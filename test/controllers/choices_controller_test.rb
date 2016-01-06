require 'test_helper'

class ChoicesControllerTest < ActionController::TestCase
  setup do
    @choice = choices(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:choices)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create choice" do
    assert_difference('Choice.count') do
      post :create, choice: { current_rank: @choice.current_rank, issue_id: @choice.issue_id, speaker_id: @choice.speaker_id, text: @choice.text, voice_tally_1: @choice.voice_tally_1, voice_tally_2: @choice.voice_tally_2, voice_tally_3: @choice.voice_tally_3 }
    end

    assert_redirected_to choice_path(assigns(:choice))
  end

  test "should show choice" do
    get :show, id: @choice
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @choice
    assert_response :success
  end

  test "should update choice" do
    patch :update, id: @choice, choice: { current_rank: @choice.current_rank, issue_id: @choice.issue_id, speaker_id: @choice.speaker_id, text: @choice.text, voice_tally_1: @choice.voice_tally_1, voice_tally_2: @choice.voice_tally_2, voice_tally_3: @choice.voice_tally_3 }
    assert_redirected_to choice_path(assigns(:choice))
  end

  test "should destroy choice" do
    assert_difference('Choice.count', -1) do
      delete :destroy, id: @choice
    end

    assert_redirected_to choices_path
  end
end
