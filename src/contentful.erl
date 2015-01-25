-module(contentful).
-export([space/2, content_types/2, entries/3, sync/3, next_page/2, next_sync/2]).

space(SpaceID, ApiKey) ->
    {Status, JSON} = cf_http_helper:get_space(SpaceID, ApiKey),
    {Status, cf_json_helper:parse(JSON)}.

content_types(SpaceID, ApiKey) ->
    {Status, JSON} = cf_http_helper:get_content_types(SpaceID, ApiKey),
    {Status, cf_json_helper:parse(JSON)}.

content_type(SpaceID, ApiKey, ContentTypes) ->
    {Status, JSON} = cf_http_helper:get_content_type(SpaceID, ApiKey, ContentTypes),
    {Status, cf_json_helper:parse(JSON)}.

%% Query: [{"K","V"}, {"k","v"}] or [{"K",{list,["a","b","c"]}}]
entries(SpaceID, ApiKey, Query) ->
    {Status, JSON} = cf_http_helper:get_entries(SpaceID, ApiKey, Query),
    {Status, cf_json_helper:parse(JSON)}.

sync(SpaceID, ApiKey, Options) ->
    {Status, JSON} = cf_http_helper:get_sync(SpaceID, ApiKey, Options),
    {Status, cf_json_helper:parse(JSON)}.

next_page(Page, ApiKey) ->
    {Status, JSON} = cf_http_helper:next_page(Page, ApiKey),
    {Status, cf_json_helper:parse(JSON)}.

next_sync(Page, ApiKey) ->
    {Status, JSON} = cf_http_helper:next_sync(Page, ApiKey),
    {Status, cf_json_helper:parse(JSON)}.
