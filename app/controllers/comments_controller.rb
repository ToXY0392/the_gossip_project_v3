class CommentsController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    @gossip = Gossip.find(params[:gossip_id])
    @comment = @gossip.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @gossip, notice: "Commentaire ajouté."
    else
      redirect_to @gossip, alert: "Impossible d'ajouter le commentaire."
    end
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])

    if @comment.update(comment_params)
      redirect_to @comment.gossip, notice: "Commentaire mis à jour."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    gossip = @comment.gossip
    @comment.destroy
    redirect_to gossip, notice: "Commentaire supprimé."
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end
end
