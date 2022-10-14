module Params
  @@google_sheet_id   = "1LgPm6RO3R6xoFVHnCvYA0P1KuFGe8uWMlKphQyipz8E"
  @@scrub_event_id    = "0052"
  @@previous_event_id = "0051"

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
