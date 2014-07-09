tlab
====

Work for [Teuscher.:Lab](http://www.teuscher-lab.com/ext/) at the PSU Masseeh College of Engineering and Computer Science.

Worked at T.:Lab from June 2013 to June 2014 on "Implementation and Evaluation of a New Routing Algorithm for Networks-on-Chip."

Code in MATLAB, requires Bioinformatics Toolbox.

## Contents

+ *visNet.m* creates a simple visualization of a mesh network of numbered nodes, printed as a counting matrix.
+ *meshNet.m* generates an adjacency matrix for a mesh network given the network dimensions and a corresponding visual network.
+ *may6.m* some simulations I ran on May 6th, 2014.
+ *ballhog.m* is probably unethical? It's a script which will use the Bioinformatics toolbox ultil stopped, which means the user running the script keeps the license. This was a key productivity tool for me.
+ *Initial Tasks:* this is code from when I was first learning MATLAB. It's pretty useless, probably not worth descriptions.
+ *Network Analysis:* these are tools I used to measure network complexity, using "QUANTITATIVE MEASURES OF NETWORK COMPLEXITY" BY DANAIL BONCHEV AND GREGORY A. BUCK as reference. Thanks to them!
    + *generatenetworks.matlab* is a script that generates the networks in the "figures" section of their paper.
    + *networkAnalysis.m* applies multiple measures of network complexity as outlined in their paper.
+ *Routing Algorithms:* the simulations I used to benchmark routing algorithms.
    + *addPackets.m* is a method of adding packets to a network structure.
    + *avgPath.m* calculates the average path length between all possible combinations of nodes in an adjacency matrix.
    + *countConnections.m* finds the average number of links (average connectivity) at each node in the network.
    + *lashMove.m* applies LASH routing to a network, returning benchmarks.
    + *networkWerror.m* generates a Watts and Strogatz model of a complex or small-world network.
    + *randMove.m* applies random routing to a network, returning benchmarks.
    + *randNetwork.m* randomly generates a network.
    + *rmCycles.m* removes the cycles from a network described by an adjacency matrix, to create a cycle-free network for the creation of virtual layers in LASH routing.
    + *shpathDirections.m* generates shortest path routing tables for a given network.
    + *shpathMove.m* applies shortest path routing to a network, returning benchmarks.