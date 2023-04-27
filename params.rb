module Params
  @@google_sheet_id   = "1PdWT8Ha-D-G4rbwBWSM0_GCLc7FyYEPYwitwyBekpek"
  @@scrub_event_id    = "0068"
  @@previous_event_id = "0067"

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
