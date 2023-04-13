module Params
  @@google_sheet_id   = "1ehN1x8DHN-CG9gdu8b_EURHH-tYfQ1yVDwAQjLEsEO8"
  @@scrub_event_id    = "0067"
  @@previous_event_id = "0066"

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
