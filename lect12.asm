
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt   

org 100h        

.data

readFile DB "\\read.txt",0
handle dw ?        
wirteFile DB "\\write.txt",0
handle1 dw ?
readData db 4000 dup (0)     
writeData db 4000 dup (0) 
filesize dw ? 

.code

mov ah, 3dh                     ;file neene
mov dx, offset readFile 
mov al,2
add dx,2
int 21h 
jc err_exit  
mov handle,ax 
      
mov ah,3fh
mov si,offset handle
mov bx,[si]                     ;move file adress to bx
mov cx,4000                     ;numbers of bytes to read
mov dx,offset readData          ;pointer to read buffer
int 21h 

mov si,offset filesize          ;move si pointer to filesize
mov [si],ax   

                         
;==============
    

mov bx,offset readData   ;move  
mov si,offset filesize
mov cx,[si]  
mov di,2  

startwrite:    
    mov al,[bx]    
    mov writeData[di],al  
    inc di  
    mov writeData[di],2Dh  
    inc di  
    xor dx,dx
    mov y,4
    findFirstHex:
        SHL al, 1                       ; zvvn tiish neg byte shiljvvlne
        RCL DL, 1 
        dec y                          ; carry flag-aar damjuult DL-g 1 byte-aar ergvvlne
    cmp y,0
    jne findFirstHex
    
    mov y,4
    findSecondHex:
        SHL al, 1                         ; zvvn tiish neg byte shiljvvlne
        RCL DH, 1
        dec y                         ; carry flag-aar damjuult DL-g 1 byte-aar ergvvlne
    cmp y,0
    jne findSecondHex
        
    MOV AX, DX 
    MOV y, 2
    
    display_hex:
        CMP y, 2               
        JE firstNumber
        MOV DL, AH
        JMP next
        
        firstNumber:
            MOV DL, AL
        
        next:
            cmp dl,9
            JNBE letter_digit                   ;dl>9
            or dl,30h                          ;dl or 30h
            mov writeData[di],dl  
            inc di                                 ;letter_digt hesgiig algasna  
            jmp nextNum
        
        letter_digit:
            sub dl,9                        ;dl=dl-9
            or dl,40h
            mov writeData[di],dl  
            inc di          
        nextNum:    
            dec y
            cmp y,0
            jne display_hex 
            mov writeData[di],68h  
            inc di   
            mov writeData[di],20h  
            inc di 
    inc bx
    dec cx                       
jnz startwrite               
                                                                                     
;========write to file============                

mov ah, 3ch                        ; CREATE OR TRUNCATE FILE
lea dx, wirteFile                  ; DS:DX -> ASCIZ filename
xor cx, cx                         ; file attributes
int 21h                            ; DOS INTERRUPT
jc err_exit

mov handle1, ax 
                               
lea dx, writeData                  ; ds:dx -> data to write
mov bx, handle1       
MOV ah, 40h
MOV cx, di                         ; Size of Buf 
INT 21h               
       
mov bx, handle                    ; file handle
mov ah, 3Eh                       ; CLOSE FILE
int 21h 
         
mov bx, handle1                   ; file handle
mov ah, 3Eh                        ; CLOSE FILE
int 21h         

err_exit:               
mov ah, 4ch                     ; Exit (AX)
int 21h                 
ret




