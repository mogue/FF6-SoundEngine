; FF6 SPC ASM by m06, 2019

arch spc700
; -raw
base $000200

; Engine start
EngineStart:
         CLRP                ; Clear direct page flag
         DI                  ; Clear interrupt flag
         MOV   X,#$FF        ; Set X to #$FF
         MOV   SP,X          ; Set stack pointer to $FF
         MOV   A,#$00        ; Zero A
         MOV   X,A           ; Zero X
L0208:   MOV   (X+),A        ; Zero $00+X; increase X
         CMP   X,#$F0        ; Pointing to $F0?
         BNE   L0208         ; Loop if not
         DECW  $C6           ; Paused and Current Song = #$FF
         MOV   A,#$00        ; Zero A...
         MOV   Y,#$0C        ; Point to MVL
         CALL  SetDSPReg     ; Master volume left: 0
         MOV   Y,#$1C        ; Point to MVR
         CALL  SetDSPReg     ; Master volume right: 0
         MOV   Y,#$2C        ; Point to EVOLL
         CALL  SetDSPReg     ; Echo volume left: 0
         MOV   Y,#$3C        ; Point to EVOLR
         CALL  SetDSPReg     ; Echo volume right: 0
         MOV   Y,#$2D        ; Point to pitch mod
         CALL  SetDSPReg     ; Pitch modulation: all voices off
         MOV   Y,#$3D        ; Point to noise
         CALL  SetDSPReg     ; Noise: all voices off
         MOV   Y,#$4D        ; Point to echo
         CALL  SetDSPReg     ; Echo: all voices off
         MOV   Y,#$5D        ; Point to DIR; sample pointer table
         MOV   A,#$1B        ; Address parameter
         CALL  SetDSPReg     ; Source directory: $1B00
         MOV   Y,#$07        ; Point to voice0 GAIN
         MOV   X,#$A0        ; Parameter
L023F:   MOV   $F2,Y         ; Set DSP register
         MOV   $F3,X         ; Store parameter
         MOV   A,Y           ; Transfer Y to A
         CLRC                ; Clear Carry for addition
         ADC   A,#$10        ; Point to next voice
         MOV   Y,A           ; Transfer A to Y
         BPL   L023F         ; Loop unless 8 voices done
         MOV   $F1,#$30      ; Clear all 4 ports, stop all 3 timers
         MOV   $FA,#$27      ; Timer0 target: 39) (4.875ms
         MOV   $FB,#$80      ; Timer1 target: 128) (16ms
         MOV   $FC,#$05      ; Timer2 target: 5
         MOV   $F1,#$07      ; Enable all 3 timers
         MOV   $8C,#$05      ; Echo Delay = #$05
         CALL  InitEcho      ; Initialize Echo
         MOV   A,#$3F        ; Parameter: 127
         MOV   Y,#$0C        ; Point to MVL
         CALL  SetDSPReg     ; Master volume left: 127
         MOV   Y,#$1C        ; Point to MVR
         CALL  SetDSPReg     ; Master volume right: 127
         DEC   $24           ; Mute all voices...?
         MOV   $C8,#$07      ; Master Evelope Frame Counter = 7
         DEC   $A8           ; Decrement SFX Volume Envelope Counter

MainLoop:
L0272:   CALL  ProcessPorts  ; Process Ports
         MOV   Y,$FD         ; Counter-0, 4.875 milliseconds
         BEQ   L0272         ; Loop if zero
         BBS2  $85,L027F     ; If ?
         BBC6  $86,L0283     ; If disable echo? skip 2 instructions
L027F:   MOV   Y,#$05        ; Start from $1999
         BRA   L0285         ; Skip next instruction
L0283:   MOV   Y,#$11        ; Start from $19A5
L0285:   MOV   A,$1994+Y     ; Register table
         MOV   $F2,A         ; Set DSP register
         MOV   A,$19A5+Y     ; Register Data table
         MOV   X,A           ; Transfer A to X
         MOV   A,(X)         ; Read from DP
         MOV   $F3,A         ; Store to register
         DBNZ  Y,L0285       ; Decrease Y, loop unless zero
         MOV   $24,Y         ; Clear key-off for all voices...?
         MOV   $22,Y         ; Clear key-on for all voices...?
         BBS7  $86,L02AE     ; If waveform output mode
         BBS3  $85,L029F+1   ; If master envelope output mode
         MOV   Y,$52         ; Y = Enabled Voices Bitmask
L029F:   MOV   A,$ADEB       ; ? pointless, use up cycles?
         MOV   A,$DD         ; A = Enabled Conditional Jump Bitmask
         MOVW  $F6,YA        ; Store to Port $2142
         MOV   Y,$7B         ; Y = Output Code
         MOV   A,#$00        ; Zero A
         MOVW  $F4,YA        ; Store to Port $2140
         BRA   L02B1         ; Skip next instruction
L02AE:   CALL  WaveformOutputMode   ; Waveform Output Mode
L02B1:   MOVW  YA,$D9        ; Paused Voices, Song and Game SFX
         BNE   L0300         ; Skip
         DEC   $C8           ; Decrement Master Envelope Frame Counter
         BNE   L02BF         ; Skip 2 instructions if counting
         MOV   $C8,#$07      ; Master Envelope Frame Counter = 7
         CALL  ProcessMasterEnv   ; Process Master Envelopes
L02BF:   CALL  ProcessSongScript  ; Process Song Script
         MOV   X,#$00        ; Zero X
         MOV   $8F,#$01      ; Current Voice = 1
         MOV   A,$83         ; A = Game Sound Effect Voices
         OR    A,$84         ; OR System Sound Effect Voices
         EOR   A,#$FF        ; Invert SFX voices
         AND   A,$52         ; Filter with Enabled Voices
         AND   A,$23         ; Filter with Key-On Voices for paused song
         MOV   $A0,A         ; Set Active Voices
         BRA   L02DE         ; Skip 5 instructions
L02D5:   MOV   $A3,X         ; Set Voice Pointer
         CALL  ProcessVibTrem  ; Process Vibrato and Tremolo
L02DA:   INC   X             ; Increment Voice Pointer
         INC   X             ; Increment Voice Pointer
         ASL   $8F           ; Next Voice
L02DE:   LSR   $A0           ; Shift Active Voices
         BCS   L02D5         ; Loop if Next Voice is active
         BNE   L02DA         ; Loop unless All Voices Done
         MOV   X,#$1E        ; X = Voice Pointer for Last Voice
         MOV   $8F,#$80      ; Current Voice = bit 7, Last Voice
         MOV   A,$83         ; A = Game Sound Effect Voices
         OR    A,$84         ; with System Sound Effect Voices
         MOV   $A0,A         ; Set Active voices
         BRA   L02FA         ; Skip 5 instructions
L02F1:   MOV   $A3,X         ; Set Voice Pointer
         CALL  ProcessVibTrem  ; Process Vibrato and Tremolo
L02F6:   DEC   X             ; Increment Voice Pointer
         DEC   X             ; Increment Voice Pointer
         LSR   $8F           ; Next Voice
L02FA:   ASL   $A0           ; Shift Active Voices
         BCS   L02F1         ; Loop if Next Voice is active
         BNE   L02F6         ; Loop unless All Voices Done
L0300:   MOV   A,#$00        ; Zero A, Volume Update
         MOV   Y,A           ; Zero Y, Pitch Update
         MOVW  $DB,YA        ; Disable Volume and Pitch Update in DSP
         JMP   L0272         ; Loop

; Process Song Script
ProcessSongScript:
         BBS5  $86,L032A     ; If fast forward mode skip 18 instructions
         MOV   A,$46         ; A = Current Tempo high
         MOV   Y,$B7         ; Y = Tempo Ratio
         BEQ   L0323         ; If zero skip 11 instructions
         MUL   YA            ; Current Tempo * Tempo Ratio
         MOV   A,Y           ; Transfer Y to A
         BBS7  $B7,L0320     ; If tempo ratio signed skip 6 instructions
         ASL   A             ; Double calculated tempo
         CLRC                ; Clear Carry for addition
         ADC   A,$46         ; Add Current Tempo low
         BCC   L0323         ; If carry clear skip 4 instructions
         MOV   A,#$FF        ; A = #$FF, tempo boundary
         BRA   L0323         ; Skip 2 instructions
L0320:   BNE   L0323         ; Skip 1 instruction
         INC   A             ; Increment A
L0323:   CLRC                ; Clear Carry for addition
         ADC   A,$47         ; Add Tempo Counter
         MOV   $47,A         ; Store Tempo Counter
         BCC   L037D         ; 
L032A:   MOV   X,#$00        ; Zero X
         MOV   $8F,#$01      ; Current Voices bitmask = #$01
         MOV   ($A0),($52)   ; Set Active Voices with Enabled Voices
         BRA   L036D         ; Skip 27 instructions
L0334:   MOV   $A3,X         ; Set Voice Pointer
         DEC   $25+X         ; Decrement Note Duration Counter
         BNE   L033F         ; If note still counting skip 2 instructions
         CALL  HandleSongScript         ; Handle Song Script Code
         BRA   L0366         ; Skip 18 instructions
L033F:   MOV   Y,#$00        ; Zero Y
         CMP   X,#$10        ; X > #$10
         BCS   L0345+1       ; If SFX skip next 1/2 instruction
L0345:   MOV   A,#$FC        ; .. $FC INC Y
         MOV   A,#$02        ; A = #$02
         CBNE  $25+X,L0366   ; If loop count != 2 skip 12 instructions
         MOV   A,$0059+Y     ; A = Disable Key-Off at End of Note
         AND   A,$8F         ; Isolate Current Voice
         BNE   L0366         ; If active skip 9 instructions
         MOV   A,Y           ; Transfer Y to A
         BNE   L0363         ; Skip if SFX voice
         MOV   A,$8F         ; A = Current Voice
         TCLR  $0023,A       ; Clear Key-On for Paused Song
         MOV   A,$83         ; A = Game Sound Effect Voices
         OR    A,$84         ; with System Sound Effect Voices
         AND   A,$8F         ; Select Current Voice
         BNE   L0366         ; Skip next instruction if active
L0363:   OR    ($24),($8F)   ; $24 = muted voices
L0366:   CALL  ProcessVolPanEnv         ; Process Volume, Pan and Pansweep Envelopes
L0369:   INC   X             ; Increment Voice Pointer
         INC   X             ; Increment Voice Pointer
         ASL   $8F           ; bitmask for current voice <<
L036D:   LSR   $A0           ; Active Voices >>
         BCS   L0334         ; Loop while carried voice is active
         BNE   L0369         ; Loop while active voices are left
         CMP   X,#$18        ; 
         BCS   L0394         ; Return if?
         CALL  ProcessTempoEchoEnv         ; Process Tempo, Echo and Filter Envelopes
         CALL  ProcessPorts  ; Process Ports
L037D:   MOV   A,#$78        ; A = #$78
         CLRC                ; Clear Carry for addition
         ADC   A,$48         ; Add SFX Tempo Counter
         MOV   $48,A         ; Store SFX Tempo Counter
         BCC   L0394         ; Return if
         MOV   X,#$18
         MOV   $8F,#$10
         MOV   A,$83         ; A = Game Sound Effect Voices
         OR    A,$84         ; with System Sound Effect Voices
         XCN   A             ; Swap high 4 and low 4 bits
         MOV   $A0,A         ; Set Active Voices
         BRA   L036D         ; Loop
L0394:   RET                 ; Return

; Process Tempo, Echo and Filter Envelopes
ProcessTempoEchoEnv:
         MOV   A,$49         ; A = Tempo Envelope Counter
         BEQ   L03A1         ; Skip if zero
         DEC   $49           ; Decrement Tempo Envelope Counter
         MOVW  YA,$4A        ; A = Tempo Envelope Change Rate
         ADDW  YA,$45        ; Add Current Tempo
         MOVW  $45,YA        ; Store Current Tempo
L03A1:   MOV   A,$50         ; A = Echo Volume Envelope Counter
         BEQ   L03AD         ; Skip if zero
         DEC   $50           ; Decrement Echo Volume Envelope Counter
         MOVW  YA,$4E        ; Echo Volume Envelope Change Rate
         ADDW  YA,$4C        ; Add Echo Volume
         MOVW  $4C,YA        ; Set Echo Volume
L03AD:   MOV   A,$78         ; A = Echo Feedback Envelope Counter
         BEQ   L03B9         ; Skip if zero
         DEC   $78           ; Decrement Echo Feedback Envelope Counter
         MOVW  YA,$79        ; A = Echo Feedback Envelope Change Rate
         ADDW  YA,$75        ; Add Echo Feedback
         MOVW  $75,YA        ; Store Echo Feedback
L03B9:   MOV   A,$77         ; A = Filter Envelope Counter
         BEQ   L03D8         ; Return if zero
         DEC   $77           ; Decrement Filter Envelope Counter
         MOV   X,#$10        ; X = #$10
L03C1:   MOV   A,$00FF+X     ; A = Filter Envelope Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$00FE+X     ; A = Filter Envelope Change Rate low
         MOVW  $98,YA        ; $98 = Filter Envelope Change Rate
         MOV   A,$63+X       ; A = Filter Data low
         MOV   Y,$64+X       ; Y = Filter Data high
         ADDW  YA,$98        ; Add Change Rate to Data
         MOV   $63+X,A       ; Set FIlter Data low
         MOV   $64+X,Y       ; Set Filter Data high
         DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next voice
         BNE   L03C1         ; Loop for all voices
L03D8:   RET                 ; Return

; Handle Song Script Code
HandleSongScript:
         CALL  NextOpCode    ; Next Script Op Code
         CMP   A,#$C4        ; Is Track Command
         BCC   L03E5         ; If not skip to Notes
         CALL  HandleTrkCmds         ; Handle Track Commands
         BRA   HandleSongScript      ; Loop
L03E5:   MOV   Y,$25+X       ; Y = Ticks Left for Current Voice
         BNE   L03F5         ; If Ticks Left, skip to handle Note
         MOV   Y,#$00        ; Zero Y
         MOV   X,#$0E        ; X = 13
         DIV   YA,X          ; A = Note, Y = Duration Pointer
         MOV   X,$A3         ; X = Voice Pointer
         MOV   A,$17D1+Y     ; A = Duration in Ticks
         MOV   $25+X,A       ; Set as Ticks Left for Current Voice
L03F5:   CMP   $A2,#$A8      ; Is a note value
         BCC   HandleNote    ; Handle Note
         CMP   $A2,#$B6      ; Is a Tie
         BCS   L0402         ; Return if not
         JMP   HandleTie     ; Handle Tie
L0402:   RET                 ; Return

; Handle Note Value
HandleNote:
         MOV   A,$A2         ; Current Op Code, Note and Duration
         MOV   Y,#$00        ; Zero Y
         MOV   X,#$0E        ; X = 13
         DIV   YA,X          ; A / 13, A = Note, Y = Duration Pointer
         MOV   $A2,A         ; Set Current Note to $A2
         MOV   X,$A3         ; X = Voice Pointer
         MOV   A,$F600+X     ; A = Octave
         MOV   Y,#$0C        ; Y = 12
         MUL   YA            ; Octave * 12
         CLRC                ; Clear Carry for addition
         ADC   A,$A2         ; Add Current Note
         CLRC                ; Clear Carry for addition
         ADC   A,$F721+X     ; Add Transposition
         SETC                ; Set Carry for subtraction
         SBC   A,#$0A        ; Subtract 10
         MOV   $F761+X,A     ; Set as Absolute Pitch
         CALL  PitchCalculation         ; Note Pitch Calculation, VxPITCH
         MOV   A,$C0         ; A = Calculated VxPITCH low
         MOV   $F8E0+X,A     ; Set Calculated VxPITCH to $F8E0+X
         MOV   A,$C1         ; A = Calculated VxPITCH high
         MOV   $F8E1+X,A     ; Set Calculated VxPITCH to $F8E1+X
         MOV   A,$0151+X     ; A = Vibrato Amplitude
         BEQ   L0438         ; Skip if no Vibrato
         MOV   $A2,A         ; $A2 = Vibrato Amplitude
         CALL  ResetVibrato  ; Reset Vibrato
L0438:   MOV   A,$0170+X     ; A = Tremolo
         BEQ   L0444         ; Skip if no Tremolo
         MOV   $A2,A         ; $A2 = Tremolo 
         CALL  ResetTremolo  ; Reset Tremolo
         MOV   A,#$00        ; Zero A
L0444:   MOV   $F8C0+X,A     ; Zero Vibrato Value low
         MOV   $F8C1+X,A     ; Zero Vibrato Value high
         MOV   $F860+X,A     ; Zero Tremolo Value low
         MOV   $F861+X,A     ; Zero Tremolo Value high
         MOV   $F780+X,A     ; Zero Pitch Envelope Change Rate low
         MOV   $F781+X,A     ; Zero Pitch Envelope Change Rate high
         CMP   X,#$10        ; X > #$10
         BCS   L047A         ; If SFX skip 15 instructions
         OR    ($23),($8F)   ; Set Key-On, paused song for Current Voice
         MOV   A,$83         ; A = Game SFX Voices
         OR    A,$84         ; with System SFX Voices
         AND   A,$8F         ; Isolate Current Voice
         BNE   L0499         ; If SFX Voice 
         MOV   A,$8F         ; A = Current Voice
         AND   A,$5F         ; And Drum Roll Enabled
         BNE   L048D         ; If so skip ? instructions
         MOV   A,$8F         ; A = Current Voice
         AND   A,$5B         ; And Slur Enabled
         BEQ   L048D         ; If not skip ? instructions
         AND   A,$5D         ; And Slur Active
         BNE   L0490         ; If so skip 12 instructions
         OR    ($5D),($8F)   ; Set Active Slur for Current Voice
         BRA   L048D         ; Skip 9 instructions
L047A:   MOV   A,$8F         ; A = Current Voice
         AND   A,$60         ; And SFX Drum Roll Enabled
         BNE   L048D         ; If so skip 6 instructions
         MOV   A,$8F         ; A = Current Voice
         AND   A,$5C         ; And SFX Slur Enabled
         BEQ   L048D         ; If not skip 3 instructions
         AND   A,$5E         ; And SFX Slur Active
         BNE   L0490         ; If so skip 2 instructions
         OR    ($5E),($8F)   ; Set Active Slur SFX for Current Voice
L048D:   OR    ($22),($8F)   ; Set Key-On for Current Voice
L0490:   OR    ($DB),($8F)   ; Set Enable Volume Update in DSP for Current Voice
         OR    ($DC),($8F)   ; Set Enable Pitch Update in DSP for Current Voice
         CALL  InstrumentUpdateDSP         ; Update DSP SRCN for Voice with Instrument

; Continue Note Processing, Tie starts from here.
HandleTie:
L0499:   CALL  HandleTrkCmdsSwitch         ; Handle some Track Commands
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; X > #$10
         BCS   L04C4         ; If SFX skip 14 instructions
         CMP   Y,#$B6        ; Y > #$B6
         BCS   L04B0         ; If so skip 4 instructions
         CMP   Y,#$A8        ; Y < #$A8
         BCC   L04B6         ; If so skip 4 instructions
         TSET  $0059,A       ; Set Disable Key-Off at End of Note
         BRA   L04E3         ; Skip 21 instructions
L04B0:   TCLR  $005B,A       ; Disable Slur
         TCLR  $005F,A       ; Disable Drum Roll
L04B6:   TCLR  $0059,A       ; Clear Disable Key-Off at End of Note
         MOV   A,$5B         ; A = Enable Slur
         OR    A,$5F         ; with Enable Drum Roll
         AND   A,$8F         ; Isolate Current Voice
         TSET  $0059,A       ; Set Disable Key-Off at End of Note
         BRA   L04E3         ; Skip 13 instructions
L04C4:   CMP   Y,#$B6        ; Y > #$B6
         BCS   L04D1         ; If so skip 4 instructions
         CMP   Y,#$A8        ; Y < #$A8
         BCC   L04D7         ; If so skip 4 instructions
         TSET  $005A,A       ; Set Disable Key-Off at End of Note SFX
         BRA   L04E3         ; Skip 7 instructions
L04D1:   TCLR  $005C,A       ; Disable Slur SFX
         TCLR  $0060,A       ; Disable Drum Roll SFX
L04D7:   TCLR  $005A,A       ; Clear Disable Key Off at End of Note SFX
         MOV   A,$5C         ; A = Enable Slur SFX
         OR    A,$60         ; with Enable Drum Roll SFX
         AND   A,$8F         ; Isolate Current Voice
         TSET  $005A,A       ; Set Disable Key-Off at End of Note SFX
L04E3:   MOV   A,$0150+X     ; A = Pitch Envelope Target
         BEQ   L0553         ; If none skip  instructions
         CLRC                ; Clear Carry for addition
         ADC   A,$F761+X     ; Add Absolute Pitch
         MOV   $F761+X,A     ; Set Absolute Pitch
         CALL  PitchCalculation         ; Note Pitch Calculation, VxPITCH
         MOV   A,$F8E1+X     ; A = Last Calculated Frequency Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F8E0+X     ; A = Last Calculated Frequency Value low
         MOVW  $98,YA        ; $98 = Last Calculated Frequency Value
         MOVW  YA,$C0        ; YA = Calculated Frequency Value
         SETC                ; Set Carry for subtraction
         SUBW  YA,$98        ; Subtract Last Calculated Frequency Value
         MOVW  $98,YA        ; $98 = Calculated Frequency Value Diff
         PUSH  P             ; Save Flags
         BCS   L050D         ; If lower frequency skip 3 instructions
         EOR   $98,#$FF      ; Invert Calculated Frequency Value Diff low
         EOR   $99,#$FF      ; Invert Calculated Frequency Value Diff high
         INCW  $98           ; Increment Calculated Frequency Value Diff
L050D:   MOV   A,$F720+X     ; A = Pitch Envelope Duration
         BNE   L0517         ; If envelope skip 2 instructions
         MOV   $9A,#$00      ; $9A = 0
         BRA   L0529         ; Skip 11 instructions
L0517:   MOV   X,A           ; Transfer A to X
         MOV   A,$99         ; A = Calculated Frequency Value Diff high
         MOV   Y,#$00        ; Zero Y
         DIV   YA,X          ; YA / X = Frequency Change Rate high
         MOV   $9A,A         ; $9A = Frequency Change Rate high
         MOV   A,$98         ; A = Calculated Frequency Value Diff low
         DIV   YA,X          ; YA / X = Frequency Change Rate low
         MOV   $99,A         ; $99 = Frequency Change Rate low
         MOV   A,#$00        ; Zero A
         DIV   YA,X          ; YA / X = Frequency Change Rate remainder
         MOV   $98,A         ; $98 = Frequency Change Rate remainder
L0529:   POP   P             ; Restore Flags
         BCS   L053B         ; If frequency diff negative skip 6 instructions
         EOR   $98,#$FF      ; Invert Frequency Change Rate remainder
         EOR   $99,#$FF      ; Invert Frequency Change Rate low
         EOR   $9A,#$FF      ; Invert Frequency Change Rate high
         INCW  $98           ; Increment $98
         BNE   L053B         ; If value skip next instruction
         INC   $9A           ; Increment Frequency Change Rate high
L053B:   MOV   X,$A3         ; X = Voice Pointer
         MOVW  YA,$99        ; YA = Frequency Change Rate
         MOV   $F780+X,A     ; Set Pitch Envelope Change Rate low
         MOV   A,Y           ; Transfer Y to A
         MOV   $F781+X,A     ; Set Pitch Envelope Change Rate high
         MOV   A,$98         ; A = Frequency Change Rate remainder
         MOV   $F8A0+X,A     ; Set Pitch Envelope Change Rate Fraction
         MOV   A,#$00        ; Zero A
         MOV   $0150+X,A     ; Zero Pitch Envelope Target
         MOV   $F8A1+X,A     ; Zero Pitch Envelope Change Rate Fraction high
