.model small.
.stack 100h
.data
 Texto DB "Please enter a maximum 8 number: ",13,10,'$'
 Texto1 DB "C1 sign extension:",13,10,'$'
 Texto2 DB "Excess 2^n-1 extension: ",13,10,'$'
 Otralinea db 13,10,'$'
 MaximoMas1 db 9
 ChRead db 0
 Cadena db 9 DUP (0)
 InputNumber db 0      
 ExcessExtension dw 0000h
 C1Extension dw 0000h

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
  mov cl, MaximoMas1
  dec cl
  xor SI, SI
  xor bx, bx
  
  bucle:   
   shl bx, 1
   mov dl, Cadena[SI]
   sub dl, 30h
   add bl, dl
   inc SI
   loop bucle
  
  mov InputNumber, bl 
  
  and bl, 80h
  mov dh, bl
  
  mov dl, InputNumber
  and dl, 7Fh  
  
  mov ExcessExtension, dx
  
  cmp dh, 00h
  je skip
  
  mov dh, 0FFh
 
 skip:
  mov dl, InputNumber
  mov C1Extension, dx
          
  mov ah, 9
  lea dx, Otralinea
  int 21h
  lea dx, Texto2
  int 21h
  
  mov bx,ExcessExtension                 
  mov cx,16 
  mov ah,02h
  
  displayExc:
      xor dl, dl
      shl bx, 1
      adc dl, 30h 
      int 21h
      loop displayExc
      
  mov ah, 9
  lea dx, Otralinea
  int 21h
  lea dx, Texto1
  int 21h
  
  mov bx, C1Extension                 
  mov cx, 16  
  mov ah,02h 
       
  displayC1:
      xor dl, dl
      shl bx, 1
      adc dl, 30h
      int 21h
      loop displayC1
     
  mov ah, 4Ch
  int 21h
END Inicio