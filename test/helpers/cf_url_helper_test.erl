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

params_string_test() ->
    Params = {"Key", "Value"},
    ?assertEqual(
       cf_url_helper:params_string(Params),
       "Key=Value").

params_string_empty_value_test() ->
    Params = {"Key", ""},
    ?assertEqual(
       cf_url_helper:params_string(Params),
       "Key").

params_string_list_test() ->
    Params = {"K",{list,["a","b","c"]}},
    ?assertEqual(
       cf_url_helper:params_string(Params),
       "K=a,b,c").

params_test() ->
    Params = [{"Key", "Value"}],
    ?assertEqual(
       "Key=Value",
       cf_url_helper:params(Params)
      ).

params_list_test() ->
    Params = [{"K","V"}, {"k","v"}],
    ?assertEqual(
       "K=V&k=v",
       cf_url_helper:params(Params)
      ).

params_array_test() ->
    Params = [{"K",{list,["a","b","c"]}}],
    ?assertEqual(
       "K=a,b,c",
       cf_url_helper:params(Params)
      ).

params_list_list_test() ->
    Params = [{"K1","V1"}, {"K",{list,["a","b","c"]}}],
    ?assertEqual(
       "K1=V1&K=a,b,c",
       cf_url_helper:params(Params)
      ).
