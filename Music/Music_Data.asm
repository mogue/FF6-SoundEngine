
; Music and Instruments
;  org $C53C5E

; Number of songs
Nr_of_Songs: db $55

; Data: Pointers to Instrument BRR's
;  org $C53C5F
Instrument_BRR_Pointers:
 dl BRR_Sample_00
 dl BRR_Sample_01
 dl BRR_Sample_02
 dl BRR_Sample_03
 dl BRR_Sample_04
 dl BRR_Sample_05
 dl BRR_Sample_06
 dl BRR_Sample_07
 dl BRR_Sample_08
 dl BRR_Sample_09
 dl BRR_Sample_0A
 dl BRR_Sample_0B
 dl BRR_Sample_0C
 dl BRR_Sample_0D
 dl BRR_Sample_0E
 dl BRR_Sample_0F
 dl BRR_Sample_10
 dl BRR_Sample_11
 dl BRR_Sample_12
 dl BRR_Sample_13
 dl BRR_Sample_14
 dl BRR_Sample_15
 dl BRR_Sample_16
 dl BRR_Sample_17
 dl BRR_Sample_18
 dl BRR_Sample_19
 dl BRR_Sample_1A
 dl BRR_Sample_1B
 dl BRR_Sample_1C
 dl BRR_Sample_1D
 dl BRR_Sample_1E
 dl BRR_Sample_1F
 dl BRR_Sample_20
 dl BRR_Sample_21
 dl BRR_Sample_22
 dl BRR_Sample_23
 dl BRR_Sample_24
 dl BRR_Sample_25
 dl BRR_Sample_26
 dl BRR_Sample_27
 dl BRR_Sample_28
 dl BRR_Sample_29
 dl BRR_Sample_2A
 dl BRR_Sample_2B
 dl BRR_Sample_2C
 dl BRR_Sample_2D
 dl BRR_Sample_2E
 dl BRR_Sample_2F
 dl BRR_Sample_30
 dl BRR_Sample_31
 dl BRR_Sample_32
 dl BRR_Sample_33
 dl BRR_Sample_34
 dl BRR_Sample_35
 dl BRR_Sample_36
 dl BRR_Sample_37
 dl BRR_Sample_38
 dl BRR_Sample_39
 dl BRR_Sample_3A
 dl BRR_Sample_3B
 dl BRR_Sample_3C
 dl BRR_Sample_3D
 dl BRR_Sample_3E

; Loop start info for samples, constants to be added to wave table pointers
;  org $C53D1C:
Instrument_Loop_Start_Data:
incsrc Instruments/Instruments_LoopStartPositions.asm

; Wave rate multiplying data for samples
;  org $C53D9A:  
Instrument_Wave_Rate_Data:
incsrc Instruments/Instruments_WaveRate.asm  

; ADSR data for samples
;  org $C53E18: 
Instrument_ADSR_Data:
incsrc Instruments/Instruments_ADSR.asm 

