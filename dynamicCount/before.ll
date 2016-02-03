; ModuleID = 'llvm-link'
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.func = type { [30 x i8], [100 x %struct.var*] }
%struct.var = type { [30 x i8], [2 x %struct.op*] }
%struct.op = type { [30 x i8], i32 }

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1
@.str.1 = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@func_list = common global [50 x %struct.func] zeroinitializer, align 16
@.str.2 = private unnamed_addr constant [5 x i8] c"load\00", align 1
@.str.1.3 = private unnamed_addr constant [6 x i8] c"store\00", align 1
@.str.2.4 = private unnamed_addr constant [30 x i8] c"op is not both load and store\00", align 1
@.str.3 = private unnamed_addr constant [15 x i8] c"Function : %s\0A\00", align 1
@.str.4 = private unnamed_addr constant [17 x i8] c"\09\09variable : %s\0A\00", align 1
@.str.5 = private unnamed_addr constant [21 x i8] c"\09\09\09\09- load num : %d\0A\00", align 1
@.str.6 = private unnamed_addr constant [31 x i8] c"\09\09\09\09- store num : %d <<<-----\0A\00", align 1

; Function Attrs: nounwind uwtable
define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %k = alloca i32, align 4
  %num = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 (i8*, ...) @__isoc99_scanf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0), i32* %num)
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4
  %1 = load i32, i32* %num, align 4
  %cmp = icmp slt i32 %0, %1
  br i1 %cmp, label %for.body, label %for.end

for.body:                                         ; preds = %for.cond
  %2 = load i32, i32* %i, align 4
  %call1 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.1, i32 0, i32 0), i32 %2)
  br label %for.inc

for.inc:                                          ; preds = %for.body
  %3 = load i32, i32* %i, align 4
  %inc = add nsw i32 %3, 1
  store i32 %inc, i32* %i, align 4
  br label %for.cond

for.end:                                          ; preds = %for.cond
  store i32 0, i32* %i, align 4
  br label %for.cond.2

for.cond.2:                                       ; preds = %for.inc.5, %for.end
  %4 = load i32, i32* %i, align 4
  %cmp3 = icmp slt i32 %4, 40
  br i1 %cmp3, label %for.body.4, label %for.end.7

for.body.4:                                       ; preds = %for.cond.2
  %5 = load i32, i32* %i, align 4
  store i32 %5, i32* %k, align 4
  br label %for.inc.5

for.inc.5:                                        ; preds = %for.body.4
  %6 = load i32, i32* %i, align 4
  %inc6 = add nsw i32 %6, 1
  store i32 %inc6, i32* %i, align 4
  br label %for.cond.2

for.end.7:                                        ; preds = %for.cond.2
  ret i32 0
}

declare i32 @__isoc99_scanf(i8*, ...) #1

declare i32 @printf(i8*, ...) #1

; Function Attrs: nounwind uwtable
define void @BasicBlockCount(i8* %function, i8* %variable, i8* %operation, i32 %count) #0 {
entry:
  %function.addr = alloca i8*, align 8
  %variable.addr = alloca i8*, align 8
  %operation.addr = alloca i8*, align 8
  %count.addr = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  %flag1 = alloca i32, align 4
  %flag2 = alloca i32, align 4
  %op44 = alloca %struct.op*, align 8
  %op86 = alloca %struct.op*, align 8
  %var = alloca %struct.var*, align 8
  %op109 = alloca %struct.op*, align 8
  %var175 = alloca %struct.var*, align 8
  %op176 = alloca %struct.op*, align 8
  store i8* %function, i8** %function.addr, align 8
  store i8* %variable, i8** %variable.addr, align 8
  store i8* %operation, i8** %operation.addr, align 8
  store i32 %count, i32* %count.addr, align 4
  store i32 0, i32* %flag1, align 4
  store i32 0, i32* %flag2, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc.168, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 50
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom
  %var_list = getelementptr inbounds %struct.func, %struct.func* %arrayidx, i32 0, i32 1
  %arrayidx1 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list, i64 0, i64 0
  %2 = load %struct.var*, %struct.var** %arrayidx1, align 16
  %tobool = icmp ne %struct.var* %2, null
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond
  %3 = phi i1 [ false, %for.cond ], [ %tobool, %land.rhs ]
  br i1 %3, label %for.body, label %for.end.170

for.body:                                         ; preds = %land.end
  %4 = load i8*, i8** %function.addr, align 8
  %5 = load i32, i32* %i, align 4
  %idxprom2 = sext i32 %5 to i64
  %arrayidx3 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom2
  %func_name = getelementptr inbounds %struct.func, %struct.func* %arrayidx3, i32 0, i32 0
  %arraydecay = getelementptr inbounds [30 x i8], [30 x i8]* %func_name, i32 0, i32 0
  %call = call i32 @strcmp(i8* %4, i8* %arraydecay) #4
  %tobool4 = icmp ne i32 %call, 0
  br i1 %tobool4, label %if.end.167, label %if.then

if.then:                                          ; preds = %for.body
  store i32 1, i32* %flag1, align 4
  store i32 0, i32* %j, align 4
  br label %for.cond.5

