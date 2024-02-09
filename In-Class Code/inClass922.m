% we have 45 variables
%    1    2    3    4    5    6    7    8    9    10   11   12   13   14
%    x11A x11B x11C x12A x12B x12C x13A x13B x13C x14A x14B x14C x15A x15B
%    15   16
%    x15C x21A
c = [30  30  30  10  10  10  60  60  60  70  70  70 130 130 130 ...
     100 100 100 90  90  90  60  60  60  30  30  30  40  40  40 ...
     180 180 180 120 120 120 100 100 100 60  60  60  20  20  20];
A = zeros(45+24, 45);
% set the bottom 45 rows
A(25:(24+45),:) = -eye(45); 
% the variables x11A, x12A, x13A, ... are 3 apart
% and are on indices 1,4,7,10,13

% warehouse constraints
A( 1, 1:3:15) = 1;                  % first warehouse constraint for A
A( 2, (1:3:15) + 15) = 1;           % first warehouse constraint for B
A( 3, (1:3:15) + 30) = 1;           % first warehouse constraint for C
A( 4, (1:3:15) + 1) = 1;            % second warehouse constraint for A
A( 5, (1:3:15) + 1 + 15) = 1;       % second warehouse constraint for B
A( 6, (1:3:15) + 1 + 30) = 1;       % second warehouse constraint for C
A( 7, (1:3:15) + 2) = 1;            % third warehouse constraint for A
A( 8, (1:3:15) + 2 + 15) = 1;       % third warehouse constraint for B
A( 9, (1:3:15) + 2 + 30) = 1;       % third warehouse constraint for C

% store constraints
A(10, 1:15:45) = -1;                 % first store constraint for A
A(11, (1:15:45) + 1) = -1;           % first store constraint for B
A(12, (1:15:45) + 2) = -1;           % first store constraint for C
A(13, (1:15:45) + 3) = -1;           % second store constraint for A
A(14, (1:15:45) + 4) = -1;           % second store constraint for B
A(15, (1:15:45) + 5) = -1;           % second store constraint for C
A(16, (1:15:45) + 6) = -1;           % third store constraint for A
A(17, (1:15:45) + 7) = -1;           % third store constraint for B
A(18, (1:15:45) + 8) = -1;           % third store constraint for C
A(19, (1:15:45) + 9) = -1;           % fourth store constraint for A
A(20, (1:15:45) + 10) = -1;          % fourth store constraint for B
A(21, (1:15:45) + 11) = -1;          % fourth store constraint for C
A(22, (1:15:45) + 12) = -1;          % fifth store constraint for A
A(23, (1:15:45) + 13) = -1;          % fifth store constraint for B
A(24, (1:15:45) + 14) = -1;          % fifth store constraint for C

A

% initialize to zeros saves time for the bottom 45 rows
b = zeros(45 + 24,1);

% warehouse constraints
b(1) = 7200;                        % first warehouse A capacity
b(2) = 1200;                        % first warehouse B capacity
b(3) = 800;                         % first warehouse C capacity

b(4) = 7500;                        % second warehouse A capacity
b(5) = 1500;                        % second warehouse B capacity
b(6) = 1000;                        % second warehouse C capacity

b(7) = 10000;                       % third warehouse A capacity
b(8) = 2000;                        % third warehouse B capacity
b(9) = 600;                         % third warehouse C capacity

% store constraints
b(10) = -4000;                      % store 1 product A (originally 12000)
b(11) = -1500;                      % store 1 product B
b(12) = -1000;                      % store 1 product C

b(13) = -2000;                      % store 2 product A
b(14) = -1600;                      % store 2 product B
b(15) = -100;                       % store 2 product C

b(16) = -1000;                      % store 3 product A
b(17) = -1000;                      % store 3 product B
b(18) = -200;                       % store 3 product C

b(19) = -1100;                      % store 4 product A (originally 6000)
b(20) = -400;                       % store 4 product B
b(21) = -100;                       % store 4 product C

b(22) = -1100;                      % store 5 product A (originally 3000)
b(23) = -200;                       % store 5 product B
b(24) = -1000;                      % store 5 product C

sol1 = linprog(-c,A,b);
c*sol1
