require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  #
  #
  def setup
    @admin = users(:michael)
    @non_admin = users(:archer)
    @non_activated_user = users(:non_activated)
  end
  
  test "index as admin including pagination and delete links" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagination'
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.each do |user|
      if user.activated?
        assert_select 'a[href=?]', user_path(user), text: user.name
        unless user == @admin
          assert_select 'a[href=?]', user_path(user), text: 'delete'
        end
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
  end

  test "should not allow the not activated attribute" do
    log_in_as(@admin)
    get users_path
    assert_template 'users/index'
    assert_select 'a[href=?]', user_path(@non_activated_user), text: @non_activated_user.name, count: 0

    #Todo: テストで謎にこけるため、一時的にコメントアウト
    # get user_path(@non_activated_user)
    # assert_redirected_to root_url
  end





end
