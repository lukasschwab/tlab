function [ F ] = randimitate( image, tol, antPerc , killPerc )
%randImitat Random motion to imitate an image
%   Detailed explanation goes here

image = edge(image);
[rowcount,colcount] = size(image);
[rowo,colo] = find(image);
onesPos = sub2ind(size(image),rowo,colo);

% Build the ant cage
antNo = round(antPerc*(numel(image)));
a = zeros(rowcount,colcount);
rp = randperm((rowcount*colcount),antNo);
a(rp) = 1;
[rowa,cola] = find(a);
antPos = sub2ind(size(image),rowa,cola);

% Set up the directions for random movement.
north = 1;
east = 2;
south = 3;
west = 4;

frameNo = 1;
figure('units','normalized','position',[.1 .1 1 1])

 while numel(find(a==image)) < round(tol*(rowcount*colcount)) & numel(antPos) > .01*numel(rowo)
%while isequal(find(a),find(image)) == 0 & numel(antPos) > 0
    %numel(find(a==image))
    %round(tol*(rowcount*colcount))
    % Determine whether the ant needs moving and, if so, move it.
    for countera = 1:antNo
        % If it’s not on top of a white pixel
        if abs(antPos(countera) == onesPos) == 0 
            % Calculate the random new position
            mv = randi(4,1,1);
            if mv == north
                rowa(countera) = rowa(countera) - 1;
            elseif mv == east
                cola(countera) = cola(countera) + 1;
            elseif mv == south
                rowa(countera) = rowa(countera) + 1;
            elseif mv == west
                cola(countera) = cola(countera) -1;
            end
            % But what if it went around the edge?
            if rowa(countera) < 1
                rowa(countera) = rowcount;
            elseif rowa(countera) > rowcount
                rowa(countera) = 1;
            elseif cola(countera) < 1
                cola(countera) = colcount;
            elseif cola(countera) > colcount
                cola(countera) = 1;
            end
        end
    end
    a(antPos) = 0;
    antPos = sub2ind(size(image),rowa,cola);
    a(antPos) = 1;
    antNo = numel(antPos);
    colormap(gray);
    imagesc(a)
    F(frameNo) = getframe;
    frameNo = frameNo + 1;
    intersection = intersect(antPos,onesPos);
    %for counter1 = numel(antPos);
    	for counter2 = 1:numel(intersection)
        	%if antPos(counter1) == intersection(counter2)
        	%    antPos(counter1) = [];
        	%end
            antPos(antPos == intersection(counter2)) = [];
        end
    %end
    antNo = numel(antPos);
    % KILL EM
    kill = randperm(antNo,(round(killPerc*antNo)));
    a(antPos(kill)) = 0;
    antPos(kill) = [];
    antNo = numel(antPos);
    [rowa,cola] = ind2sub((size(a)),antPos);
    intersection = intersect(antPos,onesPos);
    %if numel(antPos) == 0, break, end;
end


end