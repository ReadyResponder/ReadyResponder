Changelog
=========
- 0.81 09/12/2013 Fixed small bug related to Unavailable being an intention, not an outcome, until EVent is closed
- 0.81 09/12/2013 Added basic ability to export Event as a spreadsheet
- 0.81 09/10/2013 Fixed bug in Schedule action for events
- 0.81 09/10/2013 Better section for timecards on the person#show view
- 0.80 09/10/2013 Now showing description of timecards on events, turned off duplicate timecard validation for now
- 0.80 09/08/2013 Updates to events and timecards, pulled sections into partials
- 0.79 09/02/2013 Upgraded server to ruby 2.0.0-p247
- 0.79 09/01/2013 Upgraded database from SQLite to Postgresql
- 0.79 08/31/2013 Did a re-direct rather than a render, now no problem with refresh on events
- 0.79 08/31/2013 Added lots to events and event model to support scheduling. Currently cannot reload the page, or it duplicates timecards
- 0.79 08/30/2013 Added Activity model which is polymorphic capture of small events for person, event models (to start)
- 0.79 08/30/2013 Added error_code, middlename prefix_name suffix_name and nickname to person model. 
- 0.79 08/30/2013 Added error_code, id_code to Event model. The id_code will be used to directly access the event thru QRcodes or IVR applications
- 0.79 08/30/2013 Added error_code, description to Timecard model
- 0.79 08/30/2013 From memory, changed timeslots to timecards, split the accordian div up on events, added lots o tests
- 0.79 08/30/2013 DRAT - Discovered I had not saved the Changelog.md file in days, lost the notes; oh well...
- 0.79 08/24/2013 Implemented Changelog ! Moved views (inactive, declined, Police, CERT and leave) onto index.html.erb template. Made datatables for these views click-to-sort on rank and last name and duration using hidden columns so that it wasn;t just a plain ASCII sort.