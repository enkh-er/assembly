
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

org 100h

mov al, 13h

mov ah, 0
                                         
int 10h ; set graphics video mode.   

;deed dood hvreeg zurna
mov x, 30
mov y, 40
draw5:
    mov cx,x
    mov dx,y 
    draw6:
        mov al, 0001b
        mov ah, 0ch 
        int 10h ; set pixel.     
        inc cx
        cmp cx, 170
        jne draw6 
    add y,120
    cmp y,160
    je draw5 
    
mov x, 30
mov y, 40
draw7:
    mov cx,x
    mov dx,y 
    draw8:
        mov al, 0001b
        mov ah, 0ch 
        int 10h ; set pixel.     
        inc dx
        cmp dx, 160
        jne draw8 
    add x,140
    cmp x,170
    je draw7  
                 

 mov x, 100
mov y, 70
draw9:
    mov cx,x
    mov dx,y 
    draw10:
        mov al, 0001b
        mov ah, 0ch 
        int 10h ; set pixel.     
        inc cx
        cmp cx, 130
        jne draw10   
    cmp y,65
    jnge firstInc 
    mov ax, y
    mov bl,3
    div bl
    cmp ah,0
    jne exit
    inc x     
    jmp exit 
    
    firstInc:
    cmp y,60
    jnge secondInc
    inc x
    jmp exit
    
    secondInc:
    add x,3   
       
    exit:
    dec y
    cmp y,55
    jne draw9    
             
                            
mov x, 100
mov y, 70   
draw:
    mov cx,x
    mov dx,y 
    draw1:
        mov al, 0001b
        mov ah, 0ch 
        int 10h ; set pixel.     
        inc dx
        cmp dx, 150
        jne draw1     
    inc x
    cmp x,115
    jne draw

mov x, 80
mov y, 90
draw3:
    mov cx,x
    mov dx,y 
    draw4:
        mov al, 0001b
        mov ah, 0ch 
        int 10h ; set pixel.     
        inc cx
        cmp cx, 135
        jne draw4 
    inc y
    cmp y,100
    jne draw3
        
ret 

x dw 0
y dw 0
