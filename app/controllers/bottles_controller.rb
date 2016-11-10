class BottlesController < ApplicationController
  before_action :set_profile, only: [:create, :index, :show, :update, :destroy]

  def set_profile
    @user = User.find(params[:user_id])
  end

  def create
    bottle = Bottle.new(bottle_params)
    bottle.user_id = @user.id

    if bottle.save
      render json: {status: 200, message: "Created a bottle"}
    else
      render json: {status: 422, bottle: bottle.errors}
    end
  end

  def search
    search = params[:search]
    resource = RestClient::Resource.new "http://services.wine.com/api/beta2/service.svc/json/catalog?search=#{search}&apikey=#{ENV['WINE_KEY']}"
    render json: {test: resource.get, search: search}
  end

  def index
    bottles = @user.bottles

    render json: {status: 200, bottles: bottles}
  end

  def show
    bottle = @user.bottles.find(params[:id])

    render json: {status: 200, bottle: bottle}
  end

  def update
    bottle = @user.bottles.find(params[:id])

    if bottle.update(bottle_params)
      render json: {status: 200, bottle: bottle}
    else
      render json: {status: 204, message: bottle.errors}
    end

  end

  def destroy
    bottle = @user.bottles.find(params[:id])
    bottle.destroy

    render json: {status: 204}
  end


  private

  def bottle_params
    params.required(:bottle).permit(:vintage, :vineyard, :type, :category, :retail_price, :appellation, :region)
  end
end
