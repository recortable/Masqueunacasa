class AddQuestionToPhases < ActiveRecord::Migration
  def change
    add_column :phases, :title_en, :string, limit: 50
    add_column :phases, :slug_en, :string, limit: 50
    add_column :phases, :question_es, :string, limit: 300
    add_column :phases, :question_ca, :string, limit: 300
    add_column :phases, :question_en, :string, limit: 300
  end
end
