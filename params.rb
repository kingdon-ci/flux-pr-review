module Params
  @@google_sheet_id   = "1soDdiad5KDJhcET3sUd1_KVZVdsBVSGhYX5GGuS2VRI"
  @@scrub_event_id    = "0085"
  @@previous_event_id = "0084"

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
