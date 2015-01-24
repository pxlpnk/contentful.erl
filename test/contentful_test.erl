-module(contentful_test).
-include_lib("eunit/include/eunit.hrl").

space() ->
    "cfexampleapi".
wrong_space() ->
    "wrongspace".
token() ->
    "b4c0n73n7fu1".
wrong_token() ->
    "wrongtoken".

space_ok_test() ->
    {Status, _Body} = contentful:space(space(), token()),
    ?assertEqual(Status, ok).

space_wrong_token_test() ->
    {Status, _Body} = contentful:space(space(), wrong_token()),
    ?assertEqual(Status, err).

space_wrong_space_test() ->
    {Status, _Body} = contentful:space(wrong_space(), token()),
    ?assertEqual(Status, err).

content_types_ok_test() ->
    {Status, _Body} = contentful:content_types(space(), token()),
    ?assertEqual(Status, ok).

content_types_wrong_token_test() ->
    {Status, _Body} = contentful:content_types(space(), wrong_token()),
    ?assertEqual(Status, err).

content_types_wrong_space_test() ->
    {Status, _Body} = contentful:content_types(wrong_space(), token()),
    ?assertEqual(Status, err).

entries_test() ->
    Params = [{"content_type",{list, ["cat"]}}],
    {Status, _Body} = contentful:entries(space(), token(), Params),
    ?assertEqual(ok, Status).

entries_equality_test() ->
    Params = [{"sys.id","nyancat"}],
    {Status, _Body} = contentful:entries(space(), token(), Params),
    ?assertEqual(ok, Status).

entries_inequality_test() ->
    Params = [{"sys.id[ne]","nyancat"}],
    {Status, _Body} = contentful:entries(space(), token(), Params),
    ?assertEqual(ok, Status).

entries_fields_test() ->
    Params = [{"content_type","cat"},{"fields.likes","lasagna"}],
    {Status, _Body} = contentful:entries(space(), token(), Params),
    ?assertEqual(ok, Status).

entries_inclusion_test() ->
    Params = [{"sys.id[in]",{ list, ["finn","jake"] } }],
    {Status, _Body} = contentful:entries(space(), token(), Params),
    ?assertEqual(ok, Status).

entries_exclusion_test() ->
    [{"content_type","cat"}, {"fields.likes[nin]", {list, ["rainbows","lasagna"]}}],
    Params = [{"sys.id[in]",{ list, ["finn","jake"] } }],
    {Status, _Body} = contentful:entries(space(), token(), Params),
    ?assertEqual(ok, Status).
