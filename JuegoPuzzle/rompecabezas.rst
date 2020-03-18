ASxxxx Assembler V05.00  (Motorola 6809), page 1.
Hexidecimal [16-Bits]



                              1 
                              2 				.module rompecabezas	
                              3 				.area CODE1(ABS)
                              4 
                     FF01     5 fin				.equ	0xFF01
                     FF02     6 teclado			.equ	0xFF02
                     FF00     7 pantalla		.equ	0xFF00
                              8 
   0100                       9 				.org	0x100
                             10 				.globl	programa
                             11 				.globl imprimir_cadena
                             12 				.globl imprimir_decimal
   0100                      13 tablero: 	
   0100 31 31 31 31 31 31    14 	.asciz "1111111111111111"
        31 31 31 31 31 31
        31 31 31 31 00
                             15 					
   0111                      16 aciertos: 		
   0111 00 00                17 	.word 0
                             18 				
   0113                      19 hueco: 			
   0113 00                   20 	.byte 0
                             21 
   0114 00                   22 variable: .byte 0
                             23 	
   0115                      24 intentos:		
   0115 00                   25 	.byte 0
                             26 				
   0116                      27 variable_intercambio: 
   0116 00                   28 	.byte 0
                             29 				
   0117                      30 puzzle_tamano:	
   0117 04                   31 	.byte	4
                             32 				
   0118                      33 puzzle_numero:	
   0118 08                   34 	.byte	8
                             35 				
   0119                      36 puzzle_lista:	
   0119 20 42 43 44 41 46    37 	.ascii	" BCDAFKGEIJHMNOL"	; 7  aciertos aapqppaa		;qqooaoqq ;SSDDWDSS
        4B 47 45 49 4A 48
        4D 4E 4F 4C
   0129 42 43 44 48 41 46    38 	.ascii	"BCDHAFGLEJKOIMN "	; 4  aciertos pppaaaoooqqq ;aaapppqqqooo ;WWWAAASSSDDD
        47 4C 45 4A 4B 4F
        49 4D 4E 20
   0139 20 42 43 44 41 45    39 	.ascii	" BCDAEGHIFJLMNKO"	; 9  aciertos papapa		;qoqoqo ;SDSDSD
        47 48 49 46 4A 4C
        4D 4E 4B 4F
   0149 41 42 43 44 45 46    40 	.ascii	"ABCDEFKGIJOHM NL"	; 9  aciertos aapqqp		;oaaoqq ;DWWDSS
        4B 47 49 4A 4F 48
        4D 20 4E 4C
   0159 41 42 43 20 45 46    41 	.ascii	"ABC EFGDIJKHMNOL"	; 12 aciertos aaa		;qqq ;SSS
        47 44 49 4A 4B 48
        4D 4E 4F 4C
   0169 41 42 43 44 45 46    42 	.ascii	"ABCDEFGHIJKL MNO"	; 12 aciertos ppp		;ooo ;DDD
        47 48 49 4A 4B 4C
ASxxxx Assembler V05.00  (Motorola 6809), page 2.
Hexidecimal [16-Bits]



        20 4D 4E 4F
   0179 41 42 43 44 45 46    43 	.ascii	"ABCDEFGH NJLIMKO"	; 9  aciertos papqpa		;qoaoqo ;SDWDSD
        47 48 20 4E 4A 4C
        49 4D 4B 4F
   0189 41 42 43 20 45 46    44 	.ascii	"ABC EFGDIJKHMNOL"	; 12 aciertos aaa		;qqq ;SSS;Q=S;O=D;A=W;P=A;
        47 44 49 4A 4B 48
        4D 4E 4F 4C
                             45 
   0199                      46 menu: 
   0199 0A 09 09 1B 5B 33    47 	.ascii	"\n\t\t\33[32m\33[7mPUZZLE (v0.01)\33[37m\33[0m\n\n"		
        32 6D 1B 5B 37 6D
        50 55 5A 5A 4C 45
        20 28 76 30 2E 30
        31 29 1B 5B 33 37
        6D 1B 5B 30 6D 0A
        0A
   01BE 09 1B 5B 33 32 6D    48 	.asciz	"\t\33[32m\33[1m1) Jugar\n\t2) Instrucciones\n\t3) Salir\33[37m\33[0m\n\n\33[32mElige una opcion: \33[37m"
        1B 5B 31 6D 31 29
        20 4A 75 67 61 72
        0A 09 32 29 20 49
        6E 73 74 72 75 63
        63 69 6F 6E 65 73
        0A 09 33 29 20 53
        61 6C 69 72 1B 5B
        33 37 6D 1B 5B 30
        6D 0A 0A 1B 5B 33
        32 6D 45 6C 69 67
        65 20 75 6E 61 20
        6F 70 63 69 6F 6E
        3A 20 1B 5B 33 37
        6D 00
                             49 
   0214                      50 info: 			
   0214 0A 1B 5B 33 33 6D    51 	.ascii "\n\33[33m\33[1mInstrucciones rompecabezas:\33[37m\33[0m\n"
        1B 5B 31 6D 49 6E
        73 74 72 75 63 63
        69 6F 6E 65 73 20
        72 6F 6D 70 65 63
        61 62 65 7A 61 73
        3A 1B 5B 33 37 6D
        1B 5B 30 6D 0A
   0243 1B 5B 33 33 6D 4D    52 	.ascii "\33[33mMediante las letras W(arriba), S(abajo), A(izquierda), D(derecha)\n"
        65 64 69 61 6E 74
        65 20 6C 61 73 20
        6C 65 74 72 61 73
        20 57 28 61 72 72
        69 62 61 29 2C 20
        53 28 61 62 61 6A
        6F 29 2C 20 41 28
        69 7A 71 75 69 65
        72 64 61 29 2C 20
        44 28 64 65 72 65
        63 68 61 29 0A
   028A 6D 6F 76 65 72 20    53 	.asciz "mover el espacio en blanco hasta que todas las letras\nqueden en orden y el espacio al final.\33[0m\n"
        65 6C 20 65 73 70
