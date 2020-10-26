@.LinearSearch_vtable = global [0 x i8*] []
@.LS_vtable = global [4 x i8*] [i8* bitcast (i32 (i8*, i32)* @LS.Search to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Start to i8*), i8* bitcast (i32 (i8*, i32)* @LS.Init to i8*), i8* bitcast (i32 (i8*)* @LS.Print to i8*)]

declare i8* @calloc(i32, i32)
declare i32 @printf(i8*, ...)
declare void @exit(i32)

@_cint = constant [4 x i8] c"%d\0a\00"
@_cOOB = constant [15 x i8] c"Out of bounds\0a\00"
define void @print_int(i32 %i) {
    %_str = bitcast [4 x i8]* @_cint to i8*
    call i32 (i8*, ...) @printf(i8* %_str, i32 %i)
    ret void
}

define void @throw_oob() {
    %_str = bitcast [15 x i8]* @_cOOB to i8*
    call i32 (i8*, ...) @printf(i8* %_str)
    call void @exit(i32 1)
    ret void
}

define i32 @main() {
%_0 = call i8* @calloc(i32 1, i32 20)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [4 x i8*], [4 x i8*]* @.LS_vtable, i32 0, i32 0
store i8** %_2, i8*** %_1
%_3 = bitcast i8* %_0 to i8***
%_4 = load i8**, i8*** %_3
%_5 = getelementptr i8*, i8** %_4, i32 1
%_6 = load i8*, i8** %_5
%_7 = bitcast i8* %_6 to i32 (i8*, i32)*
%_9 = add i32 0, 10
%_8 = call i32  %_7 (i8* %_0 , i32 %_9)
call void (i32) @print_int(i32 %_8)
ret i32 0
}


define i32 @LS.Start(i8* %this, i32 %.sz) {
%sz = alloca i32
store i32 %.sz, i32* %sz
%aux01 = alloca i32
%aux02 = alloca i32
%_0 = bitcast i8* %this to i8***
%_1 = load i8**, i8*** %_0
%_2 = getelementptr i8*, i8** %_1, i32 2
%_3 = load i8*, i8** %_2
%_4 = bitcast i8* %_3 to i32 (i8*, i32)*
%_6 = load i32, i32* %sz
%_5 = call i32  %_4 (i8* %this , i32 %_6)
store i32 %_5, i32* %aux01
%_7 = bitcast i8* %this to i8***
%_8 = load i8**, i8*** %_7
%_9 = getelementptr i8*, i8** %_8, i32 3
%_10 = load i8*, i8** %_9
%_11 = bitcast i8* %_10 to i32 (i8*)*
%_12 = call i32  %_11 (i8* %this )
store i32 %_12, i32* %aux02
%_13 = add i32 0, 9999
call void (i32) @print_int(i32 %_13)
%_14 = bitcast i8* %this to i8***
%_15 = load i8**, i8*** %_14
%_16 = getelementptr i8*, i8** %_15, i32 0
%_17 = load i8*, i8** %_16
%_18 = bitcast i8* %_17 to i32 (i8*, i32)*
%_20 = add i32 0, 8
%_19 = call i32  %_18 (i8* %this , i32 %_20)
call void (i32) @print_int(i32 %_19)
%_21 = bitcast i8* %this to i8***
%_22 = load i8**, i8*** %_21
%_23 = getelementptr i8*, i8** %_22, i32 0
%_24 = load i8*, i8** %_23
%_25 = bitcast i8* %_24 to i32 (i8*, i32)*
%_27 = add i32 0, 12
%_26 = call i32  %_25 (i8* %this , i32 %_27)
call void (i32) @print_int(i32 %_26)
%_28 = bitcast i8* %this to i8***
%_29 = load i8**, i8*** %_28
%_30 = getelementptr i8*, i8** %_29, i32 0
%_31 = load i8*, i8** %_30
%_32 = bitcast i8* %_31 to i32 (i8*, i32)*
%_34 = add i32 0, 17
%_33 = call i32  %_32 (i8* %this , i32 %_34)
call void (i32) @print_int(i32 %_33)
%_35 = bitcast i8* %this to i8***
%_36 = load i8**, i8*** %_35
%_37 = getelementptr i8*, i8** %_36, i32 0
%_38 = load i8*, i8** %_37
%_39 = bitcast i8* %_38 to i32 (i8*, i32)*
%_41 = add i32 0, 50
%_40 = call i32  %_39 (i8* %this , i32 %_41)
call void (i32) @print_int(i32 %_40)
%_42 = add i32 0, 55
ret i32 %_42
}


define i32 @LS.Print(i8* %this) {
%j = alloca i32
%_0 = add i32 0, 1
store i32 %_0, i32* %j
br label %loop0
loop0:
%_2 = load i32, i32* %j
%_4 = getelementptr i8, i8* %this, i32 16
%_5 = bitcast i8* %_4 to i32*
%_6 = add i32 0, 1
%_7 = load i32, i32* %_5
%_3 = sub i32 %_7, %_6
%_1 = icmp sle i32 %_2, %_3
br i1 %_1, label %loop1, label %loop2
loop1:
%_8 = getelementptr i8, i8* %this, i32 8
%_9 = bitcast i8* %_8 to i8**
%_10 = bitcast i8* %_9 to i32**
%_11 = load i32*, i32** %_10
%_15 = load i32, i32* %j
%_12 = add i32 %_15, 1
%_13 = getelementptr i32, i32* %_11, i32 %_12
%_14 = load i32, i32* %_13
call void (i32) @print_int(i32 %_14)
%_17 = load i32, i32* %j
%_18 = add i32 0, 1
%_16 = add i32 %_17, %_18
store i32 %_16, i32* %j
br label %loop0
loop2:
%_19 = add i32 0, 0
ret i32 %_19
}


