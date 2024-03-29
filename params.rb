module Params
  @@google_sheet_id   = "1B19waUhimvYNzn38ZIJxOKT6w2syq0TZs0UAM4Q-5t8"
  @@scrub_event_id    = "0089"
  @@previous_event_id = "0088"

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
