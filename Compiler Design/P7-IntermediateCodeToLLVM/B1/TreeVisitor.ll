@.TreeVisitor_vtable = global [0 x i8*] []
@.Visitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i8*)* @Visitor.visit to i8*)]
@.TV_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*)* @TV.Start to i8*)]
@.MyVisitor_vtable = global [1 x i8*] [i8* bitcast (i32 (i8*, i8*)* @MyVisitor.visit to i8*)]
@.Tree_vtable = global [21 x i8*] [i8* bitcast (i1 (i8*, i8*)* @Tree.SetLeft to i8*), i8* bitcast (i32 (i8*, i8*)* @Tree.accept to i8*), i8* bitcast (i8* (i8*)* @Tree.GetLeft to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Delete to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.SetRight to i8*), i8* bitcast (i32 (i8*, i32)* @Tree.Search to i8*), i8* bitcast (i8* (i8*)* @Tree.GetRight to i8*), i8* bitcast (i1 (i8*)* @Tree.Print to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Left to i8*), i8* bitcast (i1 (i8*, i32, i32)* @Tree.Compare to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveRight to i8*), i8* bitcast (i1 (i8*)* @Tree.GetHas_Right to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.RemoveLeft to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Right to i8*), i8* bitcast (i1 (i8*, i1)* @Tree.SetHas_Left to i8*), i8* bitcast (i1 (i8*, i8*, i8*)* @Tree.Remove to i8*), i8* bitcast (i1 (i8*, i8*)* @Tree.RecPrint to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.SetKey to i8*), i8* bitcast (i32 (i8*)* @Tree.GetKey to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Insert to i8*), i8* bitcast (i1 (i8*, i32)* @Tree.Init to i8*)]

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
%_0 = call i8* @calloc(i32 1, i32 8)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [1 x i8*], [1 x i8*]* @.TV_vtable, i32 0, i32 0
store i8** %_2, i8*** %_1
%_3 = bitcast i8* %_0 to i8***
%_4 = load i8**, i8*** %_3
%_5 = getelementptr i8*, i8** %_4, i32 0
%_6 = load i8*, i8** %_5
%_7 = bitcast i8* %_6 to i32 (i8*)*
%_8 = call i32  %_7 (i8* %_0, )
call void (i32) @print_int(i32 %_8)
ret i32 0
}


