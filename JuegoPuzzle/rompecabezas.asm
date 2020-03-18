
				.module rompecabezas	
				.area CODE1(ABS)

fin				.equ	0xFF01
teclado			.equ	0xFF02
pantalla		.equ	0xFF00

				.org	0x100
				.globl	programa
				.globl imprimir_cadena
				.globl imprimir_decimal
tablero: 	
	.asciz "1111111111111111"
					
aciertos: 		
	.word 0
				
hueco: 			
	.byte 0

variable: .byte 0
	
intentos:		
	.byte 0
				
variable_intercambio: 
	.byte 0
				
puzzle_tamano:	
	.byte	4
				
puzzle_numero:	
	.byte	8
				
puzzle_lista:	
	.ascii	" BCDAFKGEIJHMNOL"	; 7  aciertos aapqppaa		;qqooaoqq ;SSDDWDSS
	.ascii	"BCDHAFGLEJKOIMN "	; 4  aciertos pppaaaoooqqq ;aaapppqqqooo ;WWWAAASSSDDD
	.ascii	" BCDAEGHIFJLMNKO"	; 9  aciertos papapa		;qoqoqo ;SDSDSD
	.ascii	"ABCDEFKGIJOHM NL"	; 9  aciertos aapqqp		;oaaoqq ;DWWDSS
	.ascii	"ABC EFGDIJKHMNOL"	; 12 aciertos aaa		;qqq ;SSS
	.ascii	"ABCDEFGHIJKL MNO"	; 12 aciertos ppp		;ooo ;DDD
	.ascii	"ABCDEFGH NJLIMKO"	; 9  aciertos papqpa		;qoaoqo ;SDWDSD
	.ascii	"ABC EFGDIJKHMNOL"	; 12 aciertos aaa		;qqq ;SSS;Q=S;O=D;A=W;P=A;

menu: 
	.ascii	"\n\t\t\33[32m\33[7mPUZZLE (v0.01)\33[37m\33[0m\n\n"		
	.asciz	"\t\33[32m\33[1m1) Jugar\n\t2) Instrucciones\n\t3) Salir\33[37m\33[0m\n\n\33[32mElige una opcion: \33[37m"

info: 			
	.ascii "\n\33[33m\33[1mInstrucciones rompecabezas:\33[37m\33[0m\n"
	.ascii "\33[33mMediante las letras W(arriba), S(abajo), A(izquierda), D(derecha)\n"
	.asciz "mover el espacio en blanco hasta que todas las letras\nqueden en orden y el espacio al final.\33[0m\n"

datos_intro:
	.asciz	"\n\n\33[32m\33[1mPUZZLE (v0.01)\n==============\33[37m\33[0m\n"
					
datos_numPuzzle:
	.asciz "\n\33[36mPuzzle:\33[37m\t\t"
				
datos_numIntentos:
	.asciz "\n\33[36mIntentos:\33[37m\t"
				
datos_numAciertos:
	.asciz "\n\33[36mAciertos:\33[37m\t"
				
comienzo_tablero:
	.asciz "\33[35m\33[1m|====|\n|"
				
final_tablero:
	.asciz "====|\33[37m\33[0m\n"
				
opcion_incorrecta:
	.asciz	"\n\33[31m\33[1mOpcion incorrecta, vuelve a intentarlo\33[37m\33[0m\n"
				
movInviable:
	.asciz "\n\33[31m\33[1mEse movimiento no es valido.\33[37m\33[0m\n"
				
menu_jugar:
	.asciz	"\n\33[32mElige el numero de puzzle [1-8]: \33[37m"
				
instrucciones_movimiento:
	.asciz "\33[34mPulsa WSAD, X: \33[37m"

teclaErronea:
	.asciz "\n\33[31m\33[1mTecla incorrecta, vuelva a probar.\33[37m\33[0m\n"
				
ganaste:
	.asciz "\n\33[33m\33[1mGANASTE, JUEGA DE NUEVO\33[37m\33[0m\n\n"
								

;++++++++++++++++++++++COMIENZO DEL PROGRAMA++++++++++++++++++++
programa:

	lds		#0xFF00			;iniciamos la pila
	
	leax	menu,pcr			;Almacenamos en x la direccion de menu es decir x 							apunta a menú
	jsr		imprimir_cadena		;saltamos a la subrutina imprimir cadena e 							introducimos el registro a
	lda		teclado				
	cmpa	#'1				
	lblo	error_opcion_menu	;comparamos los valores introducidos en el registro a
	cmpa	#'3					
	lbhi	error_opcion_menu	;y si son diferentes de 1,2 ó 3 mediante lb saltamos
	cmpa	#'1	
	lbeq	jugar				;a la direccion dememirua indicada por error opcion 							menú
	cmpa	#'2
	lbeq	instrucciones		;si pulsamos 1,2 ó 3 saltamos a las direcciones de memoria
	ldb		#'\n
	stb		pantalla			;de jugar, instrucciones o salir
	cmpa	#'3
	lbeq	salir
	

