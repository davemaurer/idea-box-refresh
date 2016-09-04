require 'test_helper'

class Api::V1::IdeasControllerTest < ActionController::TestCase
  test 'responds to json' do
    get :index, format: :json

    assert_response :success
  end

  test 'index returns an array of records' do
    get :index, format: :json

    assert_kind_of Array, json_response
  end

  test 'index returns the correct number of ideas' do
    get :index, format: :json

    assert_equal Idea.count, json_response.count
  end

  test '#index contains ideas with the correct properties' do
    get :index, format: :json

    json_response.each do |idea|
      assert idea['title']
      assert idea['body']
      assert idea['quality']
    end
  end

  test '#show responds to json' do
    id = ideas(:one).id

    get :show, id: id, format: :json
    assert_response :success
  end

  test '#show responds with a particular idea' do
    id = ideas(:one).id

    get :show, id: id, format: :json

    assert_equal id, json_response['id']
  end

  test '#create adds a new idea to the database' do
    assert_difference 'Idea.count', 1 do
      idea = { title: 'New Idea', body: 'New Body' }

      post :create, idea: idea, format: :json
    end
  end

  test '#create returns the new idea' do
    number_of_ideas = Idea.all.count
    idea = { title: 'New Idea', body: 'New Body' }

    post :create, idea: idea, format: :json

    assert_equal idea[:title], json_response['title']
    assert_equal idea[:body], json_response['body']
    assert_equal 'swill', json_response['quality']
    refute_equal number_of_ideas, Idea.all.count
  end

  test '#create rejects ideas without a title' do
    number_of_ideas = Idea.all.count
    idea = { body: 'Body' }

    post :create, idea: idea, format: :json

    assert_response 422
    assert_equal number_of_ideas, Idea.all.count
    assert_includes json_response['errors']['title'], "can't be blank"
  end

  test '#create rejects ideas without a body' do
    number_of_ideas = Idea.all.count
    idea = { title: 'Ding!' }

    post :create, idea: idea, format: :json

    assert_response 422
    assert_equal number_of_ideas, Idea.all.count
    assert_includes json_response['errors']['body'], "can't be blank"
  end

  test '#update an idea via the API' do
    updated_content = { title: 'Better Title' }

    put :update, id: ideas(:one), idea: updated_content, format: :json
    ideas(:one).reload

    assert_equal 'Better Title', ideas(:one).title
  end

  test '#update the quality of an idea' do
    updated_content = { quality: 'plausible' }

    put :update, id: ideas(:one), idea: updated_content, format: :json
    ideas(:one).reload

    assert_equal 'plausible', ideas(:one).quality
  end

  test '#update rejects invalid quality values' do
    update_content = { quality: 'invalid' }

    put :update, id: ideas(:one), idea: update_content, format: :json
    ideas(:one).reload

    assert_response 422
  end

  test '#destroy removes an idea' do
    assert_difference 'Idea.count', -1 do
      delete :destroy, id: ideas(:one), format: :json
    end
  end
end
