module HelperMethods
  extend ActiveSupport::Concern
  #clean up
  included do
    # intentionally blank
  end

  def parse_date( day )
    day = day.is_a?( Date ) ? day : Date.parse(day.to_s).beginning_of_day
  end

end
