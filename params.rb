module Params
  @@google_sheet_id   = "1hVojhbssTtPGCv8lqPkAa-5ULHE95DZD_iFQVvZS8gE"
  @@scrub_event_id    = "0081"
  @@previous_event_id = "0080"

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
