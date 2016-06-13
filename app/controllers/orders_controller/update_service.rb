class OrderController
  class UpdateService
    
    def init_order_information(approval_comment, declined_comment, str_user)
      @approval_comment = approval_comment
      @comments_update = Order.find(str_user)
      if approval_comment.size != 0
        approve_order_information
      end
      if declined_comment.size != 0
        declined_order_information
      end
    end
    
    def approve_order_information
      @comments_update.acomments = @approval_comment
      @comments_update.sub_approval = 1
      @comments_update.track = 1
      @comments_update.save
    end
    
    def declined_order_information
      case @comments_update.po_status 
      when "Declined"
       recommit
      else  
       get_comments 
    end
    
     
       
       private
       
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
         spy( @order_decline,'Declined')
       end  
  
       def recommit
         @order = Order.find(params[:id])
         @order.decline = '0'
         @order.is_manually_closed = '0'
         @order.is_fully_received = nil
         @order.po_status = 'Recommited'
         @order.save
         spy(@order,'Recommited')
       end  
       
  end
end
