class RenameQuestionInCategories < ActiveRecord::Migration
  def up
    add_column :categories, :name_es, :string, limit: 100
    add_column :categories, :name_ca, :string, limit: 100
    change_column :categories, :title_es, :string, limit: 300
    change_column :categories, :title_ca, :string, limit: 300
    execute "update categories set name_es=title_es"
    execute "update categories set name_ca=title_ca"
    execute "update categories set title_es=question_es"
    execute "update categories set title_ca=question_ca"
    remove_column :categories, :question_es
    remove_column :categories, :question_ca
  end

  def down
    add_column :categories, :question_es, limit: 300
    add_column :categories, :question_ca, limit: 300
    execute "update categories set question_es=title_es"
    execute "update categories set question_ca=title_ca"
    execute "update categories set title_es=name_es"
    execute "update categories set title_ca=name_ca"
    remove_column :categories, :name_es
    remove_column :categories, :name_ca
  end
end
