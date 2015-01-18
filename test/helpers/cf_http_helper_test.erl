-module(cf_http_helper_test).
-include_lib("eunit/include/eunit.hrl").

status_code_to_tuple_state_test() ->
    ?assertEqual(
       cf_http_helper:status_code_to_tuple_state(200), ok),
    ?assertEqual(
       cf_http_helper:status_code_to_tuple_state(300), err),
    ?assertEqual(
       cf_http_helper:status_code_to_tuple_state(400), err),
    ?assertEqual(
       cf_http_helper:status_code_to_tuple_state(500), err).

auth_header_test() ->
    ?assertEqual(
       cf_http_helper:auth_header("ApiKey"),
       {"Authorization", "Bearer ApiKey"}).

parses_auth_headers_test() ->
    ?assertEqual(
       cf_http_helper:parse_auth_headers([], "ApiKey"),
       [{"Authorization", "Bearer ApiKey"}]),
    ?assertEqual(
       cf_http_helper:parse_auth_headers([{"Such","Header"}], "ApiKey"),
       [{"Authorization", "Bearer ApiKey"}, {"Such", "Header"}]).
