:- begin_tests(astar1).




test('all single cubes at correct positions') :- 
	Rubik = rubik(w,w,w,w,w,w,w,w,w,g,g,g,g,g,g,g,g,g,r,r,r,r,r,r,r,r,r,b,b,b,b,b,b,b,b,b,o,o,o,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y),
	H = 0,
	h_function1(Rubik, H).

test('none of single cubes at correct positions') :- 
	Rubik = rubik(y,y,y,y,w,y,y,y,y,b,b,b,b,g,b,b,b,b,o,o,o,o,r,o,o,o,o,g,g,g,g,b,g,g,g,g,r,r,r,r,o,r,r,r,r,w,w,w,w,y,w,w,w,w),
	H = 48,
	h_function1(Rubik, H).

test('half of single cubes at correct positions') :- 
	Rubik = rubik(y,y,y,y,w,w,w,w,w,g,g,g,g,g,g,g,g,g,o,o,o,o,r,o,o,o,o,b,b,b,b,b,b,b,b,b,r,r,r,r,o,r,r,r,r,y,y,y,y,y,w,w,w,w),
	H = 24,
	h_function1(Rubik, H).


test('solve_Astar_1 result') :- 
	Rubik = rubik(w,w,r,w,w,g,w,w,g,r,r,r,y,g,g,y,r,r,b,b,w,r,r,r,b,b,b,o,o,g,b,b,w,o,o,w,y,g,g,o,o,g,o,o,g,y,y,y,y,y,y,o,b,b),
	Sln = [counter_clockwise_UP, counter_clockwise_BACK, counter_clockwise_DOWN],
	solve_Astar_1(Rubik, Sln).


:- end_tests(astar1).
