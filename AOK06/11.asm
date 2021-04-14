.data 
.text 
	#pochetok na niza: $s0
	#brojot na elementi: $s1
	add $t1, $s1, $zero	#brojac na elementi setiran na 0
	add $t2, $t2, $zero	#suma setirana na 0
	li $t5, 3
	jamka: 
		beq $t1, $s1, end		#uslov
		sll $t3, $t1, 2			#dobivanje na offset
		add $a0, $a0, $t3		#dodavanje na offset-ot na pochetnata adresa na niza
		lw $t4, 0($a0)			# $t4 - broj shto e naogja na i-ta pozicija vo ramki na niza
		div $t4, $t5			#delenje na brojot shto se naogja na i-ta pozicija so 3
		mfhi $t6			#dobivanje na ostatok pri deletenje od HI register
		bne $t6, $zero, tocno		#dali ostatokot pri delenje na a[i] so 3 e 0
			add $t2,$t2,$t4		#ako e nula da se izvrshi ova
		tocno: 				#ako ne e nula skokni tuka
		addi $t1, $t1, 1		#zgolemi brojac za 1
		j jamka				#bezusloven jump do pochetok na jamka
	end:
	sw $t2,0($s1)				#zachuvaj $t2 na memoriska lokacija $s1
	