for.cond.5:                                       ; preds = %for.inc, %if.then
  %6 = load i32, i32* %j, align 4
  %cmp6 = icmp slt i32 %6, 100
  br i1 %cmp6, label %land.rhs.7, label %land.end.14

land.rhs.7:                                       ; preds = %for.cond.5
  %7 = load i32, i32* %j, align 4
  %idxprom8 = sext i32 %7 to i64
  %8 = load i32, i32* %i, align 4
  %idxprom9 = sext i32 %8 to i64
  %arrayidx10 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom9
  %var_list11 = getelementptr inbounds %struct.func, %struct.func* %arrayidx10, i32 0, i32 1
  %arrayidx12 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list11, i64 0, i64 %idxprom8
  %9 = load %struct.var*, %struct.var** %arrayidx12, align 8
  %tobool13 = icmp ne %struct.var* %9, null
  br label %land.end.14

land.end.14:                                      ; preds = %land.rhs.7, %for.cond.5
  %10 = phi i1 [ false, %for.cond.5 ], [ %tobool13, %land.rhs.7 ]
  br i1 %10, label %for.body.15, label %for.end

for.body.15:                                      ; preds = %land.end.14
  %11 = load i8*, i8** %variable.addr, align 8
  %12 = load i32, i32* %j, align 4
  %idxprom16 = sext i32 %12 to i64
  %13 = load i32, i32* %i, align 4
  %idxprom17 = sext i32 %13 to i64
  %arrayidx18 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom17
  %var_list19 = getelementptr inbounds %struct.func, %struct.func* %arrayidx18, i32 0, i32 1
  %arrayidx20 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list19, i64 0, i64 %idxprom16
  %14 = load %struct.var*, %struct.var** %arrayidx20, align 8
  %var_name = getelementptr inbounds %struct.var, %struct.var* %14, i32 0, i32 0
  %arraydecay21 = getelementptr inbounds [30 x i8], [30 x i8]* %var_name, i32 0, i32 0
  %call22 = call i32 @strcmp(i8* %11, i8* %arraydecay21) #4
  %tobool23 = icmp ne i32 %call22, 0
  br i1 %tobool23, label %if.end.104, label %if.then.24

if.then.24:                                       ; preds = %for.body.15
  store i32 1, i32* %flag2, align 4
  %15 = load i8*, i8** %operation.addr, align 8
  %call25 = call i32 @strcmp(i8* %15, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0)) #4
  %tobool26 = icmp ne i32 %call25, 0
  br i1 %tobool26, label %if.else.56, label %if.then.27

if.then.27:                                       ; preds = %if.then.24
  %16 = load i32, i32* %j, align 4
  %idxprom28 = sext i32 %16 to i64
  %17 = load i32, i32* %i, align 4
  %idxprom29 = sext i32 %17 to i64
  %arrayidx30 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom29
  %var_list31 = getelementptr inbounds %struct.func, %struct.func* %arrayidx30, i32 0, i32 1
  %arrayidx32 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list31, i64 0, i64 %idxprom28
  %18 = load %struct.var*, %struct.var** %arrayidx32, align 8
  %op = getelementptr inbounds %struct.var, %struct.var* %18, i32 0, i32 1
  %arrayidx33 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op, i64 0, i64 0
  %19 = load %struct.op*, %struct.op** %arrayidx33, align 8
  %tobool34 = icmp ne %struct.op* %19, null
  br i1 %tobool34, label %if.then.35, label %if.else

if.then.35:                                       ; preds = %if.then.27
  %20 = load i32, i32* %j, align 4
  %idxprom36 = sext i32 %20 to i64
  %21 = load i32, i32* %i, align 4
  %idxprom37 = sext i32 %21 to i64
  %arrayidx38 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom37
  %var_list39 = getelementptr inbounds %struct.func, %struct.func* %arrayidx38, i32 0, i32 1
  %arrayidx40 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list39, i64 0, i64 %idxprom36
  %22 = load %struct.var*, %struct.var** %arrayidx40, align 8
  %op41 = getelementptr inbounds %struct.var, %struct.var* %22, i32 0, i32 1
  %arrayidx42 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op41, i64 0, i64 0
  %23 = load %struct.op*, %struct.op** %arrayidx42, align 8
  %count43 = getelementptr inbounds %struct.op, %struct.op* %23, i32 0, i32 1
  %24 = load i32, i32* %count43, align 4
  %inc = add nsw i32 %24, 1
  store i32 %inc, i32* %count43, align 4
  br label %if.end

