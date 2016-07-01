FlowRouter.route '/cms',
	action: (params, queryParams)->
		Session.set("siteId", null)
		BlazeLayout.render 'masterLayout',
				main: "cms_home"

FlowRouter.route '/cms/s/:siteId/admin',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_admin"

FlowRouter.route '/cms/s/:siteId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteCategoryId", null)
		Session.set("siteTag", null)
		Session.set("postId", null)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_home"

FlowRouter.route '/cms/s/:siteId/p/:postId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("postId", params.postId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_post"

FlowRouter.route '/cms/s/:siteId/t/:siteTag',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteTag", params.siteTag)
		Session.set("postId", null)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_tagged"

FlowRouter.route '/cms/s/:siteId/t/:siteTag/p/:postId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteTag", params.siteTag)
		Session.set("postId", params.postId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_post"

FlowRouter.route '/cms/s/:siteId/c/:siteCategoryId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteCategoryId", params.siteCategoryId)
		Session.set("postId", null)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_category"
			
FlowRouter.route '/cms/s/:siteId/c/:siteCategoryId/p/:postId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteCategoryId", params.siteCategoryId)
		Session.set("postId", params.postId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_post"