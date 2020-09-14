# Controller for sending out automated quotes to customers.
require 'prawn'
class SendQuoteMailer < ApplicationMailer
  # Method which sends out the email.
  def send_quote(to, quote)
    @info = quote
    @price = calculate_quote(quote)
    create_quote_file(quote, @price)
    attachments['quote.pdf'] = File.read("#{Rails.root}/tmp/quote_#{@info.id.to_s}.pdf")
    puts "Done attaching file"
    mail(to: to, subject: 'A Quote From TheCompCodes') 
  end

  private

  # Calculate the quote for the cusomter.
  def calculate_quote(quote)
    #TODO
    100
  end

  def create_quote_file(quote, price)
    Prawn::Document.generate("#{Rails.root}/tmp/quote_#{@info.id.to_s}.pdf") do |pdf|
      pdf.font "Helvetica"
      
      # Defining the grid 
      # See http://prawn.majesticseacreature.com/manual.pdf
      pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 
      
      pdf.grid([0,0], [1,1]).bounding_box do 
        pdf.text  "INVOICE", :size => 18
        pdf.text "Invoice No: 5342", :align => :left
        pdf.text "Date: #{Date.today.to_s}", :align => :left
        pdf.move_down 10
        #TODO put name of person here.
        pdf.text "Attn: To whom it may concern "
        pdf.text "Company Name"
        pdf.text "Telephone Number: +805-679-1282"
      end
      
      pdf.grid([0,3.6], [1,4]).bounding_box do 
        # Assign the path to your file name first to a local variable.
        logo_path = File.expand_path(Rails.root + "app/assets/images/logo.png", __FILE__)
      
        # Displays the image in your PDF. Dimensions are optional.
        pdf.image logo_path, :width => 50, :height => 50, :position => :left
      
        # Company address
        pdf.move_down 10
        pdf.text "TheCompCodes", :align => :left
        pdf.text "Address", :align => :left
        pdf.text "Street 1", :align => :left
        pdf.text "40300 Shah Alam", :align => :left
        pdf.text "Selangor", :align => :left
        pdf.text "Tel No: 42", :align => :left
        pdf.text "Fax No: 42", :align => :left
      end
      
      pdf.text "Details of Invoice", :style => :bold_italic
      pdf.stroke_horizontal_rule
      
      
      temp_arr = [{:name => 'Unit 1', :price => "10.00"},
                  {:name => 'Unit 2', :price => "12.00"}]
      
      pdf.move_down 10
      items = [["No","Description", "Qt.", "RM"]]
           items += temp_arr.each_with_index.map do |item, i|
             [
               i + 1,
               item[:name],
               "1",
               item[:price],
             ]
      end
      items += [["", "Total", "", "22.00"]]
      
      
      pdf.table items, :header => true, 
                       :column_widths => { 0 => 50, 1 => 350, 3 => 100}, :row_colors => ["d2e3ed", "FFFFFF"] do
        style(columns(3)) {|x| x.align = :right }
      end
      
      
      pdf.move_down 40
      pdf.text "Terms & Conditions of Sales"
      pdf.text "1.	All checks should be crossed and made payable to TheCompCodes"
      
      pdf.move_down 40
      pdf.text "Received in good condition", :style => :italic
      
      pdf.move_down 30
      
      pdf.stroke_horizontal_rule
      
      pdf.bounding_box([pdf.bounds.right - 50, pdf.bounds.bottom], :width => 60, :height => 20) do
        pagecount = pdf.page_count
        pdf.text "Page #{pagecount}"
      end
    end
  end
end
