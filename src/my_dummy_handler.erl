-module(my_dummy_handler).
-behaviour(gen_myproto).

-include("../include/myproto.hrl").

-export([check_pass/3, execute/1]).

check_pass(User, Hash, Password) ->
    case my_request:check_clean_pass(User, Hash) of
        Password -> Password;
        _ -> {error, <<"Password incorrect!">>}
    end.

execute(#request{info = <<"select @@version_comment", _/binary>>}) ->
    Info = {
        [#column{name = <<"@@version_comment">>, type=?TYPE_VARCHAR, length=20}],
        [<<"myproto 0.1">>]
    },
    #response{status=?STATUS_OK, info=Info};
execute(_Request) ->
    Info = {
        [#column{name = <<"Info">>, type=?TYPE_VARCHAR, length=20}],
        [<<"Not implemented!">>]
    },
    #response{status=?STATUS_OK, info=Info}.
