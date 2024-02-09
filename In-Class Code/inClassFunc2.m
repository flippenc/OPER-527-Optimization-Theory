function [y] = inClassFunc2(x)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
h = 10^-6;
result1 = (inClassFunc(x+h)-inClassFunc(x-h))/(2*h);
y = result1;
end