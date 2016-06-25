CMS.helpers =
	Posts: (limit, skip)->
		if !limit 
			limit = 5
		skip = 0
		siteId = Session.get("siteId")
		tag = Session.get("siteTag")
		siteCategoryId = Session.get("siteCategoryId")

		if siteId and tag
			return db.cms_posts.find({site: siteId, tags: tag}, {sort: {postDate: -1}, limit: limit, skip: skip})
		else if siteId and siteCategoryId
			return db.cms_posts.find({site: siteId, category: siteCategoryId}, {sort: {postDate: -1}, limit: limit, skip: skip})
		else if siteId
			return db.cms_posts.find({site: siteId}, {sort: {postDate: -1}, limit: limit, skip: skip})
	
	PostsCount: ()->
		siteId = Session.get("siteId")
		tag = Session.get("siteTag")
		siteCategoryId = Session.get("siteCategoryId")

		if siteId and tag
			return db.cms_posts.find({site: siteId, tags: tag}).count()
		else if siteId and siteCategoryId
			return db.cms_posts.find({site: siteId, category: siteCategoryId}).count()
		else if siteId
			return db.cms_posts.find({site: siteId}).count()
		else
			return 0
	

	Post: ()->
		postId = FlowRouter.current().params.postId
		if postId
			return db.cms_posts.findOne({_id: postId})

	SpaceUserName: (userId)->
		su = db.space_users.findOne({user: userId})
		return su?.name

	PostURL: (postId)->
		siteId = Session.get("siteId")
		if siteId
			siteCategoryId = Session.get("siteCategoryId")
			tag = Session.get("siteTag")
			if siteCategoryId
				return "/cms/" + siteId + "/c/" +  siteCategoryId + "/p/" + postId
			else if tag
				return "/cms/" + siteId + "/t/" +  tag + "/p/" + postId
			else
				return "/cms/" + siteId + "/p/" + postId

	PostSummary: ->
		if this.body
			return this.body.substring(0, 200)

	Attachments: ()->
		postId = FlowRouter.current().params.postId
		if postId
			post = db.cms_posts.findOne({_id: postId})
			if post and post.attachments
				return cfs.sites.find({_id: {$in: post.attachments}}).fetch()

	CategoryId: ()->
		return Session.get("siteCategoryId")

	CategoryActive: (categoryId)->
		if Session.get("siteCategoryId") == categoryId
			return "active"

	Category: ()->
		siteCategoryId = Session.get("siteCategoryId")
		if siteCategoryId
			return db.cms_categories.findOne(siteCategoryId)

	ParentCategory: ()->
		siteCategoryId = Session.get("siteCategoryId")
		if siteCategoryId
			c = db.cms_categories.findOne(siteCategoryId)
			if c?.parent
				return db.cms_categories.findOne(c.parent)

	SubCategories: (parent)->
		if parent
			return db.cms_categories.find({parent: parent})
		else
			return db.cms_categories.find({parent: null})
			
	SubCategoriesCount: (parent)->
		return db.cms_categories.find({parent: parent}).count()

	SiteId: ->
		siteId = Session.get("siteId")
		return siteId

	Sites: ->
		return db.cms_sites.find()

	Site: ->
		siteId = Session.get("siteId")
		if siteId
			return db.cms_sites.findOne({_id: siteId})

	Tags: ->
		siteId = Session.get("siteId")
		if siteId
			return db.cms_tags.find({site: siteId})
	Tag: ->
		tag = Session.get("siteTag")
		return tag

	Markdown: (text)->
		if text
			return Spacebars.SafeString(Markdown(text))

	PostCanEdit: ()->
		postId = Session.get("postId")
		if postId
			post = db.cms_posts.findOne(postId)
			if post?.created_by == Meteor.userId()
				return true;