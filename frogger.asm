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
 # - Milestone 2
 
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
	displayAddress: .word 0x10008000
	
	frogX:		.word 24
	frogY:  	.word 28
	
	logsInitial:      .word 644
			
	TurtlesInitial:   .word 1416
			 
	CarsInitial:      .word 2424
	
	log1Initial:    .word 644, 648, 652, 656, 660, 664, 680, 684, 688, 692, 696, 700, 
			      772, 776, 780, 784, 788, 792, 808, 812, 816, 820, 824, 828
			     
	log2Initial:    .word 1044, 1048, 1052, 1056, 1076, 1080, 1084, 1088,
			      1172, 1176, 1180, 1184, 1204, 1208, 1212, 1216
			     
	TurInitial:    .word 1416, 1420, 1424, 1428, 1432, 1436, 1476, 1480, 1484, 1488, 1492, 1496, 
			      1544, 1548, 1552, 1556, 1560, 1564, 1604, 1608, 1612, 1616, 1620, 1624
			      
	car1Initial:    .word 2308, 2312, 2316, 2320, 2324, 2328, 2344, 2348, 2352, 2356, 2360, 2364,
			      2436, 2440, 2444, 2448, 2452, 2456, 2472, 2476, 2480, 2484, 2488, 2492
			      
	car2Initial:    .word 2708, 2712, 2716, 2720, 2724, 2728, 2740, 2744, 2748, 2752, 2756, 2760
			      2836, 2840, 2844, 2848, 2852, 2856, 2868, 2872, 2876, 2880, 2884, 2888
			      
	car3Initial:    .word 3080, 3084, 3088, 3092, 3096, 3100, 
			      3208, 3212, 3216, 3220, 3224, 3228
			      
	frogInitial:    .word 3508


	
.text
	lw $t0, displayAddress
	li $t1, 0xab0000 #$t1 stores the red turtles
	li $t2, 0x604000 #$t2 stores the color of the brown wood
	li $t3, 0x5ecfe4 #$t3 stores the blue colour code
	li $t4, 0x16537e # store the color of the blue safe area
	li $t5, 0xffce3b # store the color of the frog
	li $t6, 0x66aa33 # store the color of the green top area
	li $t7, 0x000000 # store the color of black
	
# main block
main:

	jal drawStaticBg
	jal initLog1Var
	jal initLog2Var
	jal initTurtleVar
	jal initCar1Var
	jal initCar2Var
	jal initCar3Var
	
	jal drawFrog
	
	j startCycle
	
	
startCycle:
	add $t8, $zero, $zero
	lw $t8, 0xffff0000
	beq $t8, 1, keyboardInput
	
	j refresh

######################## Check keyboard inputs.    ######################################

keyboardInput:

	lw $k0, 0xffff0004
	
	beq $k0, 0x77, respond_to_W
	beq $k0, 0x61, respond_to_A
	beq $k0, 0x73, respond_to_S
	beq $k0, 0x64, respond_to_D
	
respond_to_W:

	jal moveUp
	j refresh
	
respond_to_A:

	jal moveLeft
	j refresh
	
respond_to_S:
	
	jal moveDown
	j refresh
	
respond_to_D:
	
	jal moveRight
	j refresh
	
	
# move up the frog	
moveUp:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	
stMoveUp:
	beq $s0, 4, initJump18
	lw $s1, frogInitial($s0)
	addi $s1, $s1, -384
	sw $s1, frogInitial($s0)
	addi $s0, $s0, 4
	j stMoveUp
	
initJump18:
	jr $ra


# move left the frog
moveLeft:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	
stMoveLeft:
	beq $s0, 4, initJump19
	lw $s1, frogInitial($s0)
	addi $s1, $s1, -4
	sw $s1, frogInitial($s0)
	addi $s0, $s0, 4
	j stMoveLeft
	
initJump19:
	jr $ra
	
# move the frog down	
moveDown:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	
stMoveDown:
	beq $s0, 4, initJump20
	lw $s1, frogInitial($s0)
	addi $s1, $s1, 384
	sw $s1, frogInitial($s0)
	addi $s0, $s0, 4
	j stMoveDown
	
initJump20:
	jr $ra
	
	
moveRight:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	
stMoveRight:
	beq $s0, 4, initJump21
	lw $s1, frogInitial($s0)
	addi $s1, $s1, 4
	sw $s1, frogInitial($s0)
	addi $s0, $s0, 4
	j stMoveRight
	
initJump21:
	jr $ra
	


######################## Check keyboard inputs end.######################################	

######################## Collision detect. ################################################


######################## Collision detect ends. ###########################################


####################### Refresh the screen. ###################################################
refresh:
	jal drawStaticBg
	jal initLog1ShiftRight
	jal initLog2ShiftLeft
	jal initTurShiftRight
	
	jal initCar1ShiftLeft
	jal initCar2ShiftRight
	jal initCar3ShiftLeft
	
	# paint
	jal initLog1Var
	jal initLog2Var
	jal initTurtleVar
	
	jal initCar1Var
	jal initCar2Var
	jal initCar3Var
	
	jal drawFrog
	
	li $v0, 32
	la $a0, 1000
	syscall		# Sleep
	

	j startCycle
	
	
