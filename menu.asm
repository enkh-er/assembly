
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt  
printAscii MACRO  char
     MOV DL, char  
     MOV Ah, 02h   
     INT 21h 
ENDM

;Ogogdson temdegtiin 16tiin toog olno
printHexValue  MACRO  char  
    printAscii 2dh
    mov bl,char 
    xor dx,dx
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
        jmp printHex            ;letter_digt hesgiig algasna
    
    letter_digit:
        sub dl,9             ;dl=dl-9
        or dl,40h
                         ;dl or 40h
    printHex:
        mov ah,2
        int 21h
    loop display_hex  
    printAscii 68h

ENDM   

;Ogogdson temdegtiin 10tiin toog olno
printDecimalValue  MACRO  char  
    printAscii 2dh
    mov al, char 
    aam                                                             
    mov bx,ax   
    cmp AH,0h 
    JE one
    mov cx,3
    jmp display_decimal  
    one:
    mov cx,1    
    display_decimal: 
        CMP CX, 1               
        JE lastNumber
        cmp bh,9
        JNBE letter_to_decimal    
        or bh,30h
        mov dl,bh
        mov cx,2   
        jmp printDec           
    letter_to_decimal:  
        mov al,bh
        aam        
        or ah,30h
        mov dl,ah     
        mov bh,al
        jmp printDec   
    lastNumber:    
        or bl,30h
        mov dl,bl   
        jmp printDec     
    printDec:
        mov ah,2
        int 21h        
    loop display_decimal      
    printAscii 64h

ENDM
                     
;Ogogdson temdegtiin 2tiin toog olno    
printBinaryValue  MACRO  char 
    printAscii 2dh
    mov bl,char    
    mov dx, 0h
    mov cl,8
    findbinary:
        shl bl,1  
        JC printOne 
        printAscii 30h
        jmp nextNum
        printOne: 
            printAscii 31h 
        nextNum:
    loop findbinary 
    printAscii 62h

ENDM

printMenu macro menu,bagana, mor,len
    mov al, 1
	mov bh, 0
	mov bl, 00111011b
	mov cx,  len 
	mov dl, bagana
	mov dh, mor
	push cs
	pop es
	mov bp, offset menu
	mov ah, 13h
	int 10h
endm


org 100h
.data

bin db "BINARY"
deci db "DECIMAL"
hex db "HEXADECIMAL"   
value db "Enter ascii code: $"
n_line DB 0AH,0DH,"$"     
ascii db 0

.code
  
printMenu bin,0,0,6
printMenu deci, 7,0,7
printMenu hex,15,0,11   

mov ah, 09                               ;shine mornoos ehlvvlne
mov dx, offset n_line
int 21h     
          
mov  ax, 0     ; START MOUSE.
int  33h    
mov ax, 1
int 33h

inputAscii:   
    mov dx, offset value 
    mov ah, 9
    int 21h
      
    mov ah,01h          ; garaas ascii temdegt unshina
    int 21h  
    mov ascii, al   
    
    cmp al, 0Dh
    je cancel                   
     
checkSelectMenu:

    mov ax,3
    int 33h     
    test bx,1
    jz checkSelectMenu 
    cmp dx, 5
    jg checkSelectMenu
    cmp cx,00C9h
    jg checkSelectMenu
    cmp cx,7bh
    jg selectHex
    cmp cx, 06Bh
    jg checkSelectMenu
    cmp cx, 03ah
    jg selectDec
    cmp cx, 02bh
    jg checkSelectMenu
    jmp selectBin
    
    selectHex:
        printHexValue ascii       
        jmp exit  
    
    selectDec:
        printDecimalValue ascii                       
        jmp exit
    
    selectBin:
        printBinaryValue ascii                       
        jmp exit
                        
exit:   
mov dx,13
mov ah, 09                               ;shine mornoos ehlvvlne
mov dx, offset n_line
int 21h 
jmp inputAscii    

cancel:
ret
                     

