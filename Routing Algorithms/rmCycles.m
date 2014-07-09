function [adjMatrixOut] = rmCycles(adjMatrix,source,dest)
%rmCycles - Removes links from a network to generate an acyclical network.
%It uses a set of seed links (a path from one node to another) to grow the
%acyclical network off of. That set of links is defined by a shortest path
%route between the "source" and "dest" outputs. The test whether this
%path is possible should happen at a higher level.
%
% Syntax:  [adjMatrixOut] = rmCycles(adjMatrix,source,dest)
%
% Inputs:
%    adjMatrix - Adjacency matrix for the network in question
%    source - source node for the seed path
%    dest - destination node for the seed path
%
% Outputs:
%    adjMatrixOut - One adjacecny matrix for a network without cycles
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% August 2013; Last revision: 6-August-2013

%------------- BEGIN CODE --------------

% Reserve space in the output and the test networks to give them the same
% number of nodes as the input
adjMatrixOut = zeros(size(adjMatrix));
adjMatrixTest = zeros(size(adjMatrix));
% Find the shortest path (the seed for growing the cycle-free network)
[dist,path,~] = graphshortestpath(sparse(adjMatrix),source,dest);
% For every set of links in that path
for countera = 1:(numel(path)-1);
    % Pull two nodes that make up the path
    from = path(countera);
    to = path(countera+1);
    % Make that link part of the network
    adjMatrixOut(from,to) = 1;
    adjMatrixTest(from,to) = 1;
end
% Get list of edges in adjMatrix
edges = find(adjMatrix);
% Test addition of every link in the network
rp = randperm(numel(edges));
for countera = 1:numel(rp)
    adjMatrixTest(edges(rp(countera))) = 1;
    if graphisdag(sparse(adjMatrixTest))
        adjMatrixOut = adjMatrixTest;
    else
        adjMatrixTest(edges(countera)) = 0;
    end
end

%------------- END OF CODE --------------