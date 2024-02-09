function [y] = h(x)
% the second half of f, used for splitting f in the product rule
result1 = 10*x - x.^2 - 25;
y = exp(result1);
end