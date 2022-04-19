#tag Window
Begin Window Window1
   Backdrop        =   0
   BackgroundColor =   &cFFFFFF00
   Composite       =   False
   DefaultLocation =   2
   FullScreen      =   False
   HasBackgroundColor=   False
   HasCloseButton  =   True
   HasFullScreenButton=   False
   HasMaximizeButton=   False
   HasMinimizeButton=   False
   Height          =   382
   ImplicitInstance=   True
   MacProcID       =   0
   MaximumHeight   =   32000
   MaximumWidth    =   32000
   MenuBar         =   1182132223
   MenuBarVisible  =   True
   MinimumHeight   =   64
   MinimumWidth    =   64
   Resizeable      =   False
   Title           =   "Untitled"
   Type            =   0
   Visible         =   True
   Width           =   524
   Begin PushButton PushButtonUnRegPlus
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Unregister + key"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   361
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   0
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   342
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   143
   End
   Begin Label LabelAbout
      AllowAutoDeactivate=   True
      Bold            =   False
      DataField       =   ""
      DataSource      =   ""
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   310
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   20
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   True
      LockRight       =   True
      LockTop         =   True
      Multiline       =   True
      Scope           =   2
      Selectable      =   False
      TabIndex        =   1
      TabPanelIndex   =   0
      TabStop         =   True
      Text            =   "A very simple test app to see if the global hotkeys dylib is working.\n\nAnd it seems to … at least, on my machine. For now …\n\nThe dylib is the bare minimum, and does no tracking of what has been registered, so that has to be done here in the app.\n\nThere is an app property declared as a Dictionary, with a few helper methods, to track hotkeys, their IDs, their references (should you want to remove them during the life cycle of the app), and a human friendly name for display when handled.\n\nThe two keys setup for testing in the App Open event are:\n\ncommand-option +\n\ncommand-option -"
      TextAlignment   =   0
      TextColor       =   &c00000000
      Tooltip         =   ""
      Top             =   20
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   484
   End
   Begin PushButton PushButtonRegPlus
      AllowAutoDeactivate=   True
      Bold            =   False
      Cancel          =   False
      Caption         =   "Register + key"
      Default         =   False
      Enabled         =   True
      FontName        =   "System"
      FontSize        =   0.0
      FontUnit        =   0
      Height          =   20
      Index           =   -2147483648
      InitialParent   =   ""
      Italic          =   False
      Left            =   206
      LockBottom      =   True
      LockedInPosition=   False
      LockLeft        =   False
      LockRight       =   True
      LockTop         =   False
      MacButtonStyle  =   0
      Scope           =   2
      TabIndex        =   2
      TabPanelIndex   =   0
      TabStop         =   True
      Tooltip         =   ""
      Top             =   342
      Transparent     =   False
      Underline       =   False
      Visible         =   True
      Width           =   143
   End
End
#tag EndWindow

#tag WindowCode
	#tag Event
		Sub Open()
		  self.updateButtons()
		  
		End Sub
	#tag EndEvent


	#tag Method, Flags = &h21
		Private Sub updateButtons()
		  var data as Dictionary = App.getHotKeyData( "plus key" )
		  
		  if data is nil then
		    
		    self.PushButtonRegPlus.Enabled = true
		    
		    self.PushButtonUnRegPlus.Enabled = false
		    
		  else
		    
		    self.PushButtonRegPlus.Enabled = false
		    
		    self.PushButtonUnRegPlus.Enabled = true
		    
		  end if
		  
		End Sub
	#tag EndMethod


#tag EndWindowCode

#tag Events PushButtonUnRegPlus
	#tag Event
		Sub Action()
		  var data as Dictionary = App.getHotKeyData( "plus key" )
		  
		  if data <> nil then
		    
		    var ref as Ptr = data.Value( "ref" )
		    
		    GlobalHotKeys.unregisterHotKey( ref )
		    
		    App.removeHotKeyData( data )
		    
		  end if
		  
		  self.updateButtons()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
#tag Events PushButtonRegPlus
	#tag Event
		Sub Action()
		  var ptrTo_hk_1 as Ptr = GlobalHotKeys.registerHotKey( 1, "hk_1", 24, GlobalHotKeys.CommandKey.Yes, GlobalHotKeys.OptionKey.Yes, GlobalHotKeys.ControlKey.No, GlobalHotKeys.ShiftKey.No )
		  
		  App.addHotKeyData( 1, new Dictionary( "name" : "plus key", "ref" : ptrTo_hk_1 ) )
		  
		  self.updateButtons()
		  
		End Sub
	#tag EndEvent
#tag EndEvents
