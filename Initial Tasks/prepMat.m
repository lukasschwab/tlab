function [ antNo antPos rowa cola a imgPos onesNo rowo colo rowcount colcount ] = prepMat( image )
%prepMat Sets up for image immitation
%   Analyzes the image and constructs a matrix with randomly positioned
%   ants to immitate it

% Find image properties
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

end

