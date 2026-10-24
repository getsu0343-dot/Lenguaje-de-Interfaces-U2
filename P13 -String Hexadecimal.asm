; Alumno: Alexis Serrano Salomon
; Práctica: 13
; Descripción: agarramos una cadena de texto que trae un numero en hexadecimal y la convertimos paso a paso a un valor numerico real de 32 bits.

INCLUDE Irvine32.inc

.data
    cadena BYTE "A1B2C3D4", 0 
    numero DWORD 0

.code
main PROC

    
    mov esi, 0 ; lo usamos como indice para ir recorriendo la cadena
    mov ecx, 8 ; le damos 8 vueltas al ciclo porque la cadena tiene 8 caracteres
    mov eax, 0 ; aqui vamos a ir armando el numero final

L1:
    ; recorremos eax 4 bits a la izquierda para hacerle hueco al nuevo digito que va a entrar
    shl eax, 4

    ; jalamos el caracter actual de la cadena al registro bl
    mov bl, cadena[esi]

    ; checamos si el caracter es un numero del '0' al '9' o si es letra
    cmp bl, '9'
    jbe Digito ; jbe si es numero, brinca directo a la etiqueta Digito

    ; si la compu paso para aca es porque es una letra (A-F). Le restamos 7 para ajustar el valor en la tabla ASCII antes de restarle el 0
    sub bl, 7

Digito:
    ; le restamos el valor ASCII del 0 para convertir el caracter de texto a un numero
    sub bl, '0'
; pasamos el valor de bl al ebx rellenando con ceros a la izquierda para que cuadren los tamaños
    movzx ebx, bl
    
 ; le sumamos el digito ya convertido al acumulador eax
    add eax, ebx

  ; avanzamos al siguiente caracter de la cadena
    inc esi

    ; repite el ciclo L1 hasta que el ecx llegue a cero
    loop L1
;uardamos el numero final que armamos en la variable de la memoria
    mov numero, eax

  ; confirmar que el eax trae el A1B2C3D4
    call DumpRegs

    ; mandamos a imprimir el numero en formato hexadecimal
    mov eax, numero
    call WriteHex

    call Crlf

    exit

main ENDP

END main