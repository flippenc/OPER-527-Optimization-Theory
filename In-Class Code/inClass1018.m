c = [];
% x_ijk - subject i         room j      hour k
%         10 subjects       3 rooms     6 hours  
%  Variables in order x_i11 x_i12 x_i13 x_i14 x_i15 x_i16 x_i21
A = [
    % ========================== CONSTRAINT 1 ========================== %
    % ================= EVERY SUBJECT GETS TAUGHT ONCE ================= %
                        ones(1,18)      zeros(1,18*9); % subject 1
      zeros(1,18*1)     ones(1,18)      zeros(1,18*8); % subject 2
      zeros(1,18*2)     ones(1,18)      zeros(1,18*7); % subject 3
      zeros(1,18*3)     ones(1,18)      zeros(1,18*6); % subject 4
      zeros(1,18*4)     ones(1,18)      zeros(1,18*5); % subject 5
      zeros(1,18*5)     ones(1,18)      zeros(1,18*4); % subject 6
      zeros(1,18*6)     ones(1,18)      zeros(1,18*3); % subject 7
      zeros(1,18*7)     ones(1,18)      zeros(1,18*2); % subject 8
      zeros(1,18*8)     ones(1,18)      zeros(1,18*1); % subject 9
      zeros(1,18*9)     ones(1,18)                   ; % subject 10
    % ========================== CONSTRAINT 2 ========================== %
    % ================= SAMPLE TEXT ================= %

    ];

b = ones(10);