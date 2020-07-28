
# Rubik's Cube Solver in Prolog

The aim of this project is to show steps solving a Rubik's cube. The idea of our algorithms is based on the fact that each state of the cube can be solved in less than 21 moves (more info [here](https://cube20.org/)). The project contains one very simple algorithm based on BFS, three algorithms based on A* and one algorithm that tries to simulate a ''[human algorithm](https://ruwix.com/the-rubiks-cube/how-to-solve-the-rubiks-cube-beginners-method/)''. That last approach could be improved by adding a few conditions and more "human movements" to make the result much faster. But so far we are not trying to get the result as fast as possible, where the code would be much more complicated.



## Structure of Cube

![Structure](https://github.com/lanzv/RubikSolver/blob/master/docs/images/structure.png)

    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,
    G1,G2,G3,G4,G5,G6,G7,G8,G9,
    R1,R2,R3,R4,R5,R6,R7,R8,R9,
    B1,B2,B3,B4,B5,B6,B7,B8,B9,
    O1,O2,O3,O4,O5,O6,O7,O8,O9,
    Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9).








## Moves 

### clockwise_UP
![clockwise_UP](https://github.com/lanzv/RubikSolver/blob/master/docs/images/clockwise_UP.png)
   
### clockwise_DOWN
![clockwise_DOWN](https://github.com/lanzv/RubikSolver/blob/master/docs/images/clockwise_DOWN.png)

### clockwise_LEFT
![clockwise_LEFT](https://github.com/lanzv/RubikSolver/blob/master/docs/images/clockwise_LEFT.png)

### clockwise_RIGHT
![clockwise_RIGHT](https://github.com/lanzv/RubikSolver/blob/master/docs/images/clockwise_RIGHT.png)

### clockwise_FRONT
![clockwise_FRONT](https://github.com/lanzv/RubikSolver/blob/master/docs/images/clockwise_FRONT.png)

### clockwise_BACK
![clockwise_BACK](https://github.com/lanzv/RubikSolver/blob/master/docs/images/clockwise_BACK.png)

### !!! counter_clockwise_MOVE !!!
where **MOVE** is one of {**UP**,**DOWN**,**LEFT**,**RIGHT**,**FRONT**,**BACK**}. It's just an inverse move for the **clockwise_MOVE**.





## Commands

#### default solving command

  - `solve(+Rubik'sCube, -Steps).`

#### more solving commands

  - `solve_basic(+Rubik'sCube,-Steps).`
  - `solve_Astar_1(+Rubik'sCube,-Steps).`
  - `solve_Astar_2(+Rubik'sCube,-Steps).`
  - `solve_Astar_3(+Rubik'sCube,-Steps).`
  - `solve_human(+Rubik'sCube,-Steps).`

#### genereting cube commands
    R=rubik(w,w,w,w,w,w,w,w,w,g,g,g,g,g,g,g,g,g,r,r,r,r,r,r,r,r,r,b,b,b,b,b,b,b,b,b,o,o,o,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y),move(Move1,R,R1),move(Move2,R1,R2),...,move(Move(N),R(N-1),R(N)).





## How to use it
#### solve cube:

    solve(rubik(w,w,w,w,w,w,y,y,y,r,r,o,g,g,b,r,r,o,b,b,b,r,r,r,b,b,b,r,o,o,g,b,b,r,o,o,g,g,g,o,o,o,g,g,g,w,w,w,y,y,y,y,y,y), Steps).
#### generate cube:
		
    R=rubik(w,w,w,w,w,w,w,w,w,g,g,g,g,g,g,g,g,g,r,r,r,r,r,r,r,r,r,b,b,b,b,b,b,b,b,b,o,o,o,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y),
    move(clockwise_FRONT,R,R1),
    move(clockwise_FRONT,R1,R2),
    move(clockwise_UP,R2,R3),
    move(clockwise_BACK,R3,R4),
    move(clockwise_DOWN,R4,R5),
    move(clockwise_LEFT,R5,R6),
    move(clockwise_UP,R6,R7),
    move(clockwise_BACK,R7,R8),
    move(clockwise_BACK,R8,R9).
    

   
#### Examples of Rubik's Cubes
|  |  |
|--|--|
|R=|rubik(w,w,w,w,w,w,w,w,w,g,g,g,g,g,g,g,g,g,r,r,r,r,r,r,r,r,r,b,b,b,b,b,b,b,b,b,o,o,o,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y)|
|R1=|rubik(w,w,w,w,w,w,w,w,w,r,r,r,g,g,g,g,g,g,b,b,b,r,r,r,r,r,r,o,o,o,b,b,b,b,b,b,g,g,g,o,o,o,o,o,o,y,y,y,y,y,y,y,y,y)|
|R2=|rubik(w,w,w,w,w,w,w,w,w,r,r,r,g,g,g,r,r,r,b,b,b,r,r,r,b,b,b,o,o,o,b,b,b,o,o,o,g,g,g,o,o,o,g,g,g,y,y,y,y,y,y,y,y,y)|
|R3=|rubik(w,w,w,w,w,w,r,g,r,r,r,y,g,g,y,r,r,y,b,r,b,b,r,b,b,r,b,w,o,o,w,b,b,w,o,o,g,g,g,o,o,o,g,g,g,o,b,o,y,y,y,y,y,y)|
|R4=|rubik(w,w,w,w,w,w,y,y,y,r,r,o,g,g,b,r,r,o,b,b,b,r,r,r,b,b,b,r,o,o,g,b,b,r,o,o,g,g,g,o,o,o,g,g,g,w,w,w,y,y,y,y,y,y)|
|R5=|rubik(w,w,w,w,w,w,y,y,y,r,r,o,g,g,b,b,b,b,b,b,b,r,r,r,r,o,o,r,o,o,g,b,b,g,g,g,g,g,g,o,o,o,r,r,o,w,y,y,w,y,y,w,y,y)|
|R6=|rubik(o,w,w,o,w,w,g,y,y,b,g,r,b,g,r,b,b,o,w,b,b,w,r,r,y,o,o,r,o,o,g,b,b,g,g,g,g,g,w,o,o,w,r,r,w,b,y,y,r,y,y,r,y,y)|
|R7=|rubik(b,b,b,o,w,w,g,y,y,r,g,r,y,g,r,y,b,o,w,b,b,w,r,r,y,o,o,r,o,o,g,b,w,g,g,w,w,w,w,g,o,r,g,o,r,b,y,y,r,y,y,g,b,o)|
|R8=|rubik(y,y,r,o,w,w,g,y,y,g,g,r,b,g,r,o,b,o,w,b,b,w,r,r,y,o,o,r,o,b,g,b,b,g,g,b,w,r,r,w,o,o,w,g,g,b,y,y,r,y,y,w,w,o)|
|R9=|rubik(o,b,g,o,w,w,g,y,y,w,g,r,w,g,r,o,b,o,w,b,b,w,r,r,y,o,o,r,o,y,g,b,y,g,g,r,r,o,g,r,o,g,w,w,w,b,y,y,r,y,y,b,b,b)|
|R10=|rubik(w,b,g,g,w,w,g,y,y,o,w,w,b,g,g,o,r,r,o,b,b,o,r,r,g,o,o,r,o,y,g,b,y,g,g,r,r,o,b,r,o,r,w,w,b,w,y,y,w,y,y,y,b,b)|
|R11=|rubik(w,b,g,g,w,w,r,g,w,o,w,w,b,g,y,o,r,y,g,o,o,o,r,b,o,r,b,g,o,y,y,b,y,y,g,r,r,o,b,r,o,r,w,w,b,g,g,r,w,y,y,y,b,b)|
|R12=|rubik(w,b,o,g,w,b,r,g,b,o,w,w,b,g,y,o,r,y,g,o,r,o,r,y,o,r,b,y,y,g,g,b,o,r,y,y,w,o,b,w,o,r,g,w,b,g,g,w,w,y,r,y,b,r)|
|R13=|rubik(w,b,r,g,w,y,r,g,b,o,w,w,b,g,y,o,r,y,g,o,w,o,r,r,o,r,r,r,g,y,y,b,y,y,o,g,b,o,b,b,o,r,o,w,b,g,g,g,w,y,w,y,b,w)|
|R14=|rubik(o,b,o,g,w,y,r,g,b,y,w,w,b,g,y,w,r,y,g,o,w,o,r,r,o,r,r,r,g,w,y,b,b,y,o,r,b,r,b,o,o,w,b,b,o,g,g,g,w,y,w,g,y,y)|



## Comparison of different approaches

This project has five different approaches to solve Rubik's Cube:
 
  1) ***BFS***
  2) ***A**** ***1***
  3) ***A**** ***2***
  4) ***A**** ***3***
  5) ***"Human algorithm"***

#### BFS based algorithm 
The simplest algorithm. The algorithm uses BFS to find solved situation using all possible moves. It turns out that this approach is the most effective one. 

#### A* based algorithm #1
Algorithm uses A* searching to find solved situation of cube. The metric for this A* based searcher is a number of wrongly placed colors in our cube. So this is the function h. The another function of A* is the number of already made steps.

#### A* based algorithm #2
Algorithm uses A* searching to find solved situation of cube. The metric for this A* based searcher is a number of moves to complete corners or edges. So this is the function h. The another function of A* is the number of already made steps. The only problem for function h is that we don't know the number of moves to complete the cube until we find the path, so we can use the BFS algorithm for that. We can think about this approach as a recursive algorithm, or as a combination of A* and BFS. This one is the most effective from all A* based algorithms.

#### A* based algorithm #3
Algorithm uses A* searching to find solved situation of cube. The metric for this A* based searcher is a number of wrongly placed little cubes. So this is the function h. The another function of A* is the number of already made steps. Little cubes are single cubes of Rubik's Cube. We have 20 little cubes, eight corners and twelve edges.

#### Human algorithm
This approach tries simulate steps we now from human algorithm. So there is a few stages we want to solve in specific order. 
- white cross
- white side
- white side and first level of cube
- white side, first and second level of cube
- white side, first, second a third level of cube and yellow side

There is not used any condition, still the BFS is used. But there are lists of moves that are used in this algorithm all the time. So we are using those lists as a one move instead of the real number of moves (for example 4). This algorithm is not so good yet, but it can be improved with few more lists of moves. And also with conditions like "if the little cube is between those two cubes, use this lists of moves". 


## How to use tests
- using command line
1) Run swipl in the program directory:

	`swipl`
	
2) Load the solver.pl:

	`?- ["solver.pl"].`
	
3) Load and run all tests:

	`?- ["tests/all_tests.pl"].`
	
