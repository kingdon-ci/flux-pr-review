module Params
  @@google_sheet_id   = "11_GP80hxb4IWC9mIffZZOahwcJCskJU8XQPQ9BIx0No"
  @@scrub_event_id    = "0080"
  @@previous_event_id = "0079"

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
