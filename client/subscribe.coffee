Steedos.subsSite = new SubsManager();

Tracker.autorun (c)->
    if Session.get("spaceId")
        Steedos.subsSite.subscribe "cms_sites", Session.get("spaceId")
    if Session.get("siteId")
        Steedos.subsSite.subscribe "cms_sites", Session.get("spaceId")
        Steedos.subsSite.subscribe "cms_categories", Session.get("siteId") 
        Steedos.subsSite.subscribe "cms_posts", Session.get("siteId")
        Steedos.subsSite.subscribe "cms_tags", Session.get("siteId")    
    if Session.get("postId")     
        Steedos.subsSite.subscribe "cfs_posts", Session.get("postId")       

