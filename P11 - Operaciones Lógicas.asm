; Alumno: Alexis Serrano Salomon
; Práctica:11
; Descripción: vemos como usar operaciones logicas a nivel de bits (AND, OR, XOR, NOT y TEST) para prender, apagar y revisar estados de un sistema.

INCLUDE Irvine32.inc

.code
main PROC
     ; Estos son los bits a controlar:
     ; Bit 0 - Encendido de computadora
     ; Bit 1 - Alarma
     ; Bit 2 - Conectado
     ; Estado inicial: 00000101b Encendido y Conectado, pero sin Alarma

     ;1- AND: EXTRAER EL ESTADO DE ENCENDIDO
     mov eax, 0
     mov ebx, 0
     mov al, 00000101b ; cargamos el estado inicial en el registro al
     mov bl, al
     ; usamos AND como una mascara al compararlo con 00000111b apagamos todo lo demas y nos quedamos nomas con los primeros 3 bits
     and bl, 00000111b

     call DumpRegs
     nop ; pausa pa checar los registros en el depurador

;2 - OR: ENCENDER LA ALARMA
     mov al, 00000101b
     ; usamos OR para forzar a que se prenda un bit especifico el bit 1 de la alarma sin afectar a los demas
     or al, 00000010b

     call DumpRegs
     nop


     ; 3 - XOR: CAMBIAR EL ESTADO DE CONECTADO
     mov al, 00000101b
     ; usamos XOR para cambiar o invertir nomas el bit 2 de conectado, Si estaba prendido lo apaga, y si estaba apagado lo prende
     xor al, 00000100b

     call DumpRegs
     nop


     ;4 - NOT: INVERTIR ESTADOS
     mov al, 00000101b
     ; NOT le da la vuelta a todo parejo, los 1 se hacen 0 y los 0 se hacen 1
     not al

     call DumpRegs
     nop


     ;5 - TEST: EVALUAR ALARMA Y REALIZAR SALTO
     mov al, 00000101b
     ; TEST hace lo mismo que un AND pero nomas modifica las banderas sin cambiar el registro. Checamos si el bit de la alarma el 1 edta prendido
     test al, 00000010b

     ; jz  si el resultado dio cero significa que el bit estaba apagado, asi que brincamos a la etiqueta
     jz alarmaApagada

     ; SI LA ALARMA ESTA ENCENDIDA
     mov ebx, 1 ; usamos el ebx como bandera para marcar que si estaba prendida
     jmp finTest ; brincamos al final para no pasarnos al bloque de abajo

alarmaApagada:
     ; SI LA ALARMA ESTA APAGADA
     mov ebx, 0 ; marcamos que estaba apagada

finTest:
     call DumpRegs
     nop

     exit

main ENDP

END main