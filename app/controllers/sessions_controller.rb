class SessionsController < ApplicationController
  def new
  end

  def create
    email    = params[:email].to_s.strip
    password = params[:password]

    user = User.find_by(email: email)

    if user&.authenticate(password)
      session[:user_id] = user.id
      redirect_to root_path, notice: "Connecté en tant que #{user.first_name}."
    else
      flash.now[:alert] = "Email ou mot de passe incorrect."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Tu es maintenant déconnecté."
  end
end

