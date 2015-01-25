-module(cf_url_helper).
-export([entries_url/2,
         content_types_url/1,
         content_type_url/2,
         space_url/1,
         sync_url/2,
         params/1]).

%% Export all functions for unit tests
-ifdef(TEST).
-compile(export_all).
-endif.

sync_url(SpaceID, SyncOptions) ->
    space_url(SpaceID) ++ "/sync?" ++ params(SyncOptions).

space_url(SpaceID) ->
    cda_url() ++ "/spaces/" ++ SpaceID.

content_types_url(SpaceID) ->
    space_url(SpaceID) ++ "/entries?" ++ params([{"content_types",""}]).

content_type_url(SpaceID, ContentTypes) ->
    space_url(SpaceID) ++ "/entries?" ++ params([{"content_type",{list,ContentTypes}}]).

entries_url(SpaceID, Query) ->
    Path = params(Query),
    space_url(SpaceID) ++ "/entries?" ++ Path.

delivery_api_url() -> "https://cdn.contentful.com".

cda_url() -> delivery_api_url().

params(List) ->
    Params = params_generator(List),
    string:join(Params, "&").

params_generator([]) ->
    "";
params_generator([Head|Tail]) ->
    String = params_string(Head),
    U = params_generator(Tail),
    [String | U].

params_string({K, {list, List}}) ->
    ParamsList = string:join(List, ","),
    params_string({K, ParamsList});
params_string({K,""}) ->
    K;
params_string({K, V}) ->
    K ++ "=" ++ V.

get_next_sync_url(#{<<"nextSyncUrl">> := Url}) ->
    Url.

get_next_page_url(#{<<"nextPageUrl">> := Url}) ->
    Url.