define i32 @TV.Start(i8* %this) {
%root = alloca i8*
%ntb = alloca i1
%nti = alloca i32
%v = alloca i8*
%_0 = call i8* @calloc(i32 1, i32 38)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
store i8** %_2, i8*** %_1
store i8* %_0, i8** %root
%_3 = load i8*, i8** %root
%_4 = bitcast i8* %_3 to i8***
%_5 = load i8**, i8*** %_4
%_6 = getelementptr i8*, i8** %_5, i32 20
%_7 = load i8*, i8** %_6
%_8 = bitcast i8* %_7 to i1 (i8*, i32)*
%_10 = add i32 0, 16
%_9 = call i1  %_8 (i8* %_3, i32 %_10)
store i1 %_9, i1* %ntb
%_11 = load i8*, i8** %root
%_12 = bitcast i8* %_11 to i8***
%_13 = load i8**, i8*** %_12
%_14 = getelementptr i8*, i8** %_13, i32 7
%_15 = load i8*, i8** %_14
%_16 = bitcast i8* %_15 to i1 (i8*)*
%_17 = call i1  %_16 (i8* %_11, )
store i1 %_17, i1* %ntb
%_18 = add i32 0, 100000000
call void (i32) @print_int(i32 %_18)
%_19 = load i8*, i8** %root
%_20 = bitcast i8* %_19 to i8***
%_21 = load i8**, i8*** %_20
%_22 = getelementptr i8*, i8** %_21, i32 19
%_23 = load i8*, i8** %_22
%_24 = bitcast i8* %_23 to i1 (i8*, i32)*
%_26 = add i32 0, 8
%_25 = call i1  %_24 (i8* %_19, i32 %_26)
store i1 %_25, i1* %ntb
%_27 = load i8*, i8** %root
%_28 = bitcast i8* %_27 to i8***
%_29 = load i8**, i8*** %_28
%_30 = getelementptr i8*, i8** %_29, i32 19
%_31 = load i8*, i8** %_30
%_32 = bitcast i8* %_31 to i1 (i8*, i32)*
%_34 = add i32 0, 24
%_33 = call i1  %_32 (i8* %_27, i32 %_34)
store i1 %_33, i1* %ntb
%_35 = load i8*, i8** %root
%_36 = bitcast i8* %_35 to i8***
%_37 = load i8**, i8*** %_36
%_38 = getelementptr i8*, i8** %_37, i32 19
%_39 = load i8*, i8** %_38
%_40 = bitcast i8* %_39 to i1 (i8*, i32)*
%_42 = add i32 0, 4
%_41 = call i1  %_40 (i8* %_35, i32 %_42)
store i1 %_41, i1* %ntb
%_43 = load i8*, i8** %root
%_44 = bitcast i8* %_43 to i8***
%_45 = load i8**, i8*** %_44
%_46 = getelementptr i8*, i8** %_45, i32 19
%_47 = load i8*, i8** %_46
%_48 = bitcast i8* %_47 to i1 (i8*, i32)*
%_50 = add i32 0, 12
%_49 = call i1  %_48 (i8* %_43, i32 %_50)
store i1 %_49, i1* %ntb
%_51 = load i8*, i8** %root
%_52 = bitcast i8* %_51 to i8***
%_53 = load i8**, i8*** %_52
%_54 = getelementptr i8*, i8** %_53, i32 19
%_55 = load i8*, i8** %_54
%_56 = bitcast i8* %_55 to i1 (i8*, i32)*
%_58 = add i32 0, 20
%_57 = call i1  %_56 (i8* %_51, i32 %_58)
store i1 %_57, i1* %ntb
%_59 = load i8*, i8** %root
%_60 = bitcast i8* %_59 to i8***
%_61 = load i8**, i8*** %_60
%_62 = getelementptr i8*, i8** %_61, i32 19
%_63 = load i8*, i8** %_62
%_64 = bitcast i8* %_63 to i1 (i8*, i32)*
%_66 = add i32 0, 28
%_65 = call i1  %_64 (i8* %_59, i32 %_66)
store i1 %_65, i1* %ntb
%_67 = load i8*, i8** %root
%_68 = bitcast i8* %_67 to i8***
%_69 = load i8**, i8*** %_68
%_70 = getelementptr i8*, i8** %_69, i32 19
%_71 = load i8*, i8** %_70
%_72 = bitcast i8* %_71 to i1 (i8*, i32)*
%_74 = add i32 0, 14
%_73 = call i1  %_72 (i8* %_67, i32 %_74)
store i1 %_73, i1* %ntb
%_75 = load i8*, i8** %root
%_76 = bitcast i8* %_75 to i8***
%_77 = load i8**, i8*** %_76
%_78 = getelementptr i8*, i8** %_77, i32 7
%_79 = load i8*, i8** %_78
%_80 = bitcast i8* %_79 to i1 (i8*)*
%_81 = call i1  %_80 (i8* %_75, )
store i1 %_81, i1* %ntb
%_82 = add i32 0, 100000000
call void (i32) @print_int(i32 %_82)
%_83 = call i8* @calloc(i32 1, i32 24)
%_84 = bitcast i8* %_83 to i8***
%_85 = getelementptr [1 x i8*], [1 x i8*]* @.MyVisitor_vtable, i32 0, i32 0
store i8** %_85, i8*** %_84
store i8* %_83, i8** %v
%_86 = add i32 0, 50000000
call void (i32) @print_int(i32 %_86)
%_87 = load i8*, i8** %root
%_88 = bitcast i8* %_87 to i8***
%_89 = load i8**, i8*** %_88
%_90 = getelementptr i8*, i8** %_89, i32 1
%_91 = load i8*, i8** %_90
%_92 = bitcast i8* %_91 to i32 (i8*, i8*)*
%_94 = load i8*, i8** %v
%_93 = call i32  %_92 (i8* %_87, i8* %_94)
store i32 %_93, i32* %nti
%_95 = add i32 0, 100000000
call void (i32) @print_int(i32 %_95)
%_96 = load i8*, i8** %root
%_97 = bitcast i8* %_96 to i8***
%_98 = load i8**, i8*** %_97
%_99 = getelementptr i8*, i8** %_98, i32 5
%_100 = load i8*, i8** %_99
%_101 = bitcast i8* %_100 to i32 (i8*, i32)*
%_103 = add i32 0, 24
%_102 = call i32  %_101 (i8* %_96, i32 %_103)
call void (i32) @print_int(i32 %_102)
%_104 = load i8*, i8** %root
%_105 = bitcast i8* %_104 to i8***
%_106 = load i8**, i8*** %_105
%_107 = getelementptr i8*, i8** %_106, i32 5
%_108 = load i8*, i8** %_107
%_109 = bitcast i8* %_108 to i32 (i8*, i32)*
%_111 = add i32 0, 12
%_110 = call i32  %_109 (i8* %_104, i32 %_111)
call void (i32) @print_int(i32 %_110)
%_112 = load i8*, i8** %root
%_113 = bitcast i8* %_112 to i8***
%_114 = load i8**, i8*** %_113
%_115 = getelementptr i8*, i8** %_114, i32 5
%_116 = load i8*, i8** %_115
%_117 = bitcast i8* %_116 to i32 (i8*, i32)*
%_119 = add i32 0, 16
%_118 = call i32  %_117 (i8* %_112, i32 %_119)
call void (i32) @print_int(i32 %_118)
%_120 = load i8*, i8** %root
%_121 = bitcast i8* %_120 to i8***
%_122 = load i8**, i8*** %_121
%_123 = getelementptr i8*, i8** %_122, i32 5
%_124 = load i8*, i8** %_123
%_125 = bitcast i8* %_124 to i32 (i8*, i32)*
%_127 = add i32 0, 50
%_126 = call i32  %_125 (i8* %_120, i32 %_127)
call void (i32) @print_int(i32 %_126)
%_128 = load i8*, i8** %root
%_129 = bitcast i8* %_128 to i8***
%_130 = load i8**, i8*** %_129
%_131 = getelementptr i8*, i8** %_130, i32 5
%_132 = load i8*, i8** %_131
%_133 = bitcast i8* %_132 to i32 (i8*, i32)*
%_135 = add i32 0, 12
%_134 = call i32  %_133 (i8* %_128, i32 %_135)
call void (i32) @print_int(i32 %_134)
%_136 = load i8*, i8** %root
%_137 = bitcast i8* %_136 to i8***
%_138 = load i8**, i8*** %_137
%_139 = getelementptr i8*, i8** %_138, i32 3
%_140 = load i8*, i8** %_139
%_141 = bitcast i8* %_140 to i1 (i8*, i32)*
%_143 = add i32 0, 12
%_142 = call i1  %_141 (i8* %_136, i32 %_143)
store i1 %_142, i1* %ntb
%_144 = load i8*, i8** %root
%_145 = bitcast i8* %_144 to i8***
%_146 = load i8**, i8*** %_145
%_147 = getelementptr i8*, i8** %_146, i32 7
%_148 = load i8*, i8** %_147
%_149 = bitcast i8* %_148 to i1 (i8*)*
%_150 = call i1  %_149 (i8* %_144, )
store i1 %_150, i1* %ntb
%_151 = load i8*, i8** %root
%_152 = bitcast i8* %_151 to i8***
%_153 = load i8**, i8*** %_152
%_154 = getelementptr i8*, i8** %_153, i32 5
%_155 = load i8*, i8** %_154
%_156 = bitcast i8* %_155 to i32 (i8*, i32)*
%_158 = add i32 0, 12
%_157 = call i32  %_156 (i8* %_151, i32 %_158)
call void (i32) @print_int(i32 %_157)
%_159 = add i32 0, 0
ret i32 %_159
}


