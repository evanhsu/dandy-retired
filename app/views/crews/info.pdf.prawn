
#pdf.move_down(10)
pdf.table([["Helibase Info"]], :cell_style => { :width => 215,
                                                  :height => 17,
                                                  :padding => [0,2,0,2],
                                                  :borders => [],
                                                  #:font => "Helvetica",
                                                  :font_style => :normal,
                                                  :size => 14,
                                                  :text_color => "000000",
                                                  :background_color => "eeeeee",
                                                  :overflow => :shrink_to_fit, :min_font_size => 2
                                                 })
pdf.table([[@crew.name.to_s]], :cell_style => { :width => 215,
                                                  :height => 17,
                                                  :padding => [0,2,0,2],
                                                  :borders => [],
                                                  #:font => "Helvetica",
                                                  :font_style => :bold,
                                                  :size => 15,
                                                  :text_color => "000000",
                                                  :background_color => "eeeeee",
                                                  :overflow => :shrink_to_fit, :min_font_size => 2
                                                 })
#pdf.stroke_horizontal_rule

#Set values to empty strings if they're currently Nil
@helibase.street ||= ""
@helibase.city ||= ""
@helibase.state ||= ""
@helibase.zip ||= ""
@helibase.main_phone ||= ""
@helibase.fax ||= ""
@helibase.elevation ||= ""
@helibase.nearest_airport_elevation ||= ""

address = [[@helibase.street+", "+@helibase.city+', '+@helibase.state+' '+@helibase.zip],
           [@helibase.main_phone+"\ [ph\]      "+@helibase.fax+" \[f\]"]]
address_table = pdf.make_table(address,
          :width => 215,
          :header => false,
          :cell_style => {#:width => 20,
                          :height => 15,
                          :padding => [0,2,4,2],
                          :borders => [],
                          :font => "Helvetica",
                          :font_style => :normal,
                          :size => 12,
                          :text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         })
###############################################################################
coords_info = [["Helipad:",
                "N"+@helibase.lat_degrees.to_s+"° "+@helibase.lat_minutes.to_s+"'",
                "W"+@helibase.lon_degrees.to_s+"° "+@helibase.lon_minutes.to_s+"'",
                "Elev:",
                @helibase.elevation+"'"]]

coords_table = pdf.make_table(coords_info,
          :width => 215,
          :header => false,
          :column_widths => {0 => 40, 1=>60, 2=>65, 3=>25, 4 => 25},
          :cell_style => {#:width => 30,
                          :height => 14,
                          :padding => [2,2,1,2],
                          :borders => [],
                          :font => "Helvetica",
                          :font_style => :normal,
                          :size => 10,
                          :text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         })
###############################################################################
airport_info = []

#Use either 'helibase airport' or 'nearest airport', but not both
if !@helibase.airport_name.blank?
  a = ["Home Airport:",
        @helibase.airport_name.sub(/airport/i,"")+" ("+@helibase.airport_identifier+")",
        "Elev:",
        @helibase.elevation+"'"]
elsif !@helibase.nearest_airport_name.blank?
  a = ["Nearest Airport:",
        @helibase.nearest_airport_name.sub(/airport/i,"")+" ("+@helibase.nearest_airport_identifier+")",
        "Elev:",
        @helibase.nearest_airport_elevation+"'"]
else
  a = ["No airport info available"]
end

airport_info << a

airport_info_table = pdf.make_table(airport_info,
          :width => 215,
          :header => false,
          :column_widths => {2 => 25, 3 => 25},
          :cell_style => {#:width => 30,
                          :height => 14,
                          :padding => [0,2,2,2],
                          :borders => [],
                          :font => "Helvetica",
                          :font_style => :normal,
                          :size => 10,
                          :text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         })

###############################################################################
org = [['Base Manager:', @helibase.base_manager_name, @helibase.base_manager_phone]]
unless @helibase.department1_contact_name.blank? && @helibase.department1_phone.blank?
  org << [@helibase.department1_title+":", @helibase.department1_contact_name, @helibase.department1_phone]
end
unless @helibase.department2_contact_name.blank? && @helibase.department2_phone.blank?
  org << [@helibase.department2_title+":", @helibase.department2_contact_name, @helibase.department2_phone]
end
unless @helibase.department3_contact_name.blank? && @helibase.department3_phone.blank?
  org << [@helibase.department3_title+":", @helibase.department3_contact_name, @helibase.department3_phone]
end

org_table = pdf.make_table(org,
          :width => 215,
          :header => false,
          :column_widths => {0 => 65,2 => 60},
          :cell_style => {#:width => 30,
                          :height => 12,
                          :padding => [0,2,2,2],
                          :borders => [],
                          :font => "Helvetica",
                          :font_style => :normal,
                          :size => 10,
                          :text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         })

###############################################################################
# Create the page layout - actually write content

pdf.bounding_box([0,307], :width => 216, :padding => 10) do
  address_table.draw
  pdf.stroke_horizontal_rule
  coords_table.draw
  airport_info_table.draw
  pdf.stroke_horizontal_rule
  org_table.draw
  pdf.transparent(1.0) {pdf.stroke_bounds}
end


###############################################################################
###############################################################################
# Begin Hotel Section
###############################################################################
###############################################################################
pdf.move_down(5)
#pdf.line_width(2)
#pdf.stroke_horizontal_rule
pdf.move_down 5
pdf.table([["Lodging"]], :cell_style => { :width => 215,
                                                  :height => 17,
                                                  :padding => [0,2,0,2],
                                                  :borders => [],
                                                  #:font => "Helvetica",
                                                  :font_style => :normal,
                                                  :size => 14,
                                                  :text_color => "000000",
                                                  :background_color => "eeeeee",
                                                  :overflow => :shrink_to_fit, :min_font_size => 2
                                                 })
hotel_info = []
last_city = ""
@hotels.each do |hotel|
  if hotel.city != last_city
    new_cell = pdf.make_cell(:content => hotel.city, :font_style => :bold, :height => 16)
    new_cell.padding = [8,2,0,2]
    hotel_info << [new_cell]
  end
  new_cell = pdf.make_cell(:content => (hotel.name||="")+" - "+(hotel.street1||="")+" ("+(hotel.phone||=" ") +")", :height => 10)
  new_cell.padding = [2,2,0,2]
  hotel_info << [new_cell]
  last_city = hotel.city
end
hotel_info = [["No hotels listed"]] if hotel_info.size == 0

pdf.move_up(5)
pdf.table(hotel_info,
          :width => 215,
          :cell_style => {#:height => 10,
                          #:padding => [3,2,0,2],
                          :borders => [],
                          #:font => "Helvetica",
                          #:font_style => :normal,
                          :size => 8,
                          #:text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         })
