class EditionsController < ApplicationController
  respond_to :html, :js
  expose_parent :document, [:category, :proposal, :experiencie]

  expose(:versions) do
    versions = Version.arel_table
    query = versions[:item_type].eq(document.class.to_s).
      and( versions[:item_id].eq(document.id) )

    section_ids = document.sections.map &:id
    query = query.or(versions[:item_type].eq('Section').
                     and(versions[:item_id].in_any(section_ids)))

    tasks_ids = document.tasks.map &:id
    query = query.or(versions[:item_type].eq('Task').
                     and(versions[:item_id].in_any(tasks_ids)))

    Activity.clean_versions(Version.where(query).order('id DESC'))
  end

  def show
    respond_with document
  end

end
