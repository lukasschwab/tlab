function [ testout ] = ballhog(  )
%ballhog will hog the bioinformatics ball
%   Uses a loop to hold onto a key toolbox
%   There are no input arguments, just enter "ballhog"

bioinf = 1;

while bioinf == 1
    adjMatrix = networkWerror(20,2);
    start = randi(20,1);
    dest = randi(20,1);
    [testout,~,~] = graphshortestpath(sparse(adjMatrix),start,dest);
end

end

