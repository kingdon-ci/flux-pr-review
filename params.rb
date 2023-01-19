module Params
  @@google_sheet_id   = "1uPxh_riHjGNoBL9O6H7lT5cvy5B8wnYP2A4qMc9vZ2A"
  @@scrub_event_id    = "0060"
  @@previous_event_id = "0059"

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
