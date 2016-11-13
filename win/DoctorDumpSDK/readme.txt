==========================
CrashRpt.CPP NuGet package
==========================

CrashRpt is a C++ library created to automate the bug reporting process.
It works with native Windows C++ applications.

To finish integration find "crashrpt.cpp" file that was added to your project.
Generate new GUID (http://www.guidgenerator.com/) and replace 00000000-0000-0000-0000-000000000000 with it.
And change application and vendor names to some friendly values:
====================================================================================================================================
#include <CrashRpt.h>

/*
   +-------------------------------------------------+
   | @ {AppName}                                   X |
   +-------------------------------------------------+
   |                                                 |
   | {AppName} has stopped working                   |
   |                                                 |
   | Sending collected information to the {Company}. |
   | This might take several minutes...   +--------+ |
   |                                      | Cancel | |
   |                                      +--------+ |
   +-------------------------------------------------+
*/

// global crash handler
crash_rpt::CrashRpt g_crashRpt(
#error Generate new GUID (http://www.guidgenerator.com/) and replace 00000000-0000-0000-0000-000000000000 with it.
	"00000000-0000-0000-0000-000000000000", // GUID assigned to this application.
	L"{AppName}",                           // Application name that will be used in message box.
	L"{Company}"                            // Company name that will be used in message box.
	);
====================================================================================================================================

Now you may test it. Add this code to some place you may reach easy:
	*((int*)0) = 0;

Build your application, START WITHOUT DEBUGGING (Ctrl+F5) and see what happens!


If you have any questions go to http://drdump.com/Integration.aspx
