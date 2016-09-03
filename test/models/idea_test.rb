require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'it should have a quality that defaults to 0' do
    idea = Idea.new
    assert_equal('swill', idea.quality)
  end

  test 'it should be invalid without a title or body' do
    no_title_or_body_idea = Idea.new

    refute(no_title_or_body_idea.valid?)
  end
end
