module Params
  @@google_sheet_id   = "1Jn-is1FTy0ovIJoni_g8EyiarDWEH9xcIjUlW7QAeFg"
  @@scrub_event_id    = "0059"
  @@previous_event_id = "0058"

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
