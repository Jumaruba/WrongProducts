
restrict_products_board(Board):-
	% Restrict the products. 
	restrict_products(Board, RowProducts),  
	transpose(Board, TransposedBoard),
    restrict_products(TransposedBoard, ColumnProducts). 
    
restrict_products([], []):- !. 
restrict_products([Elements|Board], [HeadProd|TailProd]) :-
    productElementsRestriction(Elements, ElementsProduct), 
    ElementsProduct #= HeadProd + 1 #\/ ElementsProduct #= HeadProd - 1,  
	restrict_products(Board,  TailProd).

productElementsRestriction([], 1):- !.
productElementsRestriction([X|L], ActualProduct):-
    productElementsRestriction(L, NewActualProduct), 
    NewActualProduct * abs(X) #= ActualProduct.



% ----------------------------------------------------------------
% Restrict elements
% ----------------------------------------------------------------

% All lines must have "Distinct" different values, the number -1, can appear more than once. 
restrict([]) :- !.
restrict([Elements|Board]) :-
    distinct(Distinct),                     % Number of distinct elements in a row and col. 
	nvalue(Distinct, Elements),
	restrict(Board).


restrict_board(Board) :-    
    board(max, Max),
    flatten(Board, FlattenBoard),    
    % Set domain.   
    % Each element appears exactly once in the board. Except for the number -1. 
    getListGlobalCarditality(CardinalityList, 1),      
    global_cardinality(FlattenBoard, CardinalityList),  
    % Force a number of distincts in each row and col. 
    restrict(Board),  
    transpose(Board, TransposedBoard), 
	restrict(TransposedBoard). 

%  The domain must be between -1, [1, max] 
getListGlobalCarditality([-1-_, Acc-1], Acc):- 
    board(max, Acc).

getListGlobalCarditality([Acc-1|R], Acc):-  
    board(max, Max),  
    Acc < Max, 
    NewAcc is Acc +1, 
    getListGlobalCarditality(R, NewAcc). 
    
