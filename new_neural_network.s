	.file	"new_neural_network.c"
	.text
	.section	.rodata.str1.1,"aMS",@progbits,1
.LC0:
	.string	"Failed to read uint32_t"
	.text
	.p2align 4
	.type	read_uint32.part.0, @function
read_uint32.part.0:
.LFB51:
	.cfi_startproc
	pushq	%rax
	.cfi_def_cfa_offset 16
	popq	%rax
	.cfi_def_cfa_offset 8
	leaq	.LC0(%rip), %rdi
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE51:
	.size	read_uint32.part.0, .-read_uint32.part.0
	.p2align 4
	.globl	initialize_layer
	.type	initialize_layer, @function
initialize_layer:
.LFB39:
	.cfi_startproc
	endbr64
	pushq	%r14
	.cfi_def_cfa_offset 16
	.cfi_offset 14, -16
	pushq	%r13
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
	pushq	%r12
	.cfi_def_cfa_offset 32
	.cfi_offset 12, -32
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 40
	.cfi_offset 6, -40
	movq	%rdi, %rbp
	xorl	%edi, %edi
	pushq	%rbx
	.cfi_def_cfa_offset 48
	.cfi_offset 3, -48
	leaq	803840(%rbp), %r13
	leaq	1024(%rbp), %rbx
	call	time@PLT
	movl	%eax, %edi
	call	srand@PLT
.L5:
	leaq	-1024(%rbx), %r14
	.p2align 4,,10
	.p2align 3
.L6:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	addq	$8, %r14
	cvtsi2sdl	%eax, %xmm0
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm0, %xmm0
	subsd	.LC2(%rip), %xmm0
	movsd	%xmm0, -8(%r14)
	cmpq	%rbx, %r14
	jne	.L6
	leaq	1024(%r14), %rbx
	cmpq	%r13, %rbx
	jne	.L5
	addq	$802816, %rbp
	leaq	80(%r12), %rbx
	leaq	10320(%r12), %r13
.L9:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	leaq	-80(%rbx), %r14
	cvtsi2sdl	%eax, %xmm0
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm0, %xmm0
	subsd	.LC2(%rip), %xmm0
	movsd	%xmm0, 0(%rbp)
	.p2align 4,,10
	.p2align 3
.L8:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	addq	$8, %r14
	cvtsi2sdl	%eax, %xmm0
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm0, %xmm0
	subsd	.LC2(%rip), %xmm0
	movsd	%xmm0, -8(%r14)
	cmpq	%rbx, %r14
	jne	.L8
	leaq	80(%r14), %rbx
	addq	$8, %rbp
	cmpq	%r13, %rbx
	jne	.L9
	addq	$10240, %r12
.L10:
	call	rand@PLT
	pxor	%xmm0, %xmm0
	addq	$8, %r12
	cvtsi2sdl	%eax, %xmm0
	divsd	.LC1(%rip), %xmm0
	addsd	%xmm0, %xmm0
	subsd	.LC2(%rip), %xmm0
	movsd	%xmm0, -8(%r12)
	cmpq	%r13, %r12
	jne	.L10
	popq	%rbx
	.cfi_def_cfa_offset 40
	popq	%rbp
	.cfi_def_cfa_offset 32
	popq	%r12
	.cfi_def_cfa_offset 24
	popq	%r13
	.cfi_def_cfa_offset 16
	popq	%r14
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE39:
	.size	initialize_layer, .-initialize_layer
	.p2align 4
	.globl	sigmoid
	.type	sigmoid, @function
sigmoid:
.LFB40:
	.cfi_startproc
	endbr64
	subq	$8, %rsp
	.cfi_def_cfa_offset 16
	xorpd	.LC3(%rip), %xmm0
	call	exp@PLT
	movsd	.LC2(%rip), %xmm1
	addq	$8, %rsp
	.cfi_def_cfa_offset 8
	addsd	%xmm1, %xmm0
	divsd	%xmm0, %xmm1
	movapd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE40:
	.size	sigmoid, .-sigmoid
	.p2align 4
	.globl	sigmoid_derivative
	.type	sigmoid_derivative, @function
sigmoid_derivative:
.LFB41:
	.cfi_startproc
	endbr64
	movapd	%xmm0, %xmm1
	movsd	.LC2(%rip), %xmm0
	subsd	%xmm1, %xmm0
	mulsd	%xmm1, %xmm0
	ret
	.cfi_endproc
.LFE41:
	.size	sigmoid_derivative, .-sigmoid_derivative
	.p2align 4
	.globl	forward_pass
	.type	forward_pass, @function
