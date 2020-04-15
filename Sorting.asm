INCLUDE Irvine32.inc

.data
 arr dword 100 dup (?)
 arr1 dword 'a','f','e','d','c'
 heading byte "SORTING ALGORITHMS", 0
 str1 byte "1. BUBBLE SORT.",0
 str2 byte "2. SELECTION SORT.",0
 str3 byte "3. INSERTION SORT.",0
 str4 byte "4. MERGE SORT.", 0
 str5 byte "5. QUICK SORT.", 0
 str6 byte "6. HEAP SORT", 0
 prompt1 byte "Enter a valid option: ", 0
 head1 byte "BUBBLE SORT", 0
 head2 byte "SELECTION SORT", 0
 head3 byte "INSERTION SORT", 0
 head4 byte "MERGE SORT", 0
 head5 byte "QUICK SORT", 0
 head6 byte "HEAP SORT", 0
 strgoback byte "Enter 0 to go back and any other key to exit: ", 0
 prompt byte "How many numbers would you like to enter: ", 0
 prompt2 byte "Enter Numbers: ", 0
 totalNumbers dword ?
 c1 dword ?
.code

Input_data proc
mov edx, offset prompt
call writestring
call readdec
mov totalNumbers, eax
mov esi, offset arr
mov ecx, totalNumbers
mov edx, offset prompt2
call crlf
call writestring
call crlf
READL:
call readdec
mov [esi], eax
add esi, type arr
LOOP READL
ret
Input_data endp

Selection_sort proc
l15:     
   mov eax,[esi]
   mov edx,esi
   mov edi,edx
   add edi,4
   mov ebx,[edi]
   mov edx,edi
   cmp eax,ebx
   ja l5
   jmp l6
   l5:
       mov [edx],eax
       mov [esi],ebx
   l6:
       add esi,4
loop l15

mov eax,c1
sub eax,1
mov c1,eax
cmp eax,0
je l7

mov esi,offset arr1
mov ecx, lengthof arr1
sub ecx,1
call Selection_sort
l7:
mov esi,offset arr1
mov ecx,lengthof arr1
ret
Selection_sort endp

bubble_sort proc
l1:     
   mov eax,[esi]
   mov edx,esi
   mov edi,edx
   add edi,4
   mov ebx,[edi]
   cmp eax,ebx
   ja l5
   jmp l6
   l5:
       mov [edi],eax
       mov [esi],ebx
   l6:
       add esi,4
loop l1

mov eax,c1
sub eax,1
mov c1,eax
cmp eax,0
je l7

mov esi,offset arr1
mov ecx,totalNumbers
sub ecx,1
call bubble_sort
l7:
ret
bubble_sort endp

swap proc,val1:PTR dword,val2:PTR dword
mov eax,0
mov esi,val1
mov edi,val2
mov eax,[esi]
xchg eax,[edi]
mov [esi],eax
ret
swap endp
partition proc,A:PTR dword,lo: dword,hi: dword
Local  pivot : dword,i :  dword,j :dword
mov esi,[A]
imul ebx,hi,type A
add esi,ebx
mov eax,[esi]
mov pivot,eax
;call writedec

mov eax,lo
dec eax
mov i,eax
;call writeint
mov eax,lo
mov j,eax
;call writeint
FORHI:
push esi
push ebx
mov esi,[A]
imul ebx,j,type A
add esi,ebx
pop ebx
push eax
mov eax,[esi]
cmp eax,pivot
ja L1
inc i
mov edi,[A]
imul ebx,i,type A
add edi,ebx
INVOKE swap,esi,edi
L1:
pop eax
pop esi
inc j
mov eax,j
cmp eax,hi
jb FORHI
inc i
push esi
mov esi,[A]
push ebx
imul ebx,i,type A
add esi,ebx
pop ebx
push edi
mov edi,[A]
push ebx
imul ebx,hi,type A
add edi,ebx
pop ebx
INVOKE swap,esi,edi
pop edi
pop esi

mov eax,i


ret
partition endp
Quicksort proc,A: PTR dword,lo: dword,hi: dword
local pi: dword
mov eax,0
mov eax,lo
cmp eax,hi
jae L1

INVOKE partition,A,lo,hi
mov pi,eax

push pi
inc pi
INVOKE Quicksort,A,pi,hi
pop pi
push pi
dec pi
INVOKE Quicksort,A,lo,pi
pop pi


L1:
ret 
Quicksort endp
heapify proc,A: PTR dword,n: dword,i: dword
local largest: dword,l: dword,r: dword
mov eax,i
mov largest,eax
;call writedec
push i
imul ebx,i,2

inc ebx
mov l,ebx
mov eax,l
;call writedec
pop i
push i
imul ebx,i,2
add ebx,2
mov r,ebx
mov eax,r
;call writedec
pop i
mov eax,l
cmp eax,n
jae L2
mov esi,[A]
imul ebx,l,type A
add esi,ebx
mov edi,[A]
imul ebx,largest,type A
add edi,ebx
mov eax,[esi]
cmp eax,[edi]
jbe L2
mov eax,l
mov largest,eax
L2:
mov eax,r
cmp eax,n
jae L3
mov esi,[A]
imul ebx,r,type A
add esi,ebx
mov edi,[A]
imul ebx,largest,type A
add edi,ebx
mov eax,[esi]
cmp eax,[edi]
jbe L3
mov eax,r
mov largest,eax
L3:
mov eax,largest
cmp eax,i
je L1
mov esi,[A]
imul ebx,i,type A
add esi,ebx
mov edi,[A]
imul ebx,largest,type A
add edi,ebx
invoke swap,esi,edi
invoke heapify,A,n,largest
L1:
ret
heapify endp 
heapsort proc,A: PTR dword,n: dword
local i: dword,j: dword
mov eax,n
mov ebx,2
cdq
idiv ebx
dec eax
mov i,eax
push ecx
mov ecx, i
inc ecx
;call writeint
FOR1:
invoke heapify,A,n,i
dec i

