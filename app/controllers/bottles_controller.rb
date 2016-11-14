class BottlesController < ApplicationController
  before_action :set_profile, only: [:create, :index, :show, :update, :destroy]

  def set_profile
    @user = User.find(params[:user_id])
  end

  def create
    bottle = Bottle.new(bottle_params)
    bottle.user_id = @user.id

    if bottle.save
      render json: {status: 200, message: "Created a bottle", bottle: bottle}
    else
      render json: {status: 422, bottle: bottle.errors}
    end
  end

  def search
    search = params[:search]
    resource = RestClient.get "http://services.wine.com/api/beta2/service.svc/json/catalog?search=#{search}&apikey=#{ENV['WINE_KEY']}"
    result = JSON.parse(resource.body)
    vintage = result['Products']['List'][0]['Vintage'].to_i
    vineyard = result['Products']['List'][0]['Vineyard']['Name']
    red_or_white = result['Products']['List'][0]['Varietal']['WineType']['Name']
    category = result['Products']['List'][0]['Varietal']['Name']
    retail_price = result['Products']['List'][0]['PriceRetail'].to_i
    appellation = result['Products']['List'][0]['Appellation']['Name']
    region = result['Products']['List'][0]['Appellation']['Region']['Name']
    label = result['Products']['List'][0]['Labels'][0]['Url']
    render json: {vintage: vintage, vineyard: vineyard, red_or_white: red_or_white, category: category, retail_price: retail_price, appellation: appellation, region: region, label: label}
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
    params.required(:bottle).permit(:vintage, :vineyard, :red_or_white, :category, :retail_price, :appellation, :region, :label, :image)
  end
end