ASxxxx Assembler V05.00  (Motorola 6809), page 3.
Hexidecimal [16-Bits]



        61 63 69 6F 20 65
        6E 20 62 6C 61 6E
        63 6F 20 68 61 73
        74 61 20 71 75 65
        20 74 6F 64 61 73
        20 6C 61 73 20 6C
        65 74 72 61 73 0A
        71 75 65 64 65 6E
        20 65 6E 20 6F 72
        64 65 6E 20 79 20
        65 6C 20 65 73 70
        61 63 69 6F 20 61
        6C 20 66 69 6E 61
        6C 2E 1B 5B 30 6D
        0A 00
                             54 
   02EC                      55 datos_intro:
   02EC 0A 0A 1B 5B 33 32    56 	.asciz	"\n\n\33[32m\33[1mPUZZLE (v0.01)\n==============\33[37m\33[0m\n"
        6D 1B 5B 31 6D 50
        55 5A 5A 4C 45 20
        28 76 30 2E 30 31
        29 0A 3D 3D 3D 3D
        3D 3D 3D 3D 3D 3D
        3D 3D 3D 3D 1B 5B
        33 37 6D 1B 5B 30
        6D 0A 00
                             57 					
   031F                      58 datos_numPuzzle:
   031F 0A 1B 5B 33 36 6D    59 	.asciz "\n\33[36mPuzzle:\33[37m\t\t"
        50 75 7A 7A 6C 65
        3A 1B 5B 33 37 6D
        09 09 00
                             60 				
   0334                      61 datos_numIntentos:
   0334 0A 1B 5B 33 36 6D    62 	.asciz "\n\33[36mIntentos:\33[37m\t"
        49 6E 74 65 6E 74
        6F 73 3A 1B 5B 33
        37 6D 09 00
                             63 				
   034A                      64 datos_numAciertos:
   034A 0A 1B 5B 33 36 6D    65 	.asciz "\n\33[36mAciertos:\33[37m\t"
        41 63 69 65 72 74
        6F 73 3A 1B 5B 33
        37 6D 09 00
                             66 				
   0360                      67 comienzo_tablero:
   0360 1B 5B 33 35 6D 1B    68 	.asciz "\33[35m\33[1m|====|\n|"
        5B 31 6D 7C 3D 3D
        3D 3D 7C 0A 7C 00
                             69 				
   0372                      70 final_tablero:
   0372 3D 3D 3D 3D 7C 1B    71 	.asciz "====|\33[37m\33[0m\n"
        5B 33 37 6D 1B 5B
        30 6D 0A 00
                             72 				
ASxxxx Assembler V05.00  (Motorola 6809), page 4.
Hexidecimal [16-Bits]



   0382                      73 opcion_incorrecta:
   0382 0A 1B 5B 33 31 6D    74 	.asciz	"\n\33[31m\33[1mOpcion incorrecta, vuelve a intentarlo\33[37m\33[0m\n"
        1B 5B 31 6D 4F 70
        63 69 6F 6E 20 69
        6E 63 6F 72 72 65
        63 74 61 2C 20 76
        75 65 6C 76 65 20
        61 20 69 6E 74 65
        6E 74 61 72 6C 6F
        1B 5B 33 37 6D 1B
        5B 30 6D 0A 00
                             75 				
   03BD                      76 movInviable:
   03BD 0A 1B 5B 33 31 6D    77 	.asciz "\n\33[31m\33[1mEse movimiento no es valido.\33[37m\33[0m\n"
        1B 5B 31 6D 45 73
        65 20 6D 6F 76 69
        6D 69 65 6E 74 6F
        20 6E 6F 20 65 73
        20 76 61 6C 69 64
        6F 2E 1B 5B 33 37
        6D 1B 5B 30 6D 0A
        00
                             78 				
   03EE                      79 menu_jugar:
   03EE 0A 1B 5B 33 32 6D    80 	.asciz	"\n\33[32mElige el numero de puzzle [1-8]: \33[37m"
        45 6C 69 67 65 20
        65 6C 20 6E 75 6D
        65 72 6F 20 64 65
        20 70 75 7A 7A 6C
        65 20 5B 31 2D 38
        5D 3A 20 1B 5B 33
        37 6D 00
                             81 				
   041B                      82 instrucciones_movimiento:
   041B 1B 5B 33 34 6D 50    83 	.asciz "\33[34mPulsa WSAD, X: \33[37m"
        75 6C 73 61 20 57
        53 41 44 2C 20 58
        3A 20 1B 5B 33 37
        6D 00
                             84 
   0435                      85 teclaErronea:
   0435 0A 1B 5B 33 31 6D    86 	.asciz "\n\33[31m\33[1mTecla incorrecta, vuelva a probar.\33[37m\33[0m\n"
        1B 5B 31 6D 54 65
        63 6C 61 20 69 6E
        63 6F 72 72 65 63
        74 61 2C 20 76 75
        65 6C 76 61 20 61
        20 70 72 6F 62 61
        72 2E 1B 5B 33 37
        6D 1B 5B 30 6D 0A
        00
                             87 				
   046C                      88 ganaste:
   046C 0A 1B 5B 33 33 6D    89 	.asciz "\n\33[33m\33[1mGANASTE, JUEGA DE NUEVO\33[37m\33[0m\n\n"
        1B 5B 31 6D 47 41