define i1 @Tree.Init(i8* %this, i32 %.v_key) {
%v_key = alloca i32
store i32 %.v_key, i32* %v_key
%_0 = load i32, i32* %v_key
%_1 = getelementptr i8, i8* %this, i32 24
%_2 = bitcast i8* %_1 to i32*
875 l: %_1 r: %_0
876 lt: i8* rt: i32
store i32 %_0, i8** %_1
%_3 = or i1 0, 0
%_4 = getelementptr i8, i8* %this, i32 28
%_5 = bitcast i8* %_4 to i1*
875 l: %_4 r: %_3
876 lt: i8* rt: i1
store i1 %_3, i8** %_4
%_6 = or i1 0, 0
%_7 = getelementptr i8, i8* %this, i32 29
%_8 = bitcast i8* %_7 to i1*
875 l: %_7 r: %_6
876 lt: i8* rt: i1
store i1 %_6, i8** %_7
%_9 = or i1 1, 1
ret i1 %_9
}


define i1 @Tree.SetRight(i8* %this, i8* %.rn) {
%rn = alloca i8*
store i8* %.rn, i8** %rn
%_0 = load i8*, i8** %rn
%_1 = getelementptr i8, i8* %this, i32 16
%_2 = bitcast i8* %_1 to i8**
875 l: %_1 r: %_0
876 lt: i8* rt: i8*
store i8* %_0, i8** %_1
%_3 = or i1 1, 1
ret i1 %_3
}


