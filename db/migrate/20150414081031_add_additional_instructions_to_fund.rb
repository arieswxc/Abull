class AddAdditionalInstructionsToFund < ActiveRecord::Migration
  def change
    add_column :funds, :additional_instructions, :string
  end
end
