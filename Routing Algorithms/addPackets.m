function [queue] = addPackets(adjMatrix,probability,queue,iteration)
%addPackets - Generates packets with random positions and goals in the network represented by the adjacency matrix
% Syntax:  [queue,packet] = addPackets(adjMatrix,packetNo)
%
% Inputs:
%    adjMatrix - adjacency matrix for the network in question
%    packetNo - number of packets to be generated
%
% Outputs:
%    queue - structure containing the queue of every node in the network, each of which contains a value "packets" which lists all of the packets sitting in that queue and their properties.
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher.lab.com
% July 2013; Last revision: 18-July-2013

%------------- BEGIN CODE --------------

% Get number of nodes
[N,~] = size(adjMatrix);

if nargin < 3
    % Generate empty queues
    for countera = 1:N
        queue(countera).inqueue = {};
    %    linksout = sum(adjMatrix(countera,:));
        indices = find(adjMatrix(countera,:));
        for counterb = 1:numel(indices)
            queue(countera).outqueue(indices(counterb)).queue = {};
        end
    end
end
% Generate each packet and put it in the proper queue
for id = 1:round(probability*N)
	packet.start = randi(N);
	packet.goal = randi(N);
	packet.location = packet.start;
	packet.iteration1 = iteration;
	queue(packet.start).inqueue(end+1) = {packet};
end


%------------- END OF CODE --------------
