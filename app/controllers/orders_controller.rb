class OrdersController < ApplicationController
  include ActionView::Helpers::NumberHelper
  
  before_filter :authenticate
  before_action :set_order, only: [:show, :edit, :destroy]
  before_filter :protect
  helper_method :sort_column, :sort_direction

  # GET /orders
  # GET /orders.json
  def index
    if params[:search].nil?
      # Order of Individual for approval
      case @current_user.first_check.to_i 
       when  1
         @orders = Order.where(:is_manually_closed => '0', :sub_approval => nil).asc
       when  2 
         @orders = Order.where(:is_manually_closed => '0', :sub_approval => '2').asc 
       when nil
         @orders = Order.where(:is_manually_closed => '0', :sub_approval => '1').asc 
       end
     end
     
    if !params[:search].nil?
      case params[:item][:itemx] 
        when "PO Number"
          @orders = Order.search(params[:search])
        when "Project"
          @orders = Order.search_project(params[:search])
        when "Vendor Name" 
          @orders = Order.search_vendor(params[:search])
        when "Customer"
          @orders = Order.search_customer(params[:search])
       end
    end  
  end #end of index

  # GET /orders/1
  # GET /orders/1.json
  def show
  end
  
  # GET /orders/new
  def new
    @order = Order.new
  end

  
  # GET /orders/1/edit
  def edit
     strApproval = EditService.new.init_process(params[:id],@current_user)
     strApproval.save
     redirect_to orders_path 
     flash[:notice] = msg
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render action: 'show', status: :created, location: @order }
      else
        format.html { render action: 'new' }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    UpdateService.new.init_order_information(params[:order][:acomments], params[:order][:dcomments], @current_user)
   redirect_to orders_path
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url }
      format.json { head :no_content }
    end
  end
  
  def import
    Order.import(params[:file],params[:subject])
    redirect_to  log_in_path
    flash[:notice] = "File Uploaded"   
  end  
  
  def searchz
  end
  
  def watcherz
   @spy = Watcher.all
  end
  
  def approved
    @orders = OrdersService.new.approved(@current_user)
  end
  
  def received
    @orders = OrdersService.new.received(@current_user)
  end
  
  def decline_rpt
    @orders = OrdersService.new.decline_rptset_sort_order(@current_user)
  end
  
  def details
    @str_get_ref_id = Order.find(params[:id])
    # move old comments into larger field  
    if !@str_get_ref_id.decliner_comments.nil?  
       if @str_get_ref_id.dcomments.nil? || @str_get_ref_id.dcomments.size == 0
        @str_get_ref_id.dcomments = @str_get_ref_id.decliner_comments
       end # end size
      #@str_get_ref_id.save
    end #move comments
    
    # move memo and customer comments 
    if !@str_get_ref_id.memo.nil?
      @str_get_ref_id.memot = @str_get_ref_id.memo
    end #end of memo
    
    if !@str_get_ref_id.user_comments.nil?
      @str_get_ref_id.ucommentst = @str_get_ref_id.user_comments
    end #end of comments
    
    str_vendor_ref_id = @str_get_ref_id.ref_number
    @orderln = Ordln.where(:ref_number => str_vendor_ref_id)  
  end # end of details
  
   
  def decline
     @order = Order.find(params[:id])
  end
  
  def undecline
    @order = Order.find(params[:id])
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:time_created, :time_modified, :ref_number, :duedate, :expected_date, :total_amount, :is_manually_closed, :is_fully_received, :custom_field_authorized_buyer, :custom_field_status)
    end
    
    def order_profile_parameters
      params.require(:order).permit(:date_due, :decliner_comments, :dcomments)
    end    
end
