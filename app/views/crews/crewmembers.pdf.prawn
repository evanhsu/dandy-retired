pdf.table([["Crewmembers"]], :cell_style => { :width => 215,
                                              :height => 13,
                                              :padding => [0,2,0,2],
                                              :borders => [],
                                              #:font => "Times-Roman",
                                              :font_style => :normal,
                                              :size => 14,
                                              :text_color => "000000",
                                              :background_color => "eeeeee",
                                              :overflow => :shrink_to_fit, :min_font_size => 2
                                             })
pdf.table([[@crew.name.to_s]], :cell_style => { :width => 215,
                                                :height => 19,
                                                :padding => [0,2,6,2],
                                                :borders => [],
                                                #:font => "Times-Roman",
                                                :font_style => :bold,
                                                :size => 15,
                                                :text_color => "000000",
                                                :background_color => "eeeeee",
                                                :overflow => :shrink_to_fit, :min_font_size => 2
                                               })
pdf.stroke_horizontal_rule

table_headers = [["Name","Cell","Days Off","Rap/Heli/Spot"]]
crewmembers_text = @crewmembers.collect do |cm|
    [
        #cm.firstname+' '+cm.lastname,
        cm.lastname+', '+cm.firstname,
        cm.cellphone,
        cm.daysoff,
        cm.rappelweight.to_s+'/'+cm.helitackweight.to_s+(cm.spotterweight.nil? ? '':'/'+cm.spotterweight.to_s )
    ]
end
crewmembers_text = table_headers + crewmembers_text

pdf.table(crewmembers_text,
          :width => 215,
          :header => true,
          :column_widths => {1 => 45,2 => 30,3 => 43},
          :cell_style => {#:width => 20,
                          :height => 10,
                          :padding => [0,2,0,2],
                          #:font => "Times-Roman",
                          :font_style => :normal,
                          :size => 6,
                          :text_color => "000000",
                          :overflow => :shrink_to_fit, :min_font_size => 3
                         }) do
         row(0).style(:font_style => :bold)
end

pdf.table([["* Spotter weight includes BD bag"]],
            :cell_style => { :width => 215,
            :height => 12,
            :padding => [0,2,0,2],
            :borders => [],
            #:font => "Times-Roman",
            :font_style => :normal,
            :size => 5,
            :text_color => "000000",
            #:background_color => "eeeeee",
            :align => :right,
            :overflow => :shrink_to_fit, :min_font_size => 2
           })