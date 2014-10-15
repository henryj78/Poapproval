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
      if @current_user.first_check.to_i == 1
        @orders = Order.where(:is_manually_closed => '0', :sub_approval => nil).asc
      end
      
      if @current_user.first_check.to_i == 2
        @orders = Order.where(:is_manually_closed => '0', :sub_approval => '2').asc  
      end  
    
      if @current_user.first_check.nil?
        @orders = Order.where(:is_manually_closed => '0', :sub_approval => '1').asc 
      end
      
    else#nil - Search
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
                
    end #end nil check
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
     str_approve = Order.find_order(params[:id])
     strApproval = str_approve[0]

     if @current_user.first_check.to_i == 1
       task = 'Approved'
       spy(strApproval,task)
       strApproval.sub_approval = 1
       strApproval.track = 1
     end # Commodity Manger - Stephen Morrish
     
     # if @current_user.first_check.to_i == 2
     #   task = 'Approved'
     #   spy(strApproval,task)
     #   strApproval.sub_approval = 1
     #   strApproval.track = 1
     # end # Production Manger - Jason Hall
     
     if @current_user.first_check.nil?
       if strApproval.is_manually_closed == 0.to_s
         strApproval.is_manually_closed = 1
         strApproval.custom_field_status = 1 #Approved
         strApproval.approve_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
         strApproval.approve_by = @current_user.first_name + " " + @current_user.last_name
         strApproval.track = 2
         strApproval.po_status = 'Approved'
         msg = "PO approval  was successful."
         
         #record who approved
         task = 'Approved'
         spy(strApproval,task)
       else
         strApproval.is_fully_received = 1
         strApproval.custom_field_status = 3 #Received
         strApproval.receive_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
         strApproval.receive_by = @current_user.first_name + " " + @current_user.last_name
         msg = "PO was received successfully."
       end # loop
     end # Regular User    
        
     
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
    @flowchk = 0
    #need to be made dry...
    if @current_user.first_check.to_i != 1
          cmt = Order.find(params[:id])
          cmt.acomments = nil
          cmt.save
          params[:order][:acomments] = nil 
    end #end decline for nil user
    
    if !params[:order][:acomments].nil? 
      if params[:order][:acomments].size != 0
       @flowchk = 1  
       cmt = Order.find(params[:id])
       cmt.acomments = params[:order][:acomments]
       cmt.save
      
      str_approve = Order.find_order(params[:id])
      strApproval = str_approve[0]
      if @current_user.first_check.to_i == 1
        task = 'Approved'
        spy(strApproval,task)
        strApproval.sub_approval = 1
        strApproval.track = 1
        strApproval.save
      end # Commodity Manger - Stephen Morrish
     end #end of size check 
    end #end check for acomments  
    
  
    if !params[:order][:dcomments].nil? && @flowchk == 0
      if params[:order][:dcomments].size != 0
        cmt = Order.find(params[:id])
        strcmt = cmt.dcomments if !cmt.dcomments.nil?
        strcmt = "" if cmt.dcomments.nil?
        cmt.update!(order_profile_parameters)
        cmt.save
         if cmt.po_status == "Declined"
          recommit
         else  
          get_comments 
         end #status
        end # end of size
       end #end check for dcomments  
    
    
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
    if @current_user.amount.to_i == 0
      @orders = Order.where(:is_manually_closed => '1', :is_fully_received => nil,:custom_field_authorized_buyer => @current_user.buyer).order( sort_column + " " + sort_direction )
    else
      @orders = Order.where(:is_manually_closed => '1', :is_fully_received => nil ).order( sort_column + " " + sort_direction )
    end#end if loop  
  end
  
  def received
    if @current_user.amount.to_i == 0
      @orders = Order.where(:is_manually_closed => '1', :is_fully_received => '1',:custom_field_authorized_buyer => @current_user.buyer).order( sort_column + " " + sort_direction )
    else
      @orders = Order.where(:is_manually_closed => '1', :is_fully_received => '1').order( sort_column + " " + sort_direction )
    end#end if loop     
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
  
  def decline_rpt
    if @current_user.amount.to_i == 0
      @orders = Order.where(:decline => '1',:custom_field_authorized_buyer => @current_user.buyer ).order(params[:sort])
    else
      @orders = Order.where(:decline => '1').order(params[:sort])
    end#end if loop  
  end
  
  def get_comments
    @order_decline = Order.find(params[:id])
    if @current_user.first_check.nil? && @order_decline.classz !='Overhead:Facilities'
      @order_decline.decline = '0'
      @order_decline.is_manually_closed = '0'
      @order_decline.is_fully_received = nil
      @order_decline.po_status = '01Declined'
      @order_decline.sub_approval = nil
    else
      @order_decline.is_manually_closed = 3
      @order_decline.is_fully_received = 3
      @order_decline.decline = 1
      @order_decline.custom_field_status = 2 #decline
      @order_decline.decline_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
      @order_decline.decline_by = @current_user.first_name + " " + @current_user.last_name
      @order_decline.po_status = 'Declined'  
    end # check whom declined
      
    @order_decline.save
    task = 'Declined'
    spy( @order_decline,task)
  end  
  
  def recommit
    @order = Order.find(params[:id])
    @order.decline = '0'
    @order.is_manually_closed = '0'
    @order.is_fully_received = nil
    @order.po_status = 'Recommited'
    @order.save
    task = 'Recommited'
    spy(@order,task)
  end  
  
    
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
    
    def sort_column
      #params[:sort] || "ref_number"
      Order.column_names.include?(params[:sort]) ? params[:sort] : "ref_number"
    end
    
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
      #params[:direction] || "asc"
    end
    
    def order_profile_parameters
      params.require(:order).permit(:date_due, :decliner_comments, :dcomments)
    end
    
    def spy(suspect, task)
      @spy = Watcher.new
      @spy.po = suspect.ref_number
      @spy.project = suspect.project_name
      @spy.customer = suspect.vendor_name  
      @spy.approver = @current_user.first_name + " " + @current_user.last_name
      @spy.task = task
      @spy.save
    end  
end
