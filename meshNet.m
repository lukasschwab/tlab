function [ adjMatrix,visualNetwork ] = meshNet( rows,cols )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

% N = number of nodes
N = rows*cols;

visualNetwork = visNet(rows,cols);

adjMatrix = zeros(N);

for counterNodes = 1:N
    [rownode,colnode] = ind2sub(size(visualNetwork),find(visualNetwork==counterNodes));
    if isequal(rownode,1)==0
        adjMatrix(counterNodes,(counterNodes-1))=1; 
    end
    if isequal(rownode,rows)== 0
        adjMatrix(counterNodes,(counterNodes+1))=1;
    end
    if isequal(colnode,1)==0
        adjMatrix(counterNodes,(counterNodes-rows))=1;
    end
    if isequal(colnode,cols)==0
        adjMatrix(counterNodes,(counterNodes+rows))=1;
    end
end

