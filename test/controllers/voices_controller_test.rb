require 'test_helper'

class VoicesControllerTest < ActionController::TestCase
  setup do
    @voice = voices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:voices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create voice" do
    assert_difference('Voice.count') do
      post :create, voice: { choice_id: @voice.choice_id, level: @voice.level, speaker_id: @voice.speaker_id }
    end

    assert_redirected_to voice_path(assigns(:voice))
  end

  test "should show voice" do
    get :show, id: @voice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @voice
    assert_response :success
  end

  test "should update voice" do
    patch :update, id: @voice, voice: { choice_id: @voice.choice_id, level: @voice.level, speaker_id: @voice.speaker_id }
    assert_redirected_to voice_path(assigns(:voice))
  end

  test "should destroy voice" do
    assert_difference('Voice.count', -1) do
      delete :destroy, id: @voice
    end

    assert_redirected_to voices_path
  end
end
