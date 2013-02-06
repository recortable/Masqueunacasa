class PrepareModelSlugsForI18n < ActiveRecord::Migration
  def up
    ## CATEGORIES
    add_column :categories, :slug_en, :string, limit: 100
    add_index :categories, :slug_en

    Category.all.each do |c|
      c.update_column :slug_ca, c.slug_es
      c.update_column :slug_en, c.slug_es
    end

    ## CONTENTS
    rename_column :contents, :slug, :slug_es
    add_column :contents, :slug_ca, :string, limit: 100
    add_column :contents, :slug_en, :string, limit: 100
    add_index :contents, :slug_es
    add_index :contents, :slug_ca
    add_index :contents, :slug_en
    remove_index :contents, :slug

    Content.all.each do |c|
      c.update_column :slug_ca, c.slug
      c.update_column :slug_en, c.slug
    end

    ## EXPERIENCIES
    add_column :experiencies, :slug_en, :string, limit: 100
    add_index :experiencies, :slug_en

    Experiencie.all.each do |e|
      e.update_column :slug_ca, e.slug_es
      e.update_column :slug_en, e.slug_es
    end

    ## PHASES
    add_index :phases, :slug_en
    Phase.all.each do |p|
      p.update_column :slug_ca, p.slug_es
      p.update_column :slug_en, p.slug_es
    end

    ## PROPOSALS
    add_column :proposals, :slug_en, :string
    add_index :proposals, :slug_en

    Proposal.all.each do |p|
      p.update_column :slug_ca, p.slug_es
      p.update_column :slug_en, p.slug_es
    end
  end

  def down
    remove_column :categories, :slug_en

    ## CONTENTS
    rename_column :contents, :slug_es, :slug

    remove_column :contents, :slug_ca, :slug_en

    remove_index :contents, :slug_es
    add_index :contents, :slug

    ## EXPERIENCIES
    remove_column :experiencies, :slug_en

    ## PHASES
    remove_index :phases, :slug_en

    ## PROPOSALS
    remove_column :proposals, :slug_en
  end
end
