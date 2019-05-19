# Version 1

## Date Time Considerations

* API returns date time text and UTC time, since UTC time is globally true it is used on Calculations.

## Calculation Considerations

* Degree values have been rounded for UI purposes

## Image Considerations

* Used image cache has been defined in global scope and is a simple performance improvement. It can be improved with Queues and active download tasks. For better implementation it should be removed from global scope and used with a Cache manager class.


## City

* Single City selected as demonstration purposes.