mov eax, i
LOOP FOR1
pop ecx

mov eax, n
dec eax
mov j, eax
push ecx
mov ecx, j
inc ecx
FOR2:
;call writeint
mov esi,[A]

mov edi,[A]
imul ebx,j,type A
add edi,ebx

Invoke swap,esi,edi
invoke heapify,A,j,0
dec j
mov eax, j
LOOP FOR2
POP ecx
quit:
ret
heapsort endp
insertion_sort proc,A: PTR dword,n:dword 
local i: dword , key: dword,j:dword
mov eax,1
;call writedec
mov i,eax
Forins:
mov esi,[A]
imul ebx,i,type A
add esi,ebx
mov eax,[esi]
mov key,eax
push i
dec i
mov eax,i
mov j,eax
pop i
inwhile:
mov eax,j
cmp eax,0
jb L1
mov edi,[A]
imul ebx,j,type A
add edi,ebx
mov eax,[edi]
cmp eax,key
jbe L1
push j
inc j

mov esi,[A]
imul ebx,j,type A
add esi,ebx
pop j

mov edi,[A]
imul ebx,j,type A
add edi,ebx
mov eax,[edi]
mov [esi],eax
dec j
jmp inwhile
L1:
push j
inc j
mov esi,[A]
imul ebx,j,type A
add esi,ebx
mov eax,key
mov [esi],eax
inc i
mov eax,n
;call writedec
cmp i,eax
jb Forins
ret
insertion_sort endp
print proc,val3: PTR dword,val4: dword
mov esi,val3
mov ecx,val4
L1:
mov eax,0
mov eax,[esi]
call writechar
call crlf
add esi,4
loop L1
ret
print endp

MainMenu proc
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset heading
call writestring
mov dl, 1
mov dh, 4
call gotoxy
mov edx, offset str1
call writestring
mov dl, 1
mov dh, 5
call gotoxy
mov edx, offset str2
call writestring
mov dl, 1
mov dh, 6
call gotoxy
mov edx, offset str3
call writestring
mov dl, 1
mov dh, 7
call gotoxy
mov edx, offset str4
call writestring
mov dl, 1
mov dh, 8
call gotoxy
mov edx, offset str5
call writestring
mov dl, 1
mov dh, 9
call gotoxy
mov edx, offset str6
call writestring
mov dl, 3
mov dh, 11
call gotoxy
mov edx, offset prompt1
call writestring
call readdec
cmp eax, 1
jne L1
mov totalNumbers, lengthof arr1
mov esi,offset arr1
mov ecx,eax
call crlf
mov esi,offset arr1
mov ecx,totalNumbers
sub ecx,1
mov c1,ecx
call bubble_sort
call clrscr
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset head1
call writestring
call crlf
call crlf
Invoke print,ADDR [arr1],lengthof arr1
call crlf
call crlf
mov edx, offset strgoback
call writestring
call readdec
cmp eax, 0
jne L
call clrscr
call MainMenu 
L1:
cmp eax, 2
jne L2
mov esi, offset arr1
mov ecx, lengthof arr1
sub ecx,1
mov c1,ecx
call Selection_sort
call clrscr
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset head2
call writestring
call crlf
call crlf
Invoke print,ADDR [arr1],lengthof arr1
call crlf
call crlf
mov edx, offset strgoback
call writestring
call readdec
cmp eax, 0
jne L
call clrscr
call MainMenu
L2:
cmp eax, 3
jne L3
Invoke insertion_sort,ADDR [arr1],lengthof arr1
call clrscr
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset head3
call writestring
call crlf
call crlf
Invoke print,ADDR [arr1],lengthof arr1
call crlf
call crlf
mov edx, offset strgoback
call writestring
call readdec
cmp eax, 0
jne L
call clrscr
call MainMenu
L3:
cmp eax, 4
jne L4
;Invoke insertion_sort,ADDR [arr1],lengthof arr1
call clrscr
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset head4
call writestring
call crlf
call crlf
Invoke print,ADDR [arr1],lengthof arr1
call crlf
call crlf
mov edx, offset strgoback
call writestring
call readdec
cmp eax, 0
jne L
call clrscr
call MainMenu
L4:
cmp eax, 5
jne L5
INVOKE Quicksort,ADDR arr1,0,(lengthof arr1)-1
call clrscr
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset head5
call writestring
call crlf
call crlf
Invoke print,ADDR [arr1],lengthof arr1
call crlf
call crlf
mov edx, offset strgoback
call writestring
call readdec
cmp eax, 0
jne L
call clrscr
call MainMenu
L5:
cmp eax, 6
jne L6
Invoke heapsort,ADDR [arr1],lengthof arr1
call clrscr
mov dl, 30
mov dh, 2
call gotoxy
mov edx, offset head6
call writestring
call crlf
call crlf
Invoke print,ADDR [arr1],lengthof arr1
call crlf
call crlf
mov edx, offset strgoback
call writestring
call readdec
cmp eax, 0
jne L
call clrscr
call MainMenu
L6:
call clrscr
call MainMenu
L:
ret
MainMenu endp

MAIN PROC
call MainMenu
exit
MAIN endp
END main
