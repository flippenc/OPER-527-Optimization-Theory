function [y] = fd2(x)
% the second derivative of h in terms of g and h
% f'' = -sin(x)*h(x) + cos(x)*h'(x) + (10-2x)*f'(x) - 2f(x)
result1 = -sin(x).*h(x);
result2 = cos(x).*hd1(x);
result3 = (10-2*x).*fd1(x);
y = result1 + result2 + result3 - 2*f(x);
end