-module(llerl).

-export([compile/1]).

compile(Filename) when is_list(Filename) ->
  {ok, Src} = file:read_file(Filename),
  compile(Src);
compile(Src) when is_binary(Src) ->
  {ok, Tokens, _} = llerl_lexer:string(binary_to_list(Src)),
  llerl_parser:parse(Tokens).
