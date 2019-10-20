; Entry Points
C50000:  JMP C50034             ; Initialization
         NOP
C50004:  JMP C50131             ; SPC Interrupts 
         NOP
C50008:  JMP C5031C             ; Not used?
         NOP
C5000C:  JMP C503EA             ; Not used?
         NOP

; Pointers to the 6 main chunks of SPC data
C50010:  dw SPC_Engine                     ; SPC Engine
         dw SoundEffect_Scripts            ; Game Sound Effect Scripts
         dw SoundEffect_Samples            ; Sound Effects BRR Data
         dw SoundEffect_SamplePointers     ; Pointers to Sound Effect BRR Data
         dw SoundEffect_ADSR               ; Sound Effect ADSR Data
         dw SoundEffect_PitchMultiplier    ; Sound Effect Pitch Multiplier

; SPC addresses for 6 main chunks of SPC data
C5001C:  dw $0200               ; SPC Engine
         dw $2C00               ; Game Sound Effect Scripts
         dw $4800               ; Sound Effects BRR Data
         dw $1B00               ; Pointers to Sound Effect BRR Data
         dw $1A80               ; Sound Effect ADSR Data
         dw $1A00               ; Sound Effect Pitch Multiplier

; Pointers to song data chunks (not used)
C50028:  dw Song_Data_Pointers             ; Pointers tp Song Data           
         dw Instrument_BRR_Pointers        ; Pointers to Instrument BRR Data
         dw Instrument_Loop_Start_Data     ; Instrument Loop Start Data
         dw Instrument_ADSR_Data           ; Instrument ADSR Data
         dw Instrument_Wave_Rate_Data      ; Instrument Wave Rate Data
         dw Instruments_for_each_Song      ; Instruments for Each Song

; Entry point C5/0000
; Initialize Sound Engine, Upload Engine and SFX Data to SPC
C50034:  PHB             ; Push Bank
         PHD             ; Push Direct Page
         PHP             ; Push Flags
         REP #$20        ; 16-bit A
         REP #$10        ; 16-bit X, Y
         PHA             ; Push A
         PHX             ; Push X
         PHY             ; Push Y
         SEP #$20        ; 8-bit A
         LDA #$00        ; Zero A
         PHA             ; Push A
         PLB             ; Zero Bank
         LDX #$1300      ; X = $1300
         PHX             ; Push X
         PLD             ; Set Direct Page to $1300
         LDX #$BBAA      ; SPC700 init message
         LDY #$F0FF      ; 
C5004F:  STY $2140       ; Clear Port-0
         CPX $2140       ; Test for init message
         BNE C5004F      ; Wait for SPC700 to initialize
         LDX #$0000      ; Zero X
         LDA.l C5001C    ; SPC RAM Address, low byte
         STA $2142       ; Store transfer address low
         LDA.l C5001C+1  ; SPC RAM Address, high byte
         STA $2143       ; Store transfer address high
         LDA #$CC        ; Start transfer message
         STA $2141       ; Set to Port-1
         STA $2140       ; Set to Port-0
C50070:  CMP $2140       ; ..
         BNE C50070      ; Wait for APU
C50075:  LDA #$00        ; Zero A
         XBA             ; Zero transfer counter
         LDA.l C50010,X   ; Pointers to the 6 main chunks of SPC data, low byte
         STA $10         ; Store low byte
         LDA.l C50010+1,X ; Pointers to the 6 main chunks of SPC data, high byte
         STA $11         ; Store high byte
         LDA #$C5        ; Bank $C5/XXXX
         STA $12         ; Store bank byte
         LDY #$0000      ; Zero Y
         LDA [$10],Y     ; Chunk size, low byte
         CLC             ; Clear Carry
         ADC #$02        ; Add 2 (account for chunk size bytes) 
         STA $1C         ; Set Chunk size, low byte
         INY             ; Increment Y, chunk pointer
         LDA [$10],Y     ; Chunk size, high byte
         ADC #$00        ; Add Carry
         STA $1D         ; Set Chunk size, high byte
         INY             ; Increment Y, chunk pointer
C5009A:  LDA [$10],Y     ; Byte to Transfer
         STA $2141       ; Send to Port-1
         XBA             ; Recover transfer counter
         STA $2140       ; Start transfer