;++++++++++++++++++++++JUGAR++++++++++++++++++++++++++++++++++++
jugar:
	lda		#'\n
	sta		pantalla			;cargamos pantalla en el registro a
	leax	menu_jugar,pcr		;almacenamos en x menu jugar
	lbsr	imprimir_cadena		;e imprimimos en pantalla la cadena que nos pide el puzzle
	lda		teclado
	cmpa	#'1	
	lblo	error_opcion_menu_jugar	;comparamos el valor que hemos metido en a a traves del 					teclado
	cmpa	#'8	
	lbhi	error_opcion_menu_jugar	;y si esta entre 1 y 8 guardamos el numero de puzzle en 					puzzle_numero
									;si es diferente vamos a la 						subrutina especificada donde mostramos mensaje de error
	sta	puzzle_numero 		;Guardamos el numero de puzzle que estamos usando
	
	lda 	#'\n
	sta 	pantalla
	sta 	pantalla
	sta 	pantalla
	
					;decrementamos el numero introducido y multiplicamos por 16 							para obtener la direccion de la 
						;primera pieza del puzzle seleccionado
	lda	puzzle_numero
	deca	
	suba 	#48
	ldb 	#16
	mul
	
	leax 	puzzle_lista,pcr 		;x apunta a la lista de puzzles
	leax 	d,x 			;le sumamos el desplazamiento que hemos calculado antes ;x=d+x

	ldb 	#0 			;inicializamos el contador a 0
	leay 	tablero,pcr 		;y apunta ahora a tablero

bucle_carga_tablero: 		;repetido 16 veces va cargardo el puzzle en la variable tablero
	incb			
	lda 	,x+		;vamos cargando en x e incrementando para cargar las letras del .ascii
	sta 	,y+		;y las colocamos en y para no perderlas
	cmpb 	#16		;repetimos esto 16 veces para cargar las 16 posiciones que tiene el 					tablero
	bne bucle_carga_tablero
	
						;ya se ha guardado el puzzle en la variable tablero
	
imprimimos_todo:			
						;ahora calculamos los aciertos
	ldb 	#0
	lda 	#'A
	leay 	tablero,pcr
	lbsr 	calculaAciertos
	

						;ahora imprimimos los datos de partida
	lbsr 	imprime_datos
	
						;ahora lo imprimimos
	leax	comienzo_tablero,pcr
	lbsr	imprimir_cadena
	ldb 	#0
	leax 	tablero,pcr
	lbsr 	imprime_tablero
			
						;buscamos el hueco
	clrb
	clra
	leax 	tablero,pcr
	lbsr 	buscarHueco
	
							;ahora pedimos el movimientos
	leax 	instrucciones_movimiento,pcr
	lbsr 	imprimir_cadena
	lda		teclado		
	cmpa	#'W		
	beq		comprueba_arriba
	cmpa	#'S		
	beq		comprueba_abajo
	cmpa	#'A		
	beq		comprueba_izquierda
	cmpa	#'D		
	beq		comprueba_derecha
	cmpa	#'X		
	lbeq	salir
	leax	teclaErronea,pcr
	lbsr	imprimir_cadena
	lbra 	imprimimos_todo
	
;ahora comprobamos la viabilidad del movimiento
comprueba_arriba:
	lda 	hueco
	suba 	#4							; | 0 | 1 | 2 | 3 |
	cmpa 	#0xFF						; | 4 | 5 | 6 | 7 |
	beq 	movimientoInviable			; | 8 | 9 | 10| 11|
	cmpa 	#0xFE						; | 12| 13| 14| 15|
	beq 	movimientoInviable
	cmpa 	#0xFD
	beq 	movimientoInviable
	cmpa 	#0xFC
	beq 	movimientoInviable
	lbra 	intercambia_arriba
	
comprueba_abajo:
	lda 	hueco						; | 0 | 1 | 2 | 3 |
	adda 	#4							; | 4 | 5 | 6 | 7 |
	cmpa 	#15							; | 8 | 9 | 10| 11|
	bhi 	movimientoInviable			; | 12| 13| 14| 15|
	lbra 	intercambia_abajo
	
comprueba_izquierda:
	lda 	hueco
	deca
	cmpa 	#0xFF
	beq 	movimientoInviable			; | 0 | 1 | 2 | 3 |
	cmpa 	#3							; | 4 | 5 | 6 | 7 |
	beq 	movimientoInviable			; | 8 | 9 | 10| 11|
	cmpa 	#7							; | 12| 13| 14| 15|
	beq 	movimientoInviable
	cmpa 	#11
	beq 	movimientoInviable
	lbra 	intercambia_izquierda
	
