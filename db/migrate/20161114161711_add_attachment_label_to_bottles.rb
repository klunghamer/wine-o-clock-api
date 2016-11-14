class AddAttachmentLabelToBottles < ActiveRecord::Migration
  def self.up
    change_table :bottles do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :bottles, :image
  end
end
