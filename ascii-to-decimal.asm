
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h
                          
mov ah,01h          ; garaas ascii temdegt unshina
int 21h
mov bl,al
mov ah,02h
mov dl,2Dh          
int 21h    

mov al, bl 
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
    jmp print           
letter_to_decimal:  
    mov al,bh
    aam        
    or ah,30h
    mov dl,ah     
    mov bh,al
    jmp print   
lastNumber:    
    or bl,30h
    mov dl,bl   
    jmp print     
print:
    mov ah,2
    int 21h
    loop display_decimal

mov ah,02h
mov dl,64h           ; 16tiin 'h' vsgiig hewlene
int 21h
ret              





