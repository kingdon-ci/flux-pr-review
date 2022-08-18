module Params
  @@google_sheet_id   = "1K0BtzTl2_a3rz-deU1KZQINYs5fRV8-j290_ayO7hms"
  @@scrub_event_id    = "0043"
  @@previous_event_id = "0042"

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
