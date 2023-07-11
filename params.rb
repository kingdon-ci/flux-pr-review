module Params
  @@google_sheet_id   = "1PmDxJ56vHhPQPBUsV4llAnqSm4t2i8REBR5mWO7k9CA"
  @@scrub_event_id    = "0074"
  @@previous_event_id = "0073"

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
