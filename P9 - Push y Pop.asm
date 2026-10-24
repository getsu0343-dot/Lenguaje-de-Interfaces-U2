; Alumno: Alexis Serrano Salomon
; Práctica: 9
; Descripción: una prueba para ver como funciona la instruccion push para meter un valor a la pila 

INCLUDE Irvine32.inc
.code
main PROC
    ; le damos un valor de 500 al eax para tener algo que guardar
    mov eax, 500

    ; push empuja o guarda el valor que trae eax directo en la cima de la pila
    push eax 
    
    ; pausita para checar en el depurador como se movio el registro de la pila 
    nop
  
    exit
main ENDP 

END main