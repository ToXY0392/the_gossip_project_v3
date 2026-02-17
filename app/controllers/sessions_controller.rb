class SessionsController < ApplicationController
  def new
  end

  def create
    first_name = params[:first_name].to_s.strip
    last_name  = params[:last_name].to_s.strip

    user = User.find_by(first_name: first_name, last_name: last_name)

    if user
      session[:user_id] = user.id
      redirect_to root_path, notice: "Connecté en tant que #{user.first_name}."
    else
      flash.now[:alert] = "Aucun profil trouvé pour ce nom."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: "Tu es maintenant déconnecté."
  end
end

