module Params
  @@google_sheet_id   = "1Zy1hFd5w7FbTu7BcWRyxryDMD4YnxZ9xxv3uWsYCGJE"
  @@scrub_event_id    = "0062"
  @@previous_event_id = "0061"

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
