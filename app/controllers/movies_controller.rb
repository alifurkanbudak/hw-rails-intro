class MoviesController < ApplicationController

    def show
      id = params[:id] # retrieve movie ID from URI route
      @movie = Movie.find(id) # look up movie by unique ID
      # will render app/views/movies/show.<extension> by default
    end
  
    def index
      if (params['sort'].nil? && !session['sort'].nil?) || (params['ratings'].nil? && !session['ratings'].nil?)
        flash.keep
        
        redirect_to movies_path(
          sort: params['sort'].nil? ? session['sort'] : params['sort'],
          ratings: params['ratings'].nil? ? session['ratings'] : params['ratings'],
        )
        return
      end
      
      session['sort'] = params['sort']
      session['ratings'] = params['ratings']
      
      @all_ratings = Movie.all_ratings
      @selected_ratings = params[:ratings].nil? ? Movie.all_ratings : params[:ratings].keys
      @movies = Movie.with_ratings(@selected_ratings)
      
      
      selected_header_class = "hilite bg-warning"
      if params['sort'] == 'title'
        @title_class = selected_header_class
        @movies = @movies.order(:title)
      elsif params['sort'] == 'date'
        @date_class = selected_header_class
        @movies = @movies.order(:release_date)
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
  
    private
    # Making "internal" methods private is not required, but is a common practice.
    # This helps make clear which methods respond to requests, and which ones do not.
    def movie_params
      params.require(:movie).permit(:title, :rating, :description, :release_date)
    end
end
