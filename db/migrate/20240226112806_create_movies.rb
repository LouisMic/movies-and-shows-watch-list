class CreateMovies < ActiveRecord::Migration[7.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.string :poster_url
      t.integer :year
      t.string :genre
      t.float :rating
      t.text :description

      t.timestamps
    end
  end
end
