require 'test_helper'

class UpdateIdeasTest < ActionDispatch::IntegrationTest
  def setup
    create_idea
    use_javascript
    visit root_path
  end

  def teardown
    reset_driver
  end

  test 'promote button should promote the quality of an idea by one rank' do
    idea = get_top_idea
    click_the_promote_button_on_idea(idea)

    assert idea.find('.idea-quality').has_content? 'Plausible'
  end

  private

  def create_idea
    Idea.create(title: 'Gone Soon', body: 'Bye')
  end

  def get_top_idea
    page.find(".idea:first-child")
  end

  def click_the_promote_button_on_idea(idea)
    idea.find('.idea-promote').click
    wait_for_ajax
  end

  def click_the_demote_button_on_idea(idea)
    idea.find('.idea-demote').click
    wait_for_ajax
  end
end
