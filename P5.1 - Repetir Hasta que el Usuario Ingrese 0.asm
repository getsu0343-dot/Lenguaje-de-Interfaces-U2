; Alumno: Alexis Serrano Salomon
; Práctica:5.1
; Descripción: le pedimos numeros al usuario y le decimos si son positivos o negativos, acaba cuando le meten un cero 

INCLUDE Irvine32.inc

.data
msgNumero BYTE "Ingresa un numero: ", 0
msgPositivo BYTE "El numero es positivo", 0
msgNegativo BYTE "El numero es negativo", 0
msgSalir BYTE "Programa finalizado", 0

.code
main PROC

ciclo:
    ; le pedimos el numero al usuario
    mov edx, OFFSET msgNumero
    call WriteString
    call ReadInt ; el numero se guarda directo en el eax

    ; checamos el numero contra el 0 
    cmp eax, 0

    je fin       ; je si le metio un cero,final
    jg positivo  ; jg si es mayor a cero salta a positivo
    jl negativo  ; jl si es menor a cero salta a negativo

positivo:
    mov edx, OFFSET msgPositivo
    call WriteString
    call Crlf
    jmp ciclo    ; pedir otro numero 

negativo:
    mov edx, OFFSET msgNegativo
    call WriteString
    call Crlf
    jmp ciclo    ; igual nos regresamos al inicio del ciclo pa seguir iterando

fin:
    ; aqui cae si el salto je se cumplio o sea, si pusieron el cero
    mov edx, OFFSET msgSalir
    call WriteString
    call Crlf

    exit

main ENDP
END main