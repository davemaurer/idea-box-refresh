require 'test_helper'

class LoadingIdeasTest < ActionDispatch::IntegrationTest
  def setup
    use_javascript
    visit root_path
  end

  def teardown
    reset_driver
  end

  test 'it should load all of the ideas with a .idea div' do
    wait_for_ajax
    within :css, '.ideas' do
      assert_equal Idea.count, page.find_all('.idea').count
    end
  end

  test 'it adds a new idea to the page' do
    assert_difference "page.find_all('.idea').count", 1 do
      page.fill_in 'idea[title]', with: "Best Idea Ever"
      page.fill_in 'idea[body]', with: "Atomize myself"
      page.click_button 'Submit Idea'

      wait_for_ajax
    end
  end
end