ASxxxx Assembler V05.00  (Motorola 6809), page 5.
Hexidecimal [16-Bits]



        4E 41 53 54 45 2C
        20 4A 55 45 47 41
        20 44 45 20 4E 55
        45 56 4F 1B 5B 33
        37 6D 1B 5B 30 6D
        0A 0A 00
                             90 								
                             91 
                             92 ;++++++++++++++++++++++COMIENZO DEL PROGRAMA++++++++++++++++++++
   0499                      93 programa:
                             94 
   0499 10 CE FF 00   [ 4]   95 	lds		#0xFF00			;iniciamos la pila
                             96 	
   049D 30 8D FC F8   [ 9]   97 	leax	menu,pcr			;Almacenamos en x la direccion de menu es decir x 							apunta a menú
   04A1 BD 00 46      [ 8]   98 	jsr		imprimir_cadena		;saltamos a la subrutina imprimir cadena e 							introducimos el registro a
   04A4 B6 FF 02      [ 5]   99 	lda		teclado				
   04A7 81 31         [ 2]  100 	cmpa	#'1				
   04A9 10 25 01 F6   [ 6]  101 	lblo	error_opcion_menu	;comparamos los valores introducidos en el registro a
   04AD 81 33         [ 2]  102 	cmpa	#'3					
   04AF 10 22 01 F0   [ 6]  103 	lbhi	error_opcion_menu	;y si son diferentes de 1,2 ó 3 mediante lb saltamos
   04B3 81 31         [ 2]  104 	cmpa	#'1	
   04B5 10 27 00 11   [ 6]  105 	lbeq	jugar				;a la direccion dememirua indicada por error opcion 							menú
   04B9 81 32         [ 2]  106 	cmpa	#'2
   04BB 10 27 01 D6   [ 6]  107 	lbeq	instrucciones		;si pulsamos 1,2 ó 3 saltamos a las direcciones de memoria
   04BF C6 0A         [ 2]  108 	ldb		#'\n
   04C1 F7 FF 00      [ 5]  109 	stb		pantalla			;de jugar, instrucciones o salir
   04C4 81 33         [ 2]  110 	cmpa	#'3
   04C6 10 27 02 9D   [ 6]  111 	lbeq	salir
                            112 	
                            113 
                            114 ;++++++++++++++++++++++JUGAR++++++++++++++++++++++++++++++++++++
   04CA                     115 jugar:
   04CA 86 0A         [ 2]  116 	lda		#'\n
   04CC B7 FF 00      [ 5]  117 	sta		pantalla			;cargamos pantalla en el registro a
   04CF 30 8D FF 1B   [ 9]  118 	leax	menu_jugar,pcr		;almacenamos en x menu jugar
   04D3 17 FB 70      [ 9]  119 	lbsr	imprimir_cadena		;e imprimimos en pantalla la cadena que nos pide el puzzle
   04D6 B6 FF 02      [ 5]  120 	lda		teclado
   04D9 81 31         [ 2]  121 	cmpa	#'1	
   04DB 10 25 01 D8   [ 6]  122 	lblo	error_opcion_menu_jugar	;comparamos el valor que hemos metido en a a traves del 					teclado
   04DF 81 38         [ 2]  123 	cmpa	#'8	
   04E1 10 22 01 D2   [ 6]  124 	lbhi	error_opcion_menu_jugar	;y si esta entre 1 y 8 guardamos el numero de puzzle en 					puzzle_numero
                            125 									;si es diferente vamos a la 						subrutina especificada donde mostramos mensaje de error
   04E5 B7 01 18      [ 5]  126 	sta	puzzle_numero 		;Guardamos el numero de puzzle que estamos usando
                            127 	
   04E8 86 0A         [ 2]  128 	lda 	#'\n
   04EA B7 FF 00      [ 5]  129 	sta 	pantalla
   04ED B7 FF 00      [ 5]  130 	sta 	pantalla
   04F0 B7 FF 00      [ 5]  131 	sta 	pantalla
                            132 	
                            133 					;decrementamos el numero introducido y multiplicamos por 16 							para obtener la direccion de la 
                            134 						;primera pieza del puzzle seleccionado
   04F3 B6 01 18      [ 5]  135 	lda	puzzle_numero
   04F6 4A            [ 2]  136 	deca	
   04F7 80 30         [ 2]  137 	suba 	#48
   04F9 C6 10         [ 2]  138 	ldb 	#16
