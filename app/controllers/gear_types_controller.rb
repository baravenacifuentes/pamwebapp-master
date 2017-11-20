class GearTypesController < ApplicationController
	before_action :set_gear_type, only: [:show, :edit, :update, :destroy]

	# GET /gear_types
	# GET /gear_types.json
	def index
		@gear_types = GearType.all
	end

	# GET /gear_types/1
	# GET /gear_types/1.json
	def show
	end

	# GET /gear_types/new
	def new
		@gear_type = GearType.new
	end

	# GET /gear_types/1/edit
	def edit
	end

	# POST /gear_types
	# POST /gear_types.json
	def create
		@gear_type = GearType.new(gear_type_params)

		respond_to do |format|
			if @gear_type.save
				format.html { redirect_to @gear_type, notice: 'Gear type was successfully created.' }
				format.json { render :show, status: :created, location: @gear_type }
			else
				format.html { render :new }
				format.json { render json: @gear_type.errors, status: :unprocessable_entity }
			end
		end
	end

	# PATCH/PUT /gear_types/1
	# PATCH/PUT /gear_types/1.json
	def update
		respond_to do |format|
			if @gear_type.update(gear_type_params)
				format.html { redirect_to @gear_type, notice: 'Gear type was successfully updated.' }
				format.json { render :show, status: :ok, location: @gear_type }
			else
				format.html { render :edit }
				format.json { render json: @gear_type.errors, status: :unprocessable_entity }
			end
		end
	end

	# DELETE /gear_types/1
	# DELETE /gear_types/1.json
	def destroy
		@gear_type.destroy
		respond_to do |format|
			format.html { redirect_to gear_types_url, notice: 'Gear type was successfully destroyed.' }
			format.json { head :no_content }
		end
	end

	private
	# Use callbacks to share common setup or constraints between actions.
	def set_gear_type
		@gear_type = GearType.find(params[:id])
	end

	# Never trust parameters from the scary internet, only allow the white list through.
	def gear_type_params
		params.require(:gear_type).permit(:name)
	end
end
