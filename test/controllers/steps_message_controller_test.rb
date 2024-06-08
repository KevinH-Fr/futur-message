require "test_helper"

class StepsMessageControllerTest < ActionDispatch::IntegrationTest
  test "should get content" do
    get steps_message_content_url
    assert_response :success
  end

  test "should get media" do
    get steps_message_media_url
    assert_response :success
  end

  test "should get send_parameters" do
    get steps_message_send_parameters_url
    assert_response :success
  end
end
