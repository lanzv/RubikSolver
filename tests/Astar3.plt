:- begin_tests(astar3).




test('all little cubes at correct positions') :- 
	Rubik = rubik(w,w,w,w,w,w,w,w,w,g,g,g,g,g,g,g,g,g,r,r,r,r,r,r,r,r,r,b,b,b,b,b,b,b,b,b,o,o,o,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y),
	N = 0,
	h_function3(Rubik, N).

test('none of little cubes at correct positions') :- 
	Rubik = rubik(w,b,r,g,w,y,r,g,b,o,w,w,b,g,y,o,r,y,g,o,w,o,r,r,o,r,r,r,g,y,y,b,y,y,o,g,b,o,b,b,o,r,o,w,b,g,g,g,w,y,w,y,b,w),
	N = 20,
	h_function3(Rubik, N).

test('half of little cubes at correct positions') :- 
	Rubik = rubik(w,w,w,w,w,w,w,w,w,r,r,r,g,g,g,g,g,g,b,b,b,r,r,r,r,r,r,o,o,o,b,b,b,b,b,b,g,g,g,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y),
	N = 8,
	h_function3(Rubik, N).


test('solve_Astar_3 result') :- 
	Rubik = rubik(w,w,r,w,w,g,w,w,g,r,r,r,y,g,g,y,r,r,b,b,w,r,r,r,b,b,b,o,o,g,b,b,w,o,o,w,y,g,g,o,o,g,o,o,g,y,y,y,y,y,y,o,b,b),
	Sln = [counter_clockwise_UP, counter_clockwise_BACK, counter_clockwise_DOWN],
	solve_Astar_3(Rubik, Sln).


:- end_tests(astar3).
