class AddSubgenreIdToSinglechoice < ActiveRecord::Migration
  def change
    add_column :singlechoices, :subgenre_id, :string
  end
end