comprueba_derecha:
	lda 	hueco
	inca
	cmpa 	#4
	beq 	movimientoInviable			; | 0 | 1 | 2 | 3 |
	cmpa 	#8							; | 4 | 5 | 6 | 7 |
	beq 	movimientoInviable			; | 8 | 9 | 10| 11|
	cmpa 	#12							; | 12| 13| 14| 15|
	beq 	movimientoInviable
	cmpa 	#16
	beq 	movimientoInviable
	lbra 	intercambia_derecha

movimientoInviable:
	leax 	movInviable,pcr
	lbsr 	imprimir_cadena
	lbra 	imprimimos_todo
	
intercambia_arriba:
									;incrementamos intentos
	lda 	intentos	
	inca
	sta 	intentos
	
	leay 	tablero,pcr			 ;y apunta a la primera letra de tablero
	lda 	hueco					;a ahora tiene el valor de la posicion del hueco
	suba 	#4
	leay 	a,y						;y apunta arriba del espacio
	ldb 	,y						;guardamos en b lo que haya en la posicion y
	stb 	variable_intercambio ;guardamos en una variable la letra a intercambiar
	lda 	#0x20					;espacio en ascii=#0x20
	sta 	,y					;ponemos en y un espacio
	
	leay 	tablero,pcr			;apuntamos de nuevo con Y al principio del tablero
	lda 	hueco					;apuntamos al hueco de antes igual que arriba
	leay 	a,y						;Y apunta ahora al hueco
	ldb 	variable_intercambio
	stb 	,y						;insertamos la letra que habiamos guardado en la 											variuable de intercambio en 
	lbra 	comprueba_final
	
intercambia_abajo:
	lda 	intentos	
	inca
	sta 	intentos
	
	leay 	tablero,pcr 						;y apunta a la primera letra de tablero
	lda 	hueco						;a ahora tiene el valor de la posicion del hueco
	adda 	#4
	leay 	a,y						;y apunta abajo del espacio
	ldb 	,y						;guardamos en b lo que haya en la posicion y
	stb 	variable_intercambio 	;guardamos en una variable la letra a intercambiar
	lda 	#0x20					;espacio en ascii=#0x20
	sta 	,y						;ponemos en y un espacio
	
	leay 	tablero,pcr
	lda 	hueco
	leay 	a,y
	ldb 	variable_intercambio
	stb 	,y
	
	lbra 	comprueba_final
	
intercambia_izquierda:
	lda 	intentos
	inca
	sta 	intentos
	
	leay 	tablero,pcr 			;y apunta a la primera letra de tablero
	lda 	hueco					;a ahora tiene el valor de la posicion del hueco
	deca
	leay 	a,y						;y apunta a la izquierda del espacio
	ldb 	,y						;guardamos en b lo que haya en la posicion y
	stb 	variable_intercambio ;guardamos en una variable la letra a intercambiar
	lda 	#0x20					;espacio en ascii=#0x20
	sta 	,y						;ponemos en y un espacio
	
	leay 	tablero,pcr 	
	lda 	hueco
	leay 	a,y
	ldb 	variable_intercambio
	stb 	,y
	
	lbra 	comprueba_final
		
intercambia_derecha:
	lda 	intentos
	inca
	sta 	intentos
	
	leay 	tablero,pcr 			;y apunta a la primera letra de tablero
	lda 	hueco					;a ahora tiene el valor de la posicion del hueco
	inca							;a ahora vale el hueco +1
	leay 	a,y						;y apunta a la derecha del espacio
	ldb 	,y						;guardamos en b lo que haya en la posicion y
	stb 	variable_intercambio ;guardamos en una variable la letra a intercambiar
	lda 	#0x20					;espacio en ascii=#0x20
	sta 	,y						;ponemos en y un espacio
	
	leay 	tablero,pcr 	
	lda 	hueco
	leay 	a,y
	ldb 	variable_intercambio
	stb 	,y
	
	lbra 	comprueba_final

comprueba_final:
									;ahora calculamos los aciertos
	ldb 	#0
	lda 	#'A
	leay 	tablero,pcr 	
	lbsr 	calculaAciertos
	
	lda 	aciertos
	cmpa 	#15 					;si aciertos = 15(16) ganaste
	lbeq 	finaliza
	lbra 	imprimimos_todo 		;sino vuelves a imprimir y pedir mov
	
finaliza:
	leax 	ganaste,pcr
	lbsr 	imprimir_cadena	
	lda		#0
	sta		aciertos
	sta		intentos
	lbra 	programa
