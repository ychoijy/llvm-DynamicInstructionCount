; ModuleID = 'test.c'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [41 x i8] c"\0A\09------- Merge sorting method -------\0A\0A\00", align 1
@.str.1 = private unnamed_addr constant [31 x i8] c"Enter total no. of elements : \00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.3 = private unnamed_addr constant [5 x i8] c"%d, \00", align 1
@.str.4 = private unnamed_addr constant [42 x i8] c"\0A\09------- Merge sorted elements -------\0A\0A\00", align 1
@.str.5 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1

; Function Attrs: nounwind uwtable
define void @merge(i32* %arr, i32 %min, i32 %mid, i32 %max) #0 {
entry:
  %arr.addr = alloca i32*, align 8
  %min.addr = alloca i32, align 4
  %mid.addr = alloca i32, align 4
  %max.addr = alloca i32, align 4
  %tmp = alloca [1000000 x i32], align 16
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %m = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  store i32 %min, i32* %min.addr, align 4
  store i32 %mid, i32* %mid.addr, align 4
  store i32 %max, i32* %max.addr, align 4
  %0 = load i32, i32* %min.addr, align 4
  store i32 %0, i32* %j, align 4
  %1 = load i32, i32* %mid.addr, align 4
  %add = add nsw i32 %1, 1
  store i32 %add, i32* %m, align 4
  %2 = load i32, i32* %min.addr, align 4
  store i32 %2, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %3 = load i32, i32* %j, align 4
  %4 = load i32, i32* %mid.addr, align 4
  %cmp = icmp sle i32 %3, %4
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond
  %5 = load i32, i32* %m, align 4
  %6 = load i32, i32* %max.addr, align 4
  %cmp5 = icmp sle i32 %5, %6
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond
  %7 = phi i1 [ false, %for.cond ], [ %cmp5, %land.rhs ]
  br i1 %7, label %for.body, label %for.end

for.body:                                         ; preds = %land.end
  %8 = load i32, i32* %j, align 4
  %idxprom = sext i32 %8 to i64
  %9 = load i32*, i32** %arr.addr, align 8
  %arrayidx = getelementptr inbounds i32, i32* %9, i64 %idxprom
  %10 = load i32, i32* %arrayidx, align 4
  %11 = load i32, i32* %m, align 4
  %idxprom6 = sext i32 %11 to i64
  %12 = load i32*, i32** %arr.addr, align 8
  %arrayidx7 = getelementptr inbounds i32, i32* %12, i64 %idxprom6
  %13 = load i32, i32* %arrayidx7, align 4
  %cmp8 = icmp sle i32 %10, %13
  br i1 %cmp8, label %if.then, label %if.else

if.then:                                          ; preds = %for.body
  %14 = load i32, i32* %j, align 4
  %idxprom9 = sext i32 %14 to i64
  %15 = load i32*, i32** %arr.addr, align 8
  %arrayidx10 = getelementptr inbounds i32, i32* %15, i64 %idxprom9
  %16 = load i32, i32* %arrayidx10, align 4
  %17 = load i32, i32* %i, align 4
  %idxprom11 = sext i32 %17 to i64
  %arrayidx12 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %tmp, i64 0, i64 %idxprom11
  store i32 %16, i32* %arrayidx12, align 4
  %18 = load i32, i32* %j, align 4
  %inc = add nsw i32 %18, 1
  store i32 %inc, i32* %j, align 4
  br label %if.end

if.else:                                          ; preds = %for.body
  %19 = load i32, i32* %m, align 4
  %idxprom13 = sext i32 %19 to i64
  %20 = load i32*, i32** %arr.addr, align 8
  %arrayidx14 = getelementptr inbounds i32, i32* %20, i64 %idxprom13
  %21 = load i32, i32* %arrayidx14, align 4
  %22 = load i32, i32* %i, align 4
  %idxprom15 = sext i32 %22 to i64
  %arrayidx16 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %tmp, i64 0, i64 %idxprom15
  store i32 %21, i32* %arrayidx16, align 4
  %23 = load i32, i32* %m, align 4
  %inc17 = add nsw i32 %23, 1
  store i32 %inc17, i32* %m, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc

for.inc:                                          ; preds = %if.end
  %24 = load i32, i32* %i, align 4
  %inc18 = add nsw i32 %24, 1
  store i32 %inc18, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %land.end
  %25 = load i32, i32* %j, align 4
  %26 = load i32, i32* %mid.addr, align 4
  %cmp19 = icmp sgt i32 %25, %26
  br i1 %cmp19, label %if.then.20, label %if.else.32

