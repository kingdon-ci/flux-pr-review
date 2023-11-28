module Params
  @@google_sheet_id   = "1eKTdxG7EVQhCR4PGEVof7KimGY_GC_O-DcxgXRUrvNU"
  @@scrub_event_id    = "0086"
  @@previous_event_id = "0085"

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
