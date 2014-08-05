module Api
  module V1
    class OrdersController < ApplicationController
      require 'pry'
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
        params[:first_name]
        params[:last_name]
        str_approve = Order.find_order(params[:id])
        binding.pry
        #strApproval.is_manually_closed = 1
        #strApproval.approve_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
        #strApproval.approve_by = params[:user_name]   
        #strApproval.save        
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
        #/api/vi/orders/details?ref_number= ...
        strOrdln = Ordln.where(:ref_number => params[:ref_number])
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