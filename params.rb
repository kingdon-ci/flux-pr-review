module Params
  @@google_sheet_id   = "1eqWSGfyxlr-ca7QZzsOdy4lrxsaxg8g3ima7SvOVCEU"
  @@scrub_event_id    = "0084"
  @@previous_event_id = "0083"

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
