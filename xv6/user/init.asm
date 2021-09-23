
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:

char *argv[] = { "sh", 0 };

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  int pid, wpid;

  if(open("console", O_RDWR) < 0){
  13:	83 ec 08             	sub    $0x8,%esp
  16:	6a 02                	push   $0x2
  18:	68 14 07 00 00       	push   $0x714
  1d:	e8 e5 02 00 00       	call   307 <open>
  22:	83 c4 10             	add    $0x10,%esp
  25:	85 c0                	test   %eax,%eax
  27:	78 59                	js     82 <main+0x82>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 0c 03 00 00       	call   33f <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 00 03 00 00       	call   33f <dup>
  3f:	83 c4 10             	add    $0x10,%esp

  for(;;){
    printf(1, "init: starting sh\n");
  42:	83 ec 08             	sub    $0x8,%esp
  45:	68 1c 07 00 00       	push   $0x71c
  4a:	6a 01                	push   $0x1
  4c:	e8 aa 03 00 00       	call   3fb <printf>
    pid = fork();
  51:	e8 69 02 00 00       	call   2bf <fork>
  56:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  58:	83 c4 10             	add    $0x10,%esp
  5b:	85 c0                	test   %eax,%eax
  5d:	78 48                	js     a7 <main+0xa7>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  5f:	74 5a                	je     bb <main+0xbb>
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  61:	e8 69 02 00 00       	call   2cf <wait>
  66:	39 c3                	cmp    %eax,%ebx
  68:	74 d8                	je     42 <main+0x42>
  6a:	85 c0                	test   %eax,%eax
  6c:	78 d4                	js     42 <main+0x42>
      printf(1, "zombie!\n");
  6e:	83 ec 08             	sub    $0x8,%esp
  71:	68 5b 07 00 00       	push   $0x75b
  76:	6a 01                	push   $0x1
  78:	e8 7e 03 00 00       	call   3fb <printf>
  7d:	83 c4 10             	add    $0x10,%esp
  80:	eb df                	jmp    61 <main+0x61>
    mknod("console", 1, 1);
  82:	83 ec 04             	sub    $0x4,%esp
  85:	6a 01                	push   $0x1
  87:	6a 01                	push   $0x1
  89:	68 14 07 00 00       	push   $0x714
  8e:	e8 7c 02 00 00       	call   30f <mknod>
    open("console", O_RDWR);
  93:	83 c4 08             	add    $0x8,%esp
  96:	6a 02                	push   $0x2
  98:	68 14 07 00 00       	push   $0x714
  9d:	e8 65 02 00 00       	call   307 <open>
  a2:	83 c4 10             	add    $0x10,%esp
  a5:	eb 82                	jmp    29 <main+0x29>
      printf(1, "init: fork failed\n");
  a7:	83 ec 08             	sub    $0x8,%esp
  aa:	68 2f 07 00 00       	push   $0x72f
  af:	6a 01                	push   $0x1
  b1:	e8 45 03 00 00       	call   3fb <printf>
      exit();
  b6:	e8 0c 02 00 00       	call   2c7 <exit>
      exec("sh", argv);
  bb:	83 ec 08             	sub    $0x8,%esp
  be:	68 d8 09 00 00       	push   $0x9d8
  c3:	68 42 07 00 00       	push   $0x742
  c8:	e8 32 02 00 00       	call   2ff <exec>
      printf(1, "init: exec sh failed\n");
  cd:	83 c4 08             	add    $0x8,%esp
  d0:	68 45 07 00 00       	push   $0x745
  d5:	6a 01                	push   $0x1
  d7:	e8 1f 03 00 00       	call   3fb <printf>
      exit();
  dc:	e8 e6 01 00 00       	call   2c7 <exit>

000000e1 <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  e1:	f3 0f 1e fb          	endbr32 
  e5:	55                   	push   %ebp
  e6:	89 e5                	mov    %esp,%ebp
  e8:	53                   	push   %ebx
  e9:	8b 4d 08             	mov    0x8(%ebp),%ecx
  ec:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  ef:	b8 00 00 00 00       	mov    $0x0,%eax
  f4:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  f8:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  fb:	83 c0 01             	add    $0x1,%eax
  fe:	84 d2                	test   %dl,%dl
 100:	75 f2                	jne    f4 <strcpy+0x13>
    ;
  return os;
}
 102:	89 c8                	mov    %ecx,%eax
 104:	5b                   	pop    %ebx
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    

00000107 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 107:	f3 0f 1e fb          	endbr32 
 10b:	55                   	push   %ebp
 10c:	89 e5                	mov    %esp,%ebp
 10e:	8b 4d 08             	mov    0x8(%ebp),%ecx
 111:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 114:	0f b6 01             	movzbl (%ecx),%eax
 117:	84 c0                	test   %al,%al
 119:	74 11                	je     12c <strcmp+0x25>
 11b:	38 02                	cmp    %al,(%edx)
 11d:	75 0d                	jne    12c <strcmp+0x25>
    p++, q++;
 11f:	83 c1 01             	add    $0x1,%ecx
 122:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 125:	0f b6 01             	movzbl (%ecx),%eax
 128:	84 c0                	test   %al,%al
 12a:	75 ef                	jne    11b <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 12c:	0f b6 c0             	movzbl %al,%eax
 12f:	0f b6 12             	movzbl (%edx),%edx
 132:	29 d0                	sub    %edx,%eax
}
 134:	5d                   	pop    %ebp
 135:	c3                   	ret    

