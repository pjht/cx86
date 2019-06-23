.globl _main
_main:
push rbp
mov rbp,rsp
mov rax,2
push rax
mov rax,[rbp-8]
push rax
mov rax,2
pop rcx
add rax,rcx
mov [rbp-8],rax
mov rax,[rbp-8]
mov rsp,rbp
pop rbp
ret
mov rax,0
mov rsp,rbp
pop rbp
ret
