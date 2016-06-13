class OrderController
  class EditServices
    
    def init_process(ordid, user_str)
      @str_approve = Order.find_order(ordid)
      @strApproval = str_approve[0]
      @current_user = user_str
      create_order_status
    end

    def create_order_status
      case @current_user.first_check.to_i
       when 1
        set_commodity_manager
       when nil
        set_production_manager
      end
    end
    
  
    # Commodity Manger - Stephen Morrish
    def set_commodity_manager
      task = 'Approved'
      spy(@strApproval,task)
      @strApproval.sub_approval = 1
      @strApproval.track = 1
      @strApproval.is_fully_received = 1
      @strApproval.custom_field_status = 3 #Received
      @strApproval.receive_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
      @strApproval.receive_by = @current_user.first_name + " " + @current_user.last_name
      msg = "PO was received successfully."  
    end
    

      # Production Manger - Rich Malone
      def set_production_manager
        case @strApproval.is_manually_closed 
        when 0.to_s
          @strApproval.is_manually_closed = 1
          @strApproval.custom_field_status = 1 #Approved
          @strApproval.approve_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
          @strApproval.approve_by = @current_user.first_name + " " + @current_user.last_name
          @strApproval.track = 2
          @strApproval.po_status = 'Approved'
          msg = "PO approval  was successful."
        else
          common_user_buyer
        end
      end
    
      def common_user_buyer
        @strApproval.is_fully_received = 1
        @strApproval.custom_field_status = 3 #Received
        @strApproval.receive_date = Time.now.strftime("%Y-%d-%m %H:%M:%S %Z")
        @strApproval.receive_by = @current_user.first_name + " " + @current_user.last_name
        msg = "PO was received successfully."
        #record who approved
        task = 'Approved'
        spy(@strApproval,task)
      end

    
    private
    
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
end
