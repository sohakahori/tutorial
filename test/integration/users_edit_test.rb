require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  #
  #
  # "user"=>{"name"=>"sohakahori", "email"=>"sohakahori@gmail.com", "password"=>"rond8154", "password_confirmation"=>"rond8154"}, "commit"=>"Edit user", "controller"=>"users", "action"=>"update", "id"=>"1"}
  #
  #
  #

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path @user
    assert_template "users/edit"
    put user_path @user, params: {
        user: {
          name: "",
          email: "akahori@a.com",
          password: "",
          password_confirmation: ""
        }
    }
    assert_template "users/edit"
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    name  = "Foo Bar"
    email = "foo@bar.com"
    put user_path @user, params: {
        user: {
            name: name,
            email: email,
            password: "",
            password_confirmation: ""
        }
    }
    assert_not flash.empty?
    assert_redirected_to user_path @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
end
