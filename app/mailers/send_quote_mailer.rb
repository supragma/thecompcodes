# Controller for sending out automated quotes to customers.
require 'prawn'
class SendQuoteMailer < ApplicationMailer
  # Method which sends out the email.
  def send_quote(to, quote)
    @info = quote
    create_quote_file(quote)
    attachments['quote.pdf'] = File.read("#{Rails.root}/tmp/quote_#{@info.id.to_s}.pdf")
    mail(to: to, subject: 'A Quote From TheCompCodes') 
  end

  private

  def create_quote_file(quote)
    Prawn::Document.generate("#{Rails.root}/tmp/quote_#{@info.id.to_s}.pdf") do |pdf|
      pdf.font "Helvetica"
      # Defining the grid 
      # See http://prawn.majesticseacreature.com/manual.pdf
      pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 
      
      pdf.grid([0,0], [1,1]).bounding_box do 
        pdf.move_down 10
        pdf.text  "Proposal", :size => 18
        pdf.text "Proposal #: #{quote.id + 1000}", :align => :left
        pdf.text "Date: #{Date.today.to_s}", :align => :left
        pdf.text "Proposal Due Date: Within 7 days", :align => :left
        pdf.move_down 10
        pdf.text "Bill To: #{quote.first_name} #{quote.last_name}"
        pdf.text "Address: #{quote.address} #{quote.zip}"
        pdf.text "Telephone Number: #{quote.phone}"
        pdf.text ""
      end
      
      pdf.grid([0,3.6], [1,4]).bounding_box do 
        # Assign the path to your file name first to a local variable.
        logo_path = File.expand_path(Rails.root + "app/assets/images/logo.png", __FILE__)
      
        # Displays the image in your PDF. Dimensions are optional.
        pdf.image logo_path, :width => 79, :height => 75, :position => :left
      
        # Company address
        pdf.text "TheCompCodes", :align => :left
        pdf.text "Santa Barbara, CA", :align => :left
        pdf.text "Telephone Number:", :align => :left
        pdf.text "805.679.1282", :align => :left
        pdf.text "www.thecompcodes.com", :align => :left
      end
      pdf.text "Scope of Work", :size => 14
      if quote.details != ""
        pdf.text "\u2022 #{quote.details}"
      end
      if  first_bullet_point(quote) != ""
        pdf.text "\u2022 #{first_bullet_point(quote)}"
      end
      if second_bullet_point(quote) != ""
        pdf.text "\u2022 #{second_bullet_point(quote)}"
      end
      if third_bullet_point(quote) != ""
        pdf.text "\u2022 #{third_bullet_point(quote)}"
      end

      pdf.text "\u2022 #{fourth_bullet_point(quote)}"

      if quote.interior_alt
        pdf.text "\u2022 Provide Renderings and Construction Documents for Interior alterations"
      end

      if quote.exterior_alt
        pdf.text "\u2022 Provide Renderings and Construction Documents for Exterior alterations"
      end

      pdf.text "\u2022 Should the Project Require Topography Survey, or Civil Engineering Set we can offer it at an additional cost."

      pdf.stroke_horizontal_rule
      pdf.move_down 10
      pdf.text "Details of Invoice (next page)", :style => :bold_italic
      pdf.stroke_horizontal_rule

      item = 1
      total_price = 0
      temp_arr = [{:name => "Arch Sets\n#{arch_set_description(quote)}", :price => get_line_item_one_price(quote.size.to_i).to_s}]
      total_price += get_price_from_string(get_line_item_one_price(quote.size.to_i))
      item += 1

      pdf.move_down 10
      items = [["No","Description", "Qt.", "Cost"]]
           items += temp_arr.each_with_index.map do |item, i|
             [
               i + 1,
               item[:name],
               "1",
               item[:price],
             ]
      end
      items += [["", "Total", "", "$ #{total_price.to_s}"]]
      pdf.table items, :header => true, 
                       :column_widths => { 0 => 50, 1 => 350, 3 => 100}, :row_colors => ["d2e3ed", "FFFFFF"] do
        style(columns(3)) {|x| x.align = :right }
      end

      pdf.start_new_page      
      pdf.define_grid(:columns => 5, :rows => 8, :gutter => 10) 
      
      pdf.grid([0,0], [1,1]).bounding_box do 
        pdf.move_down 50
        pdf.text "Initial Payment 50%", :align => :left
        pdf.text "Final Payment 50%", :align => :left
      end
      
      pdf.grid([0,3.6], [1,4]).bounding_box do 
        # Company address
        pdf.move_down 50
        pdf.text "$#{(total_price/2).to_s}", :align => :left
        pdf.text "$#{(total_price/2).to_s}", :align => :left
      end
      pdf.move_down 40
      pdf.text "Notes:", :style => :italic
      pdf.text "If you need a contractor or construction administrator please let me know and we can help you in this regard. We look forward to working with you!" 
      pdf.move_down 20
      pdf.text "..............................."
      pdf.text "#{quote.first_name} #{quote.last_name}"
      
      pdf.move_down 20
      pdf.text "..............................."
      pdf.text "Christian Cortes, CEO of TheCompCodes"

      pdf.move_down 20
      pdf.stroke_horizontal_rule
      
      pdf.move_down 20
      pdf.text "Terms & Conditions of Sales"
      pdf.text "1. All payment should be made payable to Christian Cortes via Zelle (805.679.1282), Paypal (christiancortes09@gmail.com), or Check."
      
      pdf.move_down 20
      
      pdf.stroke_horizontal_rule
      
      pdf.bounding_box([pdf.bounds.right - 50, pdf.bounds.bottom], :width => 60, :height => 20) do
        pagecount = pdf.page_count
        pdf.text "Page #{pagecount}"
      end
    end
  end

  private

  def first_bullet_point(quote)
    text = ""
    if quote.new_construction
      text += "New construction of " + quote.size + " sq. ft. "
    end
    if quote.adding
      text += "Adding unit of " + quote.size + " sq. ft. "
    end
    if quote.remodel
      text += "Remodel of " + quote.location + " of " + quote.size + " sq. ft. "
    end
    if quote.complete_remodel
      text += "Complete remodel of " + quote.location + " of " + quote.size+ " sq. ft. "
    end
    if quote.tenant_improvement
      text += "Tenate improvements of " + quote.size + " sq. ft. "
    end
    if quote.structural_repair
      text += "Structual repair of " + quote.size + " sq. ft. "
    end
    if quote.structural_eng
      text += "Structural engineering of " + quote.size + " sq. ft. "
    end
    if !quote.project_other.nil? && quote.project_other != ""
      text += quote.project_other + " of " + quote.size + " sq. ft. "
    end
    return text
  end

  def second_bullet_point(quote)
    text = "Construction Documents will include Conceptual Renderings, Schematic Drawings, Architectural Set, "
    if quote.structural_eng 
      "Structural Set, "
    end
    if quote.mech_elect_plumb
      "Mechanical Set, Electrical Set, Plumbing Set, "
    end
    text += "and calculations."
    return text
  end

  def fourth_bullet_point(quote)
    "All Design and Construction documents will follow City of #{quote.zip} Design and Construction Standards."
  end

  def third_bullet_point(quote)
    text = "Project will require "
    number_of_items_added = 0
    if quote.interior_alt
      text += "Interior Alterations, "
      number_of_items_added += 1
    end
    if quote.exterior_alt
      text += "Exterior Alterations, "
      number_of_items_added += 1
    end
    if quote.site_improvements
      text += "Site Improvements, "
      number_of_items_added += 1
    end
    if quote.earth_work
      text += "Earthwork, "
      number_of_items_added += 1
    end
    if quote.sewer
      text += "Sewer, "
      number_of_items_added += 1
    end

    if number_of_items_added == 0
      return ""
    else
      text = text.chomp(", ")
      text << "."
    end
    return text
  end

  def get_line_item_one_price(footage)
    if footage > 1500
      return "$" + (footage * 6).to_i.to_s
    else
      return "$" + (footage * 7).to_i.to_s
    end
  end

  def arch_set_description(quote)
    "The Architectural Drafter will prepare new design and construction documents (drawings) for a #{quote.location} property. #{get_address_string(quote)} Deliverables: Signed and Stamped Drawings for submission to the building department for review and approval may include, but are not be limited to:\n
