class HelpPagesController < ApplicationController
  respond_to :html

  expose(:help_page)

  def show

  end

  def new
    authorize! :create, HelpPage
    respond_with help_page
  end

  def create
    authorize! :create, HelpPage
    if help_page.save
      flash[:notice] = t 'help_pages.notices.created'
      respond_with help_page, location: admin_area_path
    else
      render 'new'
    end
  end

  def edit

  end

  def update
    authorize! :update, help_page
    if help_page.save
      flash[:notice] = t 'help_pages.notices.updated'
      respond_with help_page, location: admin_area_path
    else
      render 'edit'
    end
  end

  def destroy
    authorize! :destroy, help_page
    if help_page.destroy
      flash[:notice] = t 'help_pages.notices.destroyed'
    end
  end
end
