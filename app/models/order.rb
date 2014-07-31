class Order < ActiveRecord::Base
  
  scope :find_order, lambda {|id| where(:id => id)}
  scope :red, -> { where(ref_number: '1063796') }
  scope :desc, -> { order('expected_date DESC') } 
  
  
  def self.import(file, name)
    cus_name = ""
    cus_name_new = ""
    
    CSV.foreach(file.path, :encoding => 'ISO-8859-1', :quote_char => '"', headers: true) do |row|
      if row[106] != cus_name
        cus_name = row[106]
        insert_row = Order.new
        insert_row.ref_number = row[17]
        insert_row.date_due = row[54]
        insert_row.expected_date = row[55]
        insert_row.total_amount = row[59]
        insert_row.is_manually_closed = row[64]
        insert_row.custom_field_authorized_buyer = row[153]
        insert_row.vendor_name = row[6]
        insert_row.customer_name = row[106]
        #insert_row.project_name = row[?]
        insert_row.save
        
        insert_row = Ordln.new
        insert_row.ref_number = row[17]
        insert_row.custom_field_authorized_buyer = row[153]
        insert_row.ord_line_qty = row[96]
        insert_row.ord_line_desc = row[95]
        insert_row.ord_line_rate = row[100]
        insert_row.ord_line_amount= row[103]
        insert_row.customer_name = row[106]
        #insert_row.device = row[106]
        #insert_row.assemblies = row[106]
        insert_row.save           
        
     else
       insert_row = Ordln.new
       insert_row.ref_number = row[17]
       insert_row.custom_field_authorized_buyer = row[153]
       insert_row.ord_line_qty = row[96]
       insert_row.ord_line_desc = row[95]
       insert_row.ord_line_rate = row[100]
       insert_row.ord_line_amount= row[103]
       insert_row.customer_name = row[106]
       #insert_row.device = row[106]
       #insert_row.assemblies = row[106]       
       insert_row.save           
     end
    end
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
end