ASxxxx Assembler V05.00  (Motorola 6809), page 6.
Hexidecimal [16-Bits]



   04FB 3D            [11]  139 	mul
                            140 	
   04FC 30 8D FC 19   [ 9]  141 	leax 	puzzle_lista,pcr 		;x apunta a la lista de puzzles
   0500 30 8B         [ 8]  142 	leax 	d,x 			;le sumamos el desplazamiento que hemos calculado antes ;x=d+x
                            143 
   0502 C6 00         [ 2]  144 	ldb 	#0 			;inicializamos el contador a 0
   0504 31 8D FB F8   [ 9]  145 	leay 	tablero,pcr 		;y apunta ahora a tablero
                            146 
   0508                     147 bucle_carga_tablero: 		;repetido 16 veces va cargardo el puzzle en la variable tablero
   0508 5C            [ 2]  148 	incb			
   0509 A6 80         [ 6]  149 	lda 	,x+		;vamos cargando en x e incrementando para cargar las letras del .ascii
   050B A7 A0         [ 6]  150 	sta 	,y+		;y las colocamos en y para no perderlas
   050D C1 10         [ 2]  151 	cmpb 	#16		;repetimos esto 16 veces para cargar las 16 posiciones que tiene el 					tablero
   050F 26 F7         [ 3]  152 	bne bucle_carga_tablero
                            153 	
                            154 						;ya se ha guardado el puzzle en la variable tablero
                            155 	
   0511                     156 imprimimos_todo:			
                            157 						;ahora calculamos los aciertos
   0511 C6 00         [ 2]  158 	ldb 	#0
   0513 86 41         [ 2]  159 	lda 	#'A
   0515 31 8D FB E7   [ 9]  160 	leay 	tablero,pcr
   0519 17 01 AF      [ 9]  161 	lbsr 	calculaAciertos
                            162 	
                            163 
                            164 						;ahora imprimimos los datos de partida
   051C 17 01 C0      [ 9]  165 	lbsr 	imprime_datos
                            166 	
                            167 						;ahora lo imprimimos
   051F 30 8D FE 3D   [ 9]  168 	leax	comienzo_tablero,pcr
   0523 17 FB 20      [ 9]  169 	lbsr	imprimir_cadena
   0526 C6 00         [ 2]  170 	ldb 	#0
   0528 30 8D FB D4   [ 9]  171 	leax 	tablero,pcr
   052C 17 01 E7      [ 9]  172 	lbsr 	imprime_tablero
                            173 			
                            174 						;buscamos el hueco
   052F 5F            [ 2]  175 	clrb
   0530 4F            [ 2]  176 	clra
   0531 30 8D FB CB   [ 9]  177 	leax 	tablero,pcr
   0535 17 02 1E      [ 9]  178 	lbsr 	buscarHueco
                            179 	
                            180 							;ahora pedimos el movimientos
   0538 30 8D FE DF   [ 9]  181 	leax 	instrucciones_movimiento,pcr
   053C 17 FB 07      [ 9]  182 	lbsr 	imprimir_cadena
   053F B6 FF 02      [ 5]  183 	lda		teclado		
   0542 81 57         [ 2]  184 	cmpa	#'W		
   0544 27 1C         [ 3]  185 	beq		comprueba_arriba
   0546 81 53         [ 2]  186 	cmpa	#'S		
   0548 27 30         [ 3]  187 	beq		comprueba_abajo
   054A 81 41         [ 2]  188 	cmpa	#'A		
   054C 27 38         [ 3]  189 	beq		comprueba_izquierda
   054E 81 44         [ 2]  190 	cmpa	#'D		
   0550 27 4B         [ 3]  191 	beq		comprueba_derecha
   0552 81 58         [ 2]  192 	cmpa	#'X		
   0554 10 27 02 0F   [ 6]  193 	lbeq	salir
ASxxxx Assembler V05.00  (Motorola 6809), page 7.
Hexidecimal [16-Bits]



   0558 30 8D FE D9   [ 9]  194 	leax	teclaErronea,pcr
   055C 17 FA E7      [ 9]  195 	lbsr	imprimir_cadena
   055F 16 FF AF      [ 5]  196 	lbra 	imprimimos_todo
                            197 	
                            198 ;ahora comprobamos la viabilidad del movimiento
   0562                     199 comprueba_arriba:
   0562 B6 01 13      [ 5]  200 	lda 	hueco
   0565 80 04         [ 2]  201 	suba 	#4							; | 0 | 1 | 2 | 3 |
   0567 81 FF         [ 2]  202 	cmpa 	#0xFF						; | 4 | 5 | 6 | 7 |
   0569 27 49         [ 3]  203 	beq 	movimientoInviable			; | 8 | 9 | 10| 11|
   056B 81 FE         [ 2]  204 	cmpa 	#0xFE						; | 12| 13| 14| 15|
   056D 27 45         [ 3]  205 	beq 	movimientoInviable
   056F 81 FD         [ 2]  206 	cmpa 	#0xFD
   0571 27 41         [ 3]  207 	beq 	movimientoInviable
   0573 81 FC         [ 2]  208 	cmpa 	#0xFC
   0575 27 3D         [ 3]  209 	beq 	movimientoInviable
   0577 16 00 44      [ 5]  210 	lbra 	intercambia_arriba
                            211 	
   057A                     212 comprueba_abajo:
   057A B6 01 13      [ 5]  213 	lda 	hueco						; | 0 | 1 | 2 | 3 |
   057D 8B 04         [ 2]  214 	adda 	#4							; | 4 | 5 | 6 | 7 |
   057F 81 0F         [ 2]  215 	cmpa 	#15							; | 8 | 9 | 10| 11|
   0581 22 31         [ 3]  216 	bhi 	movimientoInviable			; | 12| 13| 14| 15|
   0583 16 00 64      [ 5]  217 	lbra 	intercambia_abajo
                            218 	
   0586                     219 comprueba_izquierda:
   0586 B6 01 13      [ 5]  220 	lda 	hueco
   0589 4A            [ 2]  221 	deca
   058A 81 FF         [ 2]  222 	cmpa 	#0xFF
   058C 27 26         [ 3]  223 	beq 	movimientoInviable			; | 0 | 1 | 2 | 3 |
   058E 81 03         [ 2]  224 	cmpa 	#3							; | 4 | 5 | 6 | 7 |
   0590 27 22         [ 3]  225 	beq 	movimientoInviable			; | 8 | 9 | 10| 11|
   0592 81 07         [ 2]  226 	cmpa 	#7							; | 12| 13| 14| 15|
   0594 27 1E         [ 3]  227 	beq 	movimientoInviable
   0596 81 0B         [ 2]  228 	cmpa 	#11
   0598 27 1A         [ 3]  229 	beq 	movimientoInviable
   059A 16 00 79      [ 5]  230 	lbra 	intercambia_izquierda
                            231 	
   059D                     232 comprueba_derecha:
   059D B6 01 13      [ 5]  233 	lda 	hueco
   05A0 4C            [ 2]  234 	inca
   05A1 81 04         [ 2]  235 	cmpa 	#4
   05A3 27 0F         [ 3]  236 	beq 	movimientoInviable			; | 0 | 1 | 2 | 3 |
   05A5 81 08         [ 2]  237 	cmpa 	#8							; | 4 | 5 | 6 | 7 |
   05A7 27 0B         [ 3]  238 	beq 	movimientoInviable			; | 8 | 9 | 10| 11|
   05A9 81 0C         [ 2]  239 	cmpa 	#12							; | 12| 13| 14| 15|
   05AB 27 07         [ 3]  240 	beq 	movimientoInviable
   05AD 81 10         [ 2]  241 	cmpa 	#16
   05AF 27 03         [ 3]  242 	beq 	movimientoInviable
   05B1 16 00 8D      [ 5]  243 	lbra 	intercambia_derecha
                            244 
   05B4                     245 movimientoInviable:
   05B4 30 8D FE 05   [ 9]  246 	leax 	movInviable,pcr
   05B8 17 FA 8B      [ 9]  247 	lbsr 	imprimir_cadena
   05BB 16 FF 53      [ 5]  248 	lbra 	imprimimos_todo
