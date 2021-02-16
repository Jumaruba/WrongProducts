/** 
 * [] 
 * Function will create random boards in the range [BoundSize, CeilSize] and solve
 * each one of those. Also, it will print the statistics about those boards. 
 */
dimensional_statistics([BoundSize, CeilSize], Distincts):- 
    dimensional_statistics(CeilSize, BoundSize, Distincts). 

dimensional_statistics(CeilSize, AccSize, Distincts):-   
    CeilSize >= AccSize,!, 
    generate_random(AccSize, Distincts, ColumnProducts, RowProducts, _), 
    solveWithStatistics(ColumnProducts, RowProducts, Distincts, Solution), 
    NewAccSize is AccSize +1, 
    dimensional_statistics(CeilSize , NewAccSize, Distincts).

dimensional_statistics(CeilSize , AccSize, Distincts):-  
    CeilSize < AccSize.  


/**
 * Function will create random boards with the number of distincts elememnts included
 * in the range [BoundDistincts, CeilDistincts]. The variation of the number of distincts
 * elements in each line or col is not a characteristics of the puzzle, but a extra
 * feature created by us.
 */ 
distincts_statistics(Size, [BoundDistincts, CeilDistincts]):-
    distincts_statistics(Size, BoundDistincts, CeilDistincts). 

distincts_statistics(Size, AccDistincts, CeilDistincts):-
    CeilDistincts >= AccDistincts, !,  
    generate_random(Size, AccDistincts, ColumnProducts, RowProducts, _),
    solveWithStatistics(ColumnProducts, RowProducts, AccDistincts, Solution),
    NewAccDistincts is AccDistincts + 1, 
    distincts_statistics(Size, NewAccDistincts, CeilDistincts). 

distincts_statistics(Size, AccDistincts, CeilDistincts):-
    CeilDistincts > AccDistincts. 



% ----------------------------------------------------------------
%   Pre determined statistics - DIMENSIONS - 2 DISTINCTS
% ---------------------------------------------------------------- 

/**
 * In order to compare the effiecience between labeling methods, 
 * the statistics need to be compared between known boards.  
 */ 
deterministic_board_solve(Side):-
    deterministic_board(ColumnProducts, RowProducts, Side), 
    solveWithStatistics(ColumnProducts, RowProducts, 2, Board). 

all_deterministic_boards:-
    all_deterministic_boards(3).

all_deterministic_boards(10):- !.
all_deterministic_boards(Side):-
    deterministic_board_solve(Side),
    NewSide is Side +1,
    all_deterministic_boards(NewSide). 

deterministic_board([5,19,7], [19,5,11], 3).      % 0.000 sec || const: 62 || backtrck: 125
deterministic_board([4,15,47,11], [19,20,15,7], 4).  %0.031 sec || const: 98 || backtrck: 1387
deterministic_board([20,61,39,35,1], [29,10,29,23,19], 5). %0.125 sec || const: 140 || backtrck: 3129
deterministic_board( [43,7,41,53,121,6], [59,71,21,5,16,83], 6). %0.984 sec || const: 194 || backtrck: 18151
deterministic_board([9,5,69,57,28,155,109],  [27,61,76,41,71,19,11], 7). %177.735 sec  || const: 254 || backtrck: 22233736
deterministic_board([19,73,57,21,14,149,26,225], [139,145,89,27,85,61,4,29], 8). %124.266 sec || const: 322 || backtrck: 1552467
deterministic_board([9,17,47,12,64,145,139,241,220], [74,188,61,181,289,107,9,29,5], 9). % > 240 sec