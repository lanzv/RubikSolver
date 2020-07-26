:- begin_tests(moves).




test('clockwise_UP') :-
	move(clockwise_UP, Before1, After1),
	move(clockwise_UP, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(w7,w6,y3,g6,w5,y6,b3,w4,y9,r1,r4,o1,w8,g5,b6,w9,o8,o9,w3,g2,o7,o4,r5,o2,g7,r6,o3,b9,b8,b7,w2,b5,y4,w1,r8,y1,r9,b2,g3,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1).

test('counter_clockwise_UP') :-
	move(counter_clockwise_UP, Before1, After1),
	move(counter_clockwise_UP, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y9,w4,b3,y6,w5,g6,y3,w6,w7,b9,b8,b7,w8,g5,b6,w9,o8,o9,r9,b2,g3,o4,r5,o2,g7,r6,o3,r1,r4,o1,w2,b5,y4,w1,r8,y1,w3,g2,o7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(b7,r4,b1,w2,w5,y6,g3,g2,y1,y3,o2,r1,r8,g5,r2,y9,b2,y7,w7,w4,r7,w8,r5,y8,o9,b6,b3,g9,b8,w9,o8,b5,o6,w3,g8,g1,r3,g6,r9,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1).




test('clockwise_DOWN') :-
	move(clockwise_DOWN, Before1, After1),
	move(clockwise_DOWN, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,g7,r6,o3,r1,r4,o1,o4,r5,o2,w1,r8,y1,w3,g2,o7,w2,b5,y4,g9,o6,r3,b9,b8,b7,g8,o5,r2,w9,o8,o9,g1,y2,r7,b4,y5,g4,y7,y8,b1),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,o9,b6,b3,g9,b8,w9,w8,r5,y8,w3,g8,g1,r3,g6,r9,o8,b5,o6,o3,b4,o7,y3,o2,r1,g4,o5,y2,y9,b2,y7,o1,y4,w1,o4,y5,r6,g7,w6,b9).

test('counter_clockwise_DOWN') :-
	move(counter_clockwise_DOWN, Before1, After1),
	move(counter_clockwise_DOWN, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,g9,o6,r3,r1,r4,o1,o4,r5,o2,w9,o8,o9,w3,g2,o7,w2,b5,y4,g7,r6,o3,b9,b8,b7,g8,o5,r2,w1,r8,y1,b1,y8,y7,g4,y5,b4,r7,y2,g1),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,o3,b4,o7,g9,b8,w9,w8,r5,y8,y9,b2,y7,r3,g6,r9,o8,b5,o6,o9,b6,b3,y3,o2,r1,g4,o5,y2,w3,g8,g1,b9,w6,g7,r6,y5,o4,w1,y4,o1).





