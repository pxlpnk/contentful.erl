-module(cf_json_helper).
-compile([export_all]).


parse(JSON) ->
    jsx:decode(JSON).
