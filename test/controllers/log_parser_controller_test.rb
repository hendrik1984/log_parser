require "test_helper"

class LogParserControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get log_parser_index_url
    assert_response :success
  end
end