if.else:                                          ; preds = %if.then.27
  %call45 = call noalias i8* @malloc(i64 36) #5
  %25 = bitcast i8* %call45 to %struct.op*
  store %struct.op* %25, %struct.op** %op44, align 8
  %26 = load %struct.op*, %struct.op** %op44, align 8
  %count46 = getelementptr inbounds %struct.op, %struct.op* %26, i32 0, i32 1
  store i32 1, i32* %count46, align 4
  %27 = load %struct.op*, %struct.op** %op44, align 8
  %op_name = getelementptr inbounds %struct.op, %struct.op* %27, i32 0, i32 0
  %arraydecay47 = getelementptr inbounds [30 x i8], [30 x i8]* %op_name, i32 0, i32 0
  %28 = load i8*, i8** %operation.addr, align 8
  %call48 = call i8* @strcpy(i8* %arraydecay47, i8* %28) #5
  %29 = load %struct.op*, %struct.op** %op44, align 8
  %30 = load i32, i32* %j, align 4
  %idxprom49 = sext i32 %30 to i64
  %31 = load i32, i32* %i, align 4
  %idxprom50 = sext i32 %31 to i64
  %arrayidx51 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom50
  %var_list52 = getelementptr inbounds %struct.func, %struct.func* %arrayidx51, i32 0, i32 1
  %arrayidx53 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list52, i64 0, i64 %idxprom49
  %32 = load %struct.var*, %struct.var** %arrayidx53, align 8
  %op54 = getelementptr inbounds %struct.var, %struct.var* %32, i32 0, i32 1
  %arrayidx55 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op54, i64 0, i64 0
  store %struct.op* %29, %struct.op** %arrayidx55, align 8
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then.35
  br label %if.end.103

if.else.56:                                       ; preds = %if.then.24
  %33 = load i8*, i8** %operation.addr, align 8
  %call57 = call i32 @strcmp(i8* %33, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1.3, i32 0, i32 0)) #4
  %tobool58 = icmp ne i32 %call57, 0
  br i1 %tobool58, label %if.else.100, label %if.then.59

if.then.59:                                       ; preds = %if.else.56
  %34 = load i32, i32* %j, align 4
  %idxprom60 = sext i32 %34 to i64
  %35 = load i32, i32* %i, align 4
  %idxprom61 = sext i32 %35 to i64
  %arrayidx62 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom61
  %var_list63 = getelementptr inbounds %struct.func, %struct.func* %arrayidx62, i32 0, i32 1
  %arrayidx64 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list63, i64 0, i64 %idxprom60
  %36 = load %struct.var*, %struct.var** %arrayidx64, align 8
  %op65 = getelementptr inbounds %struct.var, %struct.var* %36, i32 0, i32 1
  %arrayidx66 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op65, i64 0, i64 1
  %37 = load %struct.op*, %struct.op** %arrayidx66, align 8
  %tobool67 = icmp ne %struct.op* %37, null
  br i1 %tobool67, label %if.then.68, label %if.else.85

if.then.68:                                       ; preds = %if.then.59
  %38 = load i32, i32* %j, align 4
  %idxprom69 = sext i32 %38 to i64
  %39 = load i32, i32* %i, align 4
  %idxprom70 = sext i32 %39 to i64
  %arrayidx71 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom70
  %var_list72 = getelementptr inbounds %struct.func, %struct.func* %arrayidx71, i32 0, i32 1
  %arrayidx73 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list72, i64 0, i64 %idxprom69
  %40 = load %struct.var*, %struct.var** %arrayidx73, align 8
  %op74 = getelementptr inbounds %struct.var, %struct.var* %40, i32 0, i32 1
  %arrayidx75 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op74, i64 0, i64 1
  %41 = load %struct.op*, %struct.op** %arrayidx75, align 8
  %count76 = getelementptr inbounds %struct.op, %struct.op* %41, i32 0, i32 1
  %42 = load i32, i32* %count76, align 4
  %add = add nsw i32 %42, 1
  %43 = load i32, i32* %j, align 4
  %idxprom77 = sext i32 %43 to i64
  %44 = load i32, i32* %i, align 4
  %idxprom78 = sext i32 %44 to i64
  %arrayidx79 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom78
  %var_list80 = getelementptr inbounds %struct.func, %struct.func* %arrayidx79, i32 0, i32 1
  %arrayidx81 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list80, i64 0, i64 %idxprom77
  %45 = load %struct.var*, %struct.var** %arrayidx81, align 8
  %op82 = getelementptr inbounds %struct.var, %struct.var* %45, i32 0, i32 1
  %arrayidx83 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op82, i64 0, i64 1
  %46 = load %struct.op*, %struct.op** %arrayidx83, align 8
  %count84 = getelementptr inbounds %struct.op, %struct.op* %46, i32 0, i32 1
  store i32 %add, i32* %count84, align 4
  br label %if.end.99

