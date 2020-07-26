:- begin_tests(human_moves).





test('human_move_stage1') :-
	R1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,R1,R2),move(counter_clockwise_RIGHT,R2,R3),move(clockwise_LEFT,R3,R4),move(counter_clockwise_BACK,R4,R5),move(clockwise_RIGHT,R5,R6),move(counter_clockwise_LEFT,R6,R7),
	SLN1 = [clockwise_DOWN,counter_clockwise_RIGHT,clockwise_LEFT,counter_clockwise_BACK,clockwise_RIGHT,counter_clockwise_LEFT],
	human_move_stage1(SLN1,R1,R7),

	Q1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,Q1,Q2),move(clockwise_RIGHT,Q2,Q3),move(counter_clockwise_LEFT,Q3,Q4),move(clockwise_FRONT,Q4,Q5),move(counter_clockwise_RIGHT,Q5,Q6),move(clockwise_LEFT,Q6,Q7),
	SLN2 = [clockwise_DOWN,clockwise_RIGHT,counter_clockwise_LEFT,clockwise_FRONT,counter_clockwise_RIGHT,clockwise_LEFT],
	human_move_stage1(SLN2,Q1,Q7),
	
	P1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,P1,P2),move(clockwise_FRONT,P2,P3),move(clockwise_BACK,P3,P4),move(clockwise_LEFT,P4,P5),move(counter_clockwise_FRONT,P5,P6),move(counter_clockwise_BACK,P6,P7),
	SLN3 = [clockwise_DOWN,clockwise_FRONT,clockwise_BACK,clockwise_LEFT,counter_clockwise_FRONT,counter_clockwise_BACK],
	human_move_stage1(SLN3,P1,P7),

	O1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,O1,O2),move(counter_clockwise_FRONT,O2,O3),move(counter_clockwise_BACK,O3,O4),move(clockwise_RIGHT,O4,O5),move(clockwise_FRONT,O5,O6),move(clockwise_BACK,O6,O7),
	SLN4 = [clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_BACK,clockwise_RIGHT,clockwise_FRONT,clockwise_BACK],
	human_move_stage1(SLN4,O1,O7),

	M1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,M1,M2),
	human_move_stage1(clockwise_DOWN,M1,M2),!.






test('human_move_stage2') :- 
	R1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,R1,R2),move(clockwise_RIGHT,R2,R3),move(clockwise_DOWN,R3,R4),move(counter_clockwise_RIGHT,R4,R5),
	SLN1 = [counter_clockwise_DOWN,clockwise_RIGHT,clockwise_DOWN,counter_clockwise_RIGHT],
	human_move_stage2(SLN1,R1,R5),

	Q1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,Q1,Q2),move(counter_clockwise_LEFT,Q2,Q3),move(counter_clockwise_DOWN,Q3,Q4),move(clockwise_LEFT,Q4,Q5),
	SLN2 = [clockwise_DOWN,counter_clockwise_LEFT,counter_clockwise_DOWN,clockwise_LEFT],
	human_move_stage2(SLN2,Q1,Q5),
	
	P1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,P1,P2),move(counter_clockwise_RIGHT,P2,P3),move(counter_clockwise_DOWN,P3,P4),move(clockwise_RIGHT,P4,P5),
	SLN3 = [clockwise_DOWN,counter_clockwise_RIGHT,counter_clockwise_DOWN,clockwise_RIGHT],
	human_move_stage2(SLN3,P1,P5),

	O1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,O1,O2),move(clockwise_LEFT,O2,O3),move(clockwise_DOWN,O3,O4),move(counter_clockwise_LEFT,O4,O5),
	SLN4 = [counter_clockwise_DOWN,clockwise_LEFT,clockwise_DOWN,counter_clockwise_LEFT],
	human_move_stage2(SLN4,O1,O5),

	N1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,N1,N2),move(clockwise_FRONT,N2,N3),move(clockwise_DOWN,N3,N4),move(counter_clockwise_FRONT,N4,N5),
	SLN5 = [counter_clockwise_DOWN,clockwise_FRONT,clockwise_DOWN,counter_clockwise_FRONT],
	human_move_stage2(SLN5,N1,N5),

	S1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,S1,S2),move(counter_clockwise_BACK,S2,S3),move(clockwise_DOWN,S3,S4),move(clockwise_BACK,S4,S5),
	SLN6 = [counter_clockwise_DOWN,counter_clockwise_BACK,clockwise_DOWN,clockwise_BACK],
	human_move_stage2(SLN6,S1,S5),
	
	T1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,T1,T2),move(clockwise_BACK,T2,T3),move(counter_clockwise_DOWN,T3,T4),move(counter_clockwise_BACK,T4,T5),
	SLN7 = [clockwise_DOWN,clockwise_BACK,counter_clockwise_DOWN,counter_clockwise_BACK],
	human_move_stage2(SLN7,T1,T5),

	U1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,U1,U2),move(counter_clockwise_FRONT,U2,U3),move(counter_clockwise_DOWN,U3,U4),move(clockwise_FRONT,U4,U5),
	SLN8 = [clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_DOWN,clockwise_FRONT],
	human_move_stage2(SLN8,U1,U5),


	M1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,M1,M2),
	human_move_stage2(clockwise_DOWN,M1,M2),!.



