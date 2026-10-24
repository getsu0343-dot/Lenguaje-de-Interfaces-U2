; Alumno: Alexis Serrano Salomon
; Práctica: 4 Saltos
; Descripción: comparamos dos valores y mostramos un mensaje en pantalla dependiendo si son iguales o diferentes xs

INCLUDE Irvine32.inc

.data
msgIguales BYTE "Los valores son iguales", 0
msgDiferentes BYTE "Los valores son diferentes", 0 

.code
main PROC
    ; metemos un un digito para prueba
    mov eax, 10
    mov ebx, 10

     ;los comparamos 
    cmp eax, ebx

    ;si son iguales brinca a la etiqueta iguales
    je iguales

    ; si la compu llego a esta linea es porque no brincó, o sea, son diferentes
    mov edx, OFFSET msgDiferentes
    call WriteString

    ; brincamos al final pa que no se siga de largo e imprima el otro mensaje por error
    jmp fin

iguales: 
    ; aqui cae si el salto je de arriba se cumplio
    mov edx, OFFSET msgIguales
    call WriteString

fin:
    ; etiqueta final para salir 
    call crlf
    exit 
main ENDP 

END main