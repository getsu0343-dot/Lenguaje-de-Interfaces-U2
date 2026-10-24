; Materia: Lenguajes de Interfaz
; Alumno: Alexis Serrano Salomon
; Horario: 10:00 - 11:00
; Profesor: José Luis Medina Jiménez
; Práctica 2 : Captura y despliegue de mensajes
; Descripción: Voy a Capturar y mostrar el nombre del usuario en pantalla y contar cuantos caracteres usó 

INCLUDE Irvine32.inc

.data
mensajeEntrada BYTE "Escribe tu nombre: ", 0
mensajeLongitud BYTE "Caracteres capturados: ", 0

nombre BYTE 30 DUP(0)
longitud DWORD ?

.code
main PROC

    ; Muestra el mensaje de entrada
    mov edx, OFFSET mensajeEntrada
    call WriteString

    ; Capturar el nombre
    mov edx, OFFSET nombre
    mov ecx, SIZEOF nombre
    call ReadString

    ; Guardar la cantidad de caracteres eax guarda automáticamente el número de caracteres tras ReadString
    mov longitud, eax
    call Crlf

    ; Muestra el nombre capturado
    mov edx, OFFSET nombre
    call WriteString
    call Crlf

    ; Muestra mensaje de longitud
    mov edx, OFFSET mensajeLongitud
    call WriteString

    ; Mostrar cantidad de caracteres
    mov eax, longitud
    call WriteDec

    exit

main ENDP
END main