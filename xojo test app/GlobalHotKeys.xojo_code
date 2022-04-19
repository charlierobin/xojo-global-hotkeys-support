#tag Module
Protected Module GlobalHotKeys
	#tag ExternalMethod, Flags = &h1
		Protected Declare Function registerHotKey Lib dylib (id as Integer, signature as OSType, keyCode as Integer, withCmdKey as CommandKey, withOptionKey as OptionKey, withControlKey as ControlKey, withShiftKey as ShiftKey) As Ptr
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub setCallback Lib dylib (handler as Ptr)
	#tag EndExternalMethod

	#tag ExternalMethod, Flags = &h1
		Protected Declare Sub unregisterHotKey Lib dylib (ref as Ptr)
	#tag EndExternalMethod


	#tag Constant, Name = dylib, Type = String, Dynamic = False, Default = \"@executable_path/../Frameworks/libglobal-hotkeys-shim-for-xojo.dylib", Scope = Private
	#tag EndConstant


	#tag Enum, Name = CommandKey, Type = Integer, Flags = &h1
		No
		Yes
	#tag EndEnum

	#tag Enum, Name = ControlKey, Type = Integer, Flags = &h1
		No
		Yes
	#tag EndEnum

	#tag Enum, Name = OptionKey, Type = Integer, Flags = &h1
		No
		Yes
	#tag EndEnum

	#tag Enum, Name = ShiftKey, Type = Integer, Flags = &h1
		No
		Yes
	#tag EndEnum


	#tag ViewBehavior
		#tag ViewProperty
			Name="Name"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Index"
			Visible=true
			Group="ID"
			InitialValue="-2147483648"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Super"
			Visible=true
			Group="ID"
			InitialValue=""
			Type="String"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Left"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
		#tag ViewProperty
			Name="Top"
			Visible=true
			Group="Position"
			InitialValue="0"
			Type="Integer"
			EditorType=""
		#tag EndViewProperty
	#tag EndViewBehavior
End Module
#tag EndModule
