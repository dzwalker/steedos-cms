FlowRouter.route '/cms',
	action: (params, queryParams)->
		if Session.get("siteId") and db.cms_sites.findOne(Session.get("siteId"))
			FlowRouter.go "/cms/" + Session.get("siteId")
		else
			BlazeLayout.render 'masterLayout',
				main: "cms_home"

FlowRouter.route '/cms/admin',
	action: (params, queryParams)->
		if Session.get("siteId")
			FlowRouter.go "/cms/" + Session.get("siteId") + "/admin"
		else
			FlowRouter.go "/cms/"

FlowRouter.route '/cms/:siteId/admin',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_admin"

FlowRouter.route '/cms/:siteId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteCategoryId", null)
		Session.set("siteTag", null)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_home"

FlowRouter.route '/cms/:siteId/p/:postId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("postId", params.postId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_post"

FlowRouter.route '/cms/:siteId/t/:siteTag',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteTag", params.siteTag)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_tagged"

FlowRouter.route '/cms/:siteId/t/:siteTag/p/:postId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteTag", params.siteTag)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_post"

FlowRouter.route '/cms/:siteId/c/:siteCategoryId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteCategoryId", params.siteCategoryId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_category"
			
FlowRouter.route '/cms/:siteId/c/:siteCategoryId/p/:postId',
	action: (params, queryParams)->
		Session.set("siteId", params.siteId)
		Session.set("siteCategoryId", params.siteCategoryId)
		Session.set("postId", params.postId)
		BlazeLayout.render 'masterLayout',
			main: "cms_site_post"