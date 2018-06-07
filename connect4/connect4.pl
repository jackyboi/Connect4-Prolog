:- consult(moves).
:- consult(win_conditions).
:- consult(opponent).

init_board([
    ['-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-'],
    ['-', '-', '-', '-', '-', '-']
]).

% Loop through all 6 rows (columns of Board object) and print separately
show(Board) :-
    show(Board, 6),
    nl.
show(_, 0).
show(Board, N) :-
    show_row(Board, NewBoard),
    nl,
    N2 is N - 1,
    show(NewBoard, N2).

show_row([], []).
show_row([[A|B]|C], [B|D]) :-
    write(A),
    write(' '),
    show_row(C, D).

% Win condition
play(Board, Player) :-
    win(Board, Player),
    write(Player),
    write(" wins!"),
    nl,
    halt.

play(Board, 'X') :-

    % Read in column choice
    write("Enter column: "),
    nl,
    read(N),
    Choice is N - 1,

    % If valid column choice
    % Make the move and return the new board
    % Else, try again
    (  valid(Choice)
    -> make_move(Board, Choice, 'X', NewBoard)
    ;  play(Board, 'X')
    ),

    % Display board, check for win conditions, and play again
    show(NewBoard),
    play(NewBoard, 'O').

play(Board, 'O') :-
    write("Opponent chooses column: "),
    opponent_move(Board, Index),
    make_move(Board, Index, 'O', NewBoard),
    Col is Index + 1,
    write(Col),
    nl,
    show(NewBoard),
    play(NewBoard, 'X').

begin :-
    init_board(Board),
    show(Board),
    play(Board, 'X').

:- initialization(begin).