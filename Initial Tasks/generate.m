function [ a ] = generate( x )
%Image reproduction
%   Takes a matrix filled with randomly placed binary values and moves said
%   values to form the input image.

% Load image


% Find image properties

image = x;

[rowcount,colcount] = size(image);

imgPos = find(image);

onesNo = numel(imgPos);

% Build the ant cage

a = zeros(rowcount,colcount);

rp = randperm((rowcount*colcount),onesNo);

a(rp) = 1;

antPos = find(a);

antNo = numel(antPos);

%loop the slight changes

while a ~= image

    for i = 1:antNo

        if antPos(i) < imgPos(i)
            a(antPos(i)) = 0;
            a((antPos(i))+1) = 1;
        elseif antPos(i) > imgPos(i)
            a(antPos(i)) = 0;
            a((antPos(i))-1) = 1;
        end
    end
antPos = find(a);
end
end

