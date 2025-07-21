section .data
    num_input dd 5    ; change number for different results( I tested 1-8)

section .bss
    res resb 1
    output_buffer resb 20
    output_buffer_end:
section .text
    global _start

_start:
    mov ecx, [num_input]
    mov eax, 1

    cmp ecx, 0
    je print_result_and_exit

factorial_loop:
    cmp ecx, 1
    jl end_factorial_loop

    mul ecx
    dec ecx
    jmp factorial_loop

end_factorial_loop:

    mov edi, output_buffer_end     ;uses edi for the pointer to the buffer
    mov byte [edi], 0
    dec edi

    mov esi, 10

convert_loop:             ; somple loop
    xor edx, edx
    div esi

    add dl, '0'
    mov [edi], dl
    dec edi

    cmp eax, 0
    jne convert_loop

    inc edi                     ;  EDI now points to the first character

    mov eax, 4                  ; sys_write
    mov ebx, 1                  ;stdout
    mov ecx, edi                ;pointer to output string
    mov edx, output_buffer_end
    sub edx, edi                ;length of string
    int 0x80

    call linefeed

print_result_and_exit:
    call exit

linefeed:                  ; 
    mov eax, 10
    mov [res], eax
    mov ecx, res
    mov eax, 4
    mov ebx, 1
    mov edx, 1
    int 0x80
    ret

exit:
    mov eax, 1
    xor ebx, ebx
    int 0x80
