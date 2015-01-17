-module(cf_http_helper).
-compile([export_all]).

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

get(Url, Headers, ApiKey) ->
    ParsedHeaders = parse_auth_headers(Headers, ApiKey),
    {ok, StatusCode, _RespHeaders, ClientRef} = do_request(get, Url, ParsedHeaders),
    {ok, Body} = hackney:body(ClientRef),
    {status_code_to_tuple_state(StatusCode), Body}.

get_sync(SpaceID, ApiKey, Options) ->
    get(sync_url(SpaceID, Options), [], ApiKey).

get_space(SpaceID, ApiKey) ->
    get(space_url(SpaceID), [], ApiKey).

get_content_types(SpaceID, ApiKey) ->
    get(content_types_url(SpaceID), [], ApiKey).

get_content_type(SpaceID, ApiKey, ContentTypes) ->
    get(content_type_url(SpaceID, ContentTypes), [], ApiKey).

sync_url(SpaceID, Options) ->
    space_url(SpaceID) ++ "/sync?" ++ sync_options(Options).

sync_options(Options) ->
    string:join([K ++ "=" ++ V || {K, V} <- Options], "&").

space_url(SpaceID) ->
    cda_url() ++ "/spaces/" ++ SpaceID.

content_types_url(SpaceID) ->
    space_url(SpaceID) ++ "/entries?content_types".

content_type_url(SpaceID, ContentTypes) ->
    ContentTypesList = string:join(ContentTypes, ","),
    space_url(SpaceID) ++ "/entries?content_type=" ++ ContentTypesList.

delivery_api_url() ->
    "https://cdn.contentful.com".

cda_url() ->
    delivery_api_url().
