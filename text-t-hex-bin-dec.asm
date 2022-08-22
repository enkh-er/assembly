
; Garaas oruulsan temdegten tsuwaanii temdegt bvriin 16, 10, 2tiin tooliin systemrvv horwvvlne   

;Ogogdson 16tiin toonii ascii code-g hewlene
printAscii MACRO  char
     MOV DL, char  
     MOV Ah, 02h   
     INT 21h 
ENDM

;Ogogdson temdegtiin 16tiin toog olno
printHexValue  MACRO  char  
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

org 100h
    mov dx, offset inputText                   
    mov ah, 0ah
    int 21h 
    mov di,2    
    jmp charToDecHexBin
    inputText db 64, 0, 64 dup (0)              ;temdegten tsuwaag hadgalah awah huwisagch
    n_line DB 0AH,0DH,"$"                    ;new line
    
    charToDecHexBin:                         ;temdegten tsuwaan dah temdegt bvriin 10, 16, 2tiin toolloor ilerhiilne    
        cmp inputText[di],13                        ;enter darsan esehiig shalgana
        je exit                                  ;herew enter darsan bol programiig duusgana
        mov ah, 09                               ;shine mornoos ehlvvlne
        mov dx, offset n_line
        int 21h    
        printAscii inputText[di]                    ;ogogdson index deerh temdegtiig hewlene
        printAscii 2Dh                           ;'-' temdegtiig hewlene
        printDecimalValue inputText[di]             ;temdegtiig 10tiin toolliin systemeer ilerhiilen hewlene
        printAscii 20h                           ;' ' temdegtiig hewlene
        printHexValue inputText[di]                 ;temdegtiig 16tiin toolliin systemeer ilerhiilen hewlene
        printAscii 20h                           ;' ' temdegtiig hewlene
        printBinaryValue inputText[di]              ;temdegtiig 2tiin toolliin systemeer ilerhiilen hewlene
        inc di                                   ;di negeer nemegdvvlne
        jmp charToDecHexBin
    
    exit:
ret     
 
