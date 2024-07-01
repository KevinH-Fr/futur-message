# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "http://futurmessage.com"

SitemapGenerator::Sitemap.create do

  add '/home', :changefreq => 'daily', :priority => 0.9
  add '/about', :changefreq => 'daily', :priority => 0.9

  # Add sign-in and sign-up URLs to the sitemap
  add '/devise/sessions/new', :changefreq => 'daily', :priority => 0.8, :lastmod => Time.now
  add '/devise/registrations/new', :changefreq => 'daily', :priority => 0.8, :lastmod => Time.now

end
