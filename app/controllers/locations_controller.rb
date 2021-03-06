class LocationsController < ApplicationController
  before_action :set_location, only: [:show, :edit, :destroy, :update]
  before_action :set_company
  before_filter :authorize, except: [:index, :show]

  def index
    @locations = @company.locations
  end

  def show
    # @location = @company.location
  end

  def new
    @location = location.new
  end

  def edit
  end

  def create
    @location = Location.new(location_params)
    @location.company_id = params[:company_id]
    if @location.save
      redirect_to company_location_path(@company, @location)
    else
      render :new
    end
  end

  def update
    if @location.update
      redirect_to company_location_path(@company, @location)
    else
      render :edit
    end
  end

  def destroy
    @location.destroy
    if @location.destroy
      redirect_to companies_path
    end
  end

  private

  def set_location
    @location = Location.find(params[:id])
  end

  def set_company
    @company = Company.find(params[:company_id])
  end

  def location_params
    params.require(:location).permit(:city, :street_name, :state, :zip_code, :country)
  end

end