forward_pass:
.LFB42:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	leaq	802816(%rdi), %r15
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	movq	%rcx, %r14
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rsi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rcx, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	movq	%rdi, %rbx
	addq	$803840, %rbx
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movsd	.LC4(%rip), %xmm2
	movq	%r8, 8(%rsp)
.L21:
	movsd	(%r15), %xmm1
	movq	%rbp, %rdx
	leaq	-802816(%r15), %rax
	.p2align 4,,10
	.p2align 3
.L20:
	movzbl	(%rdx), %ecx
	pxor	%xmm0, %xmm0
	addq	$1024, %rax
	addq	$1, %rdx
	cvtsi2sdl	%ecx, %xmm0
	divsd	%xmm2, %xmm0
	mulsd	-1024(%rax), %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rax, %r15
	jne	.L20
	xorpd	.LC3(%rip), %xmm1
	addq	$8, %r15
	addq	$8, %r12
	movapd	%xmm1, %xmm0
	call	exp@PLT
	addsd	.LC2(%rip), %xmm0
	movsd	.LC2(%rip), %xmm1
	movq	.LC4(%rip), %rax
	divsd	%xmm0, %xmm1
	movq	%rax, %xmm2
	movsd	%xmm1, -8(%r12)
	cmpq	%r15, %rbx
	jne	.L21
	movq	8(%rsp), %r12
	leaq	10240(%r13), %rdx
	addq	$10320, %r13
.L23:
	movsd	(%rdx), %xmm1
	leaq	-10240(%rdx), %rbx
	movq	%r14, %rax
	.p2align 4,,10
	.p2align 3
.L22:
	movsd	(%rbx), %xmm0
	movupd	(%rax), %xmm3
	addq	$160, %rbx
	addq	$16, %rax
	movhpd	-80(%rbx), %xmm0
	mulpd	%xmm3, %xmm0
	addsd	%xmm0, %xmm1
	unpckhpd	%xmm0, %xmm0
	addsd	%xmm0, %xmm1
	cmpq	%rdx, %rbx
	jne	.L22
	xorpd	.LC3(%rip), %xmm1
	addq	$8, %r12
	movapd	%xmm1, %xmm0
	call	exp@PLT
	addsd	.LC2(%rip), %xmm0
	leaq	8(%rbx), %rdx
	movsd	.LC2(%rip), %xmm1
	divsd	%xmm0, %xmm1
	movsd	%xmm1, -8(%r12)
	cmpq	%rdx, %r13
	jne	.L23
	addq	$24, %rsp
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
	.cfi_endproc
.LFE42:
	.size	forward_pass, .-forward_pass
	.p2align 4
	.globl	backward_pass
	.type	backward_pass, @function
backward_pass:
.LFB43:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rdi, %r10
	movq	%rdx, %rdi
	pxor	%xmm3, %xmm3
	pushq	%rbx
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -24
	movdqa	%xmm3, %xmm5
	movq	%rcx, %r11
	movq	%r8, %rax
	subq	$1128, %rsp
	.cfi_def_cfa_offset 1152
	movapd	.LC7(%rip), %xmm1
	movsd	.LC2(%rip), %xmm8
	movq	%fs:40, %rdx
	movq	%rdx, 1112(%rsp)
	xorl	%edx, %edx
	movzbl	%r9b, %edx
	movd	%edx, %xmm6
	movapd	%xmm1, %xmm7
	pshufd	$0, %xmm6, %xmm0
	movupd	16(%r8), %xmm6
	movdqa	%xmm0, %xmm2
	pcmpeqd	.LC8(%rip), %xmm0
	pcmpeqd	.LC6(%rip), %xmm2
	pcmpgtd	%xmm0, %xmm3
	pcmpgtd	%xmm2, %xmm5
	movdqa	%xmm2, %xmm4
	punpckldq	%xmm5, %xmm4
	punpckhdq	%xmm5, %xmm2
	movupd	(%r8), %xmm5
	andpd	%xmm1, %xmm4
	andpd	%xmm1, %xmm2
	subpd	%xmm5, %xmm7
	subpd	%xmm5, %xmm4
	subpd	%xmm6, %xmm2
	mulpd	%xmm5, %xmm7
	movapd	%xmm1, %xmm5
	subpd	%xmm6, %xmm5
	mulpd	%xmm6, %xmm5
	movupd	32(%r8), %xmm6
	mulpd	%xmm4, %xmm7
	movapd	%xmm1, %xmm4
	subpd	%xmm6, %xmm4
	mulpd	%xmm2, %xmm5
	movdqa	%xmm0, %xmm2
	punpckhdq	%xmm3, %xmm0
	mulpd	%xmm6, %xmm4
	punpckldq	%xmm3, %xmm2
	andpd	%xmm1, %xmm0
	movaps	%xmm7, (%rsp)
	andpd	%xmm1, %xmm2
	movupd	48(%r8), %xmm3
	subpd	%xmm6, %xmm2
	subpd	%xmm3, %xmm0
	movaps	%xmm5, 16(%rsp)
	mulpd	%xmm2, %xmm4
	movapd	%xmm1, %xmm2
	subpd	%xmm3, %xmm2
	mulpd	%xmm3, %xmm2
	movaps	%xmm4, 32(%rsp)
	mulpd	%xmm0, %xmm2
	movsd	64(%r8), %xmm0
	movaps	%xmm2, 48(%rsp)
	cmpl	$8, %edx
	je	.L30
	movapd	%xmm8, %xmm3
	pxor	%xmm6, %xmm6
	subsd	%xmm0, %xmm3
	movapd	%xmm6, %xmm1
	subsd	%xmm0, %xmm1
	mulsd	%xmm0, %xmm3
	movapd	%xmm8, %xmm0
	mulsd	%xmm1, %xmm3
	movsd	%xmm3, 64(%rsp)
	cmpl	$9, %edx
	jne	.L53
