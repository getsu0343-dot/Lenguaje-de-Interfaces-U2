; Alumno: Alexis Serrano Salomon
; Práctica:10
; Descripción: un simulador del progreso de descarga de un archivo, calcula cuantos bytes llevamos, cuantos faltan, saca el porcentaje y agrupa los bytes descargados en bloques de 1024.

INCLUDE Irvine32.inc

.data
    ; DATOS DEL ARCHIVO valores de prueba
    tamArchivo DWORD 100000
    bloques DWORD 125
    tamBloque DWORD 512

    ; RESULTADOS (aqui vamos a guardar las cuentas que hagamos)
    descargados DWORD ?
    pendientes DWORD ?
    porcentaje DWORD ?
    grupos DWORD ?
    residuo DWORD ?

    ; MENSAJES (lo que va a salir en la pantalla)
    msg1 BYTE "Bytes descargados: ", 0
    msg2 BYTE "Bytes pendientes: ", 0
    msg3 BYTE "Porcentaje de avance: ", 0
    msg4 BYTE "Grupos completos de 1024: ", 0
    msg5 BYTE "Residuo del agrupamiento: ", 0
    simbolo BYTE "%", 0

    ; BUFFER (espacio en memoria para guardar el numero ya convertido a texto)
    buffer BYTE 11 DUP(0)

.code
main PROC

    ;1: BYTES DESCARGADOS
    mov eax, bloques
    mul tamBloque ; multiplicamos los bloques por su tamaño
    mov descargados, eax ; guardamos el resultado

    ;2: BYTES PENDIENTES
    mov eax, tamArchivo
    sub eax, descargados ; al total le restamos lo que ya bajamos
    mov pendientes, eax

    ;3: PORCENTAJE ENTERO
    mov eax, descargados
    mov ebx, 100
    mul ebx ; multiplicamos lo descargado por 100

    mov ebx, tamArchivo
    div ebx ; y lo dividimos entre el total para sacar el porcentaje
    mov porcentaje, eax

    ; 4: GRUPOS DE 1024 
    mov eax, descargados
    mov edx, 0 ; limpiamos el edx por regla para poder dividir
    mov ebx, 1024
    div ebx ; dividimos lo descargado entre 1024

    mov grupos, eax ; el cociente son los grupos completos
    mov residuo, edx ; el residuo es lo que sobro de la division

    ;MOSTRAR BYTES DESCARGADOS 
    mov edx, OFFSET msg1
    call WriteString

    mov eax, descargados
    mov esi, OFFSET buffer
    call convertirDecimal ; mandamos llamar nuestra funcion para pasarlo a texto

    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; MOSTRAR BYTES PENDIENTES 
    mov edx, OFFSET msg2
    call WriteString

    mov eax, pendientes
    mov esi, OFFSET buffer
    call convertirDecimal

    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; MOSTRAR PORCENTAJE 
    mov edx, OFFSET msg3
    call WriteString

    mov eax, porcentaje
    mov esi, OFFSET buffer
    call convertirDecimal

    mov edx, OFFSET buffer
    call WriteString

    mov edx, OFFSET simbolo ; le pegamos el signo de % al final
    call WriteString
    call Crlf

    ;MOSTRAR GRUPOS COMPLETOS 
    mov edx, OFFSET msg4
    call WriteString

    mov eax, grupos
    mov esi, OFFSET buffer
    call convertirDecimal

    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    ; MOSTRAR RESIDUO 
    mov edx, OFFSET msg5
    call WriteString

    mov eax, residuo
    mov esi, OFFSET buffer
    call convertirDecimal

    mov edx, OFFSET buffer
    call WriteString
    call Crlf

    exit
main ENDP



; PROCEDIMIENTO: CONVERTIR DECIMAL
; ENTRADA:
; EAX = NUMERO A CONVERTIR
; ESI = DIRECCION DEL BUFFER donde se va a guardar

convertirDecimal PROC

    ; guardamos el estado actual de los registros en la pila para no perderlos
    push eax
    push ebx
    push ecx
    push edx
    push esi
    push edi

    ; apuntamos al final del buffer para ir guardando de atras para adelante
    mov edi, esi
    add edi, 10

    ; ponemos el cero al final para que indique donde termina la cadena
    mov BYTE PTR [edi], 0

    mov ebx, 10 ; base 10 para ir sacando digito por digito

    ; CASO ESPECIAL: NUMERO CERO
    cmp eax, 0
    jne convertir ; si no es cero, brincamos a convertir normal

    ; si si es cero, le metemos el '0' en ASCII directo y terminamos
    dec edi
    mov BYTE PTR [edi], '0'
    jmp copiar

convertir:
    ; DIVIDIR ENTRE 10
    mov edx, 0
    div ebx

    ; pasamos el residuo a su valor en ASCII sumandole el '0'
    add dl, '0'

    ; guardamos el digito y nos movemos un espacio para atras en el buffer
    dec edi
    mov [edi], dl

    ; repetimos el ciclo si todavia quedan numeros por dividir
    cmp eax, 0
    jne convertir

copiar:
    ; acomodamos la cadena bien pasandola al inicio del buffer
    mov al, [edi]
    mov [esi], al

    inc edi
    inc esi

    ; seguimos copiando hasta toparnos con el cero de terminacion
    cmp al, 0
    jne copiar

    ; sacamos los registros de la pila en el orden inverso al que los metimos
    pop edi
    pop esi
    pop edx
    pop ecx
    pop ebx
    pop eax

    ret

convertirDecimal ENDP

END main