ASxxxx Assembler V05.00  (Motorola 6809), page 8.
Hexidecimal [16-Bits]



                            249 	
   05BE                     250 intercambia_arriba:
                            251 									;incrementamos intentos
   05BE B6 01 15      [ 5]  252 	lda 	intentos	
   05C1 4C            [ 2]  253 	inca
   05C2 B7 01 15      [ 5]  254 	sta 	intentos
                            255 	
   05C5 31 8D FB 37   [ 9]  256 	leay 	tablero,pcr			 ;y apunta a la primera letra de tablero
   05C9 B6 01 13      [ 5]  257 	lda 	hueco					;a ahora tiene el valor de la posicion del hueco
   05CC 80 04         [ 2]  258 	suba 	#4
   05CE 31 A6         [ 5]  259 	leay 	a,y						;y apunta arriba del espacio
   05D0 E6 A4         [ 4]  260 	ldb 	,y						;guardamos en b lo que haya en la posicion y
   05D2 F7 01 16      [ 5]  261 	stb 	variable_intercambio ;guardamos en una variable la letra a intercambiar
   05D5 86 20         [ 2]  262 	lda 	#0x20					;espacio en ascii=#0x20
   05D7 A7 A4         [ 4]  263 	sta 	,y					;ponemos en y un espacio
                            264 	
   05D9 31 8D FB 23   [ 9]  265 	leay 	tablero,pcr			;apuntamos de nuevo con Y al principio del tablero
   05DD B6 01 13      [ 5]  266 	lda 	hueco					;apuntamos al hueco de antes igual que arriba
   05E0 31 A6         [ 5]  267 	leay 	a,y						;Y apunta ahora al hueco
   05E2 F6 01 16      [ 5]  268 	ldb 	variable_intercambio
   05E5 E7 A4         [ 4]  269 	stb 	,y						;insertamos la letra que habiamos guardado en la 											variuable de intercambio en 
   05E7 16 00 82      [ 5]  270 	lbra 	comprueba_final
                            271 	
   05EA                     272 intercambia_abajo:
   05EA B6 01 15      [ 5]  273 	lda 	intentos	
   05ED 4C            [ 2]  274 	inca
   05EE B7 01 15      [ 5]  275 	sta 	intentos
                            276 	
   05F1 31 8D FB 0B   [ 9]  277 	leay 	tablero,pcr 						;y apunta a la primera letra de tablero
   05F5 B6 01 13      [ 5]  278 	lda 	hueco						;a ahora tiene el valor de la posicion del hueco
   05F8 8B 04         [ 2]  279 	adda 	#4
   05FA 31 A6         [ 5]  280 	leay 	a,y						;y apunta abajo del espacio
   05FC E6 A4         [ 4]  281 	ldb 	,y						;guardamos en b lo que haya en la posicion y
   05FE F7 01 16      [ 5]  282 	stb 	variable_intercambio 	;guardamos en una variable la letra a intercambiar
   0601 86 20         [ 2]  283 	lda 	#0x20					;espacio en ascii=#0x20
   0603 A7 A4         [ 4]  284 	sta 	,y						;ponemos en y un espacio
                            285 	
   0605 31 8D FA F7   [ 9]  286 	leay 	tablero,pcr
   0609 B6 01 13      [ 5]  287 	lda 	hueco
   060C 31 A6         [ 5]  288 	leay 	a,y
   060E F6 01 16      [ 5]  289 	ldb 	variable_intercambio
   0611 E7 A4         [ 4]  290 	stb 	,y
                            291 	
   0613 16 00 56      [ 5]  292 	lbra 	comprueba_final
                            293 	
   0616                     294 intercambia_izquierda:
   0616 B6 01 15      [ 5]  295 	lda 	intentos
   0619 4C            [ 2]  296 	inca
   061A B7 01 15      [ 5]  297 	sta 	intentos
                            298 	
   061D 31 8D FA DF   [ 9]  299 	leay 	tablero,pcr 			;y apunta a la primera letra de tablero
   0621 B6 01 13      [ 5]  300 	lda 	hueco					;a ahora tiene el valor de la posicion del hueco
   0624 4A            [ 2]  301 	deca
   0625 31 A6         [ 5]  302 	leay 	a,y						;y apunta a la izquierda del espacio
   0627 E6 A4         [ 4]  303 	ldb 	,y						;guardamos en b lo que haya en la posicion y
