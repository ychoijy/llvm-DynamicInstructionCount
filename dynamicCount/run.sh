clang -S -emit-llvm test.c
clang -S -emit-llvm injection.c
llvm-link test.ll injection.ll -S -o before.ll
opt -load ../../../Release+Asserts/lib/dynamicCount.so -DIcount < before.ll > after.ll
lli after.ll
