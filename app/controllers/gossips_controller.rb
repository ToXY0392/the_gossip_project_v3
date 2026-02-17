class GossipsController < ApplicationController
  def show
    @gossip = Gossip.find(params[:id])
  end

  def edit
    @gossip = Gossip.find(params[:id])
    return redirect_to root_path, alert: "Accès refusé." unless current_user == @gossip.user
  end

  def new
    @gossip = Gossip.new
  end

  def create
    # Si un user est connecté, on l'utilise comme auteur.
    # Sinon, on choisit un auteur aléatoire parmi les utilisateurs existants.
    author = current_user || User.all.sample

    unless author
      redirect_to root_path, alert: "Aucun auteur disponible pour ce potin. Crée d'abord un profil."
      return
    end

    @gossip = author.gossips.new(gossip_params)

    if @gossip.save
      redirect_to @gossip, notice: "Ton potin a été créé avec succès."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    @gossip = Gossip.find(params[:id])
    return redirect_to root_path, alert: "Accès refusé." unless current_user == @gossip.user

    if @gossip.update(gossip_params)
      redirect_to @gossip, notice: "Ton potin a été mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @gossip = Gossip.find(params[:id])
    @gossip.destroy
    redirect_to root_path, notice: "Le potin a été supprimé."
  end

  private

  def gossip_params
    params.require(:gossip).permit(:title, :content)
  end
end
