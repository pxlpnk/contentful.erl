-module(cf_url_helper).
-compile([export_all]).
%% -export([sync_url/2, space_url/1, content_types_url/1 content_type_url/2,
%%         delivery_api_url/0, cda_url/0, params/2, options/1]).

sync_url(SpaceID, Options) ->
    space_url(SpaceID) ++ "/sync?" ++ options(Options).

space_url(SpaceID) ->
    cda_url() ++ "/spaces/" ++ SpaceID.

content_types_url(SpaceID) ->
    space_url(SpaceID) ++ "/entries?content_types".

content_type_url(SpaceID, ContentTypes) ->
    ContentTypesList = string:join(ContentTypes, ","),
    space_url(SpaceID) ++ "/entries?" ++ params("content_type", ContentTypesList).

delivery_api_url() -> "https://cdn.contentful.com".

cda_url() -> delivery_api_url().

params(K,V) -> K ++ "=" ++ V.

options_to_param_list(Options) ->
    lists:foldr(fun({K, V}, Params) -> [params(K, V)|Params] end, [], Options).

options(Options) ->
    ParamList = options_to_param_list(Options),
    string:join(ParamList, "&").
