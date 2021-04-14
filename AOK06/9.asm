.data

.text
	addi $s1, $s1,9
	addi $s2, $s2, 11
	slt $t1, $s1, $s2
	beq $t1, $zero, ednakvi
		add $s3, $s2, $zero
		j end
	ednakvi:
		add $s3, $s1, $zero
	end:	
