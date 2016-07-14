posts_store

if Meteor.settings.public.cfs.store == "OSS"
  posts_store = new FS.Store.OSS("posts")
else if Meteor.settings.public.cfs.store == "S3"
  posts_store = new FS.Store.S3("posts")


cfs.posts = new FS.Collection "posts",
    stores: [posts_store]


cfs.posts.allow
  insert: (userId, doc) ->
    true
  update: (userId, doc) ->
    true
  remove: (userId, doc) ->
    true
  download: (userId)->
    true
