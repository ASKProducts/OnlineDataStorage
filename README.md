OnlineDataStorage
=================

Making use of nice online data storage that takes no download or setup

This is a small iPhone app that acts as a manually refreshed message board accessible from any device. 
The ODSDataStorage.h and .m files is the class that deal with memory storage.
If you want to implant this system into your own app, you must first set it up to be with you app:
1. Somewhere along the way, (do this only once), add this piece of code:
NSLog(@"%@",[ODSDatastorage addValue:@"{}"]);
2. Run the code, then remove it from your app. Take note of the 6 digit key that is logged during the run
3. In the ODSDataStorage.h file, set the ONLINE_DATA_STORAGE_APP_KEY to be the NSString of your key