C500A3:  CMP $2140       ; ..
         BNE C500A3      ; Wait for transfer
         INC             ; Next transfer counter
         XBA             ; Store in B
         INY             ; Increment Y, chunk pointer
         CPY $1C         ; Reached end of chunk?
         BNE C5009A      ; Loop if not
         XBA
         INC
         INC
         INC
         BNE C500B6
         INC
C500B6:  INX             ; Increment X
         INX             ; Increment X, next chunk pointer
         CPX #$000C      ; Done 6 chunks?
         BEQ C500DA      ; Continue if so
         XBA
         LDA.l C5001C,X    ; SPC addresses for 6 main chunks of SPC data, low byte
         STA $2142       ; Store transfer address low
         LDA.l C5001C+1,X  ; SPC addresses for 6 main chunks of SPC data, high byte
         STA $2143       ; Store transfer address high
         XBA
         STA $2141
         STA $2140
C500D3:  CMP $2140       ; ..
         BNE C500D3      ; Wait for APU
         BRA C50075      ; Next chunk
C500DA:  LDY #$0200      ; Starting address of execution
         STY $2142
         XBA
         LDA #$00
         STA $2141
         XBA
         STA $2140
C500EA:  CMP $2140       ; ..
         BNE C500EA      ; Wait for APU
         XBA
         STA $2140
         LDX #$0100      ; X is $100
C500F6:  STA $12FF,X     ; Clear $1300-$1400
         DEX             ; Decrement X
         BNE C500F6      ; Loop for $100 bytes
         LDA #$FF
         STA $05
         REP #$20        ; 16-bit A
         LDA.l SoundEffect_Samples ; Size of SFX BRRs
         CLC             ; Clear carry
         ADC #$4800      ; BRR samples SPC address
         STA $F8
         STA $A0
         LDX #$0800      ; X is #$800
C50111:  DEX             ; Decrement X
         BNE C50111      ; Wait $800 cycles
         SEP #$20        ; 8-bit A
         LDA #$00
         STA $FA
         LDA #$C5
         STA $FB         ; #$C500?
         LDA #$05
         STA $F0
         ASL A
         ASL A
         ASL A
         EOR #$FF               ; #$28 becomes #$D7
         INC A
         CLC
         ADC #$F5
         STA $F2                ; #$CD is the result if math is correct
         STZ $F1         ; 
         BRA C50171      ; Long exit

; Entry point C5/0004
; Handle SPC interrupt commands
C50131:  PHB             ; Push Bank
         PHD             ; Push Direct Page
         PHP             ; Push Flags
         REP #$20        ; 16-bit A
         REP #$10        ; 16-bit X, Y
         PHA             ; Push A
         PHX             ; Push X
         PHY             ; Push Y
         SEP #$20        ; 8-bit A
         LDA #$00        ; Zero A
         PHA             ; Push A
         PLB             ; Zero Bank
         LDX #$1300      ; X is $1300
         PHX             ; Push X
         PLD             ; Set Direct Page to $1300
C50146:  SEP #$20        ; 8-bit A
         LDA $00         ; Interrupt command
         BEQ C50171      ; If Zero long exit
         BMI C50167      ; If $80-$FF
         CMP #$10        ; Less then $10
         BCC C50171      ; If so long exit
         CMP #$18        ; More then $18
         BCS C50163      ; Branch if so (Test for $20-$3F)
         AND #$0F        ; $00-$0F
         ASL             ; Multiply by 2
         XBA             ; Store in B
         LDA #$00        ; Zero A
         PHA             ; Push Zero, high byte
         XBA             ; Recover B to A
         PHA             ; Push A, low byte
         PLX             ; Pull to X
         JMP (C506FE,X)  ; ultimately jumps to either C50171 or C50180

C50163:  CMP #$30        ; More then $30
         BCS C5016A      ; Branch if so (test for $30-$3F)
C50167:  JMP C505A6      ; Handle codes $20-$2F (System Sound Effects)

C5016A:  CMP #$40        ; More then $40
         BCS C50171      ; If so long exit
         JMP C50608      ; Handle codes $30-$3F (Quickplay Song)

; Long exit
C50171:  SEP #$20        ; 8-bit A
         STZ $00         ; Zero Interrupt Command
         REP #$20        ; 16-bit A
         REP #$10        ; 16-bit X, Y
         PLY             ; Pull Y
         PLX             ; Pull X
         PLA             ; Pull A 
         PLP             ; Pull Flags
         PLD             ; Pull Direct Page
         PLB             ; Pull Bank
         RTL             ; Return long

