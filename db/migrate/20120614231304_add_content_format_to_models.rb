class AddContentFormatToModels < ActiveRecord::Migration
  def change
    [Content, Category, Proposal, Experiencie].each do |model|
      add_column model.table_name, :body_type, :string, limit: 16
      model.update_all(body_type: 'html')
    end
  end
end
