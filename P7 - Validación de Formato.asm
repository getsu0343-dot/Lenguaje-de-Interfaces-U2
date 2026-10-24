; Alumno: Alexis Serrano Salomon
; Práctica: 7
; Descripción: validamos que una cadena tenga el formato correcto 

INCLUDE Irvine32.inc

.data
    cadena BYTE "TEC-67", 0
    MsgValido BYTE "Formato valido", 0
    msgInvalido BYTE "Formato Invalido", 0

.code
main PROC
    ; metemos la direccion de la cadena al esi para ir leyendo letra por letra
    mov esi, OFFSET cadena
    mov ecx, 0 ; inicializamos el contador en cero
    
validarLetras:
    ;el caracter actual al al
    mov al, [esi]

    ; checamos si esta antes de la 'A' en la tabla ASCII
    cmp al, "A"
    jb invalido ; jb  si es menor, no es mayuscula y mal

    ; checamos si se pasa de la 'Z'
    cmp al, "Z"
    ja invalido ; ja si se pasa, tampoco es mayuscula y mal

    ; avanzamos al siguiente caracter y le sumamos 1 al contador
    inc esi
    inc ecx

    ; checamos si ya revisamos las 3 primeras letras
    cmp ecx, 3
    jb validarLetras ; si llevamos menos de 3, nos regresamos a checar la siguiente

    ; Validar el guion o lo que sea que ingresemos
    mov al, [esi]
    cmp al, "-"
    jne invalido ; jne si no es un guion, lo mandamos a invalido

    ; avanzamos el esi para brincarnos el guion y reiniciamos el contador a cero
    inc esi
    mov ecx, 0

validarNumeros:
    ;  lo que sigue
    mov al, [esi]

    ; checamos que no sea menor a '0'
    cmp al, "0"
    jb invalido

    ; checamos que no sea mayor a '9'
    cmp al, "9"
    ja invalido

    ; avanzamos y subimos el contador
    inc esi
    inc ecx

    ; aqui checa si ya van 8 numeros 
    cmp ecx, 8
    jb validarNumeros

    ; Verificar que termine la cadena 
    cmp BYTE PTR [esi], 0
    jne invalido

valido:
    ; si paso todas las demandas, es valido
    mov edx, OFFSET MsgValido
    call WriteString
    call Crlf
    jmp fin

invalido:
    ; etiqueta para errores
    mov edx, OFFSET msgInvalido
    call WriteString
    call Crlf

fin:
    exit

main ENDP
END main