.L31:
	movsd	72(%rax), %xmm1
	movapd	%xmm8, %xmm9
	movapd	%xmm7, %xmm13
	movapd	%xmm5, %xmm12
	movapd	%xmm4, %xmm11
	movapd	%xmm2, %xmm10
	unpckhpd	%xmm7, %xmm7
	movq	%rsi, %r8
	subsd	%xmm1, %xmm9
	subsd	%xmm1, %xmm0
	unpckhpd	%xmm5, %xmm5
	movq	%rsi, %rax
	unpckhpd	%xmm4, %xmm4
	unpckhpd	%xmm2, %xmm2
	leaq	80(%rsp), %rcx
	xorl	%edx, %edx
	mulsd	%xmm1, %xmm9
	mulsd	%xmm0, %xmm9
	movsd	%xmm9, 72(%rsp)
.L32:
	movsd	(%rax), %xmm0
	movsd	8(%rax), %xmm14
	addq	$80, %rax
	movsd	(%r11,%rdx), %xmm1
	addq	$8, %rdx
	mulsd	%xmm13, %xmm0
	mulsd	%xmm7, %xmm14
	addsd	%xmm6, %xmm0
	addsd	%xmm14, %xmm0
	movsd	-64(%rax), %xmm14
	mulsd	%xmm12, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-56(%rax), %xmm14
	mulsd	%xmm5, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-48(%rax), %xmm14
	mulsd	%xmm11, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-40(%rax), %xmm14
	mulsd	%xmm4, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-32(%rax), %xmm14
	mulsd	%xmm10, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-24(%rax), %xmm14
	mulsd	%xmm2, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-16(%rax), %xmm14
	mulsd	%xmm3, %xmm14
	addsd	%xmm14, %xmm0
	movsd	-8(%rax), %xmm14
	mulsd	%xmm9, %xmm14
	addsd	%xmm14, %xmm0
	movapd	%xmm8, %xmm14
	subsd	%xmm1, %xmm14
	mulsd	%xmm14, %xmm1
	mulsd	%xmm1, %xmm0
	movsd	%xmm0, -8(%rdx,%rcx)
	cmpq	$1024, %rdx
	jne	.L32
	leaq	10320(%rsi), %rbp
	movq	%rcx, %rax
	movq	%rsp, %rbx
	movsd	.LC9(%rip), %xmm3
	leaq	10240(%rsi), %r9
	movq	%rbp, %rcx
	leaq	1024(%r11), %rsi
	movq	%rax, %rbp
.L38:
	movsd	(%rbx), %xmm2
	movsd	(%r9), %xmm0
	leaq	-72(%r9), %rax
	mulsd	%xmm3, %xmm2
	addsd	%xmm2, %xmm0
	movsd	%xmm0, (%r9)
	cmpq	%rax, %r11
	jnb	.L43
	cmpq	%r8, %rsi
	ja	.L33
.L43:
	unpcklpd	%xmm2, %xmm2
	movq	%r11, %rdx
	movq	%r8, %rax
	.p2align 4,,10
	.p2align 3
