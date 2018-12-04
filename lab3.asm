# Sunny Kalsi
# Lab 2
# result value stored in t1
# negative flag stored in t2
# negative sign comparison stored in t4
# zero comparison stored in t5
# new line comparison stored in t6
# number 9 stored in t8, this will be used to check if a number is greater then 9
# number 10 stored in t9, this will be used to multiple the total before adding the new value.
# t3 is used to store answers of subtraction commands

	.data
start:	.asciiz	"\n Enter your number: "
errorp:	.asciiz "\n You entered an invalid value. Ending program. "
value:	.asciiz "\n Your value is: "
end:	.asciiz "\n*****end of program*****"

 	.globl main
 	.text
 
 main:
 	li	$t1, 0		#load with 0 because this will be our total sum
 	li	$t2, 0		#load t4 with 0 to set the negative 
 	li	$t4, 45		#load t4 with 45 for "-" negative sign
 	li	$t5, 48		#load t5 with 48 for "0" zero
 	li	$t6, 10		#load t6 with "\n"
 	li	$t8, 9		#set t5 as 9 to compare to later
 	li 	$t9, 10		#set t4 as 10 to multiple with it later
 	
 	
 	li	$v0, 4		#System call code for print string
 	la	$a0, start	#load address of start in $a0
 	syscall
 	
 read:	
 	li	$v0, 12		#system call code to read character
 	syscall
 	move 	$t0, $v0	#Move character read to t0
 	
 	
 	bnez	$t1, enter	#branch if $t7 is empty
 	sub	$t3, $t0, $t4	#check to see if the char is "-"
 	beqz	$t3, negative	#skip to negative if 
enter: 	
 	sub	$t3, $t0, $t6	#check if the char is a enter
 	beqz	$t3, print	#skip to print if the char is enter	
 	
 	b	positive	#branch to positive if it's not enter
 	
 negative:			#skips here if the first char read was "-"
 	
 	li	$t2, 1		#sets the negative flag to 1 if answer is negative
 	b	read		#goes back to read for the next character
 
 positive:
 	
 	sub	$t3, $t0, $t5	#subtract your char by "0" and store in t3
 	bltz	$t3, error	#jump out if the char is less then 0
 	bgt	$t3, $t8, error	#jump out if the char is greater then 9
 	
 	mult	$t9, $t1	#multiply whatever your current answer in t7 by 10
 	mflo	$t1		#save answer back in t7
 	add	$t1, $t1, $t3	#add your char to t7 and save it back in t7
 	
 	
 	
 	b	read		#skip to re-read the input character
 	
 print:
 	
 	beqz	$t2, skip	#jump to skip if the negative flag is 0
	sub	$t1, $0, $t1	#make the answer negative if t2 is equal to 1
 	
 skip: 				#remaining print method that doesn't make everything negative
 
 	li	$v0, 4		#system call code to print string
 	la	$a0, value	#load address of string to print in value
 	syscall			#print string
 	
 	li	$v0, 1		#System call code to print int
 	la	$a0, ($t1)	#load answer into #a0
 	syscall			#read answer
 	
 	b	ending		#skip to ending
 	
 	
 error:				#jumps to here if the char is invalid.
 	li	$v0, 4		#system code to print string
 	la	$a0, errorp	#load address for errorp
 	syscall			#print string
 	
 ending:			
 	li	$v0, 4		#System call code to print string
 	la	$a0, end	#load address for end
 	syscall			#print string
