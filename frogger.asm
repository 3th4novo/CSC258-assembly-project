#####################################################################
 # CSC258H5S Fall 2021 Assembly Final Project
 # University of Toronto, St. George
 
 # Student: Yiteng Zhang, Student Number: 1006762077
 
 # Bitmap Display Configuration:
 # - Unit width in pixels: 8
 # - Unit height in pixels: 8
 # - Display width in pixels: 256
 # - Display height in pixels: 256
 # - Base Address for Display: 0x10008000 ($gp)
 # Which milestone is reached in this submission?
 # (See the assignment handout for descriptions of the milestones)
 # - Milestone 1
 # Which approved additional features have been implemented?
 # (See the assignment handout for the list of additional features)
 # 1. (fill in the feature, if any)
 # 2. (fill in the feature, if any)
 # 3. (fill in the feature, if any)
 # ... (add more if necessary)
 # Any additional information that the TA needs to know:
 # - (write here, if any)
 
 
# Demo for painting
#
# Bitmap Display Configuration:
# - Unit width in pixels: 8
# - Unit height in pixels: 8
# - Display width in pixels: 256
# - Display height in pixels: 256
# - Base Address for Display: 0x10008000 ($gp)
#
.data
	displayAddress:	   .word 0x10008000
	frogX:		   .word 
	frogY:		   .word 
	
.text
	lw $t0, displayAddress # $t0 stores the base address for display
	li $t1, 0xab0000 #$t1 stores the red turtles
	li $t2, 0x604000 #$t2 stores the color of the brown wood
	li $t3, 0x5ecfe4 #$t3 stores the blue colour code
	li $t4, 0x16537e # store the color of the blue safe area
	li $t5, 0xffce3b # store the color of the frog
	li $t6, 0x66aa33 # store the color of the green top area
	li $t7, 0xf1c232 # store the color of frogs on the bottom


# print the water area
initWaterVar:
	add $v0, $zero, $zero
	addi $v1, $zero, 1792
	add $a0, $t0, $zero
	
stDrawWater:
	beq $v0, $v1, initVar
	sw $t3, 0($a0)
	
upDrawWater:
	addi $v0, $v0, 4
	addi $a0, $a0, 4
	j stDrawWater


# $s0: iterator, from t0 to 127
# $s1: +4 every iteration
# $t9: constant 128

initVar:
	add $s0, $t0, $zero
	add $s1, $s1, $zero
	addi $t9, $zero, 128
	
	# paint the first pixel
	
stDrawTop: # the start label to draw the top area	
	beq $s1, $t9, paintTopRest
	sw $t6, 0($s0) # paint the first row green
	
upDrawRTop: # update variable of drawing the top area
	addi $s0, $s0, 4
	addi $s1, $s1, 4
	j stDrawTop
	
paintTopRest: # paint the rest pixels of the top green area
	# 1
	sw $t6, 128($t0)
	sw $t6, 256($t0)
	sw $t6, 384($t0)
	sw $t6, 132($t0)
	sw $t6, 260($t0)
	sw $t6, 388($t0)
	#2
	sw $t6, 152($t0)
	sw $t6, 280($t0)
	sw $t6, 408($t0)
	sw $t6, 156($t0)
	sw $t6, 284($t0)
	sw $t6, 412($t0)
	#3
	sw $t6, 176($t0)
	sw $t6, 304($t0)
	sw $t6, 432($t0)
	sw $t6, 180($t0)
	sw $t6, 308($t0)
	sw $t6, 436($t0)
	#4
	sw $t6, 200($t0)
	sw $t6, 328($t0)
	sw $t6, 456($t0)
	sw $t6, 204($t0)
	sw $t6, 332($t0)
	sw $t6, 460($t0)
	#5
	sw $t6, 224($t0)
	sw $t6, 352($t0)
	sw $t6, 480($t0)
	sw $t6, 228($t0)
	sw $t6, 356($t0)
	sw $t6, 484($t0)
	#6
	sw $t6, 248($t0)
	sw $t6, 376($t0)
	sw $t6, 504($t0)
	sw $t6, 252($t0)
	sw $t6, 380($t0)
	sw $t6, 508($t0)
	
	j initVar1
	
	
	
# print the blue safe area in the middle
initVar1: 
	add $s2, $s2, $zero
	addi $s3, $s3, 384
	addi $s4, $t0, 1792

stPrintSafeMiddle:
	beq $s2, $s3, initVar2
	sw $t4, 0($s4)
	
upPrintSafeMiddle:
	addi $s2, $s2, 4
	addi $s4, $s4, 4
	j stPrintSafeMiddle
	
# print the safe area on the bottom
initVar2: 
	add $s5, $s5, $zero
	addi $s6, $s6, 384
	add $s7, $t0, 3456

stPrintSafeBot:
	beq $s5, $s6, initLongLog1Var
	sw $t4, 0($s7)
	
upPrintSafeBot:
	addi $s5, $s5, 4
	addi $s7, $s7, 4
	j stPrintSafeBot
	
	
	
# below are the moving parts


	
# print the first long log on the first row	
initLongLog1Var:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	addi $s1, $zero, 24
	addi $s2, $t0, 644
			
stPrintLongLog1:
	beq $s0, $s1, initLongLog2Var
	sw $t2, 0($s2)
	sw $t2, 128($s2)
	
upPrintLongLog1:
	addi $s0, $s0, 4
	addi $s2, $s2, 4
	j stPrintLongLog1
	
# print the second long log on the first row	
initLongLog2Var:
	add $s3, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
	addi $s4, $zero, 24
	add $s5, $t0, 680
			
