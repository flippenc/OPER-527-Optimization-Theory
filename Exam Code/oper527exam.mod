/* 	******************************************************************************
	OPER 527 Exam Problem 2.e
	Christopher Flippen,
	******************************************************************************
*/

var xP1;
var xP2;
var x12;
var x13;
var x3R;
var x2R;

maximize obj: x2R + x3R;

/* capacity contraints */
s.t. c1: xP1 <= 1.7;
s.t. c2: xP2 <= 2.55;
s.t. c3: x12 <= 2.55;
s.t. c4: x13 <= 3.4;
s.t. c5: x3R <= 0.85;
s.t. c6: x2R <= 1.7;

/* flow constraints */
s.t. c7: xP1 - x12 - x13 = 0;
s.t. c8: x2R - x12 - xP2 = 0;
s.t. c9: x13 - x3R = 0;

solve;
display x2R + x3R;
display xP1, xP2, x12, x13, x3R, x2R;
end