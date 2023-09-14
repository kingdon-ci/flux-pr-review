module Params
  @@google_sheet_id   = "1VqEb8A1xfTLDar984FlDdcw-ZuH9SxJcsDVv0TN9uh4"
  @@scrub_event_id    = "0079"
  @@previous_event_id = "0078"

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
