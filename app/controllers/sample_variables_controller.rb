class SampleVariablesController < ApplicationController
  before_action :set_sample_variable, only: [:show, :edit, :update, :destroy]

  # GET /sample_variables
  # GET /sample_variables.json
  def index
    @sample_variables = SampleVariable.all
  end

  # GET /sample_variables/1
  # GET /sample_variables/1.json
  def show
  end

  # GET /sample_variables/new
  def new
    @sample_variable = SampleVariable.new
  end

  # GET /sample_variables/1/edit
  def edit
  end

  # POST /sample_variables
  # POST /sample_variables.json
  def create
    @sample_variable = SampleVariable.new(sample_variable_params)

    respond_to do |format|
      if @sample_variable.save
        format.html { redirect_to @sample_variable, notice: 'Sample variable was successfully created.' }
        format.json { render :show, status: :created, location: @sample_variable }
      else
        format.html { render :new }
        format.json { render json: @sample_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sample_variables/1
  # PATCH/PUT /sample_variables/1.json
  def update
    respond_to do |format|
      if @sample_variable.update(sample_variable_params)
        format.html { redirect_to @sample_variable, notice: 'Sample variable was successfully updated.' }
        format.json { render :show, status: :ok, location: @sample_variable }
      else
        format.html { render :edit }
        format.json { render json: @sample_variable.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sample_variables/1
  # DELETE /sample_variables/1.json
  def destroy
    @sample_variable.destroy
    respond_to do |format|
      format.html { redirect_to sample_variables_url, notice: 'Sample variable was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sample_variable
      @sample_variable = SampleVariable.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sample_variable_params
      params.require(:sample_variable).permit(:value, :sample_id, :variable_id)
    end
end
