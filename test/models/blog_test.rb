require 'test_helper'

class BlogTest < ActiveSupport::TestCase

  test 'presence of blog name ' do 
    blog = new_blog
    blog.name = ""
    assert_not blog.valid?
  end

  private

  def new_blog
    blog = Blog.new
    blog.name = "name of blog"
    blog
  end
end
