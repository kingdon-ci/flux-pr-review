module Params
  @@google_sheet_id   = "1Q36AoWc0JEbIxhqNw22Df_1Xa6Svp787xixrIW5zPI4"
  @@scrub_event_id    = "0066"
  @@previous_event_id = "0065"

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
