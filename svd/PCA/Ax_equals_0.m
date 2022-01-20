clear all;
close all;

A = [1 3.4 2.4
1*4 3.4*4 2.4*4
1*6 3.4*5 2.4*5];

% A*x = 0;

% svd to get x
[U,S,V] = svd(A);

V(:,end)
A*(V(:,end))