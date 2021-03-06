class SpeakersController < ApplicationController
  before_action :set_speaker, only: [:show, :edit, :update, :destroy]

  # GET /speakers
  # GET /speakers.json
  def index
    @speakers = Speaker.all
  end

  # GET /speakers/1
  # GET /speakers/1.json
  def show
  end

  # GET /speakers/new
  def new
    @speaker = Speaker.new
  end

  # GET /speakers/1/edit
  def edit
  end

  # POST /speakers
  # POST /speakers.json
  def create
    # note that this method does NOT actually create a new speaker object
    sparams = speaker_params
    sparams['guest'] = false
    sparams['admin'] = false
    sparams['session_token'] = 'NEWLY_REGISTERED'

    reserve_token = "RESERVED_FOR_#{current_speaker.id}"

    new_speaker = current_speaker if current_speaker.codename == sparams['codename']
    new_speaker ||= Speaker.find_by_codename_and_session_token(sparams['codename'], reserve_token)

    respond_to do |format|
      if new_speaker and new_speaker.update(sparams)
        Speaker.clear_codename_reservations(reserve_token)
        logout(false)
        login(new_speaker)
        @speaker = new_speaker
        format.html { redirect_to @speaker, notice: 'Speaker was successfully created.' }
        format.json { render :show, status: :created, location: @speaker }
      else
        format.html { render :new }
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /speakers/1
  # PATCH/PUT /speakers/1.json
  def update
    respond_to do |format|
      if @speaker.update(speaker_params)
        format.html { redirect_to @speaker, notice: 'Speaker was successfully updated.' }
        format.json { render :show, status: :ok, location: @speaker }
      else
        format.html { render :edit }
        format.json { render json: @speaker.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /speakers/1
  # DELETE /speakers/1.json
  def destroy
    @speaker.destroy
    respond_to do |format|
      format.html { redirect_to speakers_url, notice: 'Speaker was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_speaker
    @speaker = Speaker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def speaker_params
    params.require(:speaker).permit(:codename, :name, :email, :password, :starsign, :birth_month, :birth_year)
  end

end
