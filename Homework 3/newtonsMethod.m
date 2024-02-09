function [extrema, results] = newtonsMethod(f,fd1,x0,maxIterations,tolerance)
%This function takes a function f, its derivative fd1, an initial guess x0,
% and optional parameters for max number of iterations and tolerance, 
% then uses Newton's method

% initialize the results list
results = [0 0];
% currentIn = x_n
currentIn = x0;
extrema = x0;

% if maximum number of iterations is not provided, default to 20
if ~exist('maxIterations','var')
    maxIterations = 20;
end

% if tolerance not provided, default to 10^-6
if ~exist('tolerance','var')
    tolerance = 10^-6;
end

% iteratively apply Newton's method at most maxIterations times
% the 0th application of Newton's method is index 1
for i = 1:maxIterations+1
    % add the pair (x_n, f(x_n)) to the results list
    results(i,1) = currentIn;
    results(i,2) = f(currentIn);
    % extrema stores the best guess so far
    extrema = currentIn;
    % if the newest iteration made a sufficiently small change in x_n,
    % return the current results
    if i > 1 && abs(results(i,2) - results(i-1,2)) < tolerance
        break;
    end
    % x_n+1 = x_n - f(x_n)/f'(x_n)
    currentIn = currentIn - f(currentIn)/fd1(currentIn);
end

end