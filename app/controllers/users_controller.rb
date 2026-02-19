class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :ensure_current_user_owns_profile, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    assign_city_from_params

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Profil créé, tu es maintenant connecté en tant que #{@user.first_name}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    assign_city_from_params

    if @user.update(user_params)
      redirect_to @user, notice: "Profil mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def ensure_current_user_owns_profile
    redirect_to root_path, alert: "Accès refusé." unless current_user == @user
  end

  def assign_city_from_params
    name = params[:user][:city_name].to_s.strip
    zip  = params[:user][:city_zip_code].to_s.strip

    return if name.blank? && zip.blank?

    if name.blank? || zip.blank?
      @user.errors.add(:city, "doit avoir un nom et un code postal")
      return
    end

    @user.city = City.find_or_create_by!(name: name, zip_code: zip)
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :age,
      :description
    )
  end
end
