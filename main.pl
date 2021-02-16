:- use_module(library(between)).
:- use_module(library(clpfd)).
:- use_module(library(lists)). 
:- use_module(library(random)).
:- consult('asserts.pl').
:- consult('restrictions.pl').  
:- consult('io.pl').
:- consult('generate.pl').
:- consult('utils.pl').
:- consult('statistics.pl').
 
generate_and_solve(Side, Distinct, Board):- 
	generate_random(Side, Distinct, ColumnProducts, RowProducts, Solution), 
	solveWithStatistics(ColumnProducts, RowProducts, Distinct, Board). 
	
solve(ColumnProducts, RowProducts, Distinct, Board) :-  
    asserts(ColumnProducts, RowProducts, Distinct),
	print_problem_visualization(ColumnProducts, RowProducts),
	create_board(Board),   
	restrict_board(Board), 
	% Restrict the products. 
	restrict_products(Board, RowProducts),  
	transpose(Board, TransposedBoard),
	restrict_products(TransposedBoard, ColumnProducts),  
	% Solution   
	flatten(Board, FlattenBoard), 
	labeling([enum], FlattenBoard),
	% Print the solution
	print_problem_solution(Board), 
    abolishes.
 
solveWithStatistics(ColumnProducts, RowProducts, Distinct, Board):- 
    statistics(runtime, [T0|_]), 
    solve(ColumnProducts, RowProducts, Distinct, Board),  
    statistics(runtime, [T1|_]),  
    T is T1 - T0, 
    print_statistics(T). 


    
% ----------------------------------------------------------------
% Board
% ----------------------------------------------------------------
% Creates the board 
create_board(Board):- 
	board(side, Side), 
	create_board(Board, Side). 

create_board([], 0):- !.
create_board([Line|Board], AccLines):-    
	AccLines > 0, 
	board(side, Side), 
	length(Line, Side), 
	NewAccLines is AccLines - 1, 
	create_board(Board, NewAccLines).    