define i1 @Tree.SetLeft(i8* %this, i8* %.ln) {
%ln = alloca i8*
store i8* %.ln, i8** %ln
%_0 = load i8*, i8** %ln
%_1 = getelementptr i8, i8* %this, i32 8
%_2 = bitcast i8* %_1 to i8**
875 l: %_1 r: %_0
876 lt: i8* rt: i8*
store i8* %_0, i8** %_1
%_3 = or i1 1, 1
ret i1 %_3
}


define i8* @Tree.GetRight(i8* %this) {
%_0 = getelementptr i8, i8* %this, i32 16
%_1 = bitcast i8* %_0 to i8**
ret i8* %_0
}


define i8* @Tree.GetLeft(i8* %this) {
%_0 = getelementptr i8, i8* %this, i32 8
%_1 = bitcast i8* %_0 to i8**
ret i8* %_0
}


define i32 @Tree.GetKey(i8* %this) {
%_0 = getelementptr i8, i8* %this, i32 24
%_1 = bitcast i8* %_0 to i32*
ret i8* %_0
}


define i1 @Tree.SetKey(i8* %this, i32 %.v_key) {
%v_key = alloca i32
store i32 %.v_key, i32* %v_key
%_0 = load i32, i32* %v_key
%_1 = getelementptr i8, i8* %this, i32 24
%_2 = bitcast i8* %_1 to i32*
875 l: %_1 r: %_0
876 lt: i8* rt: i32
store i32 %_0, i8** %_1
%_3 = or i1 1, 1
ret i1 %_3
}


define i1 @Tree.GetHas_Right(i8* %this) {
%_0 = getelementptr i8, i8* %this, i32 29
%_1 = bitcast i8* %_0 to i1*
ret i8* %_0
}


define i1 @Tree.GetHas_Left(i8* %this) {
%_0 = getelementptr i8, i8* %this, i32 28
%_1 = bitcast i8* %_0 to i1*
ret i8* %_0
}


define i1 @Tree.SetHas_Left(i8* %this, i1 %.val) {
%val = alloca i1
store i1 %.val, i1* %val
%_0 = load i1, i1* %val
%_1 = getelementptr i8, i8* %this, i32 28
%_2 = bitcast i8* %_1 to i1*
875 l: %_1 r: %_0
876 lt: i8* rt: i1
store i1 %_0, i8** %_1
%_3 = or i1 1, 1
ret i1 %_3
}


define i1 @Tree.SetHas_Right(i8* %this, i1 %.val) {
%val = alloca i1
store i1 %.val, i1* %val
%_0 = load i1, i1* %val
%_1 = getelementptr i8, i8* %this, i32 29
%_2 = bitcast i8* %_1 to i1*
875 l: %_1 r: %_0
876 lt: i8* rt: i1
store i1 %_0, i8** %_1
%_3 = or i1 1, 1
ret i1 %_3
}


