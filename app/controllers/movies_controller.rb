require "json"
require "open-uri"

class MoviesController < ApplicationController
  def index
    query = params[:query]
    url = "https://api.themoviedb.org/3/search/movie?query=#{query}&include_adult=false&language=en-US&page=1%22&api_key=#{ENV['TMDB_API_KEY']}"
    movies_json = JSON.parse(URI.open(url).read)["results"]

    @movies = []
    movies_json.each do |movie|
      if Movie.find_by(title: movie["title"], description:  movie["overview"])
        @movies << Movie.find_by(title: movie["title"], description:  movie["overview"])
      else
        @movies << Movie.new(
          title: movie["title"],
          rating: movie["vote_average"].round(2),
          year: movie["release_date"][0..3],
          description:  movie["overview"],
          poster_url: "http://image.tmdb.org/t/p/w500/#{movie["backdrop_path"] || movie["poster_path"]}",
          vote_count: movie["vote_count"]
          )
      end
    end
    @movies.sort_by!(&:vote_count).reverse!
    @list = List.find(params[:list_id])
  end
end
