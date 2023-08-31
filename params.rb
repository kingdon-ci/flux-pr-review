module Params
  @@google_sheet_id   = "1GLb74u25SofsdWv1DYqSmbrE0BN4UZI94z3AzbkLNpQ"
  @@scrub_event_id    = "0077"
  @@previous_event_id = "0076"

  def google_sheet_id
    @@google_sheet_id
  end

  def scrub_event_id
    @@scrub_event_id
  end

  def previous_event_id
    @@previous_event_id
  end

  module_function :google_sheet_id, :scrub_event_id, :previous_event_id
end