####################### Refresh block ends. ###################################################


######################## Draw the static background.######################################
######################## This block is finished.    ######################################	
drawStaticBg:
	addi $sp, $sp, -4
	sw $ra, 0($sp)
	
	jal initWaterVar # draw the water region
	jal initVar      # draw the top green area
	jal paintTopRest # draw the top rest area
	jal initVar1     # draw the blue area in the middle
	jal initRoad	 # draw the road area
	jal initVar2     # draw the safe area on the bottom
	jal printLife    # draw the lifes on the bottom
	
	lw $ra, 0($sp)
	addi $sp, $sp, 4
	
	jr $ra
	
	
# print the water area
initWaterVar:
	add $v0, $zero, $zero
	addi $v1, $zero, 1792
	add $a0, $t0, $zero
	
stDrawWater:
	beq $v0, $v1, initJump1
	sw $t3, 0($a0)

	
upDrawWater:
	addi $v0, $v0, 4
	addi $a0, $a0, 4
	j stDrawWater
	
initJump1:
	jr $ra


# $s0: iterator, from t0 to 127
# $s1: +4 every iteration
# $t9: constant 128

initVar:
	add $s0, $t0, $zero
	add $s1, $zero, $zero
	addi $t9, $zero, 128
	
	# paint the first pixel
	
stDrawTop: # the start label to draw the top area	
	beq $s1, $t9, initJump2
	sw $t6, 0($s0) # paint the first row green
	

	
upDrawRTop: # update variable of drawing the top area
	addi $s0, $s0, 4
	addi $s1, $s1, 4
	j stDrawTop
	
initJump2:
	jr $ra
	
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
	
	jr $ra
	
	
# print the blue safe area in the middle
initVar1: 
	add $s2, $zero, $zero
	addi $s3, $zero, 384
	addi $s4, $t0, 1792

stPrintSafeMiddle:
	beq $s2, $s3, initJump3
	sw $t4, 0($s4)
		
	
upPrintSafeMiddle:
	addi $s2, $s2, 4
	addi $s4, $s4, 4
	j stPrintSafeMiddle
	
initJump3:
	jr $ra
	
	
	
# paint the black road area
initRoad: 
	add $s2, $zero, $zero
	addi $s3, $zero, 1280
	addi $s4, $t0, 2176

stPrintRoad:
	beq $s2, $s3, initJump17
	sw $t7, 0($s4)
		
	
upPrintRoad:
	addi $s2, $s2, 4
	addi $s4, $s4, 4
	j stPrintRoad
	
initJump17:
	jr $ra
	
# print the safe area on the bottom
initVar2: 
	add $s5, $zero, $zero
	addi $s6, $zero, 384
	add $s7, $t0, 3456

stPrintSafeBot:
	beq $s5, $s6, initJump4
	sw $t4, 0($s7)

	
upPrintSafeBot:
	addi $s5, $s5, 4
	addi $s7, $s7, 4
	j stPrintSafeBot
	
initJump4:
	jr $ra
	
	
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
	
	jr $ra
	
######################## Draw the static background ends.######################################
	

################################ shift right ##################################################
initLog1ShiftRight:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	
stLog1ShiftRight:	
	beq $s0, 96, initJump8		
	lw $s1, log1Initial($s0)

	rem $s2, $s1, 128
	beq $s2, 124, log1wrapToLeft
	
	
	addi $s1, $s1, 4
	
	sw $s1, log1Initial($s0)
	
	addi $s0, $s0, 4
	
	j stLog1ShiftRight
	
log1wrapToLeft:
	addi $s1, $s1, -124
	
	sw $s1, log1Initial($s0)
	
	addi $s0, $s0, 4
	
	j stLog1ShiftRight

initJump8:
	jr $ra
	
	
	
	
# shift the turtles to the right
initTurShiftRight:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	
stTurShiftRight:	
	beq $s0, 96, initJump10		
	lw $s1, TurInitial($s0)

	rem $s2, $s1, 128
	beq $s2, 124, TurWrapToLeft
	
	
	addi $s1, $s1, 4
	
	sw $s1, TurInitial($s0)
	
	addi $s0, $s0, 4
	
	j stTurShiftRight
	
TurWrapToLeft:
	addi $s1, $s1, -124
	
	sw $s1, TurInitial($s0)
	
	addi $s0, $s0, 4
	
	j stTurShiftRight

initJump10:
	jr $ra
	
	
	
# shift car2 to the right
initCar2ShiftRight:
	add $s0, $zero, $zero
	add $s1, $zero, $zero
	add $s2, $zero, $zero
	
stCar2ShiftRight:	
	beq $s0, 96, initJump15		
	lw $s1, car2Initial($s0)

	rem $s2, $s1, 128
	beq $s2, 124, Car2WrapToLeft
	
	
	addi $s1, $s1, 4
	
	sw $s1, car2Initial($s0)
	
	addi $s0, $s0, 4
	
	j stCar2ShiftRight
	
