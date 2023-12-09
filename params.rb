module Params
  @@google_sheet_id   = "1xgt9Mqt-ktSGq1BY01nHbdDXz7a0BW1WxjBU3gmZMEQ"
  @@scrub_event_id    = "0087"
  @@previous_event_id = "0086"

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
