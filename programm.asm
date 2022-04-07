extern printf


section .data
    array_output:          db "%d", 10, 0
    max_element:                  db "Максимальный элемент массива: %d", 10, 0
    index_max_element:            db "Индекс максимального элемента массива: %d", 10, 0

    array                  dd  10, 20, 30, 40, 50, 300, 70, 80, 90, 100, '\0'
    quantity_elements:     dd   10 ; количество элементов в массиве

SECTION .text
global procedure_for_c_plus_plus
procedure_for_c_plus_plus:  
    push rbp ;сохранить состояния регистра rbp в стэк (для использования функций printf)

    ; вывод массива
    mov r15, 0 ;помещаем значение 0 в r15
    cycle_print_start: ;начало вывода массива
        cmp r15, [quantity_elements]  ;сравнение 
        je cycle_print_end

        mov rdi, array_output
        mov rsi, [array + r15 * 4]
        call printf

        add r15, 1 ;складываются, результат помещается в r15
        jmp cycle_print_start
    cycle_print_end:

    ; цикл для поиска максимального элемента массива и индекса_
    mov rcx, 0   ; счетчик
    mov rdx, 0  ; значение для текущего элемента
    mov r14, -2147483647  ; регистр для элемента  
    mov r15, 0  ; регистр для позиции в массиве (индекс с 0)
    cycle_start:
    cmp rcx, [quantity_elements]                 ; условие выхода из цикла
    je cycle_end
    mov rdx, [rcx * 4 + array] ; текущий элемент массива
    and rdx, 0x00000000000ffff

    cmp rdx, r14
    jl element_smaller          ; переход, если первый операнд меньше второго

    mov r14, rdx                ; сохраняем текущий максимальный элемент массива
    mov r15, rcx                ; сохраняем текущий индекс максимального элемента массива

    element_smaller:
    cmp rcx, [quantity_elements]                 ; условие выхода из цикла
    je cycle_end

    add rcx, 1
    jmp cycle_start
    cycle_end:


    ; вывод максимального элемента
    lea rdi, [max_element]
    mov rsi, r14
    call printf

    ; вывод индекса максимального элемента
    lea rdi, [index_max_element]
    mov rsi, r15
    call printf

    pop rbp

    mov     rax, 60
    xor     rdi, rdi
    syscall