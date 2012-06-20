class PreparePhasesToHaveSections < ActiveRecord::Migration
  def change
    rename_column :phases, :name_es, :title_es
    rename_column :phases, :name_ca, :title_ca
    remove_column :phases, :description_es
    remove_column :phases, :description_ca
  end

end
