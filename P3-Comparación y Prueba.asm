
; Alumno: Alexis Serrano Salomon
; Práctica: 3 Comparacion de pruebas
; Descripción: Programa para observar las alteraciones en las banderas de 
; estado ZF, SF, CF, OF


INCLUDE Irvine32.inc

.code
main PROC

   ;1. PRUEBA DE ZERO FLAG ZF
   mov ebx, 01h       ; Cargamos 1 en formato hexadecimal
   cmp ebx, 1         ; Comparamos contra 1 decimal
   call dumpRegs

   mov eax, 1         
   cmp eax, ebx       ; Comparamos registros idénticos
   call dumpRegs 

   mov cl, 0FFh       ; 0FFh es exactamente igual a 11111111b
   cmp cl, cl
   call dumpRegs 


   ;2. PRUEBA DE SIGN FLAG SF
   mov eax, 0
   mov ebx, 0

   mov al, -5         ; Valor negativo
   mov bl, 01h        ; Valor positivo
   cmp al, bl         ; La comparación activa la bandera de signo
   call dumpRegs 


   ;3. PRUEBA DE CARRY FLAG CF
   mov eax, 0
   mov ebx, 0

   mov al, 0FFh       ; 255 decimal límite máximo de 8 bits sin signo
   add al, 1          ; Forzamos el desbordamiento 
   call dumpRegs 


   ;4. PRUEBA DE OVERFLOW FLAG OF
   mov eax, 0
   mov ebx, 0

   mov al, -128       ; Límite máximo negativo de 8 bits con signo
   mov bl, 1
   cmp al, bl         ; Provoca desbordamiento con signo
   call dumpRegs


   ;5. USO DE LA INSTRUCCIÓN TEST
   mov eax, 0
   mov eax, 5         ; 5 en decimal equivale a 00000101b
   test eax, 1        ; Operación AND lógica a nivel de bits
   call dumpRegs 
   
   ; Representación de la operación:
   ;   00000101b (Valor 5)
   ; & 00000001b (Valor 1)
   ;   00000001b (El resultado modifica las banderas)

   mov eax, 0
   mov al, 80h        ; 80h equivale a 10000000b
   test al, al        ; El registro se evalúa a sí mismo
   call dumpRegs

   exit
main ENDP 

END main