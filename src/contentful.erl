-module(contentful).
-export([space/2, content_types/2]).
-compile([export_all]).

space(SpaceID, ApiKey) ->
    {Status, JSON} = cf_http_helper:get_space(SpaceID, ApiKey),
    {Status, cf_json_helper:parse(JSON)}.

content_types(SpaceID, ApiKey) ->
    {Status, JSON} = cf_http_helper:get_content_types(SpaceID, ApiKey),
    {Status, cf_json_helper:parse(JSON)}.

content_type(SpaceID, ApiKey, ContentTypes) ->
    {Status, JSON} = cf_http_helper:get_content_type(SpaceID, ApiKey, ContentTypes),
    {Status, cf_json_helper:parse(JSON)}.
