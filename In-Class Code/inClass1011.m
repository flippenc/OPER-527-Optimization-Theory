c = [ 100 150 ];
b = [ 40000 200 0 0];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;];
% solution on the reals
% x_star = linprog(-c,A,b);
% x_star
% c*x_star
% branch on x2 by adding constraints
% x2 <= 5
c = [ 100 150 ];
b = [ 40000 200 0 0 5 ];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;
       0    1;];
x_star = linprog(-c,A,b);
x_star
c*x_star
% x_star = (2.5, 5), Z = 1000

% x2 >= 6
c = [ 100 150 ];
b = [ 40000 200 0 0 6 ];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;
       0   -1;];
x_star = linprog(-c,A,b);
x_star
c*x_star
% x_star = (1.333,6), Z = 1033.33

% x1 <= 1
c = [ 100 150 ];
b = [ 40000 200 0 0 1 ];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;
       1    0;];
x_star = linprog(-c,A,b);
x_star
c*x_star

% x1 >= 2
c = [ 100 150 ];
b = [ 40000 200 0 0 -2 ];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;
      -1    0;];
x_star = linprog(-c,A,b);
x_star
c*x_star

% x2 >= 6
c = [ 100 150 ];
b = [ 40000 200 0 0 -7 ];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;
       0    -1;];
x_star = linprog(-c,A,b);
x_star
% c*x_star

c = [ 100 150 ];
b = [ 40000 200 0 0 ];
A = [ 8000 4000;
      15   30;
      -1    0;
       0   -1;];
x_star = intlinprog(-c,[1 2],A,b);
x_star
