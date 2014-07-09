counter = 0;
for IR = 1:30
    [~,throughputLASH(IR),~] = lashMove(adjMatrix,IR,100000,1000000,50);
    [~,throughputSH(IR),~] = shpathMove(adjMatrix,50,50,50,IR);
    [~,throughputRAND(IR),~] = shpathMove(adjMatrix,50,50,50,IR);
    counter = counter+1
end
csvwrite('throughputLASH.csv',throughputLASH)
csvwrite('throughputSH.csv',throughputSH)
csvwrite('throughputRAND.csv',throughputRAND)