% ##################
% SOLVE RUBIK'S CUBE
% ##################




% solve(+Rubik'sCube, -Steps) :- List of steps solving Rubik'sCube with specified algorithm.
solve(Rubik, Solution) :- solve_basic(Rubik,Solution).








% ###############################
% RUBIK'S CUBE SOLVING ALGORITHMS
% ###############################




% solve_basic(+Rubik'sCube,-Steps) :- List of Steps solving our "Rubik'sCube".
% Simple recursive approach.
solve_basic(Rubik,[]) :- solved(Rubik). 
solve_basic(Rubik,[NewMove | Moves]) :- solve_basic(NewState,Moves), move(NewMove, Rubik, NewState).

% solve_Astar_1(+Rubik'sCube,-Steps) :- List of steps solving our "Rubik'sCube".
% A star approach. Using metric based on function h_function1 (number of wrongly placed colors).
solve_Astar_1(Rubik,Steps) :- solve_Astar(Rubik,Steps,h_function1), !.

% solve_Astar_2(+Rubik'sCube,-Steps)  :- List of steps solving our "Rubik'sCube".
% A star approach. Using metric based on function h_function2 (number of moves to complete corners or edges).
solve_Astar_2(Rubik,Steps) :- solve_Astar(Rubik,Steps,h_function2), !.

% solve_Astar_3(+Rubik'sCube,-Steps)  :- List of steps solving our "Rubik'sCube".
% A star approach. Using metric based on function h_function3 (number of wrongly placed little cubes).
solve_Astar_3(Rubik,Steps) :- solve_Astar(Rubik,Steps,h_function3), !.

% solve_human(+Rubik'sCube,-Steps)  :- List of steps solving our "Rubik'sCube".
% Human algorithm approach. Using metric based on human's algorithms building the cube from white side up to yellow side.
solve_human(Rubik,Steps) :- solve_human_stage1(Rubik,RubikStage1,Steps1),
    						solve_human_stage2(RubikStage1,RubikStage2,Steps2),
    						solve_human_stage3(RubikStage2,RubikStage3,Steps3),
    						solve_human_stage4(RubikStage3,_,Steps4),
    						!,append([Steps1,Steps2,Steps3,Steps4], Steps).








% #############
% A* COMPONENTS
% #############




% solve_Astar(+Rubik'sCube,-Steps,+H_func) :- Search steps solving Rubik'sCube using A*,
% 									The algorithm is based on a NodeList, List of nodes with data [Rubik,Steps,F,D],
% 									
% 										where Rubik is a state of a cube, Steps is a list of moves from Rubik'sCube to Rubik, F is a value of function F and D is a number
% 										of steps from start .. DistanceFromStart,
% 									
% 									and that NodeList is ordered by value of function F, with no repeated Rubik's State of nodes,
% 									And the algorithm takes the cheapest element, finds all children/followers, inserts them into NodeList until the solved state is found.  
solve_Astar(Rubik,Steps,H_func) :- f_function(Rubik,FunctionF,0,H_func),search([[Rubik,[],FunctionF,0]],ReversedSteps,H_func), reverse(ReversedSteps,Steps).

% search(+NodeList,-Steps,+H_func) :- take cheapest node, first one of NodeList,
% 			 look for all his followers and create a new NodeList with them, still ordered by value of function F 
% 			 until the solved Rubik is found.
search([[Rubik,Steps,_,_]|_],Steps,_) :- solved(Rubik).
search([CheapestNode|NodeList],Steps,H_func) :- find_followers(CheapestNode,AllFollowers,H_func),insert_followers(AllFollowers,NodeList,NewNodeList),search(NewNodeList,Steps,H_func).

% find_followers(+Node,-AllFollowers,+H_func) :- find all followers (passed in AllFollowers) for actual node 'Node' using bagof. 
find_followers([Rubik,Steps,_,DistanceFromStart],AllFollowers,H_func) :- bagof([Follower,[Move|Steps],F,NewDistanceFromStart],
           (NewDistanceFromStart is DistanceFromStart+1,move(Move,Rubik,Follower),f_function(Follower,F,NewDistanceFromStart,H_func)),
           AllFollowers).

% insert_followers(+ListToInsert,+NodeList,-NewNodeList) :- NewNodeList is a list created by inserting nodes from ListToInsert into NodeList,
% 													still ordered by function F and without repeated same states of Rubiks. 
insert_followers([ElementToInsert|ListToInsert],NodeList,NewNodeList) :- insert_single(ElementToInsert,NodeList,NodeListWithOneInserted), insert_followers(ListToInsert,NodeListWithOneInserted,NewNodeList).
insert_followers([],NodeList,NodeList).

% insert_single(+ElementToInsert, +NodeList, -NodeListWithThatElement) :- NodeListWithThatElement is a result of inserted ElementToInsert into NodeList,
% 															ElementToInsert has to have a uniq Rubik State (or there is a cheaper version of this state)
% 															and all elements before ElementToInsert have a cheaper value of function F and the first (-> all) elment after
% 															ElementToInsert should be more expensive.
insert_single(ElementToInsert,NodeList,NodeList) :- repeating_nodes(ElementToInsert,NodeList),!.
insert_single(ElementToInsert,[X|NodeList],[ElementToInsert,X|NodeList]) :- not_ordered_nodes_by_F(ElementToInsert,X),!.
insert_single(ElementToInsert,[X|NodeList],[X|NodeListWithOneInserted]) :- insert_single(ElementToInsert,NodeList,NodeListWithOneInserted),!.
insert_single(ElementToInsert,[],[ElementToInsert]).

% repeating_nodes(?ElemnetToInsert, ?NodeList) :- false, if there is not a same element for ElementToInsert as a head of NodeList (with same State),
% 											in a way insert_single is using it .. false, if there is not same element in whole list, 
% 											otherwise true.
repeating_nodes([Rubik,_,_,_], [[Rubik,_,_,_]|_]).

% not_ordered_nodes_by_F(?Node1,?Node2) :- Comparing two nodes, whether the Node1 has cheaper value of function F, then Node2. 
not_ordered_nodes_by_F( [_,_,FunctionF1,_], [_,_,FunctionF2,_] ) :- FunctionF1 < FunctionF2.

% f_function(+Rubik'sCube,-FunctionF,+DistanceFromStart,+H_func) :- FunctionF is result of sum of DistanceFromStart (number of steps) and FunctionH (using H_func function) for Rubik'sCube.
f_function(Rubik,FunctionF,DistanceFromStart,H_func) :- call(H_func,Rubik,FunctionH),FunctionF is DistanceFromStart + FunctionH.








% ####################################################
% H FUNCTIONS FOR A* ALGORITHM FOR EACH OF OUR METRICS
% ####################################################




% h_function1(+Rubik'sCube, -H) :- "Rubik'sCube" has value of H. That value is based on the number of correct colers.
% The maximum value of H is 48, when all colers of the cube "Rubik'sCube" are wrongly placed.
h_function1(R, H) :- h_singleFields(R, H).

% h_function2(+Rubik'sCube, -H) :- "Rubik'sCube" has value of H. That value is based on the number of moves we need to solve the cube.
% Basically, function takes maximum value of three components - number of moves to solve corners, to solve half od edges and to solve the resting half of edges.
% .. h(n) = max {h_{corners}(n), h_{e1}(n), h_{e2}(n)}
% Inspiration from here http://www.diva-portal.org/smash/get/diva2:816583/FULLTEXT01.pdf
%
% Only problem is that we don't know the number of moves. So we have two options 1) pregenerate all situations and their distances 2) find the number with some other solver.
h_function2(R, H) :- h_max(R, H).


% h_function3(+Rubik'sCube, -H) :- "Rubik'sCube" has value of H. That value is based on the number of correct little cubes.
% The maximum value of H is 20, when all little cubes of the cube "Rubik'sCube" are wrongly placed.
h_function3(R, H) :- h_littleCubes(R, N), H is 20 - N.








% ###################
% FIRST METRIC FOR A*
% ###################




% h_singleFields(+Rubik'sCube, -H) :- H is a number of wrongly placed colors in our cube "Rubik'sCube".
h_singleFields(rubik(A1,A2,A3,A4,A5,A6,A7,A8,A9,B1,B2,B3,B4,B5,B6,B7,B8,B9,C1,C2,C3,C4,C5,C6,C7,C8,C9,D1,D2,D3,D4,D5,D6,D7,D8,D9,E1,E2,E3,E4,E5,E6,E7,E8,E9,F1,F2,F3,F4,F5,F6,F7,F8,F9), H) :-
     same(A1, A5, N11), same(A2, A5, N12), same(A3, A5, N13), same(A4, A5, N14), same(A6, A5, N16), same(A7, A5, N17), same(A8, A5, N18), same(A9, A5, N19),
     same(B1, B5, N21), same(B2, B5, N22), same(B3, B5, N23), same(B4, B5, N24), same(B6, B5, N26), same(B7, B5, N27), same(B8, B5, N28), same(B9, B5, N29),
     same(C1, C5, N31), same(C2, C5, N32), same(C3, C5, N33), same(C4, C5, N34), same(C6, C5, N36), same(C7, C5, N37), same(C8, C5, N38), same(C9, C5, N39),
     same(D1, D5, N41), same(D2, D5, N42), same(D3, D5, N43), same(D4, D5, N44), same(D6, D5, N46), same(D7, D5, N47), same(D8, D5, N48), same(D9, D5, N49),
     same(E1, E5, N51), same(E2, E5, N52), same(E3, E5, N53), same(E4, E5, N54), same(E6, E5, N56), same(E7, E5, N57), same(E8, E5, N58), same(E9, E5, N59),
     same(F1, F5, N61), same(F2, F5, N62), same(F3, F5, N63), same(F4, F5, N64), same(F6, F5, N66), same(F7, F5, N67), same(F8, F5, N68), same(F9, F5, N69),
     H is 48-N11-N12-N13-N14-N16-N17-N18-N19-N21-N22-N23-N24-N26-N27-N28-N29-N31-N32-N33-N34-N36-N37-N38-N39-N41-N42-N43-N44-N46-N47-N48-N49-N51-N52-N53-N54-N56-N57-N58-N59-N61-N62-N63-N64-N66-N67-N68-N69.

% same(+Color1, +Color2, -Num) :- For C1 == C2 we have Num = 1. Otherwise N = 0.
same(C1,C2,N) :- C1 == C2, !, N = 1.
same(C1,C2,N) :- C1 \= C2, N = 0.








% ####################
% SECOND METRIC FOR A*
% ####################




%h_max(+Rubik'sCube,-N) :- maximum value of h_corner, h_e1, h_e2 for cube Rubik'sCube.
h_max(Rubik, N) :- h_corner(Rubik, N1),h_e1(Rubik, N2),h_e2(Rubik, N3),maxm(N1,N2,N3,N).

%h_corner(+Rubik'sCube,-N) :- N moves from cube Rubik'sCube to cube Corners with correctly placed corners.
h_corner(Rubik, N) :- solvedCorners(Corners),find_path(Rubik, Corners,Solution),!,length(Solution,N).

%h_e1(+Rubik'sCube,-N) :- N moves from cube Rubik'sCube to cube Edges1 with correctly placed half of edges.
h_e1(Rubik, N) :- solvedEdges1(Edges1), find_path(Rubik, Edges1,Solution),!,length(Solution, N).

%h_e2(+Rubik'sCube,-N) :-N moves from cube Rubik'sCube to cube Edges2 with correctly placed second half of edges.
h_e2(Rubik, N) :- solvedEdges2(Edges2), find_path(Rubik,Edges2,Solution),!,length(Solution,N).

%maxm(+A1, +A2, +A3, -N):- N=max(A1,A2,A3).
maxm(A1,A2,A3,N) :- A1>A2,A1>A3,!,N=A1.
maxm(A1,A2,A3,N) :- A1<A2,A2>A3,!,N=A2.
maxm(A1,A2,A3,N) :- A3>A2,A1<A3,!,N=A3.
maxm(A1,A2,A3,N) :- A1=A2,A1<A3,!,N=A3.
maxm(A1,A2,A3,N) :- A1<A2,A1=A3,!,N=A2.
maxm(A1,A2,A3,N) :- A2=A3,A1>A2,!,N=A1.
maxm(A1,A2,A3,N) :- A1=A2,A1>A3,!,N=A1.
maxm(A1,A2,A3,N) :- A1=A3,A2<A3,!,N=A1.
maxm(A1,A2,A3,N) :- A2=A3,A1<A3,!,N=A2.
maxm(A1,A2,A3,N) :- A1=A2,A1=A3,!,N=A1.

%find_path(+Rubik'sCube,+GoalCube,-Steps) :- Steps is a list of steps leading Rubik'sCube cube into GoalCube cube.
find_path(Rubik, Rubik,[]). 
find_path(Rubik, Goal, [NewMove | Moves]) :- !, find_path(NewState,Goal,Moves), move(NewMove, Rubik, NewState).








% ###################
% THIRD METRIC FOR A*
% ###################




% h_littleCubes(Rubik'sCube, H) :- H is a number of correctly placed little cubes in our "Rubik'sCube". 
h_littleCubes(R,H) :- true_false(h_littleCube1(R), N1),true_false(h_littleCube2(R), N2),true_false(h_littleCube2(R), N2), true_false(h_littleCube3(R), N3),true_false(h_littleCube4(R), N4),
    true_false(h_littleCube5(R), N5),true_false(h_littleCube6(R), N6),true_false(h_littleCube7(R), N7),true_false(h_littleCube8(R), N8),
    true_false(h_littleCube9(R), N9),true_false(h_littleCube10(R), N10),true_false(h_littleCube11(R), N11),true_false(h_littleCube12(R), N12),
    true_false(h_littleCube13(R), N13),true_false(h_littleCube14(R), N14),true_false(h_littleCube15(R), N15),true_false(h_littleCube16(R), N16),
    true_false(h_littleCube17(R), N17),true_false(h_littleCube18(R), N18),true_false(h_littleCube19(R), N19),true_false(h_littleCube20(R), N20),
    !, H is N1 + N2 + N3 + N4 + N5 + N6 + N7 + N8 + N9 + N10 + N11 + N12 + N13 + N14 + N15 + N16 + N17 + N18 + N19 + N20.

% h_littleCubeN(Rubik'sCube) :- "Rubik'sCube" has Nth little cube the correctly placed. 
h_littleCube1(rubik(W,_,_,_,W,_,_,_,_,G,_,_,_,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube2(rubik(_,W,_,_,W,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,_,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube3(rubik(_,_,W,_,W,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,_,B,_,_,_,_,O,_,_,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube4(rubik(_,_,_,W,W,_,_,_,_,_,G,_,_,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube5(rubik(_,_,_,_,W,W,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,_,_,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube6(rubik(_,_,_,_,W,_,W,_,_,_,_,G,_,G,_,_,_,_,R,_,_,_,R,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube7(rubik(_,_,_,_,W,_,_,W,_,_,_,_,_,_,_,_,_,_,_,R,_,_,R,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube8(rubik(_,_,_,_,W,_,_,_,W,_,_,_,_,_,_,_,_,_,_,_,R,_,R,_,_,_,_,B,_,_,_,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube9(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,G,_,_,_,G,_,_,_,_,R,_,R,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Y,_,_,_,Y,_,_,_,_)).
h_littleCube10(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,R,_,_,R,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Y,_,_,Y,_,_,_,_)).
h_littleCube11(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,R,_,_,_,R,_,_,_,_,B,_,B,_,_,_,_,_,_,_,_,_,_,_,_,_,Y,_,Y,_,_,_,_)).
h_littleCube12(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,G,_,_,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Y,Y,_,_,_,_)).
h_littleCube13(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,_,_,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,Y,Y,_,_,_)).
h_littleCube14(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,G,_,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,_,_,_,O,_,_,_,_,Y,_,Y,_,_)).
h_littleCube15(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,_,_,O,_,_,_,_,_,Y,_,_,Y,_)).
h_littleCube16(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,_,_,_,B,_,_,_,_,O,_,O,_,_,_,_,_,_,Y,_,_,_,Y)).
h_littleCube17(rubik(_,_,_,_,_,_,_,_,_,_,_,_,G,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,O,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube18(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,B,_,_,_,_,_,_,O,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube19(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,R,R,_,_,_,_,_,_,B,B,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).
h_littleCube20(rubik(_,_,_,_,_,_,_,_,_,_,_,_,_,G,G,_,_,_,_,_,_,R,R,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_)).

% true_false(T, N) :- for T .. true, return N = 1, otherwise return N = 0.
true_false(T, N) :- T, !, N = 1.
true_false(T, N) :- \+ T, N = 0.








% ##########################
% SITUATIONS OF RUBIK'S CUBE
% ##########################




%solved(?Rubik'sCube) :- Rubik'sCube is solved cube.
solved(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,G,G,G,G,R,R,R,R,R,R,R,R,R,B,B,B,B,B,B,B,B,B,O,O,O,O,O,O,O,O,O,Y,Y,Y,Y,Y,Y,Y,Y,Y)).

% solvedCorners(?Rubik'sCube) :- Rubik'sCube is a cube with correct corners.
solvedCorners(rubik(W,_,W,_,W,_,W,_,W,G,_,G,_,G,_,G,_,G,R,_,R,_,R,_,R,_,R,B,_,B,_,B,_,B,_,B,O,_,O,_,O,_,O,_,O,Y,_,Y,_,Y,_,Y,_,Y)).

% solvedEdges1(?Rubik'sCube) :- Rubik'sCube is a cube with a first half of correct edges.
solvedEdges1(rubik(_,_,_,_,W,W,_,W,_,_,_,_,G,G,_,_,G,_,_,R,_,_,R,R,_,_,_,_,B,_,B,B,_,_,_,_,_,_,_,_,O,O,_,O,_,_,_,_,Y,Y,_,_,Y,_)).

% solvedEdges2(?Rubik'sCube) :-  Rubik'sCube is a cube with a second half of correct edges.
solvedEdges2(rubik(_,W,_,W,W,_,_,_,_,_,G,_,_,G,G,_,_,_,_,_,_,R,R,_,_,R,_,_,_,_,_,B,B,_,B,_,_,O,_,O,O,_,_,_,_,_,Y,_,_,Y,Y,_,_,_)).

% solvedHumanStage1 is a stage to build white cross correctly
%
% solvedHumanStage1v1(?Rubik'sCube) :- correctly placed white-orange edge. 
solvedHumanStage1v1(rubik(_,W,_,_,W,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,_,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage1v2(?Rubik'sCube) :- correctly placed white-orange,white-green edges. 
solvedHumanStage1v2(rubik(_,W,_,W,W,_,_,_,_,_,G,_,_,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,_,O,_,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage1v2(?Rubik'sCube) :- correctly placed white-orange,white-green, white-blue edges.
solvedHumanStage1v3(rubik(_,W,_,W,W,W,_,_,_,_,G,_,_,G,_,_,_,_,_,_,_,_,_,_,_,_,_,_,B,_,_,B,_,_,_,_,_,O,_,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage1v2(?Rubik'sCube) :- correctly placed all white edges. 
solvedHumanStage1v4(rubik(_,W,_,W,W,W,_,W,_,_,G,_,_,G,_,_,_,_,_,R,_,_,R,_,_,_,_,_,B,_,_,B,_,_,_,_,_,O,_,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).

% solvedHumanStage2 is a stage to build white corners correctly
%
% solvedHumanStage2v1(?Rubik'sCube) :- one corner correctly placed. 
solvedHumanStage2v1(rubik(W,W,_,W,W,W,_,W,_,G,G,_,_,G,_,_,_,_,_,R,_,_,R,_,_,_,_,_,B,_,_,B,_,_,_,_,_,O,O,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage2v2(?Rubik'sCube) :- two corners at the right position. 
solvedHumanStage2v2(rubik(W,W,W,W,W,W,_,W,_,G,G,_,_,G,_,_,_,_,_,R,_,_,R,_,_,_,_,_,B,B,_,B,_,_,_,_,O,O,O,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage2v3(?Rubik'sCube) :- trhee corners at the right position. 
solvedHumanStage2v3(rubik(W,W,W,W,W,W,W,W,_,G,G,G,_,G,_,_,_,_,R,R,_,_,R,_,_,_,_,_,B,B,_,B,_,_,_,_,O,O,O,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage2v4(?Rubik'sCube) :- completed white side. 
solvedHumanStage2v4(rubik(W,W,W,W,W,W,W,W,W,G,G,G,_,G,_,_,_,_,R,R,R,_,R,_,_,_,_,B,B,B,_,B,_,_,_,_,O,O,O,_,O,_,_,_,_,_,_,_,_,_,_,_,_,_)).

% solvedHumanStage3 is a stage to build second level correctly
%
% solvedHumanStage3v1(?Rubik'sCube) :- one corner correctly placed. 
solvedHumanStage3v1(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,_,_,_,_,R,R,R,_,R,_,_,_,_,B,B,B,_,B,_,_,_,_,O,O,O,_,O,O,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage3v2(?Rubik'sCube) :- two corners at the right position. 
solvedHumanStage3v2(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,_,_,_,_,R,R,R,_,R,_,_,_,_,B,B,B,_,B,B,_,_,_,O,O,O,O,O,O,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage3v3(?Rubik'sCube) :- trhee corners at the right position. 
solvedHumanStage3v3(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,_,_,_,_,R,R,R,_,R,R,_,_,_,B,B,B,B,B,B,_,_,_,O,O,O,O,O,O,_,_,_,_,_,_,_,_,_,_,_,_)).
% solvedHumanStage3v4(?Rubik'sCube) :- completed white side. 
solvedHumanStage3v4(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,G,_,_,_,R,R,R,R,R,R,_,_,_,B,B,B,B,B,B,_,_,_,O,O,O,O,O,O,_,_,_,_,_,_,_,_,_,_,_,_)).

% solvedHumanStage4 is a stage to build second level correctly
%
% solvedHumanStage4v1(?Rubik'sCube) :- whiteside,first and second level, and corners of yellow side are correctly placed. 
solvedHumanStage4v1(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,G,_,_,_,R,R,R,R,R,R,_,_,_,B,B,B,B,B,B,_,_,_,O,O,O,O,O,O,_,_,_,Y,_,Y,_,Y,_,Y,_,Y)).
% solvedHumanStage4v2(?Rubik'sCube) :-  Rubik'sCube is a cube with a correct white side, first and second level cube and yellow side.
solvedHumanStage4v2(rubik(W,W,W,W,W,W,W,W,W,G,G,G,G,G,G,_,_,_,R,R,R,R,R,R,_,_,_,B,B,B,B,B,B,_,_,_,O,O,O,O,O,O,_,_,_,Y,Y,Y,Y,Y,Y,Y,Y,Y)).








% ####################################################
% DATA STRUCTURE OF RUBIK'S CUBE WITH MOVES DEFINITION
% ####################################################




%move(clockwise_up, CubeBefore, CubeAfter) :- If we rotate 'up' side ('W'hite color) in clockwise direction of CubeBefore, we get CubeAfter.
%							
move(clockwise_UP,
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W7,W4,W1,W8,W5,W2,W9,W6,W3,R1,R2,R3,G4,G5,G6,G7,G8,G9,B1,B2,B3,R4,R5,R6,R7,R8,R9,O1,O2,O3,B4,B5,B6,B7,B8,B9,G1,G2,G3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9)).
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_UP,Before,After) :- move(clockwise_UP,After,Before).



%move(clockwise_down, CubeBefore, CubeAfter) :- If we rotate 'down' side ('Y'ellow color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_DOWN,
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,R7,R8,R9,R1,R2,R3,R4,R5,R6,B7,B8,B9,B1,B2,B3,B4,B5,B6,O7,O8,O9,O1,O2,O3,O4,O5,O6,G7,G8,G9,Y3,Y6,Y9,Y2,Y5,Y8,Y1,Y4,Y7)).
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_DOWN,Before,After) :- move(clockwise_DOWN,After,Before).



%move(clockwise_left, CubeBefore, CubeAfter) :- If we rotate 'left' side ('G'reen color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_LEFT,
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(O9,W2,W3,O6,W5,W6,O3,W8,W9,G7,G4,G1,G8,G5,G2,G9,G6,G3,W1,R2,R3,W4,R5,R6,W7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,Y7,O4,O5,Y4,O7,O8,Y1,R1,Y2,Y3,R4,Y5,Y6,R7,Y8,Y9)).
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_LEFT,Before,After) :- move(clockwise_LEFT,After,Before).



%move(clockwise_right, CubeBefore, CubeAfter) :- If we rotate 'right' side ('B'lue color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_RIGHT,
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,W2,R3,W4,W5,R6,W7,W8,R9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,Y3,R4,R5,Y6,R7,R8,Y9,B7,B4,B1,B8,B5,B2,B9,B6,B3,W9,O2,O3,W6,O5,O6,W3,O8,O9,Y1,Y2,O7,Y4,Y5,O4,Y7,Y8,O1)).
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_RIGHT,Before,After) :- move(clockwise_RIGHT,After,Before).



%move(clockwise_front, CubeBefore, CubeAfter) :- If we rotate 'front' side ('R'ed color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_FRONT,
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,W2,W3,W4,W5,W6,G9,G6,G3,G1,G2,Y1,G4,G5,Y2,G7,G8,Y3,R7,R4,R1,R8,R5,R2,R9,R6,R3,W7,B2,B3,W8,B5,B6,W9,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,B7,B4,B1,Y4,Y5,Y6,Y7,Y8,Y9)).
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_FRONT,Before,After) :- move(clockwise_FRONT,After,Before).



%move(clockwise_back, CubeBefore, CubeAfter) :- If we rotate 'back' side ('O'range color) in clockwise direction of CubeBefore, we get CubeAfter.
%
move(clockwise_BACK,
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(G7,G4,G1,W4,W5,W6,W7,W8,W9,Y7,G2,G3,Y8,G5,G6,Y9,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,W1,B4,B5,W2,B7,B8,W3,O3,O6,O9,O2,O5,O8,O1,O4,O7,Y1,Y2,Y3,Y4,Y5,Y6,B9,B6,B3)).
% move(moveDescirption, CubeBefore, CubeAfter) :- move(moveDescription, CubeAfter,CubeBefore) is inverse move.
move(counter_clockwise_BACK,Before,After) :- move(clockwise_BACK,After,Before).








% #######################################
% HUMAN ALGORITHM, MORE COMPLICATED MOVES
% #######################################




% human_move_stage1(ListOfMoves, CubeBefore,CubeAfter) :- useful moves for stage1.
%
% 	1) all basic moves
% 	2) moves to place edges into white side
human_move_stage1(Move,CubeBefore,CubeAfter) :- move(Move,CubeBefore,CubeAfter).
human_move_stage1([clockwise_DOWN,counter_clockwise_RIGHT,clockwise_LEFT,counter_clockwise_BACK,clockwise_RIGHT,counter_clockwise_LEFT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,O8,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,W2,G9,R1,R2,R3,R4,R5,R6,R7,B8,R9,B1,B2,B3,B4,B5,B6,B7,Y4,B9,O1,Y8,O3,O4,O5,O6,O7,Y2,O9,Y1,Y6,Y3,O2,Y5,G8,Y7,R8,Y9)).
human_move_stage1([clockwise_DOWN,clockwise_RIGHT,counter_clockwise_LEFT,clockwise_FRONT,counter_clockwise_RIGHT,clockwise_LEFT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,W2,W3,W4,W5,W6,W7,R8,W9,G1,G2,G3,G4,G5,G6,G7,Y6,G9,R1,Y2,R3,R4,R5,R6,R7,Y8,R9,B1,B2,B3,B4,B5,B6,B7,W8,B9,O1,O2,O3,O4,O5,O6,O7,G8,O9,Y1,O8,Y3,B8,Y5,R2,Y7,Y4,Y9)).
human_move_stage1([clockwise_DOWN,clockwise_FRONT,clockwise_BACK,clockwise_LEFT,counter_clockwise_FRONT,counter_clockwise_BACK],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,W2,W3,G8,W5,W6,W7,W8,W9,G1,Y4,G3,G4,G5,G6,G7,Y6,G9,R1,R2,R3,R4,R5,R6,R7,W4,R9,B1,B2,B3,B4,B5,B6,B7,O8,B9,O1,O2,O3,O4,O5,O6,O7,Y2,O9,Y1,G2,Y3,B8,Y5,Y8,Y7,R8,Y9)).
human_move_stage1([clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_BACK,clockwise_RIGHT,clockwise_FRONT,clockwise_BACK],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
    rubik(W1,W2,W3,W4,W5,B8,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,R8,G9,R1,R2,R3,R4,R5,R6,R7,Y8,R9,B1,Y6,B3,B4,B5,B6,B7,Y4,B9,O1,O2,O3,O4,O5,O6,O7,W6,O9,Y1,O8,Y3,Y2,Y5,G8,Y7,B2,Y9)).



% human_move_stage2(ListOfMoves, CubeBefore,CubeAfter) :- useful moves for stage2.
%
% 	1) all basic moves
% 	2) moves to place corners into white side
human_move_stage2(Move,CubeBefore,CubeAfter) :- move(Move,CubeBefore,CubeAfter).
human_move_stage2([counter_clockwise_DOWN,clockwise_RIGHT,clockwise_DOWN,counter_clockwise_RIGHT],
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,O7,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,Y3,R1,R2,R3,R4,R5,R6,R9,B6,G9,B1,B2,B9,B4,B5,B8,R7,R8,W3,Y9,O2,O3,Y6,O5,O6,O1,O8,O9,B7,O4,Y1,Y4,Y5,Y2,Y7,Y8,B3)).
human_move_stage2([clockwise_DOWN,counter_clockwise_LEFT,counter_clockwise_DOWN,clockwise_LEFT],
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(O9,W2,W3,W4,W5,W6,W7,W8,W9,G7,G2,G3,G8,G5,G6,W1,R8,R9,R1,R2,R3,R4,R5,R6,B7,G4,R7,B1,B2,B3,B4,B5,B6,Y1,B8,B9,O1,O2,Y7,O4,O5,Y4,O7,O8,O3,Y3,O6,G9,Y2,Y5,Y6,G1,Y8,Y9)).
human_move_stage2([clockwise_DOWN,counter_clockwise_RIGHT,counter_clockwise_DOWN,clockwise_RIGHT],
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,R9,G1,G2,G3,G4,G5,G6,Y9,G8,G9,R1,R2,Y3,R4,R5,Y6,R7,R8,R3,B7,B2,B3,B8,B5,B6,W9,O8,O9,O1,O2,O3,O4,O5,O6,G7,B4,O7,Y1,Y2,B1,Y4,Y5,Y8,B9,R6,Y7)).
human_move_stage2([counter_clockwise_DOWN,clockwise_LEFT,clockwise_DOWN,counter_clockwise_LEFT],
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,R7,W8,W9,G1,G2,G9,G4,G5,G8,O7,O8,W7,Y1,R2,R3,Y4,R5,R6,R1,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,Y7,O1,O2,O3,O4,O5,O6,O9,G6,B9,G3,Y2,Y3,Y8,Y5,Y6,Y9,R4,G7)).
human_move_stage2([counter_clockwise_DOWN,clockwise_FRONT,clockwise_DOWN,counter_clockwise_FRONT],
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,B7,G1,G2,G3,G4,G5,G6,G9,R6,O9,R1,R2,R9,R4,R5,R8,G7,G8,W9,Y3,B2,B3,Y2,B5,B6,B1,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,Y1,Y7,Y4,R3,B4,Y5,Y6,R7,Y8,Y9)).
human_move_stage2([counter_clockwise_DOWN,counter_clockwise_BACK,clockwise_DOWN,clockwise_BACK],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(G7,W2,W3,W4,W5,W6,W7,W8,W9,Y7,G2,G3,Y8,G5,G6,G1,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,Y9,B1,B2,B3,B4,B5,B6,B9,O6,R9,O1,O2,O9,O4,O5,O8,B7,B8,W1,Y1,Y2,O7,Y4,Y5,G4,O3,Y6,Y3)).
human_move_stage2([clockwise_DOWN,clockwise_BACK,counter_clockwise_DOWN,counter_clockwise_BACK],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,B9,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,R7,O4,G7,R1,R2,R3,R4,R5,R6,Y7,R8,R9,B1,B2,Y9,B4,B5,Y8,B7,B8,B3,O7,O2,O3,O8,O5,O6,W3,G8,G9,O9,Y2,Y3,B6,Y5,Y6,Y1,Y4,O1)).
human_move_stage2([clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_DOWN,clockwise_FRONT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,G9,W8,W9,G1,G2,Y1,G4,G5,Y2,G7,G8,G3,R7,R2,R3,R8,R5,R6,W7,B8,B9,B1,B2,B3,B4,B5,B6,O7,R4,B7,O1,O2,O3,O4,O5,O6,Y3,O8,O9,R1,Y6,Y9,Y4,Y5,G6,Y7,Y8,R9)).



% human_move_stage3(ListOfMoves, CubeBefore,CubeAfter) :- useful moves for stage2.
%
% 	1) all basic moves
% 	2) moves to place second-level-edges into white side
human_move_stage3(Move,CubeBefore,CubeAfter) :- move(Move,CubeBefore,CubeAfter).
human_move_stage3([clockwise_DOWN,clockwise_BACK,counter_clockwise_DOWN,counter_clockwise_BACK,   counter_clockwise_DOWN,clockwise_RIGHT,clockwise_DOWN,counter_clockwise_RIGHT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,R7,O4,Y3,R1,R2,R3,R4,R5,R6,R9,Y8,G7,B1,B2,B3,B4,B5,B8,Y7,R8,B9,O1,O2,O3,Y6,O5,O6,O7,G8,G9,B7,O8,O9,B6,Y5,Y2,Y1,Y4,Y9)).
human_move_stage3([counter_clockwise_DOWN,counter_clockwise_BACK,clockwise_DOWN,clockwise_BACK,   clockwise_DOWN,counter_clockwise_LEFT,counter_clockwise_DOWN,clockwise_LEFT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G8,G5,G6,G7,R8,Y9,R1,R2,R3,R4,R5,R6,B9,Y8,R7,B1,B2,B3,B4,B5,B6,Y1,O6,R9,O1,O2,O3,O4,O5,Y4,B7,B8,O9,O7,O8,G9,Y2,Y5,G4,Y7,Y6,Y3)).
human_move_stage3([counter_clockwise_DOWN,clockwise_FRONT,clockwise_DOWN,counter_clockwise_FRONT,   clockwise_DOWN,counter_clockwise_RIGHT,counter_clockwise_DOWN,clockwise_RIGHT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,Y9,R6,O9,R1,R2,R3,R4,R5,Y6,G7,G8,R9,B1,B2,B3,B8,B5,B6,B7,O8,Y1,O1,O2,O3,O4,O5,O6,G9,Y2,O7,Y7,Y4,Y3,B4,Y5,Y8,B9,R8,R7)).
human_move_stage3([clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_DOWN,clockwise_FRONT,   counter_clockwise_DOWN,clockwise_LEFT,clockwise_DOWN,counter_clockwise_LEFT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G8,Y3,O8,G9,R1,R2,R3,Y4,R5,R6,R7,B8,B9,B1,B2,B3,B4,B5,B6,O7,R4,Y7,O1,O2,O3,O4,O5,O6,O9,Y2,B7,Y1,Y6,Y9,Y8,Y5,G6,R9,R8,G7)).
human_move_stage3([clockwise_DOWN,counter_clockwise_RIGHT,counter_clockwise_DOWN,clockwise_RIGHT,    counter_clockwise_DOWN,clockwise_FRONT,clockwise_DOWN,counter_clockwise_FRONT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G9,Y6,O7,R1,R2,R3,R4,R5,R8,Y9,G8,R9,B1,B2,B3,Y2,B5,B6,B7,O8,O9,O1,O2,O3,O4,O5,O6,G7,B4,Y1,B9,Y4,Y3,B8,Y5,Y8,R7,R6,Y7)).
human_move_stage3([clockwise_DOWN,counter_clockwise_LEFT,counter_clockwise_DOWN,clockwise_LEFT,    counter_clockwise_DOWN,counter_clockwise_BACK,clockwise_DOWN,clockwise_BACK],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,Y8,G5,G6,G7,R8,R9,R1,R2,R3,R4,R5,R6,B7,G4,Y9,B1,B2,B3,B4,B5,B6,B9,Y4,R7,O1,O2,O3,O4,O5,O8,Y1,B8,O9,Y3,O6,O7,Y2,Y5,G8,Y7,Y6,G9)).
human_move_stage3([counter_clockwise_DOWN,clockwise_RIGHT,clockwise_DOWN,counter_clockwise_RIGHT,    clockwise_DOWN,clockwise_BACK,counter_clockwise_DOWN,counter_clockwise_BACK],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,R9,Y6,G7,R1,R2,R3,R4,R5,R6,Y7,B6,G9,B1,B2,B3,B4,B5,Y8,R7,R8,B9,O1,O2,O3,O8,O5,O6,O7,G8,Y3,O9,O4,Y1,B8,Y5,Y2,B7,Y4,Y9)).
human_move_stage3([counter_clockwise_DOWN,clockwise_LEFT,clockwise_DOWN,counter_clockwise_LEFT,    clockwise_DOWN,counter_clockwise_FRONT,counter_clockwise_DOWN,clockwise_FRONT],
    rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,G6,G7,G8,G9,R1,R2,R3,R4,R5,R6,R7,R8,R9,B1,B2,B3,B4,B5,B6,B7,B8,B9,O1,O2,O3,O4,O5,O6,O7,O8,O9,Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9),
	rubik(W1,W2,W3,W4,W5,W6,W7,W8,W9,G1,G2,G3,G4,G5,Y2,O7,O8,G9,R1,R2,R3,R8,R5,R6,R7,B8,Y7,B1,B2,B3,B4,B5,B6,O9,Y4,B7,O1,O2,O3,O4,O5,O6,Y3,G6,B9,Y1,Y6,G7,Y8,Y5,G8,Y9,R4,R9)).








% ######################################################
% HUMAN ALGORITHM, FIND_PATH WITH MORE COMPLICATED MOVES
% ######################################################




% find_path_stage1(+Rubik'sCube,+GoalCube,-MoveList) :- returns path from 'Rubik'sCube' to 'GoalCube' in 'MoveList' using moves specified for stage1 of human algorithm.
find_path_stage1(Rubik, Rubik,[]). 
find_path_stage1(Rubik, Goal, [NewMove | Moves]) :- !, find_path(NewState,Goal,Moves), human_move_stage1(NewMove, Rubik, NewState).

% find_path_stage2(+Rubik'sCube,+GoalCube,-MoveList) :- returns path from 'Rubik'sCube' to 'GoalCube' in 'MoveList' using moves specified for stage2 of human algorithm.
find_path_stage2(Rubik, Rubik,[]). 
find_path_stage2(Rubik, Goal, [NewMove | Moves]) :- !, find_path(NewState,Goal,Moves), human_move_stage2(NewMove, Rubik, NewState).

% find_path_stage3(+Rubik'sCube,+GoalCube,-MoveList) :- returns path from 'Rubik'sCube' to 'GoalCube' in 'MoveList' using moves specified for stage3 of human algorithm.
find_path_stage3(Rubik, Rubik,[]). 
find_path_stage3(Rubik, Goal, [NewMove | Moves]) :- !, find_path(NewState,Goal,Moves), human_move_stage3(NewMove, Rubik, NewState).

% find_path_stage4(+Rubik'sCube,+GoalCube,-MoveList) :- returns path from 'Rubik'sCube' to 'GoalCube' in 'MoveList' using moves specified for stage4 of human algorithm.
find_path_stage4(Rubik, Rubik,[]). 
find_path_stage4(Rubik, Goal, [NewMove | Moves]) :- !, find_path(NewState,Goal,Moves), move(NewMove, Rubik, NewState).








% ########################################
%  HUMAN ALGORITHM, SOLVE DIFFERENT STAGES
% ########################################




% solve_human_stage1(+Rubik'sCube,-RubikResult,-Steps) :- list of moves in 'Steps' from 'Rubik'sCube' through the stage1,
%														RubikResult is a new created cube.
solve_human_stage1(Rubik,RubikResult,Steps) :- find_path_stage1(Rubik,RubikV1,Steps1), solvedHumanStage1v1(RubikV1),
    								find_path_stage1(RubikV1,RubikV2,Steps2), solvedHumanStage1v2(RubikV2),
    								find_path_stage1(RubikV2,RubikV3,Steps3), solvedHumanStage1v3(RubikV3),
    								find_path_stage1(RubikV3,RubikResult,Steps4), solvedHumanStage1v4(RubikResult), 
                   					append([Steps1,Steps2,Steps3,Steps4], Steps).
    						 
% solve_human_stage2(+Rubik'sCube,-RubikResult,-Steps) :- list of moves in 'Steps' from 'Rubik'sCube' through the stage2,
%														RubikResult is a new created cube.
solve_human_stage2(Rubik,RubikResult,Steps) :- find_path_stage2(Rubik,RubikV1,Steps1), solvedHumanStage2v1(RubikV1),
    								find_path_stage2(RubikV1,RubikV2,Steps2), solvedHumanStage2v2(RubikV2),
    								find_path_stage2(RubikV2,RubikV3,Steps3), solvedHumanStage2v3(RubikV3),
    								find_path_stage2(RubikV3,RubikResult,Steps4), solvedHumanStage2v4(RubikResult), 
                   					append([Steps1,Steps2,Steps3,Steps4], Steps).    

% solve_human_stage3(+Rubik'sCube,-RubikResult,-Steps) :- list of moves in 'Steps' from 'Rubik'sCube' through the stage3,
%														RubikResult is a new created cube.
solve_human_stage3(Rubik,RubikResult,Steps) :- find_path_stage3(Rubik,RubikV1,Steps1), solvedHumanStage3v1(RubikV1),
    								find_path_stage3(RubikV1,RubikV2,Steps2), solvedHumanStage3v2(RubikV2),
    								find_path_stage3(RubikV2,RubikV3,Steps3), solvedHumanStage3v3(RubikV3),
    								find_path_stage3(RubikV3,RubikResult,Steps4), solvedHumanStage3v4(RubikResult),
                   					append([Steps1,Steps2,Steps3,Steps4], Steps). 

% solve_human_stage4(+Rubik'sCube,-RubikResult,-Steps) :- list of moves in 'Steps' from 'Rubik'sCube' through the stage4,
%														RubikResult is a new created cube.
solve_human_stage4(Rubik,RubikResult,Steps) :- find_path_stage4(Rubik,RubikV1,Steps1), solvedHumanStage4v1(RubikV1),
    								find_path_stage4(RubikV1,RubikV2,Steps2), solvedHumanStage4v2(RubikV2),
    								find_path_stage4(RubikV2,RubikResult,Steps3), solved(RubikResult),
                   					append([Steps1,Steps2,Steps3], Steps).







