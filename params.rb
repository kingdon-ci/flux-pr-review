module Params
  @@google_sheet_id   = "1_EY4C-lgfSaUeTcXEg-RsE-K457ReKLzxGqjuPHFKYg"
  @@scrub_event_id    = "0065"
  @@previous_event_id = "0064"

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
