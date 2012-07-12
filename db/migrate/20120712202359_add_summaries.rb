class AddSummaries < ActiveRecord::Migration
  TABLES = [:contents, :proposals, :experiencies, 
   :categories, :phases]
  def change

    TABLES.each do |table|
      [:es, :ca, :en].each do |lang|
        add_column table, "summary_#{lang}", :text
      end
    end

    TABLES.delete :contents

    TABLES.each do |table|
      klass = table.to_s.classify.constantize
      klass.all.each do |model|
        section = model.sections.first
        if section
          model.summary_es = section.body
          model.save
          section.destroy
        end
      end      
    end
  end
end
