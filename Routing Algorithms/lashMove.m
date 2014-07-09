function [outputq,throughput,latency] = lashMove(adjMatrix,injRate,inqlimit,outqlimit,iterations)
%lashMove - Applies LASH style movement to packets in a network
% The structure of queues and virtual layers works like this:
%	For INqueues: node([node number]).VL([VL]).inqueue
%	For OUTqueues: node([node number]).VL([VL]).outqueue([identifier associated with link order]).queue
%
% Syntax:  [outputq,throughput] = lashMove(adjMatrix,injRate,inqlimit,outqlimit,iterations)
%
% Inputs:
%    adjMatrix - adjacency matrix for the network in question
%    injRate - Injection rate: the chance (between 0 and 1) that a packet is generated in a given node in a given clock cycle
%    inqlimit - Limit for input queue size
%	 outqlimit - limit for output queue size
%	 iterations - the number of clock cycles that should be run through
%
% Outputs:
%    outputq - queue structures post-movement
%    throughput - number of packets that have reached their destinations
%    latency - a vector of the travel time for each completed packet trip
%
%
% Other m-files required: none
% Subfunctions: none
% MAT-files required: none

% Author: Lukas Schwab
% email: lukas.schwab@gmail.com
% Website: http://www.teuscher-lab.com
% August 2013; Last revision: 7-August-2013

%------------- BEGIN CODE --------------

[N,~] = size(adjMatrix);
networks = [];

% BUILD EMPTY QUEUE STRUCTURES
%for counterNodes = 1:N
%	node(counterNodes).inqueue = [];
%	for counterLinks = 1:sum(adjMatrix(N,:))

% Set throughput at 0 and iteration at 1... let's get this show on the road!
throughput = 0;
latency = [];
iterationNo = 1;

% THIS IS ONLY BEING TESTED
node(1:N) = zeros;
node(1:N) = [];

