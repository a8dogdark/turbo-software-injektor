;    .OPT NO LIST
;
;
;        SAVE #D:ROMRAM.MAC
;
;
;
; INICIALIZAMOS LAS VARIABLES
PT.1 =  $CB
ROM.INICIO = $C000
;
;
ROMRAM.INICIO = $0600
;
;
;    *=  ROMRAM.INICIO
    ORG $0600
ROMINICIO
    LDA NMIEN
    PHA
    LDA #$FF
    STA PORTB
    SEI
    LDA # <ROM.INICIO
    STA PT.1
    LDA # >ROM.INICIO
    STA PT.1+1
    LDY #$00
    STY NMIEN
ROMRAM.LOOP
    LDA (PT.1),Y
    DEC PORTB
    STA (PT.1),Y
    INC PORTB
    INY
    BNE ROMRAM.LOOP
    INC PT.1+1
    BEQ ROMRAM.FIN
    LDA PT.1+1
    CMP #$D0
    BNE ROMRAM.LOOP
    LDA #$D8
    STA PT.1+1
    BNE ROMRAM.LOOP
ROMRAM.FIN
    PLA
    STA NMIEN
    CLI
    RTS
;    *=  INITAD
;    .WORD ROMRAM.INICIO
    INI ROMINICIO
