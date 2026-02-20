class GossipsController < ApplicationController
  before_action :require_login, only: [:new, :create, :show]

  def show
    @gossip = Gossip.find(params[:id])
  end

  def edit
    @gossip = Gossip.find(params[:id])
    return redirect_to root_path, alert: "Accès refusé." unless current_user == @gossip.user
    @tags = Tag.all
  end

  def new
    @gossip = Gossip.new
    @tags = Tag.all
  end

  def create
    @gossip = current_user.gossips.create(gossip_params)
    @gossip.tag_ids = [params[:gossip][:tag_id]].compact if params[:gossip][:tag_id].present?

    if @gossip.save
      redirect_to @gossip, notice: "Ton potin a été créé avec succès."
    else
      @tags = Tag.all
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @gossip = Gossip.find(params[:id])
    return redirect_to root_path, alert: "Accès refusé." unless current_user == @gossip.user

    if @gossip.update(gossip_params)
      @gossip.tag_ids = [params[:gossip][:tag_id]].compact if params[:gossip][:tag_id].present?
      redirect_to @gossip, notice: "Ton potin a été mis à jour."
    else
      @tags = Tag.all
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    return redirect_to root_path, alert: "Accès refusé." unless current_user == @gossip.user
    @gossip.destroy
    redirect_to root_path, notice: "Le potin a été supprimé."
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content, tag_ids: [])
 
  end
end
