
bin/bb:     file format elf64-x86-64


Disassembly of section .init:

0000000000001000 <_init>:
    1000:	f3 0f 1e fa          	endbr64
    1004:	48 83 ec 08          	sub    rsp,0x8
    1008:	48 8b 05 d9 2f 00 00 	mov    rax,QWORD PTR [rip+0x2fd9]        # 3fe8 <__gmon_start__@Base>
    100f:	48 85 c0             	test   rax,rax
    1012:	74 02                	je     1016 <_init+0x16>
    1014:	ff d0                	call   rax
    1016:	48 83 c4 08          	add    rsp,0x8
    101a:	c3                   	ret

Disassembly of section .plt:

0000000000001020 <.plt>:
    1020:	ff 35 9a 2f 00 00    	push   QWORD PTR [rip+0x2f9a]        # 3fc0 <_GLOBAL_OFFSET_TABLE_+0x8>
    1026:	ff 25 9c 2f 00 00    	jmp    QWORD PTR [rip+0x2f9c]        # 3fc8 <_GLOBAL_OFFSET_TABLE_+0x10>
    102c:	0f 1f 40 00          	nop    DWORD PTR [rax+0x0]
    1030:	f3 0f 1e fa          	endbr64
    1034:	68 00 00 00 00       	push   0x0
    1039:	e9 e2 ff ff ff       	jmp    1020 <_init+0x20>
    103e:	66 90                	xchg   ax,ax

Disassembly of section .plt.got:

0000000000001040 <__cxa_finalize@plt>:
    1040:	f3 0f 1e fa          	endbr64
    1044:	ff 25 ae 2f 00 00    	jmp    QWORD PTR [rip+0x2fae]        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    104a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .plt.sec:

0000000000001050 <__printf_chk@plt>:
    1050:	f3 0f 1e fa          	endbr64
    1054:	ff 25 76 2f 00 00    	jmp    QWORD PTR [rip+0x2f76]        # 3fd0 <__printf_chk@GLIBC_2.3.4>
    105a:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]

Disassembly of section .text:

0000000000001060 <main>:
    1060:	f3 0f 1e fa          	endbr64
    1064:	48 83 ec 18          	sub    rsp,0x18
    1068:	ba 01 00 00 00       	mov    edx,0x1
    106d:	48 c7 44 24 08 81 00 	mov    QWORD PTR [rsp+0x8],0x81
    1074:	00 00
    ;======================================= The bit_ceil() function 
    1076:	48 8b 44 24 08       	mov    rax,QWORD PTR [rsp+0x8]
    107b:	48 83 f8 01          	cmp    rax,0x1
    107f:	76 0e                	jbe    108f <main+0x2f>
    1081:	48 83 e8 01          	sub    rax,0x1
    1085:	48 0f bd c0          	bsr    rax,rax
    1089:	8d 48 01             	lea    ecx,[rax+0x1]
    108c:	48 d3 e2             	shl    rdx,cl
    108f:	48 8d 35 6e 0f 00 00 	lea    rsi,[rip+0xf6e]        # 2004 <_IO_stdin_used+0x4>
    1096:	bf 02 00 00 00       	mov    edi,0x2
    109b:	31 c0                	xor    eax,eax
    109d:	e8 ae ff ff ff       	call   1050 <__printf_chk@plt>
    ;======================================================
    10a2:	31 c0                	xor    eax,eax
    10a4:	48 83 c4 18          	add    rsp,0x18
    10a8:	c3                   	ret
    10a9:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

00000000000010b0 <_start>:
    10b0:	f3 0f 1e fa          	endbr64
    10b4:	31 ed                	xor    ebp,ebp
    10b6:	49 89 d1             	mov    r9,rdx
    10b9:	5e                   	pop    rsi
    10ba:	48 89 e2             	mov    rdx,rsp
    10bd:	48 83 e4 f0          	and    rsp,0xfffffffffffffff0
    10c1:	50                   	push   rax
    10c2:	54                   	push   rsp
    10c3:	45 31 c0             	xor    r8d,r8d
    10c6:	31 c9                	xor    ecx,ecx
    10c8:	48 8d 3d 91 ff ff ff 	lea    rdi,[rip+0xffffffffffffff91]        # 1060 <main>
    10cf:	ff 15 03 2f 00 00    	call   QWORD PTR [rip+0x2f03]        # 3fd8 <__libc_start_main@GLIBC_2.34>
    10d5:	f4                   	hlt
    10d6:	66 2e 0f 1f 84 00 00 	cs nop WORD PTR [rax+rax*1+0x0]
    10dd:	00 00 00 