define i1 @Tree.Compare(i8* %this, i32 %.num1, i32 %.num2) {
%num1 = alloca i32
store i32 %.num1, i32* %num1
%num2 = alloca i32
store i32 %.num2, i32* %num2
%ntb = alloca i1
%nti = alloca i32
%_0 = or i1 0, 0
store i1 %_0, i1* %ntb
%_2 = load i32, i32* %num2
%_3 = add i32 0, 1
%_1 = add i32 %_2, %_3
store i32 %_1, i32* %nti
%_6 = load i32, i32* %num1
%_7 = load i32, i32* %num2
%_5 = icmp sle i32 %_6, %_7
%_9 = load i32, i32* %num1
%_10 = load i32, i32* %num2
%_8 = icmp ne i32 %_9, %_10
%_4 = and i1 %_5, %_8
br i1 %_4, label %if0, label %if1
if0:
%_11 = or i1 0, 0
store i1 %_11, i1* %ntb
br label %if2
if1:
%_13 = load i32, i32* %num1
%_15 = load i32, i32* %nti
%_16 = add i32 0, 1
%_14 = sub i32 %_15, %_16
%_12 = icmp sle i32 %_13, %_14
%_17 = xor i1 1, %_12
br i1 %_17, label %if3, label %if4
if3:
%_18 = or i1 0, 0
store i1 %_18, i1* %ntb
br label %if5
if4:
%_19 = or i1 1, 1
store i1 %_19, i1* %ntb
br label %if5
if5:
br label %if2
if2:
%_20 = load i1, i1* %ntb
ret i1 %_20
}


define i1 @Tree.Insert(i8* %this, i32 %.v_key) {
%v_key = alloca i32
store i32 %.v_key, i32* %v_key
%new_node = alloca i8*
%ntb = alloca i1
%current_node = alloca i8*
%cont = alloca i1
%key_aux = alloca i32
%_0 = call i8* @calloc(i32 1, i32 38)
%_1 = bitcast i8* %_0 to i8***
%_2 = getelementptr [21 x i8*], [21 x i8*]* @.Tree_vtable, i32 0, i32 0
store i8** %_2, i8*** %_1
store i8* %_0, i8** %new_node
%_3 = load i8*, i8** %new_node
%_4 = bitcast i8* %_3 to i8***
%_5 = load i8**, i8*** %_4
%_6 = getelementptr i8*, i8** %_5, i32 20
%_7 = load i8*, i8** %_6
%_8 = bitcast i8* %_7 to i1 (i8*, i32)*
%_10 = load i32, i32* %v_key
%_9 = call i1  %_8 (i8* %_3, i32 %_10)
store i1 %_9, i1* %ntb
store null this, i8** %current_node
%_11 = or i1 1, 1
store i1 %_11, i1* %cont
br label %loop0
loop0:
%_12 = load i1, i1* %cont
br i1 %_12, label %loop1, label %loop2
loop1:
%_13 = load i8*, i8** %current_node
%_14 = bitcast i8* %_13 to i8***
%_15 = load i8**, i8*** %_14
%_16 = getelementptr i8*, i8** %_15, i32 18
%_17 = load i8*, i8** %_16
%_18 = bitcast i8* %_17 to i32 (i8*)*
%_19 = call i32  %_18 (i8* %_13, )
store i32 %_19, i32* %key_aux
%_21 = load i32, i32* %v_key
%_23 = load i32, i32* %key_aux
%_24 = add i32 0, 1
%_22 = sub i32 %_23, %_24
%_20 = icmp sle i32 %_21, %_22
br i1 %_20, label %if6, label %if7
if6:
%_25 = load i8*, i8** %current_node
%_26 = bitcast i8* %_25 to i8***
%_27 = load i8**, i8*** %_26
%_28 = getelementptr i8*, i8** %_27, i32 8
%_29 = load i8*, i8** %_28
%_30 = bitcast i8* %_29 to i1 (i8*)*
%_31 = call i1  %_30 (i8* %_25, )
br i1 %_31, label %if9, label %if10
if9:
%_32 = load i8*, i8** %current_node
%_33 = bitcast i8* %_32 to i8***
%_34 = load i8**, i8*** %_33
%_35 = getelementptr i8*, i8** %_34, i32 2
%_36 = load i8*, i8** %_35
%_37 = bitcast i8* %_36 to i8* (i8*)*
%_38 = call i8*  %_37 (i8* %_32, )
store i8* %_38, i8** %current_node
br label %if11
if10:
%_39 = or i1 0, 0
store i1 %_39, i1* %cont
%_40 = load i8*, i8** %current_node
%_41 = bitcast i8* %_40 to i8***
%_42 = load i8**, i8*** %_41
%_43 = getelementptr i8*, i8** %_42, i32 14
%_44 = load i8*, i8** %_43
%_45 = bitcast i8* %_44 to i1 (i8*, i1)*
%_47 = or i1 1, 1
%_46 = call i1  %_45 (i8* %_40, i1 %_47)
store i1 %_46, i1* %ntb
%_48 = load i8*, i8** %current_node
%_49 = bitcast i8* %_48 to i8***
%_50 = load i8**, i8*** %_49
%_51 = getelementptr i8*, i8** %_50, i32 0
%_52 = load i8*, i8** %_51
%_53 = bitcast i8* %_52 to i1 (i8*, i8*)*
%_55 = load i8*, i8** %new_node
%_54 = call i1  %_53 (i8* %_48, i8* %_55)
store i1 %_54, i1* %ntb
br label %if11
if11:
br label %if8
if7:
%_56 = load i8*, i8** %current_node
%_57 = bitcast i8* %_56 to i8***
%_58 = load i8**, i8*** %_57
%_59 = getelementptr i8*, i8** %_58, i32 11
%_60 = load i8*, i8** %_59
%_61 = bitcast i8* %_60 to i1 (i8*)*
%_62 = call i1  %_61 (i8* %_56, )
br i1 %_62, label %if12, label %if13
if12:
%_63 = load i8*, i8** %current_node
%_64 = bitcast i8* %_63 to i8***
%_65 = load i8**, i8*** %_64
%_66 = getelementptr i8*, i8** %_65, i32 6
%_67 = load i8*, i8** %_66
%_68 = bitcast i8* %_67 to i8* (i8*)*
%_69 = call i8*  %_68 (i8* %_63, )
store i8* %_69, i8** %current_node
br label %if14
if13:
%_70 = or i1 0, 0
store i1 %_70, i1* %cont
%_71 = load i8*, i8** %current_node
%_72 = bitcast i8* %_71 to i8***
%_73 = load i8**, i8*** %_72
%_74 = getelementptr i8*, i8** %_73, i32 13
%_75 = load i8*, i8** %_74
%_76 = bitcast i8* %_75 to i1 (i8*, i1)*
%_78 = or i1 1, 1
%_77 = call i1  %_76 (i8* %_71, i1 %_78)
store i1 %_77, i1* %ntb
%_79 = load i8*, i8** %current_node
%_80 = bitcast i8* %_79 to i8***
%_81 = load i8**, i8*** %_80
%_82 = getelementptr i8*, i8** %_81, i32 4
%_83 = load i8*, i8** %_82
%_84 = bitcast i8* %_83 to i1 (i8*, i8*)*
%_86 = load i8*, i8** %new_node
%_85 = call i1  %_84 (i8* %_79, i8* %_86)
store i1 %_85, i1* %ntb
br label %if14
if14:
br label %if8
if8:
br label %loop0
loop2:
%_87 = or i1 1, 1
ret i1 %_87
}


