Nonterminals
exprs expr func list.

Terminals
call endcall var boolean integer string float atom startlist endlist.

Rootsymbol expr.

exprs -> expr : ['$1'].
exprs -> expr exprs : ['$1' | '$2'].

expr -> boolean : '$1'.
expr -> integer : '$1'.
expr -> float : '$1'.
expr -> string : '$1'.
expr -> atom : '$1'.
expr -> var : '$1'.
expr -> func : '$1'.
expr -> list : '$1'.

func -> call exprs endcall :
        {call, ?line('$1'), ?value('$1'), '$2'}.
func -> call endcall :
        {call, ?line('$1'), ?value('$1'), []}.

list -> startlist exprs endlist : '$2'.
list -> startlist endlist : [].

Erlang code.

%% Keep track of line info in tokens.
-define(line(Tup), element(2, Tup)).
-define(value(Tup), element(3, Tup)).