00000000000010e0 <deregister_tm_clones>:
    10e0:	48 8d 3d 29 2f 00 00 	lea    rdi,[rip+0x2f29]        # 4010 <__TMC_END__>
    10e7:	48 8d 05 22 2f 00 00 	lea    rax,[rip+0x2f22]        # 4010 <__TMC_END__>
    10ee:	48 39 f8             	cmp    rax,rdi
    10f1:	74 15                	je     1108 <deregister_tm_clones+0x28>
    10f3:	48 8b 05 e6 2e 00 00 	mov    rax,QWORD PTR [rip+0x2ee6]        # 3fe0 <_ITM_deregisterTMCloneTable@Base>
    10fa:	48 85 c0             	test   rax,rax
    10fd:	74 09                	je     1108 <deregister_tm_clones+0x28>
    10ff:	ff e0                	jmp    rax
    1101:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]
    1108:	c3                   	ret
    1109:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001110 <register_tm_clones>:
    1110:	48 8d 3d f9 2e 00 00 	lea    rdi,[rip+0x2ef9]        # 4010 <__TMC_END__>
    1117:	48 8d 35 f2 2e 00 00 	lea    rsi,[rip+0x2ef2]        # 4010 <__TMC_END__>
    111e:	48 29 fe             	sub    rsi,rdi
    1121:	48 89 f0             	mov    rax,rsi
    1124:	48 c1 ee 3f          	shr    rsi,0x3f
    1128:	48 c1 f8 03          	sar    rax,0x3
    112c:	48 01 c6             	add    rsi,rax
    112f:	48 d1 fe             	sar    rsi,1
    1132:	74 14                	je     1148 <register_tm_clones+0x38>
    1134:	48 8b 05 b5 2e 00 00 	mov    rax,QWORD PTR [rip+0x2eb5]        # 3ff0 <_ITM_registerTMCloneTable@Base>
    113b:	48 85 c0             	test   rax,rax
    113e:	74 08                	je     1148 <register_tm_clones+0x38>
    1140:	ff e0                	jmp    rax
    1142:	66 0f 1f 44 00 00    	nop    WORD PTR [rax+rax*1+0x0]
    1148:	c3                   	ret
    1149:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001150 <__do_global_dtors_aux>:
    1150:	f3 0f 1e fa          	endbr64
    1154:	80 3d b5 2e 00 00 00 	cmp    BYTE PTR [rip+0x2eb5],0x0        # 4010 <__TMC_END__>
    115b:	75 2b                	jne    1188 <__do_global_dtors_aux+0x38>
    115d:	55                   	push   rbp
    115e:	48 83 3d 92 2e 00 00 	cmp    QWORD PTR [rip+0x2e92],0x0        # 3ff8 <__cxa_finalize@GLIBC_2.2.5>
    1165:	00 
    1166:	48 89 e5             	mov    rbp,rsp
    1169:	74 0c                	je     1177 <__do_global_dtors_aux+0x27>
    116b:	48 8b 3d 96 2e 00 00 	mov    rdi,QWORD PTR [rip+0x2e96]        # 4008 <__dso_handle>
    1172:	e8 c9 fe ff ff       	call   1040 <__cxa_finalize@plt>
    1177:	e8 64 ff ff ff       	call   10e0 <deregister_tm_clones>
    117c:	c6 05 8d 2e 00 00 01 	mov    BYTE PTR [rip+0x2e8d],0x1        # 4010 <__TMC_END__>
    1183:	5d                   	pop    rbp
    1184:	c3                   	ret
    1185:	0f 1f 00             	nop    DWORD PTR [rax]
    1188:	c3                   	ret
    1189:	0f 1f 80 00 00 00 00 	nop    DWORD PTR [rax+0x0]

0000000000001190 <frame_dummy>:
    1190:	f3 0f 1e fa          	endbr64
    1194:	e9 77 ff ff ff       	jmp    1110 <register_tm_clones>

Disassembly of section .fini:

000000000000119c <_fini>:
    119c:	f3 0f 1e fa          	endbr64
    11a0:	48 83 ec 08          	sub    rsp,0x8
    11a4:	48 83 c4 08          	add    rsp,0x8
    11a8:	c3                   	ret
