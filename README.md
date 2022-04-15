# App Global Hotkeys Support
 
I was trying to get global hotkeys support in a Mac Xojo going, but couldn't quite finish the job, so I thought I'd just bodge it up with a small dylib instead. (As I'm not bothered about Windows/Linux support.)

This was the result. It's good enough for me, perhaps it will be useful for someone else out there.

To build the Xojo test app, you need the dylib (either compiled from the supplied XCode project, or use the supplied zipped pre-built one).

Copy the dylib into the Frameworks directory of your app (usually with a CopyFiles build step).

The test app has a module with all the required declares, and also has a very simple Dictionary-based store for tracking assigned keys, displaying which has been pressed, and keeping a reference in case you want to de-register a particular key at any point whilst the app is running.

You need to provide a handler (signature `id as Integer`) which will be called with the id of the hotkey:

`GlobalHotKeys.setCallback( AddressOf callback_Handler )`

You install a hot key with the `registerHotKey` method, signature:

`( id as Integer, signature as OSType, keyCode as Integer, withCmdKey as Boolean, withOptionKey as Boolean, withControlKey as Boolean, withShiftKey as Boolean ) returns Ptr`

For example:

`var ptrTo_hk as Ptr = GlobalHotKeys.registerHotKey( 1, "hk_1", 24, true, true, false, false )`

Note that the id is NOT the keyCode or anything like that.

You shoud retain the returned reference (`ptrTo_hk` above) if you think you will later want to de-register that hotkey:

`unregisterHotKey( ref as Ptr )`

If you are not bothered, then I don't think you need to.

But you do need to keep a note somewhere of which id is paired with which key, as otherwise you'll have no way of knowing which `id` in the callback handler is which.

(Unless you've only registered the one hot key, I guess, in which you don't even need to know this!)

