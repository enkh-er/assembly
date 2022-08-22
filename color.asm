
; You may customize this and other start-up templates; 
; The location of this template is c:\emu8086\inc\0_com_template.txt

macro1 macro gorim
mov al, gorim
mov ah, 0
int 10h   
endm      

macro2 macro x,y,color
mov AH ,0Dh
INT 10h
cmp AL,color
je notChange:

mov cx,x
mov dx,y 
mov al, color
mov ah, 0ch 
int 10h ; 
 
notChange:  
endm      
 

org 100h

macro1 13h
macro2 50,50,0111b

ret




