require 'test_helper'

class LoadingIdeasTest < ActionDispatch::IntegrationTest

  def setup
    super
    use_javascript
    visit root_path
  end

  def teardown
    super
    reset_driver
  end

  test 'it creates a new idea upon form submission' do
    assert_difference 'Idea.count', 1 do
      page.fill_in 'idea[title]', with: 'Best Idea Ever'
      page.fill_in 'idea[body]', with: 'It really is'
      page.click_button 'Submit Idea'
      wait_for_ajax
    end
  end

  test 'it does not create a new idea upon invalid form submission' do
    assert_difference 'Idea.count', 0 do
      page.fill_in 'idea[title]', with: ''
      page.fill_in 'idea[body]', with: ''
      page.click_button 'Submit Idea'
      wait_for_ajax
    end
  end

  test 'it shows an error saying the the title or body cannot be blank if missing' do
    page.click_button 'Submit Idea'

    wait_for_ajax

    assert page.find('.new-idea-messages').has_content? 'Title and/or body cannot be blank.'
  end

  test 'it removes the error on subsequent submissions' do
    page.click_button 'Submit Idea'

    wait_for_ajax

    page.fill_in 'idea[title]', with: 'Best Idea Ever'
    page.fill_in 'idea[body]', with: 'It really is'
    page.click_button 'Submit Idea'

    refute page.find('.new-idea-messages').has_content? 'Title and/or body cannot be blank.'
  end
end

