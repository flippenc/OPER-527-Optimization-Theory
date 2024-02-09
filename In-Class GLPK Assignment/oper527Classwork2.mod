/* 	******************************************************************************
	OPER 527 Classwork 12/1/22
	Christopher Flippen,
	******************************************************************************
*/
var y1 integer;
var y2 integer;
var y3 integer;
minimize obj: 48*y1+20*y2+8*y3;
s.t. c1: 8*y1 + 4*y2 + 2*y3 >= 60;
s.t. c2: 6*y1 + 2*y2 + 1.5*y3 >= 30;
s.t. c3: y1 + 1.5*y2 + 0.5*y3 >= 20;
s.t. c4: y1>=0;
s.t. c5: y2>=0;
s.t. c6: y3>=0;
solve;
display y1,y2,y3;
display 48*y1+20*y2+8*y3;
end
