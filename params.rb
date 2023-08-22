module Params
  @@google_sheet_id   = "1c3jhcfEvVK8bI1URjwHTjZVSuByBuOS9OS1S_RvM-V0"
  @@scrub_event_id    = "0076"
  @@previous_event_id = "0075"

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
