class CreateSongs < ActiveRecord::Migration
  def change
    create_table :songs do |t|
    	t.references :user
    	t.string :name
    	t.string :yt_id
      t.timestamps
    end
    add_index :songs, :name
    add_index :songs, :user_id
    add_index :songs, :yt_id
  end
end
