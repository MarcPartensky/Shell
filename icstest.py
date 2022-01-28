#!/usr/bin/env python

import os
from datetime import datetime
import pytz
from icalendar import Calendar, Event

cal = Calendar()
cal.add("attendee", "MAILTO:marc.partensky@gmail.com")

event = Event()
event.add("summary", "Python meeting about calendaring")
event.add("dtstart", datetime(2021, 4, 4, 8, 0, 0, tzinfo=pytz.utc))
event.add("dtend", datetime(2021, 4, 4, 10, 0, 0, tzinfo=pytz.utc))
event.add("dtstamp", datetime(2021, 4, 4, 0, 10, 0, tzinfo=pytz.utc))

# Adding events to calendar
cal.add_component(event)

directory = "/tmp"
print(directory)
f = open(os.path.join(directory, "test.ics"), "wb")
f.write(cal.to_ical())
f.close()
