; Alumno: Alexis Serrano Salomon
; Práctica:15
; Descripción: creamos un archivo de texto llamado "Inventario", le escribimos el numero "125" adentro y lo cerramos. Si algo sale mal, tiramos un mensaje de error.

INCLUDE Irvine32.inc

.data
    nombreArchivo BYTE "Inventario.txt", 0
    texto BYTE "125", 0
    archivoHandle DWORD ? 

    mensajeExito BYTE "Archivo guardado correctamente", 0 
    mensajeError BYTE "No se pudo guardar el archivo", 0 

.code
main PROC

; 1. CREAR ARCHIVO TXT 
    mov edx, OFFSET nombreArchivo 
    call CreateOutputFile 

    ; checamos si se creo bien
    cmp eax, INVALID_HANDLE_VALUE
    je error ; si el handle es invalida brinca error

    ; si todo salio bien, guardamos el handle en su variable
    mov archivoHandle, eax 

;2. ESCRIBIR CARACTERES EN EL ARCHIVO TXT
    mov eax, archivoHandle 
    mov edx, OFFSET texto 
    mov ecx, SIZEOF texto - 1 ; le restamos 1 para no imprimir el cero de terminacion
    call WriteToFile

    ; jc si se prende la bandera de acarreo es porque hubo error al escribir
    jc errorEscritura

    ; verificamos que la cantidad de bytes escritos
    cmp eax, SIZEOF texto - 1 
    jne errorEscritura ; si no cuadra, nos vamos a la etiqueta de error

; 3. CERRAR EL ARCHIVO TXT
    mov eax, archivoHandle 
    call CloseFile 

    ; test revisa si cerro bien. Si eax quedó en 0, hubo falla
    test eax, eax 
    jz error ; si devolvio cero, tiramos error

    ; salta si no hay errores
    mov edx, OFFSET mensajeExito
    call WriteString 
    call Crlf
    jmp fin ; brincamos al final para saltarnos los mensajes de error

errorEscritura:
    ; si hubo falla al escribir, de todos modos cerramos el archivo para no dejarlo en la memoria
    mov eax, archivoHandle 
    call CloseFile 

error: 
    ; etiqueta comun para cuando algo sale mal
    mov edx, OFFSET mensajeError 
    call WriteString 
    call Crlf

fin:

    exit
main ENDP 
END main