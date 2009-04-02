require 'test_helper'

class LinkToRemoteWithSeoTest < ActionView::TestCase
  
  test "href should not be set when seo is false" do
    html = link_to_remote "link text",
      { :update => "#results",
        :url => { :action => "next_page" } }
    assert_select HTML::Document.new(html).root, "a[href=#]"
  end

  test "href should be set when seo is true" do
    html = link_to_remote "link text",
      { :update => "#results",
        :url => { :action => "next_page" },
        :seo => true }
    assert_select HTML::Document.new(html).root, "a[href=http://www.example.com/next_page]"
  end

  test "href should not be clobbered if specified in html_options" do
    html = link_to_remote "link text",
      { :update => "#results",
        :url => { :action => "next_page" },
        :seo => true },
      { :href => "/some_page" }
    assert_select HTML::Document.new(html).root, "a[href=/some_page]"
  end

  protected

  def protect_against_forgery?
    false
  end

  def url_for(options)
    if options.is_a?(String)
      options
    else
      url =  "http://www.example.com/"
      url << options[:action].to_s if options and options[:action]
      url << "?a=#{options[:a]}" if options && options[:a]
      url << "&b=#{options[:b]}" if options && options[:a] && options[:b]
      url
    end
  end

end
