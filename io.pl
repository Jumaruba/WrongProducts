:-use_module(library(clpfd)). 
% ----------------------------------------------------------------
%   PRINT VISUALIZATION  
% ----------------------------------------------------------------  

print_problem_visualization(ColProd, RowProd):-  
    print('---------- PROBLEM SPECIFICATION ----------\n'),  nl, 
    board(size, Size), 
    print('[INFO] Matrix of size :: '), print(Size),  nl,   
    board(side, Side),  
    print('[INFO] Matrix of side :: '), print(Side),  nl,
    distinct(Distinct), 
    print('[INFO] Number of distincts elements in a row :: '), print(Distinct), nl,  
    board(max, Max), 
    print('[INFO] Range of numbers that can be used :: 1-'), print(Max), nl, 
    print('[INFO] Multiplication of each row :: '), print(RowProd), nl, 
    print('[INFO] Multiplication of each column :: '), print(ColProd), nl, nl, 
    print('[REQUEST] Confirm the specifications [Y|N].'), nl, 
    getCharOptions(['Y', 'N'], Value),
    interpretInputVisualization(Value). 

interpretInputVisualization('N'):-  
    abolishes,
    abort. 
interpretInputVisualization('Y'). 

print_statistics(T):-  
    print('---------- PROBLEM STATISTICS----------\n'),  nl, 
    fd_statistics, 
    format('Program took ~3d sec. ~n',[T]),
    print('%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%'), nl, nl.

% ----------------------------------------------------------------
%   PRINT SOLUTION  
% ---------------------------------------------------------------- 

print_formated_matrix(Matrix) :-
    remove_minus_one_matrix(Matrix, MatrixWithoutZero),
    print_matrix(MatrixWithoutZero).

print_problem_solution(Solution):-
    nl, 
    print('----------- PROBLEM SOLUTION -----------\n'),   
    print('The x represents the empty cells\n'), 
    nl,
    print_formated_matrix(Solution),
    nl.
    

% ----------------------------------------------------------------
%   PRINT FUNCTIONS  
% ---------------------------------------------------------------- 

print_matrix([]). 
print_matrix([X|Matrix]):-
    print(X), nl, 
    print_matrix(Matrix). 


remove_minus_one([], []). 
remove_minus_one([-1|Array], ['x'|NewArray]):-
    remove_minus_one(Array, NewArray), !. 

remove_minus_one([X|Array], [X|NewArray]):-
    X \= 'x', 
    remove_minus_one(Array, NewArray).  

remove_minus_one_matrix([],[]).
remove_minus_one_matrix([Line|Matrix], [NewLine|MatrixWithoutZero]):- 
    remove_minus_one(Line, NewLine), 
    remove_minus_one_matrix(Matrix, MatrixWithoutZero).


% ----------------------------------------------------------------
%   INPUT  
% ----------------------------------------------------------------  

readChar(Char) :-
	get_char(Char),
    skip_line.
 

getCharOptions(Options, Value) :-
	readChar(Value),
	member(Value, Options), !.

getCharOptions(Options, Value) :-
    print('Invalid input, try again!'), nl, 
	getCharOptions(Options, Value). 


