module Params
  @@google_sheet_id   = FIXME # "1_HOdAPlujN2IuxQKpRW99GKU7hz7in2QpLHQZjjgpn4"
  @@scrub_event_id    = "0058"
  @@previous_event_id = "0057"

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
