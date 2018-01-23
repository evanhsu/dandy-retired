


headers = [pdf.make_cell("Name", :size=>8),
           pdf.make_cell("Contact", :size=>8),
           pdf.make_cell("Location", :size=>6),
           pdf.make_cell("Coverage", :size=>8)]
data = []
data << headers

@dispatch_centers.each do |dc|
  cell1 = pdf.make_cell(dc.name, :size => 6, :valign => :top, :padding => [0,2,4,2], :valign => :center)
  cell2 = pdf.make_table([["Phone:",dc.phone1],["24-hr:",dc.phone24], ["Fax:",dc.fax], ["",""]], #4th row is blank just to add space
              #:width => 90,
              #:column_widths => {0 => 23, 1 => 45},
              :cell_style => {:borders => [],
                              :height => 6,
                              :padding => [0,2,0,2],
                              :size => 6,
                              :overflow => :shrink_to_fit, :min_font_size => 3})
  cell3 = pdf.make_cell(dc.location, :size => 6, :width => 35, :padding => [0,2,0,2], :align => :center, :valign => :top)

  fscoverage = blmcoverage = parkcoverage = ""
  fscoverage =  "<color rgb='33cc33'>"+dc.fscoverage.to_s + "</color>\n" unless dc.fscoverage.blank?
  blmcoverage = "<color rgb='aaaa44'>"+dc.blmcoverage.to_s+ "</color>\n" unless dc.blmcoverage.blank?
  parkcoverage= "<color rgb='3333dd'>"+dc.parkcoverage.to_s+"</color>" unless dc.parkcoverage.blank?

  cell4 = pdf.make_table([[fscoverage + blmcoverage + parkcoverage]],
              :width => 50,
              :cell_style => {:borders => [],
                              #:height => 25,
                              :padding => [0,2,2,2],
                              :size => 3,
                              :inline_format => true,
                              :overflow => :expand_to_fit, :min_font_size => 3})
  data << [cell1, cell2, cell3, cell4]

end
###############################################################################
## Decide whether to split across 2 pages ##

output = []
if (data.count-1) > 11
  (((data.count-1) / 11)+1).times do |i|
    output[i] = data[(i*11)..(i*11+10)]
  end
else
  output[0] = data
end
###############################################################################
## Write Data ##

output.count.times do |i|
  #Print page header "Dispatch Centers (Page 1 of 2)", etc
  page_label = "Dispatch Centers (Page "+((i+1).to_s)+" of "+(output.count.to_s)+")"
  pdf.table([[page_label]],
            :cell_style => {:width => 215,
                            :height => 34,
                            :padding => [0,2,0,2],
                            :borders => [],
                            :valign => :center,
                            :font_style => :normal,
                            :size => 14,
                            :background_color => "eeeeee",
                            :overflow => :shrink_to_fit
                           })

  # Print the table of dispatch centers
  pdf.table(output[i],
            :header => true,
            #:column_widths => {0 => 35, 1 => 65, 2 => 68},
            :cell_style => {#:borders => [],
                            #:size => 8,
                            #:overflow => :shrink_to_fit, :min_font_size => 3
            })
  
  # Print the color legend
  pdf.move_down(5)
  pdf.formatted_text_box [{:text => "Color Code:\n", :size => 6, :color => "000000"},
                    {:text => "Forest Service\n", :size => 5, :color => "33CC33"},
                    {:text => "BLM\n", :size => 5, :color => "aaaa44"},
                    {:text => "Park Service\n", :size => 5, :color => "3333dd"}],
                        :at => [170, pdf.cursor]
  
  pdf.start_new_page if i < (output.count - 1) #Only start a new page if there will be another loop
end

