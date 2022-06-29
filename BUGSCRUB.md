### Bug Scrub Process

In order to generate a new bug scrub spreadsheet, first clone the previous
week's sheet in Google Drive.

Share the new Bug Scrub spreadsheet with everyone who has the link, give editor access.
(Set the previous week's sheet link access to read-only.)

Clone the worksheet and increment the number in the worksheet tab title,
empty the contents in the cloned worksheet while preserving the header row,
then clone the flux-pr-review repo so you can run the process to populate the empty worksheet.

Completely empty the "Raw data" tab. The update process will not begin before it is blank.

Set up the flux-pr-review app's credentials to refresh the login (edit config.json so it contains only `client_id` and `client_secret`. You will need to complete the Login Workflow again, this cred expires every week in Dev mode.)

Ensure EPR gem is installed (Export Pull Requests)

Export `GITHUB_TOKEN` and ensure a github token is set for EPR in `.git/config` (as explained in the EPR readme)

Set the parameters in `bugcrush.rb`: `google_sheet_id`, `scrub_event_id`, and `previous_event_id` then run "make"

Verify the spreadsheet has been populated and the line notes are carried over

Delete the last-week's worksheet tab we cloned out of from this week's bug scrub

Ensure the top row header is still locked

Ensure the emoji column is working as expected

Set the sort order
(Sort by Column I "Stale-Age")

Clear and set the filters on the new worksheet
Column F - State: open
Column B - Type: Issue, Discussion
Column G - Created: Date is after exact date 2022-03-15 (date format - eg. a date less than 6 months ago)
Column H - Updated: Date is before (yesterday) to not worry about issues that are not stale at all yet

Hide columns G,H & J,K & M and get your big monitor ready, (the whole width of the sheet should fit well now)

(Add your name to the Attendance tab in the Host position)
