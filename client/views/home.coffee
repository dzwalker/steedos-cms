Template.cms_home.helpers CMS.helpers

Template.cms_home.onRendered ->
    siteCount = db.cms_sites.find().count();
    if siteCount == 0
        Meteor.call "space_blogs_init", Session.get("spaceId"), (error, result) ->
    #         if result
    #             FlowRouter.go "/cms/" + result;
    # else if siteCount == 1
    #     site = db.cms_sites.findOne()
    #     FlowRouter.go "/cms/s/" + site._id;


Template.cms_home.events
    "click #site-preview": (e,t)->
        url = Meteor.absoluteUrl("site/s/" + this._id)
        Steedos.openWindow(url)