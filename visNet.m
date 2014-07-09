function [ visualNet ] = visNet( rows,cols )
% visNet makes a visual representation of a mesh network, with simply
% labelled nodes
%   rows: rows in the mesh
%   cols: cols in teh mesh

visualNet = zeros(rows,cols);
for counter = 1:(rows*cols)
    visualNet(counter) = counter;
end


end

