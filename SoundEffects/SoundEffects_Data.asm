
; Sound Effect Data
;  org $C51EC7

; Length of sound effect sample data
;  org $C51EC7

SoundEffect_Samples:
dw SFX_BRRs_End-SFX_BRRs_Start
 
; Sound effect sample data
SFX_BRRs_Start:
base !SPCMEM_BRR
SFX_Sample00: incbin BRRs/Sample00.brr
SFX_Sample01: incbin BRRs/Sample01.brr
SFX_Sample02: incbin BRRs/Sample02.brr
SFX_Sample03: incbin BRRs/Sample03.brr
SFX_Sample04: incbin BRRs/Sample04.brr
SFX_Sample05: incbin BRRs/Sample05.brr
SFX_Sample06: incbin BRRs/Sample06.brr
SFX_Sample07: incbin BRRs/Sample07.brr
base off
SFX_BRRs_End:

; Length of pointer table to sound effect sample data
;  org $C52016

SoundEffect_SamplePointers:
dw SFX_BRR_PTR_End-SFX_BRR_PTR_Start

; Pointer table to sound effect sample data
;  org $C52018

SFX_BRR_PTR_Start:
dw SFX_Sample00        ; $00 BRR Pointer  ($4800)
dw SFX_Sample00+0      ; $00 Loop Pointer ($4800)
dw SFX_Sample01        ; $01 BRR Pointer  ($4824)
dw SFX_Sample01+0      ; $01 Loop Pointer ($4824)
dw SFX_Sample02        ; $02 BRR Pointer  ($4848)
dw SFX_Sample02+0      ; $02 Loop Pointer ($4848)
dw SFX_Sample03        ; $03 BRR Pointer  ($486C)
dw SFX_Sample03+$1B    ; $03 Loop Pointer ($4887)
dw SFX_Sample04        ; $04 BRR Pointer  ($48AB)
dw SFX_Sample04+$1B    ; $04 Loop Pointer ($48C6)
dw SFX_Sample05        ; $05 BRR Pointer  ($48D8)
dw SFX_Sample05+0      ; $05 Loop Pointer ($48D8)
dw SFX_Sample06        ; $06 BRR Pointer  ($48EA)
dw SFX_Sample06+0      ; $06 Loop Pointer ($48EA)
dw SFX_Sample07        ; $07 BRR Pointer  ($48FC)
dw SFX_Sample07+$1B    ; $07 Loop Pointer ($4917)
SFX_BRR_PTR_End:

; Length of ADSR data for sound effect samples
;  org $C52038

SoundEffect_ADSR:
dw SFX_ADSR_End-SFX_ADSR_Start

; ADSR data for sound effect samples
;  org $C5203A

SFX_ADSR_Start: 
dw $E0FF        ; $00 Sample ADSR
dw $E0FF        ; $01 Sample ADSR
dw $E0FF        ; $02 Sample ADSR
dw $E0FF        ; $03 Sample ADSR
dw $E0FF        ; $04 Sample ADSR
dw $E0FF        ; $05 Sample ADSR
dw $E0FF        ; $06 Sample ADSR
dw $E0FF        ; $07 Sample ADSR
SFX_ADSR_End:

; Length of wave rate multiplying values for sound effect samples - Evil Peer
;  org $C5204A
SoundEffect_PitchMultiplier:
dw SFX_Multi_End-SFX_Multi_Start

; Wave rate multiplying values for sound effect samples
; C5204C: export.label C5204C
; incbin Sound_Effect_Pitch_Multiplication_Data.bin
SFX_Multi_Start: 
dw $A0E1        ; $00 Sample Pitch Multiplier
dw $A0E1        ; $01 Sample Pitch Multiplier
dw $A0E1        ; $02 Sample Pitch Multiplier
dw $A0E1        ; $03 Sample Pitch Multiplier
dw $0000        ; $04 Sample Pitch Multiplier
dw $A0E1        ; $05 Sample Pitch Multiplier
dw $A0E1        ; $06 Sample Pitch Multiplier
dw $0000        ; $07 Sample Pitch Multiplier
SFX_Multi_End:

; Length of type 1 sound effect instruction pointers and instructions
;  org $C5205C

SoundEffect_Scripts:
dw SFX_Scripts_End-SFX_Scripts_Start

; Type 1 sound effect instruction pointers and instructions
;  org $C5205E

SFX_Scripts_Start:
incsrc SoundEffects_Pointers.asm
incsrc SoundEffects_Scripts.asm

;padbyte $FF
;pad $C53C5D
SFX_Scripts_End:



