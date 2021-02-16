% Generates a random argument that has only one solution and returns it with the solution with Side and Distinct
generate_random(Side, Distinct, ColumnProducts, RowProducts, Board) :-
	assert_for_generation(Side, Distinct), 
	create_board(Board),
	restrict_board(Board), 
	NumberToRandomize is floor((Side * Distinct) / 2 + 1),  
	flatten(Board, FlattenBoard),
	randomize_elements(FlattenBoard, NumberToRandomize), 
	labeling([], FlattenBoard),
    create_arguments(Board, RowProducts, ColumnProducts).   
generate_random(Side, Distinct, ColumnProducts, RowProducts, Solution) :-
	generate_random(Side, Distinct, ColumnProducts, RowProducts, Solution).
	
generate_random(Side, Distinct) :-
	generate_random(Side, Distinct, ColumnProducts, RowProducts, Solution),
	format('\n-------Args-------\n~w ~w\n\n', [ColumnProducts, RowProducts]),
	print('-----Solution-----\n'),
	print_formated_matrix(Solution, Side).
	
assert_for_generation(Side, Distinct):-
	abolishes, 
	sideBoardAssert(Side, Side),
    sizeBoardAssert(Side, Side),
    distinctElementsAssert(Distinct),
    maxBoardAssert(Side).


calculate_products_([],[]). 
calculate_products_([X|Board], [Prod|RowProducts]):-
	productElementsRestriction(X, Prod), 
	calculate_products_(Board, RowProducts). 
calculate_products_(Board, ColumnProducts, RowProducts):-
	calculate_products_(Board, RowProducts), 
	transpose(Board,TransposedBoard), 
	calculate_products_(TransposedBoard, ColumnProducts). 


change_by_one([], []).
change_by_one([Head | Tail], [New | Rest]) :-
	random_member(Diff, [-1, 1]),
	New is Head + Diff,
	change_by_one(Tail, Rest).

create_arguments(Board, RowProducts, ColumnProducts) :-
	calculate_products_(Board, AuxRowProducts, AuxColumnProducts), !,
    change_by_one(AuxRowProducts, RowProducts),
    change_by_one(AuxColumnProducts, ColumnProducts), 
    % Empirically we can observe that when one possible set of the arguments differed by one has more than one solution,
    % the other possible sets will probably have the same problem.
    % The cut forces the algorithm to calculate another board, to save time and computer resources
    !.

randomize_elements(_, _, _, _, _, 0) :- !.
randomize_elements(Board, Size, Max, SelectedNums, SelectedPos, Number) :-
	random(1, Max, Num),
	nonmember(Num, SelectedNums),
	random(0, Size, Pos),
	nonmember(Pos, SelectedPos),
	nth0(Pos, Board, Num),
	Number1 is Number - 1,
	randomize_elements(Board, Size, Max, [Num | SelectedNums], [Pos | SelectedPos], Number1).
randomize_elements(Board, Number) :-
	board(size, Size),
    board(max, Max),
    MaxArgument is Max + 1,
    randomize_elements(Board, Size, MaxArgument, [], [], Number).
