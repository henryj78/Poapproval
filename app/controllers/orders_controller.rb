class OrdersController < ApplicationController
  before_filter :authenticate
  before_action :set_order, only: [:show, :edit, :destroy]
  before_filter :protect
  helper_method :sort_column, :sort_direction
  
  # GET /orders
  # GET /orders.json
  def index
    #@search = Order.search(params[:q])
    #@test = @search.result
    
    if params[:search].nil?
      if @current_user.first_check.to_i == 1
        @orders = Order.where(:is_manually_closed => '0', :sub_approval => nil).asc
      else
        @orders = Order.where(:is_manually_closed => '0').asc  
      end  
    else#nil
      if params[:item][:itemx] == "PO Number"
         @orders = Order.search(params[:search])
      end#PO Number
      
      if params[:item][:itemx] == "Project"
         @orders = Order.search_project(params[:search])
      end#PO Number  
      
      if params[:item][:itemx] == "Vendor Name"
         @orders = Order.search_vendor(params[:search])
      end#Vendor Name  
      
      if params[:item][:itemx] == "Customer"
         @orders = Order.search_customer(params[:search])
      end#Customer Name  
                
    end#end nil check
  end

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
     str_approve = Order.find_order(params[:id])
     strApproval = str_approve[0]

     if @current_user.first_check.to_i == 1
       strApproval.sub_approval = 1
     else # boss
       if strApproval.is_manually_closed == 0.to_s
        strApproval.is_manually_closed = 1
        strApproval.custom_field_status = 1 #Approved
        strApproval.approve_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
        strApproval.approve_by = @current_user.first_name + " " + @current_user.last_name
        msg = "PO approval  was successful."
       else
         strApproval.is_fully_received = 1
         strApproval.custom_field_status = 3 #Received
         strApproval.receive_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
         strApproval.receive_by = @current_user.first_name + " " + @current_user.last_name
         msg = "PO was received successfully."
       end
     end # current boss
        
     
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
    cmt = Order.find(params[:id])
    cmt.update!(order_profile_parameters)
    get_comments
    # respond_to do |format|
    #   if @order.update(order_params)
    #     UserMailer.poapproval_email('ihenryjackson@gmail.com').deliver
    #     format.html { redirect_to @order, notice: 'Order was successfully updated.' }
    #     format.json { head :no_content }
    #   else
    #     format.html { render action: 'edit' }
    #     format.json { render json: @order.errors, status: :unprocessable_entity }
    #   end
    # end
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
  
  def approved
    @orders = Order.where(:is_manually_closed => '1', :is_fully_received => nil ).order( sort_column + " " + sort_direction )
  end
  
  def received
    @orders = Order.where(:is_manually_closed => '1', :is_fully_received => '1').order( sort_column + " " + sort_direction )
  end
  
  def details
    @str_get_ref_id = Order.find(params[:id])
    str_vendor_ref_id = @str_get_ref_id.ref_number
    @orderln = Ordln.where(:ref_number => str_vendor_ref_id)     #.group('ord_line_desc','ord_line_amount')
    # if @orderln == []
    #   @orderln = Order.where(:ref_number => str_vendor_ref_id) #.group('ord_line_desc','ord_line_amount')
    # end
  end  
  
  def decline_rpt
    @orders = Order.where(:decline => '1').order(params[:sort])
  end
  
  def get_comments
    @order_decline = Order.find(params[:id])
    @order_decline.is_manually_closed = 3
    @order_decline.is_fully_received = 3
    @order_decline.decline = 1
    @order_decline.custom_field_status = 2 #decline
    @order_decline.decline_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
    @order_decline.decline_by = @current_user.first_name + " " + @current_user.last_name
    @order_decline.save
  end  
  
    
  def decline
     @order = Order.find(params[:id])
     # @order_decline = Order.find(params[:id])
     # @order_decline.is_manually_closed = 3
     # @order_decline.is_fully_received = 3
     # @order_decline.decline = 1
     # @order_decline.custom_field_status = 2 #decline
     # @order_decline.decliner_comments = params[:decline_comment]
     # @order_decline.decline_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
     # @order_decline.decline_by = @current_user.first_name + " " + @current_user.last_name
     # @order_decline.save
     # redirect_to orders_path
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
    
    def sort_column
      #params[:sort] || "ref_number"
      Order.column_names.include?(params[:sort]) ? params[:sort] : "ref_number"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      #params[:direction] || "asc"
    end
    
    def order_profile_parameters
      params.require(:order).permit(:date_due, :decliner_comments)
    end
end