00000136 <strlen>:

uint
strlen(char *s)
{
 136:	f3 0f 1e fb          	endbr32 
 13a:	55                   	push   %ebp
 13b:	89 e5                	mov    %esp,%ebp
 13d:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 140:	80 3a 00             	cmpb   $0x0,(%edx)
 143:	74 14                	je     159 <strlen+0x23>
 145:	b8 00 00 00 00       	mov    $0x0,%eax
 14a:	83 c0 01             	add    $0x1,%eax
 14d:	89 c1                	mov    %eax,%ecx
 14f:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 153:	75 f5                	jne    14a <strlen+0x14>
    ;
  return n;
}
 155:	89 c8                	mov    %ecx,%eax
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
  for(n = 0; s[n]; n++)
 159:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 15e:	eb f5                	jmp    155 <strlen+0x1f>

00000160 <memset>:

void*
memset(void *dst, int c, uint n)
{
 160:	f3 0f 1e fb          	endbr32 
 164:	55                   	push   %ebp
 165:	89 e5                	mov    %esp,%ebp
 167:	57                   	push   %edi
 168:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 16b:	89 d7                	mov    %edx,%edi
 16d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 170:	8b 45 0c             	mov    0xc(%ebp),%eax
 173:	fc                   	cld    
 174:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 176:	89 d0                	mov    %edx,%eax
 178:	5f                   	pop    %edi
 179:	5d                   	pop    %ebp
 17a:	c3                   	ret    

0000017b <strchr>:

char*
strchr(const char *s, char c)
{
 17b:	f3 0f 1e fb          	endbr32 
 17f:	55                   	push   %ebp
 180:	89 e5                	mov    %esp,%ebp
 182:	8b 45 08             	mov    0x8(%ebp),%eax
 185:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 189:	0f b6 10             	movzbl (%eax),%edx
 18c:	84 d2                	test   %dl,%dl
 18e:	74 15                	je     1a5 <strchr+0x2a>
    if(*s == c)
 190:	38 d1                	cmp    %dl,%cl
 192:	74 0f                	je     1a3 <strchr+0x28>
  for(; *s; s++)
 194:	83 c0 01             	add    $0x1,%eax
 197:	0f b6 10             	movzbl (%eax),%edx
 19a:	84 d2                	test   %dl,%dl
 19c:	75 f2                	jne    190 <strchr+0x15>
      return (char*)s;
  return 0;
 19e:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1a3:	5d                   	pop    %ebp
 1a4:	c3                   	ret    
  return 0;
 1a5:	b8 00 00 00 00       	mov    $0x0,%eax
 1aa:	eb f7                	jmp    1a3 <strchr+0x28>

000001ac <gets>:

char*
gets(char *buf, int max)
{
 1ac:	f3 0f 1e fb          	endbr32 
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	57                   	push   %edi
 1b4:	56                   	push   %esi
 1b5:	53                   	push   %ebx
 1b6:	83 ec 2c             	sub    $0x2c,%esp
 1b9:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1bc:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 1c1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1c4:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1c7:	83 c3 01             	add    $0x1,%ebx
 1ca:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1cd:	7d 27                	jge    1f6 <gets+0x4a>
    cc = read(0, &c, 1);
 1cf:	83 ec 04             	sub    $0x4,%esp
 1d2:	6a 01                	push   $0x1
 1d4:	57                   	push   %edi
 1d5:	6a 00                	push   $0x0
 1d7:	e8 03 01 00 00       	call   2df <read>
    if(cc < 1)
 1dc:	83 c4 10             	add    $0x10,%esp
 1df:	85 c0                	test   %eax,%eax
 1e1:	7e 13                	jle    1f6 <gets+0x4a>
      break;
    buf[i++] = c;
 1e3:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1e7:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 1eb:	3c 0a                	cmp    $0xa,%al
 1ed:	74 04                	je     1f3 <gets+0x47>
 1ef:	3c 0d                	cmp    $0xd,%al
 1f1:	75 d1                	jne    1c4 <gets+0x18>
  for(i=0; i+1 < max; ){
 1f3:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 1f6:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 1f9:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 1fd:	89 f0                	mov    %esi,%eax
 1ff:	8d 65 f4             	lea    -0xc(%ebp),%esp
 202:	5b                   	pop    %ebx
 203:	5e                   	pop    %esi
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    

00000207 <stat>:

int
stat(char *n, struct stat *st)
{
 207:	f3 0f 1e fb          	endbr32 
 20b:	55                   	push   %ebp
 20c:	89 e5                	mov    %esp,%ebp
 20e:	56                   	push   %esi
 20f:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 210:	83 ec 08             	sub    $0x8,%esp
 213:	6a 00                	push   $0x0
 215:	ff 75 08             	pushl  0x8(%ebp)
 218:	e8 ea 00 00 00       	call   307 <open>
  if(fd < 0)
 21d:	83 c4 10             	add    $0x10,%esp
 220:	85 c0                	test   %eax,%eax
 222:	78 24                	js     248 <stat+0x41>
 224:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 226:	83 ec 08             	sub    $0x8,%esp
 229:	ff 75 0c             	pushl  0xc(%ebp)
 22c:	50                   	push   %eax
 22d:	e8 ed 00 00 00       	call   31f <fstat>
 232:	89 c6                	mov    %eax,%esi
  close(fd);
 234:	89 1c 24             	mov    %ebx,(%esp)
 237:	e8 b3 00 00 00       	call   2ef <close>
  return r;
 23c:	83 c4 10             	add    $0x10,%esp
}
 23f:	89 f0                	mov    %esi,%eax
 241:	8d 65 f8             	lea    -0x8(%ebp),%esp
 244:	5b                   	pop    %ebx
 245:	5e                   	pop    %esi
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
    return -1;
 248:	be ff ff ff ff       	mov    $0xffffffff,%esi
 24d:	eb f0                	jmp    23f <stat+0x38>

0000024f <atoi>:

int
atoi(const char *s)
{
 24f:	f3 0f 1e fb          	endbr32 
 253:	55                   	push   %ebp
 254:	89 e5                	mov    %esp,%ebp
 256:	53                   	push   %ebx
 257:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 25a:	0f b6 02             	movzbl (%edx),%eax
 25d:	8d 48 d0             	lea    -0x30(%eax),%ecx
 260:	80 f9 09             	cmp    $0x9,%cl
 263:	77 22                	ja     287 <atoi+0x38>
  n = 0;
 265:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 26a:	83 c2 01             	add    $0x1,%edx
 26d:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 270:	0f be c0             	movsbl %al,%eax
 273:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 277:	0f b6 02             	movzbl (%edx),%eax
 27a:	8d 58 d0             	lea    -0x30(%eax),%ebx
 27d:	80 fb 09             	cmp    $0x9,%bl
 280:	76 e8                	jbe    26a <atoi+0x1b>
  return n;
}
 282:	89 c8                	mov    %ecx,%eax
 284:	5b                   	pop    %ebx
 285:	5d                   	pop    %ebp
 286:	c3                   	ret    
  n = 0;
 287:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 28c:	eb f4                	jmp    282 <atoi+0x33>

0000028e <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 28e:	f3 0f 1e fb          	endbr32 
 292:	55                   	push   %ebp
 293:	89 e5                	mov    %esp,%ebp
 295:	56                   	push   %esi
 296:	53                   	push   %ebx
 297:	8b 75 08             	mov    0x8(%ebp),%esi
 29a:	8b 55 0c             	mov    0xc(%ebp),%edx
 29d:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2a0:	85 db                	test   %ebx,%ebx
 2a2:	7e 15                	jle    2b9 <memmove+0x2b>
 2a4:	01 f3                	add    %esi,%ebx
  dst = vdst;
 2a6:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 2a8:	83 c2 01             	add    $0x1,%edx
 2ab:	83 c0 01             	add    $0x1,%eax
 2ae:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 2b2:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 2b5:	39 c3                	cmp    %eax,%ebx
 2b7:	75 ef                	jne    2a8 <memmove+0x1a>
  return vdst;
}
 2b9:	89 f0                	mov    %esi,%eax
 2bb:	5b                   	pop    %ebx
 2bc:	5e                   	pop    %esi
 2bd:	5d                   	pop    %ebp
 2be:	c3                   	ret    

000002bf <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2bf:	b8 01 00 00 00       	mov    $0x1,%eax
 2c4:	cd 40                	int    $0x40
 2c6:	c3                   	ret    

000002c7 <exit>:
SYSCALL(exit)
 2c7:	b8 02 00 00 00       	mov    $0x2,%eax
 2cc:	cd 40                	int    $0x40
 2ce:	c3                   	ret    

000002cf <wait>:
SYSCALL(wait)
 2cf:	b8 03 00 00 00       	mov    $0x3,%eax
 2d4:	cd 40                	int    $0x40
 2d6:	c3                   	ret    

000002d7 <pipe>:
SYSCALL(pipe)
 2d7:	b8 04 00 00 00       	mov    $0x4,%eax
 2dc:	cd 40                	int    $0x40
 2de:	c3                   	ret    

000002df <read>:
SYSCALL(read)
 2df:	b8 05 00 00 00       	mov    $0x5,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <write>:
SYSCALL(write)
 2e7:	b8 10 00 00 00       	mov    $0x10,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <close>:
SYSCALL(close)
 2ef:	b8 15 00 00 00       	mov    $0x15,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <kill>:
SYSCALL(kill)
 2f7:	b8 06 00 00 00       	mov    $0x6,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <exec>:
SYSCALL(exec)
 2ff:	b8 07 00 00 00       	mov    $0x7,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <open>:
SYSCALL(open)
 307:	b8 0f 00 00 00       	mov    $0xf,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <mknod>:
SYSCALL(mknod)
 30f:	b8 11 00 00 00       	mov    $0x11,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <unlink>:
SYSCALL(unlink)
 317:	b8 12 00 00 00       	mov    $0x12,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <fstat>:
SYSCALL(fstat)
 31f:	b8 08 00 00 00       	mov    $0x8,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <link>:
SYSCALL(link)
 327:	b8 13 00 00 00       	mov    $0x13,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <mkdir>:
SYSCALL(mkdir)
 32f:	b8 14 00 00 00       	mov    $0x14,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <chdir>:
SYSCALL(chdir)
 337:	b8 09 00 00 00       	mov    $0x9,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <dup>:
SYSCALL(dup)
 33f:	b8 0a 00 00 00       	mov    $0xa,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <getpid>:
SYSCALL(getpid)
 347:	b8 0b 00 00 00       	mov    $0xb,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <sbrk>:
SYSCALL(sbrk)
 34f:	b8 0c 00 00 00       	mov    $0xc,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <sleep>:
SYSCALL(sleep)
 357:	b8 0d 00 00 00       	mov    $0xd,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <uptime>:
SYSCALL(uptime)
 35f:	b8 0e 00 00 00       	mov    $0xe,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 367:	55                   	push   %ebp
 368:	89 e5                	mov    %esp,%ebp
 36a:	57                   	push   %edi
 36b:	56                   	push   %esi
 36c:	53                   	push   %ebx
 36d:	83 ec 3c             	sub    $0x3c,%esp
 370:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 373:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 375:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 379:	74 77                	je     3f2 <printint+0x8b>
 37b:	85 d2                	test   %edx,%edx
 37d:	79 73                	jns    3f2 <printint+0x8b>
    neg = 1;
    x = -xx;
 37f:	f7 db                	neg    %ebx
    neg = 1;
 381:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 388:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 38d:	89 f7                	mov    %esi,%edi
 38f:	83 c6 01             	add    $0x1,%esi
 392:	89 d8                	mov    %ebx,%eax
 394:	ba 00 00 00 00       	mov    $0x0,%edx
 399:	f7 f1                	div    %ecx
 39b:	0f b6 92 6c 07 00 00 	movzbl 0x76c(%edx),%edx
 3a2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3a6:	89 da                	mov    %ebx,%edx
 3a8:	89 c3                	mov    %eax,%ebx
 3aa:	39 d1                	cmp    %edx,%ecx
 3ac:	76 df                	jbe    38d <printint+0x26>
  if(neg)
 3ae:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 3b2:	74 08                	je     3bc <printint+0x55>
    buf[i++] = '-';
 3b4:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3b9:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 3bc:	85 f6                	test   %esi,%esi
 3be:	7e 2a                	jle    3ea <printint+0x83>
 3c0:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 3c4:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 3c7:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 3ca:	0f b6 03             	movzbl (%ebx),%eax
 3cd:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3d0:	83 ec 04             	sub    $0x4,%esp
 3d3:	6a 01                	push   $0x1
 3d5:	56                   	push   %esi
 3d6:	ff 75 c4             	pushl  -0x3c(%ebp)
 3d9:	e8 09 ff ff ff       	call   2e7 <write>
  while(--i >= 0)
 3de:	89 d8                	mov    %ebx,%eax
 3e0:	83 eb 01             	sub    $0x1,%ebx
 3e3:	83 c4 10             	add    $0x10,%esp
 3e6:	39 f8                	cmp    %edi,%eax
 3e8:	75 e0                	jne    3ca <printint+0x63>
}
 3ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3ed:	5b                   	pop    %ebx
 3ee:	5e                   	pop    %esi
 3ef:	5f                   	pop    %edi
 3f0:	5d                   	pop    %ebp
 3f1:	c3                   	ret    
  neg = 0;
 3f2:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 3f9:	eb 8d                	jmp    388 <printint+0x21>

000003fb <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 3fb:	f3 0f 1e fb          	endbr32 
 3ff:	55                   	push   %ebp
 400:	89 e5                	mov    %esp,%ebp
 402:	57                   	push   %edi
 403:	56                   	push   %esi
 404:	53                   	push   %ebx
 405:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 408:	8b 75 0c             	mov    0xc(%ebp),%esi
 40b:	0f b6 1e             	movzbl (%esi),%ebx
 40e:	84 db                	test   %bl,%bl
 410:	0f 84 ab 01 00 00    	je     5c1 <printf+0x1c6>
 416:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 419:	8d 45 10             	lea    0x10(%ebp),%eax
 41c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 41f:	bf 00 00 00 00       	mov    $0x0,%edi
 424:	eb 2d                	jmp    453 <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 426:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 429:	83 ec 04             	sub    $0x4,%esp
 42c:	6a 01                	push   $0x1
 42e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 431:	50                   	push   %eax
 432:	ff 75 08             	pushl  0x8(%ebp)
 435:	e8 ad fe ff ff       	call   2e7 <write>
        putc(fd, c);
 43a:	83 c4 10             	add    $0x10,%esp
 43d:	eb 05                	jmp    444 <printf+0x49>
      }
    } else if(state == '%'){
 43f:	83 ff 25             	cmp    $0x25,%edi
 442:	74 22                	je     466 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 444:	83 c6 01             	add    $0x1,%esi
 447:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 44b:	84 db                	test   %bl,%bl
 44d:	0f 84 6e 01 00 00    	je     5c1 <printf+0x1c6>
    c = fmt[i] & 0xff;
 453:	0f be d3             	movsbl %bl,%edx
 456:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 459:	85 ff                	test   %edi,%edi
 45b:	75 e2                	jne    43f <printf+0x44>
      if(c == '%'){
 45d:	83 f8 25             	cmp    $0x25,%eax
 460:	75 c4                	jne    426 <printf+0x2b>
        state = '%';
 462:	89 c7                	mov    %eax,%edi
 464:	eb de                	jmp    444 <printf+0x49>
      if(c == 'd'){
 466:	83 f8 64             	cmp    $0x64,%eax
 469:	74 59                	je     4c4 <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 46b:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 471:	83 fa 70             	cmp    $0x70,%edx
 474:	74 7a                	je     4f0 <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 476:	83 f8 73             	cmp    $0x73,%eax
 479:	0f 84 9d 00 00 00    	je     51c <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 47f:	83 f8 63             	cmp    $0x63,%eax
 482:	0f 84 ec 00 00 00    	je     574 <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 488:	83 f8 25             	cmp    $0x25,%eax
 48b:	0f 84 0f 01 00 00    	je     5a0 <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 491:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 495:	83 ec 04             	sub    $0x4,%esp
 498:	6a 01                	push   $0x1
 49a:	8d 45 e7             	lea    -0x19(%ebp),%eax
 49d:	50                   	push   %eax
 49e:	ff 75 08             	pushl  0x8(%ebp)
 4a1:	e8 41 fe ff ff       	call   2e7 <write>
        putc(fd, c);
 4a6:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4a9:	83 c4 0c             	add    $0xc,%esp
 4ac:	6a 01                	push   $0x1
 4ae:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4b1:	50                   	push   %eax
 4b2:	ff 75 08             	pushl  0x8(%ebp)
 4b5:	e8 2d fe ff ff       	call   2e7 <write>
        putc(fd, c);
 4ba:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4bd:	bf 00 00 00 00       	mov    $0x0,%edi
 4c2:	eb 80                	jmp    444 <printf+0x49>
        printint(fd, *ap, 10, 1);
 4c4:	83 ec 0c             	sub    $0xc,%esp
 4c7:	6a 01                	push   $0x1
 4c9:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4ce:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4d1:	8b 17                	mov    (%edi),%edx
 4d3:	8b 45 08             	mov    0x8(%ebp),%eax
 4d6:	e8 8c fe ff ff       	call   367 <printint>
        ap++;
 4db:	89 f8                	mov    %edi,%eax
 4dd:	83 c0 04             	add    $0x4,%eax
 4e0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4e3:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e6:	bf 00 00 00 00       	mov    $0x0,%edi
 4eb:	e9 54 ff ff ff       	jmp    444 <printf+0x49>
        printint(fd, *ap, 16, 0);
 4f0:	83 ec 0c             	sub    $0xc,%esp
 4f3:	6a 00                	push   $0x0
 4f5:	b9 10 00 00 00       	mov    $0x10,%ecx
 4fa:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4fd:	8b 17                	mov    (%edi),%edx
 4ff:	8b 45 08             	mov    0x8(%ebp),%eax
 502:	e8 60 fe ff ff       	call   367 <printint>
        ap++;
 507:	89 f8                	mov    %edi,%eax
 509:	83 c0 04             	add    $0x4,%eax
 50c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 50f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 512:	bf 00 00 00 00       	mov    $0x0,%edi
 517:	e9 28 ff ff ff       	jmp    444 <printf+0x49>
        s = (char*)*ap;
 51c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 51f:	8b 01                	mov    (%ecx),%eax
        ap++;
 521:	83 c1 04             	add    $0x4,%ecx
 524:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 527:	85 c0                	test   %eax,%eax
 529:	74 13                	je     53e <printf+0x143>
        s = (char*)*ap;
 52b:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 52d:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 530:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 535:	84 c0                	test   %al,%al
 537:	75 0f                	jne    548 <printf+0x14d>
 539:	e9 06 ff ff ff       	jmp    444 <printf+0x49>
          s = "(null)";
 53e:	bb 64 07 00 00       	mov    $0x764,%ebx
        while(*s != 0){
 543:	b8 28 00 00 00       	mov    $0x28,%eax
 548:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 54b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 54e:	83 ec 04             	sub    $0x4,%esp
 551:	6a 01                	push   $0x1
 553:	8d 45 e7             	lea    -0x19(%ebp),%eax
 556:	50                   	push   %eax
 557:	57                   	push   %edi
 558:	e8 8a fd ff ff       	call   2e7 <write>
          s++;
 55d:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 560:	0f b6 03             	movzbl (%ebx),%eax
 563:	83 c4 10             	add    $0x10,%esp
 566:	84 c0                	test   %al,%al
 568:	75 e1                	jne    54b <printf+0x150>
      state = 0;
 56a:	bf 00 00 00 00       	mov    $0x0,%edi
 56f:	e9 d0 fe ff ff       	jmp    444 <printf+0x49>
        putc(fd, *ap);
 574:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 577:	8b 07                	mov    (%edi),%eax
 579:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 57c:	83 ec 04             	sub    $0x4,%esp
 57f:	6a 01                	push   $0x1
 581:	8d 45 e7             	lea    -0x19(%ebp),%eax
 584:	50                   	push   %eax
 585:	ff 75 08             	pushl  0x8(%ebp)
 588:	e8 5a fd ff ff       	call   2e7 <write>
        ap++;
 58d:	83 c7 04             	add    $0x4,%edi
 590:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 593:	83 c4 10             	add    $0x10,%esp
      state = 0;
 596:	bf 00 00 00 00       	mov    $0x0,%edi
 59b:	e9 a4 fe ff ff       	jmp    444 <printf+0x49>
        putc(fd, c);
 5a0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5a3:	83 ec 04             	sub    $0x4,%esp
 5a6:	6a 01                	push   $0x1
 5a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5ab:	50                   	push   %eax
 5ac:	ff 75 08             	pushl  0x8(%ebp)
 5af:	e8 33 fd ff ff       	call   2e7 <write>
 5b4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b7:	bf 00 00 00 00       	mov    $0x0,%edi
 5bc:	e9 83 fe ff ff       	jmp    444 <printf+0x49>
    }
  }
}
 5c1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5c4:	5b                   	pop    %ebx
 5c5:	5e                   	pop    %esi
 5c6:	5f                   	pop    %edi
 5c7:	5d                   	pop    %ebp
 5c8:	c3                   	ret    

000005c9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5c9:	f3 0f 1e fb          	endbr32 
 5cd:	55                   	push   %ebp
 5ce:	89 e5                	mov    %esp,%ebp
 5d0:	57                   	push   %edi
 5d1:	56                   	push   %esi
 5d2:	53                   	push   %ebx
 5d3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5d6:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5d9:	a1 e0 09 00 00       	mov    0x9e0,%eax
 5de:	eb 0c                	jmp    5ec <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5e0:	8b 10                	mov    (%eax),%edx
 5e2:	39 c2                	cmp    %eax,%edx
 5e4:	77 04                	ja     5ea <free+0x21>
 5e6:	39 ca                	cmp    %ecx,%edx
 5e8:	77 10                	ja     5fa <free+0x31>
{
 5ea:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5ec:	39 c8                	cmp    %ecx,%eax
 5ee:	73 f0                	jae    5e0 <free+0x17>
 5f0:	8b 10                	mov    (%eax),%edx
 5f2:	39 ca                	cmp    %ecx,%edx
 5f4:	77 04                	ja     5fa <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 5f6:	39 c2                	cmp    %eax,%edx
 5f8:	77 f0                	ja     5ea <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 5fa:	8b 73 fc             	mov    -0x4(%ebx),%esi
 5fd:	8b 10                	mov    (%eax),%edx
 5ff:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 602:	39 fa                	cmp    %edi,%edx
 604:	74 19                	je     61f <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 606:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 609:	8b 50 04             	mov    0x4(%eax),%edx
 60c:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 60f:	39 f1                	cmp    %esi,%ecx
 611:	74 1b                	je     62e <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 613:	89 08                	mov    %ecx,(%eax)
  freep = p;
 615:	a3 e0 09 00 00       	mov    %eax,0x9e0
}
 61a:	5b                   	pop    %ebx
 61b:	5e                   	pop    %esi
 61c:	5f                   	pop    %edi
 61d:	5d                   	pop    %ebp
 61e:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 61f:	03 72 04             	add    0x4(%edx),%esi
 622:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 625:	8b 10                	mov    (%eax),%edx
 627:	8b 12                	mov    (%edx),%edx
 629:	89 53 f8             	mov    %edx,-0x8(%ebx)
 62c:	eb db                	jmp    609 <free+0x40>
    p->s.size += bp->s.size;
 62e:	03 53 fc             	add    -0x4(%ebx),%edx
 631:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 634:	8b 53 f8             	mov    -0x8(%ebx),%edx
 637:	89 10                	mov    %edx,(%eax)
 639:	eb da                	jmp    615 <free+0x4c>

0000063b <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 63b:	f3 0f 1e fb          	endbr32 
 63f:	55                   	push   %ebp
 640:	89 e5                	mov    %esp,%ebp
 642:	57                   	push   %edi
 643:	56                   	push   %esi
 644:	53                   	push   %ebx
 645:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 648:	8b 45 08             	mov    0x8(%ebp),%eax
 64b:	8d 58 07             	lea    0x7(%eax),%ebx
 64e:	c1 eb 03             	shr    $0x3,%ebx
 651:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 654:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
 65a:	85 d2                	test   %edx,%edx
 65c:	74 20                	je     67e <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 65e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 660:	8b 48 04             	mov    0x4(%eax),%ecx
 663:	39 cb                	cmp    %ecx,%ebx
 665:	76 3c                	jbe    6a3 <malloc+0x68>
 667:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 66d:	be 00 10 00 00       	mov    $0x1000,%esi
 672:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 675:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 67c:	eb 72                	jmp    6f0 <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 67e:	c7 05 e0 09 00 00 e4 	movl   $0x9e4,0x9e0
 685:	09 00 00 
 688:	c7 05 e4 09 00 00 e4 	movl   $0x9e4,0x9e4
 68f:	09 00 00 
    base.s.size = 0;
 692:	c7 05 e8 09 00 00 00 	movl   $0x0,0x9e8
 699:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 69c:	b8 e4 09 00 00       	mov    $0x9e4,%eax
 6a1:	eb c4                	jmp    667 <malloc+0x2c>
      if(p->s.size == nunits)
 6a3:	39 cb                	cmp    %ecx,%ebx
 6a5:	74 1e                	je     6c5 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6a7:	29 d9                	sub    %ebx,%ecx
 6a9:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6ac:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6af:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6b2:	89 15 e0 09 00 00    	mov    %edx,0x9e0
      return (void*)(p + 1);
 6b8:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6bb:	89 d0                	mov    %edx,%eax
 6bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6c0:	5b                   	pop    %ebx
 6c1:	5e                   	pop    %esi
 6c2:	5f                   	pop    %edi
 6c3:	5d                   	pop    %ebp
 6c4:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6c5:	8b 08                	mov    (%eax),%ecx
 6c7:	89 0a                	mov    %ecx,(%edx)
 6c9:	eb e7                	jmp    6b2 <malloc+0x77>
  hp->s.size = nu;
 6cb:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6ce:	83 ec 0c             	sub    $0xc,%esp
 6d1:	83 c0 08             	add    $0x8,%eax
 6d4:	50                   	push   %eax
 6d5:	e8 ef fe ff ff       	call   5c9 <free>
  return freep;
 6da:	8b 15 e0 09 00 00    	mov    0x9e0,%edx
      if((p = morecore(nunits)) == 0)
 6e0:	83 c4 10             	add    $0x10,%esp
 6e3:	85 d2                	test   %edx,%edx
 6e5:	74 d4                	je     6bb <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6e7:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6e9:	8b 48 04             	mov    0x4(%eax),%ecx
 6ec:	39 d9                	cmp    %ebx,%ecx
 6ee:	73 b3                	jae    6a3 <malloc+0x68>
    if(p == freep)
 6f0:	89 c2                	mov    %eax,%edx
 6f2:	39 05 e0 09 00 00    	cmp    %eax,0x9e0
 6f8:	75 ed                	jne    6e7 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 6fa:	83 ec 0c             	sub    $0xc,%esp
 6fd:	57                   	push   %edi
 6fe:	e8 4c fc ff ff       	call   34f <sbrk>
  if(p == (char*)-1)
 703:	83 c4 10             	add    $0x10,%esp
 706:	83 f8 ff             	cmp    $0xffffffff,%eax
 709:	75 c0                	jne    6cb <malloc+0x90>
        return 0;
 70b:	ba 00 00 00 00       	mov    $0x0,%edx
 710:	eb a9                	jmp    6bb <malloc+0x80>