L0553:   RET                 ; Return

; Note Pitch Calculation:
; Converts the tracker note value to a value that VxPITCHL/H can use
; 
; Looking at Chrono Trigger disassmebly FF6 seems to have a bug, missing instruction,
; this results in the fine tune (low byte of instrument pitch) being slightly miscalculated.
; 
; A rough overview of the routine:
; Input: A (note value
; 1. A gets divided by 0x0C (12 decimal). The remainder is the note (Y), and the quotient is the octave (A
; 2. (Voice Pitch Multiplier + Detune) * Note Pitch Multiplier = VxPITCHL/H
; 3. VxPITCHL/H gets shifted by octave.
; Additional pitch manipulation (Vibrato and Master Pitch) happens in the DSP Pitch routine.
PitchCalculation:
         MOV   X,#$0C        ; Divisor: 12
         MOV   Y,#$00        ; Zero Y
         DIV   YA,X          ; Y = Note, A = Octave
         MOV   X,$A3         ; Transfer Voice Pointer to X
         MOV   $A1,A         ; Transfer Octave to $A1
         MOV   A,Y           ; Transfer Note to A
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y; Note*2
         MOV   A,TuningTable+Y     ; Transfer Note Pitch Multiplier Low to A
         MOV   $C2,A         ; Store in $C2
         MOV   A,TuningTable+1+Y     ; Transfer Note Pitch Multiplier High to A
         MOV   $C3,A         ; Store in $C3
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F740+X     ; Transfer Voice Pitch Multiplier Low to A
         CLRC                ; Clear Carry for addition
         ADC   A,$F760+X	    ; Add Detune to A
         PUSH  P             ; Push Flags
         PUSH  A             ; Push Voice Pitch Multiplier Low and Detune
         MUL   YA            ; Note Pitch Multiplier High * Voice Pitch Multiplier Low and Detune
         MOVW  $C0,YA        ; Transfer Calculated Frequency Value to $C0
         MOV   Y,$C2         ; Transfer Note Pitch Multiplier Low to Y
         POP   A             ; Pull Voice Pitch Multiplier Low and Detune
         MUL   YA            ; Note Pitch Multipler Low * Voice Pitch Multiplier Low and Detune
         MOV   A,Y           ; Transfer Calculated Frequency Value High to A
         MOV   Y,#$00        ; Zero Y
         ADDW  YA,$C0        ; Add Calculated Frequency Values
         MOVW  $C0,YA        ; Transfer Calculated Frequency Value to $C0
         MOV   A,$F741+X     ; Transfer Voice Pitch Multiplier High to A, overwrites Calculated Frequency Value Low
         BEQ   L058F         ; Skip if #$00
         MUL   YA            ; Calculated Frequency Value High * Voice Pitch Multiplier High
         MOV   A,Y           ; Transfer Y to A, Calculated Frequency Value High to A
         MOV   Y,#$00        ; Zero Y
         ADDW  YA,$C0        ; Add Calculated Frequency Values
         BRA   L0591         ; Skip next instruction
L058F:   MOV   A,$C0         ; Transfer Calculated Frequency Value to A
L0591:   POP   P             ; Pull Flags
         BMI   L0596         ; Branch if Voice Pitch Multiplier Low is signed negative
         ADDW  YA,$C2        ; Add Note Pitch Multiplier H&L to Calculated Frequency Value
L0596:   MOVW  $C0,YA        ; Store Calculated Frequency Value to $C0
         MOV   A,#$04        ; Transfer #$04 to A, default octave value
         MOV   Y,$A1         ; Transfer Octave to Y
         BMI   L05AC         ; Branch if Octave is negative
         CMP   A,$A1         ; Compare #$04 to Octave
         BCS   L05B1         ; Branch if Carry set?
L05A2:   ASL   $C0           ; << $C0, increment octave
         ROL   $C1           ; << $C1, increment octave with carry from $C0
         INC   A             ; Increment A
         CBNE  $A1,L05A2     ; A != Target Octave then branch to $05A2, loop
         BRA   L05B4         ; Exit) (RET...
L05AC:   LSR   $C1           ; >> $C1, decrement octave
         ROR   $C0           ; >> $C0, decrement octave with carry from $C1
         DEC   A             ; Decrement A
L05B1:   CBNE  $A1,L05AC     ; A != Target Octave then branch to $05AC, loop
L05B4:   RET                 ; Return

; Handle Track Commands from JMP Table
HandleTrkCmds:
         SBC   A,#$C4        ; A = Track Command #
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$1882+Y     ; Pointer to JMP Table, high byte
         PUSH  A             ; Push on stack
         MOV   A,$1881+Y     ; Pointer to JMP Table, low byte
         PUSH  A             ; Push on stack
         MOV   A,Y           ; Transfer Y to A
         LSR   A             ; Halve A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$18F9+Y     ; Number of parameter bytes
         BEQ   L05D3         ; Return if none

; Next Script Op Code
NextOpCode:
         MOV   A,($02+X)     ; A = Script Op Code
         MOV   $A2,A         ; $A2 = Script Op Code
         INC   $02+X         ; Increment Script Pointer
         BNE   L05D3         ; Return if not $00
         INC   $03+X         ; Carry to high byte
L05D3:   RET                 ; Return

; Handle some Track Commands
HandleTrkCmdsSwitch:
         MOV   A,$02+X       ; A = Current Script Pointer low
         MOV   Y,$03+X       ; Y = Current Script Pointer high
         MOVW  $90,YA        ; $90 = Current Script Pointer
         MOV   A,$26+X       ; A = Pointer to Loop Count
         MOV   $C5,A         ; $C5 = Current Pointer to Loop Count
L05DE:   MOV   Y,#$00        ; Zero Y
L05E0:   MOV   A,($90)+Y     ; A = Current Operation
         CMP   A,#$C4        ; A < #$C4, Note Command) 
         BCC   L0647         ; Exit
         INCW  $90           ; Point to first parameter of track command
         CMP   A,#$EB        ; == #$EB End of Song Script
         BEQ   L0647         ; Exit
         CMP   A,#$F6        ; == #$F6 Jump to xxxx
         BNE   L05F5         ; If not skip 2 instructions
         CALL  TrkSwitch_JumpToXXXX         ; Switch #$F6: Jump to xxxx
         BRA   L05DE         ; Loop
L05F5:   CMP   A,#$E3        ; == #$E3 Loop End
         BNE   L05FE         ; If not skip 2 instructions
         CALL  $1725         ; Switch $E3: Loop End
         BRA   L05DE         ; Loop
L05FE:   CMP   A,#$F5        ; == #$F5 Jump to yyyy when loop count reaches xx
         BNE   L0607         ; If not skip 2 instructions
         CALL  $1695         ; Switch $F5: Jump to yyyy when loop count reaches xx
         BRA   L05DE         ; Loop
L0607:   CMP   A,#$E5        ; == #$E5 Disable Slur
         BNE   L0610         ; If not skip 2 instructions
         CALL  $15CF         ; Track Command $E5: Disable Slur
         BRA   L05DE         ; Loop
L0610:   CMP   A,#$E7        ; == #$E7 Disable Drum Roll
         BNE   L0619         ; If not skip 2 instructions
         CALL  $15F3         ; Track Command $E7: Disable Drum Roll
         BRA   L05DE         ; Loop
L0619:   CMP   A,#$E9        ; == #$E9 Play Game SFX, voice A
         BNE   L0622         ; If not skip 2 instructions
         CALL  $1633         ; Switch $E9: Play Game SFX, voice A
         BRA   L05DE         ; Loop
L0622:   CMP   A,#$EA        ; == #$EA Play Game SFX, voice B
         BNE   L062B         ; If not skip 2 instructions
         CALL  $1639         ; Switch $EA: Play Game SFX, voice B
         BRA   L05DE         ; Loop
L062B:   CMP   A,#$DC        ; == #$DC Set Instrument
         BNE   L0637         ; If not skip 3 instructions
         CALL  $15CF         ; Track Command $E5: Disable Slur
         CALL  $15F3         ; Track Command $E7: Disable Drum Roll
         BRA   L05DE         ; Loop
L0637:   SETC                ; Set Carry for subtraction
         SBC   A,#$C4        ; Index from #$C4
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$18F9+Y     ; Number of bytes for Track Command
         BEQ   L05DE         ; Loop if no parameters
         MOV   Y,A           ; Transfer A to Y
L0641:   INCW  $90           ; Next parameter
         DBNZ  Y,L0641       ; Decrease Y, loop unless zero
         BRA   L05E0         ; Loop
L0647:   RET                 ; Return

; Store A to DSP register Y
SetDSPReg:
         MOV   $F2,Y         ; Set register address
         MOV   $F3,A         ; Write parameter
         RET                 ; Return

; Enable all timers, reset input from ports 0 and 1
EnableTimersResetPorts:
         MOV   $F1,#$17      ; Enable all 3 timers, reset input from ports 0 and 1
         MOV   $F1,#$07      ; Enable all 3 timers...
         RET                 ; Return

; Process Volume, Pan and Pansweep Envelopes
ProcessVolPanEnv:
         SETP                ; Set direct page flag
         MOV   A,$11+X       ; A = SFX Song Script Pointer low ?
         BEQ   L065B         ; If zero skip next instruction
         DEC   $11+X         ; Decrement 
L065B:   MOV   A,$31+X
         BEQ   L0661         ; If zero skip next instruction
         DEC   $31+X
L0661:   CLRP                ; Clear direct page flag
         MOV   A,$F6A0+X     ; A = Volume Envelope Counter
         BEQ   L068D         ; If no envelope skip 16 instructions
         DEC   A             ; Decrement A
         MOV   $F6A0+X,A     ; Set Volume Envelope Counter
         MOV   A,$F620+X     ; A = Voice Volume low
         MOV   $98,A         ; Set $98
         MOV   A,$F621+X     ; A = Voice Volume high
         MOV   $99,A         ; Set $99
         MOV   A,$F641+X     ; A = Voice Envelope Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F640+X     ; A = Voice Envelope Change Rate low
         ADDW  YA,$98        ; Add Voice Volume
         MOV   $F620+X,A     ; Set Voice Volume low
         MOV   A,Y           ; Transfer Y to A
         CMP   A,$F621+X     ; Check if Volume Changed
         MOV   $F621+X,A     ; Set Voice Volume high
         BEQ   L068D         ; If no volume skip next instruction
         OR    ($DB),($8F)   ; Enable Volume Update in DSP for Current Voice
L068D:   MOV   A,$F6A1+X     ; A = Pan Envelope Counter
         BEQ   L06B8         ; If no envelope skip 16 instructions
         DEC   A             ; Decrement A
         MOV   $F6A1+X,A     ; Set Pan Envelope Counter
         MOV   A,$F660+X     ; A = Voice Pan low
         MOV   $98,A         ; Set $98
         MOV   A,$F661+X     ; A = Voice Pan high
         MOV   $99,A         ; Set $99
         MOV   A,$F681+X     ; A = Pan Envelope Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F680+X     ; A = Pan Envelope Change Rate low
         ADDW  YA,$98        ; Add Voice Pan
         MOV   $F660+X,A     ; Set Voice Pan low
         MOV   A,Y           ; Transfer Y to A
         CMP   A,$F661+X     ; Check if Pan Changed
         MOV   $F661+X,A     ; Set Voice Pan high
         BEQ   L06B8         ; If no change skip next instruction
         OR    ($DB),($8F)   ; Enable Volume Update in DSP for Current Voice
L06B8:   MOV   A,$F8A0+X     ; A = Pitch Envelope Change Rate fraction
         MOV   $98,A         ; Set $98
         MOV   A,$F780+X     ; A = Pitch Envelope Change Rate low
         MOV   $99,A         ; Set $99
         MOV   A,$F781+X     ; A = Pitch Envelope Change Rate high
         MOV   $9A,A         ; Set $9A
         MOVW  YA,$98        ; YA = Pitch Envelope Change Rate low and fraction
         BNE   L06CF         ; If envelope skip 2 instructions
         MOV   A,$9A         ; A = Pitch Envelope Change Rate high
         BEQ   L06FD         ; If zero skip 19 instructions
L06CF:   MOV   A,$F720+X     ; A = Pitch Envelope Duration
         DEC   A             ; Decrement A
         BNE   L06DE         ; If counting skip 3 instructions
         MOV   $F780+X,A     ; Zero Pitch Envelope Change Rate low
         MOV   $F781+X,A     ; Zero Pitch Envelope Change Rate high
         MOV   $F8A0+X,A     ; Zero Pitch Envelope Change Rate fraction
L06DE:   MOV   $F720+X,A     ; Set Pitch Envelope Duration
         CLRC                ; Clear Carry
         MOV   A,$F8E0+X     ; A = Calculated Frequency Value low
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F8A1+X     ; A = Pitch Envelope Change Rate fraction high
         ADDW  YA,$98        ; Add Pitch Envelope Change Rate low and fraction
         MOV   $F8A1+X,A     ; Set Pitch Envelope Change Rate fraction high
         MOV   A,Y           ; Transfer Y to A
         MOV   $F8E0+X,A     ; Set Calculataed Frequency Value low
         MOV   A,$9A         ; A = Pitch Envelope Change Rate high
         ADC   A,$F8E1+X     ; Add Calculated Frequency Value high
         MOV   $F8E1+X,A     ; Set Calculated Frequency Value high
         OR    ($DC),($8F)   ; Enable Pitch Update in DSP for Current Voice
L06FD:   MOV   A,$0171+X     ; A = Pansweep
         BEQ   L0744         ; If no pansweep exit
         MOV   A,$F7A0+X     ; A = Pansweep Change Rate low
         MOV   $98,A         ; Set $98
         MOV   A,$F7A1+X     ; A = Pansweep Change Rate high
         MOV   $99,A         ; Set $99
         MOV   A,$F881+X     ; A = Pansweep Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   $9A,A         ; Set $9A
         MOV   A,$F880+X     ; A = Pansweep Value low
         ADDW  YA,$98        ; Add Pansweep Change Rate
         MOV   $F880+X,A     ; Set Pansweep Value low
         MOV   A,Y           ; Transfer Y to A
         CMP   A,$F881+X     ; Detect if Pansweep Value changed
         MOV   $F881+X,A     ; Set Pansweep Value high
         BEQ   L0726         ; If no change skip next instruction
         OR    ($DB),($8F)   ; Enable Volume Update in DSP for Current Voice
L0726:   MOV   A,$F701+X     ; A = Pansweep Cycle Counter
         DEC   A             ; Decrement A
         BNE   L0741         ; If counting skip 8 instructions) 
         EOR   $98,#$FF      ; Invert Pansweep Change Rate low
         EOR   $99,#$FF      ; Invert Pansweep Change Rate high
         INCW  $98           ; Increment Pansweep Change Rate
         MOV   A,$98         ; A = Pansweep Change Rate low
         MOV   $F7A0+X,A     ; Set Pansweep Change Rate low
         MOV   A,$99         ; A = Pansweep Change Rate high
         MOV   $F7A1+X,A     ; Set Pansweep Change Rate high
         MOV   A,$F700+X     ; A = Pansweep Cycle Duration
L0741:   MOV   $F701+X,A     ; Set Pansweep Cycle Counter
L0744:   RET                 ; Return

; Process Vibrato and Tremolo
ProcessVibTrem:
         MOV   A,$0151+X     ; A = Vibrato Amplitude
         BEQ   L0751         ; If zero skip 3 instructions
         MOV   $A2,A         ; $A2 = Vibrato Amplitude
         MOV   A,$0111+X     ; A = Vibrato Predelay Counter
         BEQ   ProcessVibrato         ; If zero skip next instruction
L0751:   JMP   ProcessTremolo         ; Jump to Tremolo

ProcessVibrato:
         MOV   A,$F7E1+X     ; A = Vibrato Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F7E0+X     ; A = Vibrato Change Rate low
         MOVW  $C0,YA        ; $C0 = Vibrato Change Rate
         MOV   A,$F841+X     ; A = Vibrato Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F840+X     ; A = Vibrato Value low
         ADDW  YA,$C0        ; Add Vibrato Value to Vibrato Change Rate
         MOVW  $C2,YA        ; Store as Note Pitch Multiplier
         MOV   $F840+X,A     ; Set Vibrato Value low
         MOV   A,Y           ; Transfer Y to A
         CMP   A,$F841+X     ; A == Vibrato Value high
         BEQ   L07C8         ; If zero skip  instructions
         MOV   $F841+X,A     ; Set Vibrato Value high
         ASL   $C2           ; Double Note Pitch Multiplier low
         ROL   $C3           ; Double Note Pitch Multiplier high with carry
         MOV   A,$F8E1+X     ; A = Calculated Frequency Value high
         MOV   Y,#$0F        ; Y = #$0F
         MUL   YA            ; Multiply
         MOVW  $98,YA        ; Set to $98 word, Vibrato Max Range
         MOV   A,$F8E0+X     ; A = Calculated Frequency Value low
         MOV   Y,#$0F        ; Y = #$0F
         MUL   YA            ; Multiply
         MOV   A,Y           ; Transfer Y to A
         MOV   Y,#$00        ; Zero Y
         ADDW  YA,$98        ; Add Vibrato Max Range
         MOVW  $98,YA        ; Set Vibrato Max Range
         MOV   A,$C3         ; A = Note Pitch Multiplier high
         MUL   YA            ; Multiply
         MOVW  $9A,YA        ; Set to $9A word, new Calculated Vibrato Value
         MOV   Y,$98         ; Y = Vibrato Max Range low
         MOV   A,$C3         ; A = Note Pitch Multiplier high
         MUL   YA            ; Multiply
         MOV   A,Y           ; Transfer Y to A
         MOV   Y,#$00        ; Zero Y
         ADDW  YA,$9A        ; Add new Calculated Vibrato Value
         MOVW  $9A,YA        ; Set new Calculated Vibrato Value
         MOV   Y,$C2         ; Y = Note Pitch Multiplier low
         MOV   A,$99         ; A = Vibrato Max Range high
         MUL   YA            ; Multiply
         MOV   A,Y           ; Transfer Y to A
         MOV   Y,#$00        ; Zero Y
         ADDW  YA,$9A        ; Add new Calculated Vibrato Value
         MOVW  $9A,YA        ; Set new Calculated Vibrato Value
         BBC7  $C3,L07B1     ; If not signed skip next instruction
         SUBW  YA,$98        ; Subtract Vibrato Max Range
         MOVW  $9A,YA        ; Set new Calculated Vibrato Value
L07B1:   MOV   A,$F8C1+X     ; A = Calculated Vibrato Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F8C0+X     ; A = Calculated Vibrato Value low
         CMPW  YA,$9A        ; New Vibrato Value == Last Vibrato Value
         BEQ   L07C8         ; If so skip 5 instructions
         MOVW  YA,$9A        ; YA = new Calculated Vibrato Value
         MOV   $F8C0+X,A     ; Set Calculated Vibrato Value low
         MOV   A,Y           ; Transfer Y to A
         MOV   $F8C1+X,A     ; Set Calculated Vibrato Value high
         OR    ($DC),($8F)   ; Enable Pitch Update in DSP for Current Voice
L07C8:   MOV   A,$F6C1+X     ; A = Vibrato Cycle Counter
         DEC   A             ; Decrement Vibrato Cycle Counter
         BNE   L07F9         ; If counting skip 18 instructions
         MOV   A,$F7C1+X     ; A = Max Vibrato Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F7C0+X     ; A = Max Vibrato Change Rate low
         MOVW  $98,YA        ; $98 = Max Vibrato Change Rate
         MOV   A,$C1         ; A = Vibrato Change Rate high
         MOV   $C2,A         ; $C2 = Vibrato Change Rate high
         MOV   A,$0190+X     ; A = Tremolo/Vibrato Gain Counter
         MOV   $9B,A         ; Set $9B
         AND   $9B,#$70      ; $9B = Tremolo Gain Counter
         AND   A,#$07        ; A = Vibrato Gain Counter
         CALL  VolPit_ChgRate         ; Process Change Rate with Mode and Gain Counter
         MOV   $F7E0+X,A     ; Set Vibrato Change Rate low
         MOV   A,Y           ; Transfer Y to A
         MOV   $F7E1+X,A     ; Set Vibrato Change Rate high
         MOV   A,$9A         ; A = Vibrato Gain Counter
         OR    A,$9B         ; Join with Tremolo Gain Counter
         MOV   $0190+X,A     ; Set Tremolo/Vibrato Gain Counter
         MOV   A,$F6C0+X     ; A = Vibrato Cycle Duration
L07F9:   MOV   $F6C1+X,A     ; Set Vibrato Cycle Counter

ProcessTremolo:
         MOV   A,$0170+X     ; A = Tremolo mode/amp
         BEQ   L085D         ; If zero skip to updates and exit
         MOV   $A2,A         ; $A2 = Tremolo mode/amp
         MOV   A,$0131+X     ; A = Tremolo Predelay Counter
         BNE   L085D         ; If predelay active skip to updates and exit
         MOV   A,$F821+X     ; A = Tremolo Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F820+X     ; A = Tremolo Change Rate low
         MOVW  $C0,YA        ; $C0 = Tremolo Change Rate
         MOV   $C2,Y         ; $C2 = Tremolo Change Rate high
         MOV   A,$F861+X     ; A = Tremolo Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F860+X     ; A = Tremolo Value low) 
         ADDW  YA,$C0        ; Add Tremolo Change Rate
         MOV   $F860+X,A     ; Set Tremolo Value low
         MOV   A,Y           ; Transfer Y to A
         CMP   A,$F861+X     ; Detect if Tremolo Value changed
         BEQ   L082B         ; If no change skip 2 instructions
         MOV   $F861+X,A     ; Set Tremolo Value high
         OR    ($DB),($8F)   ; Enable Volume Update in DSP for Current Voice
L082B:   MOV   A,$F6E1+X     ; A = Tremolo Cycle Counter
         DEC   A             ; Decrement A
         BNE   L085A         ; If counting skip 18 instructions
         MOV   A,$F801+X     ; A = Tremolo Max Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F800+X     ; A = Tremolo Max Change Rate low
         MOVW  $98,YA        ; $98 = Tremolo Max Change Rate
         MOV   A,$0190+X     ; A = Tremolo/Vibrato Gain Counter
         MOV   $9B,A         ; Set $9B
         AND   $9B,#$07      ; $9B = Vibrato Gain Counter
         XCN   A             ; Swap high 4 and low 4 bits
         AND   A,#$07        ; A = Tremolo Gain Counter
         CALL  VolPit_ChgRate         ; Process Change Rate with Mode and Gain Counter
         MOV   $F820+X,A     ; Set Tremolo Change Rate low
         MOV   A,Y           ; Transfer Y to A
         MOV   $F821+X,A     ; Set Tremolo Change Rate high
         MOV   A,$9A         ; A = Tremolo Gain Counter
         XCN   A             ; Swap high 4 and low 4 bits
         OR    A,$9B         ; Join with Vibrato Gain Counter
         MOV   $0190+X,A     ; Set Tremolo/Vibrato Gain Counter
         MOV   A,$F6E0+X     ; A = Tremolo Cycle Duration
