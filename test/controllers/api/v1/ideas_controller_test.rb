require 'test_helper'

class Api::V1::IdeasControllerTest < ActionController::TestCase
  test 'responds to json' do
    get :index, format: :json

    assert_response :success
  end

  test 'index returns an array of records' do
    get :index, format: :json
    json_response = JSON.parse(response.body)

    assert_kind_of Array, json_response
  end
end
