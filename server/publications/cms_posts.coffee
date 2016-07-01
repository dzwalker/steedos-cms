Meteor.publish 'cms_posts', (siteId, postId)->
  
    unless this.userId
      return this.ready()
    
    unless siteId
      return this.ready()

    console.log '[publish] cms_posts for site ' + siteId

    selector = 
        site: siteId

    if !postId
        return db.cms_posts.find selector, 
            sort: 
                postDate: -1
            fields: 
                space: 1
                site: 1
                title: 1
                author: 1
                author_name: 1
                summary: 1
                image: 1
    else    
        selector._id = postId
        return db.cms_posts.find(selector, {sort: {postDate: -1}})