.L35:
	movupd	(%rdx), %xmm0
	movsd	(%rax), %xmm1
	addq	$160, %rax
	addq	$16, %rdx
	mulpd	%xmm2, %xmm0
	movhpd	-80(%rax), %xmm1
	addpd	%xmm1, %xmm0
	movlpd	%xmm0, -160(%rax)
	movhpd	%xmm0, -80(%rax)
	cmpq	%rax, %r9
	jne	.L35
.L36:
	addq	$8, %r9
	addq	$8, %r8
	addq	$8, %rbx
	cmpq	%rcx, %r9
	jne	.L38
	movsd	.LC4(%rip), %xmm2
	leaq	802816(%r10), %rsi
	movq	%rbp, %r8
	addq	$803840, %r10
.L40:
	movsd	(%r8), %xmm1
	movsd	(%rsi), %xmm0
	leaq	-802816(%rsi), %rax
	movq	%rdi, %rdx
	mulsd	%xmm3, %xmm1
	addsd	%xmm1, %xmm0
	movsd	%xmm0, (%rsi)
	.p2align 4,,10
	.p2align 3
.L39:
	movzbl	(%rdx), %ecx
	pxor	%xmm0, %xmm0
	addq	$1024, %rax
	addq	$1, %rdx
	cvtsi2sdl	%ecx, %xmm0
	divsd	%xmm2, %xmm0
	mulsd	%xmm1, %xmm0
	addsd	-1024(%rax), %xmm0
	movsd	%xmm0, -1024(%rax)
	cmpq	%rax, %rsi
	jne	.L39
	addq	$8, %rsi
	addq	$8, %r8
	cmpq	%r10, %rsi
	jne	.L40
	movq	1112(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L54
	addq	$1128, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 24
	popq	%rbx
	.cfi_def_cfa_offset 16
	popq	%rbp
	.cfi_def_cfa_offset 8
	ret
.L33:
	.cfi_restore_state
	movq	%r11, %rdx
	movq	%r8, %rax
	.p2align 4,,10
	.p2align 3
.L37:
	movsd	(%rdx), %xmm0
	addq	$80, %rax
	addq	$8, %rdx
	mulsd	%xmm2, %xmm0
	addsd	-80(%rax), %xmm0
	movsd	%xmm0, -80(%rax)
	cmpq	%rax, %r9
	jne	.L37
	jmp	.L36
.L30:
	movapd	%xmm8, %xmm1
	pxor	%xmm6, %xmm6
	subsd	%xmm0, %xmm1
	mulsd	%xmm1, %xmm0
	movapd	%xmm0, %xmm3
	movapd	%xmm6, %xmm0
	mulsd	%xmm1, %xmm3
	movsd	%xmm3, 64(%rsp)
	jmp	.L31
.L53:
	movapd	%xmm6, %xmm0
	jmp	.L31
.L54:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE43:
	.size	backward_pass, .-backward_pass
	.section	.rodata.str1.1
.LC10:
	.string	"Epoch %d/%d completed\n"
	.text
	.p2align 4
	.globl	train
	.type	train, @function
train:
.LFB44:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	movq	%rdi, %r13
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	movq	%rsi, %r12
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$1176, %rsp
	.cfi_def_cfa_offset 1232
	movq	%rdx, 32(%rsp)
	movq	%rcx, 40(%rsp)
	movl	%r8d, 24(%rsp)
	movl	%r9d, 28(%rsp)
	movq	%fs:40, %rax
	movq	%rax, 1160(%rsp)
	xorl	%eax, %eax
	leal	-1(%r8), %eax
	movl	$0, 20(%rsp)
	leaq	1(%rcx,%rax), %rax
	movq	%rax, 8(%rsp)
	testl	%r9d, %r9d
	jle	.L55
	.p2align 4,,10
	.p2align 3
.L56:
	movl	24(%rsp), %eax
	testl	%eax, %eax
	jle	.L60
	movq	32(%rsp), %r14
	movq	40(%rsp), %rbx
	leaq	48(%rsp), %r15
	leaq	128(%rsp), %rbp
	.p2align 4,,10
	.p2align 3
.L58:
	movq	%r14, %rdx
	movq	%r15, %r8
	movq	%rbp, %rcx
	movq	%r12, %rsi
	movq	%r13, %rdi
	addq	$1, %rbx
	call	forward_pass
	movzbl	-1(%rbx), %r9d
	movq	%r14, %rdx
	movq	%r15, %r8
	movq	%rbp, %rcx
	movq	%r12, %rsi
	movq	%r13, %rdi
	addq	$784, %r14
	call	backward_pass
	cmpq	8(%rsp), %rbx
	jne	.L58
.L60:
	addl	$1, 20(%rsp)
	movl	28(%rsp), %r15d
	xorl	%eax, %eax
	leaq	.LC10(%rip), %rsi
	movl	20(%rsp), %ebx
	movl	$1, %edi
	movl	%r15d, %ecx
	movl	%ebx, %edx
	call	__printf_chk@PLT
	cmpl	%r15d, %ebx
	jne	.L56
.L55:
	movq	1160(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L68
	addq	$1176, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L68:
	.cfi_restore_state
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE44:
	.size	train, .-train
	.p2align 4
	.globl	recognize
	.type	recognize, @function
recognize:
.LFB45:
	.cfi_startproc
	endbr64
	subq	$1128, %rsp
	.cfi_def_cfa_offset 1136
	movq	%fs:40, %rax
	movq	%rax, 1112(%rsp)
	xorl	%eax, %eax
	leaq	80(%rsp), %rcx
	movq	%rsp, %r8
	call	forward_pass
	movsd	(%rsp), %xmm1
	movsd	8(%rsp), %xmm0
	movl	$1, %eax
	comisd	%xmm1, %xmm0
	ja	.L70
	movapd	%xmm1, %xmm0
	xorl	%eax, %eax
.L70:
	movsd	16(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	ja	.L81
	movapd	%xmm0, %xmm1
	movsd	24(%rsp), %xmm0
	comisd	%xmm1, %xmm0
	ja	.L82
.L92:
	movapd	%xmm1, %xmm0
	movsd	32(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	ja	.L83
.L93:
	movapd	%xmm0, %xmm1
	movsd	40(%rsp), %xmm0
	comisd	%xmm1, %xmm0
	ja	.L84
.L94:
	movapd	%xmm1, %xmm0
	movsd	48(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	ja	.L85
.L95:
	movapd	%xmm0, %xmm1
	movsd	56(%rsp), %xmm0
	comisd	%xmm1, %xmm0
	ja	.L86
.L96:
	movapd	%xmm1, %xmm0
	movsd	64(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	ja	.L87
.L97:
	movapd	%xmm0, %xmm1
.L77:
	movsd	72(%rsp), %xmm0
	movl	$9, %edx
	ucomisd	%xmm1, %xmm0
	cmova	%edx, %eax
	movq	1112(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L91
	addq	$1128, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
	.p2align 4,,10
	.p2align 3
.L81:
	.cfi_restore_state
	movsd	24(%rsp), %xmm0
	movl	$2, %eax
	comisd	%xmm1, %xmm0
	jbe	.L92
.L82:
	movsd	32(%rsp), %xmm1
	movl	$3, %eax
	comisd	%xmm0, %xmm1
	jbe	.L93
.L83:
	movsd	40(%rsp), %xmm0
	movl	$4, %eax
	comisd	%xmm1, %xmm0
	jbe	.L94
.L84:
	movsd	48(%rsp), %xmm1
	movl	$5, %eax
	comisd	%xmm0, %xmm1
	jbe	.L95
.L85:
	movsd	56(%rsp), %xmm0
	movl	$6, %eax
	comisd	%xmm1, %xmm0
	jbe	.L96
.L86:
	movsd	64(%rsp), %xmm1
	movl	$7, %eax
	comisd	%xmm0, %xmm1
	jbe	.L97
.L87:
	movl	$8, %eax
	jmp	.L77
.L91:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE45:
	.size	recognize, .-recognize
	.p2align 4
	.globl	read_uint32
	.type	read_uint32, @function
read_uint32:
.LFB46:
	.cfi_startproc
	endbr64
	subq	$24, %rsp
	.cfi_def_cfa_offset 32
	movq	%rdi, %rcx
	movl	$1, %edx
	movl	$4, %esi
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	leaq	4(%rsp), %rdi
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L102
	movl	4(%rsp), %eax
	bswap	%eax
	movq	8(%rsp), %rdx
	subq	%fs:40, %rdx
	jne	.L103
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 8
	ret
.L102:
	.cfi_restore_state
	call	read_uint32.part.0
.L103:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE46:
	.size	read_uint32, .-read_uint32
	.section	.rodata.str1.1
.LC11:
	.string	"rb"
.LC12:
	.string	"Failed to open file"
.LC13:
	.string	"Failed to read images"
	.text
	.p2align 4
	.globl	load_mnist_images
	.type	load_mnist_images, @function
load_mnist_images:
.LFB47:
	.cfi_startproc
	endbr64
	pushq	%r13
	.cfi_def_cfa_offset 16
	.cfi_offset 13, -16
	pushq	%r12
	.cfi_def_cfa_offset 24
	.cfi_offset 12, -24
	pushq	%rbp
	.cfi_def_cfa_offset 32
	.cfi_offset 6, -32
	movq	%rdx, %rbp
	pushq	%rbx
	.cfi_def_cfa_offset 40
	.cfi_offset 3, -40
	movq	%rsi, %rbx
	leaq	.LC11(%rip), %rsi
	subq	$40, %rsp
	.cfi_def_cfa_offset 80
	movq	%fs:40, %rax
	movq	%rax, 24(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L111
	leaq	20(%rsp), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movq	%rax, %r12
	movl	$4, %esi
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L107
	leaq	16(%rsp), %rdi
	movq	%r12, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L107
	movl	16(%rsp), %eax
	leaq	12(%rsp), %rdi
	movq	%r12, %rcx
	movl	$1, %edx
	movl	$4, %esi
	bswap	%eax
	movl	%eax, (%rbx)
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L107
	movl	12(%rsp), %r13d
	leaq	8(%rsp), %rdi
	movq	%r12, %rcx
	movl	$1, %edx
	movl	$4, %esi
	bswap	%r13d
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L107
	movl	8(%rsp), %edi
	bswap	%edi
	imull	%r13d, %edi
	movl	%edi, 0(%rbp)
	imull	(%rbx), %edi
	movslq	%edi, %rdi
	call	malloc@PLT
	movslq	0(%rbp), %rdx
	movslq	(%rbx), %rcx
	movq	%r12, %r8
	movq	$-1, %rsi
	movq	%rax, %rdi
	movq	%rax, %r13
	call	__fread_chk@PLT
	movslq	(%rbx), %rdx
	cmpq	%rax, %rdx
	jne	.L112
	movq	%r12, %rdi
	call	fclose@PLT
	movq	24(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L113
	addq	$40, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 40
	movq	%r13, %rax
	popq	%rbx
	.cfi_def_cfa_offset 32
	popq	%rbp
	.cfi_def_cfa_offset 24
	popq	%r12
	.cfi_def_cfa_offset 16
	popq	%r13
	.cfi_def_cfa_offset 8
	ret
.L107:
	.cfi_restore_state
	call	read_uint32.part.0
.L111:
	leaq	.LC12(%rip), %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L113:
	call	__stack_chk_fail@PLT
.L112:
	leaq	.LC13(%rip), %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE47:
	.size	load_mnist_images, .-load_mnist_images
	.section	.rodata.str1.1
.LC14:
	.string	"Failed to read labels"
	.text
	.p2align 4
	.globl	load_mnist_labels
	.type	load_mnist_labels, @function
load_mnist_labels:
.LFB48:
	.cfi_startproc
	endbr64
	pushq	%r12
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
	pushq	%rbp
	.cfi_def_cfa_offset 24
	.cfi_offset 6, -24
	pushq	%rbx
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -32
	movq	%rsi, %rbx
	leaq	.LC11(%rip), %rsi
	subq	$16, %rsp
	.cfi_def_cfa_offset 48
	movq	%fs:40, %rax
	movq	%rax, 8(%rsp)
	xorl	%eax, %eax
	call	fopen@PLT
	testq	%rax, %rax
	je	.L121
	leaq	4(%rsp), %rdi
	movq	%rax, %rcx
	movl	$1, %edx
	movq	%rax, %rbp
	movl	$4, %esi
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L117
	movq	%rsp, %rdi
	movq	%rbp, %rcx
	movl	$1, %edx
	movl	$4, %esi
	call	fread@PLT
	cmpq	$1, %rax
	jne	.L117
	movl	(%rsp), %edi
	bswap	%edi
	movl	%edi, (%rbx)
	movslq	%edi, %rdi
	call	malloc@PLT
	movslq	(%rbx), %rdx
	movq	%rbp, %rcx
	movl	$1, %esi
	movq	%rax, %rdi
	movq	%rax, %r12
	call	fread@PLT
	movslq	(%rbx), %rdx
	cmpq	%rax, %rdx
	jne	.L122
	movq	%rbp, %rdi
	call	fclose@PLT
	movq	8(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L123
	addq	$16, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 32
	movq	%r12, %rax
	popq	%rbx
	.cfi_def_cfa_offset 24
	popq	%rbp
	.cfi_def_cfa_offset 16
	popq	%r12
	.cfi_def_cfa_offset 8
	ret
.L117:
	.cfi_restore_state
	call	read_uint32.part.0
.L121:
	leaq	.LC12(%rip), %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
.L123:
	call	__stack_chk_fail@PLT
.L122:
	leaq	.LC14(%rip), %rdi
	call	perror@PLT
	movl	$1, %edi
	call	exit@PLT
	.cfi_endproc
.LFE48:
	.size	load_mnist_labels, .-load_mnist_labels
	.p2align 4
	.globl	calculate_accuracy
	.type	calculate_accuracy, @function
calculate_accuracy:
.LFB49:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	subq	$24, %rsp
	.cfi_def_cfa_offset 80
	movl	%r8d, 12(%rsp)
	testl	%r8d, %r8d
	jle	.L128
	movl	%r8d, %eax
	movq	%rdi, %r12
	movq	%rsi, %r13
	movq	%rdx, %r14
	subl	$1, %eax
	movq	%rcx, %rbx
	xorl	%ebp, %ebp
	leaq	1(%rcx,%rax), %r15
	.p2align 4,,10
	.p2align 3
.L127:
	movq	%r14, %rdx
	movq	%r13, %rsi
	movq	%r12, %rdi
	call	recognize
	cmpb	%al, (%rbx)
	sete	%al
	addq	$1, %rbx
	addq	$784, %r14
	movzbl	%al, %eax
	addl	%eax, %ebp
	cmpq	%r15, %rbx
	jne	.L127
	pxor	%xmm0, %xmm0
	cvtsi2sdl	%ebp, %xmm0
.L125:
	pxor	%xmm1, %xmm1
	cvtsi2sdl	12(%rsp), %xmm1
	addq	$24, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	divsd	%xmm1, %xmm0
	ret
	.p2align 4,,10
	.p2align 3
.L128:
	.cfi_restore_state
	pxor	%xmm0, %xmm0
	jmp	.L125
	.cfi_endproc
.LFE49:
	.size	calculate_accuracy, .-calculate_accuracy
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC15:
	.string	"mnist_data/train-images-idx3-ubyte"
	.align 8
.LC16:
	.string	"mnist_data/train-labels-idx1-ubyte"
	.align 8
.LC17:
	.string	"Number of images and labels do not match\n"
	.section	.rodata.str1.1
.LC19:
	.string	"Training accuracy: %.2f%%\n"
	.section	.rodata.str1.8
	.align 8
.LC20:
	.string	"Image %d: Recognized digit = %d, Actual digit = %d\n"
	.section	.text.startup,"ax",@progbits
	.p2align 4
	.globl	main
	.type	main, @function
main:
.LFB50:
	.cfi_startproc
	endbr64
	pushq	%r15
	.cfi_def_cfa_offset 16
	.cfi_offset 15, -16
	pushq	%r14
	.cfi_def_cfa_offset 24
	.cfi_offset 14, -24
	pushq	%r13
	.cfi_def_cfa_offset 32
	.cfi_offset 13, -32
	pushq	%r12
	.cfi_def_cfa_offset 40
	.cfi_offset 12, -40
	pushq	%rbp
	.cfi_def_cfa_offset 48
	.cfi_offset 6, -48
	pushq	%rbx
	.cfi_def_cfa_offset 56
	.cfi_offset 3, -56
	leaq	-815104(%rsp), %r11
	.cfi_def_cfa 11, 815160
.LPSRL0:
	subq	$4096, %rsp
	orq	$0, (%rsp)
	cmpq	%r11, %rsp
	jne	.LPSRL0
	.cfi_def_cfa_register 7
	subq	$232, %rsp
	.cfi_def_cfa_offset 815392
	leaq	.LC15(%rip), %rdi
	movq	%fs:40, %rax
	movq	%rax, 815320(%rsp)
	xorl	%eax, %eax
	leaq	40(%rsp), %rdx
	leaq	36(%rsp), %rsi
	call	load_mnist_images
	leaq	44(%rsp), %rsi
	leaq	.LC16(%rip), %rdi
	movq	%rax, 24(%rsp)
	call	load_mnist_labels
	movq	%rax, 8(%rsp)
	movl	44(%rsp), %eax
	cmpl	%eax, 36(%rsp)
	jne	.L169
	leaq	1152(%rsp), %r12
	leaq	11472(%rsp), %rbp
	xorl	%r13d, %r13d
	movq	%r12, %rsi
	movq	%rbp, %rdi
	call	initialize_layer
	movq	8(%rsp), %r15
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movq	24(%rsp), %rbx
	movl	36(%rsp), %r8d
	movl	$10, %r9d
	movq	%r15, %rcx
	movq	%rbx, %rdx
	call	train
	movl	36(%rsp), %r8d
	movq	%r15, %rcx
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	leaq	48(%rsp), %r15
	call	calculate_accuracy
	movl	$1, %edi
	movl	$1, %eax
	leaq	.LC19(%rip), %rsi
	mulsd	.LC18(%rip), %xmm0
	call	__printf_chk@PLT
	leaq	128(%rsp), %rax
	movq	%rax, 16(%rsp)
	.p2align 4,,10
	.p2align 3
.L152:
	movq	16(%rsp), %rcx
	movq	%r15, %r8
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movq	%rbp, %rdi
	movl	%r13d, %r14d
	call	forward_pass
	movsd	48(%rsp), %xmm0
	movsd	56(%rsp), %xmm1
	xorl	%ecx, %ecx
	comisd	%xmm0, %xmm1
	jbe	.L133
	movapd	%xmm1, %xmm0
	movl	$1, %ecx
.L133:
	movsd	64(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L135
	movapd	%xmm1, %xmm0
	movl	$2, %ecx
.L135:
	movsd	72(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L137
	movapd	%xmm1, %xmm0
	movl	$3, %ecx
.L137:
	movsd	80(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L139
	movapd	%xmm1, %xmm0
	movl	$4, %ecx
.L139:
	movsd	88(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L141
	movapd	%xmm1, %xmm0
	movl	$5, %ecx
.L141:
	movsd	96(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L143
	movapd	%xmm1, %xmm0
	movl	$6, %ecx
.L143:
	movsd	104(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L145
	movapd	%xmm1, %xmm0
	movl	$7, %ecx
.L145:
	movsd	112(%rsp), %xmm1
	comisd	%xmm0, %xmm1
	jbe	.L147
	movapd	%xmm1, %xmm0
	movl	$8, %ecx
.L147:
	movsd	120(%rsp), %xmm1
	movq	8(%rsp), %rax
	comisd	%xmm0, %xmm1
	movzbl	(%rax,%r13), %r8d
	jbe	.L168
	movl	$9, %ecx
.L168:
	movl	%r14d, %edx
	leaq	.LC20(%rip), %rsi
	xorl	%eax, %eax
	addq	$1, %r13
	movl	$1, %edi
	addq	$784, %rbx
	call	__printf_chk@PLT
	cmpq	$10, %r13
	jne	.L152
	movq	24(%rsp), %rdi
	call	free@PLT
	movq	8(%rsp), %rdi
	call	free@PLT
	movq	815320(%rsp), %rax
	subq	%fs:40, %rax
	jne	.L170
	addq	$815336, %rsp
	.cfi_remember_state
	.cfi_def_cfa_offset 56
	xorl	%eax, %eax
	popq	%rbx
	.cfi_def_cfa_offset 48
	popq	%rbp
	.cfi_def_cfa_offset 40
	popq	%r12
	.cfi_def_cfa_offset 32
	popq	%r13
	.cfi_def_cfa_offset 24
	popq	%r14
	.cfi_def_cfa_offset 16
	popq	%r15
	.cfi_def_cfa_offset 8
	ret
.L169:
	.cfi_restore_state
	movq	stderr(%rip), %rcx
	movl	$41, %edx
	movl	$1, %esi
	leaq	.LC17(%rip), %rdi
	call	fwrite@PLT
	movl	$1, %edi
	call	exit@PLT
.L170:
	call	__stack_chk_fail@PLT
	.cfi_endproc
.LFE50:
	.size	main, .-main
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC1:
	.long	-4194304
	.long	1105199103
	.set	.LC2,.LC7
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC3:
	.long	0
	.long	-2147483648
	.long	0
	.long	0
	.section	.rodata.cst8
	.align 8
.LC4:
	.long	0
	.long	1081073664
	.section	.rodata.cst16
	.align 16
.LC6:
	.long	0
	.long	1
	.long	2
	.long	3
	.align 16
.LC7:
	.long	0
	.long	1072693248
	.long	0
	.long	1072693248
	.align 16
.LC8:
	.long	4
	.long	5
	.long	6
	.long	7
	.section	.rodata.cst8
	.align 8
.LC9:
	.long	1202590843
	.long	1065646817
	.align 8
.LC18:
	.long	0
	.long	1079574528
	.ident	"GCC: (Ubuntu 11.4.0-1ubuntu1~22.04) 11.4.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
