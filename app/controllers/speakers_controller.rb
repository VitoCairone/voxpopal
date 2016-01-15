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
    sparams = speaker_params
    sparams['codename'] = get_available_codename
    @speaker = Speaker.new(sparams)

    respond_to do |format|
      if @speaker.save
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
    params.require(:speaker).permit(:codename, :name, :email, :password_hash, :starsign, :birth_month, :birth_year, :verification_id, :level, :session_token, :recall_token, :logged_in, :last_action)
  end

  def get_available_codename
    # this current implementation isn't tightly time-constrained or collision-proof
    # prerer in the future pulling and reserving from a pre-created list
    list_1 = [
      'Noble ',
      'Valiant ',
      'Kind ',
      'Swift ',
      'Strong ',
      'Clever ',
      'Shining ',
      'Righteous ',
      'Wise ',
      'Proud ',
      'Brave ',
      'Honest ',
      'Awesome ',
      'Triumphant ',
      'Furious ',
      'Leaping ',
      'Fighting ',
      'Champion ',
      'Smiling ',
      'Rising ',
      'Flying ',
      'Grinning '
    ]

    list_2 = [
      'Red ',
      'Orange ',
      'Yellow ',
      'Green ',
      'Blue ',
      'Violet ',
      'White',
      'Black',
      'Brown',
      'Pink',
      'Snow ',
      'Fire ',
      'Earth ',
      'Wind ',
      'Water ',
      'Electric ',
      'Space ',
      'Thunder ',
      'Sonic ',
      'Little ',
      'Big '
    ]

    list_3 = [
      'Eagle',
      'Lion',
      'Wolf',
      'Fox',
      'Wildcat',
      'Horse',
      'Rabbit',
      'Seal',
      'Tiger',
      'Owl',
      'Dove',
      'Songbird',
      'Swan',
      'Gator',
      'Dolphin',
      'Bumblebee',
      'Grasshopper',
      'Deer',
      'Tortoise'
    ]

    not_original = true
    while not_original do
      codename = list_1.sample + list_2.sample + list_3.sample
      not_original = !!(Speaker.find_by_codename(codename))
    end
    codename
  end

end
