module Params
  @@google_sheet_id   = "1cixcqcCUhHbXVIA0dc_RxHH5h-emoQeWIJaOFI1GSLY"
  @@scrub_event_id    = "0054"
  @@previous_event_id = "0053"

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
