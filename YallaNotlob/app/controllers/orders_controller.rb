class OrdersController < ApplicationController
  skip_before_action :verify_authenticity_token
  def index
  end

  def new
  	@order = Order.new
  end

  def create
  	@order = Order.new(order_params)
    puts @order.valid?
    respond_to do |format|
	  	if @order.save
        puts "Oder Invites"
        # @invites = OrderInvite.where(order_id: @order.id)
          # add order invites if the order successfully added
          params[:invited].each { |invite| @order.order_invites.create(order_id: @order.id,user_id: invite) }
          @invites = @order.order_invites
	        format.html { redirect_to @order, notice: 'Order was successfully created.' }
	        format.json { render :show, status: :created, location: @order }
          format.js
		else
	        format.html { render :new }
	        format.json { render json: @order.errors, status: :unprocessable_entity }
          format.js
	    end
	end
  end

  def show
    @invite = current_user.order_invites.find_by(order_id: params[:id])
    if @invite
      @invite.invite_status = "1"
      @invite.save
    else
      render file: "#{Rails.root}/public/404.html", layout: false, status: 404
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @post = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:order_type, :destination, :menu_img, :invited, :user_id)
    end
end
