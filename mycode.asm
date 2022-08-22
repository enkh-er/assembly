
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt    

insert macro name
    local next
    mov dx, offset name
    mov ah, 0ah
    int 21h
    jmp next
    name db 30,?,30 dup(' ')   
    next:
    mov bh,0
    mov bl, name[1]
    mov name[bx+2],'$'       
endm

org 100h

; add your code here   
insert name

ret




