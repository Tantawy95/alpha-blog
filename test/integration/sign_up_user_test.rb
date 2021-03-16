require "test_helper"

class SignUpUserTest < ActionDispatch::IntegrationTest
 
  def setup 
    
  end
 
  test "Sign up user successfully" do
    get "/signup"
    assert_response :success
    assert_difference 'User.count', 1 do
      post users_path, params: { user: {username: "Ali ", email: "a@l.com", password: "password" } }
      assert_response :redirect
    end
    assert true
  end

  
end
