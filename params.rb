module Params
  @@google_sheet_id   = "1IxyF5xc-usR2kO5EMDv-N2pBUW69wP-60WnF6gcuyQo"
  @@scrub_event_id    = "0056"
  @@previous_event_id = "0055"

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
