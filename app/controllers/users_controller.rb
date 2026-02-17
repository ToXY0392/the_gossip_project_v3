class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    # Remplit les champs obligatoires non présents dans le formulaire
    if @user.email.blank?
      base = "#{@user.first_name}.#{@user.last_name}".downcase.gsub(/\s+/, ".")
      @user.email = "#{base}+#{Time.now.to_i}@example.com"
    end

    @user.city ||= City.first || City.create!(name: "Paris", zip_code: "75000")

    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Profil créé, tu es maintenant connecté en tant que #{@user.first_name}."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name)
  end
end
