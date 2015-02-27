-module(cf_http_helper).
-export([get/2,
         get/3,
         get_sync/3,
         get_space/2,
         get_content_types/2,
         get_content_type/3,
         get_entries/3,
         get_entry/4,
         get_asset/3,
         next_page/2,
         next_sync/2]).

%% Export all functions for unit tests
-ifdef(TEST).
-compile(export_all).
-endif.

get(Url, ApiKey) ->
    get(Url, [], ApiKey).

get(Url, Headers, ApiKey) ->
    ParsedHeaders = parse_auth_headers(Headers, ApiKey),
    {ok, StatusCode, _RespHeaders, ClientRef} = do_request(get, Url, ParsedHeaders),
    {ok, Body} = hackney:body(ClientRef),
    {status_code_to_tuple_state(StatusCode), Body}.

get_sync(SpaceID, ApiKey, Options) ->
    get(cf_url_helper:sync_url(SpaceID, Options), ApiKey).

get_space(SpaceID, ApiKey) ->
    get(cf_url_helper:space_url(SpaceID), ApiKey).

get_content_types(SpaceID, ApiKey) ->
    get(cf_url_helper:content_types_url(SpaceID), ApiKey).

get_content_type(SpaceID, ApiKey, ContentTypes) ->
    get(cf_url_helper:content_type_url(SpaceID, ContentTypes), [], ApiKey).

get_entries(SpaceID, ApiKey, Query) ->
    Url = cf_url_helper:entries_url(SpaceID, Query),
    get(Url, ApiKey).

get_entry(SpaceID, EntryID, ApiKey, Query) ->
    Url = cf_url_helper:entry_url(SpaceID, EntryID, Query),
    get(Url, ApiKey).

next_page(Page, ApiKey) ->
    Url = cf_url_helper:get_next_page_url(Page),
    get(Url, ApiKey).

next_sync(Page, ApiKey) ->
    Url = cf_url_helper:get_next_sync_url(Page),
    get(Url, ApiKey).

get_asset(SpaceID, ApiKey, AssetID) ->
    Url = cf_url_helper:asset_url(SpaceID, AssetID),
    get(Url, ApiKey).

auth_header(ApiKey) ->
    { "Authorization", "Bearer " ++ ApiKey }.

status_code_to_tuple_state(StatusCode) ->
    case round(StatusCode / 100) of
        2 -> ok;
        _ -> err
    end.

parse_auth_headers(Headers, ApiKey) ->
    [auth_header(ApiKey)| Headers].

do_request(Method, Url, Headers) ->
    do_request(Method, Url, Headers, <<>>, []).

do_request(Method, URL, Headers, Payload, Options) ->
    hackney:start(),
    hackney:request(Method, URL, Headers, Payload, Options).
