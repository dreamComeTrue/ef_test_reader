ef_test_reader
==============

Implementation of the test app for EF.

This iOS application is a simple RSS-feed readed.

It will show you a list of the last BBC news. You can change the feed address in the phone Settings app.
News listed with the image, title and short description fields, sorted by publication time.
Upper right button allow to refresh list content if internet connection is available.
If connection is not available the button will be titled "Offline" and does nothing.
Tap on list cell will open screen with the full publication content.
Upper right button will open the page on the BBC website.
The last most news list is always be saved to allow to work in offline.
The app uses a simple image cache so all news images are saved too.

3rd party frameworks:
– XMLDictionary
– Reachability