ASxxxx Assembler V05.00  (Motorola 6809), page 9.
Hexidecimal [16-Bits]



   0629 F7 01 16      [ 5]  304 	stb 	variable_intercambio ;guardamos en una variable la letra a intercambiar
   062C 86 20         [ 2]  305 	lda 	#0x20					;espacio en ascii=#0x20
   062E A7 A4         [ 4]  306 	sta 	,y						;ponemos en y un espacio
                            307 	
   0630 31 8D FA CC   [ 9]  308 	leay 	tablero,pcr 	
   0634 B6 01 13      [ 5]  309 	lda 	hueco
   0637 31 A6         [ 5]  310 	leay 	a,y
   0639 F6 01 16      [ 5]  311 	ldb 	variable_intercambio
   063C E7 A4         [ 4]  312 	stb 	,y
                            313 	
   063E 16 00 2B      [ 5]  314 	lbra 	comprueba_final
                            315 		
   0641                     316 intercambia_derecha:
   0641 B6 01 15      [ 5]  317 	lda 	intentos
   0644 4C            [ 2]  318 	inca
   0645 B7 01 15      [ 5]  319 	sta 	intentos
                            320 	
   0648 31 8D FA B4   [ 9]  321 	leay 	tablero,pcr 			;y apunta a la primera letra de tablero
   064C B6 01 13      [ 5]  322 	lda 	hueco					;a ahora tiene el valor de la posicion del hueco
   064F 4C            [ 2]  323 	inca							;a ahora vale el hueco +1
   0650 31 A6         [ 5]  324 	leay 	a,y						;y apunta a la derecha del espacio
   0652 E6 A4         [ 4]  325 	ldb 	,y						;guardamos en b lo que haya en la posicion y
   0654 F7 01 16      [ 5]  326 	stb 	variable_intercambio ;guardamos en una variable la letra a intercambiar
   0657 86 20         [ 2]  327 	lda 	#0x20					;espacio en ascii=#0x20
   0659 A7 A4         [ 4]  328 	sta 	,y						;ponemos en y un espacio
                            329 	
   065B 31 8D FA A1   [ 9]  330 	leay 	tablero,pcr 	
   065F B6 01 13      [ 5]  331 	lda 	hueco
   0662 31 A6         [ 5]  332 	leay 	a,y
   0664 F6 01 16      [ 5]  333 	ldb 	variable_intercambio
   0667 E7 A4         [ 4]  334 	stb 	,y
                            335 	
   0669 16 00 00      [ 5]  336 	lbra 	comprueba_final
                            337 
   066C                     338 comprueba_final:
                            339 									;ahora calculamos los aciertos
   066C C6 00         [ 2]  340 	ldb 	#0
   066E 86 41         [ 2]  341 	lda 	#'A
   0670 31 8D FA 8C   [ 9]  342 	leay 	tablero,pcr 	
   0674 17 00 54      [ 9]  343 	lbsr 	calculaAciertos
                            344 	
   0677 B6 01 11      [ 5]  345 	lda 	aciertos
   067A 81 0F         [ 2]  346 	cmpa 	#15 					;si aciertos = 15(16) ganaste
   067C 10 27 00 03   [ 6]  347 	lbeq 	finaliza
   0680 16 FE 8E      [ 5]  348 	lbra 	imprimimos_todo 		;sino vuelves a imprimir y pedir mov
                            349 	
   0683                     350 finaliza:
   0683 30 8D FD E5   [ 9]  351 	leax 	ganaste,pcr
   0687 17 F9 BC      [ 9]  352 	lbsr 	imprimir_cadena	
   068A 86 00         [ 2]  353 	lda		#0
   068C B7 01 11      [ 5]  354 	sta		aciertos
   068F B7 01 15      [ 5]  355 	sta		intentos
   0692 16 FE 04      [ 5]  356 	lbra 	programa
                            357 ;++++++++++++++++++++FIN JUGAR++++++++++++++++++++++++++++++++++
                            358 
