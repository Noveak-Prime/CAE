:: -- SET-UP -- ::
:STRT
@ECHO OFF
SETLOCAL EnableDelayedExpansion 
SETLOCAL EnableExtensions
MODE CON: CP SELECT=65001>NUL
:: -- SCRIPT START -- ::
CLS
SET CMDS="CAE.EXT" "CAE.CFG" "CAE.CLR" "SYSC HLT" "SYSC RBT" "SYSC HIB" "SYSC HCF" "SYSC KBC CHK" "SYSC KBC CPD" "KBC.KEYS" "#print" "#RaiseError" "#RaErr" "#concat" "RPR.RPT" "CAE.HLP" "CAE.ABT" "CAE.CFG" "CAE.DAT" "CAE.EDS" "#calc" "CAE.RBT" "#TS" "#DS"
SET "Version=0.18.3"
SET "SpecialVersionType="
SET "VersionType=CLOSED BETA"
SET "Edition=DEFINITIVE"
SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
TITLE !WinTitle!
SET "QuotWarn=ALWAYS KEEP IN MIND: IGNORE ALL QUOTATION MARKS EXCEPT IN ERROR MESSAGES (THIS MESSAGE WILL ONLY BE SHOWN ONCE PER SESSION)"
SET "ExecProc=MProc"
IF "!SpecialVersionType!"=="" (
   SET "InitWinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR VERSION !Version! !VersionType! - !Edition! EDITION"
) ELSE (
   SET "InitWinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR VERSION !Version! !VersionType! !SpecialVersionType! - !Edition! EDITION"
)
SET /A "delay=4"
SET /A "delay+=1"
:MAIN
ECHO:
ECHO  !InitWinTitle!
ECHO:
ECHO  !QuotWarn!
ECHO  EXECUTE "CAE.HLP" TO SUMMON HELP FILE
ECHO:
ECHO:
:INIT
@SET "Instr="
ECHO:
SET /P Instr="~ "
IF "!Instr!"=="CAE.EXT" (
   ECHO  TERMINATING EMULATOR SESSION...
   PING localhost -n 4 > NUL
   ECHO:
   ECHO  EMULATOR SESSION TERMINATED
   ENDLOCAL DisableDelayedExpansion
   ENDLOCAL DisableExtensions
   ECHO:
   ECHO:
   EXIT
)
IF "!Instr!"=="CAE.CLR" (
   CLS
   GOTO :INIT
)
:: -- SYSC INSTRUCTIONS -- ::
IF "!Instr!"=="SYSC HLT" (
   ECHO  !ExecProc! ^^!^> ^0 : EMULATOR CAN NOT HALT A COMPONENT
   GOTO :INIT
)
IF "!Instr!"=="SYSC RBT" (
   ECHO  !ExecProc! ^^!^> ^0 : EMULATOR CAN NOT REBOOT A COMPONENT
   GOTO :INIT
)
IF "!Instr!"=="SYSC HIB" (
   ECHO  !ExecProc! ^^!^> ^0 : EMULATOR CAN NOT HIBERNATE A COMPONENT
   GOTO :INIT
)
:: -- KBC INSTRUCTIONS -- ::
IF "!Instr!"=="SYSC KBC CHK" (
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR - SYSTEM FAILURE"
   TITLE !WinTitle!
   CLS
   ECHO:
   ECHO  SYSTEM FAILURE - SYSTEM HALTED
   ECHO     MACHINE_CHECK_EXCEPTION
   ECHO:
   ECHO  A CRITICAL FAILURE HAS BEEN DETECTED IN COMPONENT "MProc"
   ECHO  THE SYSTEM HAS BEEN HALTED TO PREVENT DATA LOSS
   ECHO:
   ECHO  ---- DETAILS ------------------------------------------------------
   ECHO    CATCHER : "Processor Integrity Checker"
   ECHO    CATCHER_MSG : CRITICAL FAILURE IN MAIN PROCESSOR, SYSTEM HALTED
   ECHO    KBC_KEY : CHK
   ECHO  -------------------------------------------------------------------
   ECHO:
   ECHO  PRESS ^[RETURN^] TO RESTART
   PAUSE>NUL
   SET "ExecProc=ResProc"
   CLS
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
   TITLE !WinTitle!
   GOTO :MAIN
)
IF "!Instr!"=="SYSC KBC CPD" (
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR - SYSTEM FAILURE"
   TITLE !WinTitle!
   CLS
   ECHO:
   ECHO  SYSTEM FAILURE - SYSTEM HALTED
   ECHO      CRITICAL_PROCESS_DIED
   ECHO:
   ECHO  A CRITICAL SYSTEM PROCESS HAS TERMINATED
   ECHO  THE SYSTEM HAS BEEN HALTED TO PREVENT DATA LOSS
   ECHO:
   ECHO  ---- DETAILS ---------------------------------------------------------
   ECHO    CATCHER : KRNL
   ECHO    CATCHER_MSG : A CRITICAL SYSTEM PROCESS TERMINATED, SYSTEM HALTED
   ECHO    KBC_KEY : CPD
   ECHO  ----------------------------------------------------------------------
   ECHO:
   ECHO  PRESS ^[RETURN^] TO RESTART
   PAUSE>NUL
   SET "ExecProc=ResProc"
   CLS
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
   TITLE !WinTitle!
   GOTO :MAIN
)
IF "!Instr!"=="SYSC KBC KIF" (
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR - SYSTEM FAILURE"
   TITLE !WinTitle!
   CLS
   ECHO:
   ECHO  SYSTEM FAILURE - SYSTEM HALTED
   ECHO       KERNEL_INIT_FAILURE
   ECHO:
   ECHO  THE KERNEL HAS FAILED TO INITIALISE
   ECHO  THE SYSTEM HAS BEEN HALTED TO PREVENT DATA LOSS
   ECHO:
   ECHO  ---- DETAILS -------------------------------------------------------
   ECHO    CATCHER : CyberBootMgr
   ECHO    CATCHER_MSG : MAIN KERNEL FAILED TO INITIALISE, SYSTEM HALTED 
   ECHO    KBC_KEY : KIF
   ECHO  --------------------------------------------------------------------
   ECHO:
   ECHO  PRESS ^[RETURN^] TO RESTART
   PAUSE>NUL
   SET "ExecProc=ResProc"
   CLS
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
   TITLE !WinTitle!
   GOTO :MAIN
)
IF "!Instr!"=="KBC.KEYS" (
   ECHO  ---- KERNEL BUG CHECKER: HELP FILE -----------------------------------------
   ECHO:
   ECHO   "CHK" : MACHINE_CHECK_EXCEPTION
   ECHO   "CPD" : CRITICAL_PROCESS_DIED
   ECHO   "KIF" : KERNEL_INIT_FAILURE
   ECHO:
   ECHO   CALL KBC BY WRITING "SYSC KBC " AND THEN ONE OF THE KEYWORD LISTED ABOVE
   ECHO  ----------------------------------------------------------------------------
   GOTO :INIT
)
:: -- FUNCTIONS -- ::
IF "!Instr!"=="#print" (
   SET /P data="?> data [STR]: "
   ECHO  #^> !data!
   GOTO :INIT
)
IF "!Instr!"=="#RaiseError" (
   SET /P msg="?> msg [STR]: "
   SET /P errLvl="?> errLvl [INT]: "
   SET /P statCode="?> statCode [INT]: "
   IF "!errLvl!"=="1" (
      ECHO  #^> A CRITICAL ERROR HAS OCCURRED: !msg!^. ^(!statCode!^)^. HALTING EXECUTION.
      GOTO :INIT
   )
   IF "!errLvl!"=="0" (
      ECHO  #^> AN ERROR HAS OCCURRED: !msg!^. ^(!statCode!^)^. CONTINUING EXECUTION
      GOTO :INIT
   )
   GOTO :INIT
)

