:- begin_tests(astar2).




test('maxm function') :- 
	A1 = 1, A2 = 1, A3 = 1,
	B1 = 1, B2 = 2, B3 = 2,
	C1 = 1, C2 = 2, C3 = 3,
	D1 = 1, D2 = 3, D3 = 2,
	E1 = 3, E2 = 2, E3 = 1,
	F1 = 2, F2 = 2, F3 = 1,
	G1 = 2, G2 = 2, G3 = 3,
	H1 = 3, H2 = 2, H3 = 2,
	I1 = 2, I2 = 3, I3 = 2,
	J1 = 2, J2 = 1, J3 = 2,
	maxm(A1,A2,A3,A1),
	maxm(B1,B2,B3,B2),
	maxm(C1,C2,C3,C3),
	maxm(D1,D2,D3,D2),
	maxm(E1,E2,E3,E1),
	maxm(F1,F2,F3,F1),
	maxm(G1,G2,G3,G3),
	maxm(H1,H2,H3,H1),
	maxm(I1,I2,I3,I2),
	maxm(J1,J2,J3,J1).

test('assert number of corners') :- 
	Rubik1 = rubik(o,g,r,o,w,w,o,b,r,y,y,y,g,g,r,w,w,w,g,r,g,y,r,b,b,r,b,y,o,y,w,b,w,w,b,w,b,o,b,g,o,y,g,o,g,r,g,o,r,y,y,r,b,o),
	N1 = 4,
	Rubik2 = rubik(w,w,w,w,w,w,y,y,y,r,r,o,g,g,g,r,r,o,b,b,b,r,r,o,b,b,b,r,o,o,b,b,b,r,o,o,g,g,g,r,o,o,g,g,g,w,w,w,y,y,y,y,y,y),
	N2 = 4,
	h_corner(Rubik1,N1),
	h_corner(Rubik2,N2).

test('assert number of first half od edges') :- 
	Rubik1 = rubik(o,g,r,o,w,w,o,b,r,y,y,y,g,g,r,w,w,w,g,r,g,y,r,b,b,r,b,y,o,y,w,b,w,w,b,w,b,o,b,g,o,y,g,o,g,r,g,o,r,y,y,r,b,o),
	N1 = 6,
	Rubik2 = rubik(w,w,w,w,w,w,y,y,y,r,r,o,g,g,g,r,r,o,b,b,b,r,r,o,b,b,b,r,o,o,b,b,b,r,o,o,g,g,g,r,o,o,g,g,g,w,w,w,y,y,y,y,y,y),
	N2 = 4,
	h_e1(Rubik1,N1),
	h_e1(Rubik2,N2).


test('assert number of second half od edges') :- 
	Rubik1 = rubik(o,g,r,o,w,w,o,b,r,y,y,y,g,g,r,w,w,w,g,r,g,y,r,b,b,r,b,y,o,y,w,b,w,w,b,w,b,o,b,g,o,y,g,o,g,r,g,o,r,y,y,r,b,o),
	N1 = 6,
	Rubik2 = rubik(w,w,w,w,w,w,y,y,y,r,r,o,g,g,g,r,r,o,b,b,b,r,r,o,b,b,b,r,o,o,b,b,b,r,o,o,g,g,g,r,o,o,g,g,g,w,w,w,y,y,y,y,y,y),
	N2 = 4,
	h_e2(Rubik1,N1),
	h_e2(Rubik2,N2).




test('solve_Astar_2 result') :- 
	Rubik = rubik(w,w,r,w,w,g,w,w,g,r,r,r,y,g,g,y,r,r,b,b,w,r,r,r,b,b,b,o,o,g,b,b,w,o,o,w,y,g,g,o,o,g,o,o,g,y,y,y,y,y,y,o,b,b),
	Sln = [counter_clockwise_UP, counter_clockwise_BACK, counter_clockwise_DOWN],
	solve_Astar_2(Rubik, Sln).


:- end_tests(astar2).