if.else.85:                                       ; preds = %if.then.59
  %call87 = call noalias i8* @malloc(i64 36) #5
  %47 = bitcast i8* %call87 to %struct.op*
  store %struct.op* %47, %struct.op** %op86, align 8
  %48 = load %struct.op*, %struct.op** %op86, align 8
  %count88 = getelementptr inbounds %struct.op, %struct.op* %48, i32 0, i32 1
  store i32 1, i32* %count88, align 4
  %49 = load %struct.op*, %struct.op** %op86, align 8
  %op_name89 = getelementptr inbounds %struct.op, %struct.op* %49, i32 0, i32 0
  %arraydecay90 = getelementptr inbounds [30 x i8], [30 x i8]* %op_name89, i32 0, i32 0
  %50 = load i8*, i8** %operation.addr, align 8
  %call91 = call i8* @strcpy(i8* %arraydecay90, i8* %50) #5
  %51 = load %struct.op*, %struct.op** %op86, align 8
  %52 = load i32, i32* %j, align 4
  %idxprom92 = sext i32 %52 to i64
  %53 = load i32, i32* %i, align 4
  %idxprom93 = sext i32 %53 to i64
  %arrayidx94 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom93
  %var_list95 = getelementptr inbounds %struct.func, %struct.func* %arrayidx94, i32 0, i32 1
  %arrayidx96 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list95, i64 0, i64 %idxprom92
  %54 = load %struct.var*, %struct.var** %arrayidx96, align 8
  %op97 = getelementptr inbounds %struct.var, %struct.var* %54, i32 0, i32 1
  %arrayidx98 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op97, i64 0, i64 1
  store %struct.op* %51, %struct.op** %arrayidx98, align 8
  br label %if.end.99

if.end.99:                                        ; preds = %if.else.85, %if.then.68
  br label %if.end.102

if.else.100:                                      ; preds = %if.else.56
  %call101 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2.4, i32 0, i32 0))
  br label %if.end.102

if.end.102:                                       ; preds = %if.else.100, %if.end.99
  br label %if.end.103

if.end.103:                                       ; preds = %if.end.102, %if.end
  br label %for.end

if.end.104:                                       ; preds = %for.body.15
  br label %for.inc

for.inc:                                          ; preds = %if.end.104
  %55 = load i32, i32* %j, align 4
  %inc105 = add nsw i32 %55, 1
  store i32 %inc105, i32* %j, align 4
  br label %for.cond.5

for.end:                                          ; preds = %if.end.103, %land.end.14
  %56 = load i32, i32* %flag2, align 4
  %cmp106 = icmp eq i32 %56, 0
  br i1 %cmp106, label %land.lhs.true, label %if.end.166

land.lhs.true:                                    ; preds = %for.end
  %57 = load i32, i32* %j, align 4
  %cmp107 = icmp ne i32 %57, 100
  br i1 %cmp107, label %if.then.108, label %if.end.166

if.then.108:                                      ; preds = %land.lhs.true
  %call110 = call noalias i8* @malloc(i64 48) #5
  %58 = bitcast i8* %call110 to %struct.var*
  store %struct.var* %58, %struct.var** %var, align 8
  %call111 = call noalias i8* @malloc(i64 36) #5
  %59 = bitcast i8* %call111 to %struct.op*
  store %struct.op* %59, %struct.op** %op109, align 8
  %60 = load %struct.op*, %struct.op** %op109, align 8
  %count112 = getelementptr inbounds %struct.op, %struct.op* %60, i32 0, i32 1
  store i32 1, i32* %count112, align 4
  %61 = load %struct.var*, %struct.var** %var, align 8
  %var_name113 = getelementptr inbounds %struct.var, %struct.var* %61, i32 0, i32 0
  %arraydecay114 = getelementptr inbounds [30 x i8], [30 x i8]* %var_name113, i32 0, i32 0
  %62 = load i8*, i8** %variable.addr, align 8
  %call115 = call i8* @strcpy(i8* %arraydecay114, i8* %62) #5
  %63 = load %struct.var*, %struct.var** %var, align 8
  %64 = load i32, i32* %j, align 4
  %idxprom116 = sext i32 %64 to i64
  %65 = load i32, i32* %i, align 4
  %idxprom117 = sext i32 %65 to i64
  %arrayidx118 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom117
  %var_list119 = getelementptr inbounds %struct.func, %struct.func* %arrayidx118, i32 0, i32 1
  %arrayidx120 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list119, i64 0, i64 %idxprom116
  store %struct.var* %63, %struct.var** %arrayidx120, align 8
  %66 = load i8*, i8** %operation.addr, align 8
  %call121 = call i32 @strcmp(i8* %66, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0)) #4
  %tobool122 = icmp ne i32 %call121, 0
  br i1 %tobool122, label %if.else.141, label %if.then.123

if.then.123:                                      ; preds = %if.then.108
  %67 = load %struct.op*, %struct.op** %op109, align 8
  %op_name124 = getelementptr inbounds %struct.op, %struct.op* %67, i32 0, i32 0
  %arraydecay125 = getelementptr inbounds [30 x i8], [30 x i8]* %op_name124, i32 0, i32 0
  %68 = load i8*, i8** %operation.addr, align 8
  %call126 = call i8* @strcpy(i8* %arraydecay125, i8* %68) #5
  %69 = load %struct.op*, %struct.op** %op109, align 8
  %70 = load i32, i32* %j, align 4
  %idxprom127 = sext i32 %70 to i64
  %71 = load i32, i32* %i, align 4
  %idxprom128 = sext i32 %71 to i64
  %arrayidx129 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom128
  %var_list130 = getelementptr inbounds %struct.func, %struct.func* %arrayidx129, i32 0, i32 1
  %arrayidx131 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list130, i64 0, i64 %idxprom127
  %72 = load %struct.var*, %struct.var** %arrayidx131, align 8
  %op132 = getelementptr inbounds %struct.var, %struct.var* %72, i32 0, i32 1
  %arrayidx133 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op132, i64 0, i64 0
  store %struct.op* %69, %struct.op** %arrayidx133, align 8
  %73 = load i32, i32* %j, align 4
  %idxprom134 = sext i32 %73 to i64
  %74 = load i32, i32* %i, align 4
  %idxprom135 = sext i32 %74 to i64
  %arrayidx136 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom135
  %var_list137 = getelementptr inbounds %struct.func, %struct.func* %arrayidx136, i32 0, i32 1
  %arrayidx138 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list137, i64 0, i64 %idxprom134
  %75 = load %struct.var*, %struct.var** %arrayidx138, align 8
  %op139 = getelementptr inbounds %struct.var, %struct.var* %75, i32 0, i32 1
  %arrayidx140 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op139, i64 0, i64 1
  store %struct.op* null, %struct.op** %arrayidx140, align 8
  br label %if.end.165

