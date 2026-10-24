; Alumno: Alexis Serrano Salomon
; Práctica:8
; Descripción: unas operaciones matematicas basicas (suma, resta, multiplicacion y division) y banderas de acarreo y desbordamiento

INCLUDE Irvine32.inc

.code
main PROC
  ;1: OPERACIONES: ADD Y SUB
  mov eax, 50
  mov ebx, 20

  add eax, ebx ; sumamos
  sub eax, 15  ; a los 70 que traemos le restamos 15

  nop ; pausa para checar los registros en el depurador


  ;2: CF: ACARREO EN UNA SUMA SIN SIGNO 
  mov eax, 0
  mov al, 255  ; le metemos 255 que es el limite maximo de 8 bits
  add al, 1    ; le sumamos 1 pa pasarnos de la raya y forzar el acarreo para que salte cf

  nop 


  ; 3: OF: CONDICION DE DESBORDAMIENTO 
  mov eax, 0
  mov al, 127  ; 127 es el limite maximo positivo en 8 bits con signo
  add al, 1    ; al sumarle 1 truena el limite y prende la bandera de desbordamiento (OF)

  nop


  ;4: MUL: MULTIPLICACION DE VALORES DENTRO DE 32 BITS 
  mov eax, 25
  mov ebx, 3

  mul ebx ; multiplicamos 25 x 3, como cabe bien, el resultado se queda en eax

  nop


  ;5: MUL: PRODUCTO QUE NECESITA MAS DE 32 BITS 
   mov eax, 65537
   mov ebx, 65537

   mul ebx ; al multiplicar esto el resultado no cabe en un solo registro, asi que el edx entra para guardar la parte alta

   nop


   ; 6: mul: multiplicacion con signo
   mov eax, -5

   ; usamos imul porque tenemos un signo negativo, multiplicamos el -5 del eax por 3
   imul eax, eax, 3 

   nop


   ; 7: DIV: division sin signo 
   mov eax, 125 ; este es el dividendo
   mov edx, 0   ; limpiamos el edx a fuerzas porque la division agarra el edx y el eax juntos
   mov ebx, 12  ; este es el divisor

   div ebx      ; dividimos 125 entre 12. el cociente queda en eax y lo que sobra en edx

  nop


  ;8: IDIV: DIVISION CON SIGNOS
  mov eax, -125

  ; convert double to quad: esto agarra el signo negativo del eax y lo extiende al edx pa dejar todo listo
  cdq 

  mov ebx, 12

  idiv ebx ; division con signo, igualito: cociente al eax y residuo al edx

  nop
  exit
main ENDP 

END main