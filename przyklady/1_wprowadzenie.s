        .data
max:    .word 0         ; max number so far

title:  .asciiz "Wprowadzenie\n"
prompt:	.asciiz "Liczba= "
str:    .asciiz "Wynik= "

;
; Memory Mapped I/O area
;
; Address of CONTROL and DATA registers
;
; Set CONTROL = 1, Set DATA to Unsigned Integer to be output
; Set CONTROL = 2, Set DATA to Signed Integer to be output
; Set CONTROL = 3, Set DATA to Floating Point to be output
; Set CONTROL = 4, Set DATA to address of string to be output
; Set CONTROL = 5, Set DATA+5 to x coordinate, DATA+4 to y coordinate, and DATA to RGB colour to be output
; Set CONTROL = 6, Clears the terminal screen
; Set CONTROL = 7, Clears the graphics screen
; Set CONTROL = 8, read the DATA (either an integer or a floating-point) from the keyboard
; Set CONTROL = 9, read one byte from DATA, no character echo.
;

CONTROL: .word32 0x10000
DATA:    .word32 0x10008

        .text
        lwu r8,DATA(r0)    ; pamiec mapowana
        lwu r9,CONTROL(r0) ; rozkaz - uproszczone

        daddi r11,r0,4     ; typ operacji: wyswietl 
        daddi r1,r0,title  ; adres ciagu
        sd r1,(r8)         ; zapisz dane
        sd r11,(r9)	   ;uruchom rozkaz
 
        daddi r1,r0,prompt ; adres napisu
        sd r1,0(r8)        ; przeslij dane
        sd r11,0(r9)       ; rozkaz

        daddi r1,$zero,8   ; r1=0+8
        sd r1,0(r9)	   ; wyswietl dane 
        ld r1,0(r8)	   ; wczytaj watrosc

        sd r1,max(r0)    ; zapisz wartosc
        daddi r12,r0,1   ; r12=r0+1

loop:   andi r3,r1,1     ; r3= r1 iloczyn bitowy 1
        beqz r3,even     ; skocz gdy wynik 0 (parzysty)
odd:    daddu r2,r1,r1   ; mnozenie 3* jako dodawanie
        dadd r1,r2,r1    ; 
        daddi r1,r1,1    ; r1=r1+1
        j over
even:   dsrl r1,r1,1     ; dzielenie przez 2-> przesuniecie w lewo
over:   sd r1,(r8)       ; zapisz w buforze
        sd r12,(r9)      ; wyswietl wynik
        ld r4,max(r0)    ; wczytaj poprzedni max
        slt r3,r4,r1     ; ustawia r3=1 gdy r4<r1
        beqz r3,skip     ; jezeli 0 wykonaj skok
        sd r1,max(r0)    ; nowe maksimum
skip:   slti r3,r1,2     ; porownanie czy wynik <2
        beqz r3,loop     ; ponownie jezeli nie

        ld r2,max(r0)    ; wczytaj wynik
        daddi r1,r0,str  ; ustaw adres napis: wynik
        sd r1,(r8)       ; ustaw w buforze
        sd r11,(r9)      ; wyswietl
        sd r2,(r8)       ; ustaw wynik
        sd r12,(r9)	 ;wyswietl
        halt
        