if.else.141:                                      ; preds = %if.then.108
  %76 = load i8*, i8** %operation.addr, align 8
  %call142 = call i32 @strcmp(i8* %76, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1.3, i32 0, i32 0)) #4
  %tobool143 = icmp ne i32 %call142, 0
  br i1 %tobool143, label %if.else.162, label %if.then.144

if.then.144:                                      ; preds = %if.else.141
  %77 = load %struct.op*, %struct.op** %op109, align 8
  %op_name145 = getelementptr inbounds %struct.op, %struct.op* %77, i32 0, i32 0
  %arraydecay146 = getelementptr inbounds [30 x i8], [30 x i8]* %op_name145, i32 0, i32 0
  %78 = load i8*, i8** %operation.addr, align 8
  %call147 = call i8* @strcpy(i8* %arraydecay146, i8* %78) #5
  %79 = load %struct.op*, %struct.op** %op109, align 8
  %80 = load i32, i32* %j, align 4
  %idxprom148 = sext i32 %80 to i64
  %81 = load i32, i32* %i, align 4
  %idxprom149 = sext i32 %81 to i64
  %arrayidx150 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom149
  %var_list151 = getelementptr inbounds %struct.func, %struct.func* %arrayidx150, i32 0, i32 1
  %arrayidx152 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list151, i64 0, i64 %idxprom148
  %82 = load %struct.var*, %struct.var** %arrayidx152, align 8
  %op153 = getelementptr inbounds %struct.var, %struct.var* %82, i32 0, i32 1
  %arrayidx154 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op153, i64 0, i64 1
  store %struct.op* %79, %struct.op** %arrayidx154, align 8
  %83 = load i32, i32* %j, align 4
  %idxprom155 = sext i32 %83 to i64
  %84 = load i32, i32* %i, align 4
  %idxprom156 = sext i32 %84 to i64
  %arrayidx157 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom156
  %var_list158 = getelementptr inbounds %struct.func, %struct.func* %arrayidx157, i32 0, i32 1
  %arrayidx159 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list158, i64 0, i64 %idxprom155
  %85 = load %struct.var*, %struct.var** %arrayidx159, align 8
  %op160 = getelementptr inbounds %struct.var, %struct.var* %85, i32 0, i32 1
  %arrayidx161 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op160, i64 0, i64 0
  store %struct.op* null, %struct.op** %arrayidx161, align 8
  br label %if.end.164

if.else.162:                                      ; preds = %if.else.141
  %call163 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2.4, i32 0, i32 0))
  br label %if.end.164

if.end.164:                                       ; preds = %if.else.162, %if.then.144
  br label %if.end.165

if.end.165:                                       ; preds = %if.end.164, %if.then.123
  br label %if.end.166

if.end.166:                                       ; preds = %if.end.165, %land.lhs.true, %for.end
  br label %for.end.170

if.end.167:                                       ; preds = %for.body
  br label %for.inc.168

for.inc.168:                                      ; preds = %if.end.167
  %86 = load i32, i32* %i, align 4
  %inc169 = add nsw i32 %86, 1
  store i32 %inc169, i32* %i, align 4
  br label %for.cond

for.end.170:                                      ; preds = %if.end.166, %land.end
  %87 = load i32, i32* %flag1, align 4
  %cmp171 = icmp eq i32 %87, 0
  br i1 %cmp171, label %land.lhs.true.172, label %if.end.233

land.lhs.true.172:                                ; preds = %for.end.170
  %88 = load i32, i32* %i, align 4
  %cmp173 = icmp ne i32 %88, 50
  br i1 %cmp173, label %if.then.174, label %if.end.233

