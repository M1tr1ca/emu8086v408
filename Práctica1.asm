.model small
.stack 100h
.data
    Op1H DW 3030h
    Op1L DW 3030h
    Op2H DW 5050h
    Op2L DW 5050h
    ResSubH DW 0000h
    ResSubL DW 0000h


.code
Inicio:
 mov ax, @data
 mov ds, ax
 sub ax, ax
 sub bx,bx
 sub cx,cx
 sub dx,dx
 
 
 mov AX, Op1L
 sbb AX, Op2L
 mov ResSubL,AX 
 
 mov BX,Op1H
 sbb BX,Op2H
 mov ResSubH,BX
 
 mov ah, 4Ch
 int 21h 
 end