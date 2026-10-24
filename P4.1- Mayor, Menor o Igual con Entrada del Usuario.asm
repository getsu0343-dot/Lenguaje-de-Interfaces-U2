; Alumno: Alexis Serrano Salomon
; Práctica: 4.1 comparaciones
; Descripción: pedimos dos numeros al usuario los comparamos y vemos cual es el mayor, el menor o si son iguales 

INCLUDE Irvine32.inc

.data
msgNum1 BYTE "Ingresa el primer numero: ", 0
msgNum2 BYTE "Ingresa el segundo numero: ", 0

msgMayor BYTE "El primer numero es mayor", 0
msgMenor BYTE "El primer numero es menor", 0
msgIguales BYTE "Los numeros son iguales", 0

num1 DWORD ?
num2 DWORD ?

.code
main PROC

    ; pedimos el primer numero al usuario
    mov edx, OFFSET msgNum1
    call WriteString
    call ReadInt
    mov num1, eax

    ; ahora pedimos el segundo numero
    mov edx, OFFSET msgNum2
    call WriteString
    call ReadInt
    mov num2, eax

    ; muevo los numeros a los registros pa compararlos
    mov eax, num1
    mov ebx, num2

    cmp eax, ebx

    ; hacemos los brincos dependiendo del resultado de cmp
    jg mayor   ; jg brinca si el primero es mayor
    jl menor   ; jl brinca si el primero es menor
    je iguales ; je brinca si son el mismo numero

iguales:
    mov edx, OFFSET msgIguales
    call WriteString
    jmp fin    ; brincamos al final pa salir

mayor:
    mov edx, OFFSET msgMayor
    call WriteString
    jmp fin    ; igual brincamos para que no se siga de largo a imprimir 

menor:
    mov edx, OFFSET msgMenor
    call WriteString
    ; aqui ya no ocupa brinco porque aqui termina la cadena

fin:
    call Crlf
    exit

main ENDP
END main