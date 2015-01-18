-module(cf_url_helper_test).
-include_lib("eunit/include/eunit.hrl").

content_delivery_api_url_test() ->
    ?assertEqual(
       cf_url_helper:delivery_api_url(),
       "https://cdn.contentful.com"),
    ?assertEqual(
       cf_url_helper:cda_url(),
       "https://cdn.contentful.com").

space_url_test() ->
    ?assertEqual(
       cf_url_helper:space_url("SpaceKey"),
       "https://cdn.contentful.com/spaces/SpaceKey").


content_types_url_test() ->
    ?assertEqual(
       cf_url_helper:content_types_url("SpaceKey"),
       "https://cdn.contentful.com/spaces/SpaceKey/entries?content_types").

content_type_url_test() ->
    ?assertEqual(
       cf_url_helper:content_type_url("SpaceKey",["cat","dog"]),
       "https://cdn.contentful.com/spaces/SpaceKey/entries?content_type=cat,dog").

options_test() ->
    Options = [{"initial", "true"}, {"type","Entry"}],
    ?assertEqual(
       cf_url_helper:options(Options),
       "initial=true&type=Entry").

params_test() ->
    ?assertEqual(
       cf_url_helper:params("Key", "Value"),
       "Key=Value").
