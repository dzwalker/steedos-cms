db.cms_sites = new Meteor.Collection('cms_sites')

db.cms_sites._simpleSchema = new SimpleSchema
	space: 
		type: String,
		autoform: 
			type: "hidden",
			defaultValue: ->
				return Session.get("spaceId");
	# theme: 
	# 	type: String,
	# 	autoform: 
	# 		type: "select",
	# 		options: ->
	# 			options = []
	# 			objs = db.cms_themes.find()
	# 			objs.forEach (obj) ->
	# 				options.push
	# 					label: obj.name,
	# 					value: obj._id
	# 			return options
	type:
		type: String,
		defaultValue: "space",
		allowedValues: ["space", "user"]
		autoform: 
			omit: true

	name: 
		type: String,
		optional: true,

	description: 
		type: String,
		optional: true,
		autoform: 
			rows: 3

	anonymous:
		type: Boolean,
		defaultValue: true
		autoform:
			omit: true

	cover:
		type: String,
		optional: true,
		autoform:
			type: 'fileUpload'
			collection: 'avatars'
			accept: 'image/*'
	avatar:
		type: String,
		optional: true,
		autoform:
			type: 'fileUpload'
			collection: 'avatars'
			accept: 'image/*'
	owner: 
		type: String,
		optional: true,
		autoform:
			omit: true
			type: "selectuser"
			defaultValue: ->
				return Meteor.userId()

	order: 
		type: Number,
		optional: true,

	layout: 
		type: String,
		optional: true,
		autoform: 
			rows: 10
			type: ()->
				spaceId = Session.get("spaceId")
				if spaceId
					space = db.spaces.findOne(spaceId)
					if space?.is_paid
						return "textarea"
				return "hidden"
	created:
		type: Date,
		optional: true
	created_by:
		type: String,
		optional: true
	modified:
		type: Date,
		optional: true
	modified_by:
		type: String,
		optional: true

if Meteor.isClient
	db.cms_sites._simpleSchema.i18n("cms_sites")

db.cms_sites.attachSchema(db.cms_sites._simpleSchema)

if Meteor.isServer
	
	db.cms_sites.before.insert (userId, doc) ->

		doc.created_by = userId
		doc.created = new Date()
		doc.modified_by = userId
		doc.modified = new Date()
		
		if !userId
			throw new Meteor.Error(400, t("cms_sites_error.login_required"));

		doc.owner = userId
		doc.admins = [userId]


	db.cms_sites.after.insert (userId, doc) ->
			

	db.cms_sites.before.update (userId, doc, fieldNames, modifier, options) ->
		modifier.$set = modifier.$set || {};

		# only site owner can modify site
		if doc.owner != userId
			throw new Meteor.Error(400, t("cms_sites_error.site_owner_only"));

		modifier.$set.modified_by = userId;
		modifier.$set.modified = new Date();