; Load Song (Interrupts $10, $11, $14, $15) 
C50180:  SEP #$20        ; 8-bit A
         LDA $01         ; Song to play
         CMP $05         ; Same as currently playing song
         BEQ C50171      ; If so long exit
         CMP.l Nr_of_Songs ; $55, the number of songs ($C53C5E)
         BCS C50171      ; song is greater than number of total songs, so long exit
         JSR C5061F      ; Check if current song should pause
         LDA $01         ; Song to play
         CMP #$54        ; Is $54 Ending #2?
         BNE C5019D      ; branch if not Ending #2
         LDA $05         ; Currently playing song
         CMP #$53        ; Is $53 Ending #1?
         BEQ C501A4      ; Branch if Ending #1
C5019D:  LDA $F3         ; Load Sound Effects Flag 
         BEQ C501A4      ; If Zero skip Sound Effect Script loadingg
         JSR C50640      ; Upload Sound Effect Scripts
C501A4:  SEP #$20        ; 8-bit A
         LDA $02         ; Master Volume (param 2)
         STA $2142       ; Set to Port-2
         LDA $01         ; Song Index (param 1)
         STA $2141       ; Set to Port-1
         LDA $00         ; SPC Interrupt Code
         STA $2140       ; Set to Port-0
C501B5:  CMP $2140       ; ..
         BNE C501B5      ; Wait for APU
         INC A           ; Increment transfer counter
         AND #$7F        ; Remove high bit
         STA $1E         ; Store transfer counter
         REP #$20        ; 16-bit A
         LDX #$0020      ; X is $20
C501C4:  STZ $141E,X     ; Zero $141F-$143E
         DEX             ; Decrement X
         BNE C501C4      ; Loop for $20 bytes
         LDA #$1400      ; 
         STA $10
         LDA #$1420      ;
         STA $12
         LDA $00         ; Current song and interrupt command
         AND #$FF00      ; Remove command (song index in high byte)
         LSR A           ; Halve
         LSR A           ; Divide by 4
         LSR A           ; Divide by 8 ($0100 -> $0020)
         TAX             ; A to X
         ADC #$0020      ; Add $20
         STA $1C         ; Store end pointer
C501E2:  LDA.l Instruments_for_each_Song,X  ; 16-bit index table
         STA ($10)
         INC $10         ; Increment pointer
         INC $10         ; Increment pointer
         LDY #$0040
C501EF:  CMP $131E,Y     ; 
         BEQ C501FE      ; If so skip to next instrument
         DEY             ; Decrement Y
         DEY             ; Decrement Y
         BNE C501EF      ; Loop 
         STA ($12)
         INC $12         ; Increment pointer
         INC $12         ; Increment pointer, next
C501FE:  INX             ; Increment X
         INX             ; Increment X, next instrument
         CPX $1C         ; Reached end pointer?
         BNE C501E2      ; Loop for instruments in song
         LDA $1420       ; First instrument pointer
         BNE C5020C      ; Get Instruments for Song
         JMP C503EA      ; Continue Song Upload

; Get Instrument Pointers for a Song
C5020C:  LDX #$0000      ; Zero X
         STX $1C         ; Zero transfer size
C50211:  LDA $1420,X     ; Instrument index
         BEQ C50253      ; Hit index $0000 so go to upload
         PHX             ; Push X
         DEC A           ; Decrement A
         STA $E2         ; Store index
         ASL A           ; Double it
         CLC             ; Clear Carry
         ADC $E2         ; Multiply by 3
         TAX             ; A to X
         SEP #$20        ; 8-bit A
         LDA.l Instrument_BRR_Pointers,X    ; low byte
         STA $10         ; Set low byte
         LDA.l Instrument_BRR_Pointers+1,X  ; middle byte
         STA $11         ; Set middle byte
         LDA.l Instrument_BRR_Pointers+2,X  ; high byte
         STA $12         ; Set high byte
         LDY $10         ; Load pointer to Y
         STZ $10         ; Zero low byte 
         STZ $11         ; Zero middle byte
         LDA [$10],Y     ; Load dynamic Instrument Pointer
         XBA             
         INY             ; Increment Y (for carry)
         BNE C50241      ; Skip next line if no carry
         INC $12         ; Carry to high byte
