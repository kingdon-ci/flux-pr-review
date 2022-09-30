module Params
  @@google_sheet_id   = "1pmqSAcdxmSjh3CSuMSqRaoXrB8v0CIfwsVQe5ZzM350"
  @@scrub_event_id    = "0050"
  @@previous_event_id = "0049"

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
