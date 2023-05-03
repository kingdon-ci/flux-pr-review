module Params
  @@google_sheet_id   = "1mgd_4JwaK8HfWbLMTOv1EqUsprROro1Zu4RCMKHPWoE"
  @@scrub_event_id    = "0069"
  @@previous_event_id = "0068"

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