if.then.174:                                      ; preds = %land.lhs.true.172
  %call177 = call noalias i8* @malloc(i64 48) #5
  %89 = bitcast i8* %call177 to %struct.var*
  store %struct.var* %89, %struct.var** %var175, align 8
  %call178 = call noalias i8* @malloc(i64 36) #5
  %90 = bitcast i8* %call178 to %struct.op*
  store %struct.op* %90, %struct.op** %op176, align 8
  %91 = load i32, i32* %i, align 4
  %idxprom179 = sext i32 %91 to i64
  %arrayidx180 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom179
  %func_name181 = getelementptr inbounds %struct.func, %struct.func* %arrayidx180, i32 0, i32 0
  %arraydecay182 = getelementptr inbounds [30 x i8], [30 x i8]* %func_name181, i32 0, i32 0
  %92 = load i8*, i8** %function.addr, align 8
  %call183 = call i8* @strcpy(i8* %arraydecay182, i8* %92) #5
  %93 = load %struct.var*, %struct.var** %var175, align 8
  %var_name184 = getelementptr inbounds %struct.var, %struct.var* %93, i32 0, i32 0
  %arraydecay185 = getelementptr inbounds [30 x i8], [30 x i8]* %var_name184, i32 0, i32 0
  %94 = load i8*, i8** %variable.addr, align 8
  %call186 = call i8* @strcpy(i8* %arraydecay185, i8* %94) #5
  %95 = load %struct.var*, %struct.var** %var175, align 8
  %96 = load i32, i32* %i, align 4
  %idxprom187 = sext i32 %96 to i64
  %arrayidx188 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom187
  %var_list189 = getelementptr inbounds %struct.func, %struct.func* %arrayidx188, i32 0, i32 1
  %arrayidx190 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list189, i64 0, i64 0
  store %struct.var* %95, %struct.var** %arrayidx190, align 16
  %97 = load %struct.op*, %struct.op** %op176, align 8
  %count191 = getelementptr inbounds %struct.op, %struct.op* %97, i32 0, i32 1
  store i32 1, i32* %count191, align 4
  %98 = load i8*, i8** %operation.addr, align 8
  %call192 = call i32 @strcmp(i8* %98, i8* getelementptr inbounds ([5 x i8], [5 x i8]* @.str.2, i32 0, i32 0)) #4
  %tobool193 = icmp ne i32 %call192, 0
  br i1 %tobool193, label %if.else.210, label %if.then.194

if.then.194:                                      ; preds = %if.then.174
  %99 = load %struct.op*, %struct.op** %op176, align 8
  %op_name195 = getelementptr inbounds %struct.op, %struct.op* %99, i32 0, i32 0
  %arraydecay196 = getelementptr inbounds [30 x i8], [30 x i8]* %op_name195, i32 0, i32 0
  %100 = load i8*, i8** %operation.addr, align 8
  %call197 = call i8* @strcpy(i8* %arraydecay196, i8* %100) #5
  %101 = load %struct.op*, %struct.op** %op176, align 8
  %102 = load i32, i32* %i, align 4
  %idxprom198 = sext i32 %102 to i64
  %arrayidx199 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom198
  %var_list200 = getelementptr inbounds %struct.func, %struct.func* %arrayidx199, i32 0, i32 1
  %arrayidx201 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list200, i64 0, i64 0
  %103 = load %struct.var*, %struct.var** %arrayidx201, align 16
  %op202 = getelementptr inbounds %struct.var, %struct.var* %103, i32 0, i32 1
  %arrayidx203 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op202, i64 0, i64 0
  store %struct.op* %101, %struct.op** %arrayidx203, align 8
  %104 = load i32, i32* %i, align 4
  %idxprom204 = sext i32 %104 to i64
  %arrayidx205 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom204
  %var_list206 = getelementptr inbounds %struct.func, %struct.func* %arrayidx205, i32 0, i32 1
  %arrayidx207 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list206, i64 0, i64 0
  %105 = load %struct.var*, %struct.var** %arrayidx207, align 16
  %op208 = getelementptr inbounds %struct.var, %struct.var* %105, i32 0, i32 1
  %arrayidx209 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op208, i64 0, i64 1
  store %struct.op* null, %struct.op** %arrayidx209, align 8
  br label %if.end.232

if.else.210:                                      ; preds = %if.then.174
  %106 = load i8*, i8** %operation.addr, align 8
  %call211 = call i32 @strcmp(i8* %106, i8* getelementptr inbounds ([6 x i8], [6 x i8]* @.str.1.3, i32 0, i32 0)) #4
  %tobool212 = icmp ne i32 %call211, 0
  br i1 %tobool212, label %if.else.229, label %if.then.213

if.then.213:                                      ; preds = %if.else.210
  %107 = load %struct.op*, %struct.op** %op176, align 8
  %op_name214 = getelementptr inbounds %struct.op, %struct.op* %107, i32 0, i32 0
  %arraydecay215 = getelementptr inbounds [30 x i8], [30 x i8]* %op_name214, i32 0, i32 0
  %108 = load i8*, i8** %operation.addr, align 8
  %call216 = call i8* @strcpy(i8* %arraydecay215, i8* %108) #5
  %109 = load %struct.op*, %struct.op** %op176, align 8
  %110 = load i32, i32* %i, align 4
  %idxprom217 = sext i32 %110 to i64
  %arrayidx218 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom217
  %var_list219 = getelementptr inbounds %struct.func, %struct.func* %arrayidx218, i32 0, i32 1
  %arrayidx220 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list219, i64 0, i64 0
  %111 = load %struct.var*, %struct.var** %arrayidx220, align 16
  %op221 = getelementptr inbounds %struct.var, %struct.var* %111, i32 0, i32 1
  %arrayidx222 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op221, i64 0, i64 1
  store %struct.op* %109, %struct.op** %arrayidx222, align 8
  %112 = load i32, i32* %i, align 4
  %idxprom223 = sext i32 %112 to i64
  %arrayidx224 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom223
  %var_list225 = getelementptr inbounds %struct.func, %struct.func* %arrayidx224, i32 0, i32 1
  %arrayidx226 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list225, i64 0, i64 0
  %113 = load %struct.var*, %struct.var** %arrayidx226, align 16
  %op227 = getelementptr inbounds %struct.var, %struct.var* %113, i32 0, i32 1
  %arrayidx228 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op227, i64 0, i64 0
  store %struct.op* null, %struct.op** %arrayidx228, align 8
  br label %if.end.231

