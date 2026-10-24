; Alumno: Alexis Serrano Salomon
; Práctica: 5 condiciones
; Descripción: hacemos un ciclo que va contando y mostrando los numeros del 1 al 10 en la pantalla y 1 al 100

INCLUDE Irvine32.inc

.code
main PROC
    mov ebx, 1 ; le damos un 1 inicial pa empezar a contar

ciclo:
    cmp ebx, 10 ; checamos si el contador ya paso de 10 

    ; jg si se pasa del 10, 
    jg fin 

    ; lo pasamos al eax porque el writeDec nomas lee e imprime lo que hay ahi
    mov eax, ebx 
    call writeDec ; imprimimos el numero
    call crlf ; slato de linea

    inc ebx ; le sumamos 1 al ebx pa que siga avanzando 

    ; brinco directo de regreso hasta cumplir la condicion
    jmp ciclo 

fin: 
    exit

main ENDP 

END main

