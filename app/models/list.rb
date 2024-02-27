class List < ApplicationRecord
  has_many :bookmarks, dependent: :destroy
  has_many :movies, -> { distinct }, through: :bookmarks

  validates :name, presence: true, uniqueness: true

  def movies
    self.bookmarks.map { |bookmark| bookmark.movie}
  end

  def bookmark_comment(id)
    Bookmark.where(list: self, movie_id: id)[0].comment
  end
end
