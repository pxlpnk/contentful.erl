-module(entries).
-compile([export_all]).

space() ->
    "cfexampleapi".
token() ->
    "b4c0n73n7fu1".


get() ->
    Params =[{"content_type",{list, ["cat","dog"]}}],
    cf_http_helper:get_entries(space, token, Params).

get_cat_dog_content_types()->
    Params = [{"content_type",{list, ["cat","dog"]}}],
    cf_http_helper:get_sync(space, token, Params).
