class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.unseen_by_speaker(current_speaker)
  end

  def seen
    @issues = Issue.seen_by_speaker(current_speaker)
    render :seen
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @voice = Voice.find_by issue_id: @issue.id, speaker_id: current_speaker.id
    @voice_given = !!@voice
    @voices = Voice.where(issue_id: @issue.id) if @voice_given
    @voice ||= Voice.new
    @voice_stats = Voice.find_counts_by_choice(@issue)
  end

  # GET /issues/new
  def new
    @issue = Issue.new
    7.times { @issue.choices.build }
  end

  # GET /issues/1/edit
  def edit
  end

  # POST /issues
  # POST /issues.json
  def create
    iparams = issue_params
    iparams['speaker_id'] = current_speaker.id
    iparams['codename'] = get_available_codename
    choices_attributes = iparams['choices_attributes']
    choices_attributes.each do |k, v|
      choices_attributes[k]['speaker_id'] = current_speaker.id
    end
    choices_attributes.keep_if { |k, v| !v['text'].blank? }
    @issue = Issue.new(iparams)

    respond_to do |format|
      if @issue.save
        format.html { redirect_to @issue, notice: 'Issue was successfully created.' }
        format.json { render :show, status: :created, location: @issue }
      else
        format.html { render :new }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /issues/1
  # PATCH/PUT /issues/1.json
  def update
    respond_to do |format|
      iparams = issue_params
      iparams['speaker_id'] = current_speaker.id
      if @issue.update(iparams)
        format.html { redirect_to @issue, notice: 'Issue was successfully updated.' }
        format.json { render :show, status: :ok, location: @issue }
      else
        format.html { render :edit }
        format.json { render json: @issue.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /issues/1
  # DELETE /issues/1.json
  def destroy
    @issue.destroy
    respond_to do |format|
      format.html { redirect_to issues_url, notice: 'Issue was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  
  # Use callbacks to share common setup or constraints between actions.
  def set_issue
    @issue = Issue.includes(:choices).find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def issue_params
    params.require(:issue).permit(:codename, :text, choices_attributes: [:id, :text, :_destroy])
  end

  def get_available_codename
    not_original = true
    while not_original do
      codename = (rand(26) + 'A'.ord).chr + rand(100).to_s
      break if Issue.count > 26 * 100 * 2/3
      not_original = !!(Issue.find_by_codename(codename))
    end
    codename
  end
end
