module Params
  @@google_sheet_id   = "1VT6p4WAzYJoik5yEfYnx9wfWIOX8_oFTOZk2OzeErrY"
  @@scrub_event_id    = "0049"
  @@previous_event_id = "0047" # this is correct

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
