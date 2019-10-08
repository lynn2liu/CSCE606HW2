class MoviesController < ApplicationController

  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    # Get all possible ratings from movie model
    @all_ratings = Movie.all_ratings

    # These OR statements are necessary in order to maintain consistent
    # states (Aka, keep the same boxes checked on refresh)
    @sort = params[:sort] || session[:sort]
    @ratings = params[:ratings] || session[:ratings]

    # I do not think this is the best way to do this, but after several hours
    # this seemed to be the most concise and easiest for me to understand.
    if @sort and !@ratings
      session[:sort] = @sort
      @movies = Movie.order(@sort.to_sym)
    elsif @ratings and !@sort
      session[:ratings] = @ratings
      @movies = Movie.where(rating: @ratings.keys)
    elsif @sort and @ratings 
      session[:sort] = @sort
      session[:ratings] = @ratings
      @movies = Movie.where(rating: @ratings.keys).order(@sort.to_sym)
    else 
      @movies = Movie.all
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
