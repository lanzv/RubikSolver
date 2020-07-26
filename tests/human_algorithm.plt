:- begin_tests(human_algorithm).

:- use_module("../solver.pl").


test('solve_human') :- 
	Rubik = rubik(y,y,b,g,w,w,r,r,r,o,r,b,y,g,g,b,b,b,w,w,w,o,r,y,w,o,r,g,o,r,b,b,b,y,g,g,y,g,g,w,o,r,o,r,y,o,y,g,o,y,w,o,b,w),
	Sln = [counter_clockwise_UP, clockwise_DOWN, clockwise_DOWN, clockwise_LEFT, clockwise_LEFT, counter_clockwise_RIGHT, counter_clockwise_FRONT],
	solve_human(Rubik, Sln).


:- end_tests(human_algorithm).