c = ones(1,13);

b = [-ones(1,13) ones(1,13) zeros(1,13)];

intflag = 1:13;

%    A B C D E F G H I J K L M
A = [1 1 0 1 0 0 1 0 0 0 0 0 0;  %xA constraints
     1 1 1 1 1 1 0 0 0 0 0 0 0;  %xB constraints
     0 1 1 0 0 1 0 0 0 0 0 0 0;  %xC constraints
     1 1 0 1 1 0 1 1 0 0 0 0 0;  %xD constraints
     0 1 0 1 1 1 0 1 1 0 0 0 0;  %xE constraints
     0 1 1 0 1 1 0 0 1 0 0 0 0;  %xF constraints
     1 0 0 1 0 0 1 1 0 1 1 1 0;  %xG constraints
     0 0 0 1 1 0 1 1 1 0 0 1 0;  %xH constraints
     0 0 0 0 1 1 0 1 1 0 0 1 1;  %xI constraints
     0 0 0 0 0 0 1 0 0 1 1 0 0;  %xJ constraints
     0 0 0 0 0 0 1 0 0 0 1 1 1;  %xK constraints
     0 0 0 0 0 0 1 1 1 0 1 1 1;  %xL constraints
     0 0 0 0 0 0 0 0 1 0 1 1 1]; %xM constraints
% A contains >=, the next 13 constraints are <=1, and the final 13 are >=0
% the 2 sets of 13 constraints are requiring the integers are >= 0 and 1 <=
A = [ -A ; eye(13); -eye(13) ];
sol = intlinprog(c, intflag, A, b);

% BKL is a solution
sol