test('clockwise_LEFT') :-
	move(clockwise_LEFT, Before1, After1),
	move(clockwise_LEFT, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(r3,y6,y9,r2,w5,w4,b7,g6,b3,w9,w8,r9,o8,g5,b2,o9,b6,g3,y3,r4,o1,w6,r5,o2,w7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b1,g8,o5,y8,g9,o6,y7,r1,b4,g1,o4,y5,y2,g7,g4,r7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(o7,w2,b7,y2,w5,r4,r1,y6,b1,y9,r8,w7,b2,g5,w4,y7,r2,r7,g3,b8,w9,g2,r5,y8,y1,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,b9,g4,o5,w6,o3,b4,g7,g9,o4,o1,w8,y5,y4,o9,r6,w1).

test('counter_clockwise_LEFT') :-
	move(counter_clockwise_LEFT, Before1, After1),
	move(counter_clockwise_LEFT, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(r1,y6,y9,o4,w5,w4,g7,g6,b3,g3,b6,o9,b2,g5,o8,r9,w8,w9,y7,r4,o1,y8,r5,o2,b1,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,w7,g8,o5,w6,g9,o6,y3,r3,b4,g1,r2,y5,y2,b7,g4,r7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g9,w2,b7,w8,w5,r4,o9,y6,b1,r7,r2,y7,w4,g5,b2,w7,r8,y9,g7,b8,w9,w6,r5,y8,b9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,y1,g4,o5,g2,o3,b4,g3,o7,o4,o1,y2,y5,y4,r1,r6,w1).





test('clockwise_RIGHT') :-
	move(clockwise_RIGHT, Before1, After1),
	move(clockwise_RIGHT, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y3,y6,o1,w6,w5,o2,w7,g6,o3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,g1,o4,r5,y2,g7,r6,r7,w1,w2,w3,r8,b5,g2,y1,y4,o7,b3,b8,b7,w4,o5,r2,y9,o6,r3,y7,b4,g9,y8,y5,g8,b1,g4,b9),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g3,w2,w9,g2,w5,y8,y1,y6,b3,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,o1,w8,r5,y4,o9,b6,w1,w3,o8,r3,g8,b5,g6,g1,o6,r9,b1,o2,r1,r4,o5,y2,b7,b4,o7,g7,o4,o3,w6,y5,g4,b9,r6,y3).

test('counter_clockwise_RIGHT') :-
	move(counter_clockwise_RIGHT, Before1, After1),
	move(counter_clockwise_RIGHT, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y3,y6,g9,w6,w5,g8,w7,g6,b9,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,y9,o4,r5,w4,g7,r6,b3,o7,y4,y1,g2,b5,r8,w3,w2,w1,r7,b8,b7,y2,o5,r2,g1,o6,r3,y7,b4,o1,y8,y5,o2,b1,g4,o3),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g3,w2,o3,g2,w5,g4,y1,y6,y3,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,b7,w8,r5,r4,o9,b6,b1,r9,o6,g1,g6,b5,g8,r3,o8,w3,w1,o2,r1,y4,o5,y2,o1,b4,o7,g7,o4,w9,w6,y5,y8,b9,r6,b3).




test('clockwise_FRONT') :-
	move(clockwise_FRONT, Before1, After1),
	move(clockwise_FRONT, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y3,y6,y9,w6,w5,w4,o9,b6,g3,r9,b2,y7,w8,g5,b4,w9,o8,g1,g7,o4,r1,r6,r5,r4,o3,o2,o1,w7,g2,o7,g6,b5,y4,b3,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,w1,w2,w3,y8,y5,y2,b1,g4,r7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g3,w2,b7,g2,w5,r4,y7,r2,r7,w7,w4,g7,r8,g5,o4,y9,b2,o1,o9,w8,g9,b6,r5,b8,b3,y8,w9,y1,g6,r9,y6,b5,o6,b1,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,w3,o8,r3,w6,y5,y4,b9,r6,w1).

test('counter_clockwise_FRONT') :-
	move(counter_clockwise_FRONT, Before1, After1),
	move(counter_clockwise_FRONT, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(y3,y6,y9,w6,w5,w4,w3,w2,w1,r9,b2,b3,w8,g5,g6,w9,o8,w7,o1,o2,o3,r4,r5,r6,r1,o4,g7,g1,g2,o7,b4,b5,y4,y7,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,g3,b6,o9,y8,y5,y2,b1,g4,r7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(g3,w2,b7,g2,w5,r4,r3,o8,w3,w7,w4,b1,r8,g5,y6,y9,b2,y1,w9,y8,b3,b8,r5,b6,g9,w8,o9,o1,g6,r9,o4,b5,o6,g7,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,r7,r2,y7,w6,y5,y4,b9,r6,w1).






test('clockwise_BACK') :-
	move(clockwise_BACK, Before1, After1),
	move(clockwise_BACK, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(w9,w8,r9,w6,w5,w4,w7,g6,b3,b1,b2,g3,g4,g5,b6,r7,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,y3,w2,b5,y6,w1,r8,y9,b7,r2,r3,b8,o5,o6,b9,g8,g9,y7,b4,g1,y8,y5,y2,y1,y4,o7),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(y9,r8,w7,g2,w5,r4,y1,y6,b1,b9,w4,r7,r6,g5,r2,w1,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,g3,o8,b5,w2,w3,g8,b7,r1,y2,o7,o2,o5,b4,y3,g4,o3,g7,o4,o1,w6,y5,y4,g1,o6,r9).

test('counter_clockwise_BACK') :-
	move(counter_clockwise_BACK, Before1, After1),
	move(counter_clockwise_BACK, Before2, After2),
    	Before1=rubik(y3,y6,y9,w6,w5,w4,w7,g6,b3,r9,b2,g3,w8,g5,b6,w9,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,o7,w2,b5,y4,w1,r8,y1,b9,b8,b7,g8,o5,r2,g9,o6,r3,y7,b4,g1,y8,y5,y2,b1,g4,r7),
	After1=rubik(o7,y4,y1,w6,w5,w4,w7,g6,b3,y9,b2,g3,y6,g5,b6,y3,o8,o9,r1,r4,o1,o4,r5,o2,g7,r6,o3,w3,g2,r7,w2,b5,g4,w1,r8,b1,g9,g8,b9,o6,o5,b8,r3,r2,b7,y7,b4,g1,y8,y5,y2,r9,w8,w9),
	Before2=rubik(g3,w2,b7,g2,w5,r4,y1,y6,b1,w7,w4,r7,r8,g5,r2,y9,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,r9,o8,b5,o6,w3,g8,g1,y3,o2,r1,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	After2=rubik(r9,o6,g1,g2,w5,r4,y1,y6,b1,b7,w4,r7,w2,g5,r2,g3,b2,y7,g9,b8,w9,w8,r5,y8,o9,b6,b3,r3,g6,w1,o8,b5,r6,w3,g8,b9,o3,g4,y3,b4,o5,o2,o7,y2,r1,g7,o4,o1,w6,y5,y4,w7,r8,y9).



:- end_tests(moves).
