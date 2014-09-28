class SchoolsController < ApplicationController
  before_filter :authenticate_user!
  before_action :set_school, only: [:show, :edit, :update, :destroy]

  # GET /schools
  # GET /schools.json
  def index
    @schools = School.all
  end

  # GET /schools/1
  # GET /schools/1.json
  def show
    @visits = @school.visits.approved
  end

  # GET /schools/new
  def new
    @school = School.new
  end

  # GET /schools/1/edit
  def edit
  end

  # POST /schools
  # POST /schools.json
  def create
    @school = School.new(school_params)

    respond_to do |format|
      if @school.save
        format.html { redirect_to @school, notice: 'School was successfully created.' }
        format.json { render action: 'show', status: :created, location: @school }
      else
        format.html { render action: 'new' }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /schools/1
  # PATCH/PUT /schools/1.json
  def update
    respond_to do |format|
      if @school.update(school_params)
        format.html { redirect_to @school, notice: 'School was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @school.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /schools/1
  # DELETE /schools/1.json
  def destroy
    @school.destroy
    respond_to do |format|
      format.html { redirect_to schools_url }
      format.json { head :no_content }
    end
  end

  def districts
    if params[:division_id]
      division = Division.find(params[:division_id])
      @districts = division.districts
    else
      @districts = Division.all
    end
    render :json => @districts.collect { |district| {:id => district.id, :name => district.name} }
  end

  def thanas
    if params[:district_id]
      district = District.find(params[:district_id])
      @thanas = district.thanas
    else
      @thanas = District.all
    end
    render :json => @thanas.collect { |thana| {:id => thana.id, :name => thana.name} }
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_school
    @school = School.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def school_params
    params.require(:school).permit(:year, :unique_id, :state, :division_id, :district_id, :thana_id, :union, :title, :headmaster_name, :phone, :boys, :girls, :created_by)
  end
end
