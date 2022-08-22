
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

mov ah, 01h
int 21h

mov bl, al
mov ah, 02h
mov dl, 2dh
int 21h

mov dx, 0h
mov cl,8
findbinary:
    shl bl,1  
    JC printOne 
    mov dl, 30h
    jmp exit
    printOne: 
        mov dl, 31h 
    exit:
        mov ah, 02h   
        int 21h
loop findbinary 

mov ah, 02h    
mov dl, 68h
int 21h
    
ret




