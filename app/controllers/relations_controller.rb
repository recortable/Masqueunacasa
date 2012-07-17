# Relations Controller
class RelationsController < ApplicationController
  respond_to :html

  expose_parent :parent, [:proposal, :experiencie]
  expose(:relations) { proposal.relations }
  expose(:relation)

  expose(:valid_term?) { params[:term].present? }
  expose(:results) { Experiencie.search(params[:term]) if valid_term? }

  def new
    authorize! :create, Relation
  end

  def create
    authorize! :create, Relation
    target = Experiencie.find(params[:e])
    relation = parent.add_relation(target, current_user)
    flash[:notice] = t('relations.notices.created') 
    respond_with relation, location: parent
  end

  def destroy
    authorize! :destroy, relation
    flash[:notice] = t('relations.notices.destroyed') if relation.destroy
    respond_with relation, location: parent
  end
end
