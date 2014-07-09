function [avg] = avgPath( adjMatrix )
%avgPath - average path length between all nodes in an adjacency matrix
% Code works fine, but will always return an infinite value if there is an
% unreachable node.
%
% Syntax:  [avgPath] = avgPath(adjMatrix)
%
% Inputs:
%    adjMatrix - the adjacency matrix in question
%
% Outputs:
%    avgPath - the average path length between two nodes in the adjacency matrix
%
% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% July 2013; Last revision: 12-July-2013
%
%------------- BEGIN CODE --------------

[rowcount,~] = size(adjMatrix);
adjMatrix = sparse(adjMatrix);
dist = zeros(rowcount,rowcount);
for a = 1:rowcount
    [dist(:,a),~,~] = graphshortestpath(adjMatrix,a);
end
% Sum the average distances and divide to find the overall average distance
avg = sum(sum(dist(dist~=Inf)))/(numel(dist(dist~=Inf)));

%------------- END OF CODE --------------