Package.describe({
    name: 'steedos:cms',
    version: '0.0.2',
    summary: 'Steedos CMS',
    git: ''
});

Npm.depends({
  cookies: "0.6.1",
});

Package.onUse(function(api) { 
    api.versionsFrom("1.2.1");

    api.use('reactive-var');
    api.use('reactive-dict');
    api.use('coffeescript');
    api.use('random');
    api.use('ddp');
    api.use('check');
    api.use('ddp-rate-limiter');
    api.use('underscore');
    api.use('tracker');
    api.use('session');
    api.use('blaze');
    api.use('templating');
    api.use('webapp', 'server');
    
    api.use('flemay:less-autoprefixer@1.2.0');
    api.use('simple:json-routes@2.1.0');
    api.use('nimble:restivus@0.8.7');
    api.use('aldeed:simple-schema@1.3.3');
    api.use('aldeed:collection2@2.5.0');
    api.use('aldeed:tabular@1.6.0');
    api.use('aldeed:autoform@5.8.0');
    api.use('matb33:collection-hooks@0.8.1');
    api.use('cfs:standard-packages@0.5.9');
    api.use('kadira:blaze-layout@2.3.0');
    api.use('kadira:flow-router@2.10.1');

    api.use('meteorhacks:ssr@2.2.0');
    api.use('steedos:lib@0.0.1');
    api.use('tap:i18n@1.7.0');
    api.use('meteorhacks:subs-manager');



    //api.add_files("package-tap.i18n", ["client", "server"]);
    tapi18nFiles = ['i18n/en.i18n.json', 'i18n/zh-CN.i18n.json']
    api.addFiles(tapi18nFiles, ['client', 'server']);
    
    api.addFiles('lib/core.coffee');
    api.addFiles('lib/modals/categories.coffee');
    api.addFiles('lib/modals/cfs_posts.coffee');
    api.addFiles('lib/modals/comments.coffee');
    api.addFiles('lib/modals/pages.coffee');
    api.addFiles('lib/modals/posts.coffee');
    api.addFiles('lib/modals/sites.coffee');
    api.addFiles('lib/modals/tags.coffee');
    api.addFiles('lib/modals/themes.coffee');
    api.addFiles('lib/admin.coffee');

    api.addFiles('client/views/_helpers.coffee', 'client');
    api.addFiles('client/views/home.html', 'client');
    api.addFiles('client/views/home.coffee', 'client');
    api.addFiles('client/views/home.less', 'client');
    api.addFiles('client/views/site_header.html', 'client');
    api.addFiles('client/views/site_header.coffee', 'client');
    api.addFiles('client/views/site_header.less', 'client');
    api.addFiles('client/views/post_list_item.html', 'client');
    api.addFiles('client/views/post_list_item.coffee', 'client');
    api.addFiles('client/views/site_admin.html', 'client');
    api.addFiles('client/views/site_admin.coffee', 'client');
    api.addFiles('client/views/site_category.html', 'client');
    api.addFiles('client/views/site_category.coffee', 'client');
    api.addFiles('client/views/site_home.html', 'client');
    api.addFiles('client/views/site.less', 'client');
    api.addFiles('client/views/site_home.coffee', 'client');
    api.addFiles('client/views/site_menu.html', 'client');
    api.addFiles('client/views/site_menu.coffee', 'client');
    api.addFiles('client/views/site_post.html', 'client');
    api.addFiles('client/views/site_post.coffee', 'client');
    api.addFiles('client/views/site_tagged.html', 'client');
    api.addFiles('client/views/site_tagged.coffee', 'client');

    api.addFiles('client/router.coffee', 'client');
    api.addFiles('client/subscribe.coffee', 'client');

    api.addFiles('server/methods/cms_init.coffee', 'server');
    api.addFiles('server/methods/cms_site_build.coffee', 'server');

    api.addFiles('server/publications/cfs_posts.coffee', 'server');
    api.addFiles('server/publications/cms_categories.coffee', 'server');
    api.addFiles('server/publications/cms_posts.coffee', 'server');
    api.addFiles('server/publications/cms_sites.coffee', 'server');
    api.addFiles('server/publications/cms_tags.coffee', 'server');
    api.addFiles('server/publications/cms_themes.coffee', 'server');

    api.addFiles('server/routes/site.coffee', 'server');
    api.addFiles('server/routes/avatar.coffee', 'server');
    api.addAssets('themes/default.html', 'server');

    // EXPORT
    api.export('CMS');
});

Package.onTest(function(api) {

});
