class OrdersController
  class OrdersService
    
    def approved(str_user)
      @check_order_set = "Approved"
      @str_user = str_user
      init_order_recordset
    end
    
    def received(str_user)
      @check_order_set = "Received" 
      @str_user = str_user
      init_order_recordset
    end
    
    def decline_rptset_sort_order (str_user)
      @check_order_set = "Decline"
      @str_user = str_user
      init_order_recordset
    end
        
    private
       
    def init_order_recordset
     if @str_user.amount.to_i == 0 || @str_user.first_check.to_i == 1
       case @check_order_set
        when "Approved"
          approved_order_recordset 
        when "Received"
          received_order_recordset
        when "Decline"
          decline_order_recordset
        else
          sec_init_order_recordset
        end
      end   
    end
    
    def sec_init_order_recordset
      case @check_order_set
       when "Approved"
         @orders = Order.where(:is_manually_closed => '1', :is_fully_received => nil ).order( sort_column + " " + sort_direction )
       when "Received"
         @orders = Order.where(:is_manually_closed => '1', :is_fully_received => '1').order( sort_column + " " + sort_direction ) 
       when "Decline"
         @orders = Order.where(:decline => '1').order(@str_sort) 
       else
         "I dont have any idea what you need"
       end
    end
    
    def approved_order_recordset
      @orders = Order.where(:is_manually_closed => '1', :is_fully_received => nil,:custom_field_authorized_buyer => @str_user.buyer).order( sort_column + " " + sort_direction )
    end
    
    def received_order_recordset
      @orders = Order.where(:is_manually_closed => '1', :is_fully_received => '1',:custom_field_authorized_buyer => @str_user.buyer).order( sort_column + " " + sort_direction )
    end
    
    def decline_order_recordset
      @orders = Order.where(:decline => '1',:custom_field_authorized_buyer => @str_user.buyer ).order(@str_sort)
    end
    
    def sort_column
      Order.column_names.include?(@str_sort) ? @str_sort : "ref_number"
    end
  
    def sort_direction
      %w[asc desc].include?(@str_direction) ? @str_direction : "asc"
    end 
  end
end