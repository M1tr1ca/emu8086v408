.model small.
.stack 100h
.data
 Texto DB "Please, input a sentence of a maximum of 90 characters: ",13,10,'$'
 Texto1 DB "The number of capital letters is: ",13,10,'$'
 Texto2 DB "The number of lower-case letters is: ",13,10,'$'
 Texto3 DB "The number of numerical characters is: ",13,10,'$'
 Texto4 DB "The number of gap spaces is: ",13,10,'$'
 Otralinea db 13,10,'$'
 MaximoMas1 db 91
 ChRead db 0
 Cadena db 90 DUP (0)
 CapLet dw 0000h      
 LowLet dw 0000h      
 NumChar dw 0000h      
 GapSpaces dw 0000h 
 len DW 0     
 
.code
 Inicio:
  mov ax, @data
  mov ds, ax  
  
  mov ah, 9
  lea dx, Texto
  int 21h
  
  mov ah, 0Ah
  lea dx, MaximoMas1
  int 21h
           
  xor cx, cx      
  mov cl, ChRead
  xor SI, SI
  xor bx, bx
  
  bucle:
   mov bl, Cadena[SI] 
   
   cmp bl, 20h
   je space   
   
   cmp bl, 30h
   jl continue
   
   cmp bl, 3Ah
   jl num   
              
   cmp bl, 41h
   jl continue
   
   cmp bl, 5Bh
   jl mayusc
              
   cmp bl, 61h
   jl continue
   
   cmp bl, 7Bh
   jl minusc
              
               
   space:
   inc GapSpaces
   jmp continue
   
   num:
   inc NumChar
   jmp continue 
   
   mayusc:
   inc CapLet
   jmp continue
   
   minusc:
   inc LowLet
   jmp continue 
   
   continue:   
   inc SI
   loop bucle
   
printResult macro num, texto 
    
    local digit, print

mov ah, 9h
  lea dx, Otralinea
  int 21h
  lea dx, texto
  int 21h    
    
mov ax,num
mov cx,0Ah
mov len, 0
digit:
    mov dx,00h
    div cx
    push dx
    inc len
    cmp ax,cx
    jae digit   
    push ax
    inc len
    
mov cx,len
mov ah,02h
print:    
    pop dx
    add dl,30h
    int 21h
    loop print 
    
endm
   
printResult CapLet, Texto1   
printResult LowLet, Texto2   
printResult NumChar, Texto3   
printResult GapSpaces, Texto4   
           
  mov ah, 4Ch
  int 21h
END Inicio