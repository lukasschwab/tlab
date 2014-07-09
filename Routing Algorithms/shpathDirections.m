function [directions] = shpathDirections(adjMatrix)
%shpathDirections - This generates instructions for each node so they know to which node a packet should be sent in the shortest path routing method.
%
% Syntax:  [directions] = shpathDirections(adjMatrix)
%
% Inputs:
%    adjMatrix - adjacency matrix for the network in question
%
% Outputs:
%    directions - a matrix that describes where to send a packet from each node depending on where the packet is headed. Sitting in the node associated with the column, going to the one associated with the row, it travels to the node associated with the field.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none
%

% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% July 2013; Last revision: 24-July-2013

%------------- BEGIN CODE --------------

% How many nodes in the network?
[N,~] = size(adjMatrix);
% That is the rowcount, colcount of the directions. Build an empty matrix.
directions = zeros(N);

% Prep adjMatrix for processing
adjMatrix = sparse(adjMatrix);

% For every node in the network
for countera = 1:N
	% find the shortest path to every other node in the matrix
	[~,path,~] = graphshortestpath(adjMatrix,countera);
	% store it in "directions". The loop is necessary because graphshortestpath outputs lists in cells.
	for counterb = 1:N
        if numel(path{counterb}) > 1
		directions(counterb,countera) = path{counterb}(2);
        end
		% When the packet is already at its destination -- this might not be an issue if the higher level code is written like that for random movement
		directions(countera,countera) = countera;
	end
end


%------------- END OF CODE --------------
