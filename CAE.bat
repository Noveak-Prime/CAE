:: -- SET-UP -- ::
:STRT
@ECHO OFF
SETLOCAL EnableDelayedExpansion
SETLOCAL EnableExtensions
MODE CON: CP SELECT=65001>nul
:: -- SCRIPT START -- ::
CLS
SET CMDS="TDSC INT" "TDSC FLOAT" "TDSC STR" "TDSC NUM" "TDSC BOOL" "TDSC ARY" "TDSC HEX" "TDSC MEM" "TDSC FUNC" "TDSC ANY" "CAE.EXT" "CAE.CFG" "CAE.CLR" "SYSC HLT" "SYSC RBT" "SYSC HIB" "SYSC HCF" "SYSC KBC CHK" "SYSC KBC CPD" "KBC.KEYS" "#Print" "#RaiseError" "#Concat" "RPR.RPT" "CAE.HLP" "CAE.ABT" "CAE.CFG" "CAE.DAT" "CAE.EDS" "#Calc" "CAE.RBT"
SET "Version=0.15.0"
SET "SpecialVersionType="
SET "VersionType=CLOSED BETA"
SET "Edition=DEVELOPER"
SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
TITLE %WinTitle%
SET "QuotWarn=ALWAYS KEEP IN MIND: IGNORE ALL QUOTATION MARKS EXCEPT IN ERROR MESSAGES (MESSAGE WILL ONLY BE SHOWN ONCE PER SESSION)"
SET "ExecProc=MProc"
IF "!SpecialVersionType!"=="" (
   SET "InitWinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR VERSION !Version! !VersionType! - !Edition! EDITION"
) ELSE (
   SET "InitWinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR VERSION !Version! !VersionType! !SpecialVersionType! - !Edition! EDITION"
)
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
:: -- TDSC INSTRUCTION -- ::
IF "!Instr!"=="TDSC INT" (
   ECHO  ~^> Integer: whole number
   GOTO :INIT
)
IF "!Instr!"=="TDSC FLOAT" (
   ECHO  ~^> Floating Point: decimal
   GOTO :INIT
)
IF "!Instr!"=="TDSC STR" (
   ECHO  ~^> String: regular text.
   GOTO :INIT
)
IF "!Instr!"=="TDSC NUM" (
   ECHO  ~^> Number: optional replacement f^or INT and FLOAT datatypes.
   GOTO :INIT
)
IF "!Instr!"=="TDSC BOOL" (
   ECHO  ~^> Boolean: true/false.
   GOTO :INIT
)
IF "!Instr!"=="TDSC ARY" (
   ECHO  ~^> Array: list of values.
   GOTO :INIT
)
IF "!Instr!"=="TDSC HEX" (
   ECHO  ~^> Hexadecimal
   GOTO :INIT
)
IF "!Instr!"=="TDSC MEM" (
   ECHO  ~^> Memory Address
   GOTO :INIT
)
IF "!Instr!"=="TDSC FUNC" (
   ECHO  ~^> Function
   GOTO :INIT
)
IF "!Instr!"=="TDSC ANY" (
   ECHO  ~^> Any Datatype: only available f^or the built-in #Array and #AssocArray functions, unavailable in the emulator.
   GOTO :INIT
)
:: -- CAE INSTRUCTIONS -- ::
IF "!Instr!"=="CAE.EXT" (
   ECHO  CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR SESSION TERMINATED
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
IF "!Instr!"=="SYSC HCF" (
   ECHO  ^^!^> ALERT: PROCESSOR FREEZE ATTEMPT DETECTED, ATTEMPTING TO ABORT...
   PING localhost -n 6 >NUL
   ECHO  ^^!^> PROCESSOR FREEZE AVERTED
   GOTO :INIT
)
IF "!Instr!"=="SYSC KBC CHK" (
   SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR - SYSTEM FAILURE"
   TITLE !WinTitle!
   CLS
   ECHO:
   ECHO  SYSTEM FAILURE - SYSTEM HALTED
   ECHO     MACHINE_CHECK_EXCEPTION
   ECHO:
   ECHO  COMPONENT "Component Integrity Checker" HAS DETECTED A CRITICAL FAILURE IN COMPONENT "MProc"
   ECHO  THE SYSTEM HAS BEEN HALTED TO PREVENT DATA LOSS
   ECHO:
   ECHO  ---- DETAILS ------------------------------------------------------
   ECHO    CATCHER : "Component Integrity Checker"
   ECHO    CATCHER_MSG : CRITICAL FAILURE IN MAIN PROCESSOR, SYSTEM HALTED
   ECHO    KBC_KEY : CHK
   ECHO  -------------------------------------------------------------------
   ECHO:
   ECHO  PRESS ^[RETURN^] TO RESTART
   pause>nul
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
   ECHO  --- DETAILS ---------------------------------------------------------
   ECHO    CATCHER : KRNL
   ECHO    CATCHER_MSG : A CRITICAL SYSTEM PROCESS TERMINATED, SYSTEM HALTED
   ECHO    KBC_KEY : CPD
   ECHO  ---------------------------------------------------------------------
   ECHO:
   ECHO  PRESS ^[RETURN^] TO RESTART
   pause>nul
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
   ECHO  --- DETAILS -------------------------------------------------------
   ECHO    CATCHER : CyberBootMgr
   ECHO    CATCHER_MSG : MAIN KERNEL FAILED TO INITIALISE, SYSTEM HALTED 
   ECHO    KBC_KEY : KIF
   ECHO  -------------------------------------------------------------------
   ECHO:
   ECHO  PRESS ^[RETURN^] TO RESTART
   pause>nul
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
IF "!Instr!"=="#Print" (
   SET /P output="?> output [STR]: "
   ECHO  #^> !output!
   GOTO :INIT
)
IF "!Instr!"=="#RaiseError" (
   SET /P msg="?> msg [STR): "
   SET /P errLvl="?> errLvl [INT]: "
   SET /P statCode="?> statCode [INT]: "
   SET /P support="?> support [STR]: "
   IF "!errLvl!"=="1" (
      ECHO  #^> A CRITICAL ERROR HAS OCCURED: !msg! ^(!statCode!^). CONTACT !support! ^FOR SUPPORT. EXECUTION WILL NOW HALT.
      GOTO :INIT
   )
   IF "!errLvl!"=="0" (
      ECHO  #^> AN ERROR HAS OCCURED: !msg! ^(!statCode!^). CONTACT !support! ^FOR SUPPORT. EXECUTION WILL CONTINUE.
      GOTO :INIT
   )
   GOTO :INIT
)
IF "!Instr!"=="#Concat" (
   SET /P str1="?> firstString [STR]: "
   SET /P str2="?> secondString [STR]: "
   SET "ConcatString=!str1! !str2!"
   ECHO  #^> !ConcatString!
   GOTO :INIT
)
IF "!Instr!"=="#Calc" (
   SET OPS="+" "-" "*" "/"
   SET /P "Num1=?> firstNumber [NUM]: "
   SET /P "Op=?> Operation [STR]: "
   SET /P "Num2=?> secondNumber [NUM]: "
   IF "!Num1!"=="0" (
      IF "!Op!"=="/" (
         IF "!Num2!"=="0" (
            ECHO  MthProc ^^!^> ^0 : DIVISION BY ZERO IS NOT POSSIBLE
            GOTO :INIT
         )
      )
   )
   IF "!Op!"=="+" (
      SET /A result=!Num1! + !Num2!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!"=="-" (
      SET /A result=!Num1! - !Num2!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!"=="*" (
      SET /A result=!Num1! * !Num2!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!"=="/" (
      SET /A result=!Num1! / !Num2!
      ECHO  #^> !result!
      GOTO :INIT
   )
   IF "!Op!" NEQ "!OPS!" (
      ECHO  MthProc ^^!^> ^0 : "!Op!" IS NOT A VALID MATHEMATICAL OPERATION.
      GOTO :INIT
   )
)
:: -- INSTRUCTIONS -- ::
IF "!Instr!"=="RPR.RPT" (
   SET /P times="?> times (INT): "
   SET /P output="?> output (STR): "   
   FOR /L %%i IN (1,1,!times!) DO (
      ECHO  #^> !output!
   )
   GOTO :INIT
)
:: -- CAE INSTRUCTIONS -- ::
IF "!Instr!"=="CAE.HLP" (
   ECHO  ---------- CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR: HELP FILE -------------------------------
   ECHO    "TDSC": Shows a description of the given datatype. EXAMPLE: TDSC STR
   ECHO    "CAE.CLR" : Clears output.
   ECHO    "SYSC HCF" : Joke instruction. Stands for Halt and Catch Fire
   ECHO    "SYSC KBC" : Crash the emulator. HELP FILE: "KBC.KEYS"
   ECHO    "RPR.RPT" : Start a fixed repeater
   ECHO    "CAE.EXT" : Exits the Cyber-Assembly 2.0 Assembler Emulator
   ECHO    "CAE.HLP" : Summons this help file
   ECHO    "CAE.ABT" : Summons a help file regarding the Cyber-Assembly 2.0 Assembler Emulator
   ECHO    "CAE.DAT" : Summons datatypes help file
   ECHO    "CAE.CFG" : Configure the Cyber-Assembly 2.0 Assembler Emulator
   ECHO    "CAE.EDS" : Summons help file regarding the editions
   ECHO    "CAE.RBT" : Restarts the Cyber-Assembly 2.0 Assembler Emulator
   ECHO    "#Print" : Outputs something
   ECHO    "#RaiseError" : Outputs a custom error message
   ECHO    "#Concat" : Concatenates two strings
   ECHO    "#Calc" : Calculates the result of two numbers
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
   ECHO    "~>" : Processor result. EXAMPLE: "~> String: regular text"
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
   GOTO :STRT
)
IF "!Instr!"=="CAE.CFG" (
   SET CFG-CMDS="HLP" "SET EP" "SET WT" "EXT" "GET EP" "GET WT" "SET WT -FLL" "SET WT -RST"
   ECHO EXECUTE "HLP" TO SUMMON HELP FILE.
   :: -------------------------- ::
   :CFG_INIT
   ECHO:
   SET /P cfgType="CAE_CFG> "
   :: -------------------------- ::
   IF "!cfgType!"=="HLP" (
      ECHO  ---- CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR CONFIGURATION: HELP FILE ----------------
      ECHO    "SET EP" : SETS THE EXECUTING PROCESSOR
      ECHO    "SET WT" : SETS WINDOW TITLE ^(APPEND " -RST" TO RESET, " -FLL" FOR FULL VALUE^)
      ECHO    "EXT" : EXIT CONFIGURATION
      ECHO    "GET EP" : GETS THE EXECUTING PROCESSOR
      ECHO    "GET WT" : GETS THE WINDOW TITLE
      ECHO  ------------------------------------------------------------------------------------
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET EP" (
      SET /P ExecProc="Executing Processor: "
      ECHO:
      ECHO  EXECUTING PROCESSOR CHANGED TO "!ExecProc!" 
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET WT -RST" (
      SET "WinTitle=CYBER-ASSEMBLY 2.0 ASSEMBLER EMULATOR"
      TITLE !WinTitle!
      ECHO  WINDOW TITLE HAS BEEN RESET TO DEFAULT
      GOTO :CFG_INIT
   )
   IF "!cfgType!"=="SET WT -INIT" (
      SET "WinTitle=!InitWinTitle!"
      TITLE !WinTitle!
      ECHO  WINDOW TITLE HAS BEEN SET TO INITIAL VALUE
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