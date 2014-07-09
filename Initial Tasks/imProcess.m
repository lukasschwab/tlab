function [ ans ] = imProcess( image )
%imProcess Prep for work
%   Takes an image and translates it into a usable binary format

ans = imread(image);
ans = rgb2gray(ans);
ans = dither(ans);

end

