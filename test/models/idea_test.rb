require 'test_helper'

class IdeaTest < ActiveSupport::TestCase
  test 'it should have a quality that defaults to 0' do
    idea = Idea.new
    assert_equal('swill', idea.quality)
  end

  test 'it should be invalid without a title or body' do
    blank_idea = Idea.new

    refute(blank_idea.valid?)
  end

  test 'it should be invalid without a title' do
    idea = Idea.new(title: 'Lord of the Ideas')

    refute(idea.valid?)
  end

  test 'it should be invalid without a body' do
    idea = Idea.new(body: 'Lies over the ocean')

    refute(idea.valid?)
  end

  test 'it is valid with both a title a body' do
    idea = Idea.new(title: 'Valid Title', body: 'Valid Body')

    assert(idea.valid?)
  end

  test 'it is valid with a quality of swill' do
    ideas(:one).quality = 'swill'

    assert(ideas(:one).valid?)
  end

  test 'it is valid with a quality of plausible' do
    ideas(:one).quality = 'plausible'

    assert(ideas(:one).valid?)
  end

  test 'it is valid with a quality of genius' do
    ideas(:one).quality = 'genius'

    assert(ideas(:one).valid?)
  end

  test 'it is invalid with any quality not in validations' do
    ideas(:one).quality = 'bingo'

    refute(ideas(:one).valid?)
  end
end
