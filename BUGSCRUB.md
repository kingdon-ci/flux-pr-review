### Bug Scrub Process

In order to generate a new bug scrub spreadsheet, first clone the previous
week's sheet in Google Drive.

Share the new Bug Scrub spreadsheet with everyone who has the link, give editor access.
(Set the previous week's sheet link access to read-only.)

Clone the worksheet and increment the number in the worksheet tab title,
empty the contents in the cloned worksheet, then clone the flux-pr-review repo.

Set up the flux-pr-review app's credentials to refresh the login (edit config.json)

Ensure EPR gem is installed (Export Pull Requests)

Export `GITHUB_TOKEN` and ensure a github token is set for EPR in `.git/config` (as explained in the EPR readme)

Run "make"

Verify the spreadsheet has been populated and the line notes are carried over

Delete the last-week's worksheet tab we cloned out of from this week's bug scrub

Ensure the top row header is still locked

Ensure the emoji column is working as expected

Set the sort order

Set the filters

(Add your name to the Attendance tab in the Host position)