C50241:  LDA [$10],Y
         XBA
         REP #$20        ; 16-bit A
         CLC             ; Clear Carry
         ADC $1C
         STA $1C
         PLX             ; Pull X
         INX             ; Increment X
         INX             ; Increment X, next Instrument
         CPX #$0020      ; Done all Instruments?
         BNE C50211      ; Loop for all Instruments in Song to load
C50253:  LDX #$0040      ; Loop for Instrument Pointers and Loop Start Pointers 
C50256:  LDA $1E,X       ; Instrument 
         BNE C50260      ; Upload Instrument
         DEX             ; Decrement X
         DEX             ; Decrement X, next instrument
         BNE C50256      ; Loop for all pointers
         BRA C5026B      ; Upload Instrument BRR Data

; Upload Instrument BRR
C50260:  LDA $A0,X       ; Next SPC pointer for BRR instrument
         CLC             ; Clear Carry
         ADC $1C         ; Add previous BRR size
         BCS C5026E      ; 
         CMP $F1         ; Compare with Zero? 
         BCS C5026E      ; 
C5026B:  JMP C5031C      ; Upload Instrument BRR Data

; 
C5026E:  SEP #$20        ; 8-bit A
         LDA #$07        ; No transfer message
         STA $2141       ; Store transfer size
         REP #$20        ; 16-bit A
         LDX #$0000      ; Zero X
C5027A:  LDA $20,X
         BEQ C50296
         LDY #$0000      ; Zero Y
C50281:  CMP $1400,Y
         BEQ C5028F
         INY             ; Increment Y
         INY             ; Increment Y, next instrument
         CPY #$0020      ; Done all instruments?
         BNE C50281      ; Loop for
         STZ $20,X
C5028F:  INX             ; Increment X
         INX             ; Increment X
         CPX #$0040      ; Done ?
         BNE C5027A      ; Loop for
C50296:  LDX #$0000      ; Zero X
C50299:  LDA $20,X
         BEQ C502A4
         INX
         INX
         CPX #$0040
         BNE C50299
C502A4:  STX $1C         ; Set transfer size
         LDX #$0040
C502A9:  LDA $1E,X
         BNE C502B1
         DEX
         DEX
         BNE C502A9
C502B1:  CPX $1C         ; C
         BNE C502B8
         JMP C5031C      ;

; Loop  for 
C502B8:  LDY #$0000      ; Zero X
C502BB:  LDA $1320,Y     ; 
         BNE C5030D
         TYX
         BRA C502C7
C502C3:  LDA $20,X
         BNE C502D0      ; Transfer
C502C7:  INX             ; Increment X
         INX             ; Increment X, next
         CPX #$0040      ; Done $40 bytes?
         BNE C502C3      ; Loop if not
         BRA C50316      ; Continue...
;
C502D0:  STA $1320,Y     ; Store
         STZ $20,X
         LDA $A0,X
         STA $2142
         SEP #$20        ; 8-bit A
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         REP #$20        ; 16-bit A
         LDA $13A0,Y
         STA $2142
         CLC
         ADC $60,X
         STA $13A2,Y
         SEP #$20        ; 8-bit A
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         REP #$20        ; 16-bit A
         LDA $60,X
         STA $2142
         STA $1360,Y
         SEP #$20        ; 8-bit A
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
C5030D:  REP #$20        ; 16-bit A
         INY             ; Increment Y
         INY             ; Increment Y, next
         CPY #$0040      ; Done ?
         BNE C502BB      ; Loop if not
C50316:  SEP #$20        ; 8-bit A
         LDA #$F0        ; Reset transfer message
         STA $1E         ; Store to transfer counter

; Entry point C5/0008

C5031C:  SEP #$20        ; 8-bit A
         LDX #$0000      ; Zero X
C50321:  LDA $20,X       ; 
         BEQ C50333      ; Skip if $00
         INX             ; Increment X
         INX             ; Increment X, next
         CPX #$0040      ; Done $40 bytes?
         BNE C50321      ; Loop if not
         LDA #$00        ; Zero A
C5032E:  STA $1F,X       ; Zero 
         DEX
         BNE C5032E      ; Loop 