IF "!Instr!"=="#RaErr" (
   SET /P msg="?> msg [STR]: "
   SET /P errLvl="?> errLvl [INT]: "
   SET /P statCode="?> statCode [INT]: "
   IF "!errLvl!"=="1" (
      ECHO  #^> A CRITICAL ERROR HAS OCCURRED: !msg!^. ^(!statCode!^)^. HALTING EXECUTION.
      GOTO :INIT
   )
   IF "!errLvl!"=="0" (
      ECHO  #^> AN ERROR HAS OCCURRED: !msg!^. ^(!statCode!^)^. CONTINUING EXECUTION
      GOTO :INIT
   )
   GOTO :INIT
)
IF "!Instr!"=="#concat" (
   SET /P str1="?> firstString [STR]: "
   SET /P str2="?> secondString [STR]: "
   SET "ConcatString=!str1!!str2!"
   ECHO  #^> !ConcatString!
   GOTO :INIT
)
IF "!Instr!"=="#calc" (
   SET OPS="+" "-" "*" "/"
   SET /P "fNum=?> firstNumber [INT]: "
   SET /P "Op=?> Operation [STR]: "
   SET /P "sNum=?> secondNumber [INT]: "
   IF "!fNum!"=="0" (
      IF "!Op!"=="/" (
         IF "!sNum!"=="0" (
            ECHO  MthProc ^^!^> ^0 : DIVISION BY ZERO IS NOT POSSIBLE
            GOTO :INIT
         )
      )
   )
   IF "!Op!"=="+" (
      SET /A result=!fNum! + !sNum!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!"=="-" (
      SET /A result=!fNum! - !sNum!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!"=="*" (
      SET /A result=!fNum! * !sNum!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!"=="/" (
      SET /A result=!fNum! / !sNum!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!" NEQ "!OPS!" (
      ECHO  MthProc ^^!^> ^0 : "!Op!" IS NOT A VALID MATHEMATICAL OPERATION.
      GOTO :INIT
   )
)
IF "!Instr!"=="#AssocArray" (
   ECHO  !ExecProc! ^^!^> ^0 : ASSOCIATIVE ARRAYS ARE UNVAILABLE IN THE EMULATOR
   GOTO :INIT
)
IF "!Instr!"=="#Array" (
   ECHO  !ExecProc! ^^!^> ^0 : ARRAYS ARE UNVAILABLE IN THE EMULATOR
   GOTO :INIT
)
IF "!Instr!"=="#TS" (
   FOR /F "delims=" %%i IN ('TIME /T') DO (
      SET TIME=%%i
      )
      ECHO  #^> !TIME!
   GOTO :INIT
)
IF "!Instr!"=="#DS" (
   FOR /F "delims=" %%i IN ('DATE /T') DO (
      SET DATE=%%i
      )
      ECHO  #^> !DATE!
   GOTO :INIT
)
:: -- INSTRUCTIONS -- ::
IF "!Instr!"=="RPR.RPT" (
   ECHO  !ExecProc! ^^!^> ^0 : "!Instr!" IS UNVAILABLE IN THE EMULATOR
   GOTO :INIT
)
:: -- CAE INSTRUCTIONS -- ::
IF "!Instr!"=="CAE.HLP" (
   ECHO  ---------- CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR: HELP FILE -------------------------------
   ECHO    "CAE.CLR" : Clears output. 
   ECHO    "SYSC KBC" : Crash the emulator. HELP FILE: "KBC.KEYS"
   ECHO    "CAE.EXT" : Exits the Emulator
   ECHO    "CAE.HLP" : Summons this help file
   ECHO    "CAE.ABT" : Summons a help file regarding the Emulator
   ECHO    "CAE.DAT" : Summons datatypes help file
   ECHO    "CAE.CFG" : Configure the Emulator
   ECHO    "CAE.EDS" : Summons help file regarding the editions
   ECHO    "CAE.RBT" : Restarts the Emulator
   ECHO    "#print" : Outputs something
   ECHO    "#RaiseError" : Outputs a custom error message
   ECHO    "#RaErr" : Alias of above
   ECHO    "#concat" : Concatenates two strings ^(Include spaces^)
   ECHO    "#calc" : Calculates the result of two integers
   ECHO    "#TS" : Displays the current system time
   ECHO    "#DS" : Displays the current system date
   ECHO  -------------------------------------------------------------------------------------------
   ECHO:
   ECHO:
   ECHO  --------------------------------------
   ECHO    "SYSC HLT" : Halts component
   ECHO    "SYSC RBT" : Reboots component
   ECHO    "SYSC HIB" : Hibernates component
   ECHO  --------------------------------------
   ECHO:
   ECHO:
   ECHO  ------------------------------- RETURN SYMBOLS --------------------------------------------
   ECHO    "§>" : Processor result. EXAMPLE: "§> String: regular text" ^(Not currently used^)
   ECHO    "^!>" : Processor returned error. EXAMPLE: "%ExecProc% ^!> 0: INSTRUCTION NOT FOUND"
   ECHO    "?>" : Argument prompt. EXAMPLE: "?> output [STR]:"
   ECHO    "#>" : Function output. EXAMPLE: "#> Example"
   ECHO  -------------------------------------------------------------------------------------------
   ECHO:
   GOTO :INIT

)
IF "!Instr!"=="CAE.ABT" (
   ECHO  ---- CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR: ABOUT FILE ----
   ECHO    Emulator Version: !Version! !VersionType!
   ECHO    Emulator Edition: "!Edition!"
   ECHO    Assembler Engine: CASMR 2.0
   ECHO  -----------------------------------------------------------
   ECHO  REDISTRIBUTING THIS FILE OR ITS CONTENTS WITHOUT PERMISSION IS FORBIDDEN
   GOTO :INIT
)
IF "!Instr!"=="CAE.RBT" (
   ECHO RESTARTING EMULATOR SESSION...
   PING localhost -n !delay! > NUL
   ENDLOCAL DisableDelayedExpansion
   ENDLOCAL DisableExtensions
   GOTO :STRT
)
IF "!Instr!"=="CAE.CFG" (
   SET CFG-CMDS="HLP" "SET EP" "SET WT" "EXT" "GET EP" "GET WT" "SET WT -F" "SET WT -R" "GET DY" "SET DY"
   ECHO EXECUTE "HLP" TO SUMMON HELP FILE.
   :: -------------------------- ::
   :CFG_INIT
   @SET "cfgType="
   ECHO:
   SET /P cfgType=">>> "
   :: -------------------------- ::
   IF "!cfgType!"=="HLP" (
      ECHO  ---- CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR CONFIGURATION: HELP FILE ----------------
      ECHO    "SET EP" : SETS THE EXECUTING PROCESSOR
      ECHO    "SET WT" : SETS WINDOW TITLE ^(APPEND " -R" TO RESET, " -F" FOR FULL VALUE^)
      ECHO    "EXT" : EXIT CONFIGURATION
      ECHO    "GET EP" : GETS THE EXECUTING PROCESSOR
      ECHO    "GET WT" : GETS THE WINDOW TITLE
      ECHO    "GET DY" : GETS CURRENT RESTART DELAY
      ECHO    "SET DY" : SETS RESTART DELAY ^(WILL AUTOMATICALLY INCREMENT BY 1^)
      ECHO  ------------------------------------------------------------------------------------
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET EP" (
      SET /P ExecProc="ExecProc [STR]: "
      ECHO:
      ECHO  EXECUTING PROCESSOR CHANGED TO "!ExecProc!" 
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET WT -R" (
      SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
      TITLE !WinTitle!
      ECHO  WINDOW TITLE HAS BEEN RESET TO DEFAULT
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET WT -F" (
      SET "WinTitle=!InitWinTitle!"
      TITLE !WinTitle!
      ECHO  WINDOW TITLE HAS BEEN SET TO FULL VALUE
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET WT" (
      SET /P WinTitle="Window Title: "
      TITLE !WinTitle!
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="EXT" (
      ECHO:
      GOTO :INIT
   )
   IF "!cfgType!"=="GET EP" (
      ECHO  EXECUTING PROCESSOR : "!ExecProc!"
      GOTO :CFG_INIT
   )
    IF "!cfgType!"=="GET WT" (
      ECHO  WINDOW TITLE : "!WinTitle!"
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="GET DY" (
      ECHO:
      ECHO CURRENT RESTART DELAY IS "!delay!"
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET DY" (
      SET /P delay="delay [INT]: "
      SET /A "delay+=1"
      ECHO RESTART DELAY IS NOW "!delay!"
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="" (
      ECHO  CAE_CFG ^^!^> ^0 : NO CONFIGURATION COMMAND SPECIFIED
      GOTO :CFG_INIT
   )
   IF "!cfgType!" NEQ "!CFG-CMDS!" (
      ECHO  CAE_CFG ^^!^> ^0 : "!cfgType!" IS NOT A VALID CONFIGURATION COMMAND
      GOTO :CFG_INIT
   )

)
IF "!Instr!"=="CAE.DAT" (
   ECHO  ---------------------------------------------------------------------------------------------------------
   ECHO   INT : Integer, whole number
   ECHO   FLOAT : Floating Point, decimal
   ECHO   NUM : Number, optional replacement for INT and FLOAT
   ECHO   STR : String, regular text
   ECHO   BOOL : Boolean, true/false
   ECHO   ARY : Array, list of values
   ECHO   HEX : Hexadecimal
   ECHO   MEM : Memory Address
   ECHO   FUNC : Function
   ECHO   ANY : Any datatype, used for the built-in #Array and #AssocArray functions ^(UNAVILABLE IN EMULATOR^)  
   ECHO  ---------------------------------------------------------------------------------------------------------
   GOTO :INIT
)
IF "!Instr!"=="CAE.EDS" (
   ECHO ---- CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR: EDITION ABOUT FILE ---------------------------
   ECHO   "DEVELOPER" : Developers only, contains all features and in-development features.
   ECHO   "RELEASE PREVIEW" : Contains completed features, and some uncompleted features.
   ECHO   "RELEASE" : Contains only completed features.
   ECHO   "DEFINITIVE" : Contains completed features, uncompleted features, and broken features.
   ECHO ------------------------------------------------------------------------------------------
   GOTO :INIT
)
:: -- DO NOT PUT ANYTHING BELOW THIS LINE -- ::
IF "!Instr!"=="" (
   ECHO  !ExecProc! ^^!^> ^0 : NO INSTRUCTION SPECIFIED
   GOTO :INIT
)
IF "!Instr!" NEQ "!CMDS!" (
   ECHO  !ExecProc! ^^!^> ^0 : "!Instr!" IS NOT A VALID INSTRUCTION
   GOTO :INIT
)
GOTO :INIT
:: -- SCRIPT END -- ::