if.then.20:                                       ; preds = %for.end
  %27 = load i32, i32* %m, align 4
  store i32 %27, i32* %k, align 4
  br label %for.cond.21

for.cond.21:                                      ; preds = %for.inc.29, %if.then.20
  %28 = load i32, i32* %k, align 4
  %29 = load i32, i32* %max.addr, align 4
  %cmp22 = icmp sle i32 %28, %29
  br i1 %cmp22, label %for.body.23, label %for.end.31

for.body.23:                                      ; preds = %for.cond.21
  %30 = load i32, i32* %k, align 4
  %idxprom24 = sext i32 %30 to i64
  %31 = load i32*, i32** %arr.addr, align 8
  %arrayidx25 = getelementptr inbounds i32, i32* %31, i64 %idxprom24
  %32 = load i32, i32* %arrayidx25, align 4
  %33 = load i32, i32* %i, align 4
  %idxprom26 = sext i32 %33 to i64
  %arrayidx27 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %tmp, i64 0, i64 %idxprom26
  store i32 %32, i32* %arrayidx27, align 4
  %34 = load i32, i32* %i, align 4
  %inc28 = add nsw i32 %34, 1
  store i32 %inc28, i32* %i, align 4
  br label %for.inc.29

for.inc.29:                                       ; preds = %for.body.23
  %35 = load i32, i32* %k, align 4
  %inc30 = add nsw i32 %35, 1
  store i32 %inc30, i32* %k, align 4
  br label %for.cond.21

for.end.31:                                       ; preds = %for.cond.21
  br label %if.end.44

if.else.32:                                       ; preds = %for.end
  %36 = load i32, i32* %j, align 4
  store i32 %36, i32* %k, align 4
  br label %for.cond.33

for.cond.33:                                      ; preds = %for.inc.41, %if.else.32
  %37 = load i32, i32* %k, align 4
  %38 = load i32, i32* %mid.addr, align 4
  %cmp34 = icmp sle i32 %37, %38
  br i1 %cmp34, label %for.body.35, label %for.end.43

for.body.35:                                      ; preds = %for.cond.33
  %39 = load i32, i32* %k, align 4
  %idxprom36 = sext i32 %39 to i64
  %40 = load i32*, i32** %arr.addr, align 8
  %arrayidx37 = getelementptr inbounds i32, i32* %40, i64 %idxprom36
  %41 = load i32, i32* %arrayidx37, align 4
  %42 = load i32, i32* %i, align 4
  %idxprom38 = sext i32 %42 to i64
  %arrayidx39 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %tmp, i64 0, i64 %idxprom38
  store i32 %41, i32* %arrayidx39, align 4
  %43 = load i32, i32* %i, align 4
  %inc40 = add nsw i32 %43, 1
  store i32 %inc40, i32* %i, align 4
  br label %for.inc.41

for.inc.41:                                       ; preds = %for.body.35
  %44 = load i32, i32* %k, align 4
  %inc42 = add nsw i32 %44, 1
  store i32 %inc42, i32* %k, align 4
  br label %for.cond.33

for.end.43:                                       ; preds = %for.cond.33
  br label %if.end.44

if.end.44:                                        ; preds = %for.end.43, %for.end.31
  %45 = load i32, i32* %min.addr, align 4
  store i32 %45, i32* %k, align 4
  br label %for.cond.45

for.cond.45:                                      ; preds = %for.inc.52, %if.end.44
  %46 = load i32, i32* %k, align 4
  %47 = load i32, i32* %max.addr, align 4
  %cmp46 = icmp sle i32 %46, %47
  br i1 %cmp46, label %for.body.47, label %for.end.54

for.body.47:                                      ; preds = %for.cond.45
  %48 = load i32, i32* %k, align 4
  %idxprom48 = sext i32 %48 to i64
  %arrayidx49 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %tmp, i64 0, i64 %idxprom48
  %49 = load i32, i32* %arrayidx49, align 4
  %50 = load i32, i32* %k, align 4
  %idxprom50 = sext i32 %50 to i64
  %51 = load i32*, i32** %arr.addr, align 8
  %arrayidx51 = getelementptr inbounds i32, i32* %51, i64 %idxprom50
  store i32 %49, i32* %arrayidx51, align 4
  br label %for.inc.52

for.inc.52:                                       ; preds = %for.body.47
  %52 = load i32, i32* %k, align 4
  %inc53 = add nsw i32 %52, 1
  store i32 %inc53, i32* %k, align 4
  br label %for.cond.45

for.end.54:                                       ; preds = %for.cond.45
  ret void
}

