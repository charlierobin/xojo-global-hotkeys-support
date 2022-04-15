//
//  main.c
//  global hotkeys shim for xojo, a bodge because can't get it to work with declares in xojo (for now)
//
//  Created by charlie robin on 10/03/2019.
//
//  https://snippets.aktagon.com/snippets/361-registering-global-hot-keys-with-cocoa-and-objective-c
//

#import <Carbon/Carbon.h>

typedef void (*handler)(int);

static handler g_CallbackFunction;

static Boolean g_Inited = false;

static OSStatus OnHotKeyEvent( EventHandlerCallRef nextHandler, EventRef theEvent, void *userData )
{
    EventHotKeyID hkEvent;
    
    GetEventParameter( theEvent, kEventParamDirectObject, typeEventHotKeyID, NULL, sizeof( hkEvent ), NULL, &hkEvent );

    g_CallbackFunction( hkEvent.id );
    
    return noErr;
}

static void init()
{
    EventTypeSpec eventType;
    
    eventType.eventClass = kEventClassKeyboard;
    eventType.eventKind = kEventHotKeyPressed;
    
    InstallApplicationEventHandler( &OnHotKeyEvent, 1, &eventType, NULL, NULL );
}

EventHotKeyRef registerHotKey( int id, OSType signature, int keyCode, Boolean withCmdKey, Boolean withOptionKey, Boolean withControlKey, Boolean withShiftKey )
{
    if ( ! g_Inited )
    {
        init();
        g_Inited = true;
    }
    
    EventHotKeyID hotKeyID = { .signature = signature, .id = id };
        
    UInt32 inHotKeyModifiers = 0;
    
    if ( withCmdKey ) inHotKeyModifiers = inHotKeyModifiers + cmdKey;
    if ( withOptionKey ) inHotKeyModifiers = inHotKeyModifiers + optionKey;
    if ( withControlKey ) inHotKeyModifiers = inHotKeyModifiers + controlKey;
    if ( withShiftKey ) inHotKeyModifiers = inHotKeyModifiers + shiftKey;
    
    EventHotKeyRef hotKeyRef;
    
    RegisterEventHotKey( keyCode, inHotKeyModifiers, hotKeyID, GetApplicationEventTarget(), 0, &hotKeyRef );
    
    return hotKeyRef;
}

void unregisterHotKey( EventHotKeyRef hotKeyRef )
{
    UnregisterEventHotKey( hotKeyRef );
}

void setCallback( handler xojoAddressOf )
{
    g_CallbackFunction = xojoAddressOf;
}