if.else.229:                                      ; preds = %if.else.210
  %call230 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([30 x i8], [30 x i8]* @.str.2.4, i32 0, i32 0))
  br label %if.end.231

if.end.231:                                       ; preds = %if.else.229, %if.then.213
  br label %if.end.232

if.end.232:                                       ; preds = %if.end.231, %if.then.194
  br label %if.end.233

if.end.233:                                       ; preds = %if.end.232, %land.lhs.true.172, %for.end.170
  ret void
}

; Function Attrs: nounwind readonly
declare i32 @strcmp(i8*, i8*) #2

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #3

; Function Attrs: nounwind
declare i8* @strcpy(i8*, i8*) #3

; Function Attrs: nounwind uwtable
define void @PrintResult() #0 {
entry:
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %i, align 4
  br label %for.cond

for.cond:                                         ; preds = %for.inc.56, %entry
  %0 = load i32, i32* %i, align 4
  %cmp = icmp slt i32 %0, 50
  br i1 %cmp, label %land.rhs, label %land.end

land.rhs:                                         ; preds = %for.cond
  %1 = load i32, i32* %i, align 4
  %idxprom = sext i32 %1 to i64
  %arrayidx = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom
  %var_list = getelementptr inbounds %struct.func, %struct.func* %arrayidx, i32 0, i32 1
  %arrayidx1 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list, i64 0, i64 0
  %2 = load %struct.var*, %struct.var** %arrayidx1, align 16
  %tobool = icmp ne %struct.var* %2, null
  br label %land.end

land.end:                                         ; preds = %land.rhs, %for.cond
  %3 = phi i1 [ false, %for.cond ], [ %tobool, %land.rhs ]
  br i1 %3, label %for.body, label %for.end.58

for.body:                                         ; preds = %land.end
  %4 = load i32, i32* %i, align 4
  %idxprom2 = sext i32 %4 to i64
  %arrayidx3 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom2
  %func_name = getelementptr inbounds %struct.func, %struct.func* %arrayidx3, i32 0, i32 0
  %arraydecay = getelementptr inbounds [30 x i8], [30 x i8]* %func_name, i32 0, i32 0
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([15 x i8], [15 x i8]* @.str.3, i32 0, i32 0), i8* %arraydecay)
  store i32 0, i32* %j, align 4
  br label %for.cond.4

for.cond.4:                                       ; preds = %for.inc, %for.body
  %5 = load i32, i32* %j, align 4
  %cmp5 = icmp slt i32 %5, 100
  br i1 %cmp5, label %land.rhs.6, label %land.end.13

land.rhs.6:                                       ; preds = %for.cond.4
  %6 = load i32, i32* %j, align 4
  %idxprom7 = sext i32 %6 to i64
  %7 = load i32, i32* %i, align 4
  %idxprom8 = sext i32 %7 to i64
  %arrayidx9 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom8
  %var_list10 = getelementptr inbounds %struct.func, %struct.func* %arrayidx9, i32 0, i32 1
  %arrayidx11 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list10, i64 0, i64 %idxprom7
  %8 = load %struct.var*, %struct.var** %arrayidx11, align 8
  %tobool12 = icmp ne %struct.var* %8, null
  br label %land.end.13

land.end.13:                                      ; preds = %land.rhs.6, %for.cond.4
  %9 = phi i1 [ false, %for.cond.4 ], [ %tobool12, %land.rhs.6 ]
  br i1 %9, label %for.body.14, label %for.end

