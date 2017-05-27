require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "testuser", email: "testuser@email.com", password: "secretpassword", password_confirmation: "secretpassword")
  end
  
  test "username should be present" do
  	@user.username = "   "
    assert_not @user.valid?
  end

  test "email should be present" do
  	@user.email = "   "
    assert_not @user.valid?
  end

  test "password should be present" do
  	@user.password = "      "
  	@user.password_confirmation = "      "
    assert_not @user.valid?
  end
end