Car2WrapToLeft:
	addi $s1, $s1, -124
	
	sw $s1, car2Initial($s0)
	
	addi $s0, $s0, 4
	
	j stCar2ShiftRight

initJump15:
	jr $ra
	
	



################################ shift right ends #############################################




############################### shift left ####################################################
initLog2ShiftLeft:
	add $s3, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
	
stLog2ShiftLeft:
	beq $s3, 64, initJump9
	lw $s4, log2Initial($s3)

	rem $s5, $s4, 128
	beq $s5, 0, log2wrapToRight
	
	
	addi $s4, $s4, -4
	
	sw $s4, log2Initial($s3)
	
	addi $s3, $s3, 4
	j stLog2ShiftLeft
	
log2wrapToRight:
	addi $s4, $s4, 124
	
	sw $s4, log2Initial($s3)
	
	addi $s3, $s3, 4
	
	j stLog2ShiftLeft

initJump9:
	jr $ra
	
	
# shift car1 to the left	
initCar1ShiftLeft:
	add $s3, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
	
stCar1ShiftLeft:
	beq $s3, 96, initJump14
	lw $s4, car1Initial($s3)

	rem $s5, $s4, 128
	beq $s5, 0, car1wrapToRight
	
	
	addi $s4, $s4, -4
	
	sw $s4, car1Initial($s3)
	
	addi $s3, $s3, 4
	j stCar1ShiftLeft
	
car1wrapToRight:
	addi $s4, $s4, 124
	
	sw $s4, car1Initial($s3)
	
	addi $s3, $s3, 4
	
	j stCar1ShiftLeft

initJump14:
	jr $ra
	
	
# shift car3 to the left	
initCar3ShiftLeft:
	add $s3, $zero, $zero
	add $s4, $zero, $zero
	add $s5, $zero, $zero
	
stCar3ShiftLeft:
	beq $s3, 48, initJump16
	lw $s4, car3Initial($s3)

	rem $s5, $s4, 128
	beq $s5, 0, car3wrapToRight
	
	
	addi $s4, $s4, -4
	
	sw $s4, car3Initial($s3)
	
	addi $s3, $s3, 4
	j stCar3ShiftLeft
	
car3wrapToRight:
	addi $s4, $s4, 124
	
	sw $s4, car3Initial($s3)
	
	addi $s3, $s3, 4
	
	j stCar3ShiftLeft

initJump16:
	jr $ra






############################### shift left ends ###############################################



######################## Draw the logs.                  ######################################
drawLogs:
initLog1Var:
	add $s0, $zero, $zero
	
stPaintLog1:
	beq $s0, 96, initJump5
	lw $s1, log1Initial($s0)
	add $s1, $s1, $t0
	sw $t2, 0($s1)
	addi $s0, $s0, 4
	
	j stPaintLog1
	
initJump5:
	jr $ra
	

initLog2Var:
	add $s0, $zero, $zero
	
stPaintLog2:
	beq $s0, 64, initJump6
	lw $s1, log2Initial($s0)
	add $s1, $s1, $t0
	sw $t2, 0($s1)
	addi $s0, $s0, 4
	
	j stPaintLog2
	
initJump6:
	jr $ra

######################## Draw the logs ends.             ######################################



######################## Draw the Turtle.                  ######################################
initTurtleVar:
	add $s0, $zero, $zero
	
stPaintTurtle:
	beq $s0, 96, initJump7
	lw $s1, TurInitial($s0)
	add $s1, $s1, $t0
	sw $t1, 0($s1)
	addi $s0, $s0, 4
	
	j stPaintTurtle
	
initJump7:
	jr $ra

######################## Draw the turtles ends.             ######################################

######################## Draw the cars.                  ######################################
# paint the first row of cars
initCar1Var:
	add $s0, $zero, $zero
	
stPaintCar1:
	beq $s0, 96, initJump11
	lw $s1, car1Initial($s0)
	add $s1, $s1, $t0
	sw $t2, 0($s1)
	addi $s0, $s0, 4
	
	j stPaintCar1
	
initJump11:
	jr $ra
	
# the second row of cars	
initCar2Var:
	add $s0, $zero, $zero
	
stPaintCar2:
	beq $s0, 96, initJump12
	lw $s1, car2Initial($s0)
	add $s1, $s1, $t0
	sw $t2, 0($s1)
	addi $s0, $s0, 4
	
	j stPaintCar2
	
initJump12:
	jr $ra
	
	
# the third row of cars	
initCar3Var:
	add $s0, $zero, $zero
	
stPaintCar3:
	beq $s0, 48, initJump13
	lw $s1, car3Initial($s0)
	add $s1, $s1, $t0
	sw $t1, 0($s1)
	addi $s0, $s0, 4
	
	j stPaintCar3
	
initJump13:
	jr $ra

######################## Draw the cars ends.             ######################################

######################## Draw the frog.                  ######################################

drawFrog:
	add $s0, $zero, $zero
	lw $s1, frogInitial($s0)
	add $s1, $s1, $t0
	sw $t5, 0($s1)
	jr $ra
	
######################## Draw the frog ends.             ######################################


Exit:
	li $v0, 10
	syscall
