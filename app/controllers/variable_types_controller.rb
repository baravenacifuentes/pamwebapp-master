class VariableTypesController < ApplicationController
  before_action :set_variable_type, only: [:show, :edit, :update, :destroy]

  # GET /variable_types
  # GET /variable_types.json
  def index
    @variable_types = VariableType.all
  end

  # GET /variable_types/1
  # GET /variable_types/1.json
  def show
  end

  # GET /variable_types/new
  def new
    @variable_type = VariableType.new
  end

  # GET /variable_types/1/edit
  def edit
  end

  # POST /variable_types
  # POST /variable_types.json
  def create
    @variable_type = VariableType.new(variable_type_params)

    respond_to do |format|
      if @variable_type.save
        format.html { redirect_to @variable_type, notice: 'Variable type was successfully created.' }
        format.json { render :show, status: :created, location: @variable_type }
      else
        format.html { render :new }
        format.json { render json: @variable_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /variable_types/1
  # PATCH/PUT /variable_types/1.json
  def update
    respond_to do |format|
      if @variable_type.update(variable_type_params)
        format.html { redirect_to @variable_type, notice: 'Variable type was successfully updated.' }
        format.json { render :show, status: :ok, location: @variable_type }
      else
        format.html { render :edit }
        format.json { render json: @variable_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /variable_types/1
  # DELETE /variable_types/1.json
  def destroy
    @variable_type.destroy
    respond_to do |format|
      format.html { redirect_to variable_types_url, notice: 'Variable type was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_variable_type
      @variable_type = VariableType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def variable_type_params
      params.require(:variable_type).permit(:name)
    end
end
