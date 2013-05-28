class PrepareModelSlugsForI18n < ActiveRecord::Migration
  def up
    ## CATEGORIES
    add_column :categories, :slug_en, :string, limit: 100
    add_column :categories, :slug_it, :string, limit: 100
    add_column :categories, :slug_fr, :string, limit: 100
    add_index :categories, :slug_en
    add_index :categories, :slug_it
    add_index :categories, :slug_fr

    Category.all.each do |c|
      c.update_column :slug_ca, c.slug_es
      c.update_column :slug_en, c.slug_es
      c.update_column :slug_it, c.slug_es
      c.update_column :slug_en, c.slug_es
    end

    ## EXPERIENCIES
    add_column :experiencies, :slug_en, :string, limit: 100
    add_column :experiencies, :slug_it, :string, limit: 100
    add_column :experiencies, :slug_fr, :string, limit: 100
    add_index :experiencies, :slug_en
    add_index :experiencies, :slug_it
    add_index :experiencies, :slug_fr

    Experiencie.all.each do |e|
      e.update_column :slug_ca, e.slug_es
      e.update_column :slug_en, e.slug_es
      e.update_column :slug_it, e.slug_es
      e.update_column :slug_fr, e.slug_es
    end

    ## PHASES
    add_column :phases, :slug_it, :string, limit: 100
    add_column :phases, :slug_fr, :string, limit: 100
    add_index :phases, :slug_en
    add_index :phases, :slug_it
    add_index :phases, :slug_fr
    Phase.all.each do |p|
      p.update_column :slug_ca, p.slug_es
      p.update_column :slug_en, p.slug_es
      p.update_column :slug_it, p.slug_es
      p.update_column :slug_fr, p.slug_es
    end

    ## PROPOSALS
    add_column :proposals, :slug_en, :string, limit: 100
    add_column :proposals, :slug_it, :string, limit: 100
    add_column :proposals, :slug_fr, :string, limit: 100
    add_index :proposals, :slug_en
    add_index :proposals, :slug_it
    add_index :proposals, :slug_fr

    Proposal.all.each do |p|
      p.update_column :slug_ca, p.slug_es
      p.update_column :slug_en, p.slug_es
      p.update_column :slug_it, p.slug_es
      p.update_column :slug_fr, p.slug_es
    end
  end

  def down
    ## CATEGORIES
    remove_column :categories, :slug_en
    remove_column :categories, :slug_it
    remove_column :categories, :slug_fr

    ## EXPERIENCIES
    remove_column :experiencies, :slug_en, :slug_it, :slug_fr

    ## PHASES
    remove_column :phases, :slug_it, :slug_fr
    remove_index :phases, :slug_en

    ## PROPOSALS
    remove_column :proposals, :slug_en, :slug_it, :slug_fr
  end
end
