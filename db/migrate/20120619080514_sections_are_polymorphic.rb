class SectionsArePolymorphic < ActiveRecord::Migration
  def up
    add_column :sections, :document_id, :integer
    add_column :sections, :document_type, :string, limit: 16
    add_index :sections, [:document_type, :document_id]
    add_index :sections, [:document_type, :document_id, :lang]

    Section.all.each do |section|
      section.document_id = section.proposal_id
      section.document_type = 'Proposal'
      section.save
    end

    remove_column :sections, :proposal_id
  end

  def down
  end
end
