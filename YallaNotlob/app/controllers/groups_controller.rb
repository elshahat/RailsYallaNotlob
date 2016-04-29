class GroupsController < ApplicationController
	def new
		@group = Group.all
	end

	def create
		@user = current_user
		@group = @user.groups.create(group_params)
		redirect_to :back
		#group_path(@group)
		#redirect_to :action => 'suppliers', :id => @product.id 

	end

	#show the groups
	def show
		@group = Group
	end

	def destroy
		@group = Group.find(params[:id])
		@group.destroy
		redirect_to :back
	end

	private
	def group_params
		params.require(:group).permit(:name)
	end
end
