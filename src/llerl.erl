-module(llerl).

-export([compile/1]).
-export([compile_file/1]).

compile(Src) when is_binary(Src) ->
  compile(binary_to_list(Src));
compile(Src) ->
  {ok, Tokens, _} = llerl_lexer:string(Src),
  llerl_parser:parse(Tokens).

compile_file(Filename) when is_list(Filename) ->
  {ok, Src} = file:read_file(Filename),
  compile(Src).
