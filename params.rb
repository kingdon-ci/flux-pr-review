module Params
  @@google_sheet_id   = "1EL20ejDnoxFBY_pDC5CYDh0igE8uSyZswu3FqkGX_7M"
  @@scrub_event_id    = "0044"
  @@previous_event_id = "0043"

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
