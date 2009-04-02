module LinkToRemoteWithSeo
  def self.append_features(base)
    super
    base.alias_method_chain :link_to_remote, :seo
  end

  def link_to_remote_with_seo(name, options = {}, html_options = {})
    Rails.logger.debug "options[:seo] is overridden by explicit html_options[:href] in link_to_remote" if html_options[:href] && options[:seo]
    html_options[:href] ||= url_for(options[:url]) if options[:seo]
    link_to_remote_without_seo(name, options, html_options)
  end
end

module ActionView #:nodoc:
  class Base #:nodoc:
    include LinkToRemoteWithSeo
  end
end
