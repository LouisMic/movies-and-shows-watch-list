require "open-uri"
require "json"

url = "https://api.themoviedb.org/3/movie/top_rated?api_key=#{ENV['TMDB_API_KEY']}"
# movie_list = JSON.parse(URI.open(url).read)["results"]

# movie_list.each do |movie|
#   Movie.create!(title: movie["title"], rating: movie["vote_average"], year: movie["release_date"][0..3], description:  movie["overview"], poster_url: "http://image.tmdb.org/t/p/w154/#{movie["poster_path"]}")
# end

puts url
