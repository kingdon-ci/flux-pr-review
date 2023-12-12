module Params
  @@google_sheet_id   = "15eOvdnFwQ24HgWmQrlZm-wcdQPGZPIDZ6bWlLxxyxWA"
  @@scrub_event_id    = "0088"
  @@previous_event_id = "0087"

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