ASxxxx Assembler V05.00  (Motorola 6809), page 10.
Hexidecimal [16-Bits]



                            359 
                            360 ;++++++++++++++++++++INSRUCCIONES+++++++++++++++++++++++++++++++
   0695                     361 instrucciones:
   0695 34 10         [ 6]  362 	pshs	x
   0697 30 8D FB 79   [ 9]  363 	leax	info,pcr
   069B 17 F9 A8      [ 9]  364 	lbsr	imprimir_cadena
   069E 35 10         [ 6]  365 	puls	x
   06A0 16 FD F6      [ 5]  366 	lbra 	programa
                            367 ;+++++++++++++++++++FIN INSTRUCCIONES+++++++++++++++++++++++++++
                            368 
                            369 
                            370 
                            371 
                            372 ;|=============================================================|
                            373 ;|+++++++++++++++++++++++SUBRUTINAS++++++++++++++++++++++++++++|
                            374 ;|=============================================================|
                            375 
                            376 
                            377 
                            378 ;+++++++++++++++++++Mensajes de error+++++++++++++++++++++++++++
   06A3                     379 error_opcion_menu:
   06A3 30 8D FC DB   [ 9]  380 	leax	opcion_incorrecta,pcr
   06A7 17 F9 9C      [ 9]  381 	lbsr	imprimir_cadena
   06AA 86 0A         [ 2]  382 	lda		#'\n
   06AC B7 FF 00      [ 5]  383 	sta		pantalla
   06AF 86 0A         [ 2]  384 	lda		#'\n
   06B1 B7 FF 00      [ 5]  385 	sta		pantalla
   06B4 16 FD E2      [ 5]  386 	lbra	programa
                            387 
   06B7                     388 error_opcion_menu_jugar:
   06B7 30 8D FC C7   [ 9]  389 	leax	opcion_incorrecta,pcr
   06BB 17 F9 88      [ 9]  390 	lbsr	imprimir_cadena
   06BE 86 0A         [ 2]  391 	lda		#'\n
   06C0 B7 FF 00      [ 5]  392 	sta		pantalla
   06C3 86 0A         [ 2]  393 	lda		#'\n
   06C5 B7 FF 00      [ 5]  394 	sta		pantalla
   06C8 16 FD FF      [ 5]  395 	lbra	jugar
                            396 ;+++++++++++++++++++Fin mensajes de error+++++++++++++++++++++++
                            397 
                            398 ;+++++++++++++++++++Calculo de aciertos+++++++++++++++++++++++++
   06CB                     399 calculaAciertos:
   06CB 81 4F         [ 2]  400 	cmpa 	#'O
   06CD 22 0C         [ 3]  401 	bhi 	calculaAciertos_salida
   06CF A1 A0         [ 6]  402 	cmpa 	,y+
   06D1 27 03         [ 3]  403 	beq 	incrementaAciertos
   06D3 4C            [ 2]  404 	inca
   06D4 20 F5         [ 3]  405 	bra 	calculaAciertos
                            406 
   06D6                     407 incrementaAciertos:
   06D6 4C            [ 2]  408 	inca	
   06D7 5C            [ 2]  409 	incb
   06D8 16 FF F0      [ 5]  410 	lbra 	calculaAciertos
                            411 
   06DB                     412 calculaAciertos_salida:
   06DB F7 01 11      [ 5]  413 	stb 	aciertos
ASxxxx Assembler V05.00  (Motorola 6809), page 11.
Hexidecimal [16-Bits]



   06DE 39            [ 5]  414 	rts
                            415 ;++++++++++++++++++Fin calculo de aciertos++++++++++++++++++++++
                            416 
                            417 ;+++++++++++++++++++Imprimir datos++++++++++++++++++++++++++++++
   06DF                     418 imprime_datos:
   06DF 30 8D FC 09   [ 9]  419 	leax	datos_intro,pcr
   06E3 17 F9 60      [ 9]  420 	lbsr	imprimir_cadena
   06E6 30 8D FC 35   [ 9]  421 	leax	datos_numPuzzle,pcr
   06EA 17 F9 59      [ 9]  422 	lbsr	imprimir_cadena
   06ED B6 01 18      [ 5]  423 	lda 	puzzle_numero
   06F0 B7 FF 00      [ 5]  424 	sta 	pantalla
   06F3 30 8D FC 3D   [ 9]  425 	leax	datos_numIntentos,pcr
   06F7 17 F9 4C      [ 9]  426 	lbsr	imprimir_cadena
                            427 
   06FA B6 01 15      [ 5]  428 	lda 	intentos
                            429 
   06FD 17 F9 01      [ 9]  430 	lbsr	imprimir_decimal
                            431 
   0700 30 8D FC 46   [ 9]  432 	leax	datos_numAciertos,pcr
   0704 17 F9 3F      [ 9]  433 	lbsr	imprimir_cadena
   0707 B6 01 11      [ 5]  434 	lda 	aciertos
                            435 	
   070A 17 F8 F4      [ 9]  436 	lbsr	imprimir_decimal
                            437 	
   070D 86 0A         [ 2]  438 	lda		#'\n
   070F B7 FF 00      [ 5]  439 	sta		pantalla
   0712 B7 FF 00      [ 5]  440 	sta		pantalla
                            441 	
   0715 39            [ 5]  442 	rts
                            443 ;+++++++++++++++++++Fin imprimir datos++++++++++++++++++++++++++
                            444 
                            445 ;+++++++++++++++++++Impresion de tablero++++++++++++++++++++++++
   0716                     446 imprime_tablero:
   0716 5C            [ 2]  447 	incb
                            448 
   0717 C1 05         [ 2]  449 	cmpb 	#5			;comparamos que hemos puesto los cuatro primeros valores de 						la fila 1 y al 5 ponemos salto de linea
   0719 10 27 00 23   [ 6]  450 	lbeq 	pon_salto
   071D C1 09         [ 2]  451 	cmpb 	#9			;comparamos que hemos puesto los cuatro segundos valores de 						la fila 2 y al 9 ponemos salto de linea
   071F 10 27 00 1D   [ 6]  452 	lbeq 	pon_salto
   0723 C1 0D         [ 2]  453 	cmpb 	#13			;comparamos que hemos puesto los cuatro terceros valores de 						la fila 3 y al 13 ponemos salto de linea
   0725 10 27 00 17   [ 6]  454 	lbeq 	pon_salto
   0729 C1 11         [ 2]  455 	cmpb 	#17			;comparamos que hemos puesto los cuatro cuartos valores de la 						fila 4 y al 17 ponemos salto de linea
   072B 10 27 00 11   [ 6]  456 	lbeq 	pon_salto
   072F                     457 yahasaltao:
   072F A6 80         [ 6]  458 	lda 	,x+
   0731 27 05         [ 3]  459 	beq 	imprime_tablero_salida
   0733 B7 FF 00      [ 5]  460 	sta		pantalla
   0736 20 DE         [ 3]  461 	bra		imprime_tablero
                            462 
   0738                     463 imprime_tablero_salida:
   0738 30 8D FC 36   [ 9]  464 	leax	final_tablero,pcr
   073C 17 F9 07      [ 9]  465 	lbsr	imprimir_cadena
   073F 39            [ 5]  466 	rts
                            467 	
   0740                     468 pon_salto:
