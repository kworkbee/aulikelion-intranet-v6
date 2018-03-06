require 'test_helper'

class IntranetControllerTest < ActionDispatch::IntegrationTest
  test "should get dashboard" do
    get intranet_dashboard_url
    assert_response :success
  end

  test "should get notice" do
    get intranet_notice_url
    assert_response :success
  end

  test "should get freeboard" do
    get intranet_freeboard_url
    assert_response :success
  end

  test "should get gallery" do
    get intranet_gallery_url
    assert_response :success
  end

  test "should get writer" do
    get intranet_writer_url
    assert_response :success
  end

  test "should get notice_view" do
    get intranet_notice_view_url
    assert_response :success
  end

  test "should get freeboard_view" do
    get intranet_freeboard_view_url
    assert_response :success
  end

end
