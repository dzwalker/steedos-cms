CMS.helpers =

	SpaceUserName: (userId)->
		su = db.space_users.findOne({user: userId})
		return su?.name

	SpaceName: ()->
		spaceId = Steedos.getSpaceId()
		if spaceId
			space = db.spaces.findOne(spaceId)
			if space
				return space.name

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
	

	PostId: ()->
		return FlowRouter.current().params.postId

	Post: ()->
		postId = FlowRouter.current().params.postId
		if postId
			return db.cms_posts.findOne({_id: postId})

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
			return this.body.substring(0, 400)

	PostImage: (postId)->
		if postId
			post = db.cms_posts.findOne({_id: postId})
			if post?.images?.length>0
				return post.images[0]

	PostImages: ()->
		postId = FlowRouter.current().params.postId
		if postId
			post = db.cms_posts.findOne({_id: postId})
			if post?.images?.length>0
				return cfs.posts.find({_id: {$in: post.images}}).fetch()

	PostAttachments: ()->
		postId = FlowRouter.current().params.postId
		if postId
			post = db.cms_posts.findOne({_id: postId})
			if post and post.attachments
				return cfs.posts.find({_id: {$in: post.attachments}}).fetch()

	CategoryId: ()->
		return Session.get("siteCategoryId")

	CategoryActive: (categoryId)->
		if !categoryId and !Session.get("siteCategoryId")
			return "active"
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
			return db.cms_categories.find({parent: parent}, {sort: {order: 1, created: 1}})
		else
			return db.cms_categories.find({parent: null}, {sort: {order: 1, created: 1}})
			
	SubCategoriesCount: (parent)->
		if parent
			return db.cms_categories.find({parent: parent}).count()
		else
			return db.cms_categories.find({parent: null}).count()

	SiteId: ->
		siteId = Session.get("siteId")
		return siteId

	Sites: ->
		return db.cms_sites.find({}, {sort: {order: 1, created: 1}})

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
		return false;