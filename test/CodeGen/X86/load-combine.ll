; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py
; RUN: llc < %s -mtriple=i686-unknown | FileCheck %s
; RUN: llc < %s -mtriple=x86_64-unknown | FileCheck %s --check-prefix=CHECK64

; i8* p;
; (i32) p[0] | ((i32) p[1] << 8) | ((i32) p[2] << 16) | ((i32) p[3] << 24)
define i32 @load_i32_by_i8(i32*) {
; CHECK-LABEL: load_i32_by_i8:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movl (%rdi), %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = getelementptr inbounds i8, i8* %2, i32 1
  %6 = load i8, i8* %5, align 1
  %7 = zext i8 %6 to i32
  %8 = shl nuw nsw i32 %7, 8
  %9 = or i32 %8, %4
  %10 = getelementptr inbounds i8, i8* %2, i32 2
  %11 = load i8, i8* %10, align 1
  %12 = zext i8 %11 to i32
  %13 = shl nuw nsw i32 %12, 16
  %14 = or i32 %9, %13
  %15 = getelementptr inbounds i8, i8* %2, i32 3
  %16 = load i8, i8* %15, align 1
  %17 = zext i8 %16 to i32
  %18 = shl nuw nsw i32 %17, 24
  %19 = or i32 %14, %18
  ret i32 %19
}

; i8* p;
; ((i32) p[0] << 24) | ((i32) p[1] << 16) | ((i32) p[2] << 8) | (i32) p[3]
define i32 @load_i32_by_i8_bswap(i32*) {
; CHECK-LABEL: load_i32_by_i8_bswap:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    bswapl %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_bswap:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movl (%rdi), %eax
; CHECK64-NEXT:    bswapl %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = shl nuw nsw i32 %4, 24
  %6 = getelementptr inbounds i8, i8* %2, i32 1
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = shl nuw nsw i32 %8, 16
  %10 = or i32 %9, %5
  %11 = getelementptr inbounds i8, i8* %2, i32 2
  %12 = load i8, i8* %11, align 1
  %13 = zext i8 %12 to i32
  %14 = shl nuw nsw i32 %13, 8
  %15 = or i32 %10, %14
  %16 = getelementptr inbounds i8, i8* %2, i32 3
  %17 = load i8, i8* %16, align 1
  %18 = zext i8 %17 to i32
  %19 = or i32 %15, %18
  ret i32 %19
}

; i16* p;
; (i32) p[0] | ((i32) p[1] << 16)
define i32 @load_i32_by_i16(i32*) {
; CHECK-LABEL: load_i32_by_i16:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i16:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movl (%rdi), %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i16*
  %3 = load i16, i16* %2, align 1
  %4 = zext i16 %3 to i32
  %5 = getelementptr inbounds i16, i16* %2, i32 1
  %6 = load i16, i16* %5, align 1
  %7 = zext i16 %6 to i32
  %8 = shl nuw nsw i32 %7, 16
  %9 = or i32 %8, %4
  ret i32 %9
}

; i16* p_16;
; i8* p_8 = (i8*) p_16;
; (i32) p_16[0] | ((i32) p[2] << 16) | ((i32) p[3] << 24)
define i32 @load_i32_by_i16_i8(i32*) {
; CHECK-LABEL: load_i32_by_i16_i8:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i16_i8:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movl (%rdi), %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i16*
  %3 = bitcast i32* %0 to i8*
  %4 = load i16, i16* %2, align 1
  %5 = zext i16 %4 to i32
  %6 = getelementptr inbounds i8, i8* %3, i32 2
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = shl nuw nsw i32 %8, 16
  %10 = getelementptr inbounds i8, i8* %3, i32 3
  %11 = load i8, i8* %10, align 1
  %12 = zext i8 %11 to i32
  %13 = shl nuw nsw i32 %12, 24
  %14 = or i32 %9, %13
  %15 = or i32 %14, %5
  ret i32 %15
}


