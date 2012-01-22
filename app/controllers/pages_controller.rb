class PagesController < ApplicationController

  	before_filter :authenticate, :only => [:profile,:chatter]

	def home
    	@title = 'Home'
    	if params.key?(:sm) && !params[:sm].blank?
    		
 			case params[:sm] 
        		when '0'
        		flash[:success] = "You've successfully signed out!"
        		when '1'
        		flash[:notice] = "Your session has expired. Please login."
        	end

    	end
	end

    def profile
        @title = 'Profile'
        @me = Databasedotcom::Chatter::User.find(session[:client], "me")

    end

    def chatter
        @title = 'Chatter'
    end

end