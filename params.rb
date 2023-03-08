module Params
  @@google_sheet_id   = "1F64B4fm7g3jFLTmoXiyJyM1x9Pb3T9yAaZOYPduLXQM"
  @@scrub_event_id    = "0063"
  @@previous_event_id = "0062"

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
