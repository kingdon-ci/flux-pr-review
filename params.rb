module Params
  @@google_sheet_id   = "1Ll4kQeVmQfnpbGN9TteBGzGupO_tMr_D2Q4CRK4Abxg"
  @@scrub_event_id    = "0071"
  @@previous_event_id = "0070"

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