L085A:   MOV   $F6E1+X,A     ; Set Tremolo Cycle Counter
L085D:   MOVW  YA,$DB        ; YA = DSP Volume/Pitch Update bitmask
         BNE   L0862         ; Branch if not 0, DSP Volume/Pitch Updates
         RET                 ; Return

; Branch DSP Volume/Pitch Updates
VolumePitchDSP:
L0862:   MOV   A,X           ; Transfer X to A
         AND   A,#$0F        ; Mask #$0F
         MOV   $98,A         ; ..
         MOV   A,$98         ; ..
         XCN   A             ; Swap high 4 and low 4 bits
         LSR   A             ; Halve A
         MOV   $99,A         ; Set DSP Register x0
         MOV   A,$8F         ; A = Current Voice
         AND   A,$DB         ; And Enable Volume Update in DSP
         BEQ   L0879         ; if not skip 2 instructions
         TCLR  $00DB,A       ; Test and clear Enable Volume Update in DSP
         CALL  VolumeUpdateDSP         ; DSP Volume Update
L0879:   MOV   A,$8F         ; A = Current Voice
         AND   A,$DC         ; And Enable Pitch Update in DSP
         BEQ   L0887         ; If not exit
         TCLR  $00DC,A       ; Test and clear Enable Pitch Update in DSP
         SET1  $99           ; Set bit 1, DSP Register now x2
         CALL  PitchUpdateDSP         ; DSP Pitch Update
L0887:   RET                 ; Return

; DSP Volume Update
VolumeUpdateDSP:
         MOV   $9A,#$80      ; $9A = #$80
         BBS0  $85,L08B1     ; If mono mode skip 15 instructions
         BBS2  $85,L08B1     ; ??, this bit is never set
         MOV   A,$8F         ; A = Current Voice
         AND   A,$84         ; And System SFX Voice
         BNE   L08B1         ; If voice is off then skip 12 instructions
         MOV   A,$F661+X     ; A = Pan high
         MOV   Y,A           ; Transfer A to Y
         CMP   X,#$10        ; X > #$10
         BCC   L08A7         ; If not SFX skip 4 instructions
         MOV   A,$B2         ; A = SFX Pansweep Value high
         EOR   A,#$80        ; Invert Signature
         CALL  PanWithPansweep         ; Calculate Pan with Pansweep
         MOV   Y,A           ; Y = Calculated SFX Pan
L08A7:   MOV   A,$F881+X     ; A = Pansweep Value high
         CALL  PanWithPansweep         ; Calculate Pan with Pansweep
         EOR   A,#$FF        ; Invert A
         MOV   $9A,A         ; $9A = Calculated Pan
L08B1:   MOV   A,$F621+X     ; A = Voice Volume high
         MOV   Y,A           ; Transfer A to Y
         MOV   $9B,A         ; $9B = Voice Volume high
         MOV   A,$F861+X     ; A = Tremolo Value high
         BEQ   L08C8         ; If zero skip 8 instructions
         ASL   A             ; Double A
         MUL   YA            ; Tremolo * Volume
         BCS   L08C8         ; If carry skip 5 instructions
         MOV   A,Y           ; Transfer Y to A
         ADC   A,$9B         ; Add Voice Volume
         BPL   L08C7         ; If less than #$80 skip next instruction
         MOV   A,#$7F        ; A = #$7F
L08C7:   MOV   Y,A           ; Transfer A to Y
L08C8:   CMP   X,#$10        ; X > #$10
         BCS   L08D9         ; If SFX skip 7 instructions
         MOV   A,$A6         ; A = Master Volume high
         MUL   YA            ; Voice Volume wTremolo * Master Volume
         MOV   A,$8F         ; A = Current Voice
         AND   A,$61         ; And Ignore Song Volume
         BNE   L08E6         ; If so skip 9 instructions) 
         MOV   A,$51         ; A = Song Volume
         BRA   L08E5         ; Skip 6 instructions
L08D9:   MOV   A,$8F         ; A = Current Voice
         AND   A,$84         ; And System SFX Voices
         BEQ   L08E3         ; If not System SFX voice skip 2 instructions
         MOV   A,#$FF        ; A = #$FF
         BRA   L08E5         ; Skip next instruction
L08E3:   MOV   A,$A8         ; A = SFX Volume high
L08E5:   MUL   YA            ; Calculated Volume * SFX Volume/Song Volume
L08E6:   MOV   $9B,Y         ; $9B = Calculated Volume
         MOV   A,$9A         ; A = Calculated Pan
L08EA:   MOV   Y,A           ; Transfer A to Y
         MOV   A,$9B         ; A = Calculated Volume
         MUL   YA            ; Calculated * Calculated Pan
         MOV   A,$8F         ; A = Current Voice
         AND   A,$A4         ; And Muted Voices
         BEQ   L08F6         ; If current voice is not muted skip next instruction
         MOV   Y,#$00        ; Zero Y
L08F6:   MOV   A,Y           ; Transfer Y to A
         MOV   Y,$98         ; Y = Voice Pointer
         MOV   $00C9+Y,A     ; Set Calculated Volume for Voice
         MOV   Y,A           ; Transfer it to Y
         MOV   A,$99         ; A = DSP Register
         MOV   $F2,A         ; Set register address
         CMP   Y,$F3         ; New and current value are the same
         BEQ   L0907         ; If so skip next instruction
         MOV   $F3,Y         ; Write DSP Parameter
L0907:   MOV   A,$9A         ; A = Calculated Pan
         EOR   A,#$FF        ; Invert
         NOT0  $0098         ; ,0 Increment/Decrement Voice Pointer
         INC   $99           ; Next register, x1
         BBC1  $99,L08EA     ; Loop for right channel
         RET                 ; Return

; DSP Pitch Update
PitchUpdateDSP:
         MOV   A,$F8E1+X     ; A = Calculated Frequency Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F8E0+X     ; A = Calculated Frequency Value low
         MOVW  $9A,YA        ; $9A = Calculated Frequency Value
         MOV   A,$F8C1+X     ; A = Calculated Vibrato Value high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F8C0+X     ; A = Calculated Vibrato Value low
         ADDW  YA,$9A        ; Add Vibrato to Frequency
         MOVW  $9A,YA        ; $9A = Final Frequency Value
         CMP   X,#$10        ; X < #$10
         BCC   L0930         ; If not SFX skip 2 instructions
         MOVW  YA,$9A        ; YA = Final Frequency Value
         BRA   L094B         ; Skip 20 instructions
L0930:   MOV   A,$BC         ; A = Master Pitch Multiplier high
         PUSH  P             ; Save Flags
         PUSH  A             ; Save A
         MUL   YA            ; Final Frequency Value high * Master Pitch Multiplier high
         MOVW  $9C,YA        ; $9C = Shifted Final Frequency Value
         POP   A             ; Restore A
         MOV   Y,$9A         ; Y = Final Frequency Value low
         MUL   YA            ; Final Frequency Value low * Master Pitch Multiplier high
         MOV   A,Y           ; Transfer Y to A
         MOV   Y,#$00        ; Zero Y
         ADDW  YA,$9C        ; Add Shifted Final Frequency Value
         POP   P             ; Restore Flags
         BMI   L094B         ; If negative skip 7 instructions
         ASL   A             ; Double A
         PUSH  A             ; Save A
         MOV   A,Y           ; Transfer Y to A
         ROL   A             ; Double A with carry
         MOV   Y,A           ; Transfer A to Y
         POP   A             ; Restore A
         ADDW  YA,$9A        ; Add Final Frequency Value
L094B:   PUSH  X             ; Save X
         MOV   X,$99         ; X = DSP Register
         MOV   $F2,X         ; Set DSP Register
         CMP   A,$F3         ; Compare with current parameter
         BEQ   L0956         ; If no change skip next instruction
         MOV   $F3,A         ; Write parameter
L0956:   INC   X             ; Next register address
         MOV   $F2,X         ; Set register address
         CMP   Y,$F3         ; Compare with current parameter
         BEQ   L095F         ; If no change exit
         MOV   $F3,Y         ; Write parameter
L095F:   POP   X             ; Restore X
         RET                 ; Return