;++++++++++++++++++++FIN JUGAR++++++++++++++++++++++++++++++++++


;++++++++++++++++++++INSRUCCIONES+++++++++++++++++++++++++++++++
instrucciones:
	pshs	x
	leax	info,pcr
	lbsr	imprimir_cadena
	puls	x
	lbra 	programa
;+++++++++++++++++++FIN INSTRUCCIONES+++++++++++++++++++++++++++




;|=============================================================|
;|+++++++++++++++++++++++SUBRUTINAS++++++++++++++++++++++++++++|
;|=============================================================|



;+++++++++++++++++++Mensajes de error+++++++++++++++++++++++++++
error_opcion_menu:
	leax	opcion_incorrecta,pcr
	lbsr	imprimir_cadena
	lda		#'\n
	sta		pantalla
	lda		#'\n
	sta		pantalla
	lbra	programa

error_opcion_menu_jugar:
	leax	opcion_incorrecta,pcr
	lbsr	imprimir_cadena
	lda		#'\n
	sta		pantalla
	lda		#'\n
	sta		pantalla
	lbra	jugar
;+++++++++++++++++++Fin mensajes de error+++++++++++++++++++++++

;+++++++++++++++++++Calculo de aciertos+++++++++++++++++++++++++
calculaAciertos:
	cmpa 	#'O
	bhi 	calculaAciertos_salida
	cmpa 	,y+
	beq 	incrementaAciertos
	inca
	bra 	calculaAciertos

incrementaAciertos:
	inca	
	incb
	lbra 	calculaAciertos

calculaAciertos_salida:
	stb 	aciertos
	rts
;++++++++++++++++++Fin calculo de aciertos++++++++++++++++++++++

;+++++++++++++++++++Imprimir datos++++++++++++++++++++++++++++++
imprime_datos:
	leax	datos_intro,pcr
	lbsr	imprimir_cadena
	leax	datos_numPuzzle,pcr
	lbsr	imprimir_cadena
	lda 	puzzle_numero
	sta 	pantalla
	leax	datos_numIntentos,pcr
	lbsr	imprimir_cadena

	lda 	intentos

	lbsr	imprimir_decimal

	leax	datos_numAciertos,pcr
	lbsr	imprimir_cadena
	lda 	aciertos
	
	lbsr	imprimir_decimal
	
	lda		#'\n
	sta		pantalla
	sta		pantalla
	
	rts
;+++++++++++++++++++Fin imprimir datos++++++++++++++++++++++++++

;+++++++++++++++++++Impresion de tablero++++++++++++++++++++++++
imprime_tablero:
	incb

	cmpb 	#5			;comparamos que hemos puesto los cuatro primeros valores de 						la fila 1 y al 5 ponemos salto de linea
	lbeq 	pon_salto
	cmpb 	#9			;comparamos que hemos puesto los cuatro segundos valores de 						la fila 2 y al 9 ponemos salto de linea
	lbeq 	pon_salto
	cmpb 	#13			;comparamos que hemos puesto los cuatro terceros valores de 						la fila 3 y al 13 ponemos salto de linea
	lbeq 	pon_salto
	cmpb 	#17			;comparamos que hemos puesto los cuatro cuartos valores de la 						fila 4 y al 17 ponemos salto de linea
	lbeq 	pon_salto
yahasaltao:
	lda 	,x+
	beq 	imprime_tablero_salida
	sta		pantalla
	bra		imprime_tablero

imprime_tablero_salida:
	leax	final_tablero,pcr
	lbsr	imprimir_cadena
	rts
	
pon_salto:
	pshs 	a
	lda		#'|
	sta 	pantalla		;accedemos a traves de imprime_tablero y nos encargamos de 						mostrar por pantalla el salto y el caracter |
	lda 	#'\n		
	sta 	pantalla		;que nos indica el final de una fila del tablero
	lda 	#'|
	sta 	pantalla
	puls 	a
	lbra 	yahasaltao		;saltamos a la direccion de memoria que nos indica yahasaltao
;+++++++++++++++++++Fin de impresion de tablero+++++++++++++++++

;+++++++++++++++++++Buscar hueco++++++++++++++++++++++++++++++++
buscarHueco:
	lda 	,x+
	beq 	buscarHueco_salida
	cmpa 	#32
	beq 	guardaPosicion
	
	incb
	bra 	buscarHueco
	
guardaPosicion:
	stb		hueco
	bra 	buscarHueco_salida
	
buscarHueco_salida:
	rts
;+++++++++++++++++++Fin buscar hueco++++++++++++++++++++++++++++	

salir:
	clra
	sta		fin

	.org	0xFFFE
	.word	programa
