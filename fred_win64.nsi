; FRED_Win Installer
;
; This script is based on example1.nsi, but it remember the directory, 
; has uninstall support and (optionally) installs start menu shortcuts.
;
; It will install FRED.nsi into a directory that the user selects,

;----------------------------------------------------------------------

; The name of the installer
Name "FRED_Win64"

; The file to write
OutFile "fred_win64.exe"

; Request application privileges for Windows Vista
RequestExecutionLevel admin

AllowRootDirInstall true

; The default installation directory
InstallDir "C:\PublicHealthDynamicsLab"

; Registry key to check for directory (so if you install again, it will overwrite the old one automatically)
InstallDirRegKey HKLM "Software\FRED" "Install_Dir"

;--------------------------------

; Pages

Page components
Page directory
DirText "Setup will install FRED to the selected directory. To install into a different directory, click Browse and select another folder.$\nIn order for FRED to operate correctly, THE SELECTED PATHNAME MUST HAVE NO SPACES. So 'C:\Program Files\PublicHealthDynamicsLab' will not work."

Page instfiles

UninstPage uninstConfirm
UninstPage instfiles

;--------------------------------
; The stuff to install

Section "Cygwin & essential libraries (required)"
; Set output path to the installation directory.
  SetOutPath $INSTDIR\cygwin_install_files
  
  ; Put file there
  File /r "PublicHealthDynamicsLab\cygwin_install_files\*"
  Exec '"$OUTDIR\setup-x86_64.exe" -C Development,Editors,Graphics,Perl,Python,Shells,X11'
SectionEnd

Section "FRED (required)"
  SectionIn RO
  
  SetOutPath $INSTDIR\FRED
  File /r "PublicHealthDynamicsLab\FRED\*"
  
  ; Write the installation path into the registry
  WriteRegStr HKLM SOFTWARE\FRED "Install_Dir" "$INSTDIR"
  
  ; Write the uninstall keys for Windows
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\FRED" "DisplayName" "FRED"
  WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\FRED" "UninstallString" '"$INSTDIR\uninstall.exe"'
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\FRED" "NoModify" 1
  WriteRegDWORD HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\FRED" "NoRepair" 1
  WriteUninstaller "uninstall.exe"
  
  ; NOT Optional section (can be disabled by the user)
  ;Section "Start Menu Shortcuts"  
    CreateDirectory "$SMPROGRAMS\FRED"
    CreateShortcut "$SMPROGRAMS\FRED\FRED.lnk" "$INSTDIR\FRED\bin\FRED.bat" "" "$INSTDIR\FRED\bin\FRED.bat" 0
    CreateShortcut "$SMPROGRAMS\FRED\README_FIRST.lnk" "$INSTDIR\FRED\doc\README_FIRST.txt" "" "$INSTDIR\FRED\doc\README_FIRST.txt" 0
    CreateShortcut "$SMPROGRAMS\FRED\QuickStart.lnk" "$INSTDIR\FRED\doc\QuickStart.rtf" "" "$INSTDIR\FRED\doc\FRED_QuickStart.rtf" 0
    CreateShortcut "$SMPROGRAMS\FRED\UserGuide.lnk" "$INSTDIR\FRED\doc\FRED_UserGuide.pdf" "" "$INSTDIR\FRED\doc\FRED_UserGuide.pdf" 0
    CreateShortcut "$SMPROGRAMS\FRED\Uninstall.lnk" "$INSTDIR\uninstall.exe" "" "$INSTDIR\Uninstall.exe" 0
  ;SectionEnd
  
SectionEnd

; Optional section (can be disabled by the user)
Section "FRED examples"
  ; Set output path to the installation directory.
  SetOutPath $INSTDIR\FRED\FRED_examples
  
  File /r "PublicHealthDynamicsLab\FRED_examples\*"
  CreateShortcut "$SMPROGRAMS\FRED\FRED_examples.lnk" "$INSTDIR\FRED\FRED_examples" "" "$INSTDIR\FRED\FRED_examples" 0
SectionEnd

;--------------------------------

; Uninstaller

Section "Uninstall"
  
  ; Remove registry keys
  DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\FRED"
  DeleteRegKey HKLM SOFTWARE\FRED

  ; Remove files and uninstaller
;  Delete $INSTDIR\example2.nsi
;  Delete $INSTDIR\uninstall.exe

  ; Remove shortcuts, if any
  RMDir /r "$SMPROGRAMS\FRED"

  ; Remove directories used
  RMDir /r "$SMPROGRAMS\FRED"
  RMDir /r "$INSTDIR"

SectionEnd
