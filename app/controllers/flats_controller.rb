class FlatsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index]
  def index
    @flats = if params[:query].presence
                Flat.where('name LIKE ? OR address LIKE ?', "%#{params[:query]}%", "%#{params[:query]}%")
            else
              Flat.all
            end
    end

  def new
    @flat = Flat.new
  end

  def create
    @flat = current_user.flats.build(flats_params)
    if @flat.save
      redirect_to flats_path, notice: 'Flat was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @flat = Flat.find(params[:id])
  end

  def edit
    @flat = Flat.find(params[:id])
  end

  def update
    @flat = Flat.find(params[:id])
    if @flat.update(flats_params)
      redirect_to flats_path, notice: 'Flat was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def my_flats
    @flats = current_user.flats
  end

  def destroy
    @flat = Flat.find(params[:id])
    @flat.destroy
    redirect_to flats_path, notice: 'Flat was successfully deleted.'
  end

  private

  def flats_params
    params.require(:flat).permit(:name, :address, :description, :price_per_night, :number_of_guests, :picture_url, :available_from, :available_to)
  end
end
