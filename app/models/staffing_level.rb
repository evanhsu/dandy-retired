class StaffingLevel < ActiveRecord::Base
  belongs_to :crew

  def self.latest_from_each_crew
    data = connection.select_values("SELECT f.* FROM
                                (SELECT crew_id, max(created_at) as max_c_a
                                 FROM staffing_levels GROUP BY crew_id) AS x
                              INNER JOIN staffing_levels AS f
                                 ON f.crew_id = x.crew_id AND f.created_at = x.max_c_a")

    #data is an Array of id's
    StaffingLevel.find(data, :order => :crew_id)
  end

end