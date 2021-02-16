
flatten(List, RetList):- flatten(List, RetList, []). 
flatten([], Final, Final):- !. 
flatten([Element|List], [Element|Flatten], Final):- 
    \+is_list(Element),!, 
    flatten(List, Flatten, Final). 
flatten([Element|List], Flatten, Final):-
    flatten(Element, Flatten, Final_1), 
    flatten(List, Final_1, Final).