class AddGenreIdToSinglechoice < ActiveRecord::Migration
  def change
    add_column :singlechoices, :genre_id, :string
  end
end
