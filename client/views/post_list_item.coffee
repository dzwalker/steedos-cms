Template.cms_post_list_item.helpers CMS.helpers


Template.cms_post_list_item.onRendered ->
    $('.swipebox').swipebox();


Template.cms_post_list_item.events
    "click #post-preview": (e,t)->
        url = Meteor.absoluteUrl("site/" + this.site + "/p/" + this._id)
        Steedos.openWindow(url)
