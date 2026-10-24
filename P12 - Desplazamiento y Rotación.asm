; Alumno: Alexis Serrano Salomon
; Práctica:12
; Descripción: calamos las instrucciones para recorrer y rotar bits (shl, shr, sar) y vemos como dan la vuelta usando la bandera de acarreo.

INCLUDE Irvine32.inc

.code
main PROC
  ; limpiamos los registros principales para empezar desde cero y que no haya basura
  mov eax, 0
  mov ebx, 0
  mov ecx, 0
  mov edx, 0

  ;1 SHL: DESPLAZAR UNA POSICION A LA IZQUIERDA
  mov al, 10000000b
  shl al, 1 ; recorre los bits a la izquierda. El 1 de la orilla se cae y se va a la bandera de acarreo (CF) y por la derecha entra un 0

  call DumpRegs
  call WriteBin ; imprimimos para ver como se movieron los ceros y unos
  call Crlf


  ; 2 - SHR: DESPLAZAR UNA POSICION A LA DERECHA
  mov al, 00001101b
  shr al, 1 ; recorre a la derecha. Lo que sale se va al CF y por la izquierda entra un 0

  call DumpRegs
  call WriteBin
  call Crlf


  ; 3 - SAR: CONSERVAR EL SIGNO
  mov al, -8
  sar al, 1 ; es como dividir entre 2, pero conserva el bit de signo para que el numero siga siendo negativo

  call DumpRegs
  call WriteBin
  call Crlf


  ;SAR: CON OPERACIONES NO EXACTAS
  mov al, -9
  sar al, 1 ; como el -9 es impar, al dividirlo entre 2 el residuo se va a la bandera de acarreo CF y el resultado se redondea

  call DumpRegs
  call WriteBin
  call Crlf


  ;5 - CONTEO: DESPLAZAR 2 BITS A LA IZQUIERDA
  mov al, 00001111b
  shl al, 2 ; le decimos directo que recorra 2 posiciones de golpe

  call DumpRegs
  call WriteBin
  call Crlf


  ; 6 - DESPLAZAR 2 BITS A LA DERECHA UTILIZANDO CL
  mov al, 00001111b
  mov cl, 2 ; metemos la cantidad de saltos en el registro cl
  shr al, cl

  call DumpRegs
  call WriteBin
  call Crlf


  ;7 - ROR: ROTAR BITS A LA DERECHA 
  mov al, 10000001b
  ror al, 1 

  call DumpRegs
  call WriteBin
  call Crlf


  ;8 - ROL: ROTAR BITS A LA IZQUIERDA
  mov al, 10000001b
  rol al, 1

  call DumpRegs
  call WriteBin
  call Crlf


  ;9 - RCL: ROTAR A LA IZQUIERDA CON ACARREO 
  clc ; limpiamos la bandera de acarreo 
  mov al, 10000001b
  rcl al, 1 

  call DumpRegs
  call WriteBin
  call Crlf


  ;10 - RCR: ROTAR A LA DERECHA CON ACARREO
  clc ; volvemos a limpiar el acarreo
  mov al, 10000001b
  rcr al, 1 

  call DumpRegs
  call WriteBin
  call Crlf

  exit

main ENDP

END main