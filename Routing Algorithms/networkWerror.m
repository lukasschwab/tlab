function [adjMatrix] = networkWerror(N,P)
%networkWerror - Generates an adjacency matrix for a network with a determined amount of random influence
% It could allow you to determine how many connections per node there should be, but at this time assumes two.
%
% Syntax:  [adjMatrix] = networkWerror(N,P)
%
% Inputs:
%    N - Number of nodes in the network
%    P - The probability of a random link, a decimal between 0 and 1
%
% Outputs:
%    adjMatrix - adjacency matrix for the network generated
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%

% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% July 2013; Last revision: 17-July-2013

%------------- BEGIN CODE --------------

adjMatrix = zeros(N);

% The first node gets a special case because it can not link to a node with just one lower number (it has to link to the last node)

if rand(1) > P
	adjMatrix(1,2) = 1;
else
	to = randi(N);
	adjMatrix(1,to) = adjMatrix(1,to) + 1;
end

if rand(1) > P
	adjMatrix(1,N) = 1;
else
	to = randi(N);
	adjMatrix(1,to) = adjMatrix(1,to) + 1;
end


% Then the bulk of nodes, which can be placed inside a loop...
for countera = 2:(N-1)

	if rand(1) > P
		adjMatrix(countera,countera+1) = 1;
	else
		to = randi(N);
		adjMatrix(countera,to) = adjMatrix(countera,to) + 1;
	end

	if rand(1) > P
		adjMatrix(countera,countera-1) = 1;
	else
		to = randi(N);
		adjMatrix(countera,to) = adjMatrix(countera,to) + 1;
	end
end

% Then there's another special case for the last node.

if rand(1) > P
	adjMatrix(N,1) = 1;
else
	to = randi(N);
	adjMatrix(N,to) = adjMatrix(N,to) + 1;
end

if rand(1) > P
	adjMatrix(N,(N-1)) = 1;
else
	to = randi(N);
	adjMatrix(N,to) = adjMatrix(N,to) + 1;
end


%------------- END OF CODE --------------