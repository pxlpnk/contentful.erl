-module(contentful_test).
-include_lib("eunit/include/eunit.hrl").

space() ->
    "cfexampleapi".
wrong_space() ->
    "wrongspace".
token() ->
    "b4c0n73n7fu1".
wrong_token() ->
    "wrongtoken".



space_ok_test() ->
    {Status, _Body} = contentful:space(space(), token()),
    ?assertEqual(Status, ok).

space_wrong_token_test() ->
    {Status, _Body} = contentful:space(space(), wrong_token()),
    ?assertEqual(Status, err).

space_wrong_space_test() ->
    {Status, _Body} = contentful:space(wrong_space(), token()),
    ?assertEqual(Status, err).

content_types_ok_test() ->
    {Status, _Body} = contentful:content_types(space(), token()),
    ?assertEqual(Status, ok).

content_types_wrong_token_test() ->
    {Status, _Body} = contentful:content_types(space(), wrong_token()),
    ?assertEqual(Status, err).

content_types_wrong_space_test() ->
    {Status, _Body} = contentful:content_types(wrong_space(), token()),
    ?assertEqual(Status, err).
