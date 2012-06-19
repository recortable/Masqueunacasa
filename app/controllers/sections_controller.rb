class SectionsController < ApplicationController
  respond_to :html

  expose_parent :document, [:proposal, :experiencie, :page]
  expose(:sections) { document.sections(:es) }
  expose(:section)

  def new
    authorize! :create, section
  end

  def edit
    authorize! :edit, section
  end

  def create
    section.document = document
    section.lang = I18n.locale
    section.body_type ||= 'markdown'
    authorize! :create, section
    section.save
    respond_with section, location: document_location
  end

  def update
    section.attributes = params[:section]
    authorize! :update, section
    section.save
    respond_with section, location: document_location
  end

  private
  def document_location
    section.title? ? 
      url_for(document) + "##{section.title}" :
      url_for(document)
  end

end
