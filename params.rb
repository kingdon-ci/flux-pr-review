module Params
  @@google_sheet_id   = "1zfrkZf-c4mZDJRb86SIr-bSorP6KQl1dDW-ocdjy754"
  @@scrub_event_id    = "0075"
  @@previous_event_id = "0074"

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
