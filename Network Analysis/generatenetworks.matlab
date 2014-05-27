% GENERATES NETWORKS USED IN FIGURE 7 
% OF "QUANTITATIVE MEASURES OF NETWORK
% COMPLEXITY" BY DANAIL BONCHEV AND 
% GREGORY A. BUCK
% LUKAS SCHWAB, TEUSCHER.:LAB, APR.11 2014

% NETWORK 3
adjMatrix3 = zeros(5);
adjMatrix3(1,2) = 1;
adjMatrix3(2,3) = 1;
adjMatrix3(3,4) = 1;
adjMatrix3(4,5) = 1;
adjMatrix3 = adjMatrix3 + adjMatrix3';

% NETWORK 4
adjMatrix4 = zeros(5);
adjMatrix4(1,2) = 1;
adjMatrix4(2,3) = 1;
adjMatrix4(2,4) = 1;
adjMatrix4(2,5) = 1;
adjMatrix4 = adjMatrix4 + adjMatrix4';

% NETWORK 5
adjMatrix5 = zeros(5);
adjMatrix5(1,2) = 1;
adjMatrix5(2,3) = 1;
adjMatrix5(2,4) = 1;
adjMatrix5(2,5) = 1;
adjMatrix5 = adjMatrix5 + adjMatrix5';

% NETWORK 6
adjMatrix6 = zeros(5);
adjMatrix6(1,2) = 1;
adjMatrix6(2,3) = 1;
adjMatrix6(3,4) = 1;
adjMatrix6(4,5) = 1;
adjMatrix6(5,1) = 1;
adjMatrix6 = adjMatrix6 + adjMatrix6';

% NETWORK 7
adjMatrix7 = zeros(5);
adjMatrix7(1,4) = 1;
adjMatrix7(1,2) = 1;
adjMatrix7(4,3) = 1;
adjMatrix7(2,3) = 1;
adjMatrix7(3,5) = 1;
adjMatrix7 = adjMatrix7 + adjMatrix7';

% NETWORK 8
adjMatrix8 = zeros(5);
adjMatrix8(1,2) = 1;
adjMatrix8(2,3) = 1;
adjMatrix8(2,4) = 1;
adjMatrix8(3,4) = 1;
adjMatrix8(4,5) = 1;
adjMatrix8 = adjMatrix8 + adjMatrix8';

% NETWORK 9
adjMatrix9 = zeros(5);
adjMatrix9(1,2) = 1;
adjMatrix9(1,3) = 1;
adjMatrix9(2,3) = 1;
adjMatrix9(3,4) = 1;
adjMatrix9(4,5) = 1;
adjMatrix9(5,1) = 1;
adjMatrix9 = adjMatrix9 + adjMatrix9';

% NETWORK 10
adjMatrix10 = zeros(5);
adjMatrix10(2,1) = 1;
adjMatrix10(2,4) = 1;
adjMatrix10(4,1) = 1;
adjMatrix10(1,3) = 1;
adjMatrix10(4,3) = 1;
adjMatrix10(3,5) = 1;
adjMatrix10 = adjMatrix10 + adjMatrix10';

% NETWORK 11
adjMatrix11 = zeros(5);
adjMatrix11(1,2) = 1;
adjMatrix11(1,3) = 1;
adjMatrix11(1,4) = 1;
adjMatrix11(2,3) = 1;
adjMatrix11(4,3) = 1;
adjMatrix11(3,5) = 1;
adjMatrix11 = adjMatrix11 + adjMatrix11';

% NETWORK 12
adjMatrix12 = zeros(5);
adjMatrix12(1,2) = 1;
adjMatrix12(1,3) = 1;
adjMatrix12(1,4) = 1;
adjMatrix12(1,5) = 1;
adjMatrix12(2,3) = 1;
adjMatrix12(3,4) = 1;
adjMatrix12(4,5) = 1;
adjMatrix12 = adjMatrix12 + adjMatrix12';

% NETWORK 13
adjMatrix13 = zeros(5);
adjMatrix13(1,3) = 1;
adjMatrix13(1,2) = 1;
adjMatrix13(1,4) = 1;
adjMatrix13(2,3) = 1;
adjMatrix13(2,4) = 1;
adjMatrix13(3,4) = 1;
adjMatrix13(4,5) = 1;
adjMatrix13 = adjMatrix13 + adjMatrix13';

% NETWORK 14
adjMatrix14 = zeros(5);
adjMatrix14(1,2) = 1;
adjMatrix14(1,3) = 1;
adjMatrix14(1,4) = 1;
adjMatrix14(1,5) = 1;
adjMatrix14(2,3) = 1;
adjMatrix14(3,4) = 1;
adjMatrix14(4,5) = 1;
adjMatrix14(5,3) = 1;
adjMatrix14(2,4) = 1;
adjMatrix14 = adjMatrix14 + adjMatrix14';

% NETWORK 15
adjMatrix15 = zeros(5);
adjMatrix15(1,2) = 1;
adjMatrix15(1,3) = 1;
adjMatrix15(1,4) = 1;
adjMatrix15(1,5) = 1;
adjMatrix15(2,3) = 1;
adjMatrix15(3,4) = 1;
adjMatrix15(4,5) = 1;
adjMatrix15(5,3) = 1;
adjMatrix15(2,4) = 1;
adjMatrix15(5,2) = 1;
adjMatrix15 = adjMatrix15 + adjMatrix15';