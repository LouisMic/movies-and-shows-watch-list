require "json"
require "open-uri"

class BookmarksController < ApplicationController
  before_action :set_list

  def new
    movies_json = load_movies_json
    @movies = []
    create_movies(movies_json, @movies)
    @movies.sort_by!(&:vote_count).reverse!
  end

  def create
    if Movie.find(movie_params[:id])
      movie = Movie.find(movie_params[:id])
    else
      movie = Movie.create!(movie_params)
    end
    create_bookmark(@list, movie)
  end

  def destroy
    @bookmark = Bookmark.find_by(list: @list, movie_id: params[:movie_id])
    @bookmark.destroy
    redirect_to list_path(List.find(params[:list_id])), status: :see_other
  end

  private

  def load_movies_json
    query = params[:query]
    url = "https://api.themoviedb.org/3/search/movie?query=#{query}&include_adult=false&language=en-US&page=1%22&api_key=#{ENV['TMDB_API_KEY']}"
    JSON.parse(URI.open(url).read)["results"]
  end

  def create_movies(movie_json, movie_array)
    movie_json.each do |movie|
      saved_movie = Movie.find_by(title: movie["title"], description:  movie["overview"])
      if saved_movie
        movie_array << saved_movie
      else
        movie_array << Movie.new(
          title: movie["title"],
          rating: movie["vote_average"].round(2),
          year: movie["release_date"][0..3],
          description:  movie["overview"],
          poster_url: "http://image.tmdb.org/t/p/w500/#{movie["backdrop_path"] || movie["poster_path"]}",
          vote_count: movie["vote_count"]
          )
      end
    end
  end

  def movie_params
    params.require(:movie).permit(:id, :year, :title, :rating, :vote_count, :description, :poster_url)
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def create_bookmark(list, movie)
    bookmark = Bookmark.create(list: list, movie: movie, comment: params[:comment])
    if bookmark.save
      redirect_to list_path(list)
    else
      render "lists/show", status: :unprocessable_entity
    end
  end
end
