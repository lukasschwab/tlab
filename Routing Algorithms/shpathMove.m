function [outputq,throughput,latency] = shpathMove(adjMatrix,inqlimit,outqlimit,iterations,probability)
%shpathMove - applies shortest path movement to packets in a network
%
% Syntax:  [output1,output2] = function_name(input1,input2,input3)
%
% Inputs:
%    adjMatrix - adjacency matrix for the network in question
%    q - Queue for the network in question. See function addPackets to understand the structure of the queue.
%    inqlimit - limit for in-queue size
%    outqlimit - limit for out-queue size
%    iterations - number of desired iterations--how many moves should the packets make?
%
% Outputs:
%    outputq - queue after the number of specified iterations
%    throughput - number of packets that reach their destinations
%    latency - the latency of each transmitted packet in a vector
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% July 2013; Last revision: 26-July-2013

%------------- BEGIN CODE --------------

% Set up counter to limit the number of iterations to the number of desired iterations
iterationNo = 1;

% Set up empty latency
latency = [];

% Set throughput to zero
throughput = 0;

% If the network is static, this is where to pull up the list of directions for each node
directions = shpathDirections(adjMatrix);

% Create an empty queue
q = addPackets(adjMatrix,0);

% Loop with the iterations defined above
while iterationNo <= iterations
    % Add new packets to the queue
    q = addPackets(adjMatrix,probability,q,iterationNo);
    % FIRST MOVE NODES SITTING IN OUTPUT QUEUES
	% Run through every node's output queue in the network
	for counterOutq = 1:numel(sum(adjMatrix))
        % Set up counter to check every one of the outqueues generated for
        % a node (most of them are empty, thanks to the stupid way matlab
        % handles empty fields (if you try to define a field, 0:that field
        % all end up defined))
        [~,oqpos] = find(adjMatrix(counterOutq,:));
        oqcount = numel(oqpos);
        % If the queue is not empty.
        for counterc = 1:oqcount
            if isempty(q(counterOutq).outqueue(oqpos(counterc)).queue) == 0
                goal = (q(counterOutq).outqueue(oqpos(counterc)).queue{1}.goal);
                dest = oqpos(counterc);
                % Check if there is space in the destination queue
                if numel(q(dest).inqueue) < inqlimit
                    % Check if the packet is traveling to its end-point
                    if dest == goal
			% Note the latency
			latency(end+1) = iterationNo - q(counterOutq).outqueue(oqpos(counterc)).queue{1}.iteration1;
                        % Remove it from the network
                        q(counterOutq).outqueue(oqpos(counterc)).queue(1) = [];
                        % Success! Note it in the throughput output
                        throughput = throughput + 1;
                    else
                        % Add packet to end of new queue
                        q(dest).inqueue(end+1) = q(counterOutq).outqueue(oqpos(counterc)).queue(1);
                        % how to remove the place in the old queue
                        q(counterOutq).outqueue(oqpos(counterc)).queue(1) = [];
                    end
                end
            end
        end
    end
    % NEXT MOVE PACKETS FROM INPUT QUEUES TO OUTPUT QUEUES
    % For every node in the network
    for counterNodes = 1:numel(sum(adjMatrix))
        % If there are packets in the input queue
        if isempty(q(counterNodes).inqueue) == 0
            % Find the links out of the node, and the number of them 
            linksout = find(adjMatrix(counterNodes,:));
            linksno = numel(linksout);
            % Prep for the loop by defining 'test'
            test = 0;
            % Begin to loop for every link out (checking for each link out
            % if there's a packet to be storted in)
            for counterLinks = 1:linksno
                % If the outqueue in question (see above line)
                if numel(q(counterNodes).outqueue(counterLinks).queue) < outqlimit
                    % Loop for every packet in the inqueue
                    counterd = 1;
                    while counterd <= numel(q(counterNodes).inqueue)
                        % Test to see if the packet is going to the outqueue
                        % you're trying to add to, and if there isn't already
                        % one added to that outqueue
                        dest = directions((q(counterNodes).inqueue{counterd}.goal),counterNodes);
                        if dest == linksout(counterLinks) && test ~= 1
                            % Add the packet to the end of the appropriate end
                            % queue
                            q(counterNodes).outqueue(dest).queue(end + 1) = q(counterNodes).inqueue(counterd);
                            % Remove it from the inqueue
                            q(counterNodes).inqueue(counterd) = [];
                            % Change the value of test to make sure only one
                            % packet is added to that queue
                            test  = 1;
                        end
                        counterd = counterd + 1;
                    end
                    % Reset the value of test so that a packet can be moved to
                    % the other outqueues
                    test = 0;
                end
            end
        end
    end
	% Last line in keeping that while loop under control
	iterationNo = iterationNo + 1;
end

outputq = q;

%------------- END OF CODE --------------
