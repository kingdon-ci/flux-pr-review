module Params
  @@google_sheet_id   = "1cKKGzRuQJ8v3heCRbsjqirb9eqEWRb4E7nfOpf4799g"
  @@scrub_event_id    = "0053"
  @@previous_event_id = "0052"

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
