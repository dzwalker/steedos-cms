Template.cms_site_post.helpers CMS.helpers

Template.cms_site_post.onRendered ->
    $('.swipebox' ).swipebox();

Template.cms_site_post.events
    "click .post-attachment": (e,t)->
        url = Meteor.absoluteUrl("api/files/posts/" + this._id + "/" + this.original.name)
        Steedos.openWindow(url)