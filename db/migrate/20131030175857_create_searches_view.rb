class CreateSearchesView < ActiveRecord::Migration
  def up
    execute "
    CREATE VIEW searches AS
      SELECT
        proposals.id AS searchable_id,
        'Proposal' AS searchable_type,
        proposal_translations.title,
        '' AS section_title,
        proposal_translations.summary AS text,
        proposal_translations.locale
      FROM proposals
      JOIN proposal_translations ON proposals.id = proposal_translations.proposal_id

      UNION

      SELECT
        experiencies.id AS searchable_id,
        'Experiencie' AS searchable_type,
        experiencie_translations.title,
        '' AS section_title,
        experiencie_translations.summary AS text,
        experiencie_translations.locale
      FROM experiencies
      JOIN experiencie_translations ON experiencies.id = experiencie_translations.experiencie_id

      UNION

      SELECT
        categories.id AS searchable_id,
        'Category' AS searchable_type,
        category_translations.title,
        '' AS section_title,
        category_translations.summary AS text,
        category_translations.locale
      FROM categories
      JOIN category_translations ON categories.id = category_translations.category_id

      UNION

      SELECT
        groups.id AS searchable_id,
        'Group' AS searchable_type,
        group_translations.title,
        '' AS section_title,
        group_translations.summary AS text,
        group_translations.locale
      FROM groups
      JOIN group_translations ON groups.id = group_translations.group_id

      UNION

      SELECT
        sections.document_id AS searchable_id,
        sections.document_type AS searchable_type,
        '' AS title,
        sections.title AS section_title,
        sections.body AS text,
        sections.locale
      FROM sections
      WHERE type = 'TextSection'
    ;"
  end

  def down
    execute "DROP VIEW searches;"
  end
end
