README
======



`F1` and `F2` are subframeworks which will be nested into an umbrella framework
`Umbrella1`.




1.	Carefully set linker options. Especially these parts.

		DYLIB_INSTALL_NAME_BASE = @rpath
		LD_RUNPATH_SEARCH_PATHS = $(inherited) @executable_path/../Frameworks @loader_path/Frameworks

	Do this for all subframeworks and the umbrella.

2.	Make sure that you set special linker flags on the umbrella.

		OTHER_LDFLAGS = -sub_umbrella F1 -sub_umbrella F2

	*	Reference: http://lists.apple.com/archives/xcode-users/2006/Aug/msg00637.html
	*	There's also `-sub_library` parameter for non-framework linking.

3.	Include frameworks and subframeworks by *Copy Files* phase into `Frameworks` destination.
	Though the files will be displayed with `... in build/Debug` notice, but it will be built properly
	with release version binary in Release build.





CAVEATS
-------

-	Currently I don't know why *modules* are not working.
	So if you having some problems, then try to turn off any module related features.




