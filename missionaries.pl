%this is a bad representation because it has extra info.
%we don't need to know the number on right bank because
%it is just 3-left bank
%my state is (MissionariesOnLeft,CannibalsOnLeft,PositionOfBoat)
%so my start state will look like (3,3,left) and end will be
%(0,0,right).

start((3,3,left)).
finish((0,0,right)).

% (3,3,left)->x(1,3,right),(2,2,right),(3,1,right),x(2,3,right),(3,2,right)
% (1,1,right)->(3,1,left),(2,2,left),x(1,3,left),(2,1,left),x(1,2,left)

next((M,C,left),(M2,C2,right),cross(DM,DC)):-
    between(0,3,M2),
    between(0,3,C2),
    M2=<M,
    C2=<C,
    (M2>=C2;M2=0),
    MR is 3-M2,
    CR is 3-C2,
    (MR>=CR;MR=0),
    DM is M-M2,
    DC is C-C2,
    D is DC+DM,
    between(1,2,D).

next((M,C,right),(M2,C2,left),cross(DM,DC)):-
    between(0,3,M2),
    between(0,3,C2),
    M2>=M,
    C2>=C,
    (M2>=C2;M2=0),
    MR is 3-M2,
    CR is 3-C2,
    (MR>=CR;MR=0),
    DM is M2-M,
    DC is C2-C,
    D is DC+DM,
    between(1,2,D).

search(EndState,EndState,_,[]).
search(A,B,PreviouslyVisited,[Move|Moves]):-
    next(A,C,Move),
    \+member(C,PreviouslyVisited),
    search(C,B,[C|PreviouslyVisited],Moves),!.

missionaries(Moves) :- start(A),finish(B),search(A,B,[A|[]],Moves).



