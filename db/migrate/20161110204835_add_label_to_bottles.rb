class AddLabelToBottles < ActiveRecord::Migration[5.0]
  def change
    add_column :bottles, :label, :string
  end
end