stPrintLongLog2:
	beq $s3, $s4, initShortLog1Var
	sw $t2, 0($s5)
	sw $t2, 128($s5)
	
upPrintLongLog2:
	addi $s3, $s3, 4
	addi $s5, $s5, 4
	j stPrintLongLog2




			

# print the second log row	
# print the first short log on the second row	
initShortLog1Var:
	add $s6, $zero, $zero
	add $s7, $zero, $zero
	add $t8, $zero, $zero
	addi $s7, $zero, 16
	addi $t8, $t0, 1044
			
stPrintShortLog1:
	beq $s6, $s7, initShortLog2Var
	sw $t2, 0($t8)
	sw $t2, 128($t8)
	
upPrintShortLog1:
	addi $s6, $s6, 4
	addi $t8, $t8, 4
	j stPrintShortLog1
	
# print the second short log on the second row	
initShortLog2Var:
	add $v0, $zero, $zero
	add $v1, $zero, $zero
	add $a0, $zero, $zero
	addi $v1, $zero, 16
	add $a0, $t0, 1076
			
stPrintShortLog2:
	beq $v0, $v1, initTurtle1Var
	sw $t2, 0($a0)
	sw $t2, 128($a0)
	
upPrintShortLog2:
	addi $v0, $v0, 4
	addi $a0, $a0, 4
	j stPrintShortLog2
	

	
		
				
	
# print the turtle in the water
# print the first turtle on the third row	
initTurtle1Var:
	add $a1, $zero, $zero
	add $a2, $zero, $zero
	add $a3, $zero, $zero
	addi $a2, $zero, 24
	addi $a3, $t0, 1416
			
stPrintTurtle1:
	beq $a1, $a2, initTurtle2Var
	sw $t1, 0($a3)
	sw $t1, 128($a3)
	
upPrintTurtle1:
	addi $a1, $a1, 4
	addi $a3, $a3, 4
	j stPrintTurtle1
	
# print the second turtle on the third row	
initTurtle2Var:
	add $v0, $zero, $zero
	add $v1, $zero, $zero
	add $a0, $zero, $zero
	addi $v1, $zero, 24
	add $a0, $t0, 1476
			
stPrintTurtle2:
	beq $v0, $v1, initLargeCar1Var
	sw $t1, 0($a0)
	sw $t1, 128($a0)
	
upPrintTurtle2:
	addi $v0, $v0, 4
	addi $a0, $a0, 4
	j stPrintTurtle2



# print the large car row
# print the first large car
initLargeCar1Var:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	addi $s1, $zero, 24
	addi $s2, $t0, 2308
			
stPrintLarge1Car:
	beq $s0, $s1, initLargeCar2Var
	sw $t2, 0($s2)
	sw $t2, 128($s2)
	
upPrintLarge1Car:
	addi $s0, $s0, 4
	addi $s2, $s2, 4
	j stPrintLarge1Car

# print the second large car
initLargeCar2Var:
	add $s3, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
	addi $s4, $zero, 24
	add $s5, $t0, 2344
			
stPrintLargeCar2:
	beq $s3, $s4, initMiddleCar1Var
	sw $t2, 0($s5)
	sw $t2, 128($s5)
	
upPrintLargeCar2:
	addi $s3, $s3, 4
	addi $s5, $s5, 4
	j stPrintLargeCar2






# print the middle car row
# print the first middle car
initMiddleCar1Var:
	add $s6, $zero, $zero
	add $s7, $zero, $zero
	add $t8, $zero, $zero
	addi $s7, $zero, 16
	addi $t8, $t0, 2708
			
stPrintMiddleCar1:
	beq $s6, $s7, initMiddleCar2Var
	sw $t2, 0($t8)
	sw $t2, 128($t8)
	
upPrintMiddleCar1:
	addi $s6, $s6, 4
	addi $t8, $t8, 4
	j stPrintMiddleCar1
	
# print the second middle car
initMiddleCar2Var:
	add $v0, $zero, $zero
	add $v1, $zero, $zero
	add $a0, $zero, $zero
	addi $v1, $zero, 16
	add $a0, $t0, 2740
			
stPrintMiddleCar2:
	beq $v0, $v1, initSmallCarVar
	sw $t2, 0($a0)
	sw $t2, 128($a0)
	
upPrintMiddleCar2:
	addi $v0, $v0, 4
	addi $a0, $a0, 4
	j stPrintMiddleCar2

# print the small car row
initSmallCarVar:
	add $a1, $zero, $zero
	add $a2, $zero, $zero
	add $a3, $zero, $zero
	addi $a2, $zero, 24
	addi $a3, $t0, 3080
			
stPrintSmallCar:
	beq $a1, $a2, printFrog
	sw $t1, 0($a3)
	sw $t1, 128($a3)
	
upPrintSmallCar:
	addi $a1, $a1, 4
	addi $a3, $a3, 4
	j stPrintSmallCar








# print the frog
printFrog:
	sw $t5, 3636($t0)
	sw $t5, 3640($t0)
	sw $t5, 3764($t0)
	sw $t5, 3768($t0)
	

# print the number of lives on the bottom
printLife:
	sw $t5, 3840($t0)
	sw $t5, 3844($t0)
	sw $t5, 3968($t0)
	sw $t5, 3972($t0)
	
	sw $t5, 3852($t0)
	sw $t5, 3856($t0)
	sw $t5, 3980($t0)
	sw $t5, 3984($t0)
	
	sw $t5, 3864($t0)
	sw $t5, 3868($t0)
	sw $t5, 3992($t0)
	sw $t5, 3996($t0)	

returnToTop:
	li $v0, 32
	li $a0, 17
	syscall
		
Exit:
	li $v0, 10 # terminate the program gracefully
	syscall 
 
