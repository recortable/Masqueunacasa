class EditionsController < ApplicationController
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

    clean_versions(Version.where(query).order('id DESC'))
  end

  def show

  end

  protected
  def clean_versions(versions)
    prev = nil
    versions.select do |version|
      like_prev = prev && prev.item_type == version.item_type && prev.item_id == version.item_id && prev.whodunnit == version.whodunnit 
      prev = version
      !like_prev
    end
  end
end
