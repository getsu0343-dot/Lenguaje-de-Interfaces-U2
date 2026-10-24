; Alumno: Alexis Serrano Salomon
; Práctica: 6.1
; Descripción: un simulador de estacionamiento para llevar el conteo de los carros que entran y salen, con un limite de 20 espacios.

INCLUDE Irvine32.inc

.data
    msgMenu BYTE "1. Entrada de carro", 0
    msgSalida BYTE "2. Salida de carro", 0
    msgOcupacion BYTE "Carros estacionados: ", 0
    msgEntrada BYTE "Un carro ha entrado", 0
    msgSalio BYTE "Un carro ha salido", 0
    msgVacio BYTE "El estacionamiento esta vacio", 0
    msgLleno BYTE "ESTACIONAMIENTO LLENO", 0
    msgOpcion BYTE "Seleccione una opcion: ", 0
    msgError BYTE "Opcion no valida", 0

    carros DWORD 0 ; iniciamos el contador en cero porque esta vacio o a eleccion

.code
main PROC

ciclo:
    ; mostramos cuantos carros hay estacionados
    mov edx, OFFSET msgOcupacion
    call WriteString
    mov eax, carros
    call WriteDec
    call Crlf

    ; checamos si ya llegamos al limite de capacidad 
    cmp carros, 20
    je lleno ; si ya esta, lo mandamos a la etiqueta lleno

    ; imprimimos las opciones del menu
    mov edx, OFFSET msgMenu
    call WriteString
    call Crlf

    mov edx, OFFSET msgSalida
    call WriteString
    call Crlf

    ; pedimos que seleccione una opcion
    mov edx, OFFSET msgOpcion
    call WriteString
    call ReadInt ; la opcion seleccionada se guarda en el eax

    ; checamos que boton apreto el usuario
    cmp eax, 1
    je entrada ; si puso 1, brinca a dar entrada

    cmp eax, 2
    je salida ; si puso 2, brinca a dar salida

    ; si puso un numero que nada que ver, le tira error y repite el ciclo
    mov edx, OFFSET msgError
    call WriteString
    call Crlf
    jmp ciclo

entrada:
    ; sumamos un carro al contador
    inc carros

    ; avisamos que ya entro
    mov edx, OFFSET msgEntrada
    call WriteString
    call Crlf
    jmp ciclo ; de regreso al menu principal

salida:
 ;  checamos que haya carros
    cmp carros, 0
    je vacio

    ; si si hay carros, restamos uno
    dec carros

    ; avisamos que ya salio el carro
    mov edx, OFFSET msgSalio
    call WriteString
    call Crlf
    jmp ciclo ; de regreso al menu

vacio:
    ; le avisamos que no hay nada que sacar
    mov edx, OFFSET msgVacio
    call WriteString
    call Crlf
    jmp ciclo

lleno:
    ; si llego a 20, le avisamos 
    mov edx, OFFSET msgLleno
    call WriteString
    call Crlf

    exit

main ENDP
END main