define i1 @Tree.Delete(i8* %this, i32 %.v_key) {
%v_key = alloca i32
store i32 %.v_key, i32* %v_key
%current_node = alloca i8*
%parent_node = alloca i8*
%cont = alloca i1
%found = alloca i1
%ntb = alloca i1
%is_root = alloca i1
%key_aux = alloca i32
store null this, i8** %current_node
store null this, i8** %parent_node
%_0 = or i1 1, 1
store i1 %_0, i1* %cont
%_1 = or i1 0, 0
store i1 %_1, i1* %found
%_2 = or i1 1, 1
store i1 %_2, i1* %is_root
br label %loop3
loop3:
%_3 = load i1, i1* %cont
br i1 %_3, label %loop4, label %loop5
loop4:
%_4 = load i8*, i8** %current_node
%_5 = bitcast i8* %_4 to i8***
%_6 = load i8**, i8*** %_5
%_7 = getelementptr i8*, i8** %_6, i32 18
%_8 = load i8*, i8** %_7
%_9 = bitcast i8* %_8 to i32 (i8*)*
%_10 = call i32  %_9 (i8* %_4, )
store i32 %_10, i32* %key_aux
%_12 = load i32, i32* %v_key
%_14 = load i32, i32* %key_aux
%_15 = add i32 0, 1
%_13 = sub i32 %_14, %_15
%_11 = icmp sle i32 %_12, %_13
br i1 %_11, label %if15, label %if16
if15:
%_16 = load i8*, i8** %current_node
%_17 = bitcast i8* %_16 to i8***
%_18 = load i8**, i8*** %_17
%_19 = getelementptr i8*, i8** %_18, i32 8
%_20 = load i8*, i8** %_19
%_21 = bitcast i8* %_20 to i1 (i8*)*
%_22 = call i1  %_21 (i8* %_16, )
br i1 %_22, label %if18, label %if19
if18:
%_23 = load i8*, i8** %current_node
store i8* %_23, i8** %parent_node
%_24 = load i8*, i8** %current_node
%_25 = bitcast i8* %_24 to i8***
%_26 = load i8**, i8*** %_25
%_27 = getelementptr i8*, i8** %_26, i32 2
%_28 = load i8*, i8** %_27
%_29 = bitcast i8* %_28 to i8* (i8*)*
%_30 = call i8*  %_29 (i8* %_24, )
store i8* %_30, i8** %current_node
br label %if20
if19:
%_31 = or i1 0, 0
store i1 %_31, i1* %cont
br label %if20
if20:
br label %if17
if16:
%_34 = load i32, i32* %key_aux
%_35 = load i32, i32* %v_key
%_33 = icmp sle i32 %_34, %_35
%_37 = load i32, i32* %key_aux
%_38 = load i32, i32* %v_key
%_36 = icmp ne i32 %_37, %_38
%_32 = and i1 %_33, %_36
br i1 %_32, label %if21, label %if22
if21:
%_39 = load i8*, i8** %current_node
%_40 = bitcast i8* %_39 to i8***
%_41 = load i8**, i8*** %_40
%_42 = getelementptr i8*, i8** %_41, i32 11
%_43 = load i8*, i8** %_42
%_44 = bitcast i8* %_43 to i1 (i8*)*
%_45 = call i1  %_44 (i8* %_39, )
br i1 %_45, label %if24, label %if25
if24:
%_46 = load i8*, i8** %current_node
store i8* %_46, i8** %parent_node
%_47 = load i8*, i8** %current_node
%_48 = bitcast i8* %_47 to i8***
%_49 = load i8**, i8*** %_48
%_50 = getelementptr i8*, i8** %_49, i32 6
%_51 = load i8*, i8** %_50
%_52 = bitcast i8* %_51 to i8* (i8*)*
%_53 = call i8*  %_52 (i8* %_47, )
store i8* %_53, i8** %current_node
br label %if26
if25:
%_54 = or i1 0, 0
store i1 %_54, i1* %cont
br label %if26
if26:
br label %if23
if22:
%_55 = load i1, i1* %is_root
br i1 %_55, label %if27, label %if28
if27:
%_57 = load i8*, i8** %current_node
%_58 = bitcast i8* %_57 to i8***
%_59 = load i8**, i8*** %_58
%_60 = getelementptr i8*, i8** %_59, i32 11
%_61 = load i8*, i8** %_60
%_62 = bitcast i8* %_61 to i1 (i8*)*
%_63 = call i1  %_62 (i8* %_57, )
%_64 = xor i1 1, %_63
%_65 = load i8*, i8** %current_node
%_66 = bitcast i8* %_65 to i8***
%_67 = load i8**, i8*** %_66
%_68 = getelementptr i8*, i8** %_67, i32 8
%_69 = load i8*, i8** %_68
%_70 = bitcast i8* %_69 to i1 (i8*)*
%_71 = call i1  %_70 (i8* %_65, )
%_72 = xor i1 1, %_71
%_56 = and i1 %_64, %_72
br i1 %_56, label %if30, label %if31
if30:
%_73 = or i1 1, 1
store i1 %_73, i1* %ntb
br label %if32
if31:
%_74 = bitcast i8* %this to i8***
%_75 = load i8**, i8*** %_74
%_76 = getelementptr i8*, i8** %_75, i32 15
%_77 = load i8*, i8** %_76
%_78 = bitcast i8* %_77 to i1 (i8*, i8*, i8*)*
%_80 = load i8*, i8** %parent_node
%_81 = load i8*, i8** %current_node
%_79 = call i1  %_78 (i8* %this, i8* %_80, i8* %_81)
store i1 %_79, i1* %ntb
br label %if32
if32:
br label %if29
if28:
%_82 = bitcast i8* %this to i8***
%_83 = load i8**, i8*** %_82
%_84 = getelementptr i8*, i8** %_83, i32 15
%_85 = load i8*, i8** %_84
%_86 = bitcast i8* %_85 to i1 (i8*, i8*, i8*)*
%_88 = load i8*, i8** %parent_node
%_89 = load i8*, i8** %current_node
%_87 = call i1  %_86 (i8* %this, i8* %_88, i8* %_89)
store i1 %_87, i1* %ntb
br label %if29
if29:
%_90 = or i1 1, 1
store i1 %_90, i1* %found
%_91 = or i1 0, 0
store i1 %_91, i1* %cont
br label %if23
if23:
br label %if17
if17:
%_92 = or i1 0, 0
store i1 %_92, i1* %is_root
br label %loop3
loop5:
%_93 = load i1, i1* %found
ret i1 %_93
}


