
pdf.table([["Frequencies"]], :cell_style => { :width => 215,
                                                  :height => 17,
                                                  :padding => [0,2,0,2],
                                                  :borders => [],
                                                  #:font => "Times-Roman",
                                                  :font_style => :normal,
                                                  :size => 14,
                                                  :text_color => "000000",
                                                  :background_color => "eeeeee",
                                                  :overflow => :shrink_to_fit, :min_font_size => 2
                                                 })
pdf.table([["Group "+@radio_group.group_number.to_s+" - ",@radio_group.name]],
          :width => 215,
          :column_widths => {0 => 75},
          :cell_style => {#:width => 215,
                          :height => 17,
                          :padding => [0,2,0,2],
                          :borders => [],
                          #:font => "Times-Roman",
                          :font_style => :bold,
                          :size => 15,
                          :text_color => "000000",
                          :background_color => "eeeeee",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         })
pdf.line_width = 1
pdf.bounding_box([0,307], :width => 216, :padding => 20) do
  pdf.indent 2,2 do #Indent the left & right sides of the bounding box
    pdf.move_down 2 #Add padding to the top of the bounding box
    pdf.text "Dispatch Center: "+@radio_group.dispatch_center.name.to_s+"\n"+
             "Callsign: \""+@radio_group.dispatch_center.callsign+"\"",
             :size => 7
  end #indented block
  pdf.transparent(1.0) {pdf.stroke_bounds}
end


table_headers = [["Ch","Name","Rx","RxTone","Tx","TxTone","Location"]]
freqs = @frequencies.collect do |freq|
    [
        freq.channel.to_s + freq.band,
        freq.name,
        freq.rx,
        freq.rx_tone,
        freq.tx,
        freq.tx_tone,
        freq.repeater_location
    ]
end
freqs = table_headers + freqs

pdf.table freqs,
          :width => 216,
          :header => true,
          :column_widths => {0 => 15,2 => 25,3 => 25,4 => 25,5 => 25,6 => 60},
          :cell_style => {#:width => 20,
                          :height => 15,
                          :padding => [2,2,2,2],
                          :font => "Times-Roman",
                          :font_style => :normal,
                          :size => 7,
                          :text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 2
                         }