function [ F ] = edgemovie( image )
%edgemovie makes a movie of replicating the edge with directed motion
%   Detailed explanation goes here
tic;
% Find image properties
image = edge(image);
[rowcount,colcount] = size(image);
[rowo,colo] = find(image);
onesNo = numel(rowo);
imgPos = [rowo,colo];

% Build the ant cage
a = zeros(rowcount,colcount);
rp = randperm((rowcount*colcount),onesNo);
a(rp) = 1;
[rowa,cola] = find(a);
antPos = [rowa,cola];
antNo = numel(rowa);

frameNo = 1;
figure('units','normalized','position',[.1 .1 .4 .4])

%loop the slight changes
while isequal(antPos,imgPos) == 0
for i = 1:antNo
    if rowa(i) < rowo(i)
            rowa(i) = rowa(i) + 1;
    elseif rowa(i) > rowo(i)
        rowa(i) = rowa(i) - 1;
        end
        if cola(i) < colo(i)
            cola(i) = cola(i) + 1;
        elseif cola(i) > colo(i)
            cola(i) = cola(i) - 1;
        end
end
antPos = sub2ind(size(a),rowa,cola);
a = zeros(rowcount,colcount);
a(antPos) = 1;
imagesc(a)
colormap(gray)
F(frameNo) = getframe;
frameNo = frameNo + 1;
antPos = [rowa,cola];
end
end

