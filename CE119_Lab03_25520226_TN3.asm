	.text
main:
	li $a0, 20
	jal fib_rec
	add $s0, $zero, $v0
	li $v0, 1
	add $a0, $zero, $s0
	syscall
	li $v0, 10
	syscall
# fib_iter: tinh F(n) bang vong lap
# Tham so : $a0 = n    Tra ve : $v0 = F(n)
# Thanh ghi: $t0-$t3 (thu tuc la)
fib_iter:
        move  $v0, $zero        # a = F(0)
        li    $t0, 1            # b = F(1)
        move  $t1, $zero        # i = 0
fi_loop:
        slt   $t2, $t1, $a0
        beq   $t2, $zero, fi_done
        addu  $t3, $v0, $t0     # a + b
        move  $v0, $t0
        move  $t0, $t3
        addiu $t1, $t1, 1
        j     fi_loop
fi_done:
        jr    $ra
#thu tuc fib_rec
#dau vao $a0, nhap so n
#dau ra $v0, ket qua F(n)
fib_rec:
	addi $sp, $sp, -12
	sw   $ra, 8($sp)
	sw   $a0, 4($sp)
	sw   $s0, 0($sp)

	ble $a0, $zero, is0           # n <= 0  
	li   $t0, 1
	beq  $a0, $t0, is1      # n =1

	addi $a0, $a0, -1
	jal  fib_rec                 # v0 = fib(n-1)
	move $s0, $v0            #luu vao s0

	lw   $a0, 4($sp)         
	addi $a0, $a0, -2
	jal  fib_rec                 # v0 = fib(n-2)

	add  $v0, $v0, $s0       # fib(n-1) + fib(n-2)
	j    fib_done

is0:
	li   $v0, 0
	j    fib_done
is1:
	li   $v0, 1

fib_done:
	lw   $s0, 0($sp)
	lw   $a0, 4($sp)
	lw   $ra, 8($sp)
	addi $sp, $sp, 12
	jr   $ra
