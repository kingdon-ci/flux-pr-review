module Params
  @@google_sheet_id   = "1v6HrPBq16guDHmThBFp9cUfYvTYUql8GmbjJqbmwYD0"
  @@scrub_event_id    = "0070"
  @@previous_event_id = "0069"

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
