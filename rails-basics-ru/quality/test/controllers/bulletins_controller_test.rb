require 'test_helper'

class BulletinsControllerTest < ActionDispatch::IntegrationTest
  test 'should get index' do
    get bulletins_path
    assert_response :success
  end

  test 'should get show' do
    bulletin = bulletins(:first)
    get bulletin_path(bulletin)
    assert_response :success
  end
end
