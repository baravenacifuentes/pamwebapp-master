class LubricantsController < ApplicationController
  before_action :set_lubricant, only: [:show, :edit, :update, :destroy]

  # GET /lubricants
  # GET /lubricants.json
  def index
    @lubricants = Lubricant.all
  end

  # GET /lubricants/1
  # GET /lubricants/1.json
  def show
  end

  # GET /lubricants/new
  def new
    @lubricant = Lubricant.new
  end

  # GET /lubricants/1/edit
  def edit
  end

  # POST /lubricants
  # POST /lubricants.json
  def create
    @lubricant = Lubricant.new(lubricant_params)

    respond_to do |format|
      if @lubricant.save
        format.html { redirect_to @lubricant, notice: 'Lubricant was successfully created.' }
        format.json { render :show, status: :created, location: @lubricant }
      else
        format.html { render :new }
        format.json { render json: @lubricant.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lubricants/1
  # PATCH/PUT /lubricants/1.json
  def update
    respond_to do |format|
      if @lubricant.update(lubricant_params)
        format.html { redirect_to @lubricant, notice: 'Lubricant was successfully updated.' }
        format.json { render :show, status: :ok, location: @lubricant }
      else
        format.html { render :edit }
        format.json { render json: @lubricant.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lubricants/1
  # DELETE /lubricants/1.json
  def destroy
    @lubricant.destroy
    respond_to do |format|
      format.html { redirect_to lubricants_url, notice: 'Lubricant was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lubricant
      @lubricant = Lubricant.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lubricant_params
      params.require(:lubricant).permit(:name)
    end
end
