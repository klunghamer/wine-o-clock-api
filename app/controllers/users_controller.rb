class UsersController < ApplicationController
  before_action :set_profile, only: [:update, :show]

  def set_profile
    @user = User.find(params[:id])
  end

  def create
      user = User.new(user_params)
      if user.save
        render json: {status: 200, message: "Registration Succesful"}
      else
        render json: {status: 422, user: user.errors}
      end
    end

  def login
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      token = token(user.id, user.email)
      render json: {status: 201, token: token, user: user}
    else
      render json: {status: 401, message: "unauthorized"}
    end
  end

  def index
    users = User.all

    render json: {users: users}
  end

  def show
    render json: {user: @user}
  end

  def update
    if @user.update(pass_params)
      render json: {status: 200, user: @user}
    else
      render json: {status: 204, message: @user.errors}
    end
  end

  private

  def token(id, email)
    JWT.encode(payload(id, email), ENV['JWT_SECRET'], 'HS256')
  end

  def payload(id, email)
    {
      exp: (Time.now + 2.minutes).to_i,
      iat: Time.now.to_i,
      iss: ENV['JWT_ISSUER'],
      user: {
        id: id,
        email: email
      }
    }
  end

  def user_params
    params.required(:user).permit(:first_name, :last_name, :email, :password)
  end

  def pass_params
    params.required(:user).permit(:password, :email)
  end

end
