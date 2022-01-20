clear all;
close all;


data = csvread("AMZN.csv");



terms = 5;

% [ x0^0 x0^1 x0^2 ... x0^m ] [k0]   [y0]
% [ x1^0 x1^1 x1^2 ... x0^m ]*[k1] = [y1]
% [ x2^0 x2^1 x2^2 ... x0^m ] [k2]   [y2]
% [ xn^0 xn^1 xn^2 ... x0^m ] [km]   [yn]

K = zeros(terms, 1);

x = [1:size(data,1)]';
y = [data(:,7)];


X = zeros(size(data,1), terms);
for i = 1:size(data,1)
  for j = 1:terms
    X(i,j) = x(i)^(j);
  endfor
endfor

% least square sol
rank(X'*X)
K = inv(X'*X)*(X'*y);

y_fix = X*K;

figure()
plot(y);
hold on
plot(y_fix)
legend("raw","fix");
