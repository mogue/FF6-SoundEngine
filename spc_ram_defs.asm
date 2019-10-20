
;###############################################################################
;                            SPC Memory Allocation
;###############################################################################

;===============================================================================
; Notes:
; • Memory pointers to the APU, used both in 65816 and SPC-700 
;===============================================================================

; $0000-$01FF Direct Page 0-1
; $0200-$19FF SPC Program (code)
 !SPCMEM_Program = $0200

; $1A00-$1A7F Instrument Pitch Multipliers (2 bytes each, high then low byte)
 !SPCMEM_Pitch = $1A00

; $1A80-$1AFF ADSR Data (2 bytes each, gdddaaa then sssrrrrr)
 !SPCMEM_ADSR = $1A80

; $1B00-$1BFF Pointers to BRR Waveform Data (4 bytes each, start and loop start)
 !SPCMEM_BRR_Pointers = $1B00

; $1C00-$2BFF Song Scripts
 !SPCMEM_Song = $1C00

; $2C00-$2FFF Pointers to Game Sound Effects (4 bytes each, voice A then B)
 !SPCMEM_SFX_Pointers = $2C00

; $3000-$47FF Game Sound Effect Data
 !SPCMEM_SFX_Scripts = $3000

; $4800-$7CFF BRR Data
 !SPCMEM_BRR = $4800

; $7D00-$F5FF Echo Buffer (assuming max echo delay value of 15, 240ms)
 !SPCMEM_Echo = $7D00

;###############################################################################
;                               SPC Voice Memory
;###############################################################################