C50333:  LDY #$0000      ; Zero Y
C50336:  REP #$20        ; 16-bit A
         LDA $1420,Y
         BEQ C50371
         STA $20,X       ; Instrument index
         PHY             ; Push Y
         PHX             ; Push X
         DEC A           ; Decrement A
         STA $E2         ; Store instrument index
         ASL A           ; Double it
         CLC             ; Clear carry
         ADC $E2         ; Multiply by 3
         TAX             ; A to X
         SEP #$20        ; 8-bit A
         LDA.l Instrument_BRR_Pointers,X     ; low byte
         STA $10         ; Store low byte 
         LDA.l Instrument_BRR_Pointers+1,X   ; middle byte
         STA $11         ; Store middle byte
         LDA.l Instrument_BRR_Pointers+2,X   ; high byte
         STA $12         ; Store high byte
         LDY $10         ; Y is BRR pointer
         STZ $10         ; Zero low byte
         STZ $11         ; Zero middle byte
         PLX             ; Pull X, instrument slot
         JSR C50374      ;
         PLY             ; Pull Y, instrument slot
         INY             ; Increment Y
         INY             ; Increment Y
         INX             ; Increment X
         INX             ; Increment X
         CPY #$0020      ; Done $10 instrument slots?
         BNE C50336      ; Loop if not
C50371:  JMP C503EA      ; Upload Song Script and Instrument Data

C50374:  PHP             ; Push flags
         PHX             ; Push X
         SEP #$20        ; 8-bit A
         PLX             ; Pull X ..
         PHX             ; Push X ..
         LDA $A0,X
         STA $2142
         LDA $A1,X
         STA $2143
         LDA #$03
         STA $2141
         LDA $1E
         STA $2140
C5038E:  CMP $2140
         BNE C5038E
         INC A
         AND #$7F
         STA $1E
         LDA [$10],Y
         STA $1C
         STA $60,X
         CLC
         ADC $A0,X
         STA $A2,X
         INY
         BNE C503A8
         INC $12
C503A8:  LDA [$10],Y
         STA $1D
         STA $61,X
         ADC $A1,X
         STA $A3,X
         INY
         BNE C503B7
         INC $12
C503B7:  LDX $1C
C503B9:  LDA [$10],Y
C503BB:  STA $2141
         INY
         BNE C503C3
         INC $12
C503C3:  LDA [$10],Y
         STA $2142
         INY
         BNE C503CD
         INC $12
C503CD:  LDA [$10],Y
         STA $2143
         INY
         BNE C503D7
         INC $12
C503D7:  LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         DEX             ; Decrement X
         DEX             ; Decrement X
         DEX             ; Decrement X
         BNE C503B9      ; Loop for
         LDA #$F0        ; Restart transfer command
         STA $1E         ; Store it
         PLX             ; Pull X
         PLP             ; Pull Flags
         RTS             ; Return

;------------------------------------------------------------------------------
;			      Entry point C5/000C
;		     Upload Song Script and Instrument Data 
;------------------------------------------------------------------------------

C503EA:  REP #$20        ; 16-bit A
         LDA #$1480
         STA $10
         LDX #$0000      ; Zero X
C503F4:  LDA $1400,X
         BEQ C50424
         LDY #$0000      ; Zero Y
C503FC:  CMP $1320,Y     ; 
         BEQ C5040D      ; Calculate Loop Start Data to RAM
         INY             ; Increment Y
         INY             ; Increment Y
         CPY #$0040      ; Done all instruments?
         BNE C503FC      ; Loop for 
         LDA #$0000      ; Zero A
         BRA C50424      ; Skip loop start calculations

; Branch calculate loop start pointer
C5040D:  PHX             ; Push X
         DEC A           ; Decrement A
         ASL A           ; Dduble A
         TAX             ; Transfer A to X
         LDA $13A0,Y     ;
         STA ($10)       ; Current instrument sample pointer
         INC $10         ; Increment Pointer
         INC $10         ; Increment Pointer
         CLC             ; Clear Carry
         ADC.l Instrument_Loop_Start_Data,X    ; Add Loop start info for Instruments
         STA ($10)       ; Store calculated loop start position
         PLX             ; Pull X
         BRA C5042C      ; Continue to transfer

; Branch loop start is start of sample
C50424:  STA ($10)
         INC $10
         INC $10
         STA ($10)
C5042C:  INC $10
         INC $10
         INX
         INX
         CPX #$0020
         BNE C503F4
         SEP #$20        ; 8-bit A
         LDX #$1B80
         STX $2142       ; Store transfer address
         LDA #$02        ; 2 byte chunks
         STA $2141       ; Store transfer chunk size
         LDA $1E
         STA $2140
