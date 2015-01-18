-module(sync).
-compile([export_all]).

space() ->
    "cfexampleapi".
token() ->
    "b4c0n73n7fu1".

get_sync() ->
    Options = [{"initial", "true"}, {"type","Entry"}],
    contentful:sync(space(), token(), Options).
