class GroupsController < ApplicationController
	def new
	end

	def create
		@user = current_user
		@group = @user.groups.create(group_params)
		redirect_to group_path(@group)
		#redirect_to :action => 'suppliers', :id => @product.id 

	end

	#show the groups
	def show
		@group = Group
	end

	private
	def group_params
		params.require(:group).permit(:name)
	end
end
