module Params
  @@google_sheet_id   = "1y0hxzdNYEAvVKmqlFFECpI1wbY4K5PPsWgulC-bkIGI"
  @@scrub_event_id    = "0061"
  @@previous_event_id = "0060"

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
