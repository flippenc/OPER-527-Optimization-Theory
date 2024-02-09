/* 	******************************************************************************
	OPER 527 Classwork 12/1/22
	Christopher Flippen,
	******************************************************************************
*/
var x1 integer;
var x2 integer;
var x3 integer;
maximize obj: 60*x1+30*x2+20*x3;
s.t. c1: 8*x1 + 6*x2 + x3 <= 48;
s.t. c2: 4*x1 + 2*x2 + 1.5*x3 <= 20;
s.t. c3: 2*x1 + 1.5*x2 + 0.5*x3 <= 8;
s.t. c4: x1>=0;
s.t. c5: x2>=0;
s.t. c6: x3>=0;
solve;
display x1,x2,x3;
display 60*x1+30*x2+20*x3;
end