for.body.14:                                      ; preds = %land.end.13
  %10 = load i32, i32* %j, align 4
  %idxprom15 = sext i32 %10 to i64
  %11 = load i32, i32* %i, align 4
  %idxprom16 = sext i32 %11 to i64
  %arrayidx17 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom16
  %var_list18 = getelementptr inbounds %struct.func, %struct.func* %arrayidx17, i32 0, i32 1
  %arrayidx19 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list18, i64 0, i64 %idxprom15
  %12 = load %struct.var*, %struct.var** %arrayidx19, align 8
  %var_name = getelementptr inbounds %struct.var, %struct.var* %12, i32 0, i32 0
  %arraydecay20 = getelementptr inbounds [30 x i8], [30 x i8]* %var_name, i32 0, i32 0
  %call21 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([17 x i8], [17 x i8]* @.str.4, i32 0, i32 0), i8* %arraydecay20)
  %13 = load i32, i32* %j, align 4
  %idxprom22 = sext i32 %13 to i64
  %14 = load i32, i32* %i, align 4
  %idxprom23 = sext i32 %14 to i64
  %arrayidx24 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom23
  %var_list25 = getelementptr inbounds %struct.func, %struct.func* %arrayidx24, i32 0, i32 1
  %arrayidx26 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list25, i64 0, i64 %idxprom22
  %15 = load %struct.var*, %struct.var** %arrayidx26, align 8
  %op = getelementptr inbounds %struct.var, %struct.var* %15, i32 0, i32 1
  %arrayidx27 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op, i64 0, i64 0
  %16 = load %struct.op*, %struct.op** %arrayidx27, align 8
  %tobool28 = icmp ne %struct.op* %16, null
  br i1 %tobool28, label %if.then, label %if.end

if.then:                                          ; preds = %for.body.14
  %17 = load i32, i32* %j, align 4
  %idxprom29 = sext i32 %17 to i64
  %18 = load i32, i32* %i, align 4
  %idxprom30 = sext i32 %18 to i64
  %arrayidx31 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom30
  %var_list32 = getelementptr inbounds %struct.func, %struct.func* %arrayidx31, i32 0, i32 1
  %arrayidx33 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list32, i64 0, i64 %idxprom29
  %19 = load %struct.var*, %struct.var** %arrayidx33, align 8
  %op34 = getelementptr inbounds %struct.var, %struct.var* %19, i32 0, i32 1
  %arrayidx35 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op34, i64 0, i64 0
  %20 = load %struct.op*, %struct.op** %arrayidx35, align 8
  %count = getelementptr inbounds %struct.op, %struct.op* %20, i32 0, i32 1
  %21 = load i32, i32* %count, align 4
  %call36 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([21 x i8], [21 x i8]* @.str.5, i32 0, i32 0), i32 %21)
  br label %if.end

if.end:                                           ; preds = %if.then, %for.body.14
  %22 = load i32, i32* %j, align 4
  %idxprom37 = sext i32 %22 to i64
  %23 = load i32, i32* %i, align 4
  %idxprom38 = sext i32 %23 to i64
  %arrayidx39 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom38
  %var_list40 = getelementptr inbounds %struct.func, %struct.func* %arrayidx39, i32 0, i32 1
  %arrayidx41 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list40, i64 0, i64 %idxprom37
  %24 = load %struct.var*, %struct.var** %arrayidx41, align 8
  %op42 = getelementptr inbounds %struct.var, %struct.var* %24, i32 0, i32 1
  %arrayidx43 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op42, i64 0, i64 1
  %25 = load %struct.op*, %struct.op** %arrayidx43, align 8
  %tobool44 = icmp ne %struct.op* %25, null
  br i1 %tobool44, label %if.then.45, label %if.end.55

if.then.45:                                       ; preds = %if.end
  %26 = load i32, i32* %j, align 4
  %idxprom46 = sext i32 %26 to i64
  %27 = load i32, i32* %i, align 4
  %idxprom47 = sext i32 %27 to i64
  %arrayidx48 = getelementptr inbounds [50 x %struct.func], [50 x %struct.func]* @func_list, i64 0, i64 %idxprom47
  %var_list49 = getelementptr inbounds %struct.func, %struct.func* %arrayidx48, i32 0, i32 1
  %arrayidx50 = getelementptr inbounds [100 x %struct.var*], [100 x %struct.var*]* %var_list49, i64 0, i64 %idxprom46
  %28 = load %struct.var*, %struct.var** %arrayidx50, align 8
  %op51 = getelementptr inbounds %struct.var, %struct.var* %28, i32 0, i32 1
  %arrayidx52 = getelementptr inbounds [2 x %struct.op*], [2 x %struct.op*]* %op51, i64 0, i64 1
  %29 = load %struct.op*, %struct.op** %arrayidx52, align 8
  %count53 = getelementptr inbounds %struct.op, %struct.op* %29, i32 0, i32 1
  %30 = load i32, i32* %count53, align 4
  %call54 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([31 x i8], [31 x i8]* @.str.6, i32 0, i32 0), i32 %30)
  br label %if.end.55

if.end.55:                                        ; preds = %if.then.45, %if.end
  br label %for.inc

for.inc:                                          ; preds = %if.end.55
  %31 = load i32, i32* %j, align 4
  %inc = add nsw i32 %31, 1
  store i32 %inc, i32* %j, align 4
  br label %for.cond.4

for.end:                                          ; preds = %land.end.13
  br label %for.inc.56

for.inc.56:                                       ; preds = %for.end
  %32 = load i32, i32* %i, align 4
  %inc57 = add nsw i32 %32, 1
  store i32 %inc57, i32* %i, align 4
  br label %for.cond

for.end.58:                                       ; preds = %land.end
  ret void
}

attributes #0 = { nounwind uwtable "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { nounwind readonly "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readonly }
attributes #5 = { nounwind }

!llvm.ident = !{!0, !0}

!0 = !{!"clang version 3.8.0 (trunk 251786)"}
