.data 
.text 
	li $s3, 0
	#pochetnata adresa na nizata e smestena vo $s6 
	jamka:
		beq $s3,20,end		#proverka na uslov
		sll $t1, $s3, 2		#mnozhenje na i za 4 so cel da dobieme offset koj kje go koristime za da pristapime do a[i]
		add $t1, $s6, $t1	#offset-ot go dodavame na a[0] so shto dobivame a[i]
		lw $t2, 8($t1)		#od memorijata a[i+2] go zachuvuvame vo $t2
		addi $t2, $t2, 100	#na $t2 mu dodavame 100
		sw $t2, ($t1)		#go zachuvuvame $t2 vo memorija na pozicija a[i]
		addi $s3, $s3, 1	# go zgolemuvame brojacot za eden
		j jamka
	end:
	#kraj na zadachata
