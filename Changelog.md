Changelog
=========
- 0.79 8/30/2013 Broke up accordian div in events to allow it to better adjust the height
- 0.79 8/29/2013 Additional tests and tuning of the events model. More validations around times and statuses
- 0.79 8/29/2013 Additional tests and tuning of the events model. Not done yet, that will be Version 0.80
- 0.79 8/28/2013 Added remaining accordians to the event#show view. Not great code, long chains, but mostly tested and working
- 0.79 8/28/2013 Added start date tooltip to people#index view
- 0.79 8/24/2013 Major change of direction for events, no adding people to a new event until it's saved.
- 0.79 8/24/2013 Added tooltips showing Start date to Most people views
- 0.79 8/24/2013 Much standardization around the views, removed the sidebars from the views to allow wider views. Added caption tag to the tables for more semantic markup
- 0.79 8/24/2013 Add specs for ensuring that an event creates appropriate timecards and certifications when creating and updating. Added menu for help
- 0.79 8/24/2013 Implemented Changelog ! Moved views (inactive, declined, Police, CERT and leave) onto index.html.erb template. Made datatables for these views click-to-sort on rank and last name and duration using hidden columns so that it wasn;t just a plain ASCII sort.