.data
	Array: .space 80				#alociranje na 80 bajti za cuvanje na 20 broja (int = 4 bajta)
.text
	li $v0,5					#syscall za vnesnuvanje na integer bara $v0 = 5
	syscall						#syscall za vnesuvanje integer (adresa za chuvanje na proizvod)
	add $s0,$v0,$zero				#promenliva za adresata na koja kje bide smesten proizvodot
	
	li $v0,5					#syscall za vnesnuvanje na integer bara $v0 = 5
	syscall						#syscall za vnesuvanje integer
	add $s1,$v0,$zero				#promenliva za golemina na niza
		
	li $t0,0					#brojac za pozicija vo niza
	loop: 	beq $t0,$s1,end				#proverka dali $t0 == $s1, dokolku se ednakvi skoka do end, vo sprotivno izvrshuva nareden red		
		sll $t1,$t0, 2				#brojac*4 za da dobieme offset
		li $v0,5				#syscall za vnesnuvanje na integer bara $v0 = 5
		syscall					#syscall za vnesuvanje na integer
		sw $v0,Array($t1)			#zachuvuvanje na vneseniot element preku syscall vo nizata(Array) na pozicija $t1
		addi $t0,$t0,1				#zgolemuvanje na brojachot za 1
		j loop					#nazad vo loop
	end:	
		add $a0, $s1, $zero			#podesuvanje na argumenti za funkcijata
		jal proizvodNeparni			#povikuvanje na procedura	
		sw $v0, ($s0)				#zachuvaj go rezultatot od mnozhenjeto na site neparni broevi vo memoriska lokacija $s0
		
		la $a0,($v0)				#zapishuvanje na adresata na rezultatot od mnozhenjeto na site neparni broevi vo $a0 koja kje bide iskoristena od syscall
		li $v0, 1				#syscall za pechatenje na integer bara $v0 = 5
		syscall					#pechatenje na rezultatot od mnozhenje na site neparni broevi
		add $s3, $zero, $t6			#zachuvuvanje na rezultatot vo $s3
		
	#resetiranje na site t registri koi se iskoristeni pri reshavanje	
	li $t0,0
	li $t1,0
	li $t2,0
	li $t3,0
	li $t4,0
	li $t5,0
	li $t6,0
	
	li $v0,10					#syscall za zavrshuvanje na programa bara $v0 = 10
	syscall						#kraj na programa

	proizvodNeparni:
		#$a0 - broj na elementi vo nizata
		li $t0,0				#setiranje na $t0 na 0
		li $t2,0				#seturanje na $t1 na 0
		li $t3,0				#seturanje na $t1 na 0
		li $t4,2				#setiranje na $t4 na 2 za da mozheme da delime so 2
		li $t5,0				#setiranje na $t5 na 0 
		li $t6,1				#setiranje na $t6 na 1 za vo sluchaj da nema neparni elementi da se ispechati 1
		loop2:	beq $t0,$a0,end2		#uslov
			sll $t2, $t0, 2			#dobivanje na offset
			lw $t3,Array($t2)		#dobivanje na i-ti element od niza Array
			div $t3, $t4			#delenje na i-tiot element od nizata so 2
			mfhi $t5			#vadenje na ostatokot od delenjeto
			beq $t5, $zero, nemaOstatok	#a ostatokot e 0 togas brojot e paren(ripni do nemaOstatok), a vo sluchaj ostatokot da e razlichen od 0 togash brojot e neparen(prodolzhi so izvrshuvanje na naredna linija).
				mult $t6, $t3		#mnozhenje na stariot proizvod so neparniot broj
				mflo $t6		#vadenje na rezultatot od mnozhenjeto od LO register (kje ima problem dokolku brojot zafakja povekje od 32 bita) 
			nemaOstatok: 
			addi $t0, $t0, 1		#zgolemuvanje na brojachot za 1
			j loop2				#vrati se do loop2
		end2:
		add $v0,$t6,$zero			#vrati kako rezultat od procedura $t6 (odnosno rezultat od mnozhenje)
		jr $ra					#vrati se vo glavna programa
		
		
		
		
		
		
		