define i1 @Tree.Remove(i8* %this, i8* %.p_node, i8* %.c_node) {
%p_node = alloca i8*
store i8* %.p_node, i8** %p_node
%c_node = alloca i8*
store i8* %.c_node, i8** %c_node
%ntb = alloca i1
%auxkey1 = alloca i32
%auxkey2 = alloca i32
%_0 = load i8*, i8** %c_node
%_1 = bitcast i8* %_0 to i8***
%_2 = load i8**, i8*** %_1
%_3 = getelementptr i8*, i8** %_2, i32 8
%_4 = load i8*, i8** %_3
%_5 = bitcast i8* %_4 to i1 (i8*)*
%_6 = call i1  %_5 (i8* %_0, )
br i1 %_6, label %if33, label %if34
if33:
%_7 = bitcast i8* %this to i8***
%_8 = load i8**, i8*** %_7
%_9 = getelementptr i8*, i8** %_8, i32 12
%_10 = load i8*, i8** %_9
%_11 = bitcast i8* %_10 to i1 (i8*, i8*, i8*)*
%_13 = load i8*, i8** %p_node
%_14 = load i8*, i8** %c_node
%_12 = call i1  %_11 (i8* %this, i8* %_13, i8* %_14)
store i1 %_12, i1* %ntb
br label %if35
if34:
%_15 = load i8*, i8** %c_node
%_16 = bitcast i8* %_15 to i8***
%_17 = load i8**, i8*** %_16
%_18 = getelementptr i8*, i8** %_17, i32 11
%_19 = load i8*, i8** %_18
%_20 = bitcast i8* %_19 to i1 (i8*)*
%_21 = call i1  %_20 (i8* %_15, )
br i1 %_21, label %if36, label %if37
if36:
%_22 = bitcast i8* %this to i8***
%_23 = load i8**, i8*** %_22
%_24 = getelementptr i8*, i8** %_23, i32 10
%_25 = load i8*, i8** %_24
%_26 = bitcast i8* %_25 to i1 (i8*, i8*, i8*)*
%_28 = load i8*, i8** %p_node
%_29 = load i8*, i8** %c_node
%_27 = call i1  %_26 (i8* %this, i8* %_28, i8* %_29)
store i1 %_27, i1* %ntb
br label %if38
if37:
%_30 = load i8*, i8** %c_node
%_31 = bitcast i8* %_30 to i8***
%_32 = load i8**, i8*** %_31
%_33 = getelementptr i8*, i8** %_32, i32 18
%_34 = load i8*, i8** %_33
%_35 = bitcast i8* %_34 to i32 (i8*)*
%_36 = call i32  %_35 (i8* %_30, )
store i32 %_36, i32* %auxkey1
%_37 = load i8*, i8** %p_node
%_38 = bitcast i8* %_37 to i8***
%_39 = load i8**, i8*** %_38
%_40 = getelementptr i8*, i8** %_39, i32 2
%_41 = load i8*, i8** %_40
%_42 = bitcast i8* %_41 to i8* (i8*)*
%_43 = call i8*  %_42 (i8* %_37, )
%_44 = bitcast i8* p_node to i8***
%_45 = load i8**, i8*** %_44
%_46 = getelementptr i8*, i8** %_45, i32 2
%_47 = load i8*, i8** %_46
%_48 = bitcast i8* %_47 to i8* (i8*)*
%_49 = call i8*  %_48 (i8* p_node, )
