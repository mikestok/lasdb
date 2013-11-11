require 'test_helper'

##
# Class to test the "home" controller
class HomeControllerTest < ActionController::TestCase
  test 'should get index' do
    get :index
    assert_response :success
  end

end
