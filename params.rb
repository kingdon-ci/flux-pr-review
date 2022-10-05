module Params
  @@google_sheet_id   = "1eqCeExJ146Tknsi_Yk-a6P02wD-aaON6n7B_NqGHBd8"
  @@scrub_event_id    = "0051"
  @@previous_event_id = "0050"

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