• Project will require MEP sets and Title 24 Report.\n
• Cover Sheet and project Data.\n
• Construction Notes.\n
• Full and Partial Site Plan with dimensions and location as\n
needed for Jurisdictional requirements.\n
• Architectural Plans\n
• Elevations as needed.\n
• Product Schedules as needed\n
• Structural Plans & Calculations as needed.\n
• Sections as needed\n
• Details as need\n
#{has_mechanical_elect_plumbing(quote)}
• Stamp and Signed Set of Complete Plans for permit Submittal.\n
• Provide Support with submittal process to the City.\n
• Perform preliminary analysis of how to submit project to\n
keep the submittal process as simple as possible. "
  end

  def has_mechanical_elect_plumbing(quote)
    if quote.mech_elect_plumb
      return "• Mechanical, Electrical, and Plumbing Plans\n"
    end
    return ""
  end

  def get_address_string(quote)
    text = "\nThe address of the location is "
    if quote["address"] != "" && quote["zip"] != ""
      text = "#{text} #{quote["address"]}, #{quote["zip"]}.\n"
    elsif quote["address"] == "" && quote["zip"] != ""
      text = "#{text} at zip code #{text quote["zip"]}.\n"
    elsif quote["address"] != "" && quote["zip"] == ""
      text = "#{text} #{quote["address"]}.\n"
    else
      return ""
    end
    return text 
  end

  def get_price_from_string(price)
    price[0] = ""
    price.to_i
  end
end

