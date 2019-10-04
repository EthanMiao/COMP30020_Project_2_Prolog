/* Author: Zhuoping Miao
 * Student ID: 813791
 * Purpose: Solving a maths puzzle which is a square grid of squares,
 * each to be filled in with a single digit 1–9 (zero is not permitted)
 * satisfying these constraints:
 * 1: each row and each column contains no repeated digits
 * 2: all squares on the diagonal line from upper left to lower right
 *    contain the same value
 * 3: the heading of reach row and column
 *    (leftmost square in a row and topmost square in a column) holds
 *    either the sum or the product of all the digits in that row or column
 */

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Import SWI library clpfd
:- use_module(library(clpfd)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*take input of Puzzle as a list of lists
 *find a solution which satisfied all predicates
 */
puzzle_solution(Rows):-
    %make sure all elements on diagonal have the same value
	same_diagonal(Rows),

	%resolve for rows
	range_distinct(Rows),find_value(Rows),

	%tranpose the puzzle matrix from rows to columns
	transpose(Rows, Columns),

	%resolve for columns
	range_distinct(Columns),find_value(Columns),

	%use append to flatten the array
	append(Rows,Solution),

    %use label to systematically trying out values for the
    %finite domain variables Vars until all of them are ground
	label(Solution).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% implement functions to find valid value for the puzzle by checking
% the sum rule and product rule
% add/2, multi/2, check/1 are helper functions for find_value/1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*check whether the sum of all elements in List is equal to Head or not.
 */
add([], 0).
add([X|Xs], Y):-
    add(Xs, Y1),
    Y #= X + Y1.

/**************************************************************************/

/*check whether the product of all elements in List is equal to Head or not.
 */
multi([], 1).
multi([X|Xs], Y):-
    multi(Xs, Y1),
    Y #= X*Y1.

/**************************************************************************/

/*check whether X is equal to the sum or product of all elements in List Xs
 */
check([X|Xs]):-
    multi(Xs, X);
    add(Xs, X).

/**************************************************************************/

/*find valid value to solve the puzzle
 *input is puzzle's rows or columns(getting by using function transpose)
 *skip the heading and apply function check to the remaining rows
 */
find_value([_|Xs]):-
    maplist(check, Xs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% check all elements needed to solve the puzzle are in range 1-9 and distinct
% range_distinct0/1 is helper function for range_distinct/1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*check all elements inside one row of Puzzle (except the head) are both
 *in the range of 1 to 9 and distinct
 */
range_distinct0([_|Xs]):-
    all_distinct(Xs),
    Xs ins 1..9.

/**************************************************************************/

/*remove the heading
 *apply range and distinct check to the remaining rows
 */
range_distinct([_|Xs]):-
    maplist(range_distinct0, Xs).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% make sure all elements on the diagonal are same
% extract_diagonal/4 and same/1 are helper functions for same_diagonal/1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/*extract all elements on the diagonal and store in Result
 */
extract_diagonal([], _, Diagonal, Result):-
    Result = Diagonal.
extract_diagonal([X|Xs], Index, Diagonal, Result):-
    nth0(Index, X, Elem),
    Index1 #= Index + 1,
    append([Elem], Diagonal, Diagonal1),
    extract_diagonal(Xs, Index1, Diagonal1, Result).

/**************************************************************************/

/*make sure all elements in the List are same
 */
same([_]).
same([X,X|Xs]):-
    same([X|Xs]).

/**************************************************************************/

/*make sure all elements on the diagonal are same
 */
same_diagonal([_|Xs]):-
    extract_diagonal(Xs, 1, [], Result),
    same(Result).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
