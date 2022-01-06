class ApplicationController < ActionController::API
	before_action :authorized

	def encode_token(payload)
		# JWT.encode(payload, ENV["JWT_TOKEN_SECRET"])
		
		JWT.encode(payload, "squish_all_of_the_bugs!")
				# TODO: This is just for debugging!!! I swear to god if you leave this in here for production...

	end

	def auth_header
		request.headers['Authorization']
	end

	def decoded_token
		if auth_header
			token = auth_header.split(' ')[1]
			begin
				# JWT.decode(token, ENV["JWT_TOKEN_SECRET"], true, algorithm: 'HS256')
				JWT.decode(token, "squish_all_of_the_bugs!", true, algorithm: 'HS256')
				# TODO: This is just for debugging!!! I swear to god if you leave this in here for production...
			rescue JWT::DecodeError
				nil
			end
		end
	end

	def current_user
		if decoded_token
			user_id = decoded_token[0]['user_id']
			@user = User.find_by(id: user_id)
		end
	end

	def logged_in?
		!!current_user
	end

	def authorized
		render json: { message: 'Please log in'}, status: :unauthorized unless logged_in?
	end
end
