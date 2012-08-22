class AddEditorshipsToModels < ActiveRecord::Migration
  def change
    [Category, Proposal, Experiencie].each do |klass| 
      say "Appling to #{klass}"
      klass.all.each do |model|
        Activities.document_activity(model).each do |version|
          user = User.find_by_id(version.whodunnit)
          model.add_editor(user)
        end
      end
    end
  end
end
