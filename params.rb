module Params
  @@google_sheet_id   = "1lU-PgCC1hMA28D8plTfpN2G07aTlmO5mu62rX7qSqwM"
  @@scrub_event_id    = "0064"
  @@previous_event_id = "0063"

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
