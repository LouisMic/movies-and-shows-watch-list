require "open-uri"
require "json"

url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['TMDB_API_KEY']}"
movie_list = JSON.parse(URI.open(url).read)["results"][0]

# movie_list.each do |movie|
#   Movie.create!(title: movie["title"], rating: movie["vote_average"], year: movie["release_date"][0..3], description:  movie["overview"], poster_url: "http://image.tmdb.org/t/p/w154/#{movie["poster_path"]}")
# end

# movie_list.each do |movie|
#   Movie.find_by(title: movie["title"]).update!(poster_url: "http://image.tmdb.org/t/p/w500#{movie_list[0]["backdrop_path"]}")
# end

Bookmark.delete_all
Movie.delete_all

movie = Movie.create!(title: movie_list["title"], rating: movie_list["vote_average"].round(2), year: movie_list["release_date"][0..3], description:  movie_list["overview"], poster_url: "http://image.tmdb.org/t/p/w500/#{movie_list["backdrop_path"]}")
Bookmark.create!(movie: movie, list: List.find(1), comment: "The best")
