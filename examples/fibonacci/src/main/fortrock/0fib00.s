; ModuleID = './fib.f'
target datalayout = "e-p:64:64:64-S128-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f16:16:16-f32:32:32-f64:64:64-f128:128:128-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64"
target triple = "x86_64--linux-gnu"

module asm "\09.ident\09\22GCC: (Ubuntu 4.8.4-1ubuntu15) 4.8.4 LLVM: 3.4.2\22"

; Function Attrs: nounwind uwtable
define void @fib_(i32* noalias nocapture readonly %n, i32* noalias nocapture %o) unnamed_addr #0 {
entry:
  %0 = load i32* %n, align 4
  %1 = icmp sgt i32 %0, 0
  br i1 %1, label %"4.lr.ph", label %"5"

"4.lr.ph":                                        ; preds = %entry
  %2 = load i32* %n, align 4
  br label %"4"

"4":                                              ; preds = %"4.lr.ph", %"4"
  %3 = phi i32 [ 1, %"4.lr.ph" ], [ %6, %"4" ]
  %4 = phi i32 [ 0, %"4.lr.ph" ], [ %7, %"4" ]
  %5 = phi i32 [ 0, %"4.lr.ph" ], [ %3, %"4" ]
  %6 = add i32 %3, %5
  %7 = add i32 %4, 1
  %8 = icmp sgt i32 %2, %7
  br i1 %8, label %"4", label %"5"

"5":                                              ; preds = %"4", %entry
  %.lcssa = phi i32 [ 0, %entry ], [ %3, %"4" ]
  store i32 %.lcssa, i32* %o, align 4
  ret void
}

attributes #0 = { nounwind uwtable "no-frame-pointer-elim-non-leaf"="false" }
