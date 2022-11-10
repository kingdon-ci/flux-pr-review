module Params
  @@google_sheet_id   = "164hm8ac6fhcBgRnEC_anKnWy7c1TgQGgc85jxp9lgKg"
  @@scrub_event_id    = "0055"
  @@previous_event_id = "0054"

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
