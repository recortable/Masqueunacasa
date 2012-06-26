class SectionsController < ApplicationController
  respond_to :html

  expose_parent :document, [:phase, :category, :proposal, :experiencie, :post, :page, :user, :group]
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

  def up
    s = Section.find params[:id]
    s.move_higher
    respond_with s, location: document_location(s)
  end

  def down
    s = Section.find params[:id]
    s.move_lower
    respond_with s, location: document_location(s)
  end

  private
  def document_location(s = nil)
    s ||= section
    s.title? ? 
      url_for(s.document) + "##{s.title}" :
      url_for(s.document) + "##{s.id}"
  end

end
