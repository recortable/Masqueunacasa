class AnnouncementsController < ApplicationController
  respond_to :html

  expose(:announcements) { current_group.announcements }
  expose(:announcement)

  def index
    authorize! :index, Announcement
    respond_with announcements
  end

  def show
    authorize! :read, announcement
    respond_with announcement
  end

  def new
    authorize! :new, Announcement
    respond_with announcement
  end

  def edit
    authorize! :edit, announcement
    respond_with announcement
  end

  # AQUÍ NO SE ENVÍAN LOS EMAILS. SÓLO SE GUARDAN (por si hace falta
  # editar)
  def create
    announcement.user = current_user
    announcement.group = current_group
    authorize! :create, announcement
    flash[:notice] = t('announcements.notices.created') if announcement.save
    respond_with announcement
  end

  def update
    announcement.attributes = params[:announcement]
    authorize! :update, announcement
    flash[:notice] = t('announcement.notices.updated') if announcement.save
    respond_with announcement
  end

  def probe
    # TODO: enviar el correo al current_user
    redirect_to announcement
  end

  def send_email
    # TODO: enviar el correo y marcar como enviado
    redirect_to announcement
  end

end