C50449:  CMP $2140       ; ..
         BNE C50449      ; Wait for APU
         INC A           ; Increment transfer counter
         AND #$7F        ; Remove high bit
         STA $1E         ; Store transfer counter
         LDX #$0000      ; Zero X
C50456:  LDA $1480,X
         STA $2142       ; Transfer data low
         LDA $1481,X
         STA $2143       ; Transfer data high
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         INX             ; Increment X
         INX             ; Increment X, next instrument
         CPX #$0040      ; Done $20 instruments?
         BNE C50456      ; Loop if not
         LDA #$F0        ; Restart transfer message
         STA $1E         ; Store it
         SEP #$20        ; 8-bit A
         LDX #$1A40      ; Instrument Pitch Multipliers (SPC address)
         STX $2142       ; Store transfer address
         LDA #$02        ; 2 byte chunks
         STA $2141       ; Store transfer chunk size
         LDA $1E         ; Load restart message
         STA $2140       ; Restart transfer
C50486:  CMP $2140       ; ..
         BNE C50486      ; Wait for APU
         INC A           ; Increment transfer counter
         AND #$7F        ; Remove high bit
         STA $1E         ; Store transfer counter
         LDY #$0000      ; Zero Y
C50493:  REP #$20        ; 16-bit A
         LDA $1400,Y     ; Instrument Index
         DEC A           ; Decrement A
         ASL A           ; Double A
         TAX             ; A to X
         LDA.l Instrument_Wave_Rate_Data,X           ; wave rate multiplying for samples
         STA $2142       ; Store transfer data
         SEP #$20        ; 8-bit A
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         INY             ; Increment Y
         INY             ; Increment Y, next instrument
         CPY #$0020      ; Done $20 bytes?
         BNE C50493      ; Loop if not
         LDA #$F0        ; Restart transfer command
         STA $1E         ; Store to $1E
         SEP #$20        ; 8-bit A
         LDX #$1AC0      ; Instrument ADSR Data (SPC address)
         STX $2142       ; Store transfer address
         LDA #$02        ; 2 byte chunks
         STA $2141       ; Store transfer chunk size
         LDA $1E         ; Restart transfer command
         STA $2140       ; Restart transfer
C504C8:  CMP $2140       ; ..
         BNE C504C8      ; Wait for APU
         INC A           ; Increment transfer counter
         AND #$7F        ; Remove high bit
         STA $1E         ; Store transfer counter
         LDY #$0000      ; Zero Y
C504D5:  REP #$20        ; 16-bit A
         LDA $1400,Y     ; Instrument index
         DEC A           ; Decrement A
         ASL A           ; Double A
         TAX             ; A to X
         LDA.l Instrument_ADSR_Data,X
         STA $2142       ; Store transfer data
         SEP #$20        ; 8-bit A
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         INY             ; Increment Y
         INY             ; Increment Y, next instrument
         CPY #$0020      ; Done $10 instruments?
         BNE C504D5      ; Loop if not
         LDA #$F0        ; Restart transfer message
         STA $1E         ; Store it
         SEP #$20        ; 8-bit A
         LDA $05
         BMI C50506
         LDX $04
         STX $08
         LDX $06
         STX $0A
C50506:  LDX $00         ; Current interrupt bytes 0 and 1
         STX $04         ; Set as Previous interrupt bytes 0 and 1
         LDX $02         ; Current interrupt bytes 2 and 3
         STX $06         ; Set as Previous interrupt bytes 2 and 3
         LDX #$1C00      ; Song Script (SPC address)
         STX $2142       ; Store transfer address
         LDA #$02        ; 2 byte chunks
         STA $2141       ; Store transfer chunk size
         LDA $1E         ; Restart transfer message
         STA $2140       ; Restart transfer
C5051E:  CMP $2140       ; ..
         BNE C5051E      ; Wait for APU
         INC A           ; Increment transfer counter
         AND #$7F        ; Remove high bit
         STA $1E         ; Store transfer counter
         REP #$20        ; 16-bit A
         LDA $01         ; Song index (with command byte)
         AND #$00FF      ; Remove command byte
         STA $E2         ; Store song index
         ASL A           ; Double A
         CLC             ; Clear carry
         ADC $E2         ; Multiply by 3
         TAX             ; A to X
         SEP #$20        ; 8-bit A
         LDA.l Song_Data_Pointers,X     ; low byte
         STA $10         ; Store low byte
         LDA.l Song_Data_Pointers+1,X   ; middle byte
         STA $11         ; Store middle byte
         LDA.l Song_Data_Pointers+2,X   ; high byte
         STA $12         ; Store high byte
         LDY $10         ; Y is Song Data Pointer (mid, low)
         STZ $10         ; Zero low byte
         STZ $11         ; Zero middle byte
         LDA [$10],Y     ;
         STA $1C
         INY
         BNE C50559
         INC $12
