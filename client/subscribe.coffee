Meteor.startup ->
    Tracker.autorun (c)->
        if Meteor.userId() and Session.get("spaceId")
            Meteor.subscribe "cms_sites", Session.get("spaceId")
        if Session.get("siteId")
            Meteor.subscribe "cms_categories", Session.get("siteId") 
            Meteor.subscribe "cms_posts", Session.get("siteId")
            Meteor.subscribe "cms_tags", Session.get("siteId")    
        if Session.get("postId")     
            Meteor.subscribe "cfs_posts", Session.get("postId")       