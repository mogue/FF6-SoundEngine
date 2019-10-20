;=============================================================================-;
;                                                                              ;
;                         Reassembled FF6 Sound Engine                         ;
;                                    by m06                                    ;
;                                                                              ;
;==============================================================================;
;
;   Big thanks to:
;   madsiur, everything, emberling, Novalia Spirit and Evil Peer
;   The people of FF6hacking.com
;   The people of slickproductions.org
;   Alcaro and randomdude999 for Asar help
;
;------------------------------ Header and Defs --------------------------------
hirom
; header
org $C50000

incsrc spc_ram_defs.asm

;----------------------------- SNES 65816 Program ------------------------------
;                                 org $C50000

incsrc program.asm


;------------------------------ SPC-700 Program --------------------------------
;                                 org $C5070E

SPC_Engine: 
dw $17B7
;dw SPC_End-SPC_Start                        ; Length of SPC code (for transfer)
SPC_Start:
; incbin SPC700/SPC_Code.bin
incsrc spc_program.asm
SPC_End:


;----------------------- Sound Effects (Scripts and BRRs) ----------------------
;                                 org $C51EC7

incsrc SoundEffects/SoundEffects_Data.asm

;------------------------ Music (Songs and Instruments) ------------------------
;                                 org $C53C5E

incsrc Music/Music_Data.asm