; Function Attrs: nounwind uwtable
define void @part(i32* %arr, i32 %min, i32 %max) #0 {
entry:
  %arr.addr = alloca i32*, align 8
  %min.addr = alloca i32, align 4
  %max.addr = alloca i32, align 4
  %mid = alloca i32, align 4
  store i32* %arr, i32** %arr.addr, align 8
  store i32 %min, i32* %min.addr, align 4
  store i32 %max, i32* %max.addr, align 4
  %0 = load i32, i32* %min.addr, align 4
  %1 = load i32, i32* %max.addr, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %min.addr, align 4
  %3 = load i32, i32* %max.addr, align 4
  %add = add nsw i32 %2, %3
  %div = sdiv i32 %add, 2
  store i32 %div, i32* %mid, align 4
  %4 = load i32*, i32** %arr.addr, align 8
  %5 = load i32, i32* %min.addr, align 4
  %6 = load i32, i32* %mid, align 4
  call void @part(i32* %4, i32 %5, i32 %6)
  %7 = load i32*, i32** %arr.addr, align 8
  %8 = load i32, i32* %mid, align 4
  %add1 = add nsw i32 %8, 1
  %9 = load i32, i32* %max.addr, align 4
  call void @part(i32* %7, i32 %add1, i32 %9)
  %10 = load i32*, i32** %arr.addr, align 8
  %11 = load i32, i32* %min.addr, align 4
  %12 = load i32, i32* %mid, align 4
  %13 = load i32, i32* %max.addr, align 4
  call void @merge(i32* %10, i32 %11, i32 %12, i32 %13)
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret void
}

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %arr = alloca [1000000 x i32], align 16
  %i = alloca i32, align 4
  %size = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i64 @time(i64* null) #3
  %conv = trunc i64 %call to i32
  call void @srand(i32 %conv) #3
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([41 x i8], [41 x i8]* @.str, i32 0, i32 0))
  %call2 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.1, i32 0, i32 0))
  %call3 = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i32 0, i32 0), i32* %size)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %size, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %call5 = call i32 @rand() #3
  %rem = srem i32 %call5, 1000
  %2 = load i32, i32* %i, align 4
  %idxprom = sext i32 %2 to i64
  %arrayidx = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %arr, i64 0, i64 %idxprom
  store i32 %rem, i32* %arrayidx, align 4
  %3 = load i32, i32* %i, align 4
  %idxprom6 = sext i32 %3 to i64
  %arrayidx7 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %arr, i64 0, i64 %idxprom6
  %4 = load i32, i32* %arrayidx7, align 4
  %call8 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.3, i32 0, i32 0), i32 %4)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %5 = load i32, i32* %i, align 4
  %inc = add nsw i32 %5, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  %arraydecay = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %arr, i32 0, i32 0
  %6 = load i32, i32* %size, align 4
  %sub = sub nsw i32 %6, 1
  call void @part(i32* %arraydecay, i32 0, i32 %sub)
  %call9 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([42 x i8], [42 x i8]* @.str.4, i32 0, i32 0))
  store i32 0, i32* %i, align 4
  br label %for.cond.10

for.cond.10:                                      ; preds = %for.inc.17, %for.end
  %7 = load i32, i32* %i, align 4
  %8 = load i32, i32* %size, align 4
  %cmp11 = icmp slt i32 %7, %8
  br i1 %cmp11, label %for.body.13, label %for.end.19

for.body.13:                                      ; preds = %for.cond.10
  %9 = load i32, i32* %i, align 4
  %idxprom14 = sext i32 %9 to i64
  %arrayidx15 = getelementptr inbounds [1000000 x i32], [1000000 x i32]* %arr, i64 0, i64 %idxprom14
  %10 = load i32, i32* %arrayidx15, align 4
  %call16 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.5, i32 0, i32 0), i32 %10)
  br label %for.inc.17

for.inc.17:                                       ; preds = %for.body.13
  %11 = load i32, i32* %i, align 4
  %inc18 = add nsw i32 %11, 1
  store i32 %inc18, i32* %i, align 4
  br label %for.cond.10

for.end.19:                                       ; preds = %for.cond.10
  ret i32 0
}

; Function Attrs: nounwind
declare void @srand(i32) #1

; Function Attrs: nounwind
declare i64 @time(i64*) #1

declare i32 @printf(i8*, ...) #2

declare i32 @__isoc99_scanf(i8*, ...) #2

; Function Attrs: nounwind
declare i32 @rand() #1

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind }

!llvm.ident = !{!0}

!0 = !{!"clang version 3.8.0 (trunk 251786)"}