% LOOP FOR THE NUMBER OF DESIRED ITERATIONS
while iterationNo <= iterations
	% GENERATE PACKETS
	% Run the possibility for each node
	for source = 1:N
		random = rand(1);
		% If the node is randomly selected to have a packet generated in it
		if random <= injRate
			test = 0;
			% This while loop acts as a condition to make sure the path is feasible
			while test < 1
				% Generate properties for a packet
				packet.source = source;
				dest = randi(N,1);
				packet.dest = dest;
				packet.location = source;
                packet.iteration1 = iterationNo;
				% If it's actually doable, get out of the loop
				[dist,~,~] = graphshortestpath(sparse(adjMatrix),source,dest);
				if isinf(dist)
					test = 0;
				else
					test = 1;
				end
			end
			% If virtual layers have already been added
			if isempty(networks) == 0
				% Test each VL to see if the packet can be routed in it
				for counterVL = 1:(numel(networks))
					[dist(counterVL),~,~] = graphshortestpath(sparse(networks{counterVL}),packet.source,packet.dest);
					% If it's the shortest path yet
					if dist(counterVL) == min(dist)
						idealVL = counterVL;
                    end
                end
                % If not every distance is infinite, and there are VLs in which the packet can be routed
                [distancefortest,~,~] = graphshortestpath(sparse(networks{counterVL}),packet.source,packet.dest);
				if isinf(dist(idealVL)) == 0 && isinf(distancefortest) == 0
                        % ADD THE PACKET TO THE VL
                        % But first create necessary structures if they aren't
                        % there
                        %if isstruct(node(source)) == 0
                        %    node(source).VL = [];
                        %elseif isfield(node(source),'VL') == 0
                        %    node(source).VL = [];
                        %elseif isfield(node(source).VL(idealVL),'inqueue') == 0
                        %    node(source).VL(idealVL).inqueue = [];
                        %end
                        %node(source).VL(idealVL).inqueue(end+1).packet = packet;
                        node(source).VL(idealVL).inqueue = [];
                        node(source).VL(idealVL).inqueue(end+1).packet = packet;
				% If the packet can't be routed on any of the above networks					
                else
                    test = 0;
                    while test < 1
                        virtual = rmCycles(adjMatrix,source,dest);
                        [distancefortest,~,~] = graphshortestpath(sparse(virtual),source,dest);
                        if isinf(distancefortest) == 0
                            test = 1;
                        end
                    end
                    % Add one that will match the packet's needs
                    networks{end+1} = virtual;
                    % Generate the appropriate routing table
                    routing{end+1} = shpathDirections(networks{end});
                    % Prep the VL
                    %for nodecounter = 1:N
                    %    node(nodecounter).VL(end+1) = struct([]);
                    %end
                    %TEMP
                    for counterNodes = 1:N
                        node(counterNodes).VL(numel(networks)).inqueue = {};
                    end
                    % ADD THE PACKET TO THE VL
                    node(source).VL(numel(networks)).inqueue(end+1).packet = packet;
				end
			% If there aren't any virtual layers yet
			else
				% Add one that will match the packet's needs
				networks{1} = rmCycles(adjMatrix,source,dest);
				% Generate the appropriate routing table
				routing{1} = shpathDirections(networks{1});
				% ADD THE PACKET TO THE VL
				node(source).VL(1).inqueue(1).packet = packet;
			end
		end
	end

	% MOVE PACKETS IN THE NETWORK
    % IF and only if there are VLs
    if isempty(networks) == 0;
        % First move packets sitting in output queues
        % For every node in the network
        if iterationNo > 1
        for counterNodes = 1:N
            % Make list of outgoing links
            [~,outgoing] = find(adjMatrix(counterNodes,:));
            % for each outgoing link
            % is this enough? How are the outgoing links sorted?
            for counterLinks = 1:numel(outgoing);
                % Make sure queue lengths aren't tainted
                queueLength = 0;
                % For each virtual layer
                for counterVL = 1:numel(networks)
                    % Count the number of packets sitting in the layer outqueue in the vector queueLength
                    % if the outqueue isn't empty
                    if isempty(node(counterNodes).VL(actionVL).inqueue) == 0 && numel(node(counterNodes).VL) >= counterVL
                        if isfield(node(counterNodes).VL(counterVL),'outqueue')
                            if isempty(node(counterNodes).VL(counterVL).outqueue) == 0 && counterLinks <= numel(node(counterNodes).VL(counterVL).outqueue)
                                %now count
                                queueLength(counterVL) = numel(node(counterNodes).VL(counterVL).outqueue(counterLinks).queue);
                            else
                                queueLength(counterVL) = 0;
                            end
                        else
                            queueLength(counterVL) = 0;
                        end
                    else
                        queueLength(counterVL) = 0;
                    end
                end
                % if there's anything in the node to be bothered iwth 
                if isempty(queueLength) == 0 && max(queueLength) > 0
                    % Act on the VL that has the longest queue length
                    actionVL = find(queueLength==max(queueLength));
                    actionVL = actionVL(randi(numel(actionVL),1));
                    if iscell(node(counterNodes).VL(actionVL).outqueue(counterLinks).queue(1))
                        temppacket = node(counterNodes).VL(actionVL).outqueue(counterLinks).queue{1};
                        if iscell(temppacket(1)) == 0
                            dest = temppacket(1).packet.dest;
                        else
                            dest = temppacket{1}.packet.dest;
                        end
                    else
                        dest = node(counterNodes).VL(actionVL).outqueue(counterLinks).queue(1).packet.dest;
                    end
                    %if numel(node(counterNodes).VL(actionVL).outqueue(counterLinks).queue) > 0
                    %TEMPORARILY DISABLING QUEUE LIMITS
                    % If the destination node has space in its inqueue
                    %if length(node(outgoing(counterLinks)).VL(actionVL).inqueue) < inqlimit
                        % If it's moving to the final destination node
                        if outgoing(counterLinks) == dest
                            throughput = throughput + 1;
                            latency(end+1) = iterationNo - node(counterNodes).VL(actionVL).outqueue(counterLinks).queue{1}.packet.iteration1;
                        else
                            % Copy the packet from one node to the next, minding that it goes to the right VL
                            node(outgoing(counterLinks)).VL(actionVL).inqueue(end+1).packet = temppacket(1).packet;
                        end
                    % Remove the packet from the node it just left
                    node(counterNodes).VL(actionVL).outqueue(counterLinks).queue(1) = [];
                    %end
                end
            end
        end
        end
        % Then move packets from the input queues to the output queues
        % For every node in the network
        for counterNodes = 1:N
            % Make sure the inqueueLength variable isn't tainted
            inqueueLength = 0;
            % For every virtual layer, each of which has its own inqueue
            for counterVL = 1:(numel(networks))
                % Count the length of the inqueue in each virtual layer, store them in vector inqueueLength
                if numel(node(counterNodes).VL) >= counterVL
                    inqueueLength(counterVL) = length(node(counterNodes).VL(counterVL).inqueue);
                end
            end
            if sum(inqueueLength) > 0
            % Act on the VL that has the longest queue length
            actionVL = find(inqueueLength==max(inqueueLength));
            % I think it becomes a vector sometimes if you have two queues
            % of equal length -- this should make it only take one
            % (randomly selected)
            actionVL = actionVL(randi(numel(actionVL),1));
            % Figure out the packet's destination node
            if iscell(node(counterNodes).VL(actionVL).inqueue(1)) == 0
                destNode = node(counterNodes).VL(actionVL).inqueue(1).packet.dest;
            elseif iscell(node(counterNodes).VL(actionVL).inqueue(1)) == 1
                temppacket = node(counterNodes).VL(actionVL).inqueue{1};
                if iscell(temppacket)
                    temppacket = temppacket{1};
                end
                destNode = temppacket(1).packet.dest;
            end
            % Figure out the appropriate outgoing link
            tempest = cell2mat(routing(actionVL));
            outLink = tempest(destNode,counterNodes);
            if isfield(node(counterNodes).VL(actionVL),'outqueue') == 0
                % This next line is a bit of patchwork to make sure that
                % the necessary outqueue exists
                for countertemp = 1:N
                    node(counterNodes).VL(actionVL).outqueue(N).queue = {};
                end
            end
            % Is it a cell or not?
            if iscell(node(counterNodes).VL(actionVL).inqueue(1)) == 0
                % This first condition will be triggered if the packet was
                % generated in its destination node. Otherwise, this would be
                % handled by the definition of throughput when packets are
                % moved to the next node (not internal)
                if node(counterNodes).VL(actionVL).inqueue(1).packet.dest == counterNodes
                    throughput = throughput+1;
                    latency(end+1) = iterationNo - node(counterNodes).VL(actionVL).inqueue(1).packet.iteration1;
                    node(counterNodes).VL(actionVL).inqueue(1) = [];
                else
                    % Move the packet to the appropriate outqueue
                    if isequal(outLink,0) == 0
                        node(counterNodes).VL(actionVL).outqueue(outLink).queue{1} = node(counterNodes).VL(actionVL).inqueue(1);
                    end
                    % Remove the packet from the inqueue it just left
                    node(counterNodes).VL(actionVL).inqueue(1) = [];
                end
            % But if it is a cell...
            else
                if iscell(temppacket(1))
                    temppacket = temppacket{1};
                end
                if temppacket(1).packet.dest == counterNodes
                    throughput = throughput + 1;
                    latency(end+1) = iterationNo - temppacket{1}.packet.iteration1;
                    node(counterNodes).VL(actionVL).inqueue(1) = [];
                else
                    if (outLink == 0) == 0
                        node(counterNodes).VL(actionVL).outqueue(outLink).queue(1) = node(counterNodes).VL(actionVL).inqueue(1);
                    end
                    node(counterNodes).VL(actionVL).inqueue(1) = [];
                end
            end
            end
   % This is some broken queue limit stuff, the "if" condition needs to be a second condition to some line of code up above         
   %     elseif length(node(counterNodes).VL(actionVL).outqueue(outLinkNo).queue) < outqlimit
   %         % Move the packet to the appropriate outqueue
   %         node(counterNodes).VL(actionVL).outqueue(outLinkNo).queue(end+1) = node(counterNodes).VL(actionVL).inqueue(1);
   %         % Remove the packet from the inqueue it just left
   %     	node(counterNodes).VL(actionVL).inqueue(1) = [];
        end
    end
    % Keep the while loop under control
    iterationNo = iterationNo + 1;
end

% OUTPUT THE END STATE OF THE NETWORK AND ALL THE PACKETS IN IT
outputq = node;
%------------- END OF CODE --------------