; i8* p;
; (i32) ((i16) p[0] | ((i16) p[1] << 8)) | (((i32) ((i16) p[3] | ((i16) p[4] << 8)) << 16)
define i32 @load_i32_by_i16_by_i8(i32*) {
; CHECK-LABEL: load_i32_by_i16_by_i8:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i16_by_i8:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movl (%rdi), %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i16
  %5 = getelementptr inbounds i8, i8* %2, i32 1
  %6 = load i8, i8* %5, align 1
  %7 = zext i8 %6 to i16
  %8 = shl nuw nsw i16 %7, 8
  %9 = or i16 %8, %4
  %10 = getelementptr inbounds i8, i8* %2, i32 2
  %11 = load i8, i8* %10, align 1
  %12 = zext i8 %11 to i16
  %13 = getelementptr inbounds i8, i8* %2, i32 3
  %14 = load i8, i8* %13, align 1
  %15 = zext i8 %14 to i16
  %16 = shl nuw nsw i16 %15, 8
  %17 = or i16 %16, %12
  %18 = zext i16 %9 to i32
  %19 = zext i16 %17 to i32
  %20 = shl nuw nsw i32 %19, 16
  %21 = or i32 %20, %18
  ret i32 %21
}

; i8* p;
; ((i32) (((i16) p[0] << 8) | (i16) p[1]) << 16) | (i32) (((i16) p[3] << 8) | (i16) p[4])
define i32 @load_i32_by_i16_by_i8_bswap(i32*) {
; CHECK-LABEL: load_i32_by_i16_by_i8_bswap:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl (%eax), %eax
; CHECK-NEXT:    bswapl %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i16_by_i8_bswap:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movl (%rdi), %eax
; CHECK64-NEXT:    bswapl %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i16
  %5 = getelementptr inbounds i8, i8* %2, i32 1
  %6 = load i8, i8* %5, align 1
  %7 = zext i8 %6 to i16
  %8 = shl nuw nsw i16 %4, 8
  %9 = or i16 %8, %7
  %10 = getelementptr inbounds i8, i8* %2, i32 2
  %11 = load i8, i8* %10, align 1
  %12 = zext i8 %11 to i16
  %13 = getelementptr inbounds i8, i8* %2, i32 3
  %14 = load i8, i8* %13, align 1
  %15 = zext i8 %14 to i16
  %16 = shl nuw nsw i16 %12, 8
  %17 = or i16 %16, %15
  %18 = zext i16 %9 to i32
  %19 = zext i16 %17 to i32
  %20 = shl nuw nsw i32 %18, 16
  %21 = or i32 %20, %19
  ret i32 %21
}

; i8* p;
; (i64) p[0] | ((i64) p[1] << 8) | ((i64) p[2] << 16) | ((i64) p[3] << 24) | ((i64) p[4] << 32) | ((i64) p[5] << 40) | ((i64) p[6] << 48) | ((i64) p[7] << 56)
define i64 @load_i64_by_i8(i64*) {
; CHECK-LABEL: load_i64_by_i8:
; CHECK:       # BB#0:
; CHECK-NEXT:    pushl %edi
; CHECK-NEXT:  .Lcfi0:
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:  .Lcfi1:
; CHECK-NEXT:    .cfi_def_cfa_offset 12
; CHECK-NEXT:  .Lcfi2:
; CHECK-NEXT:    .cfi_offset %esi, -12
; CHECK-NEXT:  .Lcfi3:
; CHECK-NEXT:    .cfi_offset %edi, -8
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movzbl (%ecx), %eax
; CHECK-NEXT:    movzbl 1(%ecx), %edx
; CHECK-NEXT:    shll $8, %edx
; CHECK-NEXT:    orl %eax, %edx
; CHECK-NEXT:    movzbl 2(%ecx), %esi
; CHECK-NEXT:    shll $16, %esi
; CHECK-NEXT:    orl %edx, %esi
; CHECK-NEXT:    movzbl 3(%ecx), %eax
; CHECK-NEXT:    shll $24, %eax
; CHECK-NEXT:    orl %esi, %eax
; CHECK-NEXT:    movzbl 4(%ecx), %edx
; CHECK-NEXT:    movzbl 5(%ecx), %esi
; CHECK-NEXT:    shll $8, %esi
; CHECK-NEXT:    orl %edx, %esi
; CHECK-NEXT:    movzbl 6(%ecx), %edi
; CHECK-NEXT:    shll $16, %edi
; CHECK-NEXT:    orl %esi, %edi
; CHECK-NEXT:    movzbl 7(%ecx), %edx
; CHECK-NEXT:    shll $24, %edx
; CHECK-NEXT:    orl %edi, %edx
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    popl %edi
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i64_by_i8:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movq (%rdi), %rax
; CHECK64-NEXT:    retq

  %2 = bitcast i64* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i64
  %5 = getelementptr inbounds i8, i8* %2, i64 1
  %6 = load i8, i8* %5, align 1
  %7 = zext i8 %6 to i64
  %8 = shl nuw nsw i64 %7, 8
  %9 = or i64 %8, %4
  %10 = getelementptr inbounds i8, i8* %2, i64 2
  %11 = load i8, i8* %10, align 1
  %12 = zext i8 %11 to i64
  %13 = shl nuw nsw i64 %12, 16
  %14 = or i64 %9, %13
  %15 = getelementptr inbounds i8, i8* %2, i64 3
  %16 = load i8, i8* %15, align 1
  %17 = zext i8 %16 to i64
  %18 = shl nuw nsw i64 %17, 24
  %19 = or i64 %14, %18
  %20 = getelementptr inbounds i8, i8* %2, i64 4
  %21 = load i8, i8* %20, align 1
  %22 = zext i8 %21 to i64
  %23 = shl nuw nsw i64 %22, 32
  %24 = or i64 %19, %23
  %25 = getelementptr inbounds i8, i8* %2, i64 5
  %26 = load i8, i8* %25, align 1
  %27 = zext i8 %26 to i64
  %28 = shl nuw nsw i64 %27, 40
  %29 = or i64 %24, %28
  %30 = getelementptr inbounds i8, i8* %2, i64 6
  %31 = load i8, i8* %30, align 1
  %32 = zext i8 %31 to i64
  %33 = shl nuw nsw i64 %32, 48
  %34 = or i64 %29, %33
  %35 = getelementptr inbounds i8, i8* %2, i64 7
  %36 = load i8, i8* %35, align 1
  %37 = zext i8 %36 to i64
  %38 = shl nuw i64 %37, 56
  %39 = or i64 %34, %38
  ret i64 %39
}

; i8* p;
; ((i64) p[0] << 56) | ((i64) p[1] << 48) | ((i64) p[2] << 40) | ((i64) p[3] << 32) | ((i64) p[4] << 24) | ((i64) p[5] << 16) | ((i64) p[6] << 8) | (i64) p[7]
define i64 @load_i64_by_i8_bswap(i64*) {
; CHECK-LABEL: load_i64_by_i8_bswap:
; CHECK:       # BB#0:
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:  .Lcfi4:
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:  .Lcfi5:
; CHECK-NEXT:    .cfi_offset %esi, -8
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movzbl (%eax), %ecx
; CHECK-NEXT:    shll $24, %ecx
; CHECK-NEXT:    movzbl 1(%eax), %edx
; CHECK-NEXT:    shll $16, %edx
; CHECK-NEXT:    orl %ecx, %edx
; CHECK-NEXT:    movzbl 2(%eax), %ecx
; CHECK-NEXT:    shll $8, %ecx
; CHECK-NEXT:    orl %edx, %ecx
; CHECK-NEXT:    movzbl 3(%eax), %edx
; CHECK-NEXT:    orl %ecx, %edx
; CHECK-NEXT:    movzbl 4(%eax), %ecx
; CHECK-NEXT:    shll $24, %ecx
; CHECK-NEXT:    movzbl 5(%eax), %esi
; CHECK-NEXT:    shll $16, %esi
; CHECK-NEXT:    orl %ecx, %esi
; CHECK-NEXT:    movzbl 6(%eax), %ecx
; CHECK-NEXT:    shll $8, %ecx
; CHECK-NEXT:    orl %esi, %ecx
; CHECK-NEXT:    movzbl 7(%eax), %eax
; CHECK-NEXT:    orl %ecx, %eax
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i64_by_i8_bswap:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movq (%rdi), %rax
; CHECK64-NEXT:    bswapq %rax
; CHECK64-NEXT:    retq

  %2 = bitcast i64* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i64
  %5 = shl nuw i64 %4, 56
  %6 = getelementptr inbounds i8, i8* %2, i64 1
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i64
  %9 = shl nuw nsw i64 %8, 48
  %10 = or i64 %9, %5
  %11 = getelementptr inbounds i8, i8* %2, i64 2
  %12 = load i8, i8* %11, align 1
  %13 = zext i8 %12 to i64
  %14 = shl nuw nsw i64 %13, 40
  %15 = or i64 %10, %14
  %16 = getelementptr inbounds i8, i8* %2, i64 3
  %17 = load i8, i8* %16, align 1
  %18 = zext i8 %17 to i64
  %19 = shl nuw nsw i64 %18, 32
  %20 = or i64 %15, %19
  %21 = getelementptr inbounds i8, i8* %2, i64 4
  %22 = load i8, i8* %21, align 1
  %23 = zext i8 %22 to i64
  %24 = shl nuw nsw i64 %23, 24
  %25 = or i64 %20, %24
  %26 = getelementptr inbounds i8, i8* %2, i64 5
  %27 = load i8, i8* %26, align 1
  %28 = zext i8 %27 to i64
  %29 = shl nuw nsw i64 %28, 16
  %30 = or i64 %25, %29
  %31 = getelementptr inbounds i8, i8* %2, i64 6
  %32 = load i8, i8* %31, align 1
  %33 = zext i8 %32 to i64
  %34 = shl nuw nsw i64 %33, 8
  %35 = or i64 %30, %34
  %36 = getelementptr inbounds i8, i8* %2, i64 7
  %37 = load i8, i8* %36, align 1
  %38 = zext i8 %37 to i64
  %39 = or i64 %35, %38
  ret i64 %39
}

; Part of the load by bytes pattern is used outside of the pattern
; i8* p;
; i32 x = (i32) p[1]
; res = ((i32) p[0] << 24) | (x << 16) | ((i32) p[2] << 8) | (i32) p[3]
; x | res
define i32 @load_i32_by_i8_bswap_uses(i32*) {
; CHECK-LABEL: load_i32_by_i8_bswap_uses:
; CHECK:       # BB#0:
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:  .Lcfi6:
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:  .Lcfi7:
; CHECK-NEXT:    .cfi_offset %esi, -8
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movzbl (%eax), %ecx
; CHECK-NEXT:    shll $24, %ecx
; CHECK-NEXT:    movzbl 1(%eax), %edx
; CHECK-NEXT:    movl %edx, %esi
; CHECK-NEXT:    shll $16, %esi
; CHECK-NEXT:    orl %ecx, %esi
; CHECK-NEXT:    movzbl 2(%eax), %ecx
; CHECK-NEXT:    shll $8, %ecx
; CHECK-NEXT:    orl %esi, %ecx
; CHECK-NEXT:    movzbl 3(%eax), %eax
; CHECK-NEXT:    orl %ecx, %eax
; CHECK-NEXT:    orl %edx, %eax
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_bswap_uses:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movzbl (%rdi), %eax
; CHECK64-NEXT:    shll $24, %eax
; CHECK64-NEXT:    movzbl 1(%rdi), %ecx
; CHECK64-NEXT:    movl %ecx, %edx
; CHECK64-NEXT:    shll $16, %edx
; CHECK64-NEXT:    orl %eax, %edx
; CHECK64-NEXT:    movzbl 2(%rdi), %esi
; CHECK64-NEXT:    shll $8, %esi
; CHECK64-NEXT:    orl %edx, %esi
; CHECK64-NEXT:    movzbl 3(%rdi), %eax
; CHECK64-NEXT:    orl %esi, %eax
; CHECK64-NEXT:    orl %ecx, %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = load i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = shl nuw nsw i32 %4, 24
  %6 = getelementptr inbounds i8, i8* %2, i32 1
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = shl nuw nsw i32 %8, 16
  %10 = or i32 %9, %5
  %11 = getelementptr inbounds i8, i8* %2, i32 2
  %12 = load i8, i8* %11, align 1
  %13 = zext i8 %12 to i32
  %14 = shl nuw nsw i32 %13, 8
  %15 = or i32 %10, %14
  %16 = getelementptr inbounds i8, i8* %2, i32 3
  %17 = load i8, i8* %16, align 1
  %18 = zext i8 %17 to i32
  %19 = or i32 %15, %18
  ; Use individual part of the pattern outside of the pattern
  %20 = or i32 %8, %19
  ret i32 %20
}

; One of the loads is volatile
; i8* p;
; p0 = volatile *p;
; ((i32) p0 << 24) | ((i32) p[1] << 16) | ((i32) p[2] << 8) | (i32) p[3]
define i32 @load_i32_by_i8_bswap_volatile(i32*) {
; CHECK-LABEL: load_i32_by_i8_bswap_volatile:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movzbl (%eax), %ecx
; CHECK-NEXT:    shll $24, %ecx
; CHECK-NEXT:    movzbl 1(%eax), %edx
; CHECK-NEXT:    shll $16, %edx
; CHECK-NEXT:    orl %ecx, %edx
; CHECK-NEXT:    movzbl 2(%eax), %ecx
; CHECK-NEXT:    shll $8, %ecx
; CHECK-NEXT:    orl %edx, %ecx
; CHECK-NEXT:    movzbl 3(%eax), %eax
; CHECK-NEXT:    orl %ecx, %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_bswap_volatile:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movzbl (%rdi), %eax
; CHECK64-NEXT:    shll $24, %eax
; CHECK64-NEXT:    movzbl 1(%rdi), %ecx
; CHECK64-NEXT:    shll $16, %ecx
; CHECK64-NEXT:    orl %eax, %ecx
; CHECK64-NEXT:    movzbl 2(%rdi), %edx
; CHECK64-NEXT:    shll $8, %edx
; CHECK64-NEXT:    orl %ecx, %edx
; CHECK64-NEXT:    movzbl 3(%rdi), %eax
; CHECK64-NEXT:    orl %edx, %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = load volatile i8, i8* %2, align 1
  %4 = zext i8 %3 to i32
  %5 = shl nuw nsw i32 %4, 24
  %6 = getelementptr inbounds i8, i8* %2, i32 1
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = shl nuw nsw i32 %8, 16
  %10 = or i32 %9, %5
  %11 = getelementptr inbounds i8, i8* %2, i32 2
  %12 = load i8, i8* %11, align 1
  %13 = zext i8 %12 to i32
  %14 = shl nuw nsw i32 %13, 8
  %15 = or i32 %10, %14
  %16 = getelementptr inbounds i8, i8* %2, i32 3
  %17 = load i8, i8* %16, align 1
  %18 = zext i8 %17 to i32
  %19 = or i32 %15, %18
  ret i32 %19
}

; There is a store in between individual loads
; i8* p, q;
; res1 = ((i32) p[0] << 24) | ((i32) p[1] << 16)
; *q = 0;
; res2 = ((i32) p[2] << 8) | (i32) p[3]
; res1 | res2
define i32 @load_i32_by_i8_bswap_store_in_between(i32*, i32*) {
; CHECK-LABEL: load_i32_by_i8_bswap_store_in_between:
; CHECK:       # BB#0:
; CHECK-NEXT:    pushl %esi
; CHECK-NEXT:  .Lcfi8:
; CHECK-NEXT:    .cfi_def_cfa_offset 8
; CHECK-NEXT:  .Lcfi9:
; CHECK-NEXT:    .cfi_offset %esi, -8
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movzbl (%ecx), %edx
; CHECK-NEXT:    shll $24, %edx
; CHECK-NEXT:    movzbl 1(%ecx), %esi
; CHECK-NEXT:    movl $0, (%eax)
; CHECK-NEXT:    shll $16, %esi
; CHECK-NEXT:    orl %edx, %esi
; CHECK-NEXT:    movzbl 2(%ecx), %edx
; CHECK-NEXT:    shll $8, %edx
; CHECK-NEXT:    orl %esi, %edx
; CHECK-NEXT:    movzbl 3(%ecx), %eax
; CHECK-NEXT:    orl %edx, %eax
; CHECK-NEXT:    popl %esi
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_bswap_store_in_between:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movzbl (%rdi), %eax
; CHECK64-NEXT:    shll $24, %eax
; CHECK64-NEXT:    movzbl 1(%rdi), %ecx
; CHECK64-NEXT:    movl $0, (%rsi)
; CHECK64-NEXT:    shll $16, %ecx
; CHECK64-NEXT:    orl %eax, %ecx
; CHECK64-NEXT:    movzbl 2(%rdi), %edx
; CHECK64-NEXT:    shll $8, %edx
; CHECK64-NEXT:    orl %ecx, %edx
; CHECK64-NEXT:    movzbl 3(%rdi), %eax
; CHECK64-NEXT:    orl %edx, %eax
; CHECK64-NEXT:    retq

  %3 = bitcast i32* %0 to i8*
  %4 = load i8, i8* %3, align 1
  %5 = zext i8 %4 to i32
  %6 = shl nuw nsw i32 %5, 24
  %7 = getelementptr inbounds i8, i8* %3, i32 1
  %8 = load i8, i8* %7, align 1
  ; This store will prevent folding of the pattern
  store i32 0, i32* %1
  %9 = zext i8 %8 to i32
  %10 = shl nuw nsw i32 %9, 16
  %11 = or i32 %10, %6
  %12 = getelementptr inbounds i8, i8* %3, i32 2
  %13 = load i8, i8* %12, align 1
  %14 = zext i8 %13 to i32
  %15 = shl nuw nsw i32 %14, 8
  %16 = or i32 %11, %15
  %17 = getelementptr inbounds i8, i8* %3, i32 3
  %18 = load i8, i8* %17, align 1
  %19 = zext i8 %18 to i32
  %20 = or i32 %16, %19
  ret i32 %20
}

; One of the loads is from an unrelated location
; i8* p, q;
; ((i32) p[0] << 24) | ((i32) q[1] << 16) | ((i32) p[2] << 8) | (i32) p[3]
define i32 @load_i32_by_i8_bswap_unrelated_load(i32*, i32*) {
; CHECK-LABEL: load_i32_by_i8_bswap_unrelated_load:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movzbl (%ecx), %edx
; CHECK-NEXT:    shll $24, %edx
; CHECK-NEXT:    movzbl 1(%eax), %eax
; CHECK-NEXT:    shll $16, %eax
; CHECK-NEXT:    orl %edx, %eax
; CHECK-NEXT:    movzbl 2(%ecx), %edx
; CHECK-NEXT:    shll $8, %edx
; CHECK-NEXT:    orl %eax, %edx
; CHECK-NEXT:    movzbl 3(%ecx), %eax
; CHECK-NEXT:    orl %edx, %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_bswap_unrelated_load:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movzbl (%rdi), %eax
; CHECK64-NEXT:    shll $24, %eax
; CHECK64-NEXT:    movzbl 1(%rsi), %ecx
; CHECK64-NEXT:    shll $16, %ecx
; CHECK64-NEXT:    orl %eax, %ecx
; CHECK64-NEXT:    movzbl 2(%rdi), %edx
; CHECK64-NEXT:    shll $8, %edx
; CHECK64-NEXT:    orl %ecx, %edx
; CHECK64-NEXT:    movzbl 3(%rdi), %eax
; CHECK64-NEXT:    orl %edx, %eax
; CHECK64-NEXT:    retq

  %3 = bitcast i32* %0 to i8*
  %4 = bitcast i32* %1 to i8*
  %5 = load i8, i8* %3, align 1
  %6 = zext i8 %5 to i32
  %7 = shl nuw nsw i32 %6, 24
  ; Load from an unrelated address
  %8 = getelementptr inbounds i8, i8* %4, i32 1
  %9 = load i8, i8* %8, align 1
  %10 = zext i8 %9 to i32
  %11 = shl nuw nsw i32 %10, 16
  %12 = or i32 %11, %7
  %13 = getelementptr inbounds i8, i8* %3, i32 2
  %14 = load i8, i8* %13, align 1
  %15 = zext i8 %14 to i32
  %16 = shl nuw nsw i32 %15, 8
  %17 = or i32 %12, %16
  %18 = getelementptr inbounds i8, i8* %3, i32 3
  %19 = load i8, i8* %18, align 1
  %20 = zext i8 %19 to i32
  %21 = or i32 %17, %20
  ret i32 %21
}

; Non-zero offsets are not supported for now
; i8* p;
; (i32) p[1] | ((i32) p[2] << 8) | ((i32) p[3] << 16) | ((i32) p[4] << 24)
define i32 @load_i32_by_i8_unsupported_offset(i32*) {
; CHECK-LABEL: load_i32_by_i8_unsupported_offset:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movzbl (%eax), %ecx
; CHECK-NEXT:    movzbl 2(%eax), %edx
; CHECK-NEXT:    shll $8, %edx
; CHECK-NEXT:    orl %ecx, %edx
; CHECK-NEXT:    movzbl 3(%eax), %ecx
; CHECK-NEXT:    shll $16, %ecx
; CHECK-NEXT:    orl %edx, %ecx
; CHECK-NEXT:    movzbl 4(%eax), %eax
; CHECK-NEXT:    shll $24, %eax
; CHECK-NEXT:    orl %ecx, %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_unsupported_offset:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movzbl (%rdi), %eax
; CHECK64-NEXT:    movzbl 2(%rdi), %ecx
; CHECK64-NEXT:    shll $8, %ecx
; CHECK64-NEXT:    orl %eax, %ecx
; CHECK64-NEXT:    movzbl 3(%rdi), %edx
; CHECK64-NEXT:    shll $16, %edx
; CHECK64-NEXT:    orl %ecx, %edx
; CHECK64-NEXT:    movzbl 4(%rdi), %eax
; CHECK64-NEXT:    shll $24, %eax
; CHECK64-NEXT:    orl %edx, %eax
; CHECK64-NEXT:    retq

  %2 = bitcast i32* %0 to i8*
  %3 = getelementptr inbounds i8, i8* %2, i32 1
  %4 = load i8, i8* %2, align 1
  %5 = zext i8 %4 to i32
  %6 = getelementptr inbounds i8, i8* %2, i32 2
  %7 = load i8, i8* %6, align 1
  %8 = zext i8 %7 to i32
  %9 = shl nuw nsw i32 %8, 8
  %10 = or i32 %9, %5
  %11 = getelementptr inbounds i8, i8* %2, i32 3
  %12 = load i8, i8* %11, align 1
  %13 = zext i8 %12 to i32
  %14 = shl nuw nsw i32 %13, 16
  %15 = or i32 %10, %14
  %16 = getelementptr inbounds i8, i8* %2, i32 4
  %17 = load i8, i8* %16, align 1
  %18 = zext i8 %17 to i32
  %19 = shl nuw nsw i32 %18, 24
  %20 = or i32 %15, %19
  ret i32 %20
}

; i8* p; i32 i;
; ((i32) p[i] << 24) | ((i32) p[i + 1] << 16) | ((i32) p[i + 2] << 8) | (i32) p[i + 3]
define i32 @load_i32_by_i8_bswap_base_index_offset(i32*, i32) {
; CHECK-LABEL: load_i32_by_i8_bswap_base_index_offset:
; CHECK:       # BB#0:
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %eax
; CHECK-NEXT:    movl {{[0-9]+}}(%esp), %ecx
; CHECK-NEXT:    movl (%ecx,%eax), %eax
; CHECK-NEXT:    bswapl %eax
; CHECK-NEXT:    retl
;
; CHECK64-LABEL: load_i32_by_i8_bswap_base_index_offset:
; CHECK64:       # BB#0:
; CHECK64-NEXT:    movslq %esi, %rax
; CHECK64-NEXT:    movzbl (%rdi,%rax), %ecx
; CHECK64-NEXT:    shll $24, %ecx
; CHECK64-NEXT:    movzbl 1(%rdi,%rax), %edx
; CHECK64-NEXT:    shll $16, %edx
; CHECK64-NEXT:    orl %ecx, %edx
; CHECK64-NEXT:    movzbl 2(%rdi,%rax), %ecx
; CHECK64-NEXT:    shll $8, %ecx
; CHECK64-NEXT:    orl %edx, %ecx
; CHECK64-NEXT:    movzbl 3(%rdi,%rax), %eax
; CHECK64-NEXT:    orl %ecx, %eax
; CHECK64-NEXT:    retq
; Currently we don't fold the pattern for x86-64 target because we don't see
; that the loads are adjacent. It happens because BaseIndexOffset doesn't look
; through zexts.

  %3 = bitcast i32* %0 to i8*
  %4 = getelementptr inbounds i8, i8* %3, i32 %1
  %5 = load i8, i8* %4, align 1
  %6 = zext i8 %5 to i32
  %7 = shl nuw nsw i32 %6, 24
  %8 = add nuw nsw i32 %1, 1
  %9 = getelementptr inbounds i8, i8* %3, i32 %8
  %10 = load i8, i8* %9, align 1
  %11 = zext i8 %10 to i32
  %12 = shl nuw nsw i32 %11, 16
  %13 = or i32 %12, %7
  %14 = add nuw nsw i32 %1, 2
  %15 = getelementptr inbounds i8, i8* %3, i32 %14
  %16 = load i8, i8* %15, align 1
  %17 = zext i8 %16 to i32
  %18 = shl nuw nsw i32 %17, 8
  %19 = or i32 %13, %18
  %20 = add nuw nsw i32 %1, 3
  %21 = getelementptr inbounds i8, i8* %3, i32 %20
  %22 = load i8, i8* %21, align 1
  %23 = zext i8 %22 to i32
  %24 = or i32 %19, %23
  ret i32 %24
}