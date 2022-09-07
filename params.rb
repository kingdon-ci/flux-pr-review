module Params
  @@google_sheet_id   = "18PVpzXiw8PaHbYSauPgxa3X-Wcu0GNQdQ_Y13EDEAHY"
  @@scrub_event_id    = "0046"
  @@previous_event_id = "0045"

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
