:-use_module(library(lists)). 
% ----------------------------------------------------------------
% Main assert functions  
% ----------------------------------------------------------------
:- dynamic board/2. 
:- dynamic distinct/1. 

asserts(ColumnProducts, RowProducts, Distinct):-   
    length(ColumnProducts, LenCol),
    length(RowProducts, LenRow),    
    sideBoardAssert(LenRow, LenCol), 
    sizeBoardAssert(LenCol, LenRow),   
    distinctElementsAssert(Distinct),
    maxBoardAssert(LenRow). 

% Avoid conflicts with another execution.  
abolishes :-
    abolish(distinct/1), 
    abolish(board/2).  

% ----------------------------------------------------------------
% Assert functions  
% ----------------------------------------------------------------

% Asserts how many distinct elements must be in a line or col.   
% Where the number of distinct elements in a line must be less or equal the board size. 
% Never higher. 
distinctElementsAssert(Distinct):-
    board(side, Side), 
    Distinct > Side, 
    write('The number of distincts elements in a line must be less or equal the board side.'), nl, 
    abort.
distinctElementsAssert(Distinct):-   
    NewDistinct is Distinct +1,     % We must count the empty cell as a distinct element.
    assert(distinct(NewDistinct)).  
 

% Asserts the side of the board, where the sides length must be equal (LenCol == LenRow). 
sideBoardAssert(LenCol, LenRow):- 
    LenCol \= LenRow, 
    write('The size of rows and columns must be equal'), nl,  
    abort. 
sideBoardAssert(LenCol, LenRow):-
    assert(board(side, LenCol)).                % Height and width of the board
 

% Asserts the size of the board. 
sizeBoardAssert(LenCol, LenRow):-
    BoardSize is LenRow*LenCol, 
    assert(board(size, BoardSize)). 


% Assert the maximum value for an element. 
maxBoardAssert(LenRow):-    
    distinct(DistinctWithEmpty),
    Distinct is DistinctWithEmpty - 1,        % We must not count the empty cells.
    board(side, Side), 
    Max is Side * Distinct, 
    assert(board(max, Max)). 

       
