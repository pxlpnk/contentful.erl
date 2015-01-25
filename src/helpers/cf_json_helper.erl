-module(cf_json_helper).
-export([parse/1]).





parse(JSON) ->
    jsx:decode(JSON, [return_maps]).
