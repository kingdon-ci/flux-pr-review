module Params
  @@google_sheet_id   = "11tpHXc6SHJO_vIyj-9Z2UA-dpV9oTfdk7Pst7dgwe7k"
  @@scrub_event_id    = "0047"
  @@previous_event_id = "0046"

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
