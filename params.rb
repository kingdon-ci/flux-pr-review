module Params
  @@google_sheet_id   = "1wEXvQrUwSCgK9h2dT9QLF_jJ31Xw_an6BhlHqojvw-4"
  @@scrub_event_id    = "0073"
  @@previous_event_id = "0072"

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
