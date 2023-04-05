.text 
.align 2         
#start code here

main:
    
    la t1, num                  # holds the address of variable num
    lw a1, 0(t1)                # holds the value of variable num
    
    la s1, result               # holds the address of result

    call factorial              # compute num!
    
    sw a0, 0(s1)                # store factorial we calculated in variable result
    
    j write_tohost              # jump to exit

factorial:
    
    # arg: n in a1, returns n! in a0

    addi  sp, sp, -8            # allocate space on the stack
    sw ra, 0(sp)                # save the return address
    li t0, 1                    # temporary value to test num <= 1 condition
    ble a1, t0, return_1        # 0! and 1! == 1
    sw a1, 4(sp)                # push variable num on stack
    addi a1, a1, -1             # computes num-1 and this will be our updated num value
    call factorial              # call factorial (num - 1) and a0 <- factorial(n-1)
    lw t0, 4(sp)                # t0 <- num
    mul a0, t0, a0              # a0 <- num * factorial(num-1)
    j done
    
return_1:
    li a0, 1

done:
    lw ra, 0(sp)                # pop return address from stack
    addi sp, sp, 8              # deallocate the space on the stack
    ret                         # return back

#end code here

write_tohost:

li x1, 1

sw x1, tohost, t5

j write_tohost

.data 

#start data section here
num: .word 8
result: .word 0

#end data section here

.align 12

.section ".tohost","aw",@progbits;                            

.align 4; .global tohost; tohost: .dword 0;                     

.align 4; .global fromhost; fromhost: .dword 0; 
