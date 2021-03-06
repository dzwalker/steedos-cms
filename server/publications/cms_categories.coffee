Meteor.publish 'cms_categories', (siteId)->

	unless this.userId
		return this.ready()
	
	unless siteId
		return this.ready()

	site = db.cms_sites.findOne(siteId)
	unless site
		return this.ready()

	console.log '[publish] cms_categories for site ' + site.name

	selector = {}

	if site.admins and this.userId in site.admins
		selector = 
			site: siteId
	else
		selector = {$and: [{site: siteId},{$or: [{admins: null},{admins: this.userId}]}]}

	return db.cms_categories.find(selector, {sort: {order: 1}})