Template.cms_site_post.helpers CMS.helpers

Template.cms_site_post.onRendered ->
    $('.swipebox' ).swipebox();

Template.cms_site_post.events
    "click .post-attachment": (e,t)->
        url = Meteor.absoluteUrl("api/files/posts/" + this._id + "/" + this.original.name)
        if Steedos.isAndroidApp()
          filename = this.original.name
          rev = this._id
          length = this.original.size
          Steedos.androidDownload(url, filename, rev, length)
        else
          Steedos.openWindow(url)

    "click #post-preview": (e,t)->
        url = Meteor.absoluteUrl("site/" + this.site + "/p/" + this._id)
        Steedos.openWindow(url)
