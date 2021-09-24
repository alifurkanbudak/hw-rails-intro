class Movie < ActiveRecord::Base
    def Movie.all_ratings
        ['G','PG','PG-13','R']
    end
    
    def Movie.with_ratings(ratings)
        Movie.where('"rating"' +
                         " ILIKE ANY ( array[?] )", ratings)
    end
end