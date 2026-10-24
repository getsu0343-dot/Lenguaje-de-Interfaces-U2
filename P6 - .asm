; Alumno: Alexis Serrano Salomon
; Práctica: 6
; Descripción: un sistema que pide un PIN, si te equivocas te va restando intentos y error 3 veces te bloquea el acceso

INCLUDE Irvine32.inc

.data
    msgPIN BYTE "Ingrese eL PIN: ", 0
    msgIntentos BYTE "Intentos restantes: ", 0
    msgError BYTE "PIN incorrecto", 0
    msgAcceso BYTE "ACCESO PERMITIDO", 0
    msgBloqueado BYTE "ACCESO BLOQUEADO", 0

    pinCorrecto = 6767 ; 

.code
main PROC
   mov ebx, 3 ; numero de intentos

intentar:
   ; le pedimos que meta el pin
   mov edx, OFFSET msgPIN 
   call WriteString
   call ReadInt ; el pin que teclea se va directo al eax

   ; checamos si le atino a la contraseña
   cmp eax, pinCorrecto
   
   ;je si le atino, le damos el acceso
   je acceso
   
   ; si la compu pasa a esta linea es porque no le atino
   mov edx, OFFSET msgError
   call WriteString
   call crlf

   ; le quitamos una vida restamos o decrementamos en 1 el contador ebx
   dec ebx

   ;jz si ya fueron 3 intentos bloqueamos acceso
   jz bloqueado

   ; si todavia le quedan intentos, le avisamos cuantas son
   mov edx, OFFSET msgIntentos
   call WriteString

   ; pasamos los intentos restantes al eax pa que el writedec las pueda imprimir en pantalla
   mov eax, ebx
   call WriteDec
   call crlf

   ; que intente de nuevo
   jmp intentar


acceso:
   mov edx, OFFSET msgAcceso
   call WriteString 
   call crlf
   jmp fin ; brincamos al final pa que no se pase al bloque de bloqueado


bloqueado:
   mov edx, OFFSET msgBloqueado
   call WriteString
   call crlf 
   ;no ocupa el jmp fin

fin:
   exit

main ENDP 

END main