require 'test_helper'

test 'it creates a new idea upon form submission' do
  assert_difference 'Idea.count', 1 do
    page.fill_in 'idea[title]', with: 'Best Idea Ever'
    page.fill_in 'idea[body]', with: 'It really is'
    page.click_button 'Submit Idea'
  end
end
