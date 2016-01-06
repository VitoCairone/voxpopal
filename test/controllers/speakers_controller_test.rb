require 'test_helper'

class SpeakersControllerTest < ActionController::TestCase
  setup do
    @speaker = speakers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:speakers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create speaker" do
    assert_difference('Speaker.count') do
      post :create, speaker: { birth_month: @speaker.birth_month, birth_year: @speaker.birth_year, codename: @speaker.codename, email: @speaker.email, last_action: @speaker.last_action, level: @speaker.level, logged_in: @speaker.logged_in, name: @speaker.name, password_hash: @speaker.password_hash, recall_token: @speaker.recall_token, session_token: @speaker.session_token, starsign: @speaker.starsign, verification_id: @speaker.verification_id }
    end

    assert_redirected_to speaker_path(assigns(:speaker))
  end

  test "should show speaker" do
    get :show, id: @speaker
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @speaker
    assert_response :success
  end

  test "should update speaker" do
    patch :update, id: @speaker, speaker: { birth_month: @speaker.birth_month, birth_year: @speaker.birth_year, codename: @speaker.codename, email: @speaker.email, last_action: @speaker.last_action, level: @speaker.level, logged_in: @speaker.logged_in, name: @speaker.name, password_hash: @speaker.password_hash, recall_token: @speaker.recall_token, session_token: @speaker.session_token, starsign: @speaker.starsign, verification_id: @speaker.verification_id }
    assert_redirected_to speaker_path(assigns(:speaker))
  end

  test "should destroy speaker" do
    assert_difference('Speaker.count', -1) do
      delete :destroy, id: @speaker
    end

    assert_redirected_to speakers_path
  end
end
