Template.cms_site_admin.helpers
    cms_sites: ()->
        return db.cms_sites.find()

Template.cms_site_admin.events