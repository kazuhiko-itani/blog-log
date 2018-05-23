class RelationshipsController < ApplicationController

  before_action :logged_in_user

  def create
  end

  def destroy
  end

  private

  def relationship_params
    params.require(:relationship).permit(:follower_id, :followed_id)
  end
end
