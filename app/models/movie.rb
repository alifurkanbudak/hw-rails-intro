class Movie < ActiveRecord::Base
    def Movie.all_ratings
        ['G','PG','PG-13','R']
    end
    
    def Movie.with_ratings(ratings)
        return Movie.all
        
        # logger.debug("Movie.with_ratings #{ratings}")
        # Movie.where("upper(rating) in ?", ratings)
    end
end