class WelcomeController < ApplicationController
	skip_before_action :authorized
	
	def index
		render 'index'
	end
end
