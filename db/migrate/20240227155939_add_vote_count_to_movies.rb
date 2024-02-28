class AddVoteCountToMovies < ActiveRecord::Migration[7.1]
  def change
    add_column :movies, :vote_count, :integer
  end
end
