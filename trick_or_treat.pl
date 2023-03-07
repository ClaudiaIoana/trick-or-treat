%TEXT: Five boys are trick-or-treating side by side in their neighborhood. 
%	Each one is wearing a costume, has a bag and a favorite candy. 
%	Figure out which costume Darrell is wearing.
%1. The oldest boy is at the third position.
%2. The Vampire is somewhere between the boy that has the Black bag and the Wizard, 
%in that order.
%3. Naomi's son is exactly to the right of the 8 years boy.
%4. At the fifth position is the boy who likes Jelly bean.
%5. The Magician is next to the boy that likes Lollipop.
%6. The boy who likes Jelly bean has the Blue bag.
%7. In the middle is the boy that likes Lollipop.
%8. Lewis is somewhere to the right of the boy that has the Green bag.
%9. The boy that likes Bubble gum is somewhere between Justin and the Vampire, in that order.
%10. The 9-year-old boy is Naomi's son.
%11. The Pirate is next to the boy who likes Jelly bean.
%12. Alvin is somewhere to the right of the boy who has the White bag.
%13. Eleanor's son is next to the youngest boy.
%14. Terry is immediately before the Wizard.
%15. The boy that has the Green bag is somewhere between the 6-year-old boy and the Wizard, 
%in that order.
%16. Brenda's son is next to Whitney's son.
%17. The boy that has the Green bag is somewhere to the left of Alvin.
%18. Alvin is next to the boy who likes Taffy.
%19. Whitney's son is somewhere to the right of the boy that has the White bag.

:- use_rendering(table,
		 [header(child('Bag','Name','Costume','Candy','Age','Mother' ))]).

somewhereLeft(A, B, R):- append(_, [A, B|_], R).
somewhereLeft(A, B, R):- append(_, [A, _, B|_], R).
somewhereLeft(A, B, R):- append(_, [A, _, _, B|_], R).
somewhereLeft(A, B, R):- append(_, [A, _, _, _, B|_], R).

somewhereBetween(A, B, C, R):- somewhereLeft(A, B, R), 
    somewhereLeft(B, C, R).

nextTo(A, B, R):-append(_,[B,A|_], R).
nextTo(A, B, R):-append(_,[A,B|_], R).
    
nextToLeft(A, B, R):- append(_, [A,B|_], R).

children(Children):-
    length(Children, 5),
    Children = [_,_,child(_,_,_,_,10,_),_,_],	%1
    nextToLeft(child(_, _, _, _, 8, _), child(_, _, _, _, 9, naomi),Children),   %3, 10
    Children = [_, _, _, _, child(blue-bag, _, _, jelly-bean, _, _)],	%4, 6
    Children = [_, _, child(_, _, _, lollipop, _, _), _, _],	%7
    nextTo(child(_, _, magician, _, _, _), child(_, _, _, lollipop, _, _), Children),	%5
    nextTo(child(_, _, pirate, _, _, _), child(_, _, _, jelly-bean, _, _), Children),	%11
    Youngest = child(_, _, _, _, 6, _),
    nextTo(Youngest, child(_, _, _, _, _, eleanor), Children),	%13
    nextToLeft(child(_, terry, _, _, _, _), child(_, _, wizard, _, _, _), Children),	%14
    nextTo(child(_, _, _, _, _, brenda), child(_, _, _, _, _, whitney), Children),	 %16
    nextTo(child(_, alvin, _, _, _, _), child(_, _, _, taffy, _, _), Children),		%18
    somewhereBetween(child(black-bag, _, _, _, _, _), child(_, _, vampire, _, _, _), child(_, _, wizard, _, _, _), Children), 	%2
    somewhereLeft(child(green-bag, _, _, _, _, _), child(_, lewis, _, _, _, _), Children),		%8
    somewhereBetween(child(_, justin, _, _, _, _), child(_, _, _, bubble-gum, _, _), child(_, _, vampire, _, _, _), Children), 	%9
    somewhereLeft(child(white-bag, _, _, _, _, _), child(_, alvin, _, _, _, _), Children), 	%12
    somewhereBetween(child(_, _, _, _, 6, _), child(green-bag, _, _, _, _, _), child(_, _, wizard, _, _, _), Children), 	%15
    somewhereLeft(child(green-bag, _, _, _, _, _), child(_, alvin, _, _, _, _), Children), 	%17
    somewhereLeft(child(white-bag, _, _, _, _, _), child(_, _, _, _, _, whitney), Children), 	%19
    member(child(red-bag, _, _, _, _, _),Children),
    member(child(_, darrell, _, _, _, _), Children),
    member(child(_, _, cowboy, _, _, _), Children),
    member(child(_, _, _, stick-candy, _, _), Children),
    member(child(_, _, _, _, 7, _), Children),
    member(child(_, _, _, _, _, katherina), Children), !.

    
costume(Costume):-
    children(Children),
    member(child(_, darrell, Costume, _, _,_), Children), !.

test:-
    G = [child(black-bag,justin,cowboy,stick-candy,6,katherina), 
        child(green-bag,darrell,magician,bubble-gum,7,eleanor), 
        child(white-bag,lewis,vampire,lollipop,10,brenda), 
        child(red-bag,terry,pirate,taffy,8,whitney),
        child(blue-bag,alvin,wizard,jelly-bean,9,naomi)],
    children(G),
    Cos = magician,
    costume(Cos).
	
