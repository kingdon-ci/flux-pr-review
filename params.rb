module Params
  @@google_sheet_id   = "16heWB_7dyQIBLuoCne1FySxAHgGMQDHVG0BBppC0-94"
  @@scrub_event_id    = "0083"
  @@previous_event_id = "0081"

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
