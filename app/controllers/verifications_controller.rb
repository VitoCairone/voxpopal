class VerificationsController < ApplicationController
  before_action :set_verification, only: [:show, :edit, :update, :destroy]

  # GET /verifications
  # GET /verifications.json
  def index
    @verifications = Verification.all
  end

  # GET /verifications/1
  # GET /verifications/1.json
  def show
  end

  # GET /verifications/new
  def new
    @verification = Verification.new
  end

  # GET /verifications/1/edit
  def edit
  end

  # POST /verifications
  # POST /verifications.json
  def create
    @verification = Verification.new(verification_params)

    respond_to do |format|
      if @verification.save
        format.html { redirect_to @verification, notice: 'Verification was successfully created.' }
        format.json { render :show, status: :created, location: @verification }
      else
        format.html { render :new }
        format.json { render json: @verification.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /verifications/1
  # PATCH/PUT /verifications/1.json
  def update
    respond_to do |format|
      if @verification.update(verification_params)
        format.html { redirect_to @verification, notice: 'Verification was successfully updated.' }
        format.json { render :show, status: :ok, location: @verification }
      else
        format.html { render :edit }
        format.json { render json: @verification.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /verifications/1
  # DELETE /verifications/1.json
  def destroy
    @verification.destroy
    respond_to do |format|
      format.html { redirect_to verifications_url, notice: 'Verification was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_verification
      @verification = Verification.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def verification_params
      params.require(:verification).permit(:speaker_id)
    end
end