C50559:  LDA [$10],Y
         STA $1D
         INY
         BNE C50562
         INC $12
C50562:  LDX $1C
         CPX #$1000
         BCC C5056B
         INC $F3         ; Increment Load Sound Effects Flag
C5056B:  LDA [$10],Y
         STA $2142
         INY
         BNE C50575
         INC $12
C50575:  LDA [$10],Y
         STA $2143
         INY
         BNE C5057F
         INC $12
C5057F:  LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         DEX             ; Decrement X
         DEX             ; Decrement X, next 
         BPL C5056B      ; Loop until
         LDA #$F0        ; Stop trasfer/Reset transfer
         LDX #$0400      ; X is $400
         STA $2141       ; Stop transfer
         STA $2140       ; Reset transfer
C50595:  CMP $2140       ; ..
         BEQ C505A0      ; Skip if APU ready
         DEX             ; Decrement X
         BNE C50595      ; Loop until APU ready or $400 cycles
         LDX #$0400      ; X is $400
C505A0:  DEX             ; Decrement X
         BNE C505A0      ; Wait $400 cycles
         JMP C50171      ; Long Exit

; Handle SPC codes $20-$2F (Play system sound effects)
C505A6:  SEP #$20        ; 8-bit A
         LDA $03         ; 
         STA $2143       ; 
         LDA $02         ; 
         STA $2142       ; 
         LDA $01         ; 
         STA $2141       ; 
         LDA $00         ; 
         LDX #$0400      ; 
         STA $2140       ; 
         CMP $2140       ; 
         BEQ C505C7
         DEX             ; Decrement X
         BNE $F8
C505C7:  CMP #$F0
         BCC C50605      ;  (long exit)
         CMP #$F2
         BCS C505E3
         LDA $05
         BMI C505DD
         STA $09
         LDA $04
         STA $08
         LDX $06
         STX $0A
C505DD:  LDA #$FF
         STA $05
         BRA C50605      ;  (long exit)
C505E3:  CMP #$FC
         BNE C50605      ;  (long exit)
         LDA $01
         AND #$0F
         STA $F0
         ASL A
         ASL A
         ASL A
         EOR #$FF
         INC A
         CLC
         ADC #$F5
         STA $F2
         LDX #$0000      ; Zero X
         LDA #$00        ; Zero A
C505FD:  STA $20,X       ; Zero $1320-$1360
         INX             ; Increment X
         CPX #$0040      ; Reached $40
         BNE C505FD      ; Loop if not
C50605:  JMP C50171      ; Long Exit

; Handle SPC codes $30-$3F (shortcuts to play songs $00-$0F)
C50608:  REP #$20        ; 16-bit A
         AND #$000F      ; $00-$0F
         ASL A           ; Multiply by 2
         ASL A           ; Multiply by 4
         TAX             ; Transfer A to X
         LDA.l C506B9+2,X  ; data for SPC codes $30-$3F
         STA $02         ; Set SPC codes (last 2 bytes)
         LDA.l C506B9,X    ; data for SPC codes $30-$3F
         STA $00         ; Set SPC codes (first 2 bytes)
         JMP C50146      ; Back to handle interrupt commands

; Check if current song should pause
C5061F:  PHP             ; Push flags
         SEP #$20        ; 8-bit A
         LDA $00
         CMP #$14        ; 
         BCS C50638      ; If so branch to pause and exit
         LDX #$0000      ; Zero X
C5062B:  LDA.l C506F9,X  ; Song indexes which need the current song to be paused then resumed
         BMI C5063E      ; Exit if high bit set
         CMP $01         ; Song to play is list value?
         BEQ C50638      ; branch if matched, pause and exitd
         INX             ; Increment X
         BRA C5062B      ; loop until high bit terminator or match
C50638:  LDA #$04        ; Pause bit? for commands
         ORA $00
         STA $00
C5063E:  PLP             ; Pull flags
         RTS             ; Return

