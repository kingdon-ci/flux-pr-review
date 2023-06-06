module Params
  @@google_sheet_id   = "1q3Sn1RXKIIkkOFM5rQoW4kTiSvXQC3_4ZRen9Mh2O78"
  @@scrub_event_id    = "0072"
  @@previous_event_id = "0071"

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
