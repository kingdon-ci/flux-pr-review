### Bug Scrub Process

1. In order to generate a new bug scrub spreadsheet, first clone the previous
   week's sheet in Google Drive.

2. Share the new Bug Scrub spreadsheet with everyone who has the link, give
   editor access.  (Set the previous week's sheet link access to read-only.)

3. Ensure EPR gem is installed (Export Pull Requests) and all other dependencies
   Do: `rvm gemset create bugscrub testing && bundle install`

4. Clone the worksheet and increment the number in the worksheet tab title

   # (Edit: skip all this noise it's part of step 8 now -- empty the contents in the cloned worksheet
   #  while preserving the header row, then clone the flux-pr-review repo so you
   #  can run the process to populate the empty worksheet.)

5. I keep a `GITHUB_TOKEN` in .env.local so I run `. .env.local` or `source .env.local`
   (This token should be scoped for Read:Discussions on the repo with Discussions)
   Export `GITHUB_TOKEN` and ensure a github token is set for EPR in `.git/config`
   (as explained in the EPR readme) - you may want to handle this a different way.

6. Completely empty the "Raw data" tab,  (Edit: skip this step, it's done by `make reset` in step 8.)

   # and hollow out rows beneath the frozen header row in the cloned tab
   # created in Step 4. The update process will not begin before both are blank.

7. Set up the flux-pr-review app's credentials to refresh the login if needed
   (edit config.json so it contains only `client_id` and `client_secret`. You
   will need to complete the Login Workflow again, this cred expires every week
   in Dev mode.)

8. Set the parameters in `params.rb`: `google_sheet_id`, `scrub_event_id`, and
   `previous_event_id` then run `make reset all`

 You can do the cleanup from Step 4 and 6 easily and quickly by running `make reset`

   # – NOTE:
   # this will also hollow out the sheet named by `scrub_event_id` in params.rb
   # so BE CAREFUL as you can lose your progress by running this in the wrong order.
   # Proceed with step 7 and 8 before running `make reset`.

The rest of the steps are for verification, they are not order-critical:

- Verify the spreadsheet has been populated and the line notes are carried over

- Delete the last-week's worksheet tab we cloned out of from this week's bug scrub

- Ensure the top row header is still locked (it will likely have been unlocked)

- Ensure the emoji column is working as expected

- Set the sort order
   (Sort by Column I "Stale-Age")

- Clear and set the filters on the new worksheet, (they will not update themselves)
   Column F - State: open
   Column B - Type: Issue, Discussion
   Column G - Created: Date is after exact date 2022-03-15 (date format - eg. a date less than 6 months ago)
   Column H - Updated: Date is before (yesterday) to not worry about issues that are not stale at all yet

- Hide columns G,H & J,K & M and get your big monitor ready, (the whole width of the sheet should fit well now)

- (Add your name to the Attendance tab in the Host position)
