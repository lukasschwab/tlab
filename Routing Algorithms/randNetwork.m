function [ adjMatrix ] = randNetwork(N,K)
%randNetwork - Builds an adjacency matrix for a randomly generated network with 'N' nodes an average of 'K' links per node
% Note-- it won't/can't build a matrix that has more than one connection between a pair of nodes. Coming soon, perhaps?
% This code is going to be butchered like crazy. Why? Well, to make it so that it can't generate a node with no outputs, I'm going to put it into a loop which will only be satisfied when there are none. This will take long, and is dumb, but I am not worried about timing right now.
%There should be a way to fix this by modifying the matrix, instead of regenerating it from scratch.
%
% Syntax:  [adjMatrix] = randNetwork(N , K)
%
% Inputs:
%    N - number of nodes in the randomly generated network
%    K - average number of links per node in the randomly generated network
%
% Outputs:
%    output1 - adjacency matrix for the randomly generated network
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lukas Schwab
% Work address
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% July 2013; Last revision: 16-July-2013

%------------- BEGIN CODE --------------

i = 0;

%while i == 0;

	% Adjacency matrices have a number of rows and a number of columns equal to the number of nodes.
	adjMatrix = zeros(N);

	% Random positions for the connections.
	randPos = randperm(N*N,K*N);

	% Insert them into the matrix.
	adjMatrix(randPos) = 1;

	% Test for whether there are any output-less nodes.
    % Currently set to just add connections.
	noEmpty = sum(adjMatrix,2);
	if ismember(0,noEmpty) % ~= 1
%		i = 1;
        empty = find(noEmpty == 0);
        rp = randperm(N,numel(empty));
        for i = 1:numel(empty)
            adjMatrix(empty(i),rp(i)) = 1;
        end
	end
%end

%------------- END OF CODE --------------