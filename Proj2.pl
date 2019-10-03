:- use_module(library(clpfd)).

%add()
add([], 0).
add([X|Xs], Y):-
    add(Xs, Y1),
    Y #= X + Y1.

multi([], 1).
multi([X|Xs], Y):-
    multi(Xs, Y1),
    Y #= X*Y1.

check([X|Xs]):-
    multi(Xs, X);
    add(Xs, X).

checkList([]).
checkList([X|Xs]):-
    check(X),
    checkList(Xs).

puzzle_solution2(PuzzleR):-
    PuzzleR = [_|Rows], Rows = [As, Bs],
    As = [_, A1, A2], Bs = [_, B1, B2], A1 = B2,
    [A1, A2, B1, B2] ins 1..9,
    checkList(Rows), maplist(all_distinct, Rows),
    transpose(PuzzleR, PuzzleC), PuzzleC = [_|Columns],
    checkList(Columns), maplist(all_distinct, Columns).

/*
puzzle_solution3(PuzzleR):-
    PuzzleR = [_|Rows], Rows = [As, Bs, Cs],
    As = [_, A1, A2, A3], Bs = [_, B1, B2, B3], Cs = [_, C1, C2, C3],
    A1 = B2, B2 = C3,
    [A1, A2, A3, B1, B2, B3, C1, C2, C3] ins 1..9,
    checkList(Rows), maplist(all_distinct, Rows),
    transpose(PuzzleR, PuzzleC), PuzzleC = [_|Columns],
    checkList(Columns), maplist(all_distinct, Columns).*/

puzzle_solution3(PuzzleR):-
    PuzzleR = [_|Rows], Rows = [As, Bs, Cs],
    As = [_, A1, A2, A3], Bs = [_, B1, B2, B3], Cs = [_, C1, C2, C3],
    A1 = B2, B2 = C3,
    [A1, A2, A3, B1, B2, B3, C1, C2, C3] ins 1..9,
    checkList(Rows), maplist(all_distinct, Rows),
    transpose(PuzzleR, PuzzleC), PuzzleC = [_|Columns],
    checkList(Columns), maplist(all_distinct, Columns).

puzzle_solution3(PuzzleR):-
    PuzzleR = [_|Rows], Rows = [As, Bs, Cs],
    As = [_, A1, A2, A3], Bs = [_, B1, B2, B3], Cs = [_, C1, C2, C3],
    A1 = B2, B2 = C3,
    [A1, A2, A3, B1, B2, B3, C1, C2, C3] ins 1..9,
    checkList(Rows), maplist(all_distinct, Rows),
    transpose(PuzzleR, PuzzleC), PuzzleC = [_|Columns],
    checkList(Columns), maplist(all_distinct, Columns).

puzzle_solution4(PuzzleR):-
    PuzzleR = [_|Rows], Rows = [As, Bs, Cs, Ds],
    As = [_, A1, A2, A3, A4], Bs = [_, B1, B2, B3, B4], Cs = [_, C1, C2, C3,C4],
    Ds = [_, D1, D2, D3, D4],
    A1 = B2, B2 = C3, C3 = D4,
    [A1, A2, A3, A4, B1, B2, B3, B4, C1, C2, C3, C4, D1, D2, D3, D4] ins 1..9,
    checkList(Rows), maplist(all_distinct, Rows),
    transpose(PuzzleR, PuzzleC), PuzzleC = [_|Columns],
    checkList(Columns), maplist(all_distinct, Columns).


puzzle_solution(Puzzle):-
    length(Puzzle, N),
    (N =:= 3 ->
        puzzle_solution2(Puzzle)
    ; N =:= 4 ->
        puzzle_solution3(Puzzle)
    ; puzzle_solution4(Puzzle)).
