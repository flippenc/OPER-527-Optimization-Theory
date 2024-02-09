function [y] = fd1(x)
% the first derivative of f in terms of g, g', h, and h'
result1 = gd1(x).*h(x);
result2 = g(x).*hd1(x);
y = result1 + result2;
end