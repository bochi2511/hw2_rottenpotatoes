class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    #debugger
    #raise params.inspect
    sortby = params[:sortby]
    #raise sortby.inspect
    @title_class = ''
    @release_class = ''
    @all_ratings = Movie.get_all_ratings
    @ratings_selected = Hash.new
    if !params[:ratings] then
      @all_ratings.each { |rating| @ratings_selected[rating] = "1" }
    else
      @ratings_selected = params[:ratings]
    end
    case sortby
    when 'title'
      @movies = Movie.all(:order => "title", :conditions => {:rating => @ratings_selected.keys})
      @title_class = 'hilite'
    when 'release'
      @movies = Movie.all(:order => "release_date", :conditions => {:rating => @ratings_selected.keys})
      @release_class = 'hilite'
    else
      @movies = Movie.all(:conditions => {:rating => @ratings_selected.keys})
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
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
