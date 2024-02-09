function [y] = inClassFunc(x)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
result1 = exp(-x).*x.^4.*(1-x).^12;
result1 = result1 + log(x+1).*x.^12.*(1-x).^4;
y = result1;
end