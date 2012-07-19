class LinksWithDocumentsAndProposalsExperienciesCount < ActiveRecord::Migration
  def up
    add_column :links, :document_id, :integer
    add_column :links, :document_type, :string, limit: 32

    remove_column :links, :resource_id
    remove_column :links, :resource_type

    add_column :proposals, :experiencies_count, :integer, default: 0
    change_column :experiencies, :proposals_count, :integer, default: 0

    migrate_data
  end

  def down
    remove_column :links, :document_id
    remove_column :links, :document_type

    add_column :links, :resource_id, :integer
    add_column :links, :resource_type, :string, limit: 32

    remove_column :proposals, :experiencies_count
  end

  def migrate_data
    PaperTrail.enabled = false
    ActiveRecord::Base.record_timestamps = false

    Link.all.each do |link| 
      say "Link removed #{link.inspect}"
      link.destroy
    end

    Proposal.all.each do |proposal| 
      Proposal.reset_counters proposal.id, :relations
      say "Proposal #{proposal.title}: #{proposal.experiencies_count}"
    end

    Experiencie.all.each do |experiencie|
      Experiencie.reset_counters experiencie.id, :relations
      say "Experiencie #{experiencie.title}: #{experiencie.proposals_count}"
    end
  end
end
