Changelog
=========
- 0.79 8/30/2013 Added error_code, middlename prefix_name suffix_name and nickname to person model. 
- 0.79 8/30/2013 Added error_code, id_code to Event model. The id_code will be used to directly access the event thru QRcodes or IVR applications
- 0.79 8/30/2013 Added error_code, description to Timecard model
- 0.79 8/30/2013 From memory, changed timeslots to timecards, split the accordian div up on events, added lots o tests
- 0.79 8/30/2013 DRAT - Discovered I had not saved the Changelog.md file in days, lost the notes; oh well...
- 0.79 8/24/2013 Implemented Changelog ! Moved views (inactive, declined, Police, CERT and leave) onto index.html.erb template. Made datatables for these views click-to-sort on rank and last name and duration using hidden columns so that it wasn;t just a plain ASCII sort.