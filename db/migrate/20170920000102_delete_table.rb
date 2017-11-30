class DeleteTable < ActiveRecord::Migration
  def change
  drop_table :singlechoices
  end
end
