class AddPositionToImages < ActiveRecord::Migration
  def change
    add_column :images, :position, :integer

    Experiencie.all.each do |exp|
      exp.images.each_with_index do |image, index|
        image.update_attribute(:position, index + 1)
      end
    end
  end
end
