-module(space).
-compile([export_all]).

get_error_space() ->
    cf_http_helper:get_space("cfexampleapi", "b4c0n73n7fu1a").

get_space() ->
    cf_http_helper:get_space("cfexampleapi", "b4c0n73n7fu1").

parse_space() ->
    {Status, Json} = get_space(),
    {Status, cf_json_helper:parse(Json)}.

parse_error_space() ->
    {Status, Json} = get_error_space(),
    {Status, cf_json_helper:parse(Json)}.

get_content_types() ->
    {Status, Json} = cf_http_helper:get_content_types("cfexampleapi", "b4c0n73n7fu1"),
    {Status, cf_json_helper:parse(Json)}.

sp_get_contet_types() ->
    contentful:content_type("cfexampleapi", "b4c0n73n7fu1", ["cat"]).

sync_initial_true_cat() ->
    Options = [{"initial", "true"}, {"type","Entry"}],
    contentful:sync("cfexampleapi", "b4c0n73n7fu1", Options).
