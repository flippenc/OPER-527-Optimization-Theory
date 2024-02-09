function [y] = inClassFunc3(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
h = 10^-6;
result1 = (inClassFunc(x+h)-2*inClassFunc(x)+inClassFunc(x-h))/(h^2);
y = result1;
end