; Upload Sound Effect Scripts to SPC-700
C50640:  SEP #$20        ; 8-bit A
         LDA #$FE        ; Reset SPC?
C50644:  STA $2140
         CMP $2140
         BNE C50644      ; Wait for APU
         INC a           ; Increment transfer counter
         AND #$7F        ; Remove high bit
         XBA             ; Transfer counter to B
         LDX #$2C00      ; Pointer to Sound Effect Scripts (SPC address)
         STX $2142       ; Store transfer data
         LDA #$02        ; Transfer 2 bytes
         STA $2141       ; Store transfer size
         XBA             ; Transfer counter from B
         STA $2140       ; Start transfer
C5065F:  CMP $2140       ; ..
         BNE C5065F      ; Wait for APU
         INC a           ; Increment transfer counter
         AND #$7F        ; remove high bit
         STA $1E         ; Store transfer counter
         LDA.l SoundEffect_Scripts        ; chunk size low byte
         STA $1C         ; Store chunk size low byte
         LDA.l SoundEffect_Scripts+1      ; chunk size high byte
         STA $1D         ; Store chunk size high byte
         LDX #$0000      ; Zero X
C50678:  LDA.l SoundEffect_Scripts+2,x    ; Data word low byte
         STA $2142       ; Store word low byte
         LDA.l SoundEffect_Scripts+3,x    ; Data word high byte
         STA $2143       ; Store word high byte
         INX             ; Increment X
         INX             ; Increment X, next word
         LDA $1E         ; Transfer counter
         JSR C506A9      ; Transfer to APU
         STA $1E         ; Store transfer counter
         CPX $1C         ; Compare with chunk size
         BNE C50678      ; Loop for chunk size
         LDA #$F0        ; Reset transfer message
         LDX #$0400      ; X is #$400
         STA $2141       ; Stop Transfer
         STA $2140       ; Reset Transfer
C5069E:  CMP $2140       ; ..
         BEQ C506A6      ; Exit when APU is done
         DEX             ; Decrement X
         BNE C5069E      ; Loop for $400 counts
C506A6:  STZ $F3         ; Zero Load Sound Effects Flag 
         RTS             ; Return

; Transfer to APU and increment A
C506A9:  PHP             ; Push Flags
         SEP #$20        ; 8-bit A
         STA $2140       ; Set Port-0
C506AF:  CMP $2140       ; ..
         BNE C506AF      ; Wait for APU
         INC A           ; Increment A
         AND #$7F        ; Remove high bit
         PLP             ; Pull Flags
         RTS             ; Return

; SPC codes $30-3F (shortcuts to play songs $00-$0F at full volume) 
C506B9:  db $10, $00, $FF, $00        ; $00 (Silence) 
         db $10, $01, $FF, $00        ; $01 Prelude
         db $10, $02, $FF, $00        ; $02 Opening Theme #1
         db $10, $03, $FF, $00        ; $03 Opening Theme #2
         db $10, $04, $FF, $00        ; $04 Opening Theme #3
         db $10, $05, $FF, $00        ; $05 Awakening
         db $10, $06, $FF, $00        ; $06 Terra
         db $10, $07, $FF, $00        ; $07 Shadow
         db $10, $08, $FF, $00        ; $08 Strago
         db $10, $09, $FF, $00        ; $09 Gau
         db $10, $0A, $FF, $00        ; $0A Edgar & Sabin
         db $10, $0B, $FF, $00        ; $0B Coin Song
         db $10, $0C, $FF, $00        ; $0C Cyan
         db $10, $0D, $FF, $00        ; $0D Locke
         db $10, $0E, $FF, $00        ; $0E Forever Rachel
         db $10, $0F, $FF, $00        ; $0F Relm

; Song indexes which need the current song to be paused then resumed
C506F9:  db $24          ; Battle, from C5/062B
         db $38          ; Nighty Night
         db $14          ; Decisive battle
         db $33          ; Fierce battle
         db $FF          ; Silence?

; Jump table for SPC codes $10-$17
C506FE:  dw C50180       ; $10 Load Song         
         dw C50180       ; $11 Load Song (pause current)
         dw C50171       ; $12 Exit
         dw C50171       ; $13 Exit
         dw C50180       ; $14 Load Song (alternative start)
         dw C50180       ; $15 Load Song (alternative start and pause current)
         dw C50171       ; $16 Exit
         dw C50171       ; $17 Exit


