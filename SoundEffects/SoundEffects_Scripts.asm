base $003000

SFX_Script_00_A:       ; Voice A: Lore casting sound	

db $DB, $40            ; Set Detune

SFX_Script_00_B:       ; Voice B: Lore casting sound	

db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $C9, $00, $01, $E7  ; Enable Vibrato (00: delay in ticks, 01: cycle duration, E7: amplitude, max 1/4 step)
db $CD, $0C, $79       ; Enable Pansweep (0C: delay in ticks, 79: cycle duration)
db $D4                 ; Enable Echo
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $9A                 ;  Note B    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_01_A:       ; Voice A: Casting black magic spell	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $0E            ; Set Octave to 0E
db $C8, $06, $FC       ; Change Pitch w/ Envelope (06: envelope duration, FC: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $70                 ;  Note G#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_01_B:       ; Voice B: Casting black magic spell	

db $D4                 ; Enable Echo
db $D6, $0C            ; Set Octave to 0C
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $62                 ;  Note G    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_02_A:       ; Voice A: Casting white magic spell	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $E2, $04            ; Loop Start (loop 04+1 times)
db $1A                 ;  Note C#   [4 ticks] 
db $60                 ;  Note F#   [4 ticks] 
db $7C                 ;  Note G#   [4 ticks] 
db $DA, $01            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_03_A:       ; Voice A: Esper summoning	

db $D4                 ; Enable Echo
db $D6, $07            ; Set Octave to 07
db $DB, $09            ; Set Detune
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $CB, $00, $B1, $C0  ; Enable Tremolo (00: delay in ticks, B1: cycle duration, C0: amplitude, max 50%)
db $71                 ;  Note G#   [96 ticks] 
db $EB                 ; End of Script

SFX_Script_03_B:       ; Voice B: Esper summoning	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $C9, $00, $01, $BF  ; Enable Vibrato (00: delay in ticks, 01: cycle duration, BF: amplitude, max 1/4 step)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $CB, $00, $B1, $C0  ; Enable Tremolo (00: delay in ticks, B1: cycle duration, C0: amplitude, max 50%)
db $10                 ;  Note C#   [64 ticks] 
db $B0                 ;  Note Tie  [16 ticks] 
db $EB                 ; End of Script

SFX_Script_04_A:       ; Voice A: Running Footsteps / Escaping	

db $CF, $1B            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $E2, $04            ; Loop Start (loop 04+1 times)
db $0B                 ;  Note C    [6 ticks] 
db $C2                 ;  Note Rest [4 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_05_A:       ; Voice A: Ultima	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $DC, $03            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $40, $DE       ; Change Pitch w/ Envelope (40: envelope duration, DE: change in pitch, signed)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $57                 ;  Note F#   [72 ticks] 
db $D4                 ; Enable Echo
db $C9, $00, $15, $BF  ; Enable Vibrato (00: delay in ticks, 15: cycle duration, BF: amplitude, max 1/4 step)
db $C8, $FF, $17       ; Change Pitch w/ Envelope (FF: envelope duration, 17: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $CD, $01, $30       ; Enable Pansweep (01: delay in ticks, 30: cycle duration)
db $A9                 ;  Note Tie  [96 ticks] 
db $CD, $02, $5E       ; Enable Pansweep (02: delay in ticks, 5E: cycle duration)
db $AA                 ;  Note Tie  [64 ticks] 
db $CD, $05, $7C       ; Enable Pansweep (05: delay in ticks, 7C: cycle duration)
db $C8, $FF, $0D       ; Change Pitch w/ Envelope (FF: envelope duration, 0D: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_05_B:       ; Voice B: Ultima	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $DC, $05            ; Set Instrument
db $D2                 ; Enable Pitch Modulation
db $CD, $01, $7F       ; Enable Pansweep (01: delay in ticks, 7F: cycle duration)
db $C8, $20, $EF       ; Change Pitch w/ Envelope (20: envelope duration, EF: change in pitch, signed)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $E0, $18            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $DD, $00            ; Set ADSR Attack Value (0-15)
db $D6, $06            ; Set Octave to 06
db $E8, $E8            ; Add to Note Duration (E8 = duration in ticks)
db $7E                 ;  Note A    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_06_A:       ; Voice A: Earth Breaking	

db $CF, $11            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $CD, $03, $54       ; Enable Pansweep (03: delay in ticks, 54: cycle duration)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $46                 ;  Note F    [192 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_06_B:       ; Voice B: Earth Breaking	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $01            ; Set Octave to 01
db $DC, $07            ; Set Instrument
db $CB, $00, $04, $BF  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, BF: amplitude, max 50%)
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $3F                 ;  Note E    [24 ticks] 
db $AE                 ;  Note Tie  [36 ticks] 
db $D4                 ; Enable Echo
db $C5, $60, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 60: envelope duration)
db $A8                 ;  Note Tie  [192 ticks] 
db $C8, $FF, $F6       ; Change Pitch w/ Envelope (FF: envelope duration, F6: change in pitch, signed)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_07_A:       ; Voice A: Haste	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $0B            ; Set Octave to 0B
db $E2, $03            ; Loop Start (loop 03+1 times)
db $6D                 ;  Note G    [6 ticks] 
db $BE                 ;  Note Rest [16 ticks] 
db $0B                 ;  Note C    [6 ticks] 
db $BE                 ;  Note Rest [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_07_B:       ; Voice B: Haste	

db $D6, $07            ; Set Octave to 07
db $CD, $01, $80       ; Enable Pansweep (01: delay in ticks, 80: cycle duration)
db $C9, $00, $03, $83  ; Enable Vibrato (00: delay in ticks, 03: cycle duration, 83: amplitude, max 1/4 step)
db $CB, $00, $08, $BF  ; Enable Tremolo (00: delay in ticks, 08: cycle duration, BF: amplitude, max 50%)
db $DC, $06            ; Set Instrument
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $E0, $0D            ; Set ADSR Release Value (0-31)
db $D4                 ; Enable Echo
db $70                 ;  Note G#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_08_A:       ; Voice A: Palidor	

db $E8, $04            ; Add to Note Duration (04 = duration in ticks)
db $EA, $76            ; Play Game Sound Effect (voice B)

SFX_Script_08_B:       ; Voice B: Palidor	

db $E8, $04            ; Add to Note Duration (04 = duration in ticks)
db $E9, $14            ; Play Game Sound Effect (voice A)

SFX_Script_09_A:       ; Voice A: Scan's “target” sound	

db $C4, $25            ; Set Voice Volume to 25 (00-7F)
db $D6, $00            ; Set Octave to 00
db $DC, $02            ; Set Instrument
db $CD, $05, $7F       ; Enable Pansweep (05: delay in ticks, 7F: cycle duration)
db $C8, $1F, $57       ; Change Pitch w/ Envelope (1F: envelope duration, 57: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $C8, $FF, $02       ; Change Pitch w/ Envelope (FF: envelope duration, 02: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $E0, $16            ; Set ADSR Release Value (0-31)
db $C8, $33, $B4       ; Change Pitch w/ Envelope (33: envelope duration, B4: change in pitch, signed)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_09_B:       ; Voice B: Scan's “target” sound	

db $D6, $0A            ; Set Octave to 0A
db $DC, $06            ; Set Instrument
db $E2, $06            ; Loop Start (loop 06+1 times)
db $5F                 ;  Note F#   [6 ticks] 
db $E3                 ; Loop End
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $2F, $01       ; Change Pitch w/ Envelope (2F: envelope duration, 01: change in pitch, signed)
db $4A                 ;  Note F    [48 ticks] 
db $C5, $03, $0F       ; Set Voice Volume w/ Envelope (0F: volume, 03: envelope duration)
db $B5                 ;  Note Tie  [3 ticks] 
db $C5, $5C, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 5C: envelope duration)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_0A_A:       ; Voice A: Rasp's first sound effect	

db $D4                 ; Enable Echo
db $C4, $28            ; Set Voice Volume to 28 (00-7F)
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $C5, $FF, $00       ; Set Voice Volume w/ Envelope (00: volume, FF: envelope duration)
db $E2, $04            ; Loop Start (loop 04+1 times)
db $C8, $28, $8C       ; Change Pitch w/ Envelope (28: envelope duration, 8C: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_0A_B:       ; Voice B: Rasp's first sound effect	

db $DC, $00            ; Set Instrument
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $D4                 ; Enable Echo
db $C8, $FF, $E6       ; Change Pitch w/ Envelope (FF: envelope duration, E6: change in pitch, signed)
db $E0, $0B            ; Set ADSR Release Value (0-31)
db $05                 ;  Note C    [32 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_0B_A:       ; Voice A: Rasp's second sound effect	

db $DC, $03            ; Set Instrument
db $D4                 ; Enable Echo
db $E2, $0D            ; Loop Start (loop 0D+1 times)
db $D6, $05            ; Set Octave to 05
db $CD, $09, $18       ; Enable Pansweep (09: delay in ticks, 18: cycle duration)
db $C8, $08, $15       ; Change Pitch w/ Envelope (08: envelope duration, 15: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_0C_A:       ; Voice A: Shiva	

db $D6, $07            ; Set Octave to 07
db $D4                 ; Enable Echo
db $CD, $14, $54       ; Enable Pansweep (14: delay in ticks, 54: cycle duration)
db $C8, $FF, $01       ; Change Pitch w/ Envelope (FF: envelope duration, 01: change in pitch, signed)
db $DC, $02            ; Set Instrument
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $38                 ;  Note E    [192 ticks] 
db $CB, $00, $04, $BF  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, BF: amplitude, max 50%)
db $E8, $84            ; Add to Note Duration (84 = duration in ticks)
db $C5, $60, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 60: envelope duration)
db $CD, $0A, $54       ; Enable Pansweep (0A: delay in ticks, 54: cycle duration)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_0C_B:       ; Voice B: Shiva	

db $BA                 ;  Note Rest [48 ticks] 
db $D6, $01            ; Set Octave to 01
db $C8, $68, $20       ; Change Pitch w/ Envelope (68: envelope duration, 20: change in pitch, signed)
db $02                 ;  Note C    [64 ticks] 
db $C8, $48, $31       ; Change Pitch w/ Envelope (48: envelope duration, 31: change in pitch, signed)
db $AA                 ;  Note Tie  [64 ticks] 
db $D6, $0A            ; Set Octave to 0A
db $DC, $02            ; Set Instrument
db $D4                 ; Enable Echo
db $C8, $88, $24       ; Change Pitch w/ Envelope (88: envelope duration, 24: change in pitch, signed)
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $46                 ;  Note F    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_0D_A:       ; Voice A: Miss	

db $D6, $0B            ; Set Octave to 0B
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $0A                 ;  Note C    [8 ticks] 
db $EB                 ; End of Script

SFX_Script_0D_B:       ; Voice B: Miss	

db $D6, $0C            ; Set Octave to 0C
db $DC, $06            ; Set Instrument
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $0A                 ;  Note C    [8 ticks] 
db $EB                 ; End of Script

SFX_Script_0E_A:       ; Voice A: Ramuh	

db $DC, $06            ; Set Instrument
db $D6, $00            ; Set Octave to 00
db $C8, $18, $26       ; Change Pitch w/ Envelope (18: envelope duration, 26: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $23                 ;  Note D    [24 ticks] 
db $D6, $06            ; Set Octave to 06
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_0E_B:       ; Voice B: Ramuh	

db $BE                 ;  Note Rest [16 ticks] 
db $D2                 ; Enable Pitch Modulation
db $CD, $00, $7C       ; Enable Pansweep (00: delay in ticks, 7C: cycle duration)
db $C8, $38, $EF       ; Change Pitch w/ Envelope (38: envelope duration, EF: change in pitch, signed)
db $DC, $02            ; Set Instrument
db $02                 ;  Note C    [64 ticks] 
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $C8, $8F, $01       ; Change Pitch w/ Envelope (8F: envelope duration, 01: change in pitch, signed)
db $C9, $00, $02, $BF  ; Enable Vibrato (00: delay in ticks, 02: cycle duration, BF: amplitude, max 1/4 step)
db $D6, $13            ; Set Octave to 13
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_0F_A:       ; Voice A: Siren	

db $DC, $03            ; Set Instrument
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $DD, $00            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $11            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_0F_B:       ; Voice B: Siren	

db $DC, $03            ; Set Instrument
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $D2                 ; Enable Pitch Modulation
db $CB, $00, $20, $BF  ; Enable Tremolo (00: delay in ticks, 20: cycle duration, BF: amplitude, max 50%)
db $C9, $00, $01, $7F  ; Enable Vibrato (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 1/4 step)
db $D4                 ; Enable Echo
db $D6, $05            ; Set Octave to 05
db $C8, $48, $01       ; Change Pitch w/ Envelope (48: envelope duration, 01: change in pitch, signed)
db $9A                 ;  Note B    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_10_A:       ; Voice A: Bum Rush	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $0F            ; Set Noise Clock (00-1F)
db $E2, $10            ; Loop Start (loop 10+1 times)
db $09                 ;  Note C    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_10_B:       ; Voice B: Bum Rush	

db $D4                 ; Enable Echo
db $DC, $01            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $E2, $08            ; Loop Start (loop 08+1 times)
db $C8, $30, $76       ; Change Pitch w/ Envelope (30: envelope duration, 76: change in pitch, signed)
db $69                 ;  Note G    [24 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_11_A:       ; Voice A: Alexandr (part 1)	

db $C4, $2B            ; Set Voice Volume to 2B (00-7F)
db $CD, $02, $5B       ; Enable Pansweep (02: delay in ticks, 5B: cycle duration)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $D0                 ; Enable Noise
db $CF, $0F            ; Set Noise Clock (00-1F)
db $E8, $A1            ; Add to Note Duration (A1 = duration in ticks)
db $01                 ;  Note C    [96 ticks] 
db $BB                 ;  Note Rest [32 ticks] 
db $EB                 ; End of Script

SFX_Script_11_B:       ; Voice B: Alexandr (part 1)	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $C5, $3C, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 3C: envelope duration)
db $CD, $01, $63       ; Enable Pansweep (01: delay in ticks, 63: cycle duration)
db $D8                 ; Decrement Octave
db $D2                 ; Enable Pitch Modulation
db $DC, $02            ; Set Instrument
db $E8, $A1            ; Add to Note Duration (A1 = duration in ticks)
db $01                 ;  Note C    [96 ticks] 
db $CD, $01, $60       ; Enable Pansweep (01: delay in ticks, 60: cycle duration)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $DC, $02            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $07                 ;  Note C    [24 ticks] 
db $C8, $F0, $38       ; Change Pitch w/ Envelope (F0: envelope duration, 38: change in pitch, signed)
db $02                 ;  Note C    [64 ticks] 
db $EB                 ; End of Script

SFX_Script_12_A:       ; Voice A: Alexandr (part 2) Also used when prts of Floating Continent drop	

db $D0                 ; Enable Noise
db $CF, $1B            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $CF, $10            ; Set Noise Clock (00-1F)
db $01                 ;  Note C    [96 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $E0, $14            ; Set ADSR Release Value (0-31)
db $AE                 ;  Note Tie  [36 ticks] 
db $EB                 ; End of Script

SFX_Script_12_B:       ; Voice B: Alexandr (part 2) Also used when prts of Floating Continent drop	

db $D4                 ; Enable Echo
db $D8                 ; Decrement Octave
db $CB, $00, $04, $BF  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, BF: amplitude, max 50%)
db $C8, $18, $1E       ; Change Pitch w/ Envelope (18: envelope duration, 1E: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $07                 ;  Note C    [24 ticks] 
db $E0, $16            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_13_A:       ; Voice A: Second half of Flare	

db $D0                 ; Enable Noise
db $D4                 ; Enable Echo
db $CF, $11            ; Set Noise Clock (00-1F)
db $DF, $04            ; Set ADSR Sustain Value (0-7)
db $CD, $12, $6C       ; Enable Pansweep (12: delay in ticks, 6C: cycle duration)
db $01                 ;  Note C    [96 ticks] 
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_13_B:       ; Voice B: Second half of Flare	

db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $CD, $0A, $6C       ; Enable Pansweep (0A: delay in ticks, 6C: cycle duration)
db $E2, $0C            ; Loop Start (loop 0C+1 times)
db $C8, $0F, $2A       ; Change Pitch w/ Envelope (0F: envelope duration, 2A: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_14_A:       ; Voice A: Phoenix (In battle)	

db $D6, $01            ; Set Octave to 01
db $C8, $37, $40       ; Change Pitch w/ Envelope (37: envelope duration, 40: change in pitch, signed)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $DC, $00            ; Set Instrument
db $03                 ;  Note C    [72 ticks] 
db $C8, $EF, $05       ; Change Pitch w/ Envelope (EF: envelope duration, 05: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $D4                 ; Enable Echo
db $CD, $00, $70       ; Enable Pansweep (00: delay in ticks, 70: cycle duration)
db $D6, $07            ; Set Octave to 07
db $5D                 ;  Note F#   [12 ticks] 
db $C8, $EF, $DE       ; Change Pitch w/ Envelope (EF: envelope duration, DE: change in pitch, signed)
db $9B                 ;  Note B    [96 ticks] 
db $E0, $14            ; Set ADSR Release Value (0-31)
db $AE                 ;  Note Tie  [36 ticks] 
db $EB                 ; End of Script

SFX_Script_14_B:       ; Voice B: Phoenix (In battle)	

db $D6, $06            ; Set Octave to 06
db $DC, $00            ; Set Instrument
db $C8, $FF, $15       ; Change Pitch w/ Envelope (FF: envelope duration, 15: change in pitch, signed)
db $CD, $0A, $5C       ; Enable Pansweep (0A: delay in ticks, 5C: cycle duration)
db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DE, $00            ; Set ADSR Decay Value (0-7)
db $DF, $04            ; Set ADSR Sustain Value (0-7)
db $00                 ;  Note C    [192 ticks] 
db $C5, $77, $00       ; Set Voice Volume w/ Envelope (00: volume, 77: envelope duration)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_15_A:       ; Voice A: Thundaga	

db $D0                 ; Enable Noise
db $CF, $1E            ; Set Noise Clock (00-1F)
db $0C                 ;  Note C    [4 ticks] 
db $CF, $11            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $CF, $17            ; Set Noise Clock (00-1F)
db $08                 ;  Note C    [16 ticks] 
db $C4, $4F            ; Set Voice Volume to 4F (00-7F)
db $CF, $10            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $E0, $14            ; Set ADSR Release Value (0-31)
db $CF, $15            ; Set Noise Clock (00-1F)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_15_B:       ; Voice B: Thundaga	

db $D4                 ; Enable Echo
db $C8, $28, $64       ; Change Pitch w/ Envelope (28: envelope duration, 64: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $E0, $14            ; Set ADSR Release Value (0-31)
db $4A                 ;  Note F    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_16_A:       ; Voice A: Fire 1	

db $DC, $03            ; Set Instrument
db $C4, $1C            ; Set Voice Volume to 1C (00-7F)
db $C5, $02, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 02: envelope duration)
db $CD, $10, $4B       ; Enable Pansweep (10: delay in ticks, 4B: cycle duration)
db $0B                 ;  Note C    [6 ticks] 
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_16_B:       ; Voice B: Fire 1	

db $C4, $50            ; Set Voice Volume to 50 (00-7F)
db $E2, $01            ; Loop Start (loop 01+1 times)
db $CF, $11            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $4E                 ;  Note F    [16 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_17_A:       ; Voice A: Ice	

db $DB, $01            ; Set Detune

SFX_Script_17_B:       ; Voice B: Ice	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D8                 ; Decrement Octave
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $E2, $02            ; Loop Start (loop 02+1 times)
db $C8, $01, $50       ; Change Pitch w/ Envelope (01: envelope duration, 50: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_18_A:       ; Voice A: First part of Cold Dust	

db $DB, $01            ; Set Detune

SFX_Script_18_B:       ; Voice B: First part of Cold Dust	

db $D4                 ; Enable Echo
db $D6, $32            ; Set Octave to 32
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $C8, $28, $C6       ; Change Pitch w/ Envelope (28: envelope duration, C6: change in pitch, signed)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_19_A:       ; Voice A: Fire 3	

db $C0                 ;  Note Rest [8 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $D0                 ; Enable Noise
db $CF, $0E            ; Set Noise Clock (00-1F)
db $C4, $58            ; Set Voice Volume to 58 (00-7F)
db $0C                 ;  Note C    [4 ticks] 
db $CF, $1A            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $CF, $10            ; Set Noise Clock (00-1F)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_19_B:       ; Voice B: Fire 3	

db $C4, $6C            ; Set Voice Volume to 6C (00-7F)
db $D6, $02            ; Set Octave to 02
db $C8, $01, $10       ; Change Pitch w/ Envelope (01: envelope duration, 10: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_1A_A:       ; Voice A: Meteor	

db $D4                 ; Enable Echo
db $BA                 ;  Note Rest [48 ticks] 
db $D0                 ; Enable Noise
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $CD, $1C, $5B       ; Enable Pansweep (1C: delay in ticks, 5B: cycle duration)
db $CF, $1A            ; Set Noise Clock (00-1F)
db $E2, $02            ; Loop Start (loop 02+1 times)
db $09                 ;  Note C    [12 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $E2, $07            ; Loop Start (loop 07+1 times)
db $09                 ;  Note C    [12 ticks] 
db $E8, $0A            ; Add to Note Duration (0A = duration in ticks)
db $E3                 ; Loop End
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_1A_B:       ; Voice B: Meteor	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $03            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $CD, $0A, $78       ; Enable Pansweep (0A: delay in ticks, 78: cycle duration)
db $D4                 ; Enable Echo
db $C8, $04, $ED       ; Change Pitch w/ Envelope (04: envelope duration, ED: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $C8, $24, $07       ; Change Pitch w/ Envelope (24: envelope duration, 07: change in pitch, signed)
db $AD                 ;  Note Tie  [32 ticks] 
db $C8, $FF, $04       ; Change Pitch w/ Envelope (FF: envelope duration, 04: change in pitch, signed)
db $E8, $FF            ; Add to Note Duration (FF = duration in ticks)
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_1B_A:       ; Voice A: Item from a pot	

db $DB, $01            ; Set Detune

SFX_Script_1B_B:       ; Voice B: Item from a pot	

db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $E0, $18            ; Set ADSR Release Value (0-31)
db $C8, $06, $18       ; Change Pitch w/ Envelope (06: envelope duration, 18: change in pitch, signed)
db $0B                 ;  Note C    [6 ticks] 
db $47                 ;  Note F    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_1C_A:       ; Voice A: Air Anchor being fired	

db $DB, $01            ; Set Detune

SFX_Script_1C_B:       ; Voice B: Air Anchor being fired	

db $D4                 ; Enable Echo
db $D6, $05            ; Set Octave to 05
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_1D_A:       ; Voice A: Imp (part 2)	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $D0                 ; Enable Noise
db $CF, $0E            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $CF, $11            ; Set Noise Clock (00-1F)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $A3                 ;  Note B    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_1D_B:       ; Voice B: Imp (part 2)	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $01            ; Set Octave to 01
db $E0, $18            ; Set ADSR Release Value (0-31)
db $C8, $28, $32       ; Change Pitch w/ Envelope (28: envelope duration, 32: change in pitch, signed)
db $0B                 ;  Note C    [6 ticks] 
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_1E_A:       ; Voice A: Phoenix Down	

db $DB, $04            ; Set Detune

SFX_Script_1E_B:       ; Voice B: Phoenix Down	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $CB, $00, $04, $7F  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, 7F: amplitude, max 50%)
db $E2, $07            ; Loop Start (loop 07+1 times)
db $88                 ;  Note A    [8 ticks] 
db $87                 ;  Note A    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_1F_A:       ; Voice A: Demi (short)	

db $DB, $03            ; Set Detune

SFX_Script_1F_B:       ; Voice B: Demi (short)	

db $E8, $24            ; Add to Note Duration (24 = duration in ticks)
db $EA, $8F            ; Play Game Sound Effect (voice B)

SFX_Script_20_A:       ; Voice A: Poison	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $03            ; Set Instrument
db $CB, $00, $06, $BF  ; Enable Tremolo (00: delay in ticks, 06: cycle duration, BF: amplitude, max 50%)
db $D6, $05            ; Set Octave to 05
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $05, $B8       ; Change Pitch w/ Envelope (05: envelope duration, B8: change in pitch, signed)
db $23                 ;  Note D    [24 ticks] 
db $C8, $18, $68       ; Change Pitch w/ Envelope (18: envelope duration, 68: change in pitch, signed)
db $B3                 ;  Note Tie  [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_20_B:       ; Voice B: Poison	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $00            ; Set Instrument
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $D6, $02            ; Set Octave to 02
db $E2, $04            ; Loop Start (loop 04+1 times)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $C8, $21, $E7       ; Change Pitch w/ Envelope (21: envelope duration, E7: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $C8, $14, $43       ; Change Pitch w/ Envelope (14: envelope duration, 43: change in pitch, signed)
db $B3                 ;  Note Tie  [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_21_A:       ; Voice A: Constant punching / Pummel	

db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E2, $00            ; Loop Start (loop 00+1 times)
db $C8, $30, $12       ; Change Pitch w/ Envelope (30: envelope duration, 12: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $C8, $0C, $01       ; Change Pitch w/ Envelope (0C: envelope duration, 01: change in pitch, signed)
db $0C                 ;  Note C    [4 ticks] 
db $E3                 ; Loop End

SFX_Script_21_B:       ; Voice B: Constant punching / Pummel	

db $C1                 ;  Note Rest [6 ticks] 
db $D0                 ; Enable Noise
db $E2, $00            ; Loop Start (loop 00+1 times)
db $CF, $12            ; Set Noise Clock (00-1F)
db $0C                 ;  Note C    [4 ticks] 
db $CF, $18            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End

SFX_Script_22_A:       ; Voice A: Bio

db $DB, $03            ; Set Detune

SFX_Script_22_B:       ; Voice B: Bio

db $DC, $02            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $CD, $00, $74       ; Enable Pansweep (00: delay in ticks, 74: cycle duration)
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $25                 ;  Note D    [12 ticks] 
db $C8, $0C, $08       ; Change Pitch w/ Envelope (0C: envelope duration, 08: change in pitch, signed)
db $B1                 ;  Note Tie  [12 ticks] 
db $C8, $0C, $F4       ; Change Pitch w/ Envelope (0C: envelope duration, F4: change in pitch, signed)
db $B1                 ;  Note Tie  [12 ticks] 
db $C8, $0C, $17       ; Change Pitch w/ Envelope (0C: envelope duration, 17: change in pitch, signed)
db $AD                 ;  Note Tie  [32 ticks] 
db $C8, $0C, $F4       ; Change Pitch w/ Envelope (0C: envelope duration, F4: change in pitch, signed)
db $B1                 ;  Note Tie  [12 ticks] 
db $EB                 ; End of Script

SFX_Script_23_A:       ; Voice A:     ???

db $D4                 ; Enable Echo
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $D6, $10            ; Set Octave to 10
db $C8, $05, $14       ; Change Pitch w/ Envelope (05: envelope duration, 14: change in pitch, signed)
db $CB, $00, $0C, $A3  ; Enable Tremolo (00: delay in ticks, 0C: cycle duration, A3: amplitude, max 50%)
db $9C                 ;  Note B    [64 ticks] 
db $AA                 ;  Note Tie  [64 ticks] 
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_23_B:       ; Voice B:     ???

db $DC, $02            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $DD, $03            ; Set ADSR Attack Value (0-15)
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $C5, $12, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 12: envelope duration)
db $D4                 ; Enable Echo
db $C8, $25, $06       ; Change Pitch w/ Envelope (25: envelope duration, 06: change in pitch, signed)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $4B                 ;  Note F    [32 ticks] 
db $DC, $06            ; Set Instrument
db $D6, $01            ; Set Octave to 01
db $C8, $02, $BA       ; Change Pitch w/ Envelope (02: envelope duration, BA: change in pitch, signed)
db $CD, $08, $6B       ; Enable Pansweep (08: delay in ticks, 6B: cycle duration)
db $C9, $00, $03, $82  ; Enable Vibrato (00: delay in ticks, 03: cycle duration, 82: amplitude, max 1/4 step)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $E0, $0A            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_24_A:       ; Voice A:     ???	

db $DC, $05            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $C8, $03, $6C       ; Change Pitch w/ Envelope (03: envelope duration, 6C: change in pitch, signed)
db $D4                 ; Enable Echo
db $C5, $AB, $00       ; Set Voice Volume w/ Envelope (00: volume, AB: envelope duration)
db $E2, $1B            ; Loop Start (loop 1B+1 times)
db $89                 ;  Note A    [6 ticks] 
db $0D                 ;  Note C    [3 ticks] 
db $DA, $04            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_24_B:       ; Voice B:     ???	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $1A            ; Set Noise Clock (00-1F)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $08                 ;  Note C    [16 ticks] 
db $D1                 ; Disable Noise
db $DC, $05            ; Set Instrument
db $D6, $0C            ; Set Octave to 0C
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $03, $F2       ; Change Pitch w/ Envelope (03: envelope duration, F2: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $08                 ;  Note C    [16 ticks] 
db $C8, $81, $EE       ; Change Pitch w/ Envelope (81: envelope duration, EE: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $C8, $71, $FA       ; Change Pitch w/ Envelope (71: envelope duration, FA: change in pitch, signed)
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_25_A:       ; Voice A: Terrato	

db $CF, $15            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $C5, $30, $77       ; Set Voice Volume w/ Envelope (77: volume, 30: envelope duration)
db $CB, $00, $03, $BF  ; Enable Tremolo (00: delay in ticks, 03: cycle duration, BF: amplitude, max 50%)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $E8, $72            ; Add to Note Duration (72 = duration in ticks)
db $47                 ;  Note F    [96 ticks] 
db $D1                 ; Disable Noise
db $C8, $04, $17       ; Change Pitch w/ Envelope (04: envelope duration, 17: change in pitch, signed)
db $D4                 ; Enable Echo
db $B1                 ;  Note Tie  [12 ticks] 
db $D6, $05            ; Set Octave to 05
db $C8, $1C, $74       ; Change Pitch w/ Envelope (1C: envelope duration, 74: change in pitch, signed)
db $DD, $0F            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $E0, $1C            ; Set ADSR Release Value (0-31)
db $B1                 ;  Note Tie  [12 ticks] 
db $EB                 ; End of Script

SFX_Script_25_B:       ; Voice B: Terrato	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $03            ; Set Instrument
db $D4                 ; Enable Echo
db $CB, $00, $1D, $BF  ; Enable Tremolo (00: delay in ticks, 1D: cycle duration, BF: amplitude, max 50%)
db $C8, $2C, $04       ; Change Pitch w/ Envelope (2C: envelope duration, 04: change in pitch, signed)
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $63                 ;  Note G    [96 ticks] 
db $C8, $2A, $03       ; Change Pitch w/ Envelope (2A: envelope duration, 03: change in pitch, signed)
db $A8                 ;  Note Tie  [192 ticks] 
db $C8, $08, $FD       ; Change Pitch w/ Envelope (08: envelope duration, FD: change in pitch, signed)
db $E0, $18            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_26_A:       ; Voice A: Ifrit	

db $C8, $80, $62       ; Change Pitch w/ Envelope (80: envelope duration, 62: change in pitch, signed)
db $CD, $00, $FB       ; Enable Pansweep (00: delay in ticks, FB: cycle duration)
db $D6, $08            ; Set Octave to 08
db $CB, $00, $2C, $BF  ; Enable Tremolo (00: delay in ticks, 2C: cycle duration, BF: amplitude, max 50%)
db $C5, $2C, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 2C: envelope duration)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $0E                 ;  Note C#   [192 ticks] 
db $E8, $B0            ; Add to Note Duration (B0 = duration in ticks)
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_26_B:       ; Voice B: Ifrit	

db $DC, $02            ; Set Instrument
db $D4                 ; Enable Echo
db $D6, $00            ; Set Octave to 00
db $C5, $60, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 60: envelope duration)
db $CD, $00, $01       ; Enable Pansweep (00: delay in ticks, 01: cycle duration)
db $E2, $02            ; Loop Start (loop 02+1 times)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $78, $86       ; Change Pitch w/ Envelope (78: envelope duration, 86: change in pitch, signed)
db $30                 ;  Note D#   [36 ticks] 
db $E3                 ; Loop End
db $DC, $07            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $E0, $0A            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_27_A:       ; Voice A: Sraphim (part 1)	

db $C3                 ;  Note Rest [3 ticks] 
db $C9, $00, $02, $43  ; Enable Vibrato (00: delay in ticks, 02: cycle duration, 43: amplitude, max 1/4 step)

SFX_Script_27_B:       ; Voice B: Sraphim (part 1)	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $0C            ; Set Octave to 0C
db $C8, $01, $20       ; Change Pitch w/ Envelope (01: envelope duration, 20: change in pitch, signed)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $8C                 ;  Note A#   [192 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AF                 ;  Note Tie  [24 ticks] 
db $EB                 ; End of Script

SFX_Script_28_A:       ; Voice A: Rising Sun throw	

db $C4, $57            ; Set Voice Volume to 57 (00-7F)
db $D6, $08            ; Set Octave to 08
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $E0, $17            ; Set ADSR Release Value (0-31)
db $CB, $00, $08, $77  ; Enable Tremolo (00: delay in ticks, 08: cycle duration, 77: amplitude, max 50%)
db $C9, $00, $08, $FD  ; Enable Vibrato (00: delay in ticks, 08: cycle duration, FD: amplitude, max 1/4 step)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_29_A:       ; Voice A: Cure (part 2)	

db $DB, $03            ; Set Detune

SFX_Script_29_B:       ; Voice B: Cure (part 2)	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $C9, $00, $06, $7F  ; Enable Vibrato (00: delay in ticks, 06: cycle duration, 7F: amplitude, max 1/4 step)
db $D6, $1C            ; Set Octave to 1C
db $34                 ;  Note D#   [8 ticks] 
db $D6, $1C            ; Set Octave to 1C
db $79                 ;  Note G#   [12 ticks] 
db $D6, $23            ; Set Octave to 23
db $E0, $14            ; Set ADSR Release Value (0-31)
db $68                 ;  Note G    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_2A_A:       ; Voice A: Healing spell (part 1)	

db $DB, $03            ; Set Detune

SFX_Script_2A_B:       ; Voice B: Healing spell (part 1)	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $CD, $12, $46       ; Enable Pansweep (12: delay in ticks, 46: cycle duration)
db $D6, $06            ; Set Octave to 06
db $C8, $2A, $12       ; Change Pitch w/ Envelope (2A: envelope duration, 12: change in pitch, signed)
db $75                 ;  Note G#   [32 ticks] 
db $C8, $3B, $12       ; Change Pitch w/ Envelope (3B: envelope duration, 12: change in pitch, signed)
db $74                 ;  Note G#   [48 ticks] 
db $EB                 ; End of Script

SFX_Script_2B_A:       ; Voice A: W-Wind	

db $C3                 ;  Note Rest [3 ticks] 

SFX_Script_2B_B:       ; Voice B: W-Wind	

db $C4, $46            ; Set Voice Volume to 46 (00-7F)
db $CD, $00, $1C       ; Enable Pansweep (00: delay in ticks, 1C: cycle duration)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $D6, $03            ; Set Octave to 03
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $09                 ;  Note C    [12 ticks] 
db $E2, $01            ; Loop Start (loop 01+1 times)
db $C8, $34, $F9       ; Change Pitch w/ Envelope (34: envelope duration, F9: change in pitch, signed)
db $AA                 ;  Note Tie  [64 ticks] 
db $C8, $1C, $0E       ; Change Pitch w/ Envelope (1C: envelope duration, 0E: change in pitch, signed)
db $AA                 ;  Note Tie  [64 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $C8, $68, $F9       ; Change Pitch w/ Envelope (68: envelope duration, F9: change in pitch, signed)
db $E0, $0D            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_2C_A:       ; Voice A: Door Open	

db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $E0, $1E            ; Set ADSR Release Value (0-31)
db $C8, $10, $20       ; Change Pitch w/ Envelope (10: envelope duration, 20: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $D7                 ; Increment Octave
db $6D                 ;  Note G    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_2C_B:       ; Voice B: Door Open	

db $C4, $70            ; Set Voice Volume to 70 (00-7F)
db $DC, $01            ; Set Instrument
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $E0, $1F            ; Set ADSR Release Value (0-31)
db $C8, $10, $20       ; Change Pitch w/ Envelope (10: envelope duration, 20: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $7B                 ;  Note G#   [6 ticks] 
db $EB                 ; End of Script

SFX_Script_2D_A:       ; Voice A: Monster Death	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $10            ; Set Noise Clock (00-1F)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_2D_B:       ; Voice B: Monster Death	

db $D4                 ; Enable Echo
db $D6, $0B            ; Set Octave to 0B
db $E0, $15            ; Set ADSR Release Value (0-31)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_2E_A:       ; Voice A: Sword Stab	

db $DB, $01            ; Set Detune

SFX_Script_2E_B:       ; Voice B: Sword Stab	

db $D6, $05            ; Set Octave to 05
db $CD, $00, $19       ; Enable Pansweep (00: delay in ticks, 19: cycle duration)
db $CB, $06, $09, $4D  ; Enable Tremolo (06: delay in ticks, 09: cycle duration, 4D: amplitude, max 50%)
db $C8, $18, $36       ; Change Pitch w/ Envelope (18: envelope duration, 36: change in pitch, signed)
db $A1                 ;  Note B    [24 ticks] 
db $C4, $30            ; Set Voice Volume to 30 (00-7F)
db $0B                 ;  Note C    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_2F_A:       ; Voice A: Life 2	

db $DB, $01            ; Set Detune

SFX_Script_2F_B:       ; Voice B: Life 2	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $E2, $4A            ; Loop Start (loop 4A+1 times)
db $1A                 ;  Note C#   [4 ticks] 
db $DA, $01            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_30_A:       ; Voice A: Ringing Alarm	

db $C4, $0D            ; Set Voice Volume to 0D (00-7F)
db $C5, $FF, $34       ; Set Voice Volume w/ Envelope (34: volume, FF: envelope duration)
db $C8, $FF, $0F       ; Change Pitch w/ Envelope (FF: envelope duration, 0F: change in pitch, signed)
db $EA, $51            ; Play Game Sound Effect (voice B)

SFX_Script_30_B:       ; Voice B: Ringing Alarm	

db $DC, $06            ; Set Instrument
db $CD, $00, $80       ; Enable Pansweep (00: delay in ticks, 80: cycle duration)
db $C4, $1C            ; Set Voice Volume to 1C (00-7F)
db $C5, $FF, $7F       ; Set Voice Volume w/ Envelope (7F: volume, FF: envelope duration)
db $D6, $0D            ; Set Octave to 0D
db $E2, $05            ; Loop Start (loop 05+1 times)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $02                 ;  Note C    [64 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_31_A:       ; Voice A: Flare (part 1)	

db $D4                 ; Enable Echo
db $CD, $14, $20       ; Enable Pansweep (14: delay in ticks, 20: cycle duration)
db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $E2, $05            ; Loop Start (loop 05+1 times)
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $C8, $60, $C0       ; Change Pitch w/ Envelope (60: envelope duration, C0: change in pitch, signed)
db $68                 ;  Note G    [36 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_31_B:       ; Voice B: Flare (part 1)	

db $EA, $89            ; Play Game Sound Effect (voice B)

SFX_Script_32_A:       ; Voice A: Soul Out (Part 2)	

db $C4, $57            ; Set Voice Volume to 57 (00-7F)
db $DC, $03            ; Set Instrument
db $D4                 ; Enable Echo
db $CD, $14, $A8       ; Enable Pansweep (14: delay in ticks, A8: cycle duration)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $FF, $01       ; Change Pitch w/ Envelope (FF: envelope duration, 01: change in pitch, signed)
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $8E                 ;  Note A#   [64 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $C8, $FF, $10       ; Change Pitch w/ Envelope (FF: envelope duration, 10: change in pitch, signed)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_32_B:       ; Voice B: Soul Out (Part 2)	

db $D6, $0A            ; Set Octave to 0A
db $C5, $09, $0C       ; Set Voice Volume w/ Envelope (0C: volume, 09: envelope duration)
db $CB, $00, $02, $BF  ; Enable Tremolo (00: delay in ticks, 02: cycle duration, BF: amplitude, max 50%)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $42                 ;  Note E    [8 ticks] 
db $C5, $54, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 54: envelope duration)
db $D4                 ; Enable Echo
db $AA                 ;  Note Tie  [64 ticks] 
db $CD, $14, $6C       ; Enable Pansweep (14: delay in ticks, 6C: cycle duration)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_33_A:       ; Voice A: Punch	

db $D0                 ; Enable Noise
db $CF, $11            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $CF, $17            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_34_A:       ; Voice A: Blizzard (part 2)	

db $E8, $04            ; Add to Note Duration (04 = duration in ticks)
db $EA, $1E            ; Play Game Sound Effect (voice B)

SFX_Script_34_B:       ; Voice B: Blizzard (part 2)	

db $E8, $8C            ; Add to Note Duration (8C = duration in ticks)
db $EA, $07            ; Play Game Sound Effect (voice B)

SFX_Script_35_A:       ; Voice A: Dispel (Break spell)	

db $D6, $05            ; Set Octave to 05
db $C8, $08, $EF       ; Change Pitch w/ Envelope (08: envelope duration, EF: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $C8, $18, $38       ; Change Pitch w/ Envelope (18: envelope duration, 38: change in pitch, signed)
db $AF                 ;  Note Tie  [24 ticks] 
db $C8, $8F, $F3       ; Change Pitch w/ Envelope (8F: envelope duration, F3: change in pitch, signed)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $AB                 ;  Note Tie  [72 ticks] 
db $D4                 ; Enable Echo
db $D6, $06            ; Set Octave to 06
db $E0, $12            ; Set ADSR Release Value (0-31)
db $54                 ;  Note F#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_35_B:       ; Voice B: Dispel (Break spell)	

db $D6, $02            ; Set Octave to 02
db $D2                 ; Enable Pitch Modulation
db $DC, $05            ; Set Instrument
db $C8, $20, $25       ; Change Pitch w/ Envelope (20: envelope duration, 25: change in pitch, signed)
db $05                 ;  Note C    [32 ticks] 
db $D4                 ; Enable Echo
db $D6, $03            ; Set Octave to 03
db $CD, $0E, $7F       ; Enable Pansweep (0E: delay in ticks, 7F: cycle duration)
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $C8, $34, $FE       ; Change Pitch w/ Envelope (34: envelope duration, FE: change in pitch, signed)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $02                 ;  Note C    [64 ticks] 
db $D6, $07            ; Set Octave to 07
db $58                 ;  Note F#   [48 ticks] 
db $EB                 ; End of Script

SFX_Script_36_A:       ; Voice A: Ice 2 (part 1)	

db $DB, $68            ; Set Detune

SFX_Script_36_B:       ; Voice B: Ice 2 (part 1)	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $1C            ; Set Octave to 1C
db $C9, $00, $03, $5F  ; Enable Vibrato (00: delay in ticks, 03: cycle duration, 5F: amplitude, max 1/4 step)
db $CB, $00, $01, $FF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, FF: amplitude, max 50%)
db $E0, $18            ; Set ADSR Release Value (0-31)
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $0C, $0A       ; Change Pitch w/ Envelope (0C: envelope duration, 0A: change in pitch, signed)
db $37                 ;  Note D#   [3 ticks] 
db $7D                 ;  Note G#   [3 ticks] 
db $29                 ;  Note D    [3 ticks] 
db $BE                 ;  Note Rest [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_37_A:       ; Voice A: Ice 2 crystalization (part 2)	

db $D4                 ; Enable Echo
db $D6, $0F            ; Set Octave to 0F
db $CB, $00, $24, $67  ; Enable Tremolo (00: delay in ticks, 24: cycle duration, 67: amplitude, max 50%)
db $E0, $18            ; Set ADSR Release Value (0-31)
db $E2, $01            ; Loop Start (loop 01+1 times)
db $0C                 ;  Note C    [4 ticks] 
db $88                 ;  Note A    [8 ticks] 
db $A5                 ;  Note B    [6 ticks] 
db $D5                 ; Disable Echo
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_37_B:       ; Voice B: Ice 2 crystalization (part 2)	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $E2, $01            ; Loop Start (loop 01+1 times)
db $CF, $1F            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $CF, $19            ; Set Noise Clock (00-1F)
db $88                 ;  Note A    [8 ticks] 
db $CF, $1C            ; Set Noise Clock (00-1F)
db $A5                 ;  Note B    [6 ticks] 
db $D5                 ; Disable Echo
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_38_A:       ; Voice A: Slow	

db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $06            ; Set Instrument
db $D6, $34            ; Set Octave to 34
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C9, $00, $18, $7F  ; Enable Vibrato (00: delay in ticks, 18: cycle duration, 7F: amplitude, max 1/4 step)
db $C8, $FF, $72       ; Change Pitch w/ Envelope (FF: envelope duration, 72: change in pitch, signed)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $01                 ;  Note C    [96 ticks] 
db $E0, $13            ; Set ADSR Release Value (0-31)
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_38_B:       ; Voice B: Slow	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C9, $00, $24, $7F  ; Enable Vibrato (00: delay in ticks, 24: cycle duration, 7F: amplitude, max 1/4 step)
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $FF, $EA       ; Change Pitch w/ Envelope (FF: envelope duration, EA: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $E8, $26            ; Add to Note Duration (26 = duration in ticks)
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_39_A:       ; Voice A: Muddle / Confuse	

db $BE                 ;  Note Rest [16 ticks] 
db $DB, $30            ; Set Detune

SFX_Script_39_B:       ; Voice B: Muddle / Confuse	

db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $E2, $09            ; Loop Start (loop 09+1 times)
db $6C                 ;  Note G    [8 ticks] 
db $42                 ;  Note E    [8 ticks] 
db $0A                 ;  Note C    [8 ticks] 
db $DA, $FF            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_3A_A:       ; Voice A: H-Bomb (part 1)	

db $D4                 ; Enable Echo
db $CF, $13            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $05                 ;  Note C    [32 ticks] 
db $D1                 ; Disable Noise
db $D6, $05            ; Set Octave to 05
db $C5, $07, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 07: envelope duration)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $FF, $01       ; Change Pitch w/ Envelope (FF: envelope duration, 01: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $0D            ; Set ADSR Release Value (0-31)
db $E8, $DF            ; Add to Note Duration (DF = duration in ticks)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_3A_B:       ; Voice B: H-Bomb (part 1)	

db $DC, $02            ; Set Instrument
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $D6, $06            ; Set Octave to 06
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $CB, $00, $02, $FE  ; Enable Tremolo (00: delay in ticks, 02: cycle duration, FE: amplitude, max 50%)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $C8, $0D, $0C       ; Change Pitch w/ Envelope (0D: envelope duration, 0C: change in pitch, signed)
db $9B                 ;  Note B    [96 ticks] 
db $DC, $07            ; Set Instrument
db $C5, $78, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 78: envelope duration)
db $C8, $30, $28       ; Change Pitch w/ Envelope (30: envelope duration, 28: change in pitch, signed)
db $D6, $07            ; Set Octave to 07
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $62                 ;  Note G    [192 ticks] 
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_3B_A:       ; Voice A: Carbuncle	

db $DB, $03            ; Set Detune

SFX_Script_3B_B:       ; Voice B: Carbuncle	

db $DC, $00            ; Set Instrument
db $D4                 ; Enable Echo
db $CD, $01, $88       ; Enable Pansweep (01: delay in ticks, 88: cycle duration)
db $D6, $00            ; Set Octave to 00
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $C8, $09, $4C       ; Change Pitch w/ Envelope (09: envelope duration, 4C: change in pitch, signed)
db $6A                 ;  Note G    [16 ticks] 
db $C4, $3F            ; Set Voice Volume to 3F (00-7F)
db $CF, $1F            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $9D                 ;  Note B    [72 ticks] 
db $D1                 ; Disable Noise
db $D6, $07            ; Set Octave to 07
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $01                 ;  Note C    [96 ticks] 
db $C8, $8B, $40       ; Change Pitch w/ Envelope (8B: envelope duration, 40: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_3C_A:       ; Voice A: Shoat	

db $C4, $60            ; Set Voice Volume to 60 (00-7F)
db $DC, $06            ; Set Instrument
db $D4                 ; Enable Echo
db $D6, $01            ; Set Octave to 01
db $CD, $06, $64       ; Enable Pansweep (06: delay in ticks, 64: cycle duration)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $80                 ;  Note A    [64 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_3C_B:       ; Voice B: Shoat	

db $BB                 ;  Note Rest [32 ticks] 
db $DC, $00            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $D4                 ; Enable Echo
db $CB, $00, $01, $7F  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 50%)
db $C8, $0C, $49       ; Change Pitch w/ Envelope (0C: envelope duration, 49: change in pitch, signed)
db $24                 ;  Note D    [16 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $C8, $30, $D8       ; Change Pitch w/ Envelope (30: envelope duration, D8: change in pitch, signed)
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_3D_A:       ; Voice A: Bolt 2	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $0F            ; Set Noise Clock (00-1F)
db $07                 ;  Note C    [24 ticks] 
db $CF, $19            ; Set Noise Clock (00-1F)
db $B0                 ;  Note Tie  [16 ticks] 
db $CF, $1F            ; Set Noise Clock (00-1F)
db $AF                 ;  Note Tie  [24 ticks] 
db $EB                 ; End of Script

SFX_Script_3D_B:       ; Voice B: Bolt 2	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $06            ; Set Instrument
db $D4                 ; Enable Echo
db $D6, $0C            ; Set Octave to 0C
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $14, $03       ; Change Pitch w/ Envelope (14: envelope duration, 03: change in pitch, signed)
db $9E                 ;  Note B    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_3E_A:       ; Voice A: Pearl	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $C8, $2E, $C1       ; Change Pitch w/ Envelope (2E: envelope duration, C1: change in pitch, signed)
db $21                 ;  Note D    [32 ticks] 
db $DC, $02            ; Set Instrument
db $D6, $03            ; Set Octave to 03
db $CD, $00, $4D       ; Enable Pansweep (00: delay in ticks, 4D: cycle duration)
db $CB, $00, $25, $BF  ; Enable Tremolo (00: delay in ticks, 25: cycle duration, BF: amplitude, max 50%)
db $C8, $5E, $33       ; Change Pitch w/ Envelope (5E: envelope duration, 33: change in pitch, signed)
db $1C                 ;  Note D    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_3E_B:       ; Voice B: Pearl	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $C8, $94, $09       ; Change Pitch w/ Envelope (94: envelope duration, 09: change in pitch, signed)
db $57                 ;  Note F#   [72 ticks] 
db $E2, $08            ; Loop Start (loop 08+1 times)
db $94                 ;  Note A#   [16 ticks] 
db $97                 ;  Note A#   [6 ticks] 
db $E3                 ; Loop End
db $DC, $07            ; Set Instrument
db $E2, $02            ; Loop Start (loop 02+1 times)
db $CD, $00, $64       ; Enable Pansweep (00: delay in ticks, 64: cycle duration)
db $0B                 ;  Note C    [6 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $E3                 ; Loop End
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $CE                 ; Disable Pansweep
db $C8, $3C, $17       ; Change Pitch w/ Envelope (3C: envelope duration, 17: change in pitch, signed)
db $E0, $0C            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_3F_A:       ; Voice A: Merton	

db $DB, $0C            ; Set Detune

SFX_Script_3F_B:       ; Voice B: Merton	

db $D4                 ; Enable Echo
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $C8, $64, $01       ; Change Pitch w/ Envelope (64: envelope duration, 01: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $DC, $02            ; Set Instrument
db $C8, $06, $9E       ; Change Pitch w/ Envelope (06: envelope duration, 9E: change in pitch, signed)
db $D6, $03            ; Set Octave to 03
db $0A                 ;  Note C    [8 ticks] 
db $CF, $10            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $A8                 ;  Note Tie  [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $03            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_40_A:       ; Voice A: SwdTech Activation	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $C8, $02, $23       ; Change Pitch w/ Envelope (02: envelope duration, 23: change in pitch, signed)
db $D6, $05            ; Set Octave to 05
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_40_B:       ; Voice B: SwdTech Activation	

db $D4                 ; Enable Echo
db $DC, $01            ; Set Instrument
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $C9, $00, $01, $BF  ; Enable Vibrato (00: delay in ticks, 01: cycle duration, BF: amplitude, max 1/4 step)
db $C8, $02, $AF       ; Change Pitch w/ Envelope (02: envelope duration, AF: change in pitch, signed)
db $21                 ;  Note D    [32 ticks] 
db $EB                 ; End of Script

SFX_Script_41_A:       ; Voice A: Calmness (the Instant Death attack Sleep uses when it dies)	

db $DB, $01            ; Set Detune

SFX_Script_41_B:       ; Voice B: Calmness (the Instant Death attack Sleep uses when it dies)	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $C9, $00, $04, $FF  ; Enable Vibrato (00: delay in ticks, 04: cycle duration, FF: amplitude, max 1/4 step)
db $8D                 ;  Note A#   [96 ticks] 
db $EB                 ; End of Script

SFX_Script_42_A:       ; Voice A: Fire 2	

db $BF                 ;  Note Rest [12 ticks] 
db $D0                 ; Enable Noise
db $D4                 ; Enable Echo
db $CF, $11            ; Set Noise Clock (00-1F)
db $CB, $00, $01, $7F  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 50%)
db $CD, $48, $35       ; Enable Pansweep (48: delay in ticks, 35: cycle duration)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_42_B:       ; Voice B: Fire 2	

db $D6, $06            ; Set Octave to 06
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $09                 ;  Note C    [12 ticks] 
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $01            ; Set Octave to 01
db $32                 ;  Note D#   [16 ticks] 
db $C8, $26, $4B       ; Change Pitch w/ Envelope (26: envelope duration, 4B: change in pitch, signed)
db $E0, $15            ; Set ADSR Release Value (0-31)
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_43_A:       ; Voice A: Bolt 1	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $CF, $11            ; Set Noise Clock (00-1F)
db $07                 ;  Note C    [24 ticks] 
db $CF, $1A            ; Set Noise Clock (00-1F)
db $08                 ;  Note C    [16 ticks] 
db $CF, $12            ; Set Noise Clock (00-1F)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_43_B:       ; Voice B: Bolt 1	

db $DC, $06            ; Set Instrument
db $C4, $5C            ; Set Voice Volume to 5C (00-7F)
db $D2                 ; Enable Pitch Modulation
db $D6, $0A            ; Set Octave to 0A
db $C8, $10, $03       ; Change Pitch w/ Envelope (10: envelope duration, 03: change in pitch, signed)
db $05                 ;  Note C    [32 ticks] 
db $51                 ;  Note F    [6 ticks] 
db $23                 ;  Note D    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_44_A:       ; Voice A: Runic	

db $C1                 ;  Note Rest [6 ticks] 
db $DB, $FA            ; Set Detune

SFX_Script_44_B:       ; Voice B: Runic	

db $DC, $06            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C8, $04, $0B       ; Change Pitch w/ Envelope (04: envelope duration, 0B: change in pitch, signed)
db $D4                 ; Enable Echo
db $E0, $13            ; Set ADSR Release Value (0-31)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_45_A:       ; Voice A: Shell	

db $DB, $07            ; Set Detune

SFX_Script_45_B:       ; Voice B: Shell	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $C9, $00, $C8, $7F  ; Enable Vibrato (00: delay in ticks, C8: cycle duration, 7F: amplitude, max 1/4 step)
db $C8, $14, $26       ; Change Pitch w/ Envelope (14: envelope duration, 26: change in pitch, signed)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $34                 ;  Note D#   [8 ticks] 
db $C8, $04, $26       ; Change Pitch w/ Envelope (04: envelope duration, 26: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $E0, $11            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_46_A:       ; Voice A: Esper disappears	

db $DB, $04            ; Set Detune

SFX_Script_46_B:       ; Voice B: Esper disappears	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $06            ; Set Octave to 06
db $C8, $FF, $FD       ; Change Pitch w/ Envelope (FF: envelope duration, FD: change in pitch, signed)
db $DC, $06            ; Set Instrument
db $CD, $02, $64       ; Enable Pansweep (02: delay in ticks, 64: cycle duration)
db $CB, $00, $08, $BF  ; Enable Tremolo (00: delay in ticks, 08: cycle duration, BF: amplitude, max 50%)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $17            ; Set ADSR Release Value (0-31)
db $9E                 ;  Note B    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_47_A:       ; Voice A: Quick (Part 1)	

db $D4                 ; Enable Echo
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $09            ; Set Octave to 09
db $DC, $06            ; Set Instrument
db $CD, $01, $44       ; Enable Pansweep (01: delay in ticks, 44: cycle duration)
db $DF, $01            ; Set ADSR Sustain Value (0-7)
db $52                 ;  Note F    [4 ticks] 
db $E0, $11            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_47_B:       ; Voice B: Quick (Part 1)	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $1D            ; Set Octave to 1D
db $DB, $0A            ; Set Detune
db $CD, $01, $40       ; Enable Pansweep (01: delay in ticks, 40: cycle duration)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $02                 ;  Note C    [64 ticks] 
db $EB                 ; End of Script

SFX_Script_48_A:       ; Voice A: Safe	

db $DB, $02            ; Set Detune

SFX_Script_48_B:       ; Voice B: Safe	

db $DC, $06            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $CB, $00, $01, $7F  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 50%)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E2, $0E            ; Loop Start (loop 0E+1 times)
db $0B                 ;  Note C    [6 ticks] 
db $E3                 ; Loop End
db $EA, $D3            ; Play Game Sound Effect (voice B)

SFX_Script_49_A:       ; Voice A: Wrench throw (Repo Men, Unseelies, etc.)	

db $D0                 ; Enable Noise
db $CF, $1C            ; Set Noise Clock (00-1F)
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $E2, $03            ; Loop Start (loop 03+1 times)
db $09                 ;  Note C    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_49_B:       ; Voice B: Wrench throw (Repo Men, Unseelies, etc.)	

db $D4                 ; Enable Echo
db $C4, $20            ; Set Voice Volume to 20 (00-7F)
db $C8, $18, $EB       ; Change Pitch w/ Envelope (18: envelope duration, EB: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_4A_A:       ; Voice A: Chainsaw	

db $D6, $09            ; Set Octave to 09
db $E2, $06            ; Loop Start (loop 06+1 times)
db $0C                 ;  Note C    [4 ticks] 
db $E3                 ; Loop End
db $E2, $1E            ; Loop Start (loop 1E+1 times)
db $0D                 ;  Note C    [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_4A_B:       ; Voice B: Chainsaw	

db $D2                 ; Enable Pitch Modulation
db $CF, $15            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $E2, $26            ; Loop Start (loop 26+1 times)
db $0D                 ;  Note C    [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_4B_A:       ; Voice A: Chainsaw	

db $E2, $01            ; Loop Start (loop 01+1 times)
db $E9, $E2            ; Play Game Sound Effect (voice A)

SFX_Script_4B_B:       ; Voice B: Chainsaw	

db $E2, $01            ; Loop Start (loop 01+1 times)
db $EA, $E2            ; Play Game Sound Effect (voice B)

SFX_Script_4C_A:       ; Voice A: Life	

db $D6, $05            ; Set Octave to 05
db $CD, $01, $70       ; Enable Pansweep (01: delay in ticks, 70: cycle duration)
db $E2, $0B            ; Loop Start (loop 0B+1 times)
db $0A                 ;  Note C    [8 ticks] 
db $DA, $01            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_4C_B:       ; Voice B: Life	

db $D6, $0B            ; Set Octave to 0B
db $DC, $05            ; Set Instrument
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $FF, $01       ; Change Pitch w/ Envelope (FF: envelope duration, 01: change in pitch, signed)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_4D_A:       ; Voice A: Ice 3	

db $DB, $C6            ; Set Detune

SFX_Script_4D_B:       ; Voice B: Ice 3	

db $E2, $01            ; Loop Start (loop 01+1 times)
db $D6, $04            ; Set Octave to 04
db $C8, $10, $4F       ; Change Pitch w/ Envelope (10: envelope duration, 4F: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $E3                 ; Loop End
db $E2, $05            ; Loop Start (loop 05+1 times)
db $C8, $12, $BA       ; Change Pitch w/ Envelope (12: envelope duration, BA: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End
db $EA, $37            ; Play Game Sound Effect (voice B)

SFX_Script_4E_A:       ; Voice A: Death (spell)	

db $CF, $16            ; Set Noise Clock (00-1F)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $E9, $E7            ; Play Game Sound Effect (voice A)

SFX_Script_4E_B:       ; Voice B: Death (spell)	

db $C4, $50            ; Set Voice Volume to 50 (00-7F)
db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E2, $08            ; Loop Start (loop 08+1 times)
db $C8, $08, $0F       ; Change Pitch w/ Envelope (08: envelope duration, 0F: change in pitch, signed)
db $40                 ;  Note E    [16 ticks] 
db $C2                 ;  Note Rest [4 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_4F_A:       ; Voice A: Lagomorph	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $03            ; Set Instrument
db $D6, $33            ; Set Octave to 33
db $E0, $1A            ; Set ADSR Release Value (0-31)
db $9F                 ;  Note B    [32 ticks] 
db $C8, $05, $F9       ; Change Pitch w/ Envelope (05: envelope duration, F9: change in pitch, signed)
db $6B                 ;  Note G    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_4F_B:       ; Voice B: Lagomorph	

db $DC, $05            ; Set Instrument
db $D6, $33            ; Set Octave to 33
db $E0, $1A            ; Set ADSR Release Value (0-31)
db $17                 ;  Note C#   [12 ticks] 
db $A3                 ;  Note B    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_50_A:       ; Voice A: Shock	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $16            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $09                 ;  Note C    [12 ticks] 
db $CF, $1C            ; Set Noise Clock (00-1F)
db $01                 ;  Note C    [96 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_50_B:       ; Voice B: Shock	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C8, $0C, $88       ; Change Pitch w/ Envelope (0C: envelope duration, 88: change in pitch, signed)
db $10                 ;  Note C#   [64 ticks] 
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_51_A:       ; Voice A: X-Fer	

db $DB, $01            ; Set Detune

SFX_Script_51_B:       ; Voice B: X-Fer	

db $D4                 ; Enable Echo
db $D6, $06            ; Set Octave to 06
db $CB, $00, $0C, $FF  ; Enable Tremolo (00: delay in ticks, 0C: cycle duration, FF: amplitude, max 50%)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_52_A:       ; Voice A: SwdTech Stunner	

db $D4                 ; Enable Echo
db $D6, $01            ; Set Octave to 01
db $2B                 ;  Note D#   [96 ticks] 
db $AF                 ;  Note Tie  [24 ticks] 
db $EB                 ; End of Script

SFX_Script_52_B:       ; Voice B: SwdTech Stunner	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $00            ; Set Octave to 00
db $C8, $08, $D5       ; Change Pitch w/ Envelope (08: envelope duration, D5: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $58                 ;  Note F#   [48 ticks] 
db $DC, $04            ; Set Instrument
db $D6, $0A            ; Set Octave to 0A
db $C8, $3C, $B1       ; Change Pitch w/ Envelope (3C: envelope duration, B1: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_53_A:       ; Voice A: Break (Part 1)	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $C8, $18, $4C       ; Change Pitch w/ Envelope (18: envelope duration, 4C: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $DC, $04            ; Set Instrument
db $D6, $00            ; Set Octave to 00
db $C8, $20, $74       ; Change Pitch w/ Envelope (20: envelope duration, 74: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $BB                 ;  Note Rest [32 ticks] 
db $C8, $20, $74       ; Change Pitch w/ Envelope (20: envelope duration, 74: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_53_B:       ; Voice B: Break (Part 1)	

db $D4                 ; Enable Echo
db $C4, $24            ; Set Voice Volume to 24 (00-7F)
db $D6, $04            ; Set Octave to 04
db $CB, $00, $0C, $FF  ; Enable Tremolo (00: delay in ticks, 0C: cycle duration, FF: amplitude, max 50%)
db $C9, $00, $0C, $FF  ; Enable Vibrato (00: delay in ticks, 0C: cycle duration, FF: amplitude, max 1/4 step)
db $C8, $9C, $14       ; Change Pitch w/ Envelope (9C: envelope duration, 14: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $01                 ;  Note C    [96 ticks] 
db $AD                 ;  Note Tie  [32 ticks] 
db $EB                 ; End of Script

SFX_Script_54_A:       ; Voice A: The ending of Cleave	

db $D4                 ; Enable Echo
db $D6, $01            ; Set Octave to 01
db $C8, $08, $5D       ; Change Pitch w/ Envelope (08: envelope duration, 5D: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $3F                 ;  Note E    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_54_B:       ; Voice B: The ending of Cleave	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $00            ; Set Octave to 00
db $C8, $08, $D5       ; Change Pitch w/ Envelope (08: envelope duration, D5: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $5B                 ;  Note F#   [24 ticks] 
db $EB                 ; End of Script

SFX_Script_55_A:       ; Voice A: Kitty (Desert Dance move that hastes the party)	

db $DB, $00            ; Set Detune

SFX_Script_55_B:       ; Voice B: Kitty (Desert Dance move that hastes the party)	

db $D6, $0A            ; Set Octave to 0A
db $C8, $0E, $36       ; Change Pitch w/ Envelope (0E: envelope duration, 36: change in pitch, signed)
db $DC, $01            ; Set Instrument
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_56_A:       ; Voice A: Boomerang	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $1F            ; Set Noise Clock (00-1F)
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $E0, $1B            ; Set ADSR Release Value (0-31)
db $E2, $09            ; Loop Start (loop 09+1 times)
db $09                 ;  Note C    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_57_A:       ; Voice A: Mantra	

db $DB, $08            ; Set Detune

SFX_Script_57_B:       ; Voice B: Mantra	

db $D4                 ; Enable Echo
db $CD, $40, $C1       ; Enable Pansweep (40: delay in ticks, C1: cycle duration)
db $DC, $03            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $C8, $30, $DC       ; Change Pitch w/ Envelope (30: envelope duration, DC: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $C8, $60, $30       ; Change Pitch w/ Envelope (60: envelope duration, 30: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $C8, $6B, $84       ; Change Pitch w/ Envelope (6B: envelope duration, 84: change in pitch, signed)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_58_A:       ; Voice A: Sleep	

db $DB, $FE            ; Set Detune

SFX_Script_58_B:       ; Voice B: Sleep	

db $DC, $07            ; Set Instrument
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $C8, $24, $EE       ; Change Pitch w/ Envelope (24: envelope duration, EE: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $C5, $54, $00       ; Set Voice Volume w/ Envelope (00: volume, 54: envelope duration)
db $EA, $1E            ; Play Game Sound Effect (voice B)

SFX_Script_59_A:       ; Voice A: Tapir (part 1)	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $13            ; Set Octave to 13
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $10, $FC       ; Change Pitch w/ Envelope (10: envelope duration, FC: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $DA, $66            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_59_B:       ; Voice B: Tapir (part 1)	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $C9, $00, $10, $BF  ; Enable Vibrato (00: delay in ticks, 10: cycle duration, BF: amplitude, max 1/4 step)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $E2, $03            ; Loop Start (loop 03+1 times)
db $93                 ;  Note A#   [24 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_5A_A:       ; Voice A: Runic activation	

db $DB, $02            ; Set Detune

SFX_Script_5A_B:       ; Voice B: Runic activation	

db $EA, $44            ; Play Game Sound Effect (voice B)

SFX_Script_5B_A:       ; Voice A: Steal	

db $DB, $01            ; Set Detune

SFX_Script_5B_B:       ; Voice B: Steal	

db $D6, $08            ; Set Octave to 08
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E0, $17            ; Set ADSR Release Value (0-31)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_5C_A:       ; Voice A: Green Cherry	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $0F            ; Set Octave to 0F
db $DB, $0F            ; Set Detune
db $CB, $00, $01, $FF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, FF: amplitude, max 50%)
db $C8, $01, $D6       ; Change Pitch w/ Envelope (01: envelope duration, D6: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_5C_B:       ; Voice B: Green Cherry	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $12            ; Set Octave to 12
db $DB, $06            ; Set Detune
db $CB, $00, $02, $FF  ; Enable Tremolo (00: delay in ticks, 02: cycle duration, FF: amplitude, max 50%)
db $C8, $01, $86       ; Change Pitch w/ Envelope (01: envelope duration, 86: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_5D_A:       ; Voice A: Fenrir	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $CF, $10            ; Set Noise Clock (00-1F)
db $01                 ;  Note C    [96 ticks] 
db $AD                 ;  Note Tie  [32 ticks] 
db $CF, $1C            ; Set Noise Clock (00-1F)
db $01                 ;  Note C    [96 ticks] 
db $E8, $6C            ; Add to Note Duration (6C = duration in ticks)
db $AA                 ;  Note Tie  [64 ticks] 
db $CF, $17            ; Set Noise Clock (00-1F)
db $AA                 ;  Note Tie  [64 ticks] 
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C5, $24, $54       ; Set Voice Volume w/ Envelope (54: volume, 24: envelope duration)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_5D_B:       ; Voice B: Fenrir	

db $C4, $50            ; Set Voice Volume to 50 (00-7F)
db $D2                 ; Enable Pitch Modulation
db $D6, $04            ; Set Octave to 04
db $CD, $10, $C8       ; Enable Pansweep (10: delay in ticks, C8: cycle duration)
db $C8, $34, $D3       ; Change Pitch w/ Envelope (34: envelope duration, D3: change in pitch, signed)
db $D4                 ; Enable Echo
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $9E                 ;  Note B    [48 ticks] 
db $D5                 ; Disable Echo
db $E1                 ; Reset ADSR Default Values
db $C8, $5C, $D3       ; Change Pitch w/ Envelope (5C: envelope duration, D3: change in pitch, signed)
db $47                 ;  Note F    [96 ticks] 
db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $03            ; Set Octave to 03
db $C8, $0C, $14       ; Change Pitch w/ Envelope (0C: envelope duration, 14: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $D6, $05            ; Set Octave to 05
db $C8, $A4, $EB       ; Change Pitch w/ Envelope (A4: envelope duration, EB: change in pitch, signed)
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $E0, $11            ; Set ADSR Release Value (0-31)
db $39                 ;  Note E    [96 ticks] 
db $D6, $00            ; Set Octave to 00
db $DC, $05            ; Set Instrument
db $C8, $44, $48       ; Change Pitch w/ Envelope (44: envelope duration, 48: change in pitch, signed)
db $E8, $7C            ; Add to Note Duration (7C = duration in ticks)
db $39                 ;  Note E    [96 ticks] 
db $C8, $5F, $DF       ; Change Pitch w/ Envelope (5F: envelope duration, DF: change in pitch, signed)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_5E_A:       ; Voice A: El Niño	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D6, $05            ; Set Octave to 05
db $DC, $03            ; Set Instrument
db $CD, $2C, $8C       ; Enable Pansweep (2C: delay in ticks, 8C: cycle duration)
db $D4                 ; Enable Echo
db $E2, $0D            ; Loop Start (loop 0D+1 times)
db $C8, $18, $0C       ; Change Pitch w/ Envelope (18: envelope duration, 0C: change in pitch, signed)
db $32                 ;  Note D#   [16 ticks] 
db $C8, $18, $0C       ; Change Pitch w/ Envelope (18: envelope duration, 0C: change in pitch, signed)
db $94                 ;  Note A#   [16 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_5E_B:       ; Voice B: El Niño	

db $D2                 ; Enable Pitch Modulation
db $D4                 ; Enable Echo
db $CD, $54, $5C       ; Enable Pansweep (54: delay in ticks, 5C: cycle duration)
db $D6, $09            ; Set Octave to 09
db $DC, $03            ; Set Instrument
db $C9, $00, $85, $8F  ; Enable Vibrato (00: delay in ticks, 85: cycle duration, 8F: amplitude, max 1/4 step)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $62                 ;  Note G    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_5F_A:       ; Voice A: CleanSweep	

db $D6, $05            ; Set Octave to 05
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $E6                 ; Enable Drum Roll (no key off at end of note unless the next note is a rest)
db $00                 ;  Note C    [192 ticks] 
db $E1                 ; Reset ADSR Default Values
db $C4, $6C            ; Set Voice Volume to 6C (00-7F)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $08                 ;  Note C    [16 ticks] 
db $C8, $FF, $FC       ; Change Pitch w/ Envelope (FF: envelope duration, FC: change in pitch, signed)
db $E0, $08            ; Set ADSR Release Value (0-31)
db $0E                 ;  Note C#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_5F_B:       ; Voice B: CleanSweep	

db $C4, $05            ; Set Voice Volume to 05 (00-7F)
db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $14            ; Set Noise Clock (00-1F)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $C5, $C0, $30       ; Set Voice Volume w/ Envelope (30: volume, C0: envelope duration)
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $14            ; Set ADSR Release Value (0-31)
db $B1                 ;  Note Tie  [12 ticks] 
db $EB                 ; End of Script

SFX_Script_60_A:       ; Voice A: A blunt impact 	

db $D0                 ; Enable Noise
db $D4                 ; Enable Echo
db $CF, $1A            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $CF, $0F            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_61_A:       ; Voice A: Sketch	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $D6, $02            ; Set Octave to 02
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $E2, $01            ; Loop Start (loop 01+1 times)
db $0A                 ;  Note C    [8 ticks] 
db $0B                 ;  Note C    [6 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $E3                 ; Loop End
db $DC, $05            ; Set Instrument
db $D6, $0D            ; Set Octave to 0D
db $C8, $06, $12       ; Change Pitch w/ Envelope (06: envelope duration, 12: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_61_B:       ; Voice B: Sketch	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $D6, $07            ; Set Octave to 07
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $E2, $01            ; Loop Start (loop 01+1 times)
db $0A                 ;  Note C    [8 ticks] 
db $0B                 ;  Note C    [6 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $E3                 ; Loop End
db $D6, $13            ; Set Octave to 13
db $C8, $13, $0D       ; Change Pitch w/ Envelope (13: envelope duration, 0D: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_62_A:       ; Voice A: Fire/Ice/Bolt Beam (Part 1)	

db $D4                 ; Enable Echo
db $D6, $19            ; Set Octave to 19
db $CB, $00, $03, $7F  ; Enable Tremolo (00: delay in ticks, 03: cycle duration, 7F: amplitude, max 50%)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $C8, $04, $26       ; Change Pitch w/ Envelope (04: envelope duration, 26: change in pitch, signed)
db $64                 ;  Note G    [64 ticks] 
db $EB                 ; End of Script

SFX_Script_62_B:       ; Voice B: Fire/Ice/Bolt Beam (Part 1)	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $C9, $00, $04, $7F  ; Enable Vibrato (00: delay in ticks, 04: cycle duration, 7F: amplitude, max 1/4 step)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $C8, $18, $22       ; Change Pitch w/ Envelope (18: envelope duration, 22: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_63_A:       ; Voice A: Bio Blaster	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $0A            ; Set Octave to 0A
db $C9, $00, $44, $7F  ; Enable Vibrato (00: delay in ticks, 44: cycle duration, 7F: amplitude, max 1/4 step)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $C8, $08, $0A       ; Change Pitch w/ Envelope (08: envelope duration, 0A: change in pitch, signed)
db $2B                 ;  Note D#   [96 ticks] 
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_63_B:       ; Voice B: Bio Blaster	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $1A            ; Set Octave to 1A
db $C9, $00, $64, $7F  ; Enable Vibrato (00: delay in ticks, 64: cycle duration, 7F: amplitude, max 1/4 step)
db $CB, $00, $08, $FF  ; Enable Tremolo (00: delay in ticks, 08: cycle duration, FF: amplitude, max 50%)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $C8, $03, $DE       ; Change Pitch w/ Envelope (03: envelope duration, DE: change in pitch, signed)
db $2B                 ;  Note D#   [96 ticks] 
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_64_A:       ; Voice A: Fire Dance	

db $D4                 ; Enable Echo
db $D6, $01            ; Set Octave to 01
db $C9, $00, $20, $FF  ; Enable Vibrato (00: delay in ticks, 20: cycle duration, FF: amplitude, max 1/4 step)
db $CB, $00, $18, $FF  ; Enable Tremolo (00: delay in ticks, 18: cycle duration, FF: amplitude, max 50%)
db $00                 ;  Note C    [192 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_64_B:       ; Voice B: Fire Dance	

db $D4                 ; Enable Echo
db $DC, $07            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $BA                 ;  Note Rest [48 ticks] 
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $18, $14       ; Change Pitch w/ Envelope (18: envelope duration, 14: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $C8, $18, $D0       ; Change Pitch w/ Envelope (18: envelope duration, D0: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $E3                 ; Loop End
db $C8, $18, $14       ; Change Pitch w/ Envelope (18: envelope duration, 14: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_65_A:       ; Voice A: Retort	

db $D4                 ; Enable Echo
db $DB, $01            ; Set Detune

SFX_Script_65_B:       ; Voice B: Retort	

db $DC, $07            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $C8, $07, $3C       ; Change Pitch w/ Envelope (07: envelope duration, 3C: change in pitch, signed)
db $22                 ;  Note D    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_66_A:       ; Voice A: Bio Blaster	

db $EA, $34            ; Play Game Sound Effect (voice B)

SFX_Script_66_B:       ; Voice B: Bio Blaster	

db $EA, $7D            ; Play Game Sound Effect (voice B)

SFX_Script_67_A:       ; Voice A: Discord	

db $DB, $01            ; Set Detune

SFX_Script_67_B:       ; Voice B: Discord	

db $DC, $03            ; Set Instrument
db $D4                 ; Enable Echo
db $C9, $00, $22, $FF  ; Enable Vibrato (00: delay in ticks, 22: cycle duration, FF: amplitude, max 1/4 step)
db $D6, $05            ; Set Octave to 05
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $CB, $00, $90, $BF  ; Enable Tremolo (00: delay in ticks, 90: cycle duration, BF: amplitude, max 50%)
db $8D                 ;  Note A#   [96 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_68_A:       ; Voice A: Lifeshaver	

db $D6, $06            ; Set Octave to 06
db $C8, $01, $20       ; Change Pitch w/ Envelope (01: envelope duration, 20: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $3F                 ;  Note E    [24 ticks] 
db $E2, $05            ; Loop Start (loop 05+1 times)
db $C5, $0D, $26       ; Set Voice Volume w/ Envelope (26: volume, 0D: envelope duration)
db $C8, $11, $F1       ; Change Pitch w/ Envelope (11: envelope duration, F1: change in pitch, signed)
db $83                 ;  Note A    [32 ticks] 
db $E3                 ; Loop End
db $C8, $08, $EB       ; Change Pitch w/ Envelope (08: envelope duration, EB: change in pitch, signed)
db $4D                 ;  Note F    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_68_B:       ; Voice B: Lifeshaver	

db $DC, $05            ; Set Instrument
db $D4                 ; Enable Echo
db $D6, $06            ; Set Octave to 06
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $12, $0C       ; Change Pitch w/ Envelope (12: envelope duration, 0C: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $68                 ;  Note G    [36 ticks] 
db $D5                 ; Disable Echo
db $D6, $05            ; Set Octave to 05
db $C8, $9C, $BE       ; Change Pitch w/ Envelope (9C: envelope duration, BE: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_69_A:       ; Voice A: Plasma	

db $DC, $01            ; Set Instrument
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $D4                 ; Enable Echo
db $D6, $04            ; Set Octave to 04
db $C8, $3A, $FE       ; Change Pitch w/ Envelope (3A: envelope duration, FE: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $E2, $05            ; Loop Start (loop 05+1 times)
db $DC, $00            ; Set Instrument
db $D6, $00            ; Set Octave to 00
db $C8, $19, $67       ; Change Pitch w/ Envelope (19: envelope duration, 67: change in pitch, signed)
db $32                 ;  Note D#   [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_69_B:       ; Voice B: Plasma	

db $DC, $02            ; Set Instrument
db $D4                 ; Enable Echo
db $C8, $48, $09       ; Change Pitch w/ Envelope (48: envelope duration, 09: change in pitch, signed)
db $D6, $07            ; Set Octave to 07
db $DD, $03            ; Set ADSR Attack Value (0-15)
db $02                 ;  Note C    [64 ticks] 
db $E0, $11            ; Set ADSR Release Value (0-31)
db $AC                 ;  Note Tie  [48 ticks] 
db $C8, $40, $01       ; Change Pitch w/ Envelope (40: envelope duration, 01: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_6A_A:       ; Voice A: Jump sound	

db $DC, $00            ; Set Instrument
db $D0                 ; Enable Noise
db $CF, $1E            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $D1                 ; Disable Noise
db $D6, $02            ; Set Octave to 02
db $C8, $40, $63       ; Change Pitch w/ Envelope (40: envelope duration, 63: change in pitch, signed)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_6A_B:       ; Voice B: Jump sound	

db $DC, $02            ; Set Instrument
db $D6, $19            ; Set Octave to 19
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $0A                 ;  Note C    [8 ticks] 
db $C8, $34, $2F       ; Change Pitch w/ Envelope (34: envelope duration, 2F: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_6B_A:       ; Voice A: L? Pearl (part 1)	

db $EA, $A3            ; Play Game Sound Effect (voice B)

SFX_Script_6B_B:       ; Voice B: L? Pearl (part 1)	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $C8, $18, $E4       ; Change Pitch w/ Envelope (18: envelope duration, E4: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_6C_A:       ; Voice A: TekBarrier	

db $C3                 ;  Note Rest [3 ticks] 

SFX_Script_6C_B:       ; Voice B: TekBarrier	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $C8, $C8, $03       ; Change Pitch w/ Envelope (C8: envelope duration, 03: change in pitch, signed)
db $C9, $00, $01, $7F  ; Enable Vibrato (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 1/4 step)
db $01                 ;  Note C    [96 ticks] 
db $AD                 ;  Note Tie  [32 ticks] 
db $C8, $A0, $FD       ; Change Pitch w/ Envelope (A0: envelope duration, FD: change in pitch, signed)
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_6D_A:       ; Voice A: Shiller	

db $C3                 ;  Note Rest [3 ticks] 
db $C9, $00, $04, $47  ; Enable Vibrato (00: delay in ticks, 04: cycle duration, 47: amplitude, max 1/4 step)

SFX_Script_6D_B:       ; Voice B: Shiller	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C5, $60, $10       ; Set Voice Volume w/ Envelope (10: volume, 60: envelope duration)
db $E2, $04            ; Loop Start (loop 04+1 times)
db $08                 ;  Note C    [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_6E_A:       ; Voice A: Acid Rain	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $1F            ; Set Noise Clock (00-1F)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $01                 ;  Note C    [96 ticks] 
db $E0, $10            ; Set ADSR Release Value (0-31)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_6F_A:       ; Voice A: Slash	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C8, $0C, $0F       ; Change Pitch w/ Envelope (0C: envelope duration, 0F: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $1D                 ;  Note D    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_6F_B:       ; Voice B: Slash	

db $D4                 ; Enable Echo
db $D6, $18            ; Set Octave to 18
db $C8, $54, $58       ; Change Pitch w/ Envelope (54: envelope duration, 58: change in pitch, signed)
db $25                 ;  Note D    [12 ticks] 
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $9B                 ;  Note B    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_70_A:       ; Voice A: Slimer	

db $DB, $02            ; Set Detune

SFX_Script_70_B:       ; Voice B: Slimer	

db $D4                 ; Enable Echo
db $DC, $01            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $E2, $01            ; Loop Start (loop 01+1 times)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $C8, $34, $D0       ; Change Pitch w/ Envelope (34: envelope duration, D0: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $C8, $34, $30       ; Change Pitch w/ Envelope (34: envelope duration, 30: change in pitch, signed)
db $AC                 ;  Note Tie  [48 ticks] 
db $E3                 ; Loop End
db $C8, $48, $CF       ; Change Pitch w/ Envelope (48: envelope duration, CF: change in pitch, signed)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_71_A:       ; Voice A: Delta Hit	

db $DB, $FE            ; Set Detune

SFX_Script_71_B:       ; Voice B: Delta Hit	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $A3                 ;  Note B    [12 ticks] 
db $C8, $0C, $0C       ; Change Pitch w/ Envelope (0C: envelope duration, 0C: change in pitch, signed)
db $85                 ;  Note A    [24 ticks] 
db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $9B                 ;  Note B    [96 ticks] 
db $C9, $00, $30, $D4  ; Enable Vibrato (00: delay in ticks, 30: cycle duration, D4: amplitude, max 1/4 step)
db $E2, $04            ; Loop Start (loop 04+1 times)
db $AC                 ;  Note Tie  [48 ticks] 
db $E3                 ; Loop End
db $C8, $60, $BD       ; Change Pitch w/ Envelope (60: envelope duration, BD: change in pitch, signed)
db $AB                 ;  Note Tie  [72 ticks] 
db $EB                 ; End of Script

SFX_Script_72_A:       ; Voice A: Merton (partial)	

db $DB, $00            ; Set Detune

SFX_Script_72_B:       ; Voice B: Merton (partial)	

db $D4                 ; Enable Echo
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $E0, $0C            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_73_A:       ; Voice A: Sandstorm	

db $D4                 ; Enable Echo
db $CD, $20, $7C       ; Enable Pansweep (20: delay in ticks, 7C: cycle duration)
db $C5, $B4, $00       ; Set Voice Volume w/ Envelope (00: volume, B4: envelope duration)
db $C8, $9C, $04       ; Change Pitch w/ Envelope (9C: envelope duration, 04: change in pitch, signed)
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_73_B:       ; Voice B: Sandstorm	

db $C4, $3C            ; Set Voice Volume to 3C (00-7F)
db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $C8, $47, $02       ; Change Pitch w/ Envelope (47: envelope duration, 02: change in pitch, signed)
db $4A                 ;  Note F    [48 ticks] 
db $C8, $6B, $FC       ; Change Pitch w/ Envelope (6B: envelope duration, FC: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_74_A:       ; Voice A: Goner	

db $D4                 ; Enable Echo
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $C5, $84, $28       ; Set Voice Volume w/ Envelope (28: volume, 84: envelope duration)
db $D0                 ; Enable Noise
db $CF, $11            ; Set Noise Clock (00-1F)
db $01                 ;  Note C    [96 ticks] 
db $CF, $13            ; Set Noise Clock (00-1F)
db $A8                 ;  Note Tie  [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_74_B:       ; Voice B: Goner	

db $C4, $48            ; Set Voice Volume to 48 (00-7F)
db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $05            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $C8, $FF, $34       ; Change Pitch w/ Envelope (FF: envelope duration, 34: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $DC, $04            ; Set Instrument
db $C8, $CF, $38       ; Change Pitch w/ Envelope (CF: envelope duration, 38: change in pitch, signed)
db $70                 ;  Note G#   [192 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_75_A:       ; Voice A: Land Slide	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $E2, $08            ; Loop Start (loop 08+1 times)
db $D6, $04            ; Set Octave to 04
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $E8, $06            ; Add to Note Duration (06 = duration in ticks)
db $25                 ;  Note D    [12 ticks] 
db $3F                 ;  Note E    [24 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_76_A:       ; Voice A: Rage (Forest Dance attack)/Inviz Edge (much louder though)	

db $D4                 ; Enable Echo
db $E2, $15            ; Loop Start (loop 15+1 times)
db $CF, $1F            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $E0, $1D            ; Set ADSR Release Value (0-31)
db $0A                 ;  Note C    [8 ticks] 
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $E0, $1D            ; Set ADSR Release Value (0-31)
db $CF, $1B            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_76_B:       ; Voice B: Rage (Forest Dance attack)/Inviz Edge (much louder though)	

db $DC, $07            ; Set Instrument
db $D4                 ; Enable Echo
db $CB, $00, $05, $BF  ; Enable Tremolo (00: delay in ticks, 05: cycle duration, BF: amplitude, max 50%)
db $D6, $05            ; Set Octave to 05
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $E0, $0C            ; Set ADSR Release Value (0-31)
db $C8, $45, $21       ; Change Pitch w/ Envelope (45: envelope duration, 21: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $C8, $60, $FC       ; Change Pitch w/ Envelope (60: envelope duration, FC: change in pitch, signed)
db $AA                 ;  Note Tie  [64 ticks] 
db $C8, $21, $30       ; Change Pitch w/ Envelope (21: envelope duration, 30: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $C8, $2A, $F9       ; Change Pitch w/ Envelope (2A: envelope duration, F9: change in pitch, signed)
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_77_A:       ; Voice A: Haste/Hastega (partial)	

db $E0, $1F            ; Set ADSR Release Value (0-31)
db $E2, $00            ; Loop Start (loop 00+1 times)
db $CF, $1F            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $C4, $17            ; Set Voice Volume to 17 (00-7F)
db $A1                 ;  Note B    [24 ticks] 
db $C4, $0B            ; Set Voice Volume to 0B (00-7F)
db $A1                 ;  Note B    [24 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_77_B:       ; Voice B: Haste/Hastega (partial)	

db $DC, $05            ; Set Instrument
db $E2, $00            ; Loop Start (loop 00+1 times)
db $CB, $00, $03, $BF  ; Enable Tremolo (00: delay in ticks, 03: cycle duration, BF: amplitude, max 50%)
db $D6, $08            ; Set Octave to 08
db $E0, $1D            ; Set ADSR Release Value (0-31)
db $9E                 ;  Note B    [48 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_78_A:       ; Voice A: Magitek Armor moving	

db $DB, $01            ; Set Detune

SFX_Script_78_B:       ; Voice B: Magitek Armor moving	

db $D6, $02            ; Set Octave to 02
db $7A                 ;  Note G#   [8 ticks] 
db $C8, $14, $F7       ; Change Pitch w/ Envelope (14: envelope duration, F7: change in pitch, signed)
db $41                 ;  Note E    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_79_A:       ; Voice A: Aqua Rake	

db $BE                 ;  Note Rest [16 ticks] 
db $D4                 ; Enable Echo
db $DB, $F6            ; Set Detune

SFX_Script_79_B:       ; Voice B: Aqua Rake	

db $E2, $08            ; Loop Start (loop 08+1 times)
db $EA, $D7            ; Play Game Sound Effect (voice B)

SFX_Script_7A_A:       ; Voice A: Elf Fire	

db $C4, $24            ; Set Voice Volume to 24 (00-7F)
db $CD, $28, $64       ; Enable Pansweep (28: delay in ticks, 64: cycle duration)
db $D0                 ; Enable Noise
db $CF, $08            ; Set Noise Clock (00-1F)
db $00                 ;  Note C    [192 ticks] 
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_7A_B:       ; Voice B: Elf Fire	

db $DC, $03            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C9, $00, $0C, $7F  ; Enable Vibrato (00: delay in ticks, 0C: cycle duration, 7F: amplitude, max 1/4 step)
db $C8, $FF, $04       ; Change Pitch w/ Envelope (FF: envelope duration, 04: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_7B_A:       ; Voice A: Flash Rain	

db $C4, $29            ; Set Voice Volume to 29 (00-7F)
db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $1E            ; Set Noise Clock (00-1F)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_7B_B:       ; Voice B: Flash Rain	

db $D4                 ; Enable Echo
db $CD, $01, $80       ; Enable Pansweep (01: delay in ticks, 80: cycle duration)
db $D6, $0A            ; Set Octave to 0A
db $38                 ;  Note E    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_7C_A:       ; Voice A: AuraBolt	

db $DB, $01            ; Set Detune

SFX_Script_7C_B:       ; Voice B: AuraBolt	

db $D4                 ; Enable Echo
db $D6, $32            ; Set Octave to 32
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $C8, $41, $E8       ; Change Pitch w/ Envelope (41: envelope duration, E8: change in pitch, signed)
db $03                 ;  Note C    [72 ticks] 
db $C8, $04, $30       ; Change Pitch w/ Envelope (04: envelope duration, 30: change in pitch, signed)
db $AD                 ;  Note Tie  [32 ticks] 
db $EB                 ; End of Script

SFX_Script_7D_A:       ; Voice A: Cure 2	

db $DB, $07            ; Set Detune

SFX_Script_7D_B:       ; Voice B: Cure 2	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $CD, $02, $C0       ; Enable Pansweep (02: delay in ticks, C0: cycle duration)
db $E2, $04            ; Loop Start (loop 04+1 times)
db $6D                 ;  Note G    [6 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $E2, $05            ; Loop Start (loop 05+1 times)
db $0C                 ;  Note C    [4 ticks] 
db $DA, $04            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_7E_A:       ; Voice A: Snare	

db $DB, $7F            ; Set Detune

SFX_Script_7E_B:       ; Voice B: Snare	

db $E9, $64            ; Play Game Sound Effect (voice A)

SFX_Script_7F_A:       ; Voice A: Odin	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $D6, $07            ; Set Octave to 07
db $DC, $02            ; Set Instrument
db $C8, $0A, $C7       ; Change Pitch w/ Envelope (0A: envelope duration, C7: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $A3                 ;  Note B    [12 ticks] 
db $C8, $57, $F2       ; Change Pitch w/ Envelope (57: envelope duration, F2: change in pitch, signed)
db $E0, $0D            ; Set ADSR Release Value (0-31)
db $A9                 ;  Note Tie  [96 ticks] 
db $E9, $BE            ; Play Game Sound Effect (voice A)

SFX_Script_7F_B:       ; Voice B: Odin	

db $D4                 ; Enable Echo
db $CD, $1B, $B8       ; Enable Pansweep (1B: delay in ticks, B8: cycle duration)
db $D2                 ; Enable Pitch Modulation
db $C8, $54, $16       ; Change Pitch w/ Envelope (54: envelope duration, 16: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E8, $65            ; Add to Note Duration (65 = duration in ticks)
db $02                 ;  Note C    [64 ticks] 
db $EA, $BE            ; Play Game Sound Effect (voice B)

SFX_Script_80_A:       ; Voice A: Bahamut	

db $D4                 ; Enable Echo
db $D6, $05            ; Set Octave to 05
db $DC, $00            ; Set Instrument
db $C8, $48, $E5       ; Change Pitch w/ Envelope (48: envelope duration, E5: change in pitch, signed)
db $CB, $00, $02, $BF  ; Enable Tremolo (00: delay in ticks, 02: cycle duration, BF: amplitude, max 50%)
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $0A                 ;  Note C    [8 ticks] 
db $C8, $24, $40       ; Change Pitch w/ Envelope (24: envelope duration, 40: change in pitch, signed)
db $AD                 ;  Note Tie  [32 ticks] 
db $D5                 ; Disable Echo
db $B9                 ;  Note Rest [72 ticks] 
db $D0                 ; Enable Noise
db $CF, $14            ; Set Noise Clock (00-1F)
db $CD, $10, $60       ; Enable Pansweep (10: delay in ticks, 60: cycle duration)
db $E1                 ; Reset ADSR Default Values
db $E2, $33            ; Loop Start (loop 33+1 times)
db $0B                 ;  Note C    [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_80_B:       ; Voice B: Bahamut	

db $D2                 ; Enable Pitch Modulation
db $D6, $04            ; Set Octave to 04
db $CD, $10, $60       ; Enable Pansweep (10: delay in ticks, 60: cycle duration)
db $C8, $02, $F6       ; Change Pitch w/ Envelope (02: envelope duration, F6: change in pitch, signed)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $87                 ;  Note A    [12 ticks] 
db $C8, $20, $0C       ; Change Pitch w/ Envelope (20: envelope duration, 0C: change in pitch, signed)
db $C5, $3E, $56       ; Set Voice Volume w/ Envelope (56: volume, 3E: envelope duration)
db $B2                 ;  Note Tie  [8 ticks] 
db $D6, $05            ; Set Octave to 05
db $C8, $43, $F3       ; Change Pitch w/ Envelope (43: envelope duration, F3: change in pitch, signed)
db $93                 ;  Note A#   [24 ticks] 
db $D3                 ; Disable Pitch Modulation
db $E1                 ; Reset ADSR Default Values
db $C8, $03, $CE       ; Change Pitch w/ Envelope (03: envelope duration, CE: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $D4                 ; Enable Echo
db $E2, $01            ; Loop Start (loop 01+1 times)
db $E2, $09            ; Loop Start (loop 09+1 times)
db $C8, $09, $19       ; Change Pitch w/ Envelope (09: envelope duration, 19: change in pitch, signed)
db $B3                 ;  Note Tie  [6 ticks] 
db $C8, $2D, $EA       ; Change Pitch w/ Envelope (2D: envelope duration, EA: change in pitch, signed)
db $B0                 ;  Note Tie  [16 ticks] 
db $E3                 ; Loop End
db $C5, $FF, $00       ; Set Voice Volume w/ Envelope (00: volume, FF: envelope duration)
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_81_A:       ; Voice A: Bismarck	

db $BE                 ;  Note Rest [16 ticks] 
db $CD, $0C, $57       ; Enable Pansweep (0C: delay in ticks, 57: cycle duration)
db $DB, $FA            ; Set Detune

SFX_Script_81_B:       ; Voice B: Bismarck	

db $DC, $00            ; Set Instrument
db $D4                 ; Enable Echo
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $06                 ;  Note C    [36 ticks] 
db $D6, $01            ; Set Octave to 01
db $C8, $28, $36       ; Change Pitch w/ Envelope (28: envelope duration, 36: change in pitch, signed)
db $81                 ;  Note A    [72 ticks] 
db $E2, $0A            ; Loop Start (loop 0A+1 times)
db $EA, $D7            ; Play Game Sound Effect (voice B)

SFX_Script_82_A:       ; Voice A: Drill	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $DB, $76            ; Set Detune
db $CB, $00, $01, $7F  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 50%)
db $E2, $1E            ; Loop Start (loop 1E+1 times)
db $A7                 ;  Note B    [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_82_B:       ; Voice B: Drill	

db $D4                 ; Enable Echo
db $D6, $0F            ; Set Octave to 0F
db $DB, $32            ; Set Detune
db $CB, $00, $01, $7F  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 50%)
db $E2, $1E            ; Loop Start (loop 1E+1 times)
db $A7                 ;  Note B    [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_83_A:       ; Voice A: Chocobop	

db $DC, $07            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $E2, $0E            ; Loop Start (loop 0E+1 times)
db $99                 ;  Note A#   [3 ticks] 
db $C3                 ;  Note Rest [3 ticks] 
db $37                 ;  Note D#   [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_83_B:       ; Voice B: Chocobop	

db $B7                 ;  Note Rest [96 ticks] 
db $D0                 ; Enable Noise
db $CF, $13            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $0B                 ;  Note C    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_84_A:       ; Voice A: Quasar	

db $D6, $07            ; Set Octave to 07
db $CD, $01, $BC       ; Enable Pansweep (01: delay in ticks, BC: cycle duration)
db $DC, $00            ; Set Instrument
db $D4                 ; Enable Echo
db $E2, $05            ; Loop Start (loop 05+1 times)
db $0C                 ;  Note C    [4 ticks] 
db $DA, $FA            ; Add to Transpose
db $E3                 ; Loop End
db $D6, $05            ; Set Octave to 05
db $C8, $18, $0A       ; Change Pitch w/ Envelope (18: envelope duration, 0A: change in pitch, signed)
db $C9, $00, $06, $FF  ; Enable Vibrato (00: delay in ticks, 06: cycle duration, FF: amplitude, max 1/4 step)
db $23                 ;  Note D    [24 ticks] 
db $C8, $08, $3A       ; Change Pitch w/ Envelope (08: envelope duration, 3A: change in pitch, signed)
db $AD                 ;  Note Tie  [32 ticks] 
db $C8, $FF, $FE       ; Change Pitch w/ Envelope (FF: envelope duration, FE: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $AC                 ;  Note Tie  [48 ticks] 
db $C8, $00, $03       ; Change Pitch w/ Envelope (00: envelope duration, 03: change in pitch, signed)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_84_B:       ; Voice B: Quasar	

db $D6, $04            ; Set Octave to 04
db $DC, $03            ; Set Instrument
db $CD, $03, $70       ; Enable Pansweep (03: delay in ticks, 70: cycle duration)
db $E2, $13            ; Loop Start (loop 13+1 times)
db $0D                 ;  Note C    [3 ticks] 
db $DA, $01            ; Add to Transpose
db $E3                 ; Loop End
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $01            ; Set Octave to 01
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $D4                 ; Enable Echo
db $C8, $FF, $02       ; Change Pitch w/ Envelope (FF: envelope duration, 02: change in pitch, signed)
db $1C                 ;  Note D    [192 ticks] 
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_85_A:       ; Voice A: L4 Flare (Part 2)	

db $DB, $00            ; Set Detune

SFX_Script_85_B:       ; Voice B: L4 Flare (Part 2)	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $12            ; Set Noise Clock (00-1F)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $0A                 ;  Note C    [8 ticks] 
db $0A                 ;  Note C    [8 ticks] 
db $05                 ;  Note C    [32 ticks] 
db $EB                 ; End of Script

SFX_Script_86_A:       ; Voice A: Crusader	

db $D4                 ; Enable Echo
db $CD, $40, $54       ; Enable Pansweep (40: delay in ticks, 54: cycle duration)
db $01                 ;  Note C    [96 ticks] 
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $CF, $12            ; Set Noise Clock (00-1F)
db $DF, $04            ; Set ADSR Sustain Value (0-7)
db $01                 ;  Note C    [96 ticks] 
db $C5, $28, $67       ; Set Voice Volume w/ Envelope (67: volume, 28: envelope duration)
db $01                 ;  Note C    [96 ticks] 
db $E0, $10            ; Set ADSR Release Value (0-31)
db $E8, $A9            ; Add to Note Duration (A9 = duration in ticks)
db $A8                 ;  Note Tie  [192 ticks] 
db $C5, $28, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 28: envelope duration)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $9A                 ;  Note B    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_86_B:       ; Voice B: Crusader	

db $D2                 ; Enable Pitch Modulation
db $C8, $5C, $24       ; Change Pitch w/ Envelope (5C: envelope duration, 24: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $DC, $00            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $E2, $01            ; Loop Start (loop 01+1 times)
db $C8, $60, $C4       ; Change Pitch w/ Envelope (60: envelope duration, C4: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $DA, $B4            ; Add to Transpose
db $E3                 ; Loop End
db $CB, $00, $05, $BF  ; Enable Tremolo (00: delay in ticks, 05: cycle duration, BF: amplitude, max 50%)
db $E8, $A9            ; Add to Note Duration (A9 = duration in ticks)
db $9A                 ;  Note B    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_87_A:       ; Voice A: Rippler	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $C9, $00, $24, $FF  ; Enable Vibrato (00: delay in ticks, 24: cycle duration, FF: amplitude, max 1/4 step)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $A9                 ;  Note Tie  [96 ticks] 
db $C8, $60, $C1       ; Change Pitch w/ Envelope (60: envelope duration, C1: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_87_B:       ; Voice B: Rippler	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C9, $00, $30, $FF  ; Enable Vibrato (00: delay in ticks, 30: cycle duration, FF: amplitude, max 1/4 step)
db $8D                 ;  Note A#   [96 ticks] 
db $CD, $02, $7F       ; Enable Pansweep (02: delay in ticks, 7F: cycle duration)
db $A8                 ;  Note Tie  [192 ticks] 
db $C5, $60, $00       ; Set Voice Volume w/ Envelope (00: volume, 60: envelope duration)
db $7F                 ;  Note A    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_88_A:       ; Voice A: Diffuser	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $BE                 ;  Note Rest [16 ticks] 
db $E2, $06            ; Loop Start (loop 06+1 times)
db $85                 ;  Note A    [24 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_88_B:       ; Voice B: Diffuser	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $C8, $18, $01       ; Change Pitch w/ Envelope (18: envelope duration, 01: change in pitch, signed)
db $7E                 ;  Note A    [192 ticks] 
db $AF                 ;  Note Tie  [24 ticks] 
db $C8, $30, $CD       ; Change Pitch w/ Envelope (30: envelope duration, CD: change in pitch, signed)
db $AF                 ;  Note Tie  [24 ticks] 
db $EB                 ; End of Script

SFX_Script_89_A:       ; Voice A: Burning House falling apart	

db $D4                 ; Enable Echo
db $D6, $02            ; Set Octave to 02
db $00                 ;  Note C    [192 ticks] 
db $B1                 ;  Note Tie  [12 ticks] 
db $EB                 ; End of Script

SFX_Script_89_B:       ; Voice B: Burning House falling apart	

db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $E2, $02            ; Loop Start (loop 02+1 times)
db $CF, $12            ; Set Noise Clock (00-1F)
db $07                 ;  Note C    [24 ticks] 
db $CF, $0E            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $05                 ;  Note C    [32 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_8A_A:       ; Voice A: AutoCrossbow(on hit)	

db $C2                 ;  Note Rest [4 ticks] 
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $1A            ; Set ADSR Release Value (0-31)
db $8B                 ;  Note A    [3 ticks] 
db $08                 ;  Note C    [16 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $EB                 ; End of Script

SFX_Script_8A_B:       ; Voice B: AutoCrossbow(on hit)	

db $D6, $0B            ; Set Octave to 0B
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $51                 ;  Note F    [6 ticks] 
db $A3                 ;  Note B    [12 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $EB                 ; End of Script

SFX_Script_8B_A:       ; Voice A: Claw Slash	

db $D6, $0A            ; Set Octave to 0A
db $C9, $00, $01, $FF  ; Enable Vibrato (00: delay in ticks, 01: cycle duration, FF: amplitude, max 1/4 step)
db $C8, $0C, $4B       ; Change Pitch w/ Envelope (0C: envelope duration, 4B: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_8B_B:       ; Voice B: Claw Slash	

db $D0                 ; Enable Noise
db $CF, $1A            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $CF, $10            ; Set Noise Clock (00-1F)
db $0C                 ;  Note C    [4 ticks] 
db $CF, $1C            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $EB                 ; End of Script

SFX_Script_8C_A:       ; Voice A: Generic rod hit	

db $DB, $01            ; Set Detune

SFX_Script_8C_B:       ; Voice B: Generic rod hit	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $C8, $E4, $01       ; Change Pitch w/ Envelope (E4: envelope duration, 01: change in pitch, signed)
db $CD, $05, $74       ; Enable Pansweep (05: delay in ticks, 74: cycle duration)
db $81                 ;  Note A    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_8D_A:       ; Voice A: Cards	

db $DB, $E8            ; Set Detune

SFX_Script_8D_B:       ; Voice B: Cards	

db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $E0, $18            ; Set ADSR Release Value (0-31)
db $99                 ;  Note A#   [3 ticks] 
db $CB, $00, $06, $BF  ; Enable Tremolo (00: delay in ticks, 06: cycle duration, BF: amplitude, max 50%)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $D4                 ; Enable Echo
db $9D                 ;  Note B    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_8E_A:       ; Voice A: Cards	

db $DC, $07            ; Set Instrument
db $E2, $03            ; Loop Start (loop 03+1 times)
db $0C                 ;  Note C    [4 ticks] 
db $C3                 ;  Note Rest [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_8E_B:       ; Voice B: Cards	

db $D6, $09            ; Set Octave to 09
db $E2, $03            ; Loop Start (loop 03+1 times)
db $0C                 ;  Note C    [4 ticks] 
db $C3                 ;  Note Rest [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_8F_A:       ; Voice A: Confuser	

db $DB, $03            ; Set Detune

SFX_Script_8F_B:       ; Voice B: Confuser	

db $DC, $00            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $C8, $40, $FD       ; Change Pitch w/ Envelope (40: envelope duration, FD: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $AF                 ;  Note Tie  [24 ticks] 
db $EB                 ; End of Script

SFX_Script_90_A:       ; Voice A: Magitek Missile	

db $DB, $01            ; Set Detune

SFX_Script_90_B:       ; Voice B: Magitek Missile	

db $D6, $02            ; Set Octave to 02
db $E2, $08            ; Loop Start (loop 08+1 times)
db $0D                 ;  Note C    [3 ticks] 
db $E3                 ; Loop End
db $EA, $1C            ; Play Game Sound Effect (voice B)

SFX_Script_91_A:       ; Voice A: Needle attacks, like Blow Fish	

db $DB, $74            ; Set Detune

SFX_Script_91_B:       ; Voice B: Needle attacks, like Blow Fish	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $05            ; Set Octave to 05
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $1D            ; Set ADSR Release Value (0-31)
db $E2, $07            ; Loop Start (loop 07+1 times)
db $0B                 ;  Note C    [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_92_A:       ; Voice A: Phantom Train Whistle	

db $DB, $6D            ; Set Detune

SFX_Script_92_B:       ; Voice B: Phantom Train Whistle	

db $D4                 ; Enable Echo
db $D6, $04            ; Set Octave to 04
db $DC, $03            ; Set Instrument
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $CB, $00, $02, $BF  ; Enable Tremolo (00: delay in ticks, 02: cycle duration, BF: amplitude, max 50%)
db $88                 ;  Note A    [8 ticks] 
db $C8, $05, $01       ; Change Pitch w/ Envelope (05: envelope duration, 01: change in pitch, signed)
db $A8                 ;  Note Tie  [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_93_A:       ; Voice A: Stone (Part 1)	

db $DB, $59            ; Set Detune

SFX_Script_93_B:       ; Voice B: Stone (Part 1)	

db $C4, $50            ; Set Voice Volume to 50 (00-7F)
db $D6, $01            ; Set Octave to 01
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $E2, $02            ; Loop Start (loop 02+1 times)
db $4E                 ;  Note F    [16 ticks] 
db $C2                 ;  Note Rest [4 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_94_A:       ; Voice A: Generic Dagger hit/Shuriken hit	

db $D0                 ; Enable Noise
db $CF, $11            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $CF, $1A            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_94_B:       ; Voice B: Generic Dagger hit/Shuriken hit	

db $D6, $0A            ; Set Octave to 0A
db $C8, $2C, $28       ; Change Pitch w/ Envelope (2C: envelope duration, 28: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_95_A:       ; Voice A: Net	

db $DB, $40            ; Set Detune

SFX_Script_95_B:       ; Voice B: Net	

db $DC, $02            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $E2, $04            ; Loop Start (loop 04+1 times)
db $C8, $20, $11       ; Change Pitch w/ Envelope (20: envelope duration, 11: change in pitch, signed)
db $42                 ;  Note E    [8 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_96_A:       ; Voice A: Switch hitting noise	

db $DC, $07            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $E0, $1E            ; Set ADSR Release Value (0-31)
db $35                 ;  Note D#   [6 ticks] 
db $D8                 ; Decrement Octave
db $0B                 ;  Note C    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_96_B:       ; Voice B: Switch hitting noise	

db $D6, $0A            ; Set Octave to 0A
db $E0, $1E            ; Set ADSR Release Value (0-31)
db $35                 ;  Note D#   [6 ticks] 
db $D8                 ; Decrement Octave
db $0B                 ;  Note C    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_97_A:       ; Voice A: Dog Barking	

db $C4, $20            ; Set Voice Volume to 20 (00-7F)
db $CF, $10            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_97_B:       ; Voice B: Dog Barking	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $03            ; Set Instrument
db $C8, $03, $1C       ; Change Pitch w/ Envelope (03: envelope duration, 1C: change in pitch, signed)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $6E                 ;  Note G    [4 ticks] 
db $D2                 ; Enable Pitch Modulation
db $B4                 ;  Note Tie  [4 ticks] 
db $E0, $1A            ; Set ADSR Release Value (0-31)
db $C8, $03, $EF       ; Change Pitch w/ Envelope (03: envelope duration, EF: change in pitch, signed)
db $B3                 ;  Note Tie  [6 ticks] 
db $EB                 ; End of Script

SFX_Script_98_A:       ; Voice A: Noise made when bridges change in Cave to the Sealed Gate/Chest moving in Cyan's dream	

db $D4                 ; Enable Echo
db $DB, $00            ; Set Detune

SFX_Script_98_B:       ; Voice B: Noise made when bridges change in Cave to the Sealed Gate/Chest moving in Cyan's dream	

db $EA, $78            ; Play Game Sound Effect (voice B)

SFX_Script_99_A:       ; Voice A: Same as 98, but further away	

db $C2                 ;  Note Rest [4 ticks] 
db $DB, $01            ; Set Detune

SFX_Script_99_B:       ; Voice B: Same as 98, but further away	

db $D4                 ; Enable Echo
db $C4, $20            ; Set Voice Volume to 20 (00-7F)
db $EA, $78            ; Play Game Sound Effect (voice B)

SFX_Script_9A_A:       ; Voice A: Ground breaking	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $02            ; Set Octave to 02
db $E0, $1C            ; Set ADSR Release Value (0-31)
db $6B                 ;  Note G    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_9B_A:       ; Voice A: Shock Wave (Part 1)	

db $D0                 ; Enable Noise
db $D4                 ; Enable Echo
db $C5, $30, $6B       ; Set Voice Volume w/ Envelope (6B: volume, 30: envelope duration)
db $CF, $1D            ; Set Noise Clock (00-1F)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $E2, $09            ; Loop Start (loop 09+1 times)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_9C_A:       ; Voice A: Atomic Ray (Part 1)	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $0F            ; Set Octave to 0F
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $20, $B5       ; Change Pitch w/ Envelope (20: envelope duration, B5: change in pitch, signed)
db $08                 ;  Note C    [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_9C_B:       ; Voice B: Atomic Ray (Part 1)	

db $D4                 ; Enable Echo
db $D6, $12            ; Set Octave to 12
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $E2, $03            ; Loop Start (loop 03+1 times)
db $08                 ;  Note C    [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_9D_A:       ; Voice A: Step Mine (Part 1)	

db $DB, $0C            ; Set Detune

SFX_Script_9D_B:       ; Voice B: Step Mine (Part 1)	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $E2, $03            ; Loop Start (loop 03+1 times)
db $C8, $0C, $D8       ; Change Pitch w/ Envelope (0C: envelope duration, D8: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $C8, $FF, $16       ; Change Pitch w/ Envelope (FF: envelope duration, 16: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_9E_A:       ; Voice A: Regen/Antidote/etc.	

db $DB, $04            ; Set Detune

SFX_Script_9E_B:       ; Voice B: Regen/Antidote/etc.	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $CB, $00, $04, $7F  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, 7F: amplitude, max 50%)
db $E2, $0C            ; Loop Start (loop 0C+1 times)
db $88                 ;  Note A    [8 ticks] 
db $87                 ;  Note A    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_9F_A:       ; Voice A: Flash	

db $C4, $60            ; Set Voice Volume to 60 (00-7F)
db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $0A            ; Set Octave to 0A
db $C8, $01, $23       ; Change Pitch w/ Envelope (01: envelope duration, 23: change in pitch, signed)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_9F_B:       ; Voice B: Flash	

db $C3                 ;  Note Rest [3 ticks] 
db $EA, $5C            ; Play Game Sound Effect (voice B)

SFX_Script_A0_A:       ; Voice A: Shield Block	

db $DC, $03            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C9, $00, $06, $5C  ; Enable Vibrato (00: delay in ticks, 06: cycle duration, 5C: amplitude, max 1/4 step)
db $E0, $14            ; Set ADSR Release Value (0-31)
db $90                 ;  Note A#   [48 ticks] 
db $EB                 ; End of Script

SFX_Script_A0_B:       ; Voice B: Shield Block	

db $D2                 ; Enable Pitch Modulation
db $E9, $A0            ; Play Game Sound Effect (voice A)

SFX_Script_A1_A:       ; Voice A: Imp Song	

db $C4, $4F            ; Set Voice Volume to 4F (00-7F)
db $EA, $07            ; Play Game Sound Effect (voice B)

SFX_Script_A1_B:       ; Voice B: Imp Song	

db $C4, $78            ; Set Voice Volume to 78 (00-7F)
db $D4                 ; Enable Echo
db $BF                 ;  Note Rest [12 ticks] 
db $DC, $06            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E2, $02            ; Loop Start (loop 02+1 times)
db $6A                 ;  Note G    [16 ticks] 
db $24                 ;  Note D    [16 ticks] 
db $4E                 ;  Note F    [16 ticks] 
db $DA, $1A            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_A2_A:       ; Voice A: Gravity Bomb	

db $D4                 ; Enable Echo
db $B7                 ;  Note Rest [96 ticks] 
db $E2, $0E            ; Loop Start (loop 0E+1 times)
db $C8, $0C, $14       ; Change Pitch w/ Envelope (0C: envelope duration, 14: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_A2_B:       ; Voice B: Gravity Bomb	

db $D4                 ; Enable Echo
db $E9, $89            ; Play Game Sound Effect (voice A)

SFX_Script_A3_A:       ; Voice A: Blaster	

db $D4                 ; Enable Echo
db $DC, $01            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $C8, $18, $2C       ; Change Pitch w/ Envelope (18: envelope duration, 2C: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_A3_B:       ; Voice B: Blaster	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $0F            ; Set Octave to 0F
db $C8, $30, $F9       ; Change Pitch w/ Envelope (30: envelope duration, F9: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_A4_A:       ; Voice A: Generic Sword Slash	

db $C3                 ;  Note Rest [3 ticks] 
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $12            ; Set Octave to 12
db $CB, $00, $04, $73  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, 73: amplitude, max 50%)
db $C9, $00, $05, $B1  ; Enable Vibrato (00: delay in ticks, 05: cycle duration, B1: amplitude, max 1/4 step)
db $C8, $16, $CF       ; Change Pitch w/ Envelope (16: envelope duration, CF: change in pitch, signed)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_A4_B:       ; Voice B: Generic Sword Slash	

db $D0                 ; Enable Noise
db $CF, $1C            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $CF, $12            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $CF, $1A            ; Set Noise Clock (00-1F)
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_A5_A:       ; Voice A: Earthquake	

db $CF, $12            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $CD, $00, $78       ; Enable Pansweep (00: delay in ticks, 78: cycle duration)
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $46                 ;  Note F    [192 ticks] 
db $E2, $00            ; Loop Start (loop 00+1 times)
db $A8                 ;  Note Tie  [192 ticks] 
db $E3                 ; Loop End

SFX_Script_A5_B:       ; Voice B: Earthquake	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $01            ; Set Octave to 01
db $DC, $07            ; Set Instrument
db $DD, $07            ; Set ADSR Attack Value (0-15)
db $3F                 ;  Note E    [24 ticks] 
db $E2, $00            ; Loop Start (loop 00+1 times)
db $A8                 ;  Note Tie  [192 ticks] 
db $E3                 ; Loop End

SFX_Script_A6_A:       ; Voice A: Open treasure chest / Switch	

db $DB, $7C            ; Set Detune

SFX_Script_A6_B:       ; Voice B: Open treasure chest / Switch	

db $DC, $07            ; Set Instrument
db $E0, $1A            ; Set ADSR Release Value (0-31)
db $27                 ;  Note D    [6 ticks] 
db $A5                 ;  Note B    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_A7_A:       ; Voice A: ?	

db $DC, $05            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $E2, $00            ; Loop Start (loop 00+1 times)
db $C8, $10, $3B       ; Change Pitch w/ Envelope (10: envelope duration, 3B: change in pitch, signed)
db $6E                 ;  Note G    [4 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $C8, $10, $3B       ; Change Pitch w/ Envelope (10: envelope duration, 3B: change in pitch, signed)
db $0D                 ;  Note C    [3 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $E3                 ; Loop End

SFX_Script_A8_A:       ; Voice A: Generic spear hit	

db $D6, $04            ; Set Octave to 04
db $A7                 ;  Note B    [3 ticks] 
db $C8, $08, $AC       ; Change Pitch w/ Envelope (08: envelope duration, AC: change in pitch, signed)
db $50                 ;  Note F    [8 ticks] 
db $E0, $17            ; Set ADSR Release Value (0-31)
db $C8, $14, $C1       ; Change Pitch w/ Envelope (14: envelope duration, C1: change in pitch, signed)
db $A1                 ;  Note B    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_A8_B:       ; Voice B: Generic spear hit	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $06            ; Set Instrument
db $D6, $09            ; Set Octave to 09
db $D2                 ; Enable Pitch Modulation
db $5E                 ;  Note F#   [8 ticks] 
db $E0, $14            ; Set ADSR Release Value (0-31)
db $C8, $09, $E8       ; Change Pitch w/ Envelope (09: envelope duration, E8: change in pitch, signed)
db $A1                 ;  Note B    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_A9_A:       ; Voice A: Umaro's body slam	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $01            ; Set Octave to 01
db $A5                 ;  Note B    [6 ticks] 
db $D7                 ; Increment Octave
db $6B                 ;  Note G    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_A9_B:       ; Voice B: Umaro's body slam	

db $C4, $24            ; Set Voice Volume to 24 (00-7F)
db $D0                 ; Enable Noise
db $CF, $0E            ; Set Noise Clock (00-1F)
db $19                 ;  Note C#   [6 ticks] 
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_AA_A:       ; Voice A:     ???

db $BE                 ;  Note Rest [16 ticks] 
db $E9, $7D            ; Play Game Sound Effect (voice A)

SFX_Script_AA_B:       ; Voice B:     ???

db $EA, $23            ; Play Game Sound Effect (voice B)

SFX_Script_AB_A:       ; Voice A:     ???

db $E9, $64            ; Play Game Sound Effect (voice A)

SFX_Script_AB_B:       ; Voice B:     ???

db $B8                 ;  Note Rest [64 ticks] 
db $EA, $89            ; Play Game Sound Effect (voice B)

SFX_Script_AC_A:       ; Voice A:     ???

db $D4                 ; Enable Echo
db $E9, $A4            ; Play Game Sound Effect (voice A)

SFX_Script_AC_B:       ; Voice B:     ???

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $0C            ; Set Octave to 0C
db $CB, $00, $01, $7F  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, 7F: amplitude, max 50%)
db $35                 ;  Note D#   [6 ticks] 
db $C8, $04, $36       ; Change Pitch w/ Envelope (04: envelope duration, 36: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_AD_A:       ; Voice A:     ???

db $DB, $03            ; Set Detune

SFX_Script_AD_B:       ; Voice B:     ???

db $E8, $04            ; Add to Note Duration (04 = duration in ticks)
db $EA, $8F            ; Play Game Sound Effect (voice B)

SFX_Script_AE_A:       ; Voice A:     ???

db $D4                 ; Enable Echo
db $D6, $17            ; Set Octave to 17
db $CB, $00, $06, $FF  ; Enable Tremolo (00: delay in ticks, 06: cycle duration, FF: amplitude, max 50%)
db $C8, $FF, $7A       ; Change Pitch w/ Envelope (FF: envelope duration, 7A: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_AE_B:       ; Voice B:     ???

db $E2, $03            ; Loop Start (loop 03+1 times)
db $EA, $E2            ; Play Game Sound Effect (voice B)

SFX_Script_AF_A:       ; Voice A:     ???

db $D6, $0A            ; Set Octave to 0A
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $C8, $10, $1E       ; Change Pitch w/ Envelope (10: envelope duration, 1E: change in pitch, signed)
db $09                 ;  Note C    [12 ticks] 
db $C8, $14, $0F       ; Change Pitch w/ Envelope (14: envelope duration, 0F: change in pitch, signed)
db $A4                 ;  Note B    [8 ticks] 
db $EB                 ; End of Script

SFX_Script_B0_B:       ; Voice B: Force Field	

db $E8, $90            ; Add to Note Duration (90 = duration in ticks)
db $E9, $50            ; Play Game Sound Effect (voice A)

SFX_Script_B1_A:       ; Voice A: Part of Blizzard (enemy attack)	

db $D4                 ; Enable Echo
db $D6, $02            ; Set Octave to 02
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $01                 ;  Note C    [96 ticks] 
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_B1_B:       ; Voice B: Part of Blizzard (enemy attack)	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $E2, $01            ; Loop Start (loop 01+1 times)
db $89                 ;  Note A    [6 ticks] 
db $89                 ;  Note A    [6 ticks] 
db $89                 ;  Note A    [6 ticks] 
db $85                 ;  Note A    [24 ticks] 
db $E3                 ; Loop End
db $E2, $04            ; Loop Start (loop 04+1 times)
db $0A                 ;  Note C    [8 ticks] 
db $DA, $02            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_B2_A:       ; Voice A: Mind Blast	

db $B6                 ;  Note Rest [192 ticks] 
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $D4                 ; Enable Echo
db $CD, $00, $80       ; Enable Pansweep (00: delay in ticks, 80: cycle duration)
db $D6, $08            ; Set Octave to 08
db $38                 ;  Note E    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $0A            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_B2_B:       ; Voice B: Mind Blast	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C9, $00, $34, $FF  ; Enable Vibrato (00: delay in ticks, 34: cycle duration, FF: amplitude, max 1/4 step)
db $8C                 ;  Note A#   [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $AC                 ;  Note Tie  [48 ticks] 
db $CA                 ; Disable Vibrato
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $D0                 ; Enable Noise
db $CF, $1F            ; Set Noise Clock (00-1F)
db $1C                 ;  Note D    [192 ticks] 
db $E0, $11            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_B3_A:       ; Voice A: Tritoch zapping Terra (1st battle cutscene)	

db $DB, $01            ; Set Detune

SFX_Script_B3_B:       ; Voice B: Tritoch zapping Terra (1st battle cutscene)	

db $E8, $68            ; Add to Note Duration (68 = duration in ticks)
db $CD, $02, $70       ; Enable Pansweep (02: delay in ticks, 70: cycle duration)
db $EA, $51            ; Play Game Sound Effect (voice B)

SFX_Script_B4_A:       ; Voice A: Southern Cross	

db $DB, $06            ; Set Detune

SFX_Script_B4_B:       ; Voice B: Southern Cross	

db $D4                 ; Enable Echo
db $BF                 ;  Note Rest [12 ticks] 
db $D6, $01            ; Set Octave to 01
db $CD, $30, $C0       ; Enable Pansweep (30: delay in ticks, C0: cycle duration)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E2, $02            ; Loop Start (loop 02+1 times)
db $C8, $30, $24       ; Change Pitch w/ Envelope (30: envelope duration, 24: change in pitch, signed)
db $04                 ;  Note C    [48 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $E3                 ; Loop End
db $D8                 ; Decrement Octave
db $CE                 ; Disable Pansweep
db $C8, $C4, $5C       ; Change Pitch w/ Envelope (C4: envelope duration, 5C: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AA                 ;  Note Tie  [64 ticks] 
db $EB                 ; End of Script

SFX_Script_B5_A:       ; Voice A: Landing on the floor (after someone jumps)	

db $D6, $05            ; Set Octave to 05
db $C8, $04, $DC       ; Change Pitch w/ Envelope (04: envelope duration, DC: change in pitch, signed)
db $6D                 ;  Note G    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_B5_B:       ; Voice B: Landing on the floor (after someone jumps)	

db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $C8, $03, $DE       ; Change Pitch w/ Envelope (03: envelope duration, DE: change in pitch, signed)
db $6D                 ;  Note G    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_B6_A:       ; Voice A: Will of the wisp sound	

db $D4                 ; Enable Echo
db $EA, $7A            ; Play Game Sound Effect (voice B)

SFX_Script_B6_B:       ; Voice B: Will of the wisp sound	

db $B7                 ;  Note Rest [96 ticks] 
db $AC                 ;  Note Tie  [48 ticks] 
db $E9, $32            ; Play Game Sound Effect (voice A)

SFX_Script_B7_A:       ; Voice A: Flare Star	

db $D0                 ; Enable Noise
db $CF, $16            ; Set Noise Clock (00-1F)
db $E0, $0B            ; Set ADSR Release Value (0-31)
db $01                 ;  Note C    [96 ticks] 
db $CF, $13            ; Set Noise Clock (00-1F)
db $E9, $A2            ; Play Game Sound Effect (voice A)

SFX_Script_B7_B:       ; Voice B: Flare Star	

db $EA, $3A            ; Play Game Sound Effect (voice B)

SFX_Script_B8_A:       ; Voice A: Whistle	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D6, $0A            ; Set Octave to 0A
db $DF, $03            ; Set ADSR Sustain Value (0-7)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_B8_B:       ; Voice B: Whistle	

db $D2                 ; Enable Pitch Modulation
db $DC, $05            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $C8, $0C, $13       ; Change Pitch w/ Envelope (0C: envelope duration, 13: change in pitch, signed)
db $26                 ;  Note D    [8 ticks] 
db $C8, $0E, $F7       ; Change Pitch w/ Envelope (0E: envelope duration, F7: change in pitch, signed)
db $B0                 ;  Note Tie  [16 ticks] 
db $C8, $23, $11       ; Change Pitch w/ Envelope (23: envelope duration, 11: change in pitch, signed)
db $B0                 ;  Note Tie  [16 ticks] 
db $EB                 ; End of Script

SFX_Script_B9_A:       ; Voice A: Terra leaving after she first transforms	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $CF, $15            ; Set Noise Clock (00-1F)
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $E0, $08            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_B9_B:       ; Voice B: Terra leaving after she first transforms	

db $DC, $03            ; Set Instrument
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D6, $04            ; Set Octave to 04
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $C8, $12, $22       ; Change Pitch w/ Envelope (12: envelope duration, 22: change in pitch, signed)
db $5D                 ;  Note F#   [12 ticks] 
db $D2                 ; Enable Pitch Modulation
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $15            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_BA_A:       ; Voice A: Falling Down	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $DC, $07            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $07                 ;  Note C    [24 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_BA_B:       ; Voice B: Falling Down	

db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $DD, $04            ; Set ADSR Attack Value (0-15)
db $93                 ;  Note A#   [24 ticks] 
db $C8, $FF, $EE       ; Change Pitch w/ Envelope (FF: envelope duration, EE: change in pitch, signed)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_BB_A:       ; Voice A: Stepping on large floor switches (Ebot's Rock, Kefka's Tower, Phoenix Cave)	

db $CF, $12            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $0A                 ;  Note C    [8 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_BC_A:       ; Voice A: Revenge	

db $D0                 ; Enable Noise
db $E2, $02            ; Loop Start (loop 02+1 times)
db $CF, $12            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $CF, $1A            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_BD_A:       ; Voice A: Maduin	

db $DB, $00            ; Set Detune

SFX_Script_BD_B:       ; Voice B: Maduin	

db $D4                 ; Enable Echo
db $CD, $14, $48       ; Enable Pansweep (14: delay in ticks, 48: cycle duration)
db $D6, $0A            ; Set Octave to 0A
db $C9, $00, $5C, $7F  ; Enable Vibrato (00: delay in ticks, 5C: cycle duration, 7F: amplitude, max 1/4 step)
db $00                 ;  Note C    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_BE_A:       ; Voice A: Enemy being cut in half	

db $E8, $12            ; Add to Note Duration (12 = duration in ticks)
db $BE                 ;  Note Rest [16 ticks] 
db $D4                 ; Enable Echo
db $D6, $07            ; Set Octave to 07
db $DC, $02            ; Set Instrument
db $CD, $0E, $7C       ; Enable Pansweep (0E: delay in ticks, 7C: cycle duration)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $46                 ;  Note F    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_BE_B:       ; Voice B: Enemy being cut in half	

db $C4, $12            ; Set Voice Volume to 12 (00-7F)
db $D4                 ; Enable Echo
db $CD, $1B, $B8       ; Enable Pansweep (1B: delay in ticks, B8: cycle duration)
db $C8, $10, $2F       ; Change Pitch w/ Envelope (10: envelope duration, 2F: change in pitch, signed)
db $D6, $04            ; Set Octave to 04
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $0A                 ;  Note C    [8 ticks] 
db $D5                 ; Disable Echo
db $C5, $06, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 06: envelope duration)
db $C8, $09, $A6       ; Change Pitch w/ Envelope (09: envelope duration, A6: change in pitch, signed)
db $B1                 ;  Note Tie  [12 ticks] 
db $E1                 ; Reset ADSR Default Values
db $D2                 ; Enable Pitch Modulation
db $D6, $0A            ; Set Octave to 0A
db $E0, $15            ; Set ADSR Release Value (0-31)
db $55                 ;  Note F#   [96 ticks] 
db $EB                 ; End of Script

SFX_Script_BF_A:       ; Voice A: Buy/Sell sound used in shops	

db $BB                 ;  Note Rest [32 ticks] 
db $E9, $47            ; Play Game Sound Effect (voice A)

SFX_Script_BF_B:       ; Voice B: Buy/Sell sound used in shops	

db $D0                 ; Enable Noise
db $CF, $1D            ; Set Noise Clock (00-1F)
db $E2, $03            ; Loop Start (loop 03+1 times)
db $50                 ;  Note F    [8 ticks] 
db $E3                 ; Loop End
db $D1                 ; Disable Noise
db $EA, $47            ; Play Game Sound Effect (voice B)

SFX_Script_C0_A:       ; Voice A: Pidgeon tweet	

db $C0                 ;  Note Rest [8 ticks] 
db $DB, $FA            ; Set Detune

SFX_Script_C0_B:       ; Voice B: Pidgeon tweet	

db $D4                 ; Enable Echo
db $DC, $05            ; Set Instrument
db $D6, $08            ; Set Octave to 08
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $C8, $10, $F7       ; Change Pitch w/ Envelope (10: envelope duration, F7: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $C8, $10, $C0       ; Change Pitch w/ Envelope (10: envelope duration, C0: change in pitch, signed)
db $0A                 ;  Note C    [8 ticks] 
db $EB                 ; End of Script

SFX_Script_C1_A:       ; Voice A: Start battle (mosaic)	

db $DC, $02            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $C8, $24, $24       ; Change Pitch w/ Envelope (24: envelope duration, 24: change in pitch, signed)
db $07                 ;  Note C    [24 ticks] 
db $C8, $48, $24       ; Change Pitch w/ Envelope (48: envelope duration, 24: change in pitch, signed)
db $2D                 ;  Note D#   [72 ticks] 
db $EB                 ; End of Script

SFX_Script_C1_B:       ; Voice B: Start battle (mosaic)	

db $CF, $16            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $07                 ;  Note C    [24 ticks] 
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_C2_A:       ; Voice A: Parry/Blocking spell	

db $DB, $13            ; Set Detune
db $E9, $A0            ; Play Game Sound Effect (voice A)

SFX_Script_C2_B:       ; Voice B: Parry/Blocking spell	

db $C8, $03, $02       ; Change Pitch w/ Envelope (03: envelope duration, 02: change in pitch, signed)
db $EA, $47            ; Play Game Sound Effect (voice B)

SFX_Script_C3_A:       ; Voice A: When you first meet Esper Terra in Zozo she runs around and makes this noise a few times	

db $D0                 ; Enable Noise
db $CF, $12            ; Set Noise Clock (00-1F)
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $CB, $00, $09, $7F  ; Enable Tremolo (00: delay in ticks, 09: cycle duration, 7F: amplitude, max 50%)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $03                 ;  Note C    [72 ticks] 
db $EB                 ; End of Script

SFX_Script_C3_B:       ; Voice B: When you first meet Esper Terra in Zozo she runs around and makes this noise a few times	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $D2                 ; Enable Pitch Modulation
db $DC, $06            ; Set Instrument
db $CB, $00, $02, $BF  ; Enable Tremolo (00: delay in ticks, 02: cycle duration, BF: amplitude, max 50%)
db $D6, $01            ; Set Octave to 01
db $C8, $0B, $02       ; Change Pitch w/ Envelope (0B: envelope duration, 02: change in pitch, signed)
db $A0                 ;  Note B    [36 ticks] 
db $C8, $7F, $F3       ; Change Pitch w/ Envelope (7F: envelope duration, F3: change in pitch, signed)
db $AE                 ;  Note Tie  [36 ticks] 
db $EB                 ; End of Script

SFX_Script_C4_A:       ; Voice A: Espers transforming themselves into Magicite	

db $DB, $03            ; Set Detune

SFX_Script_C4_B:       ; Voice B: Espers transforming themselves into Magicite	

db $D4                 ; Enable Echo
db $C8, $D0, $38       ; Change Pitch w/ Envelope (D0: envelope duration, 38: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $E0, $10            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_C5_A:       ; Voice A: Curing somebody in the menu	

db $D4                 ; Enable Echo
db $DB, $05            ; Set Detune
db $E9, $EE            ; Play Game Sound Effect (voice A)

SFX_Script_C5_B:       ; Voice B: Curing somebody in the menu	

db $C4, $58            ; Set Voice Volume to 58 (00-7F)
db $E9, $EE            ; Play Game Sound Effect (voice A)

SFX_Script_C6_A:       ; Voice A: Blitz noise	

db $D6, $07            ; Set Octave to 07
db $DD, $05            ; Set ADSR Attack Value (0-15)
db $DF, $00            ; Set ADSR Sustain Value (0-7)
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $E8, $84            ; Add to Note Duration (84 = duration in ticks)
db $72                 ;  Note G#   [64 ticks] 
db $EB                 ; End of Script

SFX_Script_C6_B:       ; Voice B: Blitz noise	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $BC                 ;  Note Rest [36 ticks] 
db $D2                 ; Enable Pitch Modulation
db $EA, $8D            ; Play Game Sound Effect (voice B)

SFX_Script_C7_A:       ; Voice A: Fell hard on the floor	

db $D8                 ; Decrement Octave
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $19                 ;  Note C#   [6 ticks] 
db $E0, $19            ; Set ADSR Release Value (0-31)
db $C8, $08, $03       ; Change Pitch w/ Envelope (08: envelope duration, 03: change in pitch, signed)
db $85                 ;  Note A    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_C7_B:       ; Voice B: Fell hard on the floor	

db $D2                 ; Enable Pitch Modulation
db $D8                 ; Decrement Octave
db $DD, $09            ; Set ADSR Attack Value (0-15)
db $0B                 ;  Note C    [6 ticks] 
db $E0, $19            ; Set ADSR Release Value (0-31)
db $C8, $08, $03       ; Change Pitch w/ Envelope (08: envelope duration, 03: change in pitch, signed)
db $A1                 ;  Note B    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_C8_A:       ; Voice A: Funny little whistle sound	

db $DC, $20            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $5D                 ;  Note F#   [12 ticks] 
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $C8, $13, $0A       ; Change Pitch w/ Envelope (13: envelope duration, 0A: change in pitch, signed)
db $58                 ;  Note F#   [48 ticks] 
db $EB                 ; End of Script

SFX_Script_C9_A:       ; Voice A: Reverse Polarity	

db $D4                 ; Enable Echo
db $E9, $9F            ; Play Game Sound Effect (voice A)

SFX_Script_C9_B:       ; Voice B: Reverse Polarity	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $C8, $40, $FD       ; Change Pitch w/ Envelope (40: envelope duration, FD: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_CA_A:       ; Voice A: Stray Cat jumping	

db $DB, $F3            ; Set Detune

SFX_Script_CA_B:       ; Voice B: Stray Cat jumping	

db $DC, $00            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $C8, $06, $24       ; Change Pitch w/ Envelope (06: envelope duration, 24: change in pitch, signed)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_CB_A:       ; Voice A: Curaga (Part 2)	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $E9, $8D            ; Play Game Sound Effect (voice A)

SFX_Script_CB_B:       ; Voice B: Curaga (Part 2)	

db $EA, $7D            ; Play Game Sound Effect (voice B)

SFX_Script_CC_A:       ; Voice A: Noise plays when you “catch” the glimmering light at the security checkpoint	

db $D0                 ; Enable Noise
db $CF, $1D            ; Set Noise Clock (00-1F)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $0D                 ;  Note C    [3 ticks] 
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_CC_B:       ; Voice B: Noise plays when you “catch” the glimmering light at the security checkpoint	

db $C4, $6B            ; Set Voice Volume to 6B (00-7F)
db $D6, $05            ; Set Octave to 05
db $D4                 ; Enable Echo
db $DF, $03            ; Set ADSR Sustain Value (0-7)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_CD_A:       ; Voice A: Kefka's Laugh	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $CF, $13            ; Set Noise Clock (00-1F)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $77                 ;  Note G#   [24 ticks] 
db $E0, $00            ; Set ADSR Release Value (0-31)
db $0E                 ;  Note C#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_CD_B:       ; Voice B: Kefka's Laugh	

db $C4, $5A            ; Set Voice Volume to 5A (00-7F)
db $D2                 ; Enable Pitch Modulation
db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $C8, $18, $14       ; Change Pitch w/ Envelope (18: envelope duration, 14: change in pitch, signed)
db $23                 ;  Note D    [24 ticks] 
db $E0, $1B            ; Set ADSR Release Value (0-31)
db $E2, $05            ; Loop Start (loop 05+1 times)
db $C8, $0A, $05       ; Change Pitch w/ Envelope (0A: envelope duration, 05: change in pitch, signed)
db $A3                 ;  Note B    [12 ticks] 
db $BF                 ;  Note Rest [12 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_CE_A:       ; Voice A: Splash	

db $D0                 ; Enable Noise
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $CF, $1E            ; Set Noise Clock (00-1F)
db $0A                 ;  Note C    [8 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $CF, $19            ; Set Noise Clock (00-1F)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_CF_A:       ; Voice A: Golem	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $BE                 ;  Note Rest [16 ticks] 
db $CB, $00, $03, $BF  ; Enable Tremolo (00: delay in ticks, 03: cycle duration, BF: amplitude, max 50%)
db $DD, $0B            ; Set ADSR Attack Value (0-15)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $D6, $05            ; Set Octave to 05
db $E2, $06            ; Loop Start (loop 06+1 times)
db $4E                 ;  Note F    [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_CF_B:       ; Voice B: Golem	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $0A                 ;  Note C    [8 ticks] 
db $E0, $10            ; Set ADSR Release Value (0-31)
db $02                 ;  Note C    [64 ticks] 
db $EB                 ; End of Script

SFX_Script_D0_A:       ; Voice A: Applause and a whistle by the Opera house audience	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $C5, $60, $1B       ; Set Voice Volume w/ Envelope (1B: volume, 60: envelope duration)
db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D0                 ; Enable Noise
db $CF, $1E            ; Set Noise Clock (00-1F)
db $DF, $04            ; Set ADSR Sustain Value (0-7)
db $E6                 ; Enable Drum Roll (no key off at end of note unless the next note is a rest)
db $E2, $19            ; Loop Start (loop 19+1 times)
db $1B                 ;  Note C#   [3 ticks] 
db $E3                 ; Loop End
db $C5, $C0, $00       ; Set Voice Volume w/ Envelope (00: volume, C0: envelope duration)
db $0E                 ;  Note C#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_D0_B:       ; Voice B: Applause and a whistle by the Opera house audience	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $C5, $4C, $1B       ; Set Voice Volume w/ Envelope (1B: volume, 4C: envelope duration)
db $D2                 ; Enable Pitch Modulation
db $DC, $07            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $E0, $1E            ; Set ADSR Release Value (0-31)
db $E2, $1E            ; Loop Start (loop 1E+1 times)
db $52                 ;  Note F    [4 ticks] 
db $E3                 ; Loop End
db $EA, $B8            ; Play Game Sound Effect (voice B)

SFX_Script_D1_A:       ; Voice A: Save point ding	

db $EA, $8D            ; Play Game Sound Effect (voice B)

SFX_Script_D1_B:       ; Voice B: Save point ding	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $11            ; Set Octave to 11
db $6C                 ;  Note G    [8 ticks] 
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $66                 ;  Note G    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_D2_A:       ; Voice A: Wave Cannon	

db $B7                 ;  Note Rest [96 ticks] 
db $B9                 ;  Note Rest [72 ticks] 
db $E8, $1D            ; Add to Note Duration (1D = duration in ticks)
db $EA, $89            ; Play Game Sound Effect (voice B)

SFX_Script_D2_B:       ; Voice B: Wave Cannon	

db $D4                 ; Enable Echo
db $E8, $20            ; Add to Note Duration (20 = duration in ticks)
db $EA, $51            ; Play Game Sound Effect (voice B)

SFX_Script_D3_A:       ; Voice A: Tek Laser (Part 1)	

db $DB, $01            ; Set Detune

SFX_Script_D3_B:       ; Voice B: Tek Laser (Part 1)	

db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $06            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C8, $50, $E6       ; Change Pitch w/ Envelope (50: envelope duration, E6: change in pitch, signed)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_D4_A:       ; Voice A: Blue guy rises out of ground moves	

db $D6, $04            ; Set Octave to 04
db $DC, $03            ; Set Instrument
db $C9, $00, $20, $FF  ; Enable Vibrato (00: delay in ticks, 20: cycle duration, FF: amplitude, max 1/4 step)
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E0, $0C            ; Set ADSR Release Value (0-31)
db $70                 ;  Note G#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_D4_B:       ; Voice B: Blue guy rises out of ground moves	

db $E8, $14            ; Add to Note Duration (14 = duration in ticks)
db $EA, $63            ; Play Game Sound Effect (voice B)

SFX_Script_D5_A:       ; Voice A: Big Guard	

db $DC, $02            ; Set Instrument
db $BA                 ;  Note Rest [48 ticks] 
db $C8, $14, $34       ; Change Pitch w/ Envelope (14: envelope duration, 34: change in pitch, signed)
db $C9, $00, $05, $7F  ; Enable Vibrato (00: delay in ticks, 05: cycle duration, 7F: amplitude, max 1/4 step)
db $E8, $77            ; Add to Note Duration (77 = duration in ticks)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_D5_B:       ; Voice B: Big Guard	

db $DC, $06            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $D4                 ; Enable Echo
db $E4                 ; Enable Slur (key on at beginning of first note only, no key off at end of note unless the next note is a rest)
db $0A                 ;  Note C    [8 ticks] 
db $5D                 ;  Note F#   [12 ticks] 
db $C8, $23, $23       ; Change Pitch w/ Envelope (23: envelope duration, 23: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_D6_A:       ; Voice A: Blizzard Fist	

db $DB, $DA            ; Set Detune
db $D9, $09            ; Set Transpose
db $D6, $02            ; Set Octave to 02
db $C8, $34, $11       ; Change Pitch w/ Envelope (34: envelope duration, 11: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $C8, $80, $FC       ; Change Pitch w/ Envelope (80: envelope duration, FC: change in pitch, signed)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_D6_B:       ; Voice B: Blizzard Fist	

db $D2                 ; Enable Pitch Modulation
db $D6, $02            ; Set Octave to 02
db $C8, $34, $11       ; Change Pitch w/ Envelope (34: envelope duration, 11: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $C8, $80, $FC       ; Change Pitch w/ Envelope (80: envelope duration, FC: change in pitch, signed)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $A8                 ;  Note Tie  [192 ticks] 
db $EB                 ; End of Script

SFX_Script_D7_B:       ; Voice B: Bubble Attacks 	

db $C4, $6B            ; Set Voice Volume to 6B (00-7F)
db $DC, $03            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $18            ; Set ADSR Release Value (0-31)
db $42                 ;  Note E    [8 ticks] 
db $C8, $05, $15       ; Change Pitch w/ Envelope (05: envelope duration, 15: change in pitch, signed)
db $B2                 ;  Note Tie  [8 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_D8_A:       ; Voice A: Noiseblaster	

db $DB, $03            ; Set Detune

SFX_Script_D8_B:       ; Voice B: Noiseblaster	

db $DC, $02            ; Set Instrument
db $D6, $01            ; Set Octave to 01
db $C8, $40, $14       ; Change Pitch w/ Envelope (40: envelope duration, 14: change in pitch, signed)
db $E8, $88            ; Add to Note Duration (88 = duration in ticks)
db $8D                 ;  Note A#   [96 ticks] 
db $EB                 ; End of Script

SFX_Script_D9_A:       ; Voice A: “Wark!” “Kweh!” Chocobo chirp	

db $C5, $04, $00       ; Set Voice Volume w/ Envelope (00: volume, 04: envelope duration)
db $D0                 ; Enable Noise
db $CF, $1B            ; Set Noise Clock (00-1F)
db $E2, $04            ; Loop Start (loop 04+1 times)
db $0D                 ;  Note C    [3 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_D9_B:       ; Voice B: “Wark!” “Kweh!” Chocobo chirp	

db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $D6, $0C            ; Set Octave to 0C
db $C8, $FF, $03       ; Change Pitch w/ Envelope (FF: envelope duration, 03: change in pitch, signed)
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_DA_A:       ; Voice A: Flail/Morningstar (the weapons)	

db $D0                 ; Enable Noise
db $CF, $1C            ; Set Noise Clock (00-1F)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $09                 ;  Note C    [12 ticks] 
db $E1                 ; Reset ADSR Default Values
db $CF, $1D            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $E0, $16            ; Set ADSR Release Value (0-31)
db $CF, $13            ; Set Noise Clock (00-1F)
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_DA_B:       ; Voice B: Flail/Morningstar (the weapons)	

db $D7                 ; Increment Octave
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E0, $16            ; Set ADSR Release Value (0-31)
db $09                 ;  Note C    [12 ticks] 
db $DC, $07            ; Set Instrument
db $D6, $12            ; Set Octave to 12
db $0B                 ;  Note C    [6 ticks] 
db $E0, $16            ; Set ADSR Release Value (0-31)
db $C8, $0F, $4E       ; Change Pitch w/ Envelope (0F: envelope duration, 4E: change in pitch, signed)
db $B0                 ;  Note Tie  [16 ticks] 
db $EB                 ; End of Script

SFX_Script_DB_A:       ; Voice A: A blunt impact	

db $C4, $68            ; Set Voice Volume to 68 (00-7F)
db $D0                 ; Enable Noise
db $CF, $10            ; Set Noise Clock (00-1F)
db $E0, $17            ; Set ADSR Release Value (0-31)
db $04                 ;  Note C    [48 ticks] 
db $EB                 ; End of Script

SFX_Script_DB_B:       ; Voice B: A blunt impact	

db $D4                 ; Enable Echo
db $DC, $02            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $E0, $1C            ; Set ADSR Release Value (0-31)
db $5E                 ;  Note F#   [8 ticks] 
db $E0, $17            ; Set ADSR Release Value (0-31)
db $C8, $03, $05       ; Change Pitch w/ Envelope (03: envelope duration, 05: change in pitch, signed)
db $0B                 ;  Note C    [6 ticks] 
db $C8, $07, $FB       ; Change Pitch w/ Envelope (07: envelope duration, FB: change in pitch, signed)
db $B2                 ;  Note Tie  [8 ticks] 
db $EB                 ; End of Script

SFX_Script_DC_A:       ; Voice A: Dance (Part 1)	

db $DB, $FB            ; Set Detune

SFX_Script_DC_B:       ; Voice B: Dance (Part 1)	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $03            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $C8, $0C, $31       ; Change Pitch w/ Envelope (0C: envelope duration, 31: change in pitch, signed)
db $E0, $19            ; Set ADSR Release Value (0-31)
db $06                 ;  Note C    [36 ticks] 
db $EB                 ; End of Script

SFX_Script_DD_A:       ; Voice A: Plays when you fail the opera house.	

db $DF, $03            ; Set ADSR Sustain Value (0-7)
db $CF, $12            ; Set Noise Clock (00-1F)
db $E9, $E7            ; Play Game Sound Effect (voice A)

SFX_Script_DD_B:       ; Voice B: Plays when you fail the opera house.	

db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $05            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $E2, $01            ; Loop Start (loop 01+1 times)
db $C8, $0A, $0C       ; Change Pitch w/ Envelope (0A: envelope duration, 0C: change in pitch, signed)
db $93                 ;  Note A#   [24 ticks] 
db $C8, $1C, $EB       ; Change Pitch w/ Envelope (1C: envelope duration, EB: change in pitch, signed)
db $B1                 ;  Note Tie  [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_DE_A:       ; Voice A: Mine cart screeching along tracks (after Number 128)	

db $D4                 ; Enable Echo
db $CF, $12            ; Set Noise Clock (00-1F)
db $DF, $00            ; Set ADSR Sustain Value (0-7)
db $E8, $CF            ; Add to Note Duration (CF = duration in ticks)
db $E9, $E7            ; Play Game Sound Effect (voice A)
db $EB                 ; End of Script

SFX_Script_DE_B:       ; Voice B: Mine cart screeching along tracks (after Number 128)	

db $D2                 ; Enable Pitch Modulation
db $DC, $06            ; Set Instrument
db $D6, $0A            ; Set Octave to 0A
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $C8, $03, $06       ; Change Pitch w/ Envelope (03: envelope duration, 06: change in pitch, signed)
db $25                 ;  Note D    [12 ticks] 
db $C8, $03, $06       ; Change Pitch w/ Envelope (03: envelope duration, 06: change in pitch, signed)
db $1C                 ;  Note D    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_DF_A:       ; Voice A: Elevator sound	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $DC, $01            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $61                 ;  Note F#   [3 ticks] 
db $E2, $00            ; Loop Start (loop 00+1 times)
db $C8, $C0, $05       ; Change Pitch w/ Envelope (C0: envelope duration, 05: change in pitch, signed)
db $A8                 ;  Note Tie  [192 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_DF_B:       ; Voice B: Elevator sound	

db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $DC, $03            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $CB, $00, $06, $BF  ; Enable Tremolo (00: delay in ticks, 06: cycle duration, BF: amplitude, max 50%)
db $C8, $20, $18       ; Change Pitch w/ Envelope (20: envelope duration, 18: change in pitch, signed)
db $8C                 ;  Note A#   [192 ticks] 
db $E2, $00            ; Loop Start (loop 00+1 times)
db $A8                 ;  Note Tie  [192 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_E0_A:       ; Voice A: ?	

db $D0                 ; Enable Noise
db $CF, $1E            ; Set Noise Clock (00-1F)
db $DD, $0D            ; Set ADSR Attack Value (0-15)
db $E0, $1B            ; Set ADSR Release Value (0-31)
db $09                 ;  Note C    [12 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_E0_B:       ; Voice B: ?	

db $C4, $4B            ; Set Voice Volume to 4B (00-7F)
db $D2                 ; Enable Pitch Modulation
db $DC, $02            ; Set Instrument
db $D6, $01            ; Set Octave to 01
db $CB, $00, $01, $BF  ; Enable Tremolo (00: delay in ticks, 01: cycle duration, BF: amplitude, max 50%)
db $C8, $04, $18       ; Change Pitch w/ Envelope (04: envelope duration, 18: change in pitch, signed)
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $E0, $1A            ; Set ADSR Release Value (0-31)
db $09                 ;  Note C    [12 ticks] 
db $C1                 ;  Note Rest [6 ticks] 
db $4D                 ;  Note F    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_E1_A:       ; Voice A: Auction house buzzing over the 1 000 000 gil bid	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $CF, $0D            ; Set Noise Clock (00-1F)
db $E2, $00            ; Loop Start (loop 00+1 times)
db $A3                 ;  Note B    [12 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $E3                 ; Loop End

SFX_Script_E1_B:       ; Voice B: Auction house buzzing over the 1 000 000 gil bid	

db $C4, $17            ; Set Voice Volume to 17 (00-7F)
db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $CD, $24, $1C       ; Enable Pansweep (24: delay in ticks, 1C: cycle duration)
db $D6, $05            ; Set Octave to 05
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $62                 ;  Note G    [192 ticks] 
db $E2, $00            ; Loop Start (loop 00+1 times)
db $A8                 ;  Note Tie  [192 ticks] 
db $E3                 ; Loop End

SFX_Script_E2_A:       ; Voice A: Same as Raise sound effect (4B), but only plays half the length	

db $D4                 ; Enable Echo
db $DC, $06            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $CB, $00, $04, $FF  ; Enable Tremolo (00: delay in ticks, 04: cycle duration, FF: amplitude, max 50%)
db $DD, $06            ; Set ADSR Attack Value (0-15)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $C8, $01, $51       ; Change Pitch w/ Envelope (01: envelope duration, 51: change in pitch, signed)
db $06                 ;  Note C    [36 ticks] 
db $C2                 ;  Note Rest [4 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_E2_B:       ; Voice B: Same as Raise sound effect (4B), but only plays half the length	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $C9, $00, $08, $BF  ; Enable Vibrato (00: delay in ticks, 08: cycle duration, BF: amplitude, max 1/4 step)
db $D6, $07            ; Set Octave to 07
db $DB, $2B            ; Set Detune
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $E0, $1B            ; Set ADSR Release Value (0-31)
db $7C                 ;  Note G#   [4 ticks] 
db $52                 ;  Note F    [4 ticks] 
db $7A                 ;  Note G#   [8 ticks] 
db $50                 ;  Note F    [8 ticks] 
db $BE                 ;  Note Rest [16 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_E3_A:       ; Voice A: Thunder at the Sealed Gate	

db $D4                 ; Enable Echo
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D0                 ; Enable Noise
db $CF, $1A            ; Set Noise Clock (00-1F)
db $DF, $04            ; Set ADSR Sustain Value (0-7)
db $E0, $13            ; Set ADSR Release Value (0-31)
db $07                 ;  Note C    [24 ticks] 
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $E1                 ; Reset ADSR Default Values
db $CF, $10            ; Set Noise Clock (00-1F)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_E3_B:       ; Voice B: Thunder at the Sealed Gate	

db $D2                 ; Enable Pitch Modulation
db $D6, $06            ; Set Octave to 06
db $C8, $D3, $28       ; Change Pitch w/ Envelope (D3: envelope duration, 28: change in pitch, signed)
db $DF, $01            ; Set ADSR Sustain Value (0-7)
db $95                 ;  Note A#   [12 ticks] 
db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D6, $01            ; Set Octave to 01
db $C5, $10, $7F       ; Set Voice Volume w/ Envelope (7F: volume, 10: envelope duration)
db $E1                 ; Reset ADSR Default Values
db $E0, $0F            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_E4_A:       ; Voice A: Landing after jump attack	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $C5, $5C, $67       ; Set Voice Volume w/ Envelope (67: volume, 5C: envelope duration)
db $D0                 ; Enable Noise
db $CF, $1C            ; Set Noise Clock (00-1F)
db $07                 ;  Note C    [24 ticks] 
db $E0, $1D            ; Set ADSR Release Value (0-31)
db $0B                 ;  Note C    [6 ticks] 
db $0B                 ;  Note C    [6 ticks] 
db $EB                 ; End of Script

SFX_Script_E4_B:       ; Voice B: Landing after jump attack	

db $C4, $73            ; Set Voice Volume to 73 (00-7F)
db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $D2                 ; Enable Pitch Modulation
db $E2, $0C            ; Loop Start (loop 0C+1 times)
db $0D                 ;  Note C    [3 ticks] 
db $DA, $FC            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_E5_A:       ; Voice A: Revivify	

db $E9, $CB            ; Play Game Sound Effect (voice A)

SFX_Script_E5_B:       ; Voice B: Revivify	

db $BA                 ;  Note Rest [48 ticks] 
db $EA, $7D            ; Play Game Sound Effect (voice B)

SFX_Script_E6_A:       ; Voice A: Knocking on door	

db $C4, $21            ; Set Voice Volume to 21 (00-7F)
db $CF, $12            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $0B                 ;  Note C    [6 ticks] 
db $E0, $18            ; Set ADSR Release Value (0-31)
db $08                 ;  Note C    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_E6_B:       ; Voice B: Knocking on door	

db $C4, $7B            ; Set Voice Volume to 7B (00-7F)
db $D6, $02            ; Set Octave to 02
db $E0, $18            ; Set ADSR Release Value (0-31)
db $4E                 ;  Note F    [16 ticks] 
db $EB                 ; End of Script

SFX_Script_E7_A:       ; Voice A: Nothing	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_E8_A:       ; Voice A: Huge Footstep (Phunbaba's)	

db $D4                 ; Enable Echo
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $D6, $01            ; Set Octave to 01
db $43                 ;  Note E    [6 ticks] 
db $E0, $10            ; Set ADSR Release Value (0-31)
db $C8, $30, $07       ; Change Pitch w/ Envelope (30: envelope duration, 07: change in pitch, signed)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_E8_B:       ; Voice B: Huge Footstep (Phunbaba's)	

db $C4, $6B            ; Set Voice Volume to 6B (00-7F)
db $D0                 ; Enable Noise
db $CF, $13            ; Set Noise Clock (00-1F)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $E0, $10            ; Set ADSR Release Value (0-31)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_E9_A:       ; Voice A: Recovery Spring	

db $C4, $18            ; Set Voice Volume to 18 (00-7F)
db $D4                 ; Enable Echo
db $D0                 ; Enable Noise
db $CF, $1F            ; Set Noise Clock (00-1F)
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $09                 ;  Note C    [12 ticks] 
db $EB                 ; End of Script

SFX_Script_E9_B:       ; Voice B: Recovery Spring	

db $C0                 ;  Note Rest [8 ticks] 
db $D4                 ; Enable Echo
db $C4, $6C            ; Set Voice Volume to 6C (00-7F)
db $DC, $05            ; Set Instrument
db $D6, $0C            ; Set Octave to 0C
db $C9, $00, $10, $46  ; Enable Vibrato (00: delay in ticks, 10: cycle duration, 46: amplitude, max 1/4 step)
db $DD, $0C            ; Set ADSR Attack Value (0-15)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $02                 ;  Note C    [64 ticks] 
db $EB                 ; End of Script

SFX_Script_EA_A:       ; Voice A: Draining water (In Serpent Trench and Phoenix Cave)	

db $D0                 ; Enable Noise
db $CF, $1F            ; Set Noise Clock (00-1F)
db $DD, $02            ; Set ADSR Attack Value (0-15)
db $00                 ;  Note C    [192 ticks] 
db $C5, $60, $00       ; Set Voice Volume w/ Envelope (00: volume, 60: envelope duration)
db $A9                 ;  Note Tie  [96 ticks] 
db $EB                 ; End of Script

SFX_Script_EB_A:       ; Voice A: Rain	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $D0                 ; Enable Noise
db $CF, $09            ; Set Noise Clock (00-1F)
db $EA, $EB            ; Play Game Sound Effect (voice B)

SFX_Script_EB_B:       ; Voice B: Rain	

db $D4                 ; Enable Echo
db $D2                 ; Enable Pitch Modulation
db $D6, $05            ; Set Octave to 05
db $DD, $00            ; Set ADSR Attack Value (0-15)
db $9A                 ;  Note B    [192 ticks] 
db $AC                 ;  Note Tie  [48 ticks] 
db $EB                 ; End of Script

SFX_Script_EC_A:       ; Voice A: Heartbeat	

db $DB, $01            ; Set Detune

SFX_Script_EC_B:       ; Voice B: Heartbeat	

db $DC, $03            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $C8, $05, $B8       ; Change Pitch w/ Envelope (05: envelope duration, B8: change in pitch, signed)
db $25                 ;  Note D    [12 ticks] 
db $C8, $18, $60       ; Change Pitch w/ Envelope (18: envelope duration, 60: change in pitch, signed)
db $B3                 ;  Note Tie  [6 ticks] 
db $EB                 ; End of Script

SFX_Script_ED_A:       ; Voice A: Train Starting	

db $C4, $65            ; Set Voice Volume to 65 (00-7F)
db $D0                 ; Enable Noise
db $CF, $12            ; Set Noise Clock (00-1F)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $0D                 ;  Note C    [3 ticks] 
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_ED_B:       ; Voice B: Train Starting	

db $D4                 ; Enable Echo
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $DC, $20            ; Set Instrument
db $D6, $02            ; Set Octave to 02
db $E0, $0C            ; Set ADSR Release Value (0-31)
db $8B                 ;  Note A    [3 ticks] 
db $7E                 ;  Note A    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_EE_A:       ; Voice A: Cure in menu	

db $DC, $05            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $E2, $04            ; Loop Start (loop 04+1 times)
db $1A                 ;  Note C#   [4 ticks] 
db $DA, $02            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_EF_A:       ; Voice A: Boss sound	

db $D4                 ; Enable Echo
db $DB, $08            ; Set Detune

SFX_Script_EF_B:       ; Voice B: Boss sound	

db $D2                 ; Enable Pitch Modulation
db $D6, $05            ; Set Octave to 05
db $E2, $1D            ; Loop Start (loop 1D+1 times)
db $99                 ;  Note A#   [3 ticks] 
db $DA, $FE            ; Add to Transpose
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_F0_A:       ; Voice A: Distant Boom	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $C9, $00, $02, $BF  ; Enable Vibrato (00: delay in ticks, 02: cycle duration, BF: amplitude, max 1/4 step)
db $D6, $01            ; Set Octave to 01
db $0C                 ;  Note C    [4 ticks] 
db $DD, $0E            ; Set ADSR Attack Value (0-15)
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $1C                 ;  Note D    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_F0_B:       ; Voice B: Distant Boom	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D4                 ; Enable Echo
db $C9, $00, $02, $BF  ; Enable Vibrato (00: delay in ticks, 02: cycle duration, BF: amplitude, max 1/4 step)
db $D6, $01            ; Set Octave to 01
db $C2                 ;  Note Rest [4 ticks] 
db $D2                 ; Enable Pitch Modulation
db $26                 ;  Note D    [8 ticks] 
db $DD, $0D            ; Set ADSR Attack Value (0-15)
db $E0, $0E            ; Set ADSR Release Value (0-31)
db $38                 ;  Note E    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_F1_A:       ; Voice A: Zap Charge	

db $C1                 ;  Note Rest [6 ticks] 
db $DB, $04            ; Set Detune

SFX_Script_F1_B:       ; Voice B: Zap Charge	

db $D4                 ; Enable Echo
db $DC, $00            ; Set Instrument
db $D6, $04            ; Set Octave to 04
db $C8, $1C, $10       ; Change Pitch w/ Envelope (1C: envelope duration, 10: change in pitch, signed)
db $01                 ;  Note C    [96 ticks] 
db $EB                 ; End of Script

SFX_Script_F2_A:       ; Voice A: Boss Death	

db $B9                 ;  Note Rest [72 ticks] 
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $E8, $04            ; Add to Note Duration (04 = duration in ticks)
db $E9, $42            ; Play Game Sound Effect (voice A)

SFX_Script_F2_B:       ; Voice B: Boss Death	

db $C4, $53            ; Set Voice Volume to 53 (00-7F)
db $E9, $EF            ; Play Game Sound Effect (voice A)

SFX_Script_F3_A:       ; Voice A: Dice Thrown	

db $BF                 ;  Note Rest [12 ticks] 

SFX_Script_F3_B:       ; Voice B: Dice Thrown	

db $C4, $58            ; Set Voice Volume to 58 (00-7F)
db $C5, $27, $00       ; Set Voice Volume w/ Envelope (00: volume, 27: envelope duration)
db $D0                 ; Enable Noise
db $CF, $1C            ; Set Noise Clock (00-1F)
db $E0, $1F            ; Set ADSR Release Value (0-31)
db $0A                 ;  Note C    [8 ticks] 
db $08                 ;  Note C    [16 ticks] 
db $0A                 ;  Note C    [8 ticks] 
db $0D                 ;  Note C    [3 ticks] 
db $EB                 ; End of Script

SFX_Script_F4_B:       ; Voice B: Engulf	

db $D4                 ; Enable Echo
db $C8, $B8, $14       ; Change Pitch w/ Envelope (B8: envelope duration, 14: change in pitch, signed)
db $E8, $D0            ; Add to Note Duration (D0 = duration in ticks)
db $00                 ;  Note C    [192 ticks] 
db $EB                 ; End of Script

SFX_Script_F5_A:       ; Voice A: Fighting	

db $D4                 ; Enable Echo
db $C8, $0A, $32       ; Change Pitch w/ Envelope (0A: envelope duration, 32: change in pitch, signed)
db $DF, $03            ; Set ADSR Sustain Value (0-7)
db $E0, $12            ; Set ADSR Release Value (0-31)
db $54                 ;  Note F#   [192 ticks] 
db $EB                 ; End of Script

SFX_Script_F5_B:       ; Voice B: Fighting	

db $D2                 ; Enable Pitch Modulation
db $E8, $04            ; Add to Note Duration (04 = duration in ticks)
db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $EA, $E9            ; Play Game Sound Effect (voice B)

SFX_Script_F6_A:       ; Voice A: Big Earthquake	

db $D4                 ; Enable Echo
db $CF, $15            ; Set Noise Clock (00-1F)
db $D0                 ; Enable Noise
db $CD, $03, $54       ; Enable Pansweep (03: delay in ticks, 54: cycle duration)
db $DD, $01            ; Set ADSR Attack Value (0-15)
db $46                 ;  Note F    [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $A8                 ;  Note Tie  [192 ticks] 
db $E0, $12            ; Set ADSR Release Value (0-31)
db $AD                 ;  Note Tie  [32 ticks] 
db $EB                 ; End of Script

SFX_Script_F6_B:       ; Voice B: Big Earthquake	

db $E8, $FF            ; Add to Note Duration (FF = duration in ticks)
db $EA, $06            ; Play Game Sound Effect (voice B)

SFX_Script_F7_A:       ; Voice A: Close big near	

db $D0                 ; Enable Noise
db $CF, $10            ; Set Noise Clock (00-1F)
db $0B                 ;  Note C    [6 ticks] 
db $07                 ;  Note C    [24 ticks] 
db $EB                 ; End of Script

SFX_Script_F8_A:       ; Voice A: Demi	

db $BD                 ;  Note Rest [24 ticks] 
db $D0                 ; Enable Noise
db $CF, $1C            ; Set Noise Clock (00-1F)
db $DD, $0A            ; Set ADSR Attack Value (0-15)
db $DF, $02            ; Set ADSR Sustain Value (0-7)
db $E2, $14            ; Loop Start (loop 14+1 times)
db $09                 ;  Note C    [12 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_F8_B:       ; Voice B: Demi	

db $D4                 ; Enable Echo
db $E8, $30            ; Add to Note Duration (30 = duration in ticks)
db $E9, $8F            ; Play Game Sound Effect (voice A)

SFX_Script_F9_A:       ; Voice A: Mog “Kupo!” / Dance (part 2)	

db $DB, $07            ; Set Detune

SFX_Script_F9_B:       ; Voice B: Mog “Kupo!” / Dance (part 2)	

db $C4, $64            ; Set Voice Volume to 64 (00-7F)
db $DC, $03            ; Set Instrument
db $D6, $06            ; Set Octave to 06
db $53                 ;  Note F    [3 ticks] 
db $45                 ;  Note E    [3 ticks] 
db $C0                 ;  Note Rest [8 ticks] 
db $29                 ;  Note D    [3 ticks] 
db $43                 ;  Note E    [6 ticks] 
db $53                 ;  Note F    [3 ticks] 
db $7D                 ;  Note G#   [3 ticks] 
db $EB                 ; End of Script

SFX_Script_FA_A:       ; Voice A: Dice 2	

db $D0                 ; Enable Noise
db $CF, $1E            ; Set Noise Clock (00-1F)
db $E0, $1F            ; Set ADSR Release Value (0-31)
db $E2, $07            ; Loop Start (loop 07+1 times)
db $0B                 ;  Note C    [6 ticks] 
db $E3                 ; Loop End
db $EB                 ; End of Script

SFX_Script_FB_A:       ; Voice A: Screams before cutscene with Kefka	

db $C4, $00            ; Set Voice Volume to 00 (00-7F)
db $DC, $02            ; Set Instrument
db $DD, $08            ; Set ADSR Attack Value (0-15)
db $E2, $00            ; Loop Start (loop 00+1 times)
db $05                 ;  Note C    [32 ticks] 
db $DA, $44            ; Add to Transpose
db $E3                 ; Loop End

SFX_Script_FB_B:       ; Voice B: Screams before cutscene with Kefka	

db $C4, $7F            ; Set Voice Volume to 7F (00-7F)
db $D2                 ; Enable Pitch Modulation
db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $05            ; Set Octave to 05
db $CD, $2C, $60       ; Enable Pansweep (2C: delay in ticks, 60: cycle duration)
db $CB, $00, $05, $BF  ; Enable Tremolo (00: delay in ticks, 05: cycle duration, BF: amplitude, max 50%)
db $C9, $00, $10, $BF  ; Enable Vibrato (00: delay in ticks, 10: cycle duration, BF: amplitude, max 1/4 step)
db $DD, $01            ; Set ADSR Attack Value (0-15)
db $E2, $00            ; Loop Start (loop 00+1 times)
db $D9, $00            ; Set Transpose
db $E2, $00            ; Loop Start (loop 00+1 times)
db $8C                 ;  Note A#   [192 ticks] 
db $DA, $0A            ; Add to Transpose
db $E3                 ; Loop End
db $E3                 ; Loop End

SFX_Script_FC_A:       ; Voice A: Control	

db $DB, $01            ; Set Detune

SFX_Script_FC_B:       ; Voice B: Control	

db $D4                 ; Enable Echo
db $DC, $03            ; Set Instrument
db $D6, $07            ; Set Octave to 07
db $28                 ;  Note D    [4 ticks] 
db $33                 ;  Note D#   [12 ticks] 
db $EB                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
db $FF                 ; End of Script
base off