test('human_move_stage3') :- 
	R1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,R1,R2),move(clockwise_BACK,R2,R3),move(counter_clockwise_DOWN,R3,R4),move(counter_clockwise_BACK,R4,R5),move(counter_clockwise_DOWN,R5,R6),move(clockwise_RIGHT,R6,R7),move(clockwise_DOWN,R7,R8),move(counter_clockwise_RIGHT,R8,R9),
	SLN1 = [clockwise_DOWN,clockwise_BACK,counter_clockwise_DOWN,counter_clockwise_BACK,   counter_clockwise_DOWN,clockwise_RIGHT,clockwise_DOWN,counter_clockwise_RIGHT],
	human_move_stage3(SLN1,R1,R9),

	Q1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,Q1,Q2),move(counter_clockwise_BACK,Q2,Q3),move(clockwise_DOWN,Q3,Q4),move(clockwise_BACK,Q4,Q5),move(clockwise_DOWN,Q5,Q6),move(counter_clockwise_LEFT,Q6,Q7),move(counter_clockwise_DOWN,Q7,Q8),move(clockwise_LEFT,Q8,Q9),
	SLN2 = [counter_clockwise_DOWN,counter_clockwise_BACK,clockwise_DOWN,clockwise_BACK,   clockwise_DOWN,counter_clockwise_LEFT,counter_clockwise_DOWN,clockwise_LEFT],
	human_move_stage3(SLN2,Q1,Q9),
	
	P1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,P1,P2),move(clockwise_FRONT,P2,P3),move(clockwise_DOWN,P3,P4),move(counter_clockwise_FRONT,P4,P5),move(clockwise_DOWN,P5,P6),move(counter_clockwise_RIGHT,P6,P7),move(counter_clockwise_DOWN,P7,P8),move(clockwise_RIGHT,P8,P9),
	SLN3 = [counter_clockwise_DOWN,clockwise_FRONT,clockwise_DOWN,counter_clockwise_FRONT,   clockwise_DOWN,counter_clockwise_RIGHT,counter_clockwise_DOWN,clockwise_RIGHT],
	human_move_stage3(SLN3,P1,P9),

	O1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,O1,O2),move(counter_clockwise_FRONT,O2,O3),move(counter_clockwise_DOWN,O3,O4),move(clockwise_FRONT,O4,O5),move(counter_clockwise_DOWN,O5,O6),move(clockwise_LEFT,O6,O7),move(clockwise_DOWN,O7,O8),move(counter_clockwise_LEFT,O8,O9),
	SLN4 = [clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_DOWN,clockwise_FRONT,   counter_clockwise_DOWN,clockwise_LEFT,clockwise_DOWN,counter_clockwise_LEFT],
	human_move_stage3(SLN4,O1,O9),

	N1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,N1,N2),move(counter_clockwise_RIGHT,N2,N3),move(counter_clockwise_DOWN,N3,N4),move(clockwise_RIGHT,N4,N5),move(counter_clockwise_DOWN,N5,N6),move(clockwise_FRONT,N6,N7),move(clockwise_DOWN,N7,N8),move(counter_clockwise_FRONT,N8,N9),
	SLN5 = [clockwise_DOWN,counter_clockwise_RIGHT,counter_clockwise_DOWN,clockwise_RIGHT,    counter_clockwise_DOWN,clockwise_FRONT,clockwise_DOWN,counter_clockwise_FRONT],
	human_move_stage3(SLN5,N1,N9),

	S1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,S1,S2),move(counter_clockwise_LEFT,S2,S3),move(counter_clockwise_DOWN,S3,S4),move(clockwise_LEFT,S4,S5),move(counter_clockwise_DOWN,S5,S6),move(counter_clockwise_BACK,S6,S7),move(clockwise_DOWN,S7,S8),move(clockwise_BACK,S8,S9),
	SLN6 = [clockwise_DOWN,counter_clockwise_LEFT,counter_clockwise_DOWN,clockwise_LEFT,    counter_clockwise_DOWN,counter_clockwise_BACK,clockwise_DOWN,clockwise_BACK],
	human_move_stage3(SLN6,S1,S9),
	
	T1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,T1,T2),move(clockwise_RIGHT,T2,T3),move(clockwise_DOWN,T3,T4),move(counter_clockwise_RIGHT,T4,T5),move(clockwise_DOWN,T5,T6),move(clockwise_BACK,T6,T7),move(counter_clockwise_DOWN,T7,T8),move(counter_clockwise_BACK,T8,T9),
	SLN7 = [counter_clockwise_DOWN,clockwise_RIGHT,clockwise_DOWN,counter_clockwise_RIGHT,    clockwise_DOWN,clockwise_BACK,counter_clockwise_DOWN,counter_clockwise_BACK],
	human_move_stage3(SLN7,T1,T9),

	U1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(counter_clockwise_DOWN,U1,U2),move(clockwise_LEFT,U2,U3),move(clockwise_DOWN,U3,U4),move(counter_clockwise_LEFT,U4,U5),move(clockwise_DOWN,U5,U6),move(counter_clockwise_FRONT,U6,U7),move(counter_clockwise_DOWN,U7,U8),move(clockwise_FRONT,U8,U9),
	SLN8 = [counter_clockwise_DOWN,clockwise_LEFT,clockwise_DOWN,counter_clockwise_LEFT,    clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_DOWN,clockwise_FRONT],
	human_move_stage3(SLN8,U1,U9),


	M1 = rubik(y1,g2,g3,y6,w5,w2,b1,r4,b7,g9,b8,w9,r8,g5,r2,y9,b2,y7,r3,g6,r9,w8,r5,y8,o9,b6,b3,y3,o2,r1,o8,b5,o6,w3,g8,g1,w7,w4,r7,g4,o5,y2,o3,b4,o7,g7,o4,o1,w6,y5,y4,b9,r6,w1),
	move(clockwise_DOWN,M1,M2),
	human_move_stage3(clockwise_DOWN,M1,M2),!.





:- end_tests(human_moves).
