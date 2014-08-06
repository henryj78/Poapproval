module Api
  module V1
    class OrdersController < ApplicationController
      #http_basic_authenticate_with name: "Admin", password: "secret"
      respond_to :json

      def index
       #/api/v1/orders?amount= ...
       storage = Array.new  
       params[:amount]
       Order.where(:is_manually_closed => '0').each do |z|
         storage << z if z.total_amount.to_f <= params[:amount].to_f
       end#do loop
        respond_with storage
      end
      
      def submit_approval
        #/api/v1/orders/submit_approval?...&...&...&...
        #send amount 
        params[:first_name]
        params[:last_name]
        params[:amount]
        
        str_approve = Order.find_by_ref_number(params[:id])
        
        if !str_approve.nil?
          if str_approve.total_amount.to_f < params[:amount].to_f
           str_approve.is_manually_closed = 1
           str_approve.approve_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
           str_approve.approve_by = params[:first_name] + " " + params[:last_name]   
           str_approve.save  
           respond_with "Approval has been completed"
          else
            respond_with "Permission has been Denied for this Approval"
          end#amount
        end#end of str_approve      
      end#submit_approval
      
      def submit_decline
        #/api/v1/orders/submit_decline?...&...&...&...
        #send amount 
        params[:first_name]
        params[:last_name]
        params[:amount]
        
        str_decline = Order.find_by_ref_number(params[:id])
        
        if !str_decline.nil?
          if str_decline.total_amount.to_f < params[:amount].to_f
           str_decline.is_fully_received  = 1
           str_decline.receive_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
           str_decline.receive_by = params[:first_name] + " " + params[:last_name]   
           str_decline.save  
           respond_with "Decline request has been completed"
          else
            respond_with "Permission has been Denied for this request"
          end#amount
        end#end of str_approve      
      end#submit_approval      
        
      def approved #report
        respond_with Order.where(:is_manually_closed => '1', :is_fully_received => nil )
      end
  
      def received #report
        respond_with Order.where(:is_manually_closed => '1', :is_fully_received => '1')
      end
      
      def declined #report
        respond_with Order.where(:decline => '1')
      end
      
      def details #by po number
        #/api/v1/orders/details?ref_number= ...
        load_orig = Array.new
        remove_blank = Array.new
        
        load_orig = Ordln.where(:ref_number => params[:ref_number])
        load_orig.each do |e|
          remove_blank << e if !e.ord_line_desc.nil?  &&  !e.ord_line_amount.nil?
        end
        strOrdln = remove_blank 
        respond_with strOrdln
      end
      
      def buyers
        respond_with Buyer.all
      end  
      
      def auth
        #send email e.g. /api/orders/auth:email= ...
        #returns decline or recordset
         str_auth = User.where( :email => params[:email])
         if str_auth == [] || str_auth.nil? 
           respond_with "Decline"
          else
            respond_with str_auth
         end   
      end#auth   
      
    end#class
  end#Vi
end#Api