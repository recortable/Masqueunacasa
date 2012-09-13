# encoding: utf-8
class SectionsController < ApplicationController
  respond_to :html

  expose_parent :document, [:phase, :category, :proposal, :experiencie, :post, :page, :user, :group]
  expose(:sections) { document.sections(:es) }
  expose(:section)

  expose(:with_banner) do
    [:Page, :Group, :Post].include?(document.class.to_s.to_sym)
  end

  def new
    authorize! :create, section
    polymorphic_breadcrumb_for(document)
    add_breadcrumb 'Añadir sección', polymorphic_path([:new, document, :section])
    respond_with section
  end

  def edit
    authorize! :edit, section
    polymorphic_breadcrumb_for(document)
    add_breadcrumb 'Editar sección', polymorphic_path([:edit, document, section])
    respond_with section
  end

  def show
    redirect_to document_location
  end

  def create
    authorize! :create, section
    polymorphic_breadcrumb_for(document)
    add_breadcrumb 'Añadir sección', polymorphic_path([:new, document, :section])
    flash[:notice] = 'Contenido guardado' if document.add_section(section, current_user)
    respond_with section, location: document_location
  end

  def update
    authorize! :update, section
    section.save
    respond_with section, location: document_location
  end

  def destroy
    authorize! :destroy, section
    section.destroy
    respond_with section, location: document_location(section)
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

  def remove_image
    s = Section.find params[:id]
    # https://github.com/jnicklas/carrierwave/issues/401
    s.remove_image = true
    s.image_position = nil
    s.save!
    respond_with s, location: [:edit, s.document, s]
  end

  private
  def document_location(s = nil)
    s ||= section
    s.title? ? 
      loc = url_for(s.document) + "##{s.title}" :
      loc = url_for(s.document) + "##{s.id}"
    if s.document.class == Group
      loc = profile_path
    end
    loc
  end

end