define i32 @LS.Search(i8* %this, i32 %.num) {
%num = alloca i32
store i32 %.num, i32* %num
%j = alloca i32
%ls01 = alloca i1
%ifound = alloca i32
%aux01 = alloca i32
%aux02 = alloca i32
%nt = alloca i32
%_0 = add i32 0, 1
store i32 %_0, i32* %j
%_1 = or i1 0, 0
store i1 %_1, i1* %ls01
%_2 = add i32 0, 0
store i32 %_2, i32* %ifound
br label %loop3
loop3:
%_4 = load i32, i32* %j
%_6 = getelementptr i8, i8* %this, i32 16
%_7 = bitcast i8* %_6 to i32*
%_8 = add i32 0, 1
%_9 = load i32, i32* %_7
%_5 = sub i32 %_9, %_8
%_3 = icmp sle i32 %_4, %_5
br i1 %_3, label %loop4, label %loop5
loop4:
%_10 = getelementptr i8, i8* %this, i32 8
%_11 = bitcast i8* %_10 to i8**
%_12 = bitcast i8* %_11 to i32**
%_13 = load i32*, i32** %_12
%_17 = load i32, i32* %j
%_14 = add i32 %_17, 1
%_15 = getelementptr i32, i32* %_13, i32 %_14
%_16 = load i32, i32* %_15
store i32 %_16, i32* %aux01
%_19 = load i32, i32* %num
%_20 = add i32 0, 1
%_18 = add i32 %_19, %_20
store i32 %_18, i32* %aux02
%_23 = load i32, i32* %aux01
%_24 = load i32, i32* %num
%_22 = icmp sle i32 %_23, %_24
%_26 = load i32, i32* %aux01
%_27 = load i32, i32* %num
%_25 = icmp ne i32 %_26, %_27
%_21 = and i1 %_22, %_25
br i1 %_21, label %if0, label %if1
if0:
%_28 = add i32 0, 0
store i32 %_28, i32* %nt
br label %if2
if1:
%_30 = load i32, i32* %aux01
%_32 = load i32, i32* %aux02
%_33 = add i32 0, 1
%_31 = sub i32 %_32, %_33
%_29 = icmp sle i32 %_30, %_31
%_34 = xor i1 1, %_29
br i1 %_34, label %if3, label %if4
if3:
%_35 = add i32 0, 0
store i32 %_35, i32* %nt
br label %if5
if4:
%_36 = or i1 1, 1
store i1 %_36, i1* %ls01
%_37 = add i32 0, 1
store i32 %_37, i32* %ifound
%_38 = getelementptr i8, i8* %this, i32 16
%_39 = bitcast i8* %_38 to i32*
store i32* %_39, i32** %j
br label %if5
if5:
br label %if2
if2:
%_41 = load i32, i32* %j
%_42 = add i32 0, 1
%_40 = add i32 %_41, %_42
store i32 %_40, i32* %j
br label %loop3
loop5:
%_43 = load i32, i32* %ifound
ret i32 %_43
}


define i32 @LS.Init(i8* %this, i32 %.sz) {
%sz = alloca i32
store i32 %.sz, i32* %sz
%j = alloca i32
%k = alloca i32
%aux01 = alloca i32
%aux02 = alloca i32
%_0 = load i32, i32* %sz
%_1 = getelementptr i8, i8* %this, i32 16
%_2 = bitcast i8* %_1 to i32*
875 l: %_2 r: %_0
876 lt: i32* rt: i32
store i32 %_0, i32* %_2
%_3 = load i32, i32* %sz
%_4 = add i32 %_3, 1
%_5 = @calloc(i32 4, i32 %_4)
%_6 = bitcast i8* to i32*
store i32 %_3, %_6
%_7 = getelementptr i8, i8* %this, i32 8
%_8 = bitcast i8* %_7 to i8**
875 l: %_8 r: %_6
876 lt: i8** rt: i32*
store i32* %_6, i32** %_8
%_9 = add i32 0, 1
store i32 %_9, i32* %j
%_11 = getelementptr i8, i8* %this, i32 16
%_12 = bitcast i8* %_11 to i32*
%_13 = add i32 0, 1
%_10 = add i32 %_12, %_13
store i32 %_10, i32* %k
br label %loop6
loop6:
%_15 = load i32, i32* %j
%_17 = getelementptr i8, i8* %this, i32 16
%_18 = bitcast i8* %_17 to i32*
%_19 = add i32 0, 1
%_20 = load i32, i32* %_18
%_16 = sub i32 %_20, %_19
%_14 = icmp sle i32 %_15, %_16
br i1 %_14, label %loop7, label %loop8
loop7:
%_22 = add i32 0, 2
%_23 = load i32, i32* %j
%_21 = mul i32 %_22, %_23
store i32 %_21, i32* %aux01
%_25 = load i32, i32* %k
%_26 = add i32 0, 3
%_24 = sub i32 %_25, %_26
store i32 %_24, i32* %aux02
%_28 = load i32, i32* %j
%_29 = add i32 0, 1
%_27 = add i32 %_28, %_29
store i32 %_27, i32* %j
%_31 = load i32, i32* %k
%_32 = add i32 0, 1
%_30 = sub i32 %_31, %_32
store i32 %_30, i32* %k
br label %loop6
loop8:
%_33 = add i32 0, 0
ret i32 %_33
}


