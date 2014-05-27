function [network,A,avgA,Conn,clstr,cmplx,sat,AD, B] = networkAnalysis(adjMatrix)
%networkAnalysis - Runs analysis to find network properties. End goal is to be able to
%	determine a quantitative degree of complexity for the network.
%Methodology for calculating each property pulled from "Quantitative Measures of
%	Network Complexity" by Danail Bonchev and Gregory A. Buck.
%Methodology for calculation further specified below, under "outputs"
%
% Syntax:  [output1,output2] = networkAnalysis(adjMatrix)
%
% Inputs:
%    adjMatrix - adjacency matrix for the network to be analyzed.
%
% Outputs:
%	
%	 network - a simplified output, just a structure with all of the other outputs as properties
%	 A - degree of adjacency for each node in the network, in vector form. Position in vector related to node number.
%			Sum of in- and out-links for a given node.
%    avgA - average degree of adjacency for each node in the network.
%			Mean of A, mean sum of in- and out-links.
%    Conn - degree of connectance in the network
%			Given by Conn = (twice number of links)/(number of nodes squared) OR Conn = (network adjacency)/(number of nodes squared)
%	 clstr - a vector giving the cluster coefficient for each node in the network
%			clstr is the ratio of the number of connections between a node's neighbors and the number of possible connections between its neighbors
%			Given by clstr = (2(E))/(a(a-1)) where E is the number of connections between a node's neighbors and a is the number of neighbors
%			Can later implement further that 1-degree cluster coefficient
%	 cmplx - network complexity, using Shannon's equation
%			Should give a rough measure of complexity -- normalized two-edge complexity may be better?
%	 sat - network saturation
%			Given by number of links in the network over total possible number of links in the network, ignoring self-links
%			sat = 1 is max
%	 AD - A/D complexity index value for the network
%	 B - B complexity index value for the network. Given like AD, but for each node individualy.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%
% See also: 

% Author: Lukas Schwab
% Work address
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% April 14; Last revision: 9-April-2014

%------------- BEGIN CODE --------------

% First, isolate some valuable values from the adjacency matrix
[N,~] = size(adjMatrix);

% Calculate A
for counternodes = 1:N
	A(counternodes) = sum(adjMatrix(counternodes,:)) %+ sum(adjMatrix(:,counternodes));
end

% Calculate avgA
avgA = mean(A);

% Calculate Conn
noLinks = sum(sum(adjMatrix));
Conn = noLinks/(N^2);

% Calculate clstr
for counternodes = 1:N
	E = 0;
	% Find all the nodes it is connected to and the connectivity
	a = sum(adjMatrix(counternodes,:));
	outlinks = find(adjMatrix(counternodes,:));
	% Find the number of connections between them
	for counterneighbors1 = 1:numel(outlinks)
		for counterneighbors2 = 1:numel(outlinks)
			if adjMatrix(outlinks(counterneighbors1),outlinks(counterneighbors2)) == 1
				E = E + 1;
			end
		end
	end
	clstr(counternodes) = 2E/(a*(a-1));
end

% Calculate cmplx -- apparently it shouldn't be a probability
cmplx = 0;
for counternodes = 1:N
	p = (sum(A == A(counternodes))/numel(A));
	cmplx = cmplx - (p)*log2(p);
end

% Calculate sat
sat = (sum(sum(adjMatrix)) - sum(diag(adjMatrix)))/(N*(N-1));

% Calculate AD
D = graphallshortestpaths(sparse(adjMatrix));
D(isinf(D)) = [];
D = sum(D);
d = D/(N*(N-1));
AD = avgA/d;

% Calculate B
D = graphallshortestpaths(sparse(adjMatrix));
B = 0;
for counternodes = 1:N
	di = D(counternodes,:);
	di(isinf(di)) = [];
	di = sum(di);
	ai = A(counternodes);
	bi = ai/di;
	B = B + bi;
end

% Define network
network.A = A;
network.avgA = avgA;
network.Conn = Conn;
network.clstr = clstr;
network.cmplx = cmplx;
network.sat = sat;
network.AD = AD;
network.B = B;

%------------- END OF CODE --------------

% NOTES
%
%	Make sure these dynamics are defined correctly for a directed network
%	Note that the funny isinf clauses are used to prevent a complexity of 0 (where the network isn't connected)
%	Problems with clstr -- returns "Unexpexted MATLAB operator." at what is now line 77:
%			clstr(counternodes) = 2E/(a*(a-1));