ASxxxx Assembler V05.00  (Motorola 6809), page 12.
Hexidecimal [16-Bits]



   0740 34 02         [ 6]  469 	pshs 	a
   0742 86 7C         [ 2]  470 	lda		#'|
   0744 B7 FF 00      [ 5]  471 	sta 	pantalla		;accedemos a traves de imprime_tablero y nos encargamos de 						mostrar por pantalla el salto y el caracter |
   0747 86 0A         [ 2]  472 	lda 	#'\n		
   0749 B7 FF 00      [ 5]  473 	sta 	pantalla		;que nos indica el final de una fila del tablero
   074C 86 7C         [ 2]  474 	lda 	#'|
   074E B7 FF 00      [ 5]  475 	sta 	pantalla
   0751 35 02         [ 6]  476 	puls 	a
   0753 16 FF D9      [ 5]  477 	lbra 	yahasaltao		;saltamos a la direccion de memoria que nos indica yahasaltao
                            478 ;+++++++++++++++++++Fin de impresion de tablero+++++++++++++++++
                            479 
                            480 ;+++++++++++++++++++Buscar hueco++++++++++++++++++++++++++++++++
   0756                     481 buscarHueco:
   0756 A6 80         [ 6]  482 	lda 	,x+
   0758 27 0C         [ 3]  483 	beq 	buscarHueco_salida
   075A 81 20         [ 2]  484 	cmpa 	#32
   075C 27 03         [ 3]  485 	beq 	guardaPosicion
                            486 	
   075E 5C            [ 2]  487 	incb
   075F 20 F5         [ 3]  488 	bra 	buscarHueco
                            489 	
   0761                     490 guardaPosicion:
   0761 F7 01 13      [ 5]  491 	stb		hueco
   0764 20 00         [ 3]  492 	bra 	buscarHueco_salida
                            493 	
   0766                     494 buscarHueco_salida:
   0766 39            [ 5]  495 	rts
                            496 ;+++++++++++++++++++Fin buscar hueco++++++++++++++++++++++++++++	
                            497 
   0767                     498 salir:
   0767 4F            [ 2]  499 	clra
   0768 B7 FF 01      [ 5]  500 	sta		fin
                            501 
   FFFE                     502 	.org	0xFFFE
   FFFE 04 99               503 	.word	programa
ASxxxx Assembler V05.00  (Motorola 6809), page 13.
Hexidecimal [16-Bits]

Symbol Table

    .__.$$$.       =   2710 L   |     .__.ABS.       =   0000 G
    .__.CPU.       =   0000 L   |     .__.H$L.       =   0001 L
  2 aciertos           0111 R   |   2 bucle_carga_ta     0508 R
  2 buscarHueco        0756 R   |   2 buscarHueco_sa     0766 R
  2 calculaAcierto     06CB R   |   2 calculaAcierto     06DB R
  2 comienzo_table     0360 R   |   2 comprueba_abaj     057A R
  2 comprueba_arri     0562 R   |   2 comprueba_dere     059D R
  2 comprueba_fina     066C R   |   2 comprueba_izqu     0586 R
  2 datos_intro        02EC R   |   2 datos_numAcier     034A R
  2 datos_numInten     0334 R   |   2 datos_numPuzzl     031F R
  2 error_opcion_m     06A3 R   |   2 error_opcion_m     06B7 R
    fin            =   FF01     |   2 final_tablero      0372 R
  2 finaliza           0683 R   |   2 ganaste            046C R
  2 guardaPosicion     0761 R   |   2 hueco              0113 R
  2 imprime_datos      06DF R   |   2 imprime_tabler     0716 R
  2 imprime_tabler     0738 R   |   2 imprimimos_tod     0511 R
    imprimir_caden     **** GX  |     imprimir_decim     **** GX
  2 incrementaAcie     06D6 R   |   2 info               0214 R
  2 instrucciones      0695 R   |   2 instrucciones_     041B R
  2 intentos           0115 R   |   2 intercambia_ab     05EA R
  2 intercambia_ar     05BE R   |   2 intercambia_de     0641 R
  2 intercambia_iz     0616 R   |   2 jugar              04CA R
  2 menu               0199 R   |   2 menu_jugar         03EE R
  2 movInviable        03BD R   |   2 movimientoInvi     05B4 R
  2 opcion_incorre     0382 R   |     pantalla       =   FF00 
  2 pon_salto          0740 R   |   2 programa           0499 GR
  2 puzzle_lista       0119 R   |   2 puzzle_numero      0118 R
  2 puzzle_tamano      0117 R   |   2 salir              0767 R
  2 tablero            0100 R   |   2 teclaErronea       0435 R
    teclado        =   FF02     |   2 variable           0114 R
  2 variable_inter     0116 R   |   2 yahasaltao         072F R

ASxxxx Assembler V05.00  (Motorola 6809), page 14.
Hexidecimal [16-Bits]

Area Table

[_CSEG]
   0 _CODE            size    0   flags C080
   2 CODE1            size    0   flags  908
[_DSEG]
   1 _DATA            size    0   flags C0C0

