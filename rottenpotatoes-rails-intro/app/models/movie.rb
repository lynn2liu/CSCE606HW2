class Movie < ActiveRecord::Base
    # Define the all raiting controller variable
    def self.all_ratings 
        #Pluck documentation found here:
        #https://apidock.com/rails/ActiveRecord/Calculations/pluck
        
        #Much cleaner to use then all.map(&:rating)
        #We must then call uniq afterwards to only have 1 of each rating
        self.pluck(:rating).uniq
    end 

    def self.with_ratings(ratings)
    	
    end 
end