; Process Change Rate with Mode and Gain Counter
;     A = Primary Gain Counter (to use
;  +$98 = Max Change Rate
;   $9A = Primary Gain Counter (decremented by 1 to keep
;   $9B = Secondary Gain Counter (to keep
;   $A2 = mode/amplitude
;  +$C0 = Change Rate
;   $C2 = Change Rate (high byte, duplicate
VolPit_ChgRate:
         MOV   $9A,#$00      ; Zero $9A
         CMP   $A2,#$C0      ; Mode 3 Balanced) 
         BCS   L09B4         ; If so skip to Mode 3
         CMP   $A2,#$80      ; Mode 2 Negative
         BCS   L098D         ; If so skip to Mode 2) 

; Mode 0/1 Positive
         EOR   $C0,#$FF      ; Invert Change Rate low
         EOR   $C1,#$FF      ; Invert Change Rate high
         INCW  $C0           ; Increment Change Rate
         MOV   Y,A           ; Y = Gain Counter
         BEQ   L09DE         ; If zero then exit with YA as Inverted Change Rate
         DEC   A             ; Decrement A, Gain Counter
         MOV   $9A,A         ; Store Primary Gain Counter
         BBS7  $C1,L09DE     ; If inversion is signed exit with YA as Inverted Change Rate
         LSR   $99           ; Halve Max Change Rate high
         ROR   $98           ; Halve Max Change Rate low with carry
         LSR   $99           ; Halve Max Change Rate high
         ROR   $98           ; Halve Max Change Rate low with carry
         MOVW  YA,$98        ; YA = Halve Max Change Rate
         ADDW  YA,$C0        ; Add Inverted Change Rate
         BRA   L09E0         ; Exit

; Mode 2 Negative
L098D:   EOR   $C0,#$FF      ; Invert Change Rate low
         EOR   $C1,#$FF      ; Invert Change Rate high
         INCW  $C0           ; Increment Change Rate
         MOV   Y,A           ; Y = Gain Counter
         BEQ   L09DE         ; If zero then exit with YA as Inverted Change Rate
         DEC   A             ; Decrement A, Gain Counter
         MOV   $9A,A         ; Store Primary Gain Counter
         BBC7  $C1,L09DE     ; If inversion is unsigned exit with YA as Inverted Change Rate
         LSR   $99           ; Halve Max Change Rate high
         ROR   $98           ; Halve Max Change Rate low with carry
         LSR   $99           ; Halve Max Change Rate high
         ROR   $98           ; Halve Max Change Rate low with carry
         EOR   $98,#$FF      ; Invert Change Rate low
         EOR   $99,#$FF      ; Invert Change Rate high
         INCW  $98           ; Increment Change Rate
         MOVW  YA,$98        ; YA = Calculated Change Rate
         ADDW  YA,$C0        ; Add Change Rate
         BRA   L09E0         ; Exit

; Mode 3 Balanced
L09B4:   MOV   Y,A           ; Y = Gain Counter
         BEQ   L09D6         ; If zero then exit with Inverted Change Rate as YA
         DEC   A             ; Decrement A, Gain Counter
         MOV   $9A,A         ; Store Primary Gain Counter
         BBC7  $C1,L09C5     ; If signed skip 3 instructions
         EOR   $C0,#$FF      ; Invert Change Rate low
         EOR   $C1,#$FF      ; Invert Change Rate high
         INCW  $C0           ; Increment Change Rate
L09C5:   LSR   $99           ; Halve Max Change Rate high
         ROR   $98           ; Halve Max Change Rate low with carry
         LSR   $99           ; Halve Max Change Rate high
         ROR   $98           ; Halve Max Change Rate low with carry
         MOVW  YA,$98        ; YA = Halve Max Change Rate
         ADDW  YA,$C0        ; Add Inverted Change Rate
         MOVW  $C0,YA        ; Set new Change Rate
         BBS7  $C2,L09DE     ; If old Change Rate signed exit with YA as new Change Rate
L09D6:   EOR   $C0,#$FF      ; Invert Change Rate low
         EOR   $C1,#$FF      ; Invert Change Rate high
         INCW  $C0           ; Increment Change Rate
L09DE:   MOVW  YA,$C0        ; YA = Change Rate
L09E0:   RET                 ; Return

; Read Port-0 ($2140
; Interrupts $10-$1F Song Loading
; Interrupts $20-$2F System Sound Effects
; Interrupts $80-$FF Various Commands 
ProcessPorts:
         MOV   X,$F4         ; Port-0 $2140
         BEQ   L0A1A         ; Exit if 0
L09E5:   MOV   X,$F4         ; Port-0 $2140
         CMP   X,$F4         ; Port-0 $2140
         BNE   L09E5         ; Loop if not equal
         MOVW  YA,$F6        ; Port-2/3 $2142
         MOVW  $8D,YA        ; Interrupt Command B2-B3
         MOVW  YA,$F4        ; Port-0/1 $2140
         MOVW  $8B,YA        ; Interrupt Command B0-B1
         CALL  EnableTimersResetPorts         ; Enable all timers, reset input from ports 0 and 1
         MOV   $F4,A         ; Port $2140
         MOV   X,A           ; Transfer A to X
         BPL   L09FE         ; Skip next line if Port-0 < $80
         JMP   L0C54         ; Handle Port-0 high bit set
L09FE:   CMP   X,#$10        ; Port-0 < $10
         BCC   L0A1A         ; Exit if so
         CMP   X,#$20        ; Port-0 > $20
         BCS   L0A13         ; Handle Port-0 $20-$2F, System Sound Effects
         AND   A,#$0F        ; A now 0-F (we end up here for Port-0 $10-$1F)
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$1936+Y     ; Pointer, high byte
         PUSH  A             ; Push on stack
         MOV   A,$1935+Y     ; Pointer, low byte
         PUSH  A             ; Push on stack
         RET                 ; Return

; Interrupts $20-$2F, System Sound Effects
L0A13:   CMP   X,#$30        ; Port-0 > $30
         BCS   L0A1A         ; Exit if so
         JMP   L0BF1         ; Play System Sound Effect
L0A1A:   RET                 ; Return

; Interrupt $14: Pause and Play Song
PauseAndNewSong:
         CALL  PauseSong     ; Pause Current Song

; Interrupt $10: Play Song
NewSong:
         MOV   $C4,#$10      ; Pointer to Song Start Offsets = #$10
         BRA   L0A29         ; Branch to switch song

; Interrupt $15: Pause and Play Song from Alternative Start
PauseAndNewSongAlt:
         CALL  PauseSong     ; Pause Current Song

; Interrupt $11: Play Song from Alternative Start
NewSongAlt:
         MOV   $C4,#$20      ; Pointer to Song Start Offsets = #$20
L0A29:   MOV   A,#$FF        ; Parameter
         MOV   Y,#$5C        ; Point to KOF register
         CALL  SetDSPReg     ; Mute all voices
         MOV   A,$76         ; Echo feedback) (Pointless?
         MOV   ($C7),($8C)   ; Current Song Index = Interrupt Command b1
         MOV   A,$8D         ; A = Interrupt command b2
         MOV   $A6,A         ; Set Master Volume high
         MOV   $AD,#$00      ; Zero Master Volume Envelope Counter
         CALL  TransferDataFromSCPU         ; Interrupt $FE: Transfer Data from SCPU 
         MOV   A,#$00        ; Zero A
         MOV   Y,A           ; Zero Y
         MOVW  $83,YA        ; Zero Game and System SFX Voices
         CLR5  $86           ; Clear Fast Forward
         CLR3  $85           ; Clear Master Volume Envelope Output Mode
         MOVW  $D9,YA        ; Zero Paused Voices & Paused Game SFX
         MOV   $DD,A         ; Zero Enable Conditional Jump
         CMP   ($C6),($C7)   ; Is Paused Song same as Current Song
         BNE   L0A92         ; Skip if not
         CALL  TransferPausedDataBack         ; Transfer Paused Data back to Current Data
         MOV   A,$52         ; A = Enabled Voices
         BEQ   L0A92         ; If none skip  instructions
         AND   $8A,#$E0      ; Reset Noise Generator Frequency
         OR    ($8A),($62)   ; Add Noise Clock Value
         MOV   X,#$00        ; Zero X, First Voice Pointer
         MOV   $8F,#$01      ; Set Current Voice = 1
L0A63:   INC   $25+X         ; Increment Note Duration Counter
         MOV   $A3,X         ; Set Voice Pointer
         CALL  InstrumentUpdateDSP         ; Update DSP SRCN for Voice with Instrument
         MOV   A,X           ; Transfer X to A
         XCN   A             ; Swap high 4 and low 4 bits
         LSR   A             ; Halve A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,#$00        ; Zero A
         CALL  SetDSPReg     ; Mute left channel volume
         INC   Y             ; Increment Y, DSP Reg. x1
         CALL  SetDSPReg     ; Mute right channel volume
         INC   Y             ; Increment Y, DSP Reg. x2
         MOV   $99,Y         ; Set DSP Register
         CALL  PitchUpdateDSP         ; DSP Pitch Update
         INC   X             ; Increase X
         INC   X             ; Increase X, next Voice Pointer
         ASL   $8F           ; Next voice
         BNE   L0A63         ; Loop for all voices
         MOV   A,#$00        ; Zero A
         MOV   $54,A         ; Zero Enable Echo
         MOV   $56,A         ; Zero Enable Noise
         MOV   $58,A         ; Zero Enable Pitch Mod
         MOV   ($22),($23)   ; Set key-on voices from Paused key-on voices
         MOV   $24,A         ; Zero Key-Off Voices
         BRA   L0AFC         ; Skip  instructions
L0A92:   MOV   A,#$00        ; Zero A
         MOV   Y,A           ; Zero Y
         MOV   $52,A         ; Zero Enabled Voices
         MOVW  $53,YA        ; Zero Enable Echo and Enable Echo SFX
         MOVW  $55,YA        ; Zero Enable Noise and Enable Noise SFX
         MOVW  $57,YA        ; Zero Enable Pitch Mod and Enable Pitch Mod SFX
         MOV   $22,A         ; Zero key-on voices
         MOV   $24,A         ; Zero key-off voices
         MOV   $23,A         ; Zero key-on voices for paused song
         MOV   $59,A         ; Zero Disable Key Off at End of Note
         MOV   $5B,A         ; Zero Enable Slur
         MOV   $5F,A         ; Zero Enable Drum Roll
         MOV   $61,A         ; Zero Ignore Song Volume
         MOV   $46,#$01      ; Current Tempo = 1
         MOV   $47,#$FF      ; Tempo Counter = $FF
         MOV   $51,#$FF      ; Song Volume = #$FF
         MOV   $7B,A         ; Echo Feedback Envelope Counter = 0
         MOV   Y,$C4         ; Pointer to Voice Song Script Pointers
         MOV   X,#$10        ; X = 16
L0ABA:   MOV   A,$1C03+Y     ; A = Voice Song Script Pointer
         MOV   $01+X,A       ; Set Voice Song Script Pointer
         DEC   Y             ; Decrement Y
         DEC   X             ; Decrement X
         BNE   L0ABA         ; Loop for 8 pointers, 2 bytes each
         MOV   A,$1C00       ; A = Size of Song Script low
         MOV   $00,A         ; Store Size of Song Script low
         MOV   A,$1C01       ; A = Size of Song Script high
         MOV   $01,A         ; Store Size of Song Script high
         MOV   A,#$24        ; A = #$24
         MOV   Y,#$1C        ; Y = #$1C
         SUBW  YA,$00        ; $1C24 - Size of Song Script
         MOVW  $00,YA        ; Store calculated size
         MOV   X,#$0E        ; X = 13
         MOV   $8F,#$80      ; Master Pitch Multiplier Envelops Counter = $80
         MOV   A,$1C02       ; A = Pointer to first song byte low
         MOV   Y,$1C03       ; Y = Pointer to first song byte high
         MOVW  $98,YA        ; $98 = Pointer to first song byte
L0AE2:   MOV   A,$02+X       ; Voice Script Pointer low
         MOV   Y,$03+X       ; Voice Script Pointer high
         CMPW  YA,$98        ; Voice Script Pointer is First Song Byte
         BEQ   L0AF6         ; If so branch
         OR    ($52),($8F)   ; Enable Current Voice
         ADDW  YA,$00        ; Add Song Script Offset
         MOV   $02+X,A       ; Set Voice Script Pointer low
         MOV   $03+X,Y       ; Set Voice Script Pointer high
         CALL  ZeroModulation         ; Zero Modulation Effects
L0AF6:   DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next voice pointer
         LSR   $8F           ; Next voice
         BNE   L0AE2         ; Loop 13
L0AFC:   MOV   ($87),($53)   ; Set echo enabled voices
         MOV   ($88),($55)   ; Set noise enabled voices
         MOV   ($89),($57)   ; Set pitch modulation enabled voices
         MOV   A,#$00        ; Zero A
         MOV   Y,A           ; Zero Y
         MOVW  $DB,YA        ; Clear pitch and volume updates in DSP
         MOV   X,#$FF        ; Set X to #$FF
         MOV   SP,X          ; Set stack pointer to $FF
         MOV   A,$FD         ; Counter-0; gets reset
         JMP   L0272         ; Jump to main loop

; Zero Modulation Effects (Pansweep, Vibrato, Tremolo, Detune, Transposition)
ZeroModulation:
         MOV   A,X           ; Transfer X to A
         ASL   A             ; Double A
         MOV   $26+X,A       ; Store Pointer to Loop Count
         MOV   A,#$00        ; Zero A
         MOV   $0150+X,A     ; Zero Pitch Envelope Target
         MOV   $F780+X,A     ; Zero Pitch Envelope Change Rate low
         MOV   $F781+X,A     ; Zero Pitch Envelope Change Rate high
         MOV   $F8A0+X,A     ; Zero Pitch Envelope Change Rate fraction
         MOV   $0151+X,A     ; Zero Vibrato Amplitude
         MOV   $0170+X,A     ; Zero Tremolo Mode/Amplitude
         MOV   $0171+X,A     ; Zero Pansweep
         MOV   $F880+X,A     ; Zero Pansweep Value low
         MOV   $F881+X,A     ; Zero Pansweep Value high
         MOV   $F760+X,A     ; Zero Detune
         MOV   $F721+X,A     ; Zero Transposition
         INC   A             ; Increment A, 1
         MOV   $25+X,A       ; Set Note Duration Counter
         RET                 ; Return

; Interrupt $18: Game Sound Effect
GameSFX:
         MOVW  YA,$D9        ; YA = Paused Voices bitmask
         BEQ   L0B42         ; If no voices paused skip next instruction
         RET                 ; Return
L0B42:   MOV   ($90),($8C)   ; $90 = SFX Index
         MOV   $91,#$00      ; $91 = #$00
         ASL   $90           ; Double $90
         ROL   $91           ; Double $91 with carry from $90
         ASL   $90           ; Double $90
         ROL   $91           ; Double $91 with carry from $90
         MOV   A,#$00        ; Zero A
         MOV   Y,#$2C        ; YA = #$2C00
         ADDW  YA,$90        ; YA = #$2C00 + SFX Index Multiplied
         MOVW  $90,YA        ; $90 = Pointer to SFX Pointer
         MOV   X,#$1E        ; X = #$1E, Pointer to last Voice
         MOV   $8F,#$80      ; Current Voice = bit 7, last voice
         MOV   A,$83         ; A = Game SFX voices bitmask
         BNE   L0B65         ; If active skip 2 instructions
         MOV   A,$84         ; A = System SFX voices bitmask
         EOR   A,#$F0        ; Invert high 4 bits
L0B65:   MOV   $A1,A         ; Set $A1
L0B67:   MOV   A,$A1         ; ..
         AND   A,$8F         ; Isolate Current Voice
         BNE   L0B74         ; If active skip 4 instructions
         LSR   $8F           ; Next voice
         DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next voice pointer
         BBC5  $8F,L0B67     ; Loop for 2 voices
L0B74:   MOV   Y,#$03        ; Y = 3
         MOV   $A1,#$00      ; $A1 = 0
L0B79:   MOV   A,($90)+Y     ; A = SFX Pointer high, voice B/A
         BEQ   L0BB1+1       ; If zero skip  instructions
         MOV   $03+X,A       ; Set Voice Script Pointer high
         DEC   Y             ; Decrement Y
         MOV   A,($90)+Y     ; A = SFX Pointer low, voice B/A
         MOV   $02+X,A       ; Set Voice Script Pointer low
         OR    ($A1),($8F)   ; 
         CALL  ZeroModulation         ; Zero Modulation Effects
         INC   $25+X         ; Increment Note Duration Counter
         MOV   A,#$41        ; A = #$41
         MOV   $F621+X,A     ; Voice Volume high = #$41
         MOV   A,#$80        ; A = #$80
         MOV   $F661+X,A     ; Absolute Pitch = #$80
         MOV   A,#$03        ; A = #$03
         MOV   $F600+X,A     ; Octave = #$03
         MOV   A,#$00        ; Zero A
         MOV   $F6A0+X,A     ; Volume Envelope Counter = 0
         MOV   $F6A1+X,A     ; Pan Envelope Counter = 0
         PUSH  Y             ; Save Y
         CALL  EndOfSongScript         ; Track Command $EB: End of Song Script
         MOV   A,#$04        ; A = 4
         CALL  TrkCmd_SetInstrument         ; Track Command $DC: Set Instrument
         POP   Y             ; Restore Y
         DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next Voice Pointer
         LSR   $8F           ; Next Voice
L0BB1:   MOV   A,#$DC        ; .. $DC DEC Y, from branch at $0B7B
         DEC   Y             ; Decrement Y
         BPL   L0B79         ; Loop for second SFX voice
         MOV   A,$83         ; A = Game SFX Voices
         OR    A,$A1         ; with ?
         TCLR  $0022,A       ; Clear Voice Key-On
         TCLR  $005A,A       ; Clear Disable Key-Off at End of Note
         TCLR  $005C,A       ; Clear Slur
         TCLR  $0060,A       ; Clear Drum Roll
         TSET  $0024,A       ; Mute voice
         MOV   ($A2),($83)   ; Set $A2 as Game SFX Voices
         MOV   X,#$1E        ; X = Voice Pointer for Last Voice
         MOV   $8F,#$80      ; Set Current Voice to Last Voice) 
L0BD1:   ASL   $A2           ; Shift Voices
         BCC   L0BD8         ; If no carry skip next instruction
         CALL  EndOfSongScript         ; Track Command $EB: End of Song Script
L0BD8:   DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next Voice Pointer
         LSR   $8F           ; Next voice
         BBC3  $8F,L0BD1     ; Loop for ?
         MOV   A,$A1         ; 
         MOV   $83,A         ; Set Game SFX Voices
         TCLR  $0087,A       ; Disable echo for voice
         TCLR  $0089,A       ; Disable pitch modulation for voice
         TCLR  $0088,A       ; Disable noise for voice
         MOV   A,$8D         ; A = Interrupt command b2
         MOV   $B2,A         ; Set Sound Effect Pan high
         RET                 ; Return

; Play System Sound Effect
L0BF1:   MOVW  YA,$D9        ; YA = Paused Voices and Paused SFX Voices
         BNE   L0C53         ; If paused voices exit
         MOV   A,X           ; Transfer X to A
         AND   A,#$0F        ; A = System SFX Index
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   X,#$20        ; X = #$20
         MOV   A,$83         ; A = Game SFX Voices
         OR    A,$84         ; with System SFX Voices
         AND   A,#$F0        ; 
         MOV   $8F,#$80      ; Set Current Voice = bit 7, last voice
         CMP   A,#$F0        ; 
         BEQ   L0C15         ; If so skip 7 instructions
L0C09:   DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next Voice Pointer
         ASL   A             ; Shift SFX voices
         BCC   L0C22         ; If not active skip 10 instructions
         LSR   $8F           ; Next voice
         BBC3  $8F,L0C09     ; Loop for ? voices
         BRA   L0C22         ; Skip 7 instructions
L0C15:   DEC   X             ; Decrement X
         DEC   X             ; Decrement X
         MOV   A,$84         ; A = System SFX Voices
         AND   A,$8F         ; Isolate Current Voice
         BNE   L0C22         ; If used skip 2 instructions) 
         LSR   $8F           ; Next Voice
         BBC3  $8F,L0C15     ; Loop for ? voices
L0C22:   MOV   A,$17E0+Y     ; Pointer to System Sound Effect Script high
         BEQ   L0C53         ; Exit if zero
         MOV   $03+X,A       ; Set Voice Script Pointer high
         MOV   A,$17DF+Y     ; Pointer to System Sound Effect Script low
         MOV   $02+X,A       ; Set Voice Script Pointer low
         CALL  ZeroModulation         ; Zero Modulation Effects
         INC   $25+X         ; Increment Note Duration Counter
         CALL  EndOfSongScript         ; Track Command $EB: End of Song Script
         MOV   A,$8F         ; A = Current Voice
         TCLR  $005A,A       ; Clear Disable Key-Off at End of Note SFX
         TCLR  $005C,A       ; Clear Enable Slur SFX
         TCLR  $0060,A       ; Clear Enable Drum Roll SFX
         TSET  $0024,A       ; Mute voice
         TCLR  $0022,A       ; Clear voice key-on
         TCLR  $0087,A       ; Disable echo for voice
         TCLR  $0089,A       ; Disable pitch modulation for voice
         TCLR  $0088,A       ; Disable noise for voice
         OR    ($84),($8F)   ; Set System SFX Voice for Current Voice
L0C53:   RET                 ; Return

; Port-0 with high bit set has value of 0-$1F ($80-$8F and $F0-$FF
L0C54:   CMP   X,#$F0        ; Port-0 > $F0
         BCS   L0C5C         ; Skip 2 lines if so
         CMP   X,#$90        ; Port-0 > $90
         BCS   L0C69         ; Exit if so
L0C5C:   MOV   A,X           ; Transfer X to A
         AND   A,#$1F        ; A is 0-$1F
         ASL   A             ; Double it
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$1956+Y     ; Pointer, high byte
         PUSH  A             ; Push on stack
         MOV   A,$1955+Y     ; Pointer, low byte
         PUSH  A             ; Push on stack
L0C69:   RET                 ; Return

; Interrupts $80, $81, $82: Set master/sound effect volume to yy (w/ envelope xx
MasterAndSFXVol:
L0C6A:   MOV   A,$8B         ; A = interrupt command b0
         CMP   A,#$82        ; A >= #$82
         BCS   L0C75+1       ; If so skip 3 instructions
         MOV   Y,$8D         ; Y = Interrupt command b2, Volume Value
         BNE   L0C75+1       ; If non-zero skip 1 instruction
         SETC                ; Set Carry
L0C75:   MOV   Y,#$60        ; .. CLRC Clear Carry if branch to #$60
         MOV3  $0085,C       ; Enable/Disable Master Volume Envelope Output Mode
         MOV   X,#$00        ; Zero X
         BBC0  $8B,L0C82     ; If Interrupt $80 or $82 skip 2 instructions
         INC   A             ; Increment A, run once, no loop
         BRA   L0C8F         ; Skip 7 instructions
L0C82:   BBC1  $8B,L0C8A     ; If Interrupt $80 or $81 skip 3 instructions
         INC   A             ; Increment A, run once, no loop
         MOV   X,#$02        ; X = 2, Point to SFX Volume
         BRA   L0C8F         ; Skip 3 instructions
L0C8A:   INC   $8B           ; Increment loop counter
         CLRC                ; Clear Carry for addition
         ADC   A,#$03        ; Add 3 to A, will now loop once for SFX
L0C8F:   MOV   $98,A         ; Set $98 as loop end count
L0C91:   MOV   Y,$8D         ; Y = Interrupt command b2, Volume Value
         MOV   A,$8C         ; A = Interrupt command b1, Envelope Duration
L0C95:   MOV   $AD+X,A       ; Set Master/SFX Envelope Counter
         BNE   L0CA3         ; If envelope skip 5 instructions
         MOV   $A6+X,Y       ; Set Master/SFX Volume high
         MOV   $A5+X,A       ; Zero Master/SFX Volume low
         MOV   $AA+X,A       ; Zero Master/SFX Volume Envelope Change Rate high
         MOV   $A9+X,A       ; Zero Master/SFX Volume Envelope Change Rate low
         BRA   L0CB6         ; Skip 11 instructions
L0CA3:   MOV   A,Y           ; A = new Volume high
         SETC                ; Set Carry for subtraction
         SBC   A,$A6+X       ; Subtract old Master/SFX Volume high
         BEQ   L0C95         ; If no change set new Value and zero envelope
         PUSH  X             ; Save X
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         POP   X             ; Restore X
         MOV   $A9+X,A       ; Set Master/SFX Volume Envelope Change Rate low
         MOV   $AA+X,Y       ; Set Master/SFX Volume Envelope Change Rate high
         MOV   A,#$00        ; Zero A
         MOV   $A5+X,A       ; Zero Master/SFX Envelope Data
L0CB6:   INC   $8B           ; Increment loop counter
         CMP   ($8B),($98)   ; Loop if Interrupt $80, Master and SFX
         BEQ   L0CC1         ; Enable Volume Update and exit
         INC   X             ; Increment X
         INC   X             ; Increment X, next Byte Pointer
         BRA   L0C91         ; Loop
L0CC1:   MOV   $DB,#$FF      ; Enable Volume Update in DSP for all voices
         RET                 ; Return

; Calculate Change Rate to YA
;   A = The distance to tavel (signed)
;   X = The number of steps to travel A's distance
;   Carry = Signature (set/clear, positive/negative)
ChgRateToYA:
         PUSH  P             ; Save Flags
         BCS   L0CCB         ; If positive skip 2 instructions
         EOR   A,#$FF        ; Invert A
         INC   A             ; Increment A
L0CCB:   MOV   X,$8C         ; X = Interrupt command b1
         MOV   Y,#$00        ; Zero Y
         DIV   YA,X          ; YA / X => A
         MOV   $C1,A         ; Set Calculated Change Rate low
         MOV   A,#$00        ; Zero A
         DIV   YA,X          ; YA / X => A
         MOV   $C0,A         ; Set Calculated Change Rate high
         POP   P             ; Restore Flags
         BCS   L0CE2         ; If positive skip 3 instructions
         EOR   $C0,#$FF      ; Invert Calculated Change Rate low
         EOR   $C1,#$FF      ; Invert Calculated Change Rate high
         INCW  $C0           ; Increment Calculated Change Rate
L0CE2:   MOVW  YA,$C0        ; YA = Calculated Change Rate
         RET                 ; Return

; Interrupt $83: Set sound effect pan to yy (w/ envelope xx)
SFXPan:
         MOV   Y,$8D         ; Y = Interrupt command b2, Pan Value
         MOV   A,$8C         ; A = Interrupt command b1, Envelope Duration
L0CE9:   MOV   $B5,A         ; Set Sound Effect Pan Envelope Counter
         BNE   L0CF7         ; If envelope skip 5 instructions
         MOV   $B2,Y         ; Set Sound Effect Pan high
         MOV   $B1,A         ; Set Sound Effect Pan low
         MOV   $B4,A         ; Set SFX Pan Envelope Change Rate high
         MOV   $B3,A         ; Set SFX Pan Envelope Change Rate low
         BRA   L0D05         ; Enable volume updates and exit
L0CF7:   MOV   A,Y           ; A = new Sound Effect Pan high
         SETC                ; Set Carry for subtraction
         SBC   A,$B2         ; Subtract old Sound Effect Pan high
         BEQ   L0CE9         ; If no change set Sound Effect Pan and zero envelope
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOVW  $B3,YA        ; Set Sound Effect Pan Envelope Change Rate
         MOV   $B1,#$00      ; Zero Sound Effect Pan
L0D05:   MOV   $DB,#$FF      ; Enable volume updates for all voices
         RET                 ; Return

; Interrupt $84: Set Tempo Ratio (yy = envelope duration, xx = tempo ratio, signed fraction)
TempoRatio:
         MOV   Y,$8D         ; Y = Interrupt command b2, Tempo Ratio
         MOV   A,$8C         ; A = Interrupt command b1, Envelope Duration
L0D0D:   MOV   $BA,A         ; Set Tempo Ratio Envelope Counter
         BNE   L0D1B         ; If envelope skip 5 instructions
         MOV   $B7,Y         ; Set Tempo Ratio high
         MOV   $B6,A         ; Zero Tempo Ratio low
         MOV   $B9,A         ; Zero Tempo Ratio Envelope Change Rate high
         MOV   $B8,A         ; Zero Tempo Ratio Envelope Change Rate low
         BRA   L0D31         ; Enable Pitch update and exit
L0D1B:   MOV   ($A2),($B7)   ; Set $A2 to old Tempo Ratio high
         EOR   $A2,#$80      ; Invert Signature
         MOV   A,Y           ; A = new Tempo Ratio high
         EOR   A,#$80        ; Invert Signature
         SETC                ; Set Carry for subtraction
         SBC   A,$A2         ; Subtract old Tempo Ratio from new Tempo Ratio
         BEQ   L0D0D         ; If no change set Tempo Ratio and zero Envelope
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOVW  $B8,YA        ; Set Tempo Ratio Envelope Change Rate
         MOV   $B6,#$00      ; Zero Tempo Ratio low) 
L0D31:   MOV   $DC,#$FF      ; Enable Pitch Update in DSP for all voices
         RET                 ; Return

; Interrupt $85: Change Pitch to yy (w/ envelope xx)
MasterPitch:
         MOV   Y,$8D         ; Y = interrupt command b2, Pitch Multiplier
         MOV   A,$8C         ; A = interrupt command b1, Envelope Duration
L0D39:   MOV   $BF,A         ; Set Master Pitch Multiplier Envelope Counter
         BNE   L0D47         ; If envelope skip 5 instructions
         MOV   $BC,Y         ; Set Master Pitch Multiplier high
         MOV   $BB,A         ; Zero Master Pitch Multiplier low
         MOV   $BE,A         ; Zero Master Pitch Multiplier Change Rate high
         MOV   $BD,A         ; Zero Master Pitch Multiplier Change Rate low
         BRA   L0D5D         ; Skip 10 instructions
L0D47:   MOV   ($A2),($BC)   ; Set $A2 to old Master Pitch Multiplier high
         EOR   $A2,#$80      ; Invert Signature
         MOV   A,Y           ; A = new Master Pitch Multiplier high
         EOR   A,#$80        ; Invert Signature
         SETC                ; Set Carry for subtraction
         SBC   A,$A2         ; Subtract old Master Pitch Mul. from new Master Pitch Mul.
         BEQ   L0D39         ; If no change set Master Pitch Mul. and zero change rate
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOVW  $BD,YA        ; Set Master Pitch Multiplier Change Rate
         MOV   $BB,#$00      ; Zero Master Pitch Multiplier
L0D5D:   MOV   $DC,#$FF      ; Enable Pitch Update in DSP for all voices
         RET                 ; Return

; Interrupt $F3: Enable/Disable Mono Mode
ToggleMonoMode:
         MOV   A,$8C         ; A = interrupt command b1
         BNE   L0D69         ; If non-zero skip 2 instructions
         CLR0  $85           ; Disable Mono Mode
         BRA   L0D6B         ; Skip next instruction
L0D69:   SET0  $85           ; Enable Mono Mode
L0D6B:   MOV   $DB,#$FF      ; Enable Volume Update in DSP for all voices
         RET                 ; Return

; Interrupt $F0, $F1, $F2: Stop song & sound effect
StopPlayback:
         BBS1  $8B,L0D9F     ; If $F2, skip 20 instructions
         MOV   A,$83         ; A = Game Sound Effect Voices Bitmask
         OR    A,$84         ; with System Sound Effect Voices Bitmask
         EOR   A,#$FF        ; Invert A
         TSET  $0024,A       ; Mute voice
         TCLR  $0022,A       ; Clear voice key-on
         TCLR  $0087,A       ; Disable echo for voice
         TCLR  $0089,A       ; Disable pitch modulation for voice
         TCLR  $0088,A       ; Disable noise for voice
         MOV   A,#$00        ; Zero A
         MOV   $52,A         ; Zero Enabled Voices Bitmask
         MOV   $D9,A         ; Zero Paused Voices Bitmask
         MOV   $53,A         ; Zero Enable Echo Bitmask
         MOV   $57,A         ; Zero Enable Pitch Mod Bitmask
         MOV   $55,A         ; Zero Enable Noise Bitmask
         MOV   $A0,A         ; Zero Active Voices
         DEC   A             ; A = #$FF
         MOV   $C6,A         ; Reset Paused Song
         MOV   $C7,A         ; Reset Current Song
         CLR3  $85           ; Clear Master Volume Envelope Output Mode
         BBS0  $8B,L0DC2     ; If Interrupt $F1, exit
L0D9F:   MOV   A,$83         ; A = Game Sound Effect Voices bitmask
         TSET  $0024,A       ; Mute voice
         TCLR  $0022,A       ; Clear Key-On Bitmask
         TCLR  $00DB,A       ; Clear Enable Volume Update in DSP Bitmask
         TCLR  $00DC,A       ; Clear Enable Pitch Update in DSP Bitmask
         MOV   $A1,A         ; Set Game SFX Voices bitmask
         MOV   X,#$1E        ; X = #$1E
         MOV   $8F,#$80      ; Bitmask for current voice
L0DB4:   ASL   $A1           ; Push current voice from bitmask to carry
         BCC   L0DBB         ; If no carry, skip next instruction
         CALL  EndOfSongScript         ; Track Command $EB: End of Song Script
L0DBB:   DEC   X             ; Decrement X
         DEC   X             ; Decrement X
         LSR   $8F           ; Next Voice
         BBC3  $8F,L0DB4     ; Loop for all voices
L0DC2:   RET                 ; Return

; Interrupt $F4: Mute Voices (x: voices to mute, bitmask)
MuteVoices:
         MOV   ($A4),($8C)   ; Muted Voices from interrupt b1
         MOV   $DB,#$FF      ; Enable volume update in DSP for all voices
         RET                 ; Return

; Interrupt $F5: Pause/Unpause music (0 = unpause, 1 = pause)
SongPauseToggle:
         MOV   A,$8C         ; interrupt command b1
         BEQ   L0E16         ; If zero, Unpause
         MOV   Y,#$05        ; Y = $05
L0DD0:   MOV   $F2,Y         ; Voice ADSR register address
         MOV   A,$F3         ; A = Current Data
         AND   A,#$7F        ; Remove high bit
         MOV   $F3,A         ; Store Data
         MOV   A,Y           ; Transfer Y to A
         CLRC                ; Clear Carry for addition
         ADC   A,#$10        ; Next voice
         MOV   Y,A           ; Transfer A to Y
         BPL   L0DD0         ; Loop unless 8 voices done
         MOV   X,#$00        ; Zero X
         MOV   Y,#$00        ; Zero Y
L0DE3:   MOV   $F2,Y         ; Voice Volume Left register address
         MOV   $F3,X         ; Store Zero
         INC   Y             ; Next register
         MOV   $F2,Y         ; Voice Volume Right register address
         MOV   $F3,X         ; Store Zero
         MOV   A,Y           ; Transfer Y to A
         CLRC                ; Clear Carry for addition
         ADC   A,#$0F        ; Point to next voice
         MOV   Y,A           ; Transfer A to Y
         BPL   L0DE3         ; Loop unless 8 voices done
         MOV   ($98),($52)   ; Enabled Voices Bitmask
         MOV   ($99),($83)   ; Game Sound Effect Voices Bitmask
         MOVW  YA,$98        ; YA = Active Voices Word
         BEQ   L0E07         ; Skip 6 instructions if no voices active) 
         MOVW  $D9,YA        ; Set Paused Voices Bitmask
         MOV   A,#$00        ; Zero A
         MOV   $52,A         ; Zero Enabled Voices Bitmask
         MOV   $83,A         ; Zero Game Sound Effect Voices Bitmask
         MOV   $DB,A         ; Zero Enable Volume Update in DSP Bitmask
L0E07:   MOV   $22,A         ; Zerp Key-On Voices
         MOV   Y,#$10        ; Y = 16
L0E0B:   MOV   $00C8+Y,A     ; Zero Calculated Volume for Voice
         DBNZ  Y,L0E0B       ; Decrease Y, loop for 8 voices 2 bytes each
         MOV   X,#$FF        ; Set X to #$FF
         MOV   SP,X          ; Set stack pointer to $FF
         JMP   L0272         ; Jump to main loop

; Unpause Music
L0E16:   MOV   Y,#$05        ; Y = 5, DSP ADSR ch0
L0E18:   MOV   $F2,Y         ; Set register address
         MOV   A,$F3         ; Current setting
         OR    A,#$80        ; Enable ADSR
         MOV   $F3,A         ; Save changes
         MOV   A,Y           ; Transfer Y to A
         CLRC                ; Clear Carry for addition
         ADC   A,#$10        ; Point to next voice
         MOV   Y,A           ; Transfer A to Y
         BPL   L0E18         ; Loop unless 8 voices done
         MOVW  YA,$D9        ; YA = Paused Voices and SFX Paused Voices
         BEQ   L0E37         ; Exit if no voices paused
         MOV   $DB,#$FF      ; Enable volume update in DSP for all voices
         MOV   $52,A         ; Set Enabled Voices
         MOV   $83,Y         ; Set Game Sound Effect Voices
         MOV   A,#$00        ; Zero A
         MOV   Y,A           ; Zero Y
         MOVW  $D9,YA        ; Zero Paused Voices and SFX Paused Voices
L0E37:   RET                 ; Return

; Interrupt $FE: Transfer Data from SCPU
;   Parameter 00: no transfer
;   Parameter 01: transfer one byte at a time
;   Parameter 02: transfer two bytes at a time
;   Parameter 03: transfer three bytes at a time
;   Parameter 07: move chunk
;   Parameter F0: stop transfer
TransferDataFromSCPU:
         MOV   X,$F4         ; Port $2140
         BEQ   TransferDataFromSCPU         ; Loop until $2140 has value
         CMP   X,$F4         ; Port $2140
         BNE   TransferDataFromSCPU         ; Loop unless value is consistent
L0E40:   MOV   A,$F5         ; Port $2141
         CMP   A,#$F0        ; Is #$F0
         BEQ   L0E71         ; If so push back to $2140 and continue
         MOV   $F5,A         ; Set Port $2141
         AND   A,#$07        ; Parameter 0-7
         ASL   A             ; Double A
         PUSH  A             ; Save A
         MOVW  YA,$F6        ; Port $2142 and $2143
         MOVW  $90,YA        ; Set $90, Write Address
         POP   A             ; Restore A
         CMP   Y,#$1A        ; Port $2143 > #$1A
         BCC   L0E59         ; If so skip 2 instructions
         CMP   Y,#$F5        ; Port $2143 > #$F5
         BCC   L0E5B         ; If so skip next instruction
L0E59:   MOV   A,#$00        ; Zero A
L0E5B:   MOV   $F4,X         ; Set Port $2140
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$11A0+Y     ; A = Pointer high
         PUSH  A             ; Save A
         MOV   A,$119F+Y     ; A = Pointer low
         PUSH  A             ; Save A
L0E66:   CMP   X,$F4         ; Port $2140
         BEQ   L0E66         ; Loop until $2140 has value
L0E6A:   MOV   X,$F4         ; Port $2140
         CMP   X,$F4         ; Port $2140
         BNE   L0E6A         ; Loop until $2140 has cleared
         RET                 ; Return
L0E71:   MOV   $F4,X         ; Set Port $2140
         JMP   EnableTimersResetPorts         ; Enable all timers, reset input from ports 0 and 1

; Interrupt $FE/$03: Transfer three bytes at a time
TransferThree:
L0E76:   MOV   Y,#$00        ; Zero Y
         MOV   A,$F5         ; A = Port-1 $2141
         MOV   ($90)+Y,A     ; Set 1st transfer byte
         MOV   $F4,X         ; Set Port-0, $2140
         INC   Y             ; Invrement Y
         MOV   A,$F6         ; A = Port-2 $2142
         MOV   ($90)+Y,A     ; Set 2nd transfer byte
         INC   Y             ; Increment Y
         MOV   A,$F7         ; A = Port-3 $2143
         MOV   ($90)+Y,A     ; Set 3rd transfer byte
         CLRC                ; Clear Carry for addition
         ADC   $90,#$03      ; Increment Write Address by 3
         ADC   $91,#$00      ; Apply Carry
         CMP   $91,#$F5      ; Reached Address $F500
         BEQ   L0F13         ; If so goto Interrupt $FE/$00: No Transfer
L0E94:   CMP   X,$F4         ; Compare Port-0 $2140
         BEQ   L0E94         ; Loop until $2140 has value
L0E98:   MOV   X,$F4         ; X = Port-0 $2140
         CMP   X,$F4         ; Compare Port-0 $2140
         BNE   L0E98         ; Loop until $2140 is consistent
         MOV   A,#$FF        ; A = #$FF, Reset Code
         MOV   Y,#$F0        ; Y = #$F0, Stop Transfer
         CMP   Y,$F4         ; Is Port-0 $2140 equal to #$F0, Stop Transfer
         BEQ   L0EAF         ; If stop transfer loop for next param
         CMPW  YA,$F4        ; Compare #$FF/#$F0 to Port-0/1 $2140 and $2141
         BNE   L0E76         ; Loop if not
         MOV   $8C,Y         ; Set Interrupt command b1 to #$F0
         JMP   L0FA3         ; Interrupt $FF/$F0: Reset SPC
L0EAF:   JMP   L0E40         ; Loop for next parameter

; Interrupt $FE/$02: Transfer two bytes at a time
TransferTwo:
L0EB2:   MOV   Y,#$00        ; Zero Y
         MOV   A,$F6         ; Port $2142
         MOV   ($90)+Y,A     ; Set 1st transfer byte
         MOV   $F4,X         ; Port $2140
         INC   Y             ; Increment Y, next transfer pointer
         MOV   A,$F7         ; Port $2143
         MOV   ($90)+Y,A     ; Set 2nd transfer byte
         INCW  $90           ; Increment Write Address
         INCW  $90           ; Increment Write Address
         CMP   $91,#$F5      ; Reached Address $F500
         BEQ   L0F13         ; If so goto Interrupt $FE/$00: No Transfer
L0EC8:   CMP   X,$F4         ; Compare Port-0 $2140
         BEQ   L0EC8         ; Loop until $2140 has value
L0ECC:   MOV   X,$F4         ; X = Port-0 $2140
         CMP   X,$F4         ; Compare Port-0 $2140
         BNE   L0ECC         ; Loop until $2140 is consistent
         MOV   A,#$FF        ; A = #$FF, Reset Code
         MOV   Y,#$F0        ; Y = #$F0, Stop Transfer
         CMP   Y,$F4         ; Is Port-0 $2140 equal to #$F0, Stop Transfer
         BEQ   L0EE3         ; If stop transfer loop for next param
         CMPW  YA,$F4        ; Compare #$FF/#$F0 to Port-0/1 $2140 and $2141
         BNE   L0EB2         ; Loop if not
         MOV   $8C,Y         ; Set Interrupt command b1 to #$F0
         JMP   L0FA3         ; Interrupt $FF/$F0: Reset SPC
L0EE3:   JMP   L0E40         ; Loop for next parameter

; Interrupt $FE/$01: Transfer one byte at a time
TransferOne:
L0EE6:   MOV   Y,#$00        ; Zero Y
         MOV   $F4,X         ; Set Port-0 $2140
         MOV   A,$F7         ; A = Port-3 $2143
         MOV   ($90)+Y,A     ; Set transfer byte value
         INCW  $90           ; Increment Write Address
         CMP   $91,#$F5      ; Reached Address $F500
         BEQ   L0F13         ; If so goto Interrupt $FE/$00: No Transfer
L0EF5:   CMP   X,$F4         ; Compare Port-0 $2140
         BEQ   L0EF5         ; Loop until $2140 has value
L0EF9:   MOV   X,$F4         ; X = Port-0 $2140
         CMP   X,$F4         ; Compare Port-0 $2140
         BNE   L0EF9         ; Loop until $2140 is consistent
         MOV   A,#$FF        ; A = #$FF, Reset Code
         MOV   Y,#$F0        ; Y = #$F0, Stop Transfer
         CMP   Y,$F4         ; Is Port-0 $2140 equal to #$F0, Stop Transfer
         BEQ   L0F10         ; If stop transfer loop for next param
         CMPW  YA,$F4        ; Compare #$FF/#$F0 to Port-0/1 $2140 and $2141
         BNE   L0EE6         ; Loop if not
         MOV   $8C,Y         ; Set Interrupt command b1 to #$F0
         JMP   L0FA3         ; Interrupt $FF/$F0: Reset SPC
L0F10:   JMP   L0E40         ; Loop for next parameter

; Interrupt $FE/$00: No Transfer
NoTransfer:
L0F13:   CMP   X,$F4         ; Compare Port-0 $2140
         BEQ   L0F13         ; Loop until $2140 has new value
L0F17:   MOV   X,$F4         ; X = Port-0 $2140
         CMP   X,$F4         ; Compare Port-0 $2140
         BNE   L0F17         ; Loop until $2140 is consistent
         MOV   A,#$FF        ; A = #$FF, Reset Code
         MOV   Y,#$F0        ; Y = #$F0, Stop Transfer
         CMP   Y,$F4         ; Is Port-0 $2140 equal to #$F0, Stop Transfer
         BEQ   L0F2E         ; If stop transfer loop for next param
         CMPW  YA,$F4        ; Compare #$FF/#$F0 to Port-0/1 $2140 and $2141
         BNE   L0F13         ; Loop if not
         MOV   $8C,Y         ; Set Interrupt command b1 to #$F0
         JMP   L0FA3         ; Interrupt $FF/$F0: Reset SPC
L0F2E:   JMP   L0E40         ; Loop for next parameter

; Interrupt $FE/$07: Move chunk
;   This command duplicates a chunk in SPC RAM from one address to another.
;   This is a form of look back decompression.
TransferChunk:
L0F31:   MOVW  YA,$F6        ; YA = Port-2/3 $2142 and $2143
         MOVW  $92,YA        ; Set $92, Write Address
         MOV   $F4,X         ; Set Port-0 $2140
         CALL  CheckEndOfTransfer         ; Check for stop transfer
         MOVW  YA,$F6        ; YA = Port-2/3 $2142 and $2143
         MOVW  $98,YA        ; Set $98, Chunk Size
         MOV   $F4,X         ; Set Port-0 $2140
         MOV   Y,#$00        ; Zero Y
L0F42:   MOV   A,($90)+Y     ; A = Byte from Read Address
         MOV   ($92)+Y,A     ; Set Byte at Write Address
         INC   Y             ; Increment Y
         BNE   L0F4D         ; If not zero skip 2 instructions
         INC   $91           ; Increment Read Address high
         INC   $93           ; Increment Write Address high
L0F4D:   DECW  $98           ; Decrement chunk size
         BNE   L0F42         ; Loop while chunk size
         CALL  CheckEndOfTransfer         ; Check for stop transfer
         BCS   L0F61         ; If stop transfer loop for next param
         MOVW  YA,$F6        ; YA = Port-2/3 $2142 and $2143
         MOVW  $90,YA        ; Set Read Address
         MOV   $F4,X         ; Set Port-0 $2140
         CALL  CheckEndOfTransfer         ; Check for stop transfer
         BRA   L0F31         ; Loop
L0F61:   JMP   L0E40         ; Loop for next parameter

; Check for stop transfer (#$F0)
;   Returns Carry Set/Clear (Stop/Continue)
CheckEndOfTransfer:
         MOV   A,#$FF        ; A = #$FF, Reset Code
         MOV   Y,#$F0        ; Y = #$F0, Stop Transfer
L0F68:   CMP   X,$F4         ; Compare Port-0 $2140
         BEQ   L0F68         ; Loop until $2140 has new value
L0F6C:   MOV   X,$F4         ; X = Port-0 $2140
         CMP   X,$F4         ; Compare Port-0 $2140
         BNE   L0F6C         ; Loop until $2140 consistent
         CMP   Y,$F4         ; Is Port-0 $2140 equal to #$F0, Stop Transfer
         BEQ   L0F7F         ; If so skip 4 instructions, set carry and exit
         CMPW  YA,$F4        ; Compare #$FF/#$F0 to Port-0/1 $2140 and $2141
         BNE   L0F80+1       ; If not clear carry and exit
         MOV   $8C,Y         ; Set Interrupt Command b1 to #$F0
         JMP   L0FA3         ; Interrupt $FF/$F0: Reset SPC
L0F7F:   SETC                ; Set Carry
L0F80:   MOV   Y,#$60        ; .. CLRC Clear Carry if branch to #$60
         RET                 ; Return

; Interrupt $F6: Enable/Disable Fast Forward (0 = disable, 1 = enable)
FastForwardToggle:
         MOV   A,$8C         ; A = Interrupt command b1
         CLRC                ; Clear Carry for addition
         ADC   A,#$FF        ; Set Carry for non-zero
         MOV5  $0086,C       ; ,5 Enable/Disable Fast Forward bit
         BCS   L0F91         ; If carry skip 2 instructions
         MOV   A,#$27        ; Timer0 target: 39) (4.875ms)
         BRA   L0F93         ; Skip next instruction
L0F91:   MOV   A,#$01        ; Timer0 target: 1) (0.125ms)
L0F93:   MOV   $F1,#$06      ; Enable timers 2 and 3
         MOV   $FA,A         ; Set timer0 target
         MOV   $F1,#$07      ; Enable all 3 timers
         RET                 ; Return

; Interrupt $89: Enable Conditional Jump (used by Phantom Train and Dancing Mad)
ConditionalJumpON:
         MOV   ($DD),($52)   ; Enabled Voices pushed to Enable Conditional Jump
         MOV   ($F6),($52)   ; Enabled Voices pushed to Port $2142
         RET                 ; Return

; Interrupt $FF: Reset Codes
;   $FF/$01 = enable waveform output mode
;   $FF/$02 = disable echo
;   $FF/$F0 = reset spc

; Interrupt $FF/$01: Enable waveform output mode
ResetCodes:
L0FA3:   MOV   A,$8C         ; A = interrupt command b1
         CMP   A,#$01        ; Is #$01
         BNE   DisableEcho   ; Skip 5 instructions if not
         MOV   A,$8D         ; A = interrupt command b2
         CLRC                ; Clear Carry for addition
         ADC   A,#$FF        ; Trigger Carry unless zero
         MOV7  $0086,C       ; Set $86 bit 7, enable waveform output mode
         BRA   L0FD2         ; Exit.

; Interrupt $FF/$02: Disable Echo
DisableEcho:
         CMP   A,#$02        ; Is #$02
         BNE   ResetSPC      ; Skip 5 instructions if not
         MOV   A,$8D         ; A = interrupt command b2
         CLRC                ; Clear Carry for addition
         ADC   A,#$FF        ; Trigger Carry unless zero
         MOV6  $0086,C       ; Set $86 bit 6, disable echo
         BRA   L0FD2         ; Exit) (RET...

; Interrupt $FF/$F0: Reset SPC
ResetSPC:
         CMP   A,#$F0        ; Is #$F0
         BNE   L0FD2         ; Exit if not
         MOV   A,#$E0        ; Parameter: RESET, MUTE, ECEN are set
         MOV   Y,#$6C        ; Point to DSP Flags register
         CALL  SetDSPReg     ; Set Register to Parameter
         MOV   $F1,#$80      ; Set Control Register, Reset Ports and Stop Timers
         JMP   $FFC0         ; SPC Initialization
L0FD2:   RET                 ; Return

; Return (void pointer)
VoidReturn:
         RET                 ; Return

; Volume DSP: Calculate Pan with Pansweep
;   A = Pansweep high
;   Y = Pan high
;   Returns A = Calculated Pan
PanWithPansweep:
         MOV   $C0,A         ; $C0 = Pansweep high
         MOV   A,Y           ; A = Pan high
         CLRC                ; Clear Carry for addition
         ADC   A,$C0         ; Add Pansweep to Pan
         BBS7  $C0,L0FE3     ; If signed skip 3 instructions
         BCC   L0FE7         ; If carry clear then exit
         MOV   A,#$FF        ; A = #$FF, high boundary
         BRA   L0FE7         ; Exit) (RET...
L0FE3:   BCS   L0FE7         ; If carry set then exit
         MOV   A,#$00        ; Zero A, low boundary
L0FE7:   RET                 ; Return

; Interrupt $FD: Write to DSP register
Interrupt_SetDSPReg:
         MOV   Y,$8C         ; DSP Register: interrupt b1
         MOV   A,$8D         ; Parameter: interrupt b2
         JMP   SetDSPReg     ; Store A to DSP register Y

; Wait timer1 target * (X)/8 ms
SetWaitTimer1:
         MOV   $F1,#$05      ; Enable timers 0 and 2
         MOV   A,$FE         ; Counter-1, 16 milliseconds
         MOV   $F1,#$07      ; Enable all 3 timers
         MOV   A,#$00        ; Zero A
L0FF9:   MOV   Y,$FE         ; Counter-1, 16 milliseconds
         BEQ   L0FF9         ; Loop if zero
         INC   A             ; Increase A
         CMP   A,(X)         ; Matches requirement?
         BNE   L0FF9         ; Loop if not
         RET                 ; Return

; Interrupt $FC: Initialize Echo
InitEcho:
         AND   $8C,#$0F      ; #$05 unless from interrupt
         MOV   ($80),($8C)   ; Set new echo delay value = $8C
         CALL  ConfigEcho    ; Disable Echo and Configure
         CALL  EchoON        ; Enable echo
         MOV   A,$52         ; A = Enabled Voices bitmask
         BNE   L1014         ; Return if none
         MOV   $4D,A         ; Set echo volume
L1014:   RET                 ; Return

; Disable echo, set echo buffer address, etc.
ConfigEcho:
         MOV   $F2,#$6C      ; Point to flags register
         MOV   A,$F3         ; Current setting
         OR    A,#$20        ; Disable echo
         MOV   $F3,A         ; Save changes
         MOV   Y,#$7D        ; Value for echo delay
         MOV   $F2,Y         ; Set DSP register
         MOV   A,$F3         ; Current setting
         AND   A,#$0F        ; Clear highest operative bit
         MOV   $81,A         ; Set echo wait time
         MOV   A,$80         ; Parameter
         CALL  SetDSPReg     ; Write Parameter
         ASL   A             ; Double A
         ASL   A             ; Double A
         ASL   A             ; Double A
         EOR   A,#$FF        ; Toggle all bits
         INC   A             ; Add one
         CLRC                ; Clear Carry for addition
         ADC   A,#$F5        ; Add #$F5
         MOV   Y,#$6D        ; Point to echo RAM
         CALL  SetDSPReg     ; Set echo address to $F500+n
         MOV   X,#$81        ; Counter-1 requirement held in $81
         CALL  SetWaitTimer1 ; Wait timer1 target * $81/8 ms
         RET                 ; Return

; Enable echo
EchoON:
         MOV   A,$80         ; A = New Echo Delay Value
         BEQ   L104A         ; If zero skip 2 instructions
         MOV   X,#$80        ; Counter-1 requirement held in $80
         CALL  SetWaitTimer1 ; Wait timer1 target * $80/8 ms
L104A:   MOV   $F2,#$6C      ; Flags register
         MOV   A,$F3         ; Current setting
         AND   A,#$DF        ; Enable echo
         MOV   $F3,A         ; Save changes
         RET                 ; Return

; Pause Current Song
PauseSong:
         CMP   $C7,#$2F      ; Is Current Song Index == #$2F, Fanfare
         BEQ   L1094         ; Exit if so
         MOV   ($C6),($C7)   ; Set Paused Song Index to Current Song Index
         MOV   A,#$00        ; Zero A
         MOV   $90,A         ; Pointer to Voice Data low
         MOV   A,#$F6        ; A = #$F6
         MOV   $91,A         ; Pointer to Voice Data high, $F600
         MOV   A,#$00        ; Zero A
         MOV   $92,A         ; Pointer to Paused Voice Data low
         MOV   A,#$FA        ; A = #$FA
         MOV   $93,A         ; Pointer to Paused Voice Data high, $FA00
         MOV   Y,#$00        ; Zero Y
L106E:   MOV   A,($90)+Y     ; Transfer from Voice Data $F600
         MOV   ($92)+Y,A     ; to Paused Voice Data $FA00
         INC   Y             ; Next byte to transfer
         BNE   L106E         ; Loop for $100 bytes
         INC   $91           ; Increment Voice Data high
         INC   $93           ; Increment Paused Voice Data high
         CMP   $91,#$FA      ; Has Voice Data high reached the end
         BNE   L106E         ; Loop if not
         DECW  $92           ; $92 = $FDFF
         MOV   Y,#$80        ; Y = #$80
L1082:   MOV   A,$FFFF+Y     ; Copy $80 bytes from DP 0
         MOV   ($92)+Y,A     ; store at $FE00-$FE80
         DBNZ  Y,L1082       ; Decrease Y, loop unless zero
         INC   $93           ; $93 = #$FE
         MOV   Y,#$A0        ; Y = #$A0
L108D:   MOV   A,$00FF+Y     ; Copy $A0 bytes from DP 1, $0100-$01A0
         MOV   ($92)+Y,A     ; Store at $FF00-$FFA0
         DBNZ  Y,L108D       ; Decrease Y, loop unless zero
L1094:   RET                 ; Return

; Transfer Paused Data back to Current Data, resume song
TransferPausedDataBack:
         MOV   $C6,#$FF      ; Paused Song = #$FF
         MOV   A,#$00        ; Zero A
         MOV   $90,A         ; #$00
         MOV   A,#$F6        ; #$F6
         MOV   $91,A         ; Point to $F600, Current Voice Data
         MOV   A,#$00        ; Zero A
         MOV   $92,A         ; #$00
         MOV   A,#$FA        ; #$FA
         MOV   $93,A         ; Point to $FA00, Paused Voice Data
         MOV   Y,#$00        ; Zero Y
L10AA:   MOV   A,($92)+Y     ; From $FA00+Y, Paused
         MOV   ($90)+Y,A     ; To F600+Y, Current
         INC   Y             ; Increment Y
         BNE   L10AA         ; Loop for $100 bytes
         INC   $91           ; Point to next $100
         INC   $93           ; Point to next $100
         CMP   $91,#$FA      ; Have we reached $FA00
         BNE   L10AA         ; Loop for $400 bytes
         DECW  $92           ; Point to $FDFF
         MOV   Y,#$80        ; Y = #$80, dp0 size
L10BE:   MOV   A,($92)+Y     ; From Saved dp 0
         MOV   $FFFF+Y,A     ; To dp 0
         DBNZ  Y,L10BE       ; Decrease Y, loop unless zero
         INC   $93           ; Point to $FEFF
         MOV   Y,#$A0        ; Y = #$A0, dp1 size
L10C9:   MOV   A,($92)+Y     ; From Saved dp 1
         MOV   $00FF+Y,A     ; To dp 1
         DBNZ  Y,L10C9       ; Decrease Y, loop unless zero
         MOV   $8B,#$81      ; Interrupt command $81
         MOV   $8C,#$10      ; Parameter Volume: #$10
         MOV   $8D,#$FF      ; Parameter Envelope: #$FF
         MOV   $A6,#$20      ; Master Volume high = #$20
         JMP   L0C6A         ; $81: Set master volume to yy, w/ envelope xx

; Waveform Output Mode
;   $8F     DSP Register for Current Channel
;   $98-$9B Output Data (Each byte stereo format 1LLL-RRR
;   $9C     Current Output Left (joined with A for Right
;   $9D     Pointer to Output Data
;   $9E     Pointer to Calculated Volume
;   $A0     End of Calculated volume chunk
;   $A1     bit7 set
;   $C9-$D8 Calculated volume for each voice (2 bytes each, left then right
WaveformOutputMode:
         MOV   A,#$98        ; A = #$98
         MOV   $9D,A         ; Set Pointer to Output Data
         MOV   A,#$C9        ; A = #$C9, Pointer to Calculated volume for each voice
         MOV   $A1,#$00      ; Zero $A1
         BBS4  $86,L10F0     ; If last 4 voices skip 2 instructions
         MOV   $8F,#$09      ; Set DSP Register = #$09, -OUTX ch0
         BRA   L10F8         ; Skip 4 instructions
L10F0:   MOV   $8F,#$49      ; Set DSP Register = #$49, -OUTX ch4
         CLRC                ; Clear Carry for addition
         ADC   A,#$08        ; A = #$D1, Last 4 voices Calculated Volume Pointer
         SET7  $A1           ; $A1 = #$80
L10F8:   MOV   $9E,A         ; $9E = Pointer to Calculated Volume
         CLRC                ; Clear Carry for addition
         ADC   A,#$08        ; A = $D1/$D9
         MOV   $A0,A         ; $A0 = End of Voices
L10FF:   MOV   X,$9E         ; X = Pointer to Calculated Volume
         MOV   Y,$8F         ; Y = DSP Register x9 -OUTX
         MOV   $F2,Y         ; Set register address
         MOV   Y,$F3         ; Current -OUTX
         PUSH  Y             ; Save temporarily
         MOV   A,(X+)        ; Calculated Volume L for Voice
         ASL   A             ; Double A
         MUL   YA            ; Current -OUTX  * Calculated Volume L
         MOV   A,Y           ; Transfer Y to A
         AND   A,#$70        ; Mask -LLL----
         MOV   $9C,A         ; $9C = Output L
         POP   Y             ; Restore setting
         MOV   A,(X+)        ; Calculated Volume R for Voice
         ASL   A             ; Double A
         MUL   YA            ; Current -OUTX * Calculated Volume R
         MOV   A,Y           ; Transfer Y to A
         MOV   $9E,X         ; $9E = Current Pointer to Calculated Volume
         MOV   X,$9D         ; X = Pointer to Output Data
         XCN   A             ; Swap high 4 and low 4 bits
         AND   A,#$07        ; Mask  -----RRR
         OR    A,$9C         ; A = -LLL-RRR
         OR    A,$A1         ; A = 1LLL-RRR
         MOV   (X+),A        ; Set Output Data, $98-$9B
         MOV   $9D,X         ; Set new Pointer to Output Data
         CLRC                ; Clear Carry for addition
         ADC   $8F,#$10      ; Next DSP channel
         CMP   ($9E),($A0)   ; Current Voice is End of Voices
         BNE   L10FF         ; Loop for 4 voices
         MOVW  YA,$98        ; YA = Output Data Voice 1 and 2
         MOVW  $F4,YA        ; Port $2140 and $2141
         MOVW  YA,$9A        ; YA = Output Data Voice 3 and 4) 
         MOVW  $F6,YA        ; Port $2142 and $2143
         NOT4  $0086         ; ,4 update first/last 4 voices for waveform output mode (toggles every frame)
         RET                 ; Return

; Process Master Envelopes (Master Vol, SFX Vol, SFX Pan, Tempo Ratio, Master Pitch
ProcessMasterEnv:
         MOV   A,$AD         ; A = Master Volume Envelope Counter
         BEQ   L114B         ; If no envelope skip 7 instructions
         DEC   $AD           ; Decrement MVol Env. Counter
         MOVW  YA,$A9        ; YA = Master Volume Envelope Change Rate
         ADDW  YA,$A5        ; Add Master Volume to Change Rate
         CMP   Y,$A6         ; Detect if Master Volume changed
         MOVW  $A5,YA        ; Store Master Volume
         BEQ   L114B         ; If no change skip next instruction
         OR    ($DB),($52)   ; Enable Volume Update in DSP for Enabled Voices
L114B:   MOV   A,$AF         ; A = SFX Volume Envelope Counter
         BEQ   L116C         ; If no envelope skip 13 instructions
         MOVW  YA,$AB        ; YA = SFX Volume Envelope Change Rate
         ADDW  YA,$A7        ; Add SFX Volume to Change Rate
         CMP   Y,$A8         ; Detect if SFX Volume changed
         MOVW  $A7,YA        ; Store SFX Volume
         BEQ   L115C         ; If no change skip next instruction
         OR    ($DB),($83)   ; Enable Volume Update in DSP for Game SFX Voices
L115C:   DEC   $AF           ; Decrement SFX Volume Envelope Counter
         BNE   L116C         ; If envelope active skip 5 instructions
         MOV   A,Y           ; Transfer Y to A
         BNE   L116C         ; If SFX has volume skip 3 instructions
         MOV   $A8,#$FF      ; Set SFX Volume high = Max
         MOV   $8B,#$F2      ; Interrupt command b0 = #$F2
         CALL  StopPlayback  ; Interrupt $F2: Stop sound effect
L116C:   MOV   A,$B5         ; A = SFX Pan Envelope Counter
         BEQ   L117F         ; If no envelope skip 7 instructions
         DEC   $B5           ; Decrement SFX Pan Envelope Counter
         MOVW  YA,$B3        ; YA = SFX Pan Envelope Change Rate
         ADDW  YA,$B1        ; Add SFX Pan to Change Rate
         CMP   Y,$B2         ; Detect if SFX Pan changed
         MOVW  $B1,YA        ; Store SFX Pan
         BEQ   L117F         ; If no change skip next instruction
         OR    ($DB),($83)   ; Enable Volume Update in DSP for Game SFX Voices
L117F:   MOV   A,$BA         ; A = Tempo Ratio Envelope Counter
         BEQ   L118B         ; If no envelope skip 4 instructions
         DEC   $BA           ; Decrement Tempo Ratio Envelope Counter
         MOVW  YA,$B8        ; YA = Tempo Ratio Envelope Change Rate
         ADDW  YA,$B6        ; Add Tempo Ratio? to Change Rate
         MOVW  $B6,YA        ; Store Tempo Ratio?
L118B:   MOV   A,$BF         ; A = Master Pitch Multiplier Envelope Counter
         BEQ   L119E         ; If no envelope exit
         DEC   $BF           ; Decrement Master Pitch Multiplier Envelope Counter
         MOVW  YA,$BD        ; YA = Master Pitch Multiplier Envelope Change Rate
         ADDW  YA,$BB        ; Add Master Pitch Multiplier to Change Rate
         CMP   Y,$BC         ; Detect if Master Pitch Multiplier changed
         MOVW  $BB,YA        ; Store Master Pitch Multiplier
         BEQ   L119E         ; If no change skip next instruction
         OR    ($DC),($52)   ; Enable Volume Update in DSP for Enabled Voices
L119E:   RET                 ; Return

; Jump table for Interrupt $FE: Transfer Data from SCPU
TransferDataJumpTable:
dw NoTransfer      ; $00 No transfer
dw TransferOne     ; $01 Transfer one byte at a time
dw TransferTwo     ; $02 Transfer two bytes at a time
dw TransferThree   ; $03 Transfer three bytes at a time
dw NoTransfer      ; $04 -
dw NoTransfer      ; $05 -
dw NoTransfer      ; $06 -
dw TransferChunk   ; $07 Move chunk

; Track Command $F0: Set Tempo
TrkCmd_SetTempo:
L11AF:   MOV   $46,A         ; Set Tempo in BPM
         MOV   A,#$00        ; Zero A
         MOV   $45,A         ; Zero Tempo high byte
L11B5:   MOV   $49,A         ; Zero Tempo Envelope Counter
         RET                 ; Return

; Track Command $F1: Set Tempo w/ Envelope
TrkCmd_SetTempoWithEnv:
         MOV   $49,A         ; Set Tempo Envelope Counter
         MOV   $8C,A         ; Set interrupt code b1
         CALL  NextOpCode    ; Next Script Byte
         MOV   Y,$8C         ; Y = interrupt code b1
         BEQ   L11AF         ; If counter is 0 goto Set Tempo
         SETC                ; Set Carry for subtraction
         SBC   A,$46         ; Tempo to set == Current Tempo
         BEQ   L11B5         ; if so goto Zero Tempo Envelope Counter and RET
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOV   X,$A3         ; X = Voice Pointer
         MOVW  $4A,YA        ; Set Envelope Change Rate
         RET                 ; Return

; Track Command $F4: Set Song Volume
TrkCmd_SetSongVolume:
         MOV   $51,A         ; Set Song Volume
         RET                 ; Return

; Track Command $C4: Set Voice Volume to xx (00-7F)
TrkCmd_SetVoiceVol:
L11D3:   AND   A,#$7F        ; Remove high bit
         MOV   $F621+X,A     ; Set Voice Volume high byte
         MOV   A,#$00        ; Zero A
         MOV   $F620+X,A     ; Zero Voice Volume low byte
         OR    ($DB),($8F)   ; Enable Volume update in DSP for Current Voice
L11E0:   MOV   $F6A0+X,A     ; Zero Voice Volume Envelope Counter
         RET                 ; Return

; Track Command $C5: Set Voice Volume w/ Envelope (yy: volume, xx: envelope duration
TrkCmd_SetVoiceVolWithEnv:
         MOV   $F6A0+X,A     ; Set Voice Volume Envelope Counter
         MOV   $8C,A         ; Set interrupt command b1
         CALL  NextOpCode    ; Next Script Byte
         AND   A,#$7F        ; Remove high bit
         MOV   Y,$8C         ; Y = Interrupt command b1
         BEQ   L11D3         ; If no envelope goto Track Command $C4
         SETC                ; Set Carry for subtraction
         SBC   A,$F621+X     ; Subtract Current Voice Volume
         BEQ   L11E0         ; If zero, zero counter and exit
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOV   X,$A3         ; X = Voice Pointer
         MOV   $F640+X,A     ; Set Voice Volume Envelope Change Rate high
         MOV   A,Y           ; Transfer Y to A
         MOV   $F641+X,A     ; Set Voice Volume Envelope Change Rate low
         RET                 ; Return

; Track Command $F2: Set Song Echo Volume
TrkCmd_SetSongEchoVol:
L1205:   MOV7  C,$00A2       ; Clear bit 7
         ROR   A             ; Halve A
         MOV   $4D,A         ; Set Echo Volume high byte
         MOV   A,#$00        ; Zero A
         MOV   $4C,A         ; Zero Echo Volume low byte
L120F:   MOV   $50,A         ; Zero Echo Volume Envelope Counter
         RET                 ; Return

; Track Command $F3: Set Song Echo Volume w/ Envelope
TrkCmd_SetSongEchoVolWithEnv:
         MOV   $50,A         ; Set Echo Volume Envelope Counter
         MOV   $8C,A         ; Set Interrupt command b1
         CALL  NextOpCode    ; Next Script Byte
         MOV   Y,$8C         ; Y = Interrupt command b1
         BEQ   L1205         ; If envelope is zero goto Track Command $F2
         MOV7  C,$00A2       ; Set Current Opcode bit 7
         ROR   A             ; Halve A
         EOR   A,#$80        ; Sign negative
         NOT7  $004D         ; ,7 Invert signature for Echo Volume
         SETC                ; Set Carry for subtraction
         SBC   A,$4D         ; Subtract echo volume
         NOT7  $004D         ; ,7 Invert signature for Echo Volume
         BEQ   L120F         ; If zero, zero envelope counter and exit
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOV   X,$A3         ; X = Voice Pointer
         MOVW  $4E,YA        ; Set Echo Volume Envelope Change Rate
         RET                 ; Return

; Track Command $C6: Set Voice Pan
TrkCmd_SetVoicePan:
L1236:   ASL   A             ; Double A
         MOV   $F661+X,A     ; Set Voice Pan high byte
         MOV   A,#$00        ; Zero A
         MOV   $F660+X,A     ; Zero Voice Pan low byte
         OR    ($DB),($8F)   ; Enable Volume update in DSP for Current Voice
L1242:   MOV   $F6A1+X,A     ; Zero Pan Envelope Counter
         RET                 ; Return

; Track Command $C7: Set Voice Pan w/ Envelope
TrkCmd_SetVoicePanWithEnv:
         MOV   $F6A1+X,A     ; Set Pan Envelope Counter
         MOV   $8C,A         ; Set Interrupt command b1
         CALL  NextOpCode    ; Next Script Byte
         MOV   Y,$8C         ; Y = Interrupt command b1
         BEQ   L1236         ; If no envelope goto Track Command $C6
         ASL   A             ; Double A
         SETC                ; Set Carry for subtraction
         SBC   A,$F661+X     ; Subtract Pan high byte
         BEQ   L1242         ; If zero, zero Pan Envelope Counter and exit
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOV   X,$A3         ; X = Voice Pointer
         MOV   $F680+X,A     ; Set Pan Envelope Change Rate low
         MOV   A,Y           ; Transfer Y to A
         MOV   $F681+X,A     ; Set Pan Envelope Change Rate high
         RET                 ; Return

; Track Command $C8: Change Pitch w/ Envelope
TrkCmd_ChgPitchWithEnv:
         INC   A             ; Increment A
         MOV   $F720+X,A     ; Set Pitch Envelope Duration
         CALL  NextOpCode    ; Next Script Byte
         MOV   $0150+X,A     ; Set Pitch Envelope Target
         RET                 ; Return

; Track Command $DA: Add to Transpose
TrkCmd_AddToTranspose:
         CLRC                ; Clear Carry for addition
         ADC   A,$F721+X     ; Add Transposition to parameter

; Track Command $D9: Set Transpose
TrkCmd_SetTranspose:
         MOV   $F721+X,A     ; Set Transposition, Command $D9 jumps here
         RET                 ; Return

; Track Command $F7: Set Echo Feedback to yy over xx frames
TrkCmd_SetEchoFeedback:
         MOV   $78,A         ; Set Echo Feedback Envelope Counter
         MOV   $8C,A         ; Set Interrupt command b1
         CALL  NextOpCode    ; Next Script Byte
         MOV   Y,$8C         ; Y = Interrupt command b1
         BEQ   L1298         ; If envelope is zero, set echo feedback and exit
         EOR   A,#$80        ; Invert Signature
         NOT7  $0076         ; ,7 Invert signature for Echo Feedback 
         SETC                ; Set Carry for subtraction
         SBC   A,$76         ; Subtract echo feedback
         NOT7  $0076         ; ,7 Invert signature for Echo Feedback
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         MOV   X,$A3         ; X = Voice  Pointer
         MOVW  $79,YA        ; Set Echo Feedback Change Rate
         BRA   L129A         ; Exit
L1298:   MOV   $76,A         ; Set Echo Feedback high
L129A:   RET                 ; Return

; Track Command $F8: Set Filter ------yy
TrkCmd_SetFilter:
         MOV   $77,A         ; Set Filter Envelope Counter
         MOV   $8C,A         ; Set Interrupt command b1
         CALL  NextOpCode    ; Next Script Byte 
         AND   A,#$03        ; Filter A for ------yy
         INC   A             ; Add one
         ASL   A             ; Double A
         ASL   A             ; Double A
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   X,#$10        ; X = #$10
         MOV   A,$8C         ; A = Filter Envelope Counter
         BEQ   L12D6         ; If no envelope skip 22 instructions
L12AF:   MOV   A,#$00        ; Zero A
         MOV   $63+X,A       ; Zero Filter Data low
         MOV   A,$64+X       ; A = Filter Data high
         EOR   A,#$80        ; Invert Signature
         MOV   $98,A         ; Save A, at scratchpad
         MOV   A,$17A8+Y     ; A = Filter Coefficient Y
         EOR   A,#$80        ; Invert Signature
         SETC                ; Set Carry for subtraction
         SBC   A,$98         ; Restore A, from scratchpad
         PUSH  Y             ; Save Y
         PUSH  X             ; Save X
         CALL  ChgRateToYA   ; Calculate Change Rate to YA
         POP   X             ; Restore X
         MOV   $00FE+X,A     ; Set Filter Envelope Change Rate low
         MOV   A,Y           ; Transfer Y to A
         MOV   $00FF+X,A     ; Set Filter Envelope Change Rate high
         POP   Y             ; Restore Y
         DEC   Y             ; Decrement Y
         DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next Filter Coefficient
         BNE   L12AF         ; Loop for all Filter Coefficients
         BRA   L12E0         ; Load voice pointer and exit
L12D6:   MOV   A,$17A8+Y     ; A = Filter Coefficient Y
         MOV   $64+X,A       ; Set Filter Data $X
         DEC   Y             ; Decrement Y
         DEC   X             ; Decrement X
         DEC   X             ; Decrement X, next Filter Coefficient
         BNE   L12D6         ; Loop for all Filter Coefficients
L12E0:   MOV   X,$A3         ; X = Voice Pointer
         RET                 ; Return

; Track Command $C9: Enable Vibrato
TrkCmd_VibratoON:
         MOV   $0110+X,A     ; Set Vibrato Delay, in ticks
         CALL  NextOpCode    ; Next Script Byte
         MOV   $F6C0+X,A     ; Set Vibrato Cycle Duration
         MOV   $98,A         ; Save A, to scratchpad
         CALL  NextOpCode    ; Next Script Byte
         MOV   $0151+X,A     ; Set Vibrato Amplitude
         CALL  VibTremMaxChgRate         ; Vibrato Max Change Rate to $98
         MOV   X,$A3         ; X = Voice Pointer
         MOVW  YA,$98        ; YA = Vibrato Delay Change Rate
         MOV   $F7C0+X,A     ; Set Maximum Vibrato Change Rate low
         MOV   A,Y           ; Transfer Y to A
         MOV   $F7C1+X,A     ; Set Maximum Vibrato Change Rate high

ResetVibrato:
         MOV   A,#$00        ; Zero A
         MOV   $F8C0+X,A     ; Zero Calculated Vibrato Value low
         MOV   $F8C1+X,A     ; Zero Calculated Vibrato Value high
         MOV   $F840+X,A     ; Zero Vibrato Value low
         MOV   $F841+X,A     ; Zero Vibrato Value high
         MOV   A,$F6C0+X     ; A = Vibrato Cycle Duration
         MOV   $F6C1+X,A     ; Set Vibrato Cycle Counter
         MOV   A,$F7C1+X     ; A = Max Vibrato Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F7C0+X     ; A = Max Vibrato Change Rate low
         MOVW  $98,YA        ; $98 = Max Vibrato Change Rate
         MOV   A,$0190+X     ; A = Tremolo/Vibrato Gain Counter
         AND   A,#$70        ; A = Tremolo Gain Counter
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$0110+X     ; A = Vibrato Delay, in ticks
         MOV   $0111+X,A     ; Set Vibrato Delay Counter
         CALL  VibTremGainCounter         ; Calculate Gain Counter
         MOV   $0190+X,A     ; Set Tremolo/Vibrato Gain Counter
         MOV   A,$98         ; A = Calculated Vibrato Change Rate low
         MOV   $F7E0+X,A     ; Set Vibrato Change Rate low
         MOV   A,$99         ; A = Calculated Vibrato Change Rate high
         MOV   $F7E1+X,A     ; Set Vibrato Change Rate high
         RET                 ; Return

; Max Change Rate to $98 (Vibrato/Tremolo)
VibTremMaxChgRate:
         AND   A,#$3F        ; Filter A as --yyyyyy
         INC   A             ; Increment A
         MOV   Y,#$00        ; Zero Y
         MOV   $99,Y         ; Zero Change Rate high at scratchpad
         MOV   X,$98         ; X = Vibrato Delay
         BEQ   L134D         ; If no delay skip 4 instructions
         DIV   YA,X          ; YA / X => A
         MOV   $99,A         ; Store Change Rate high to scratchpad
         MOV   A,#$00        ; Zero A
         DIV   YA,X          ; YA / X => A
L134D:   MOV   $98,A         ; Store Change Rate low to scratchpad
         LSR   $99           ; Halve Change Rate high
         ROR   $98           ; Halve Change Rate low with carry
         LSR   $99           ; Halve Change Rate high
         ROR   $98           ; Halve Change Rate low with carry
         MOVW  YA,$98        ; YA = Change Rate
         BNE   L135D         ; If not zero skip next instruction
         INC   $98           ; Increment Change Rate
L135D:   ASL   $98           ; Double Change Rate low
         ROL   $99           ; Double Change Rate high with carry
         ASL   $98           ; Double Change Rate low
         ROL   $99           ; Double Change Rate high with carry
         RET                 ; Return

; Calculate Gain Counter (Vibrato/Tremolo)
VibTremGainCounter:
         PUSH  P             ; Save Flags
         BEQ   L1371         ; If zero skip 4 instructions
         LSR   $99           ; Halve Max Vibrato Change Rate
         ROR   $98           ; Halve Max Vibrato Change Rate
         LSR   $99           ; Halve Max Vibrato Change Rate
         ROR   $98           ; Halve Max Vibrato Change Rate
L1371:   CMP   $A2,#$80      ; Is Mode 2 Negative
         BCC   L1383         ; If not skip 5 instructions
         CMP   $A2,#$C0      ; Is Mode 3 Balanced
         BCS   L1383         ; If so skip 3 instructions
         EOR   $98,#$FF      ; Invert Max Vibrato Change Rate
         EOR   $99,#$FF      ; Invert Max Vibrato Change Rate
         INCW  $98           ; Increment Max Vibrato Change Rate
L1383:   POP   P             ; Restore Flags
         BEQ   L1389+1       ; If delay in ticks is zero skip to $138A
         MOV   A,Y           ; Transfer Y to A
         OR    A,#$07        ; Filter A as -----111
L1389:   MOV   Y,#$DD        ; .. Transfer Y to A if branch to #$DD
         RET                 ; Return

; Track Command $CA: Disable Vibrato
TrkCmd_VibratoOFF:
         MOV   $0151+X,A     ; Set Vibrato Amplitude
         MOV   $F8C0+X,A     ; Set Calculated Vibrato Value low
         MOV   $F8C1+X,A     ; Set Calculated Vibrato Value high
         RET                 ; Return

; Track Command $CB: Enable Tremolo
TrkCmd_TremoloON:
         MOV   $0130+X,A     ; Set Tremolo Delay, in ticks
         CALL  NextOpCode    ; Next Script Byte
         MOV   $F6E0+X,A     ; Set Tremolo Cycle Duration
         MOV   $98,A         ; $98 = Tremolo Cycle Duration
         CALL  NextOpCode    ; Next Script Byte
         MOV   $0170+X,A     ; Set Tremolo Mode/Amplitude
         CALL  VibTremMaxChgRate         ; Delay Change Rate to $98
         MOV   X,$A3         ; X = Voice Pointer
         MOV   A,$98         ; A = Calculated Change Rate low
         MOV   $F800+X,A     ; Set Delay Tremolo Change Rate low
         MOV   A,$99         ; A = Calculated Change Rate high
         MOV   $F801+X,A     ; Set Delay Tremolo Change Rate high

ResetTremolo:
         MOV   A,#$00        ; Zero A
         MOV   $F860+X,A     ; Zero Tremolo Value low
         MOV   $F861+X,A     ; Zero Tremolo Value high
         MOV   A,$F6E0+X     ; A = Tremolo Cycle Duration
         MOV   $F6E1+X,A     ; Set Tremolo Cycle Counter
         MOV   A,$F801+X     ; A = Delayed Tremolo Change Rate high
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F800+X     ; A = Delayed Tremolo Change Rate low
         MOVW  $98,YA        ; $98 = Delayed Tremolo Change Rate
         MOV   A,$0190+X     ; A = Tremolo/Vibrato Gain Counter
         AND   A,#$70        ; Mask Tremolo Gain Counter
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$0130+X     ; A = Tremolo Delay, in ticks
         MOV   $0131+X,A     ; Set Tremolo Delay Counter
         CALL  VibTremGainCounter         ; Calculate Gain Counter
         MOV   $0190+X,A     ; Set Tremolo/Vibrato Gain Counter
         MOV   A,$98         ; A = Delayed Tremolo Change Rate low
         MOV   $F820+X,A     ; Set Tremolo Change Rate low
         MOV   A,$99         ; A = Delayed Tremolo Change Rate high
         MOV   $F821+X,A     ; Set Tremolo Change Rate high
         RET                 ; Return

; Track Command $CC: Disable Tremolo 
TrkCmd_TremoloOFF:
         MOV   $0170+X,A     ; Set Tremolo Mode/Amplitude
         MOV   $F860+X,A     ; Set Tremolo Value low
         MOV   $F861+X,A     ; Set Tremolo Value high
         RET                 ; Return

; Track Command $CD: Enable Pansweep 
TrkCmd_PansweepON:
         CLRC                ; Clear Carry
         INC   A             ; Increment A
         BEQ   L1400         ; If zero skip 4 instructions
         AND   A,#$FE        ; Mask #$FE
         BNE   L1401         ; If not zero skip 2 instructions
         MOV   A,#$02        ; A = 2
         BRA   L1401         ; Skip next instruction
L1400:   SETC                ; Set Carry
L1401:   MOV   $F700+X,A     ; Set Pansweep Cycle Duration
         ROR   A             ; Halve A
         MOV   $F701+X,A     ; Set Pansweep Cycle Counter
         MOV   Y,A           ; Transfer A to Y
         CALL  NextOpCode         ; Next Script Byte
         ASL   A             ; Double A ..
         MOV   A,$A2         ; A = Pansweep Cycle Duration
         AND   A,#$7F        ; Mask #$7F
         BCC   L1415         ; If no carry skip next instruction
         EOR   A,#$7F        ; Invert A
L1415:   MOV   $98,A         ; Set $98, Pansweep Cycle Duration
         MOV   A,Y           ; Transfer Y to A
         BPL   L141F         ; If ? skip 2 instructions
         MOV   $99,#$00      ; Zero Pansweep Cycle Duration high
         BRA   L1432         ; Skip 11 instructions
L141F:   MOV   X,A           ; Transfer A to X
         MOV   Y,#$00        ; Zero Y
         MOV   A,$98         ; A = Pansweep Cycle Duration
         DIV   YA,X          ; YA / X = Pansweep Change Rate high
         MOV   $99,A         ; Set $99 to Pansweep Change Rate high
         MOV   A,#$00        ; Zero A
         DIV   YA,X          ; YA / X = Pansweep Change Rate low
         MOV   $98,A         ; Set $98 to Pansweep Change Rate low
         MOVW  YA,$98        ; YA = Pansweep Change Rate
         BNE   L1432         ; If change rate skip next instruction
         INC   $98           ; Increment Pansweep Change Rate
L1432:   BCC   L143C         ; If not signed skip 3 instructions
         EOR   $98,#$FF      ; Invert Pansweep Change Rate low
         EOR   $99,#$FF      ; Invert Pansweep Change Rate high
         INCW  $98           ; Increment Pansweep Change Rate
L143C:   MOV   X,$A3         ; X = Voice Pointer
         MOV   A,$98         ; A = Pansweep Change Rate low
         MOV   $F7A0+X,A     ; Set Pansweep Change Rate low
         MOV   A,$99         ; A = Pansweep Change Rate high
         MOV   $F7A1+X,A     ; Set Pansweep Change Rate high
         MOV   A,$A2         ; A = Pansweep Cycle Duration

; Track Command $CE: Disable Pansweep
TrkCmd_PansweepOFF:
         MOV   $0171+X,A     ; Set Pansweep Cycle Duration
         MOV   A,#$00        ; Zero A
         MOV   $F880+X,A     ; Zero Pansweep Value low
         MOV   $F881+X,A     ; Zero Pansweep Value high
         RET                 ; Return

; Track Command $D7: Increment Octave
TrkCmd_OctaveUp:
         MOV   A,$F600+X     ; A = Octave
         INC   A             ; Increment A
         BRA   L1460         ; Write and return

; Track Command $D8: Decrement Octave
TrkCmd_OctaveDown:
         MOV   A,$F600+X     ; A = Octave
         DEC   A             ; Decrement A

; Track Command $D6: Set Octave to XX
TrkCmd_SetOctave:
L1460:   MOV   $F600+X,A     ; Set Octave to A
         RET                 ; Return

; Track Command $D4: Enable Echo
TrkCmd_EchoON:
         CMP   X,#$10        ; > #$10
         BCS   L146D         ; If SFX skip 2 instructions
         OR    ($53),($8F)   ; Set Enable Echo to Current Voice
         BRA   L1470         ; Skip 1 instruction
L146D:   OR    ($54),($8F)   ; Set Enable Echo SFX to Current Voice
L1470:   MOV   A,$83         ; A = Game SFX Voices
         OR    A,$84         ; with System SFX Voices
         EOR   A,#$FF        ; Inverted
         AND   A,$53         ; That have Enabled Echo
         OR    A,$54         ; or Enabled Echo SFX
         MOV   $87,A         ; Set echo enabled voices, DSP $4D
         RET                 ; Return

; Track Command $D5: Disable Echo
TrkCmd_EchoOFF:
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; > #$10
         BCS   L1488         ; If SFX skip 2 instructions
         TCLR  $0053,A       ; Test and clear Enabled Echo
         BRA   L1470         ; Update bitmasks and exit
L1488:   TCLR  $0054,A       ; Test and clear Enabled Echo SFX
         BRA   L1470         ; Update bitmasks and exit

; Track Command $D0: Enable Noise
TrkCmd_NoiseON:
         CMP   X,#$10        ; > #$10
         BCS   L1496         ; If SFX skip 2 instructions
         OR    ($55),($8F)   ; Set Enable Noise to Current Voice
         BRA   L1499         ; Skip next instruction
L1496:   OR    ($56),($8F)   ; Set Enable Noise SFX to Current Voice
L1499:   MOV   ($98),($56)   ; Set $98 to Enable Noise SFX
         CLR0  $98           ; Clear bit 0
         MOV   A,$8A         ; A = DSP Flags
         AND   A,#$E0        ; Clear Noise Generator Frequency
         MOV   Y,$56         ; Y = Enabled Noise SFX
         BNE   L14AA         ; If SFX skip 2 instructions
         OR    A,$62         ; with Noise Clock Value
         BRA   L14AC         ; Skip next instruction
L14AA:   OR    A,$63         ; with Noise Clock Value SFX
L14AC:   MOV   $8A,A         ; Set DSP Flags, new Noise Generator Frequency
         MOV   A,$83         ; A = Game SFX Voices
         OR    A,$84         ; with System SFX Voices
         EOR   A,#$FF        ; Inverted
         AND   A,$55         ; That have Enabled Noise
         OR    A,$98         ; or Enabled Noise SFX
         MOV   $88,A         ; Set noise enabled voices, DSP $3D
         RET                 ; Return

; Track Command $D1: Disable Noise
TrkCmd_NoiseOFF:
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; > #$10
         BCS   L14C6         ; If SFX skip 2 instructions
         TCLR  $0055,A       ; Test and clear Enable Noise
         BRA   L1499         ; Update bitmasks and exit
L14C6:   TCLR  $0056,A       ; Test and clear Enable Noise SFX
         BRA   L1499         ; Update bitmasks and exit

; Track Command $CF: Set Noise Clock (00-1F)
TrkCmd_NoiseClock:
         AND   A,#$1F        ; Mask #$1F, remove DSP Flags #$E0
         CMP   X,#$10        ; > #$10
         BCS   L14D5         ; If SFX skip 2 instructions
         MOV   $62,A         ; Set Noise Clock Value
         BRA   L1499         ; Update bitmasks and exit
L14D5:   MOV   $63,A         ; Set Noise Clock SFX Value
         BRA   L1499         ; Update bitmasks and exit

; Track Command $D2: Enable Pitch Modulation
TrkCmd_PitchModON:
         CMP   X,#$10        ; > #$10
         BCS   L14E2         ; If SFX skip 2 instructions
         OR    ($57),($8F)   ; Set Enable Pitch Mod with Current Voice
         BRA   L14E5         ; Skip next instruction
L14E2:   OR    ($58),($8F)   ; Set Enable Pitch Mod SFX with Current Voice
L14E5:   MOV   A,$83         ; A = Game SFX Voices
         OR    A,$84         ; with System SFX Voices
         EOR   A,#$FF        ; Inverted
         AND   A,$57         ; That have Enabled Pitch Mod
         OR    A,$58         ; or Enabled Pitch Mod SFX
         MOV   $89,A         ; Set pitch modulation enabled voices. DSP $2D
         RET                 ; Return

; Track Command $D3: Disable Pitch Modulation
TrkCmd_PitchModOFF:
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; X > #$10
         BCS   L14FD         ; If SFX skip 2 instructions
         TCLR  $0057,A       ; Test and clear Enable Pitch Mod
         BRA   L14E5         ; Update bitmasks and exit
L14FD:   TCLR  $0058,A       ; Test and clear Enable Pitch Mod SFX
         BRA   L14E5         ; Update bitmasks and exit

; Track Command $DC: Set Instrument
TrkCmd_SetInstrument:
         MOV   $F601+X,A     ; Set Instrument for Voice
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$1A00+Y     ; Get Instrument Pitch Multiplier low
         MOV   $F740+X,A     ; Set Instrument Pitch Multiplier low
         MOV   A,$1A01+Y     ; Get Instrument Pitch Multiplier high
         MOV   $F741+X,A     ; Set Instrument Pitch Multiplier high
         MOV   A,$1A80+Y     ; Get ADSR Data low) 
         MOV   $F900+X,A     ; Set ADSR Data low
         MOV   A,$1A81+Y     ; Get ADSR Data high
         MOV   $F901+X,A     ; Set ADSR Data high
         CMP   X,#$10        ; X > #$10
         BCS   L1528         ; If SFX exit
         MOV   A,$8F         ; A = Current Voice
         TCLR  $0061,A       ; Test and Clear Ignore Song Volume
L1528:   RET                 ; Return

; Update DSP SRCN for Voice with Instrument
InstrumentUpdateDSP:
         MOV   A,$F601+X     ; Get Instrument
         MOV   Y,A           ; Transfer it to Y
         MOV   A,X           ; Transfer X to A
         XCN   A             ; Swap high 4 and low 4 bits
         LSR   A             ; Halve A
         OR    A,#$04        ; DSP $x4, SRCN Source Number
         MOV   $F2,A         ; Set register address
         MOV   $F3,Y         ; Write parameter, Instrument
         BRA   L1548         ; Update ADSR and exit

; Track Command $DD: Set ADSR Attack Value (0-F)
TrkCmd_AttackADSR:
         AND   A,#$0F        ; Mask 0-F
         MOV   $A2,A         ; $A2 = Attack Value
         MOV   A,$F900+X     ; A = Voice ADSR1
         AND   A,#$70        ; Remove old Attack Value
         OR    A,$A2         ; Add new Attack Value
         OR    A,#$80        ; Add #$80
         MOV   $F900+X,A     ; Store Voice ADSR1
L1548:   CMP   X,#$10        ; X > #$10
         BCS   L1555         ; If SFX, update ADSR and exit
         MOV   A,$83         ; A = Game SFX Voices
         OR    A,$84         ; with System SFX Voices
         AND   A,$8F         ; Isolate Current Voice
         BEQ   L1555         ; Update DSP ADSR values for voice
         RET                 ; Return

; Update DSP ADSR values for voice
ADSRUpdateDSP:
L1555:   MOV   A,X           ; Transfer X to A
         XCN   A             ; Swap high 4 and low 4 bits
         LSR   A             ; Halve A
         OR    A,#$05        ; DSP $x5 ADSRx1
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F900+X     ; Parameter
         CALL  SetDSPReg     ; Write parameter
         INC   Y             ; DSP $x6 ADSRx2
         MOV   A,$F901+X     ; Parameter
         JMP   SetDSPReg     ; Write parameter

; Track Command $DE: Set ADSR Decay Value (0-7)
TrkCmd_DecayADSR:
         AND   A,#$07        ; Mask 0-7
         XCN   A             ; Swap high 4 and low 4 bits
         MOV   $A2,A         ; $A2 = Decay Value
         MOV   A,$F900+X     ; A = Voice ADSR1
         AND   A,#$0F        ; Remove old Decay Value
         OR    A,$A2         ; Add new Decay Value
         OR    A,#$80        ; Add #$80
         MOV   $F900+X,A     ; Store Voice ADSR1
         BRA   L1548         ; Update ADSR and exit

; Track Command $DF: Set ADSR Sustain Value (0-7)
TrkCmd_SustainADSR:
         AND   A,#$07        ; Mask 0-7
         XCN   A             ; Swap high 4 and low 4 bits
         ASL   A             ; Shift up 1 bit
         MOV   $A2,A         ; $A2 = Sustain Value
         MOV   A,$F901+X     ; A = Voice ADSR2
         AND   A,#$1F        ; Remove old Sustain Value
         OR    A,$A2         ; Add new Sustain Value
         MOV   $F901+X,A     ; Store Voice ADSR2
         BRA   L1548         ; Update ADSR and exit

; Track Command $E0: Set ADSR Release Value (0-31)
TrkCmd_ReleaseADSR:
         AND   A,#$1F        ; Mask #$1F
         MOV   $A2,A         ; $A2 = Release Value
         MOV   A,$F901+X     ; A = Voice ADSR2
         AND   A,#$E0        ; Remove old Releasae Value
         OR    A,$A2         ; Add new Release Value
         MOV   $F901+X,A     ; Store Voice ADSR2
         BRA   L1548         ; Update ADSR and exit

; Track Command $E1: Reset ADSR Default Values
TrkCmd_ResetADSR:
         MOV   A,$F601+X     ; A = Instrument
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$1A80+Y     ; A = ADSR1 for Instrument
         MOV   $F900+X,A     ; Set ADSR for Voice
         MOV   A,$1A81+Y     ; A = ADSR2 fpr Instrument
         MOV   $F901+X,A     ; Set ADSR for Voice
         BRA   L1548         ; Update ADSR and exit

; Track Command $FB: Ignore Song Volume
TrkCmd_IgnoreSongVolume:
         OR    ($61),($8F)   ; Set Ignore Song Volume for Current Voice
         RET                 ; Return

; Track Command $E4: Enable Slur
TrkCmd_SlurON:
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; X > #$10
         BCS   L15C5         ; If SFX skip 4 instructions
         TSET  $005B,A       ; Test and set Enable Slur
         TCLR  $005D,A       ; Test and clear Active Slur
         TCLR  $005F,A       ; Test and clear Enable Drum Roll
         BRA   L15CE         ; Exit) (RET...
L15C5:   TSET  $005C,A       ; Test and set Enable Slur SFX
         TCLR  $005E,A       ; Test and clear Active Slur SFX
         TCLR  $0060,A       ; Test and clear Enable Drum Roll SFX
L15CE:   RET                 ; Return

; Track Command $E5: Disable Slur (not in jump table)

         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; X > #$10
         BCS   L15DA         ; If SFX skip 2 instructions
         TCLR  $005B,A       ; Test and clear Enable Slur
         BRA   L15DD         ; Exit) (RET...
L15DA:   TCLR  $005C,A       ; Test and clear Enable Slur SFX
L15DD:   RET                 ; Return

; Track Command $E6: Enable Drum Roll
TrkCmd_DrumRollON:
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; X > #$10
         BCS   L15EC         ; If SFX skip 3 instructions
         TSET  $005F,A       ; Test and set Enable Drum Roll
         TCLR  $005B,A       ; Test and clear Enable Slur
         BRA   L15F2         ; Exit) (RET...
L15EC:   TSET  $0060,A       ; Test and set Enable Drum Roll SFX
         TCLR  $005C,A       ; Test and clear Enable Slur SFX
L15F2:   RET                 ; Return

; Track Command $E7: Disable Drum Roll (not in jump table)
         MOV   A,$8F         ; A = Current Voice
         CMP   X,#$10        ; X > #$10
         BCS   L15FE         ; If SFX skip 2 instructions
         TCLR  $005F,A       ; Test and clear Enabled Drum Roll
         BRA   L1601         ; Exit) (RET...
L15FE:   TCLR  $0060,A       ; Test and clear Enabled Drum Roll SFX
L1601:   RET                 ; Return

; Track Command $E9: Play Game Sound Effect (voice A)
TrkCmd_SFXA:
         MOV   Y,#$00        ; Y = 0, voice A
         BRA   L1608         ; Skip next instruction

; Track Command $EA: Play Game Sound Effect (voice B)
TrkCmd_SFXB:
         MOV   Y,#$02        ; Y = 2, voice B
L1608:   CALL  GetSFXasYA    ; Get Pointer to Game SFX as YA
         MOV   $02+X,A       ; Set Current Script Pointer low
         MOV   $03+X,Y       ; Set Current Script Pointer high
         MOV   A,Y           ; Transfer Y to A
         BNE   L1615         ; Exit if Y
         JMP   TrkCmd_EndOfSongScript         ; End of Song Script
L1615:   RET                 ; Return

; Get Pointer to Game SFX as YA
GetSFXasYA:
         MOV   $93,#$00      ; Zero Pointer to SFX index high
         ASL   A             ; Double A
         ROL   $93           ; Push carry to $93
         ASL   A             ; A times 4
         ROL   $93           ; Push carry to $93
         MOV   $92,A         ; $92 = Pointer to SFX index low
         MOV   A,Y           ; Transfer Y to A
         MOV   Y,#$2C        ; YA = #$2C00 or #$2C02
         ADDW  YA,$92        ; Add Pointer to SFX index
         MOVW  $92,YA        ; $92 = Address of SFX Pointer
         MOV   Y,#$00        ; Zero Y
         MOV   A,($92)+Y     ; Full SFX Pointer low
         PUSH  A             ; Save A
         INC   Y             ; Increment Y
         MOV   A,($92)+Y     ; Full SFX Pointer high
         MOV   Y,A           ; Transfer A to Y
         POP   A             ; Restore A
         RET                 ; Return

; Switch $E9: Play Game SFX, voice A
TrkSwitch_SFXA:
         MOV   A,($90)+Y     ; A = First Parameter, SFX Index
         MOV   Y,#$00        ; Zero Y, voice A
         BRA   L163D         ; Skip 2 instructions

; Switch $EA: Play Game SFX, voice B
TrkSwitch_SFXB:
         MOV   A,($90)+Y     ; A = First Parameter, SFX Index
         MOV   Y,#$02        ; Y = 2, voice B
L163D:   CALL  GetSFXasYA    ; Get pointer to Game SFX as YA
         MOVW  $90,YA        ; Set Temporary Script Pointer as Game SFX Pointer
         MOV   A,Y           ; Transfer Y to A
         BEQ   L1649         ; If no sfx script exit
         POP   A             ; Restore A
         POP   A             ; Restore A
         MOV   A,#$EB        ; A = #$EB, Track Command $EB: End of Song Script
L1649:   RET                 ; Return

; Track Command $F6: Jump to xxxx
TrkCmd_JumpToXXXX:
         MOV   Y,A           ; Y = Jump Address low
         CALL  NextOpCode    ; Next Script Byte
         MOV   A,Y           ; Transfer Y to A
         MOV   Y,$A2         ; Y = Jump Address high
         ADDW  YA,$00        ; + Song Script Offset
         MOV   $02+X,A       ; Set Current Script Pointer low
         MOV   $03+X,Y       ; Set Current Script Pointer high
         RET                 ; Return

; Switch $F6: Jump to xxxx
TrkSwitch_JumpToXXXX:
         MOV   A,($90)+Y     ; A = First Parameter, Jump Address low
         PUSH  A             ; Save A
         INC   Y             ; Increment Y
         MOV   A,($90)+Y     ; A = Second Parameter, Jump Address high
         MOV   Y,A           ; Transfer A to Y
         POP   A             ; Restore A
         ADDW  YA,$00        ; Add Song Script Offset
         MOVW  $90,YA        ; Set Temporary Script Pointer
         RET                 ; Return

; Track Command $F5: Jump to yyyy When Loop Count Reaches xx
TrkCmd_JumpToYYYYWhenLoopIsXX:
         MOV   $9A,A         ; $8A = Target Loop Count
         CALL  NextOpCode    ; Next Script Byte
         MOV   $98,A         ; $98 = Jump Address low
         CALL  NextOpCode    ; Next Script Byte
         MOV   $99,A         ; $99 = Jump Address high
         MOV   Y,$26+X       ; Y = Pointer to Loop Count
         MOV   A,$F920+Y     ; A = Repeat Counter
         CBNE  $9A,L1694     ; If not same as Target Loop Count then exit
         MOV   A,$F940+Y     ; A = Loop Counter
         DEC   A             ; Decrement A
         BNE   L168C         ; If counting do jump and exit
         MOV   A,X           ; Transfer X to A
         ASL   A             ; Double A
         DEC   A             ; Decrement A
         DEC   $26+X         ; Decrement Pointer to Loop Count
         CBNE  $26+X,L168C   ; If A != loop count do jump and exit
         CLRC                ; Clear Carry for addition
         ADC   A,#$04        ; Add 4
         MOV   $26+X,A       ; Set Pointer to Loop Count
L168C:   MOVW  YA,$98        ; YA = Jump Address
         ADDW  YA,$00        ; + Song Script Offset
         MOV   $02+X,A       ; Set Current Script Pointer low
         MOV   $03+X,Y       ; Set Current Script Pointer high
L1694:   RET                 ; Return

; Switch $F5: Jump to yyyy when loop count reaches xx
TrkSwitch_JumpToYYYYWhenLoopIsXX:
         MOV   Y,$C5         ; Y = Current Pointer to Loop Count
         MOV   A,$F920+Y     ; A = Repeat Count
         MOV   Y,#$00        ; Zero Y
         CMP   A,($90)+Y     ; Compare with Target Loop Count
         BNE   L16B9         ; If not equal then increment script and exit
         MOV   Y,$C5         ; Y = Current Pointer to Loop Count
         MOV   A,$F940+Y     ; A = Loop Count
         DEC   A             ; Decrement A
         BNE   L16B4         ; If not zero skip 8 instructions
         MOV   A,X           ; Transfer X to A
         ASL   A             ; Double A
         DEC   A             ; Decrement A
         DEC   $C5           ; Decrement Current Pointer to Loop Count
         CBNE  $C5,L16B4     ; If A != Loop Count do jump to yyyy
         CLRC                ; Clear Carry for addition
         ADC   $C5,#$04      ; Add 4 to Current Pointer to Loop Count
L16B4:   MOV   Y,#$01        ; Y = 1
         JMP   TrkSwitch_JumpToXXXX         ; Switch $F6: Jump to xxxx
L16B9:   INCW  $90           ; Increment Temporary Script Pointer
         INCW  $90           ; Increment Temporary Script Pointer
         INCW  $90           ; Increment Temporary Script Pointer
         RET                 ; Return

; Track Command $E2: Loop Start (loop xx+1 times
TrkCmd_LoopStart:
         INC   $26+X         ; Increment Pointer to Loop Count
         MOV   A,X           ; Transfer X to A
         ASL   A             ; Double A
         CLRC                ; Clear Carry for addition
         ADC   A,#$04        ; Add 4, next voice
         CBNE  $26+X,L16CF   ; If A != Loop Count skip 3 instructions
         SETC                ; Set Carry for subtraction
         SBC   A,#$04        ; Subtract 4, previous voice
         MOV   $26+X,A       ; Set Pointer to Loop Count
L16CF:   MOV   Y,$26+X       ; Y = Pointer to Loop Count
         MOV   A,$A2         ; A = First Parameter, Loop Count
         BEQ   L16D6         ; If zero skip 1 instruction
         INC   A             ; Increment A
L16D6:   MOV   $F940+Y,A     ; Set Loop Counter
         CMP   X,#$10        ; > #$10
         BCS   L16E2         ; If SFX skip 2 instructions
         MOV   A,#$01        ; A = 1
         MOV   $F920+Y,A     ; Set Repeat Count
L16E2:   MOV   A,Y           ; Transfer Y to A
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$02+X       ; A = Current Song Script Pointer low
         MOV   $F980+Y,A     ; Set Loop Start Script Pointer low
         MOV   A,$03+X       ; A = Current Song Script Pointer high
         MOV   $F981+Y,A     ; Set Loop Start Script Pointer high
         RET                 ; Return

; Track Command $E3: Loop End
TrkCmd_LoopEnd:
         MOV   Y,$26+X       ; Pointer to Loop Count
         CMP   X,#$10        ; > #$10
         BCS   L16FD         ; If so skip 3 instructions
         MOV   A,$F920+Y     ; A = Repeat Count
         INC   A             ; Increment Repeat Count
         MOV   $F920+Y,A     ; Store Repeat Count
L16FD:   MOV   A,$F940+Y     ; A = Loop Counter
         BEQ   L1717         ; If zero skip 12 instructions
         DEC   A             ; Decrement Loop Counter
         BNE   L1714         ; If not zero skip 9 instructions
         MOV   A,X           ; Transfer X to A
         ASL   A             ; Double A
         DEC   A             ; Decrement A
         DEC   $26+X         ; Decrement Pointer to Loop Count
         CBNE  $26+X,L1724   ; If A != loop count exit
         CLRC                ; Clear Carry for addition
         ADC   A,#$04        ; Add 4
         MOV   $26+X,A       ; Store Pointer to Loop Count
         BRA   L1724         ; Exit) (RET...
L1714:   MOV   $F940+Y,A     ; Store Loop Counter
L1717:   MOV   A,Y           ; Transfer Y to A
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F980+Y     ; A = Loop Start Script Pointer low
         MOV   $02+X,A       ; Set Song Script Pointer low
         MOV   A,$F981+Y     ; A = Loop Start Script Pointer high
         MOV   $03+X,A       ; Set Song Script Pointer high
L1724:   RET                 ; Return

; Switch $E3: Loop End
TrkSwitch_LoopEnd:
         MOV   Y,$C5         ; Y = Current Pointer to Loop Count
         MOV   A,$F940+Y     ; A = Loop Counter
         BEQ   L173D         ; If zero skip 10 instructions
         DEC   A             ; Decrement A
         BNE   L173D         ; If counting skip 8 instructions
         MOV   A,X           ; Transfer X to A
         ASL   A             ; Double A
         DEC   A             ; Decrement A
         DEC   $C5           ; Decrement Current Pointer to Loop Count
         CBNE  $C5,L174A     ; If A != loop count then exit
         CLRC                ; Clear Carry for addition
         ADC   $C5,#$04      ; Add 4 to Current Pointer to Loop Count
         BRA   L174A         ; Exit) (RET...
L173D:   MOV   A,Y           ; Transfer Y to A
         ASL   A             ; Double A
         MOV   Y,A           ; Transfer A to Y
         MOV   A,$F980+Y     ; A = Loop Start Script Pointer low
         MOV   $90,A         ; Set Temporary Script Pointer low
         MOV   A,$F981+Y     ; A = Loop Start Script Pointer high
         MOV   $91,A         ; Set Temporary Script Pointer high
L174A:   RET                 ; Return

; Track Command $E8: Add to Note Duration
TrkCmd_AddToNoteDuration:
         MOV   $25+X,A       ; Set Note Duration Counter
         RET                 ; Return

; Track Command $DB: Set Detune
TrkCmd_SetDetune:
         MOV   $F760+X,A     ; Set Voice Detune
         RET                 ; Return

; Track Command $F9: Increment Output Code
TrkCmd_IncOutputCode:
         INC   $7B           ; Increment Output Code
         RET                 ; Return

; Track Command $FA: Clear Output Code
TrkCmd_ClrOutputCode:
         MOV   $7B,#$00      ; Zero Output Code
         RET                 ; Return

; Track Command $FC: Conditional Jump to xxxx
TrkCmd_CondJumpToXXXX:
         MOV   Y,A           ; Transfer A to Y, save Jump Address low
         CALL  NextOpCode    ; Next Script Byte
         MOV   A,$8F         ; A = Current Voice
         AND   A,$DD         ; And Enable Conditional Jump
         BEQ   L176F         ; If not exit
         TCLR  $00DD,A       ; Test and clear Enable Conditional Jump
         MOV   A,Y           ; Transfer Y to A, Jump Address low
         MOV   Y,$A2         ; Y = Jump Address high
         ADDW  YA,$00        ; Add Song Script Offset
         MOV   $02+X,A       ; Set Song Script Pointer low
         MOV   $03+X,Y       ; Set Song Script Pointer high
L176F:   RET                 ; Return

TrkCmd_Unused:
; Track Command $EB: End of Song Script
TrkCmd_EndOfSongScript:
         POP   A             ; Restore A
         POP   A             ; Restore A
EndOfSongScript:
         MOV   A,$8F         ; A = Current Voice bitmask
         CMP   X,#$10        ; > #$10
         BCS   L177D         ; If so skip 2 instructions
         TCLR  $0052,A       ; Test and clear Enabled Voices
         BRA   L1786         ; skip 3 instructions
L177D:   TCLR  $0083,A       ; Test and clear Game SFX Voices
         TCLR  $0084,A       ; Test and clear System SFX Voices
         TCLR  $005D,A       ; Test and clear Active Slur for SFX Voices
L1786:   CALL  TrkCmd_NoiseOFF         ; Disable Noise
         CALL  TrkCmd_PitchModOFF      ; Disable Pitch Modulation
         JMP   TrkCmd_EchoOFF          ; Disable Echo

; Note Tuning values (Chrono Trigger has exactly the same data at $1D6D)
TuningTable:
dw $0879     ; A# - $0879
dw $08FA     ; B  - $08FA
dw $0983     ; C  - $0983
dw $0A14     ; C# - $0A14
dw $0AAD     ; D  - $0AAD
dw $0B50     ; D# - $0B50
dw $0BFC     ; E  - $0BFC
dw $0CB2     ; F  - $0CB2
dw $0D74     ; F# - $0D74
dw $0E41     ; G  - $0E41
dw $0F1A     ; G# - $0F1A
dw $1000     ; A  - $1000
dw $10F3     ; A# - $10F3

; Echo filter sets
EchoFilterSets:
db $7F, $00, $00, $00, $00, $00, $00, $00   ; set 0
db $0C, $21, $2B, $2B, $13, $FE, $F3, $F9   ; set 1
db $58, $BF, $DB, $F0, $FE, $07, $0C, $0C   ; set 2
db $34, $33, $00, $D9, $E5, $01, $FC, $EB   ; set 3
db $80, $80, $80, $80, $7F, $7F, $7F, $7F   ; set 4

; Note duration data (ticks
DurationTable:
db $C0	; 1/1  Whole Note
db $60	; 1/2  Half Note
db $40	; 1/3  Half Note Triplet
db $48	; 3/8  Dotted Quarter Note
db $30	; 1/4  Quarter Note
db $20	; 1/6  Quarter Note Triplet  
db $24	; 3/16 Dotted Eighth Note 
db $18	; 1/8  Eighth Note
db $10	; 1/12 Triplet
db $0C	; 1/16 Sixteenth Note
db $08	; 1/24 Sixteenth Note Triplet
db $06	; 1/32 Thirty-second Note
db $04	; 1/48 Thirty-second Note Tripet
db $03	; 1/64 Sixty-fourth Note

; Pointers to System Sound Effect Scripts ($20-$2F
SystemSFX_JumpTable:
dw    SystemSFX_Click           ; ($17FF) $20 Click
dw    SystemSFX_Cursor          ; ($180A) $21 Cursor
dw    SystemSFX_Buzzer          ; ($1815) $22 Buzzer (error)
dw    SystemSFX_Save            ; ($1820) $23 Save (success)
dw    SystemSFX_Letter          ; ($1832) $24 Letter Deletion (naming screen)
dw    $0000                     ;         $25 not used
dw    $0000                     ;         $26 not used
dw    $0000                     ;         $27 not used
dw    SystemSFX_Player1Turn     ; ($183E) $28 Ba-ding high (charcter active in battle)
dw    SystemSFX_Player2Turn     ; ($1857) $29 Ba-ding low (player 2 active in battle)
dw    $0000                     ;         $2A not used
dw    $0000                     ;         $2B not used
dw    SystemSFX_Ching           ; ($186F) $2C Ching
dw    $0000                     ;         $2D not used
dw    $0000                     ;         $2E not used
dw    $0000                     ;         $2F not used

; System Sound Effect $20: Click
SystemSFX_Click:
db $C4, $46         ; Set Voice Volume to $46 
db $DC, $05         ; Set Instrument $05
db $C8, $06, $0C    ; Change Pitch $0C w/ Envelope $06
db $D6, $06         ; Set Octave to $06
db $6C              ;   E  1/24
db $EB              ; End of Script

; System Sound Effect $21: Cursor
SystemSFX_Cursor:
db $C4, $46         ; Set Voice Volume to $46
db $DC, $05         ; Set Instrument 
db $C8, $06, $0C    ; Change Pitch $0C w/ Envelope $06
db $D6, $06         ; Set Octave to $06
db $96              ;   G  1/24
db $EB              ; End of Script

; System Sound Effect $22: Buzzer
SystemSFX_Buzzer:
db $C4, $6E         ; Set Voice Volume to $6E
db $D6, $04         ; Set Octave to $04
db $DC, $06         ; Set Instrument $06 
db $E2, $04         ; Loop Start ($05 times)
db $37              ;   C  1/64
db $E3              ; Loop End
db $EB              ; End of Script

; System Sound Effect $23: Save
SystemSFX_Save:
db $C4, $46         ; Set Voice Volume to $46
db $DC, $03         ; Set Instrument $03
db $DD, $0E         ; Set ADSR Attack Value ($0E)
db $D6, $07         ; Set Octave to $07 
db $E4              ; Enable Slur
db $28              ;   B  1/48
db $37              ;   C  1/64
db $53              ;   D  1/64
db $6E              ;   E  1/48
db $7C              ;   F  1/48
db $E0, $16         ; Set ADSR Release Value ($16)
db $90              ;   G  1/4
db $EB              ; End of Script

; System Sound Effect $24: Letter Deletion (naming screen)
SystemSFX_Letter:
db $C4, $46         ; Set Voice Volume to $46
db $DC, $07         ; Set Instrument $07
db $D6, $07         ; Set Octave to $07
db $DD, $06         ; Set ADSR Attack Value ($06
db $E0, $16         ; Set ADSR Release Value ($16
db $6C              ;   E  1/24
db $EB              ; End of Script

; System Sound Effect $28: Ba-ding high (character becomes active in battle)
SystemSFX_Player1Turn:
db $C4, $6E         ; Set Voice Volume to $6E
db $C9, $00, $0C, $7F ; Enable Vibrato ($00: delay, $0C: rate, $7F: amplitude)
db $DC, $06         ; Set Instrument 
db $D6, $05         ; Set Octave $05
db $88              ;   F# 1/24
db $D7              ; Octave Up
db $C4, $64         ; Set Voice Volume to $64
db $42              ;   C# 1/24
db $C4, $50         ; Set Voice Volume to $50
db $42              ;   C# 1/24
db $C4, $3C         ; Set Voice Volume to $3C
db $42              ;   C# 1/24
db $C4, $28         ; Set Voice Volume to $28
db $42              ;   C# 1/24
db $EB              ; End of Script

; System Sound Effect $29: Ba-ding low (player 2 becomes active in battle)
SystemSFX_Player2Turn:
db $C4, $6E         ; Set Voice Volume to 
db $C9, $00, $0C, $7F ; Enable Vibrato ($00: delay, $0C: rate, $7F: amplitude)
db $DC, $06         ; Set Instrument $06
db $D6, $05         ; Set Octave $05
db $42              ;   C# 1/24
db $C4, $64         ; Set Voice Volume to $64
db $A4              ;   G# 1/24
db $C4, $50         ; Set Voice Volume to $50
db $A4              ;   G# 1/24
db $C4, $3C         ; Set Voice Volume to $3C
db $A4              ;   G# 1/24
db $C4, $28         ; Set Voice Volume to $28
db $A4              ;   G# 1/24
db $EB              ; End of Script

; System Sound Effect $2C: Ching
SystemSFX_Ching:
db $C4, $41         ; Set Voice Volume to $41
db $DC, $05         ; Set Instrument $05 
db $D6, $07         ; Set Octave $07
db $E0, $18         ; Set ADSR Release Value ($18)
db $99              ;   G  1/64
db $CB, $00, $06, $BF ; Enable Tremolo ($00: delay, $06: rate, $BF: amplitude)
db $E0, $12         ; Set ADSR Release Value ($12)
db $D4              ; Enable Echo
db $9D              ;   G# 3/8
db $EB              ; End of Script

; Jump table for Track Commands
TrkCmdJumpTable:
dw TrkCmd_SetVoiceVol              ; $C4 Set Voice Volume to xx (00-7F)
dw TrkCmd_SetVoiceVolWithEnv       ; $C5 Set Voice Volume w/ Envelope (yy: volume, xx: envelope duration)
dw TrkCmd_SetVoicePan              ; $C6 Set Voice Pan to xx
dw TrkCmd_SetVoicePanWithEnv       ; $C7 Set Voice Pan w/ Envelope
dw TrkCmd_ChgPitchWithEnv          ; $C8 Change Pitch w/ Envelope 
dw TrkCmd_VibratoON                ; $C9 Enable Vibrato
dw TrkCmd_VibratoOFF               ; $CA Disable Vibrato
dw TrkCmd_TremoloON                ; $CB Enable Tremolo
dw TrkCmd_TremoloOFF               ; $CC Disable Tremolo
dw TrkCmd_PansweepON               ; $CD Enable Pansweep
dw TrkCmd_PansweepOFF              ; $CE Disable Pansweep
dw TrkCmd_NoiseClock               ; $CF Set Noise Clock
dw TrkCmd_NoiseON                  ; $D0 Enable Noise
dw TrkCmd_NoiseOFF                 ; $D1 Disable Noise
dw TrkCmd_PitchModON               ; $D2 Enable Pitch Modulation
dw TrkCmd_PitchModOFF              ; $D3 Disable Pitch Modulation
dw TrkCmd_EchoON                   ; $D4 Enable Echo
dw TrkCmd_EchoOFF                  ; $D5 Disable Echo
dw TrkCmd_SetOctave                ; $D6 Set Octave to xx
dw TrkCmd_OctaveUp                 ; $D7 Increment Octave
dw TrkCmd_OctaveDown               ; $D8 Decrement Octave
dw TrkCmd_SetTranspose             ; $D9 Set Transpose
dw TrkCmd_AddToTranspose           ; $DA Add to Transpose
dw TrkCmd_SetDetune                ; $DB Set Detune
dw TrkCmd_SetInstrument            ; $DC Set Instrument
dw TrkCmd_AttackADSR               ; $DD Set ADSR Attack Value (0-15
dw TrkCmd_DecayADSR                ; $DE Set ADSR Decay Value (0-7
dw TrkCmd_SustainADSR              ; $DF Set ADSR Sustain Value (0-7
dw TrkCmd_ReleaseADSR              ; $E0 Set ADSR Release Value (0-31
dw TrkCmd_ResetADSR                ; $E1 Reset ADSR Default Values
dw TrkCmd_LoopStart                ; $E2 Loop Start (loop xx+1 times
dw TrkCmd_LoopEnd                  ; $E3 Loop End
dw TrkCmd_SlurON                   ; $E4 Enable Slur
dw VoidReturn                      ; $E5 Disable Slur, handled in switch statement
dw TrkCmd_DrumRollON               ; $E6 Enable Drum Roll
dw VoidReturn                      ; $E7 Disable Drum Roll, handled in switch statement
dw TrkCmd_AddToNoteDuration        ; $E8 Add to Note Duration
dw TrkCmd_SFXA                     ; $E9 Play Game Sound Effect (voice A)
dw TrkCmd_SFXB                     ; $EA Play Game Sound Effect (voice B)
dw TrkCmd_EndOfSongScript          ; $EB End of Script
dw TrkCmd_Unused                   ; $EC Not used
dw TrkCmd_Unused                   ; $ED Not used
dw TrkCmd_Unused                   ; $EE Not used
dw TrkCmd_Unused                   ; $EF Not used
dw TrkCmd_SetTempo                 ; $F0 Set Tempo
dw TrkCmd_SetTempoWithEnv          ; $F1 Set Tempo w/ Envelope
dw TrkCmd_SetSongEchoVol           ; $F2 Set Song Echo Volume
dw TrkCmd_SetSongEchoVolWithEnv    ; $F3 Set Song Echo Volume w/ Envelope
dw TrkCmd_SetSongVolume            ; $F4 Set Song Volume
dw TrkCmd_JumpToYYYYWhenLoopIsXX   ; $F5 Jump to yyyy When Loop Count Reaches xx
dw TrkCmd_JumpToXXXX               ; $F6 Jump to xxxx
dw TrkCmd_SetEchoFeedback          ; $F7 Set Echo Feedback to yy over xx frames
dw TrkCmd_SetFilter                ; $F8 Set Filter ------yy
dw TrkCmd_IncOutputCode            ; $F9 Increment Output Code
dw TrkCmd_ClrOutputCode            ; $FA Clear Output Code
dw TrkCmd_IgnoreSongVolume         ; $FB Ignore Song Volume
dw TrkCmd_CondJumpToXXXX           ; $FC Conditional Jump to xxxx
dw TrkCmd_Unused                   ; $FD Not used
dw TrkCmd_Unused                   ; $FE Not used
dw TrkCmd_Unused                   ; $FF Not used

; Number of bytes for Track Commands
TrackCmdSize:
db $01        ; $C4 Set Voice Volume to xx
db $02        ; $C5 Set Voice Volume w/ Envelope
db $01        ; $C6 Set Voice Pan to xx
db $02        ; $C7 Set Voice Pan w/ Envelope
db $02        ; $C8 Change Pitch w/ Envelope
db $03        ; $C9 Enable Vibrato
db $00        ; $CA Disable Vibrato
db $03        ; $CB Enable Tremolo
db $00        ; $CC Disable Tremolo
db $02        ; $CD Enable Pansweep
db $00        ; $CE Disable Pansweep
db $01        ; $CF Set Noise Clock (00-1F)
db $00        ; $D0 Enable Noise
db $00        ; $D1 Disable Noise
db $00        ; $D2 Enable Pitch Modulation
db $00        ; $D3 Disable Pitch Modulation
db $00        ; $D4 Enable Echo
db $00        ; $D5 Disable Echo
db $01        ; $D6 Set Octave to xx
db $00        ; $D7 Increment Octave
db $00        ; $D8 Decrement Octave
db $01        ; $D9 Set Transpose
db $01        ; $DA Add to Transpose
db $01        ; $DB Set Detune
db $01        ; $DC Set Instrument
db $01        ; $DD Set ADSR Attack Value (0-15)
db $01        ; $DE Set ADSR Decay Value (0-7)
db $01        ; $DF Set ADSR Sustain Value (0-7)
db $01        ; $E0 Set ADSR Release Value (0-31)
db $00        ; $E1 Reset ADSR Default Values
db $01        ; $E2 Loop Start (loop xx+1 times)
db $00        ; $E3 Loop End
db $00        ; $E4 Enable Slur
db $00        ; $E5 Disable Slur
db $00        ; $E6 Enable Drum Roll
db $00        ; $E7 Disable Drum Roll
db $01        ; $E8 Add to Note Duration
db $01        ; $E9 Play Game Sound Effect (voice A)
db $01        ; $EA Play Game Sound Effect (voice B)
db $00        ; $EB End of Script
db $00        ; $EC Not used
db $00        ; $ED Not used
db $00        ; $EE Not used
db $00        ; $EF Not used
db $01        ; $F0 Set Tempo
db $02        ; $F1 Set Tempo w/ Envelope
db $01        ; $F2 Set Song Echo Volume
db $02        ; $F3 Set Song Echo Volume w/ Envelope
db $01        ; $F4 Set Song Volume
db $03        ; $F5 Jump to yyyy When Loop Count Reaches xx
db $02        ; $F6 Jump to xxxx
db $02        ; $F7 Set Echo Feedback to yy over xx frames
db $02        ; $F8 Set Filter ------yy
db $00        ; $F9 Increment Output Code
db $00        ; $FA Clear Output Code
db $00        ; $FB Ignore Song Volume
db $02        ; $FC Conditional Jump
db $00        ; $FD Not used
db $00        ; $FE Not used
db $00        ; $FF Not used

; Jump Table for Interrupts $10-$1F
Interrupt1xJumpTable:
dw NewSong                ; $10 Load New Song (x: song number, y: master volume
dw NewSongAlt             ; $11 Load New Song from Alternative Start
dw VoidReturn             ; $12 Not used (return)
dw VoidReturn             ; $13 Not used (return)
dw PauseAndNewSong        ; $14 Pause and Load New Song
dw PauseAndNewSongAlt     ; $15 Pause and Load New Song from Alternative Start
dw VoidReturn             ; $16 Not used (return)
dw VoidReturn             ; $17 Not used (return)
dw GameSFX                ; $18 Game Sound Effect
dw VoidReturn             ; $19 Not used (return)
dw VoidReturn             ; $1A Not used (return)
dw VoidReturn             ; $1B Not used (return)
dw VoidReturn             ; $1C Not used (return)
dw VoidReturn             ; $1D Not used (return)
dw VoidReturn             ; $1E Not used (return)
dw VoidReturn             ; $1F Not used (return)

; Jump Table for Interrupts $80-$8F
Interrupt8xJumpTable:
dw MasterAndSFXVol        ; $80 Set master/sound effect volume to yy (w/ envelope xx)
dw MasterAndSFXVol        ; $81 Set master volume to yy (w/ envelope xx)
dw MasterAndSFXVol        ; $82 Set sound effect volume to yy (w/ envelope xx)
dw SFXPan                 ; $83 Set sound effect pan to yy (w/ envelope xx)
dw TempoRatio             ; $84 Set Tempo Ratio (yy = envelope duration, xx = tempo ratio, signed fractioni)
dw MasterPitch            ; $85 Change Pitch
dw VoidReturn             ; $86 Not used (return)
dw VoidReturn             ; $87 Not used (return)
dw VoidReturn             ; $88 Not used (return)
dw ConditionalJumpON      ; $89 Enable Conditional Jump (used by Phantom Train and Dancing Mad)
dw VoidReturn             ; $8A Not used (return)
dw VoidReturn             ; $8B Not used (return)
dw VoidReturn             ; $8C Not used (return)
dw VoidReturn             ; $8D Not used (return)
dw VoidReturn             ; $8E Not used (return)
dw VoidReturn             ; $8F Not used (return)

; Jump Table for Interrupts $F0-$FF
InterruptFxJumpTable:
dw StopPlayback           ; $F0 Stop song & sound effect
dw StopPlayback           ; $F1 Stop song
dw StopPlayback           ; $F2 Stop sound effect
dw ToggleMonoMode         ; $F3 Enable/Disable Mono Mode
dw MuteVoices             ; $F4 Mute Voices (x: voices to mute, bitmask)
dw SongPauseToggle        ; $F5 Pause/Unpause music (0 = unpause, 1 = pause)
dw FastForwardToggle      ; $F6 Enable/Disable Fast Forward (0 = disable, 1 = enable)
dw VoidReturn             ; $F7 Not used (return)
dw VoidReturn             ; $F8 Not used (return)
dw VoidReturn             ; $F9 Not used (return)
dw VoidReturn             ; $FA Not used (return)
dw VoidReturn             ; $FB Not used (return)
dw InitEcho               ; $FC Set Echo Delay to xx
dw Interrupt_SetDSPReg    ; $FD Set DSP Register xx with data yy
dw TransferDataFromSCPU   ; $FE Transfer Data from SCPU
dw ResetCodes             ; $FF Reset Codes

; Register list (initial)
InitRegisters:
db $4C        ; 01: Key-on voices
db $2D        ; 02: Pitch modulation enabled voices
db $3D        ; 03: Noise enabled voices
db $6C        ; 04: Flags
db $5C        ; 05: Muted voices
db $4D        ; 06: Echo enable
db $2C        ; 07: Echo volume left
db $3C        ; 08: Echo volume right
db $0D        ; 09: Echo feedback
db $0F        ; 0A: C0 echo filter
db $1F        ; 0B: C1 echo filter
db $2F        ; 0C: C2 echo filter
db $3F        ; 0D: C3 echo filter
db $4F        ; 0E: C4 echo filter
db $5F        ; 0F: C5 echo filter
db $6F        ; 10: C6 echo filter
db $7F        ; 11: C7 echo filter

; Variables whose contents are stored in the registers listed above (initial)
InitSettings:
db $22        ; 01: Key-on voices
db $89        ; 02: Pitch modulation enabled voices
db $88        ; 03: Noise enabled voices
db $8A        ; 04: Flags
db $24        ; 05: Muted voices
db $87        ; 06: Echo enable
db $4D        ; 07: Echo volume left
db $4D        ; 08: Echo volume right
db $76        ; 09: Echo feedback
db $66        ; 0A: C0 echo filter
db $68        ; 0B: C1 echo filter
db $6A        ; 0C: C2 echo filter
db $6C        ; 0D: C3 echo filter
db $6E        ; 0E: C4 echo filter
db $70        ; 0F: C5 echo filter
db $72        ; 10: C6 echo filter
db $74        ; 11: C7 echo filter


warnpc $002000
base off
