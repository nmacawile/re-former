require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup
    @user = User.new(username: "testuser", email: "testuser@email.com", password: "secretpassword", password_confirmation: "secretpassword")
  end

  # username #
  
  test "username should be present" do
  	@user.username = "   "
    assert_not @user.valid?
  end

  test "username should have more than 2 characters" do
    @user.username = "aa"
    assert_not @user.valid?
  end

  test "username should have no more than 20 characters" do
    @user.username = "a" * 21
    assert_not @user.valid?
  end

  test "username validation should accept valid usernames" do
  	valid_usernames = %w(foobar
  	                     foo123
  	                     123bar
  	                     123456
  	                     foo_bar
  	                     __foobar__
  	                     ___foobar
  	                     foo-bar
  	                     FOOBAR)
  	valid_usernames.each do |valid_username|
  		@user.username = valid_username
  		assert @user.valid?
  	end
  end

  test "username validation should reject invalid usernames" do
    invalid_usernames = %w(f@@bar
                           foo+bar
                           foo/bar
                           foo.bar
                           'foo bar'
                           foo\bar)
  	invalid_usernames.each do |invalid_username|
  		@user.username = invalid_username
  		assert_not @user.valid?
  	end
  end

  test "username should be unique" do
  	User.create(username: @user.username.upcase, email: "foo@bar.com", password: "secretpassword")
  	assert_not @user.valid?
  end
  
  # email #

  test "email should be present" do
  	@user.email = "   "
    assert_not @user.valid?
  end

  test "email should have no more than 100 characters" do
    @user.email = "a" * 101
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_emails = %w(foo@bar.com
                      foo.bar@bar.com
                      foo.bar_baz@bar.com
                      foo+BAR@bar.com
                      foo@bar.fb)
    valid_emails.each do |valid_email|
      @user.email = valid_email
      assert @user.valid?
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_emails = %w(foobar
                        foo@bar
                        foo@bar,com
                        @bar.com
                        bar.com
                        foo@bar..com
                        foo@b_r.com
                        foo@b+r.com)
    invalid_emails.each do |invalid_email|
      @user.email = invalid_email
      assert_not @user.valid?
    end
  end

  test "email should be unique" do
    User.create(username: "foobaz1", email: @user.email.upcase, password: "123456")
    assert_not @user.valid?
  end

  test "email should be saved as lower-case" do
    @user.email = "FOobAr@EmAIl.COM"
    @user.save
    assert_equal @user.reload.email, "foobar@email.com"
  end

  # password #

  test "password should be present (non blank)" do
  	@user.password = "      "
  	@user.password_confirmation = "      "
    assert_not @user.valid?
  end

  test "password should have more than 5 characters" do
    @user.password = @user.password_confirmation = "12345"
    assert_not @user.valid?
  end

end
