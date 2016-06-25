Meteor.methods
	cms_init: (spaceId)->
		if !spaceId 
			return false;
		space = db.spaces.findOne(spaceId)
		if !space 
			return false;
		site = db.cms_sites.findOne({space: spaceId})
		if site
			return false;

		siteId = db.cms_sites.insert
			space: spaceId
			name: space.name
			owner: space.owner

		owner = db.users.findOne(space.owner)

		TEMPATE_CATEGORIES = ["Announcements", "Regulations", "Knowledge Base", "News"]
		if owner?.locale == "zh-cn"
			TEMPATE_CATEGORIES = ["公告通知", "规章制度", "知识库", "新闻动态"]
		
		order = 10
		categoryIds = []
		_.each TEMPATE_CATEGORIES, (c)->
			categoryId = db.cms_categories.insert
				space: spaceId
				site: siteId
				name: c
				order: order
			categoryIds.push(categoryId)
			order += 10

		TEMPLATE_POST_TITLE = "Welcome to Steedos Blogs"
		TEMPLATE_POST_BODY = "You can read and share posts with your colleagues, Space admins can manage categories."
		if owner?.locale == "zh-cn"
			TEMPLATE_POST_TITLE = "欢迎使用博客应用"
			TEMPLATE_POST_BODY = "您可以在这里与同事快速分享各类信息，管理员可以维护信息分类。"

		db.cms_posts.insert
			space: spaceId
			site: siteId
			category: [categoryIds[0]]
			title: TEMPLATE_POST_TITLE
			body: TEMPLATE_POST_BODY

		return siteId