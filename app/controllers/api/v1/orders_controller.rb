module Api
  module V1
    class OrdersController < ApplicationController
      #http_basic_authenticate_with name: "Admin", password: "secret"
      respond_to :json
      
      def index
       respond_with  Order.where(:is_manually_closed => '0')
      end
      
      def approved
        respond_with Order.where(:is_manually_closed => '1', :is_fully_received => nil )
      end
  
      def received
        respond_with Order.where(:is_manually_closed => '1', :is_fully_received => '1')
      end
      
      def declined
        respond_with Order.where(:decline => '1')
      end
      
      def details
        strOrdln = Ordln.where(:ref_number => params[:ref_number])
        respond_with strOrdln
      end
      
      def buyers
        respond_with Buyer.all
      end      
      
    end
  end#Vi
end#Api