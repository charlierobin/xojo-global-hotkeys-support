#tag Class
Protected Class App
Inherits Application
	#tag Event
		Sub Open()
		  me.simpleHotkeysDatabase = new Dictionary()
		  
		  try
		    
		    GlobalHotKeys.setCallback( AddressOf callback_Handler )
		    
		    var ptrTo_hk_1 as Ptr = GlobalHotKeys.registerHotKey( 1, "hk_1", 24, true, true, false, false )
		    
		    me.addHotKeyData( 1, new Dictionary( "name" : "plus key", "ref" : ptrTo_hk_1 ) )
		    
		    
		    var ptrTo_hk_2 as Ptr = GlobalHotKeys.registerHotKey( 2, "hk_2", 27, true, true, false, false )
		    
		    me.addHotKeyData( 2, new Dictionary( "name" : "minus key", "ref" : ptrTo_hk_2 ) )
		    
		  catch e as FunctionNotFoundException
		    
		    System.DebugLog( e.Message )
		    
		  end try
		  
		  
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h0
		Sub addHotKeyData(key as Integer, data as Dictionary)
		  me.simpleHotkeysDatabase.Value( key ) = data
		  
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h21
		Private Shared Sub callback_Handler(id as Integer)
		  var data as Dictionary = App.simpleHotkeysDatabase.Lookup( id, nil )
		  
		  if data <> nil then
		    
		    MessageBox( data.Value( "name" ) )
		    
		  end if
		  
		End Sub
	#tag EndMethod

	#tag Method, Flags = &h0
		Function getHotKeyData(name as String) As Dictionary
		  for each entry as DictionaryEntry in me.simpleHotkeysDatabase
		    
		    var data as Dictionary = entry.Value
		    
		    if data.Lookup( "name", "" ) = name then return data
		    
		  next
		  
		  return nil
		  
		End Function
	#tag EndMethod

	#tag Method, Flags = &h0
		Sub removeHotKeyData(data as Dictionary)
		  var keyToRemove as Integer = -1
		  
		  for each key as Integer in me.simpleHotkeysDatabase.Keys()
		    
		    if me.simpleHotkeysDatabase.Value( key ) = data then
		      
		      keyToRemove = key
		      
		      exit
		      
		    end if
		    
		  next
		  
		  if keyToRemove > -1 then
		    
		    me.simpleHotkeysDatabase.Remove( keyToRemove )
		    
		  end if
		  
		End Sub
	#tag EndMethod


	#tag Property, Flags = &h21
		Private simpleHotkeysDatabase As Dictionary
	#tag EndProperty


	#tag Constant, Name = kEditClear, Type = String, Dynamic = False, Default = \"&Delete", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"&Delete"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"&Delete"
	#tag EndConstant

	#tag Constant, Name = kFileQuit, Type = String, Dynamic = False, Default = \"&Quit", Scope = Public
		#Tag Instance, Platform = Windows, Language = Default, Definition  = \"E&xit"
	#tag EndConstant

	#tag Constant, Name = kFileQuitShortcut, Type = String, Dynamic = False, Default = \"", Scope = Public
		#Tag Instance, Platform = Mac OS, Language = Default, Definition  = \"Cmd+Q"
		#Tag Instance, Platform = Linux, Language = Default, Definition  = \"Ctrl+Q"
	#tag EndConstant


	#tag ViewBehavior
	#tag EndViewBehavior
End Class
#tag EndClass
