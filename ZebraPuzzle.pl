/*** Person's properties ***/
home_color(P, X) :-  P = person(X, _, _, _, _).
nationality(P, X) :- P = person(_, X, _, _, _).
drinks(P, X) :-      P = person(_, _, X, _, _).
smokes(P, X) :-      P = person(_, _, _, X, _).
owns(P, X) :-        P = person(_, _, _, _, X).


/*** List operations ***/
/*size(List, ListSize)*/
size([], 0).
size([_|T], S) :- var(S), size(T, S1), S is S1 + 1.
size([_|T], S) :- nonvar(S), S > 0, S1 is S - 1, size(T, S1), !.

/*indexOf(Element, List, ElementIndex)*/
indexOf(X, L, I) :- size(L, _), indexOf(X, L, I, 0).
indexOf(X, [X|_], I, I).
indexOf(X, [_|T], I, C) :- C1 is C + 1, indexOf(X, T, I, C1).

/*contains(Element, List)*/
contains(X, L) :- indexOf(X, L, _).

/*nextTo(ElementA, ElementB, List)*/
nextTo(A, B, L) :- rightOf(A, B, L).
nextTo(A, B, L) :- rightOf(B, A, L).

/*leftOf(LeftElement, RightElement, List)*/
rightOf(A, B, L) :- indexOf(A, L, IA), indexOf(B, L, IB), IA is IB + 1.



/*** Problem condition's ***/
conditions(Data) :- size(Data, 5),                                                              /*There are five houses.*/
  contains(A, Data), nationality(A, englishman), home_color(A, red),                            /*The Englishman lives in the red house.*/
  contains(B, Data), nationality(B, spaniard), owns(B, dog),                                    /*The Spaniard owns the dog.*/
  contains(C, Data), drinks(C, coffee), home_color(C, green),                                   /*Coffee is drunk in the green house.*/
  contains(D, Data), drinks(D, tea), nationality(D, ukrainian),                                 /*The Ukrainian drinks tea.*/
  rightOf(C, E, Data), home_color(E, ivory),                                                    /*The green house is immediately to the right of the ivory house.*/
  contains(F, Data), smokes(F, oldgold), owns(F, snails),                                       /*The Old Gold smoker owns snails.*/
  contains(G, Data), smokes(G, kool), home_color(G, yellow),                                    /*Kools are smoked in the yellow house.*/
  indexOf(H, Data, 2), drinks(H, milk),                                                         /*Milk is drunk in the middle house.*/
  indexOf(I, Data, 0), nationality(I, norwegian),                                               /*The Norwegian lives in the first house.*/
  nextTo(L, M, Data), smokes(L, chesterfield), owns(M, fox),                                    /*The man who smokes Chesterfields lives in the house next to the man with the fox.*/
  nextTo(N, G, Data), owns(N, horse),                                                           /*Kools are smoked in the house next to the house where the horse is kept.*/
  contains(O, Data), smokes(O, luckystrike), drinks(O, orangejuice),                            /*The Lucky Strike smoker drinks orange juice.*/
  contains(P, Data), nationality(P, japanese), smokes(P, parliament),                           /*The Japanese smokes Parliaments.*/
  nextTo(I, Q, Data), home_color(Q, blue).                                                      /*The Norwegian lives next to the blue house.*/


/*** Answers ***/
water(X) :- conditions(T), contains(P, T), nationality(P,X), drinks(P, water), !.               /*Who drinks water?*/
zebra(X) :- conditions(T), contains(P, T), nationality(P,X), owns(P, zebra), !.                 /*Who owns the zebra?*/
all(T) :- conditions(T), contains(X, T), contains(Y, T), owns(X, zebra), drinks(Y, water), !.   /*Complete solution*/

  