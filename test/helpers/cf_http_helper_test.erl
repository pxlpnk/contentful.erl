-module(cf_http_helper_test).
-include_lib("eunit/include/eunit.hrl").

content_delivery_api_url_test() ->
    ?assertEqual(
       cf_http_helper:delivery_api_url(),
       "https://cdn.contentful.com"),
    ?assertEqual(
       cf_http_helper:cda_url(),
       "https://cdn.contentful.com").

space_url_test() ->
    ?assertEqual(
       cf_http_helper:space_url("SpaceKey"),
       "https://cdn.contentful.com/spaces/SpaceKey").


content_types_url_test() ->
    ?assertEqual(
       cf_http_helper:content_types_url("SpaceKey"),
       "https://cdn.contentful.com/spaces/SpaceKey/entries?content_types").

content_type_url_test() ->
    ?assertEqual(
       cf_http_helper:content_type_url("SpaceKey",["cat","dog"]),
       "https://cdn.contentful.com/spaces/SpaceKey/entries?content_type=cat,dog").

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


sync_options_test() ->
    Options = [{"initial", "true"}, {"type","Entry"}],
    ?assertEqual(
       cf_http_helper:sync_options(Options),
       "initial=true&type=Entry").
