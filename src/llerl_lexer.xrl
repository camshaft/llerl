Definitions.

D = [0-9]
L = [a-z]
U = [A-Z]
A = [^']
S = ({L}|{U})
V = ({L}|\_)
WS = (\s|\t|\r|\n|,)

Rules.

true          : {token,{boolean,TokenLine,true}}.
false         : {token,{boolean,TokenLine,false}}.
'{A}*'        : S = strip(TokenChars,TokenLen),
                {token,{string,TokenLine,list_to_binary(S)}}.
{V}+          : {token,{atom,TokenLine,atom(TokenChars)}}.
/{V}+         : {token,{var,TokenLine,var(TokenChars)}}.
{V}+/{V}+     : {token,{var,TokenLine,var(TokenChars)}}.
{V}+\(        : {token,{call,TokenLine,mod(TokenChars)}}.
{V}+\.{V}+\(  : {token,{call,TokenLine,mod(TokenChars)}}.
{D}+          : {token,{integer,TokenLine,list_to_integer(TokenChars)}}.
{D}+\.{D}+    : {token,{float,TokenLine,list_to_float(TokenChars)}}.
[)]           : {token,{endcall,TokenLine}}.
\[            : {token,{startlist,TokenLine}}.
\]            : {token,{endlist,TokenLine}}.
#[^\r\n]*     : skip_token.
{WS}+         : skip_token.

Erlang code.

-export([atom/1]).
-export([strip/2]).
-export([mod/1]).
-export([var/1]).

atom(TokenChars) -> list_to_atom(TokenChars).

strip(TokenChars,TokenLen) ->
  lists:sublist(TokenChars, 2, TokenLen - 2).

mod(TokenChars) ->
  case string:tokens(string:strip(TokenChars, right, $(), ".") of
    [Fun] ->
      {global, atom(Fun)};
    [Module, Fun] ->
      {atom(Module), atom(Fun)}
  end.

var(TokenChars) ->
  case string:tokens(TokenChars, "/") of
    [Var] ->
      {global, atom(Var)};
    [NS, Var] ->
      {atom(NS), atom(Var)}
  end.
