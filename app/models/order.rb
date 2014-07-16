class Order < ActiveRecord::Base
  
  scope :find_order, lambda {|id| where(:id => id)}
  
  def self.import(file, name)
    CSV.foreach(file.path, :encoding => 'ISO-8859-1', :quote_char => '"', headers: true) do |row|
      insert_row = Order.new
      insert_row.time_created = row[0]
      insert_row.time_modified = row[1]
      insert_row.ref_number = row[2]
      insert_row.duedate = row[3]
      insert_row.expected_drive = row[4]
      insert_row.total_amount = row[5]
      insert_row.is_manually_closed = row[6]
      insert_row.is_fully_received = row[7]
      insert_row.custom_field_authorized_buyer = row[8]
      insert_row.custom_field_status = row[9]
      insert_row.save
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
