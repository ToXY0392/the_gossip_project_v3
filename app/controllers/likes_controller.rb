class LikesController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    likeable = find_likeable
    like = Like.find_or_initialize_by(user: current_user, likeable: likeable)

    if like.persisted? || like.save
      redirect_back fallback_location: root_path, notice: "Potin liké."
    else
      redirect_back fallback_location: root_path, alert: "Impossible d'ajouter le like."
    end
  end

  def destroy
    like = Like.find(params[:id])

    if current_user && like.user == current_user
      like.destroy
      redirect_back fallback_location: root_path, notice: "Like retiré."
    else
      redirect_back fallback_location: root_path, alert: "Accès refusé."
    end
  end

  private

  def find_likeable
    case params[:likeable_type]
    when "Gossip"
      Gossip.find(params[:likeable_id])
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end

