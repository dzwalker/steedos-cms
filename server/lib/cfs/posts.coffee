posts_store

if Meteor.settings.public.cfs.store == "OSS"
  posts_store = new FS.Store.OSS "posts",
      region: Meteor.settings.cfs.aliyun.region
      internal: Meteor.settings.cfs.aliyun.internal
      bucket: Meteor.settings.cfs.aliyun.bucket
      folder: Meteor.settings.cfs.aliyun.folder
      accessKeyId: Meteor.settings.cfs.aliyun.accessKeyId
      secretAccessKey: Meteor.settings.cfs.aliyun.secretAccessKey

else if Meteor.settings.public.cfs.store == "S3"
  posts_store = new FS.Store.S3 "posts",
      region: Meteor.settings.cfs.aws.region
      bucket: Meteor.settings.cfs.aws.bucket
      folder: Meteor.settings.cfs.aws.folder
      accessKeyId: Meteor.settings.cfs.aws.accessKeyId
      secretAccessKey: Meteor.settings.cfs.aws.secretAccessKey



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
