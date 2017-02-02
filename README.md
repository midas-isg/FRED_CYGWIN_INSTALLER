# FRED_CYGWIN_INSTALLER
This project creates a 64-bit Windows installer of FRED using NSIS (Nullsoft Scriptable Install System).

An example compiled executable (made using the customized Cygwin build of FRED hosted at https://github.com/midas-isg/FRED/tree/FRED-v2.12.0-build-for-cygwin) can be downloaded from here:

http://research.rods.pitt.edu/fred_win64.exe


##Instructions for building:

1. In PublicHealthDynamicsLab/cygwin_install_files directory, place a copy of setup-x86_64.exe (obtained from https://cygwin.com/)

2. In FRED place all of the files from FRED-v2.12.0-build-for-cygwin (or a derived branch which contains bin/FRED.bat) obtained from https://github.com/midas-isg/FRED/tree/FRED-v2.12.0-build-for-cygwin. Make sure that the folder's name remains FRED so that the bin, doc, etc, as well as the other directories and files are located directly within PublicHealthDynamicsLab/FRED.

3. Compile fred_win64.nsi using NSIS compiler (http://nsis.sourceforge.net/Download)

4. The produced installer will be a file labeled fred_win64.exe which should be able to be distributed for installation on modern Windows 64-bit machines (tested on Windows 7 and 10)
