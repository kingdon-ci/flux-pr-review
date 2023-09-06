module Params
  @@google_sheet_id   = "1jy0iDjBp9X14ChEPetyV6fwZTY08inWexqpjvdW7tYM"
  @@scrub_event_id    = "0078"
  @@previous_event_id = "0077"

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
