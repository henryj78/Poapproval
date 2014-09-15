class Order < ActiveRecord::Base
  
  scope :find_order, lambda {|id| where(:id => id)}
  scope :red, -> { where(ref_number: '1063796') }
  scope :desc, -> { order('expected_date DESC') } 
  scope :asc, -> { order('expected_date ASC') } 
  scope :ord_api_desc, -> { order('ref_number DESC') } 
  scope :ord_api_asc, -> { order('ref_number ASC') } 
  
  
  def self.import(file, name)
    cus_name = ""
    cus_name_new = ""
    
    CSV.foreach(file.path, :encoding => 'ISO-8859-1', :quote_char => '"', headers: true) do |row|
     # dups = Order.where(:ref_number => row[17])
    #  if dups.size == 0
    #   if row[106] != cus_name
    #     cus_name = row[106]
    #     insert_row = Order.new
    #     insert_row.ref_number = row[17]
    #     insert_row.date_due = row[54]
    #     insert_row.expected_date = row[55]
    #     insert_row.total_amount = row[59]
    #     insert_row.is_manually_closed = row[64]
    #     insert_row.custom_field_authorized_buyer = row[162]
    #     insert_row.vendor_name = row[6]
    #     insert_row.customer_name = row[106]
    #     insert_row.address = row[19]
    #     insert_row.city = row[23]
    #     insert_row.terms = row[53]
    #     insert_row.project_name = row[132]
    #     insert_row.memo = row[66]
    #     insert_row.user_comments = row[67]
    #     insert_row.item = row[92]
    #     insert_row.mpn = row[93]
    #     insert_row.wc  =  row[137]
    #     insert_row.classz = row[8]
    #
    #     #Items not  for production
    #     if row[8] != 'Production'
    #       insert_row.sub_approval = 1
    #       insert_row.track = 1
    #     end
    #     insert_row.save
        
        insert_row = Ordln.new
        insert_row.ref_number = row[17]
        insert_row.custom_field_authorized_buyer = row[162]
        insert_row.ord_line_qty = row[96]
        insert_row.ord_line_desc = row[95]
        insert_row.ord_line_rate = row[100]
        insert_row.ord_line_amount= row[103]
        insert_row.customer_name = row[106]
        insert_row.lead_time = row[129]
        insert_row.product = row[155]
        insert_row.project_id = row[132]
        insert_row.date_due = row[54]
        insert_row.expected_date = row[55]
        insert_row.address = row[19]
        insert_row.city = row[23]
        insert_row.terms = row[53]
        insert_row.memo = row[66]
        insert_row.user_comments = row[67]
        insert_row.item = row[92]
        insert_row.mpn = row[93]
        insert_row.wc  =  row[137]
        insert_row.classz = row[8]        
        insert_row.save           
        
     # else
     #   insert_row = Ordln.new
     #   insert_row.ref_number = row[17]
     #   insert_row.custom_field_authorized_buyer = row[162]
     #   insert_row.ord_line_qty = row[96]
     #   insert_row.ord_line_desc = row[95]
     #   insert_row.ord_line_rate = row[100]
     #   insert_row.ord_line_amount= row[103]
     #   insert_row.customer_name = row[106]
     #   insert_row.lead_time = row[152]
     #   insert_row.product = row[155]
     #   insert_row.project_id = row[132]
     #   insert_row.date_due = row[54]
     #   insert_row.expected_date = row[55]
     #   insert_row.address = row[19]
     #   insert_row.city = row[23]
     #   insert_row.terms = row[53]
     #   insert_row.memo = row[66]
     #   insert_row.user_comments = row[67]
     #   insert_row.item = row[92]
     #   insert_row.mpn = row[93]
     #   insert_row.wc  =  row[137]
     #   insert_row.classz = row[8]
     #   insert_row.save
     #  end #end of if loop
     # end #end of dups
    end #end csv each statement
  end #end import

def self.open_spreadsheet(file)
  case File.extname(file.original_filename)
  when ".csv" then Csv.new(file.path, nil, :ignore)
  when ".xls" then Excel.new(file.path, nil, :ignore)
  when ".xlsx" then Excelx.new(file.path, nil, :ignore)
  else raise "Unknown file type: #{file.original_filename}"
  end
 end #end open_spreadsheet

def self.to_csv(options = {})
  CSV.generate(options) do |csv|
    csv << column_names
    all.each do |po|
      csv << po.attributes.values_at(*column_names)
    end
  end
 end #end to_csv
 
 def self.search(search)
   if search
      find(:all, :conditions => ['ref_number LIKE ?', "%#{search}%"])
   else
     find(:all)
   end
 end# end of search 
 
 def self.search_project(search)
   if search
      find(:all, :conditions => ['project_name LIKE ?', "%#{search}%"])
   else
     find(:all)
   end
 end# end of search project
 
 def self.search_vendor(search)
   if search
      find(:all, :conditions => ['vendor_name LIKE ?', "%#{search}%"])
   else
     find(:all)
   end
 end# end of vendor name
 
 def self.search_customer(search)
   if search
      find(:all, :conditions => ['customer_name LIKE ?', "%#{search}%"])
   else
     find(:all)
   end
 end# end of Customer
end
