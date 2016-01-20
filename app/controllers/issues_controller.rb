class IssuesController < ApplicationController
  before_action :set_issue, only: [:show, :edit, :update, :destroy]

  # GET /issues
  # GET /issues.json
  def index
    @issues = Issue.unseen_by_speaker(current_speaker, limit=3)

    if @issues.length > 0
      current_speaker.speaker_history.issue_spare_1_id = @issues[0].id
      if @issues.length > 1
        current_speaker.speaker_history.issue_spare_2_id = @issues[1].id
        if @issues.length > 2
          current_speaker.speaker_history.issue_spare_3_id = @issues[2].id
        end
      end
    end
    # if @issues.length > 3
    #   current_speaker.speaker_history.next_issue_id = @issues[3].id
    # end
    current_speaker.speaker_history.save

    @issues
  end

  def seen
    @issues = Issue.seen_by_speaker(current_speaker, limit=3)
  end

  # GET /issues/1
  # GET /issues/1.json
  def show
    @voice = Voice.find_by issue_id: @issue.id, speaker_id: current_speaker.id
    @voice_given = !!@voice
    @voices = Voice.where(issue_id: @issue.id) if @voice_given
    @voice ||= Voice.new
    @voice_stats = Voice.find_counts_by_choice(@issue)

    voicing_workflow
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

  def voicing_workflow
    # why is it that current_speaker.speaker_history works
    # but speaker_history.issue_spare_1 doesn't?
    @history = current_speaker.speaker_history
    spare_issue_ids = [
      @history.issue_spare_1_id,
      @history.issue_spare_2_id,
      @history.issue_spare_3_id
    ]
    spare_issue_ids -= [nil]
    unord_spare_issues = Issue.find(spare_issue_ids)

    puts "@@@@@ unord_spare_issues: #{unord_spare_issues}"

    @spare_issues = []
    spare_issue_ids.each do |id|
      @spare_issues += [unord_spare_issues.find{|record| record.id == id}]
    end

    puts "@@@@@ @spare_issues: #{@spare_issues}"
    
    unseen_issues = Issue.unseen_by_speaker(current_speaker, limit=5)
    possible_new_issues = unseen_issues - (@spare_issues + [@issue])
    new_issue = possible_new_issues.sample
    replace_slot = @spare_issues.find_index @issue
    if [0,1,2].include? replace_slot
      case replace_slot
        when 0
          @history.issue_spare_1_id = new_issue.id
        when 1
          @history.issue_spare_2_id = new_issue.id
        when 2
          @history.issue_spare_3_id = new_issue.id
      end
      @spare_issues[replace_slot] = new_issue
      @history.save
    end
  end
end
