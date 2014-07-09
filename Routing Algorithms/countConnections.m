function [avgConnections] = countConnections(adjMatrix)
%countConnections - Finds the average number of connections to/from a node.
% Network must be in the form of an adjacency matrix.
% When a node is connected to itself, that is counted as two connections.
%
% Syntax:  [avgConnections] = countConnections(adjMatrix)
%
% Inputs:
%    adjMatrix - the adjacency matrix for the network in question
%
% Outputs:
%    avgConnections - the average number of connections per node
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lukas Schwab
% Work address
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% July 2013; Last revision: 9-July-2013

%------------- BEGIN CODE --------------

% Number of connections for each individual node?
avgConnections = (sum(sum(adjMatrix,1)' + sum(adjMatrix,2)))/(2*numel(sum(adjMatrix,1)));

%------------- END OF CODE --------------
