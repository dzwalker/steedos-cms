cfs.posts = new FS.Collection("posts",
  stores: [new FS.Store.FileSystem("posts")]
)

cfs.posts.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc) ->
    true
  remove: (userId, doc) ->
    true
  download: (userId)->
    true
