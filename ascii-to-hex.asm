
; You may customize this and other start-up templates;
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
                  
mov ah,01h          ; garaas ascii temdegt unshina
int 21h

mov bl,al
mov ah,02h
mov dl,2Dh          ; '-' temdgiin 16tiin utgiig onoono
int 21h

mov dx,0h
mov cx,4
findFirstHex:
SHL BL, 1           ; zvvn tiish neg byte shiljvvlne
RCL DL, 1           ; carry flag-aar damjuult DL-g 1 byte-aar ergvvlne
loop findFirstHex

mov cx,4
findSecondHex:
SHL BL, 1           ; zvvn tiish neg byte shiljvvlne
RCL DH, 1           ; carry flag-aar damjuult DL-g 1 byte-aar ergvvlne
loop findSecondHex

MOV BX, DX 
MOV CX, 2

display_hex:
CMP CX, 2               
JE firstNumber
MOV DL, BH
JMP next

firstNumber:
MOV DL, BL

next:


cmp dl,9
JNBE letter_digit    ;dl>9
or dl,30h            ;dl or 30h
jmp print            ;letter_digt hesgiig algasna

letter_digit:
sub dl,9             ;dl=dl-9
or dl,40h
                     ;dl or 40h
print:
mov ah,2
int 21h
loop display_hex


mov ah,02h
mov dl,68h           ; 16tiin 'h' vsgiig hewlene
int 21h

ret



