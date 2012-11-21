class SongsController < ApplicationController
	before_filter :signed_in

	def index
		@songs = current_user.songs
		@rand = @songs[rand(@songs.length)].yt_id unless @songs.empty?
		@song = Song.new
	end

	def create
		current_user.songs.create params[:song]
		flash[:notice] = "Song successfully added"
		return redirect_to index
	end

	def destroy
		Song.find(params[:id]).destroy
		return redirect_to index
	end

	def show
		@yt_id = Song.find(params[:id]).yt_id || 0
		@songs = current_user.songs
	end

private
	 def signed_in
    unless user_signed_in?
      flash[:error] = "Please sign in to continue"
      return redirect_to root_path
    end
  end
end