; Pointers to SPC's
;  org $C53E96
Song_Data_Pointers:
dl Song_Data_00        ; $00 - Silence
dl Song_Data_01        ; $01 - Prelude
dl Song_Data_02        ; $02 - Opening Theme #1 
dl Song_Data_03        ; $03 - Opening Theme #2
dl Song_Data_04        ; $04 - Opening Theme #3
dl Song_Data_05        ; $05 - Awakening
dl Song_Data_06        ; $06 - Terra
dl Song_Data_07        ; $07 - Shadow
dl Song_Data_08        ; $08 - Strago
dl Song_Data_09        ; $09 - Gau
dl Song_Data_0A        ; $0A - Edgar and Sabin
dl Song_Data_0B        ; $0B - Coin Song
dl Song_Data_0C        ; $0C - Cyan
dl Song_Data_0D        ; $0D - Locke
dl Song_Data_0E        ; $0E - Forever Rachel
dl Song_Data_0F        ; $0F - Relm
dl Song_Data_10        ; $10 - Setzer
dl Song_Data_11        ; $11 - Epitaph
dl Song_Data_12        ; $12 - Celes
dl Song_Data_13        ; $13 - Techno de Chocobo
dl Song_Data_14        ; $14 - The Decisive Battle
dl Song_Data_15        ; $15 - Johnny C. Bad
dl Song_Data_16        ; $16 - Kefka
dl Song_Data_17        ; $17 - The Mines of Narshe
dl Song_Data_18        ; $18 - The Phantom Forest
dl Song_Data_19        ; $19 - Wild West
dl Song_Data_1A        ; $1A - Save Them!
dl Song_Data_1B        ; $1B - The Empire 'Gestahl'
dl Song_Data_1C        ; $1C - Troops March On
dl Song_Data_1D        ; $1D - Under Martial Law
dl Song_Data_1E        ; $1E - (Water Flowing)
dl Song_Data_1F        ; $1F - Metamorphosis
dl Song_Data_20        ; $20 - Phantom Train
dl Song_Data_21        ; $21 - Another World of Beasts
dl Song_Data_22        ; $22 - Grand Finale #2
dl Song_Data_23        ; $23 - Mt. Koltz
dl Song_Data_24        ; $24 - Battle Theme
dl Song_Data_25        ; $25 - (Fanfare, slow)
dl Song_Data_26        ; $26 - The Wedding #1
dl Song_Data_27        ; $27 - Aria de Mezzo Carattere
dl Song_Data_28        ; $28 - The Serpent Trench
dl Song_Data_29        ; $29 - Slam Shuffle
dl Song_Data_2A        ; $2A - Kids Run Through the City Corner
dl Song_Data_2B        ; $2B - ?? [Crazy Old Man's House]
dl Song_Data_2C        ; $2C - Grand Finale #1
dl Song_Data_2D        ; $2D - Gogo
dl Song_Data_2E        ; $2E - Returners
dl Song_Data_2F        ; $2F - Fanfare
dl Song_Data_30        ; $30 - Umaro
dl Song_Data_31        ; $31 - Mog
dl Song_Data_32        ; $32 - The Unforgiven
dl Song_Data_33        ; $33 - The Fierce Battle
dl Song_Data_34        ; $34 - The Day After
dl Song_Data_35        ; $35 - Blackjack
dl Song_Data_36        ; $36 - Catastrophe
dl Song_Data_37        ; $37 - The Magic House
dl Song_Data_38        ; $38 - (Nighty Night)
dl Song_Data_39        ; $39 - (Wind)
dl Song_Data_3A        ; $3A - (Waves)
dl Song_Data_3B        ; $3B - Dancing Mad #1
dl Song_Data_3C        ; $3C - (Phantom Train Stopping)
dl Song_Data_3D        ; $3D - Spinach Rag
dl Song_Data_3E        ; $3E - Rest in Peace
dl Song_Data_3F        ; $3F - (Chocobos Running)
dl Song_Data_40        ; $40 - (Walking out of Zozo)
dl Song_Data_41        ; $41 - Overture #1
dl Song_Data_42        ; $42 - Overture #2
dl Song_Data_43        ; $43 - Overture #3
dl Song_Data_44        ; $44 - The Wedding #2
dl Song_Data_45        ; $45 - The Wedding #3
dl Song_Data_46        ; $46 - The Wedding #4
dl Song_Data_47        ; $47 - Devil's Lab
dl Song_Data_48        ; $48 - (Esper Attack)
dl Song_Data_49        ; $49 - (Cranes)
dl Song_Data_4A        ; $4A - (Burning House)
dl Song_Data_4B        ; $4B - New Continent
dl Song_Data_4C        ; $4C - Searching for Friends
dl Song_Data_4D        ; $4D - Fanatics
dl Song_Data_4E        ; $4E - Last Dungeon
dl Song_Data_4F        ; $4F - Dark World
dl Song_Data_50        ; $50 - Dancing Mad #3
dl Song_Data_51        ; $51 - ???
dl Song_Data_52        ; $52 - Dancing Mad #2
dl Song_Data_53        ; $53 - Ending Theme #1
dl Song_Data_54        ; $54 - Ending Theme #2 

; Table of sample indexes for each song
;  org $C53F95
Instruments_for_each_Song:
incbin Songs/Song_00_Inst.bin
incbin Songs/Song_01_Inst.bin
incbin Songs/Song_02_Inst.bin
incbin Songs/Song_03_Inst.bin
incbin Songs/Song_04_Inst.bin
incbin Songs/Song_05_Inst.bin
incbin Songs/Song_06_Inst.bin
incbin Songs/Song_07_Inst.bin
incbin Songs/Song_08_Inst.bin
incbin Songs/Song_09_Inst.bin
incbin Songs/Song_0A_Inst.bin
incbin Songs/Song_0B_Inst.bin
incbin Songs/Song_0C_Inst.bin
incbin Songs/Song_0D_Inst.bin
incbin Songs/Song_0E_Inst.bin
incbin Songs/Song_0F_Inst.bin
incbin Songs/Song_10_Inst.bin
incbin Songs/Song_11_Inst.bin
incbin Songs/Song_12_Inst.bin
incbin Songs/Song_13_Inst.bin
incbin Songs/Song_14_Inst.bin
incbin Songs/Song_15_Inst.bin
incbin Songs/Song_16_Inst.bin
incbin Songs/Song_17_Inst.bin
incbin Songs/Song_18_Inst.bin
incbin Songs/Song_19_Inst.bin
incbin Songs/Song_1A_Inst.bin
incbin Songs/Song_1B_Inst.bin
incbin Songs/Song_1C_Inst.bin
incbin Songs/Song_1D_Inst.bin
incbin Songs/Song_1E_Inst.bin
incbin Songs/Song_1F_Inst.bin
incbin Songs/Song_20_Inst.bin
incbin Songs/Song_21_Inst.bin
incbin Songs/Song_22_Inst.bin
incbin Songs/Song_23_Inst.bin
incbin Songs/Song_24_Inst.bin
incbin Songs/Song_25_Inst.bin
incbin Songs/Song_26_Inst.bin
incbin Songs/Song_27_Inst.bin
incbin Songs/Song_28_Inst.bin
incbin Songs/Song_29_Inst.bin
incbin Songs/Song_2A_Inst.bin
incbin Songs/Song_2B_Inst.bin
incbin Songs/Song_2C_Inst.bin
incbin Songs/Song_2D_Inst.bin
incbin Songs/Song_2E_Inst.bin
incbin Songs/Song_2F_Inst.bin
incbin Songs/Song_30_Inst.bin
incbin Songs/Song_31_Inst.bin
incbin Songs/Song_32_Inst.bin
incbin Songs/Song_33_Inst.bin
incbin Songs/Song_34_Inst.bin
incbin Songs/Song_35_Inst.bin
incbin Songs/Song_36_Inst.bin
incbin Songs/Song_37_Inst.bin
incbin Songs/Song_38_Inst.bin
incbin Songs/Song_39_Inst.bin
incbin Songs/Song_3A_Inst.bin
incbin Songs/Song_3B_Inst.bin
incbin Songs/Song_3C_Inst.bin
incbin Songs/Song_3D_Inst.bin
incbin Songs/Song_3E_Inst.bin
incbin Songs/Song_3F_Inst.bin
incbin Songs/Song_40_Inst.bin
incbin Songs/Song_41_Inst.bin
incbin Songs/Song_42_Inst.bin
incbin Songs/Song_43_Inst.bin
incbin Songs/Song_44_Inst.bin
incbin Songs/Song_45_Inst.bin
incbin Songs/Song_46_Inst.bin
incbin Songs/Song_47_Inst.bin
incbin Songs/Song_48_Inst.bin
incbin Songs/Song_49_Inst.bin
incbin Songs/Song_4A_Inst.bin
incbin Songs/Song_4B_Inst.bin
incbin Songs/Song_4C_Inst.bin
incbin Songs/Song_4D_Inst.bin
incbin Songs/Song_4E_Inst.bin
incbin Songs/Song_4F_Inst.bin
incbin Songs/Song_50_Inst.bin
incbin Songs/Song_51_Inst.bin
incbin Songs/Song_52_Inst.bin
incbin Songs/Song_53_Inst.bin
incbin Songs/Song_54_Inst.bin   

; BRR samples
check bankcross off
BRR_Sample_00: incbin Instruments/BRRs/BRR_Sample_00.bin
BRR_Sample_01: incbin Instruments/BRRs/BRR_Sample_01.bin
BRR_Sample_02: incbin Instruments/BRRs/BRR_Sample_02.bin
BRR_Sample_03: incbin Instruments/BRRs/BRR_Sample_03.bin
BRR_Sample_04: incbin Instruments/BRRs/BRR_Sample_04.bin
BRR_Sample_05: incbin Instruments/BRRs/BRR_Sample_05.bin
BRR_Sample_06: incbin Instruments/BRRs/BRR_Sample_06.bin
BRR_Sample_07: incbin Instruments/BRRs/BRR_Sample_07.bin
BRR_Sample_08: incbin Instruments/BRRs/BRR_Sample_08.bin
BRR_Sample_09: incbin Instruments/BRRs/BRR_Sample_09.bin
BRR_Sample_0A: incbin Instruments/BRRs/BRR_Sample_0A.bin
BRR_Sample_0B: incbin Instruments/BRRs/BRR_Sample_0B.bin
BRR_Sample_0C: incbin Instruments/BRRs/BRR_Sample_0C.bin
BRR_Sample_0D: incbin Instruments/BRRs/BRR_Sample_0D.bin
BRR_Sample_0E: incbin Instruments/BRRs/BRR_Sample_0E.bin
BRR_Sample_0F: incbin Instruments/BRRs/BRR_Sample_0F.bin
BRR_Sample_10: incbin Instruments/BRRs/BRR_Sample_10.bin
BRR_Sample_11: incbin Instruments/BRRs/BRR_Sample_11.bin
BRR_Sample_12: incbin Instruments/BRRs/BRR_Sample_12.bin
BRR_Sample_13: incbin Instruments/BRRs/BRR_Sample_13.bin
BRR_Sample_14: incbin Instruments/BRRs/BRR_Sample_14.bin
BRR_Sample_15: incbin Instruments/BRRs/BRR_Sample_15.bin
BRR_Sample_16: incbin Instruments/BRRs/BRR_Sample_16.bin
BRR_Sample_17: incbin Instruments/BRRs/BRR_Sample_17.bin
BRR_Sample_18: incbin Instruments/BRRs/BRR_Sample_18.bin
BRR_Sample_19: incbin Instruments/BRRs/BRR_Sample_19.bin
BRR_Sample_1A: incbin Instruments/BRRs/BRR_Sample_1A.bin
BRR_Sample_1B: incbin Instruments/BRRs/BRR_Sample_1B.bin
BRR_Sample_1C: incbin Instruments/BRRs/BRR_Sample_1C.bin
BRR_Sample_1D: incbin Instruments/BRRs/BRR_Sample_1D.bin
BRR_Sample_1E: incbin Instruments/BRRs/BRR_Sample_1E.bin
BRR_Sample_1F: incbin Instruments/BRRs/BRR_Sample_1F.bin
BRR_Sample_20: incbin Instruments/BRRs/BRR_Sample_20.bin
BRR_Sample_21: incbin Instruments/BRRs/BRR_Sample_21.bin
BRR_Sample_22: incbin Instruments/BRRs/BRR_Sample_22.bin
BRR_Sample_23: incbin Instruments/BRRs/BRR_Sample_23.bin
BRR_Sample_24: incbin Instruments/BRRs/BRR_Sample_24.bin
BRR_Sample_25: incbin Instruments/BRRs/BRR_Sample_25.bin
BRR_Sample_26: incbin Instruments/BRRs/BRR_Sample_26.bin
BRR_Sample_27: incbin Instruments/BRRs/BRR_Sample_27.bin
BRR_Sample_28: incbin Instruments/BRRs/BRR_Sample_28.bin
BRR_Sample_29: incbin Instruments/BRRs/BRR_Sample_29.bin
BRR_Sample_2A: incbin Instruments/BRRs/BRR_Sample_2A.bin
BRR_Sample_2B: incbin Instruments/BRRs/BRR_Sample_2B.bin
BRR_Sample_2C: incbin Instruments/BRRs/BRR_Sample_2C.bin
BRR_Sample_2D: incbin Instruments/BRRs/BRR_Sample_2D.bin
BRR_Sample_2E: incbin Instruments/BRRs/BRR_Sample_2E.bin
BRR_Sample_2F: incbin Instruments/BRRs/BRR_Sample_2F.bin
BRR_Sample_30: incbin Instruments/BRRs/BRR_Sample_30.bin
BRR_Sample_31: incbin Instruments/BRRs/BRR_Sample_31.bin
BRR_Sample_32: incbin Instruments/BRRs/BRR_Sample_32.bin
BRR_Sample_33: incbin Instruments/BRRs/BRR_Sample_33.bin
BRR_Sample_34: incbin Instruments/BRRs/BRR_Sample_34.bin
BRR_Sample_35: incbin Instruments/BRRs/BRR_Sample_35.bin
BRR_Sample_36: incbin Instruments/BRRs/BRR_Sample_36.bin
BRR_Sample_37: incbin Instruments/BRRs/BRR_Sample_37.bin
BRR_Sample_38: incbin Instruments/BRRs/BRR_Sample_38.bin
BRR_Sample_39: incbin Instruments/BRRs/BRR_Sample_39.bin
BRR_Sample_3A: incbin Instruments/BRRs/BRR_Sample_3A.bin
BRR_Sample_3B: incbin Instruments/BRRs/BRR_Sample_3B.bin
BRR_Sample_3C: incbin Instruments/BRRs/BRR_Sample_3C.bin
BRR_Sample_3D: incbin Instruments/BRRs/BRR_Sample_3D.bin
BRR_Sample_3E: incbin Instruments/BRRs/BRR_Sample_3E.bin

 ; Songs Data
Song_Data_51:
Song_Data_00: incbin Songs/Song_00_Data.bin   ; $00 (Silence)
Song_Data_01: incbin Songs/Song_01_Data.bin   ; $01 The Prelude
Song_Data_05: incbin Songs/Song_05_Data.bin   ; $05 Awakening
Song_Data_06: incbin Songs/Song_06_Data.bin   ; $06 Terra
Song_Data_07: incbin Songs/Song_07_Data.bin   ; $07 Shadow
Song_Data_08: incbin Songs/Song_08_Data.bin   ; $08 Strago
Song_Data_09: incbin Songs/Song_09_Data.bin   ; $09 Gau
Song_Data_0A: incbin Songs/Song_0A_Data.bin   ; $0A Edgar & Sabin
Song_Data_0B: incbin Songs/Song_0B_Data.bin   ; $0B Coin Song
Song_Data_0C: incbin Songs/Song_0C_Data.bin   ; $0C Cyan
Song_Data_0D: incbin Songs/Song_0D_Data.bin   ; $0D Locke
Song_Data_0E: incbin Songs/Song_0E_Data.bin   ; $0E Forever Rachel
Song_Data_0F: incbin Songs/Song_0F_Data.bin   ; $0F Relm
Song_Data_10: incbin Songs/Song_10_Data.bin   ; $10 Setzer
Song_Data_11: incbin Songs/Song_11_Data.bin   ; $11 Epitaph
Song_Data_12: incbin Songs/Song_12_Data.bin   ; $12 Celes
Song_Data_13: incbin Songs/Song_13_Data.bin   ; $13 Techno de Chocobo
              incbin Songs/Unused_Song_00_Data.bin ; Unused Song (Omen, part 1, second half)
Song_Data_14: incbin Songs/Song_14_Data.bin   ; $14 The Decisive Battle
Song_Data_15: incbin Songs/Song_15_Data.bin   ; $15 Johnny C Bad
Song_Data_03: incbin Songs/Song_03_Data.bin   ; $03 Opening Theme #2
Song_Data_16: incbin Songs/Song_16_Data.bin   ; $16 Kefka
Song_Data_17: incbin Songs/Song_17_Data.bin   ; $17 The Mines of Narshe
Song_Data_18: incbin Songs/Song_18_Data.bin   ; $18 The Phantom Forest
Song_Data_04: incbin Songs/Song_04_Data.bin   ; $04 Opening Theme #3
Song_Data_19: incbin Songs/Song_19_Data.bin   ; $19 Wild West
Song_Data_1A: incbin Songs/Song_1A_Data.bin   ; $1A Save Them!
Song_Data_1B: incbin Songs/Song_1B_Data.bin   ; $1B The Empire 'Gestahl'
Song_Data_1C: incbin Songs/Song_1C_Data.bin   ; $1C Troops March On
Song_Data_1D: incbin Songs/Song_1D_Data.bin   ; $1D Under Martial Law
Song_Data_1E: incbin Songs/Song_1E_Data.bin   ; $1E (Water Flowing)
Song_Data_1F: incbin Songs/Song_1F_Data.bin   ; $1F Metamorphosis
Song_Data_20: incbin Songs/Song_20_Data.bin   ; $20 Phantom Train
Song_Data_21: incbin Songs/Song_21_Data.bin   ; $21 Another World of Beasts
Song_Data_22: incbin Songs/Song_22_Data.bin   ; $22 Grand Finale #2
Song_Data_23: incbin Songs/Song_23_Data.bin   ; $23 Mt. Koltz
Song_Data_24: incbin Songs/Song_24_Data.bin   ; $24 Battle Theme
Song_Data_25: incbin Songs/Song_25_Data.bin   ; $25 (Fanfare, slow)
Song_Data_26: incbin Songs/Song_26_Data.bin   ; $26 The Wedding #1
Song_Data_27: incbin Songs/Song_27_Data.bin   ; $27 Aria de Mezzo Carattere
Song_Data_2A: incbin Songs/Song_2A_Data.bin   ; $2A Kids Run Through the City Corner
Song_Data_2D: incbin Songs/Song_2D_Data.bin   ; $2D Gogo
Song_Data_2E: incbin Songs/Song_2E_Data.bin   ; $2E Returners
Song_Data_2F: incbin Songs/Song_2F_Data.bin   ; $2F Fanfare
Song_Data_30: incbin Songs/Song_30_Data.bin   ; $30 Umaro
Song_Data_31: incbin Songs/Song_31_Data.bin   ; $31 Mog
Song_Data_32: incbin Songs/Song_32_Data.bin   ; $32 The Unforgiven
Song_Data_33: incbin Songs/Song_33_Data.bin   ; $33 The Fierce Battle
Song_Data_34: incbin Songs/Song_34_Data.bin   ; $34 The Day After
Song_Data_35: incbin Songs/Song_35_Data.bin   ; $35 Blackjack
Song_Data_36: incbin Songs/Song_36_Data.bin   ; $36 Catastrophe
Song_Data_37: incbin Songs/Song_37_Data.bin   ; $37 The Magic House
Song_Data_38: incbin Songs/Song_38_Data.bin   ; $38 (Nighty Night)
Song_Data_39: incbin Songs/Song_39_Data.bin   ; $39 (Wind)
Song_Data_3A: incbin Songs/Song_3A_Data.bin   ; $3A (Waves)
Song_Data_3B: incbin Songs/Song_3B_Data.bin   ; $3B Dancing Mad #1
Song_Data_3C: incbin Songs/Song_3C_Data.bin   ; $3C (Phantom Train Stopping)
Song_Data_3D: incbin Songs/Song_3D_Data.bin   ; $3D Spinach Rag
Song_Data_3E: incbin Songs/Song_3E_Data.bin   ; $3E Rest in Peace
Song_Data_3F: incbin Songs/Song_3F_Data.bin   ; $3F (Chocobos Running)
Song_Data_40: incbin Songs/Song_40_Data.bin   ; $40 (Walking out of Zozo)
Song_Data_41: incbin Songs/Song_41_Data.bin   ; $41 Overture #1
Song_Data_42: incbin Songs/Song_42_Data.bin   ; $42 Overture #2
Song_Data_43: incbin Songs/Song_43_Data.bin   ; $43 Overture #3
Song_Data_44: incbin Songs/Song_44_Data.bin   ; $44 The Wedding #2
Song_Data_45: incbin Songs/Song_45_Data.bin   ; $45 The Wedding #3
Song_Data_46: incbin Songs/Song_46_Data.bin   ; $46 The Wedding #4
Song_Data_02: incbin Songs/Song_02_Data.bin   ; $02 Opening Theme #1
Song_Data_47: incbin Songs/Song_47_Data.bin   ; $47 Devil's Lab
Song_Data_48: incbin Songs/Song_48_Data.bin   ; $48 (Esper Attack)
Song_Data_49: incbin Songs/Song_49_Data.bin   ; $49 (Cranes)
Song_Data_4A: incbin Songs/Song_4A_Data.bin   ; $4A (Burning House)
Song_Data_2B: incbin Songs/Song_2B_Data.bin   ; $2B ?? [Crazy Old Man's House]
Song_Data_28: incbin Songs/Song_28_Data.bin   ; $28 The Serpent Trench
Song_Data_29: incbin Songs/Song_29_Data.bin   ; $29 Slam Shuffle
Song_Data_2C: incbin Songs/Song_2C_Data.bin   ; $2C Grand Finale #1
Song_Data_4B: incbin Songs/Song_4B_Data.bin   ; $4B New Continent
Song_Data_4C: incbin Songs/Song_4C_Data.bin   ; $4C Searching for Friends
Song_Data_4D: incbin Songs/Song_4D_Data.bin   ; $4D Fanatics
Song_Data_4E: incbin Songs/Song_4E_Data.bin   ; $4E Last Dungeon
Song_Data_4F: incbin Songs/Song_4F_Data.bin   ; $4F Dark World
Song_Data_50: incbin Songs/Song_50_Data.bin   ; $50 Dancing Mad #3
Song_Data_52: incbin Songs/Song_52_Data.bin   ; $52 Dancing Mad #2
Song_Data_53: incbin Songs/Song_53_Data.bin   ; $53 Ending Theme #1
Song_Data_54: incbin Songs/Song_54_Data.bin   ; $54 Ending Theme #2
check bankcross on
