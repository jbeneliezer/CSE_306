
_rm:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/stat.h"
#include "user.h"

int
main(int argc, char *argv[])
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	57                   	push   %edi
  12:	56                   	push   %esi
  13:	53                   	push   %ebx
  14:	51                   	push   %ecx
  15:	83 ec 18             	sub    $0x18,%esp
  18:	8b 39                	mov    (%ecx),%edi
  1a:	8b 59 04             	mov    0x4(%ecx),%ebx
  int i;

  if(argc < 2){
  1d:	83 c3 04             	add    $0x4,%ebx
    printf(2, "Usage: rm files...\n");
    exit();
  }

  for(i = 1; i < argc; i++){
  20:	be 01 00 00 00       	mov    $0x1,%esi
  if(argc < 2){
  25:	83 ff 01             	cmp    $0x1,%edi
  28:	7e 20                	jle    4a <main+0x4a>
    if(unlink(argv[i]) < 0){
  2a:	89 5d e4             	mov    %ebx,-0x1c(%ebp)
  2d:	83 ec 0c             	sub    $0xc,%esp
  30:	ff 33                	pushl  (%ebx)
  32:	e8 79 02 00 00       	call   2b0 <unlink>
  37:	83 c4 10             	add    $0x10,%esp
  3a:	85 c0                	test   %eax,%eax
  3c:	78 20                	js     5e <main+0x5e>
  for(i = 1; i < argc; i++){
  3e:	83 c6 01             	add    $0x1,%esi
  41:	83 c3 04             	add    $0x4,%ebx
  44:	39 f7                	cmp    %esi,%edi
  46:	75 e2                	jne    2a <main+0x2a>
  48:	eb 2b                	jmp    75 <main+0x75>
    printf(2, "Usage: rm files...\n");
  4a:	83 ec 08             	sub    $0x8,%esp
  4d:	68 ac 06 00 00       	push   $0x6ac
  52:	6a 02                	push   $0x2
  54:	e8 3b 03 00 00       	call   394 <printf>
    exit();
  59:	e8 02 02 00 00       	call   260 <exit>
      printf(2, "rm: %s failed to delete\n", argv[i]);
  5e:	83 ec 04             	sub    $0x4,%esp
  61:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  64:	ff 30                	pushl  (%eax)
  66:	68 c0 06 00 00       	push   $0x6c0
  6b:	6a 02                	push   $0x2
  6d:	e8 22 03 00 00       	call   394 <printf>
      break;
  72:	83 c4 10             	add    $0x10,%esp
    }
  }

  exit();
  75:	e8 e6 01 00 00       	call   260 <exit>

0000007a <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  7a:	f3 0f 1e fb          	endbr32 
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  81:	53                   	push   %ebx
  82:	8b 4d 08             	mov    0x8(%ebp),%ecx
  85:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  88:	b8 00 00 00 00       	mov    $0x0,%eax
  8d:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  91:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  94:	83 c0 01             	add    $0x1,%eax
  97:	84 d2                	test   %dl,%dl
  99:	75 f2                	jne    8d <strcpy+0x13>
    ;
  return os;
}
  9b:	89 c8                	mov    %ecx,%eax
  9d:	5b                   	pop    %ebx
  9e:	5d                   	pop    %ebp
  9f:	c3                   	ret    

000000a0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  a0:	f3 0f 1e fb          	endbr32 
  a4:	55                   	push   %ebp
  a5:	89 e5                	mov    %esp,%ebp
  a7:	8b 4d 08             	mov    0x8(%ebp),%ecx
  aa:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  ad:	0f b6 01             	movzbl (%ecx),%eax
  b0:	84 c0                	test   %al,%al
  b2:	74 11                	je     c5 <strcmp+0x25>
  b4:	38 02                	cmp    %al,(%edx)
  b6:	75 0d                	jne    c5 <strcmp+0x25>
    p++, q++;
  b8:	83 c1 01             	add    $0x1,%ecx
  bb:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  be:	0f b6 01             	movzbl (%ecx),%eax
  c1:	84 c0                	test   %al,%al
  c3:	75 ef                	jne    b4 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  c5:	0f b6 c0             	movzbl %al,%eax
  c8:	0f b6 12             	movzbl (%edx),%edx
  cb:	29 d0                	sub    %edx,%eax
}
  cd:	5d                   	pop    %ebp
  ce:	c3                   	ret    

000000cf <strlen>:

uint
strlen(char *s)
{
  cf:	f3 0f 1e fb          	endbr32 
  d3:	55                   	push   %ebp
  d4:	89 e5                	mov    %esp,%ebp
  d6:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  d9:	80 3a 00             	cmpb   $0x0,(%edx)
  dc:	74 14                	je     f2 <strlen+0x23>
  de:	b8 00 00 00 00       	mov    $0x0,%eax
  e3:	83 c0 01             	add    $0x1,%eax
  e6:	89 c1                	mov    %eax,%ecx
  e8:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  ec:	75 f5                	jne    e3 <strlen+0x14>
    ;
  return n;
}
  ee:	89 c8                	mov    %ecx,%eax
  f0:	5d                   	pop    %ebp
  f1:	c3                   	ret    
  for(n = 0; s[n]; n++)
  f2:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
  f7:	eb f5                	jmp    ee <strlen+0x1f>

000000f9 <memset>:

void*
memset(void *dst, int c, uint n)
{
  f9:	f3 0f 1e fb          	endbr32 
  fd:	55                   	push   %ebp
  fe:	89 e5                	mov    %esp,%ebp
 100:	57                   	push   %edi
 101:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 104:	89 d7                	mov    %edx,%edi
 106:	8b 4d 10             	mov    0x10(%ebp),%ecx
 109:	8b 45 0c             	mov    0xc(%ebp),%eax
 10c:	fc                   	cld    
 10d:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 10f:	89 d0                	mov    %edx,%eax
 111:	5f                   	pop    %edi
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    

00000114 <strchr>:

char*
strchr(const char *s, char c)
{
 114:	f3 0f 1e fb          	endbr32 
 118:	55                   	push   %ebp
 119:	89 e5                	mov    %esp,%ebp
 11b:	8b 45 08             	mov    0x8(%ebp),%eax
 11e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 122:	0f b6 10             	movzbl (%eax),%edx
 125:	84 d2                	test   %dl,%dl
 127:	74 15                	je     13e <strchr+0x2a>
    if(*s == c)
 129:	38 d1                	cmp    %dl,%cl
 12b:	74 0f                	je     13c <strchr+0x28>
  for(; *s; s++)
 12d:	83 c0 01             	add    $0x1,%eax
 130:	0f b6 10             	movzbl (%eax),%edx
 133:	84 d2                	test   %dl,%dl
 135:	75 f2                	jne    129 <strchr+0x15>
      return (char*)s;
  return 0;
 137:	b8 00 00 00 00       	mov    $0x0,%eax
}
 13c:	5d                   	pop    %ebp
 13d:	c3                   	ret    
  return 0;
 13e:	b8 00 00 00 00       	mov    $0x0,%eax
 143:	eb f7                	jmp    13c <strchr+0x28>

00000145 <gets>:

char*
gets(char *buf, int max)
{
 145:	f3 0f 1e fb          	endbr32 
 149:	55                   	push   %ebp
 14a:	89 e5                	mov    %esp,%ebp
 14c:	57                   	push   %edi
 14d:	56                   	push   %esi
 14e:	53                   	push   %ebx
 14f:	83 ec 2c             	sub    $0x2c,%esp
 152:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 155:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 15a:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 15d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 160:	83 c3 01             	add    $0x1,%ebx
 163:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 166:	7d 27                	jge    18f <gets+0x4a>
    cc = read(0, &c, 1);
 168:	83 ec 04             	sub    $0x4,%esp
 16b:	6a 01                	push   $0x1
 16d:	57                   	push   %edi
 16e:	6a 00                	push   $0x0
 170:	e8 03 01 00 00       	call   278 <read>
    if(cc < 1)
 175:	83 c4 10             	add    $0x10,%esp
 178:	85 c0                	test   %eax,%eax
 17a:	7e 13                	jle    18f <gets+0x4a>
      break;
    buf[i++] = c;
 17c:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 180:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 184:	3c 0a                	cmp    $0xa,%al
 186:	74 04                	je     18c <gets+0x47>
 188:	3c 0d                	cmp    $0xd,%al
 18a:	75 d1                	jne    15d <gets+0x18>
  for(i=0; i+1 < max; ){
 18c:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 18f:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 192:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 196:	89 f0                	mov    %esi,%eax
 198:	8d 65 f4             	lea    -0xc(%ebp),%esp
 19b:	5b                   	pop    %ebx
 19c:	5e                   	pop    %esi
 19d:	5f                   	pop    %edi
 19e:	5d                   	pop    %ebp
 19f:	c3                   	ret    

000001a0 <stat>:

int
stat(char *n, struct stat *st)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	56                   	push   %esi
 1a8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1a9:	83 ec 08             	sub    $0x8,%esp
 1ac:	6a 00                	push   $0x0
 1ae:	ff 75 08             	pushl  0x8(%ebp)
 1b1:	e8 ea 00 00 00       	call   2a0 <open>
  if(fd < 0)
 1b6:	83 c4 10             	add    $0x10,%esp
 1b9:	85 c0                	test   %eax,%eax
 1bb:	78 24                	js     1e1 <stat+0x41>
 1bd:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1bf:	83 ec 08             	sub    $0x8,%esp
 1c2:	ff 75 0c             	pushl  0xc(%ebp)
 1c5:	50                   	push   %eax
 1c6:	e8 ed 00 00 00       	call   2b8 <fstat>
 1cb:	89 c6                	mov    %eax,%esi
  close(fd);
 1cd:	89 1c 24             	mov    %ebx,(%esp)
 1d0:	e8 b3 00 00 00       	call   288 <close>
  return r;
 1d5:	83 c4 10             	add    $0x10,%esp
}
 1d8:	89 f0                	mov    %esi,%eax
 1da:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1dd:	5b                   	pop    %ebx
 1de:	5e                   	pop    %esi
 1df:	5d                   	pop    %ebp
 1e0:	c3                   	ret    
    return -1;
 1e1:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1e6:	eb f0                	jmp    1d8 <stat+0x38>

000001e8 <atoi>:

int
atoi(const char *s)
{
 1e8:	f3 0f 1e fb          	endbr32 
 1ec:	55                   	push   %ebp
 1ed:	89 e5                	mov    %esp,%ebp
 1ef:	53                   	push   %ebx
 1f0:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1f3:	0f b6 02             	movzbl (%edx),%eax
 1f6:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1f9:	80 f9 09             	cmp    $0x9,%cl
 1fc:	77 22                	ja     220 <atoi+0x38>
  n = 0;
 1fe:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 203:	83 c2 01             	add    $0x1,%edx
 206:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 209:	0f be c0             	movsbl %al,%eax
 20c:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 210:	0f b6 02             	movzbl (%edx),%eax
 213:	8d 58 d0             	lea    -0x30(%eax),%ebx
 216:	80 fb 09             	cmp    $0x9,%bl
 219:	76 e8                	jbe    203 <atoi+0x1b>
  return n;
}
 21b:	89 c8                	mov    %ecx,%eax
 21d:	5b                   	pop    %ebx
 21e:	5d                   	pop    %ebp
 21f:	c3                   	ret    
  n = 0;
 220:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 225:	eb f4                	jmp    21b <atoi+0x33>

00000227 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 227:	f3 0f 1e fb          	endbr32 
 22b:	55                   	push   %ebp
 22c:	89 e5                	mov    %esp,%ebp
 22e:	56                   	push   %esi
 22f:	53                   	push   %ebx
 230:	8b 75 08             	mov    0x8(%ebp),%esi
 233:	8b 55 0c             	mov    0xc(%ebp),%edx
 236:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 239:	85 db                	test   %ebx,%ebx
 23b:	7e 15                	jle    252 <memmove+0x2b>
 23d:	01 f3                	add    %esi,%ebx
  dst = vdst;
 23f:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 241:	83 c2 01             	add    $0x1,%edx
 244:	83 c0 01             	add    $0x1,%eax
 247:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 24b:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 24e:	39 c3                	cmp    %eax,%ebx
 250:	75 ef                	jne    241 <memmove+0x1a>
  return vdst;
}
 252:	89 f0                	mov    %esi,%eax
 254:	5b                   	pop    %ebx
 255:	5e                   	pop    %esi
 256:	5d                   	pop    %ebp
 257:	c3                   	ret    

00000258 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 258:	b8 01 00 00 00       	mov    $0x1,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <exit>:
SYSCALL(exit)
 260:	b8 02 00 00 00       	mov    $0x2,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <wait>:
SYSCALL(wait)
 268:	b8 03 00 00 00       	mov    $0x3,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <pipe>:
SYSCALL(pipe)
 270:	b8 04 00 00 00       	mov    $0x4,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <read>:
SYSCALL(read)
 278:	b8 05 00 00 00       	mov    $0x5,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <write>:
SYSCALL(write)
 280:	b8 10 00 00 00       	mov    $0x10,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <close>:
SYSCALL(close)
 288:	b8 15 00 00 00       	mov    $0x15,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <kill>:
SYSCALL(kill)
 290:	b8 06 00 00 00       	mov    $0x6,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <exec>:
SYSCALL(exec)
 298:	b8 07 00 00 00       	mov    $0x7,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <open>:
SYSCALL(open)
 2a0:	b8 0f 00 00 00       	mov    $0xf,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <mknod>:
SYSCALL(mknod)
 2a8:	b8 11 00 00 00       	mov    $0x11,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <unlink>:
SYSCALL(unlink)
 2b0:	b8 12 00 00 00       	mov    $0x12,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <fstat>:
SYSCALL(fstat)
 2b8:	b8 08 00 00 00       	mov    $0x8,%eax
 2bd:	cd 40                	int    $0x40
 2bf:	c3                   	ret    

000002c0 <link>:
SYSCALL(link)
 2c0:	b8 13 00 00 00       	mov    $0x13,%eax
 2c5:	cd 40                	int    $0x40
 2c7:	c3                   	ret    

000002c8 <mkdir>:
SYSCALL(mkdir)
 2c8:	b8 14 00 00 00       	mov    $0x14,%eax
 2cd:	cd 40                	int    $0x40
 2cf:	c3                   	ret    

000002d0 <chdir>:
SYSCALL(chdir)
 2d0:	b8 09 00 00 00       	mov    $0x9,%eax
 2d5:	cd 40                	int    $0x40
 2d7:	c3                   	ret    

000002d8 <dup>:
SYSCALL(dup)
 2d8:	b8 0a 00 00 00       	mov    $0xa,%eax
 2dd:	cd 40                	int    $0x40
 2df:	c3                   	ret    

000002e0 <getpid>:
SYSCALL(getpid)
 2e0:	b8 0b 00 00 00       	mov    $0xb,%eax
 2e5:	cd 40                	int    $0x40
 2e7:	c3                   	ret    

000002e8 <sbrk>:
SYSCALL(sbrk)
 2e8:	b8 0c 00 00 00       	mov    $0xc,%eax
 2ed:	cd 40                	int    $0x40
 2ef:	c3                   	ret    

000002f0 <sleep>:
SYSCALL(sleep)
 2f0:	b8 0d 00 00 00       	mov    $0xd,%eax
 2f5:	cd 40                	int    $0x40
 2f7:	c3                   	ret    

000002f8 <uptime>:
SYSCALL(uptime)
 2f8:	b8 0e 00 00 00       	mov    $0xe,%eax
 2fd:	cd 40                	int    $0x40
 2ff:	c3                   	ret    

00000300 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	57                   	push   %edi
 304:	56                   	push   %esi
 305:	53                   	push   %ebx
 306:	83 ec 3c             	sub    $0x3c,%esp
 309:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 30c:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 30e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 312:	74 77                	je     38b <printint+0x8b>
 314:	85 d2                	test   %edx,%edx
 316:	79 73                	jns    38b <printint+0x8b>
    neg = 1;
    x = -xx;
 318:	f7 db                	neg    %ebx
    neg = 1;
 31a:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 321:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 326:	89 f7                	mov    %esi,%edi
 328:	83 c6 01             	add    $0x1,%esi
 32b:	89 d8                	mov    %ebx,%eax
 32d:	ba 00 00 00 00       	mov    $0x0,%edx
 332:	f7 f1                	div    %ecx
 334:	0f b6 92 e0 06 00 00 	movzbl 0x6e0(%edx),%edx
 33b:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 33f:	89 da                	mov    %ebx,%edx
 341:	89 c3                	mov    %eax,%ebx
 343:	39 d1                	cmp    %edx,%ecx
 345:	76 df                	jbe    326 <printint+0x26>
  if(neg)
 347:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 34b:	74 08                	je     355 <printint+0x55>
    buf[i++] = '-';
 34d:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 352:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 355:	85 f6                	test   %esi,%esi
 357:	7e 2a                	jle    383 <printint+0x83>
 359:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 35d:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 360:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 363:	0f b6 03             	movzbl (%ebx),%eax
 366:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 369:	83 ec 04             	sub    $0x4,%esp
 36c:	6a 01                	push   $0x1
 36e:	56                   	push   %esi
 36f:	ff 75 c4             	pushl  -0x3c(%ebp)
 372:	e8 09 ff ff ff       	call   280 <write>
  while(--i >= 0)
 377:	89 d8                	mov    %ebx,%eax
 379:	83 eb 01             	sub    $0x1,%ebx
 37c:	83 c4 10             	add    $0x10,%esp
 37f:	39 f8                	cmp    %edi,%eax
 381:	75 e0                	jne    363 <printint+0x63>
}
 383:	8d 65 f4             	lea    -0xc(%ebp),%esp
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5f                   	pop    %edi
 389:	5d                   	pop    %ebp
 38a:	c3                   	ret    
  neg = 0;
 38b:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 392:	eb 8d                	jmp    321 <printint+0x21>

00000394 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 394:	f3 0f 1e fb          	endbr32 
 398:	55                   	push   %ebp
 399:	89 e5                	mov    %esp,%ebp
 39b:	57                   	push   %edi
 39c:	56                   	push   %esi
 39d:	53                   	push   %ebx
 39e:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 3a1:	8b 75 0c             	mov    0xc(%ebp),%esi
 3a4:	0f b6 1e             	movzbl (%esi),%ebx
 3a7:	84 db                	test   %bl,%bl
 3a9:	0f 84 ab 01 00 00    	je     55a <printf+0x1c6>
 3af:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 3b2:	8d 45 10             	lea    0x10(%ebp),%eax
 3b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 3b8:	bf 00 00 00 00       	mov    $0x0,%edi
 3bd:	eb 2d                	jmp    3ec <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3bf:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 3c2:	83 ec 04             	sub    $0x4,%esp
 3c5:	6a 01                	push   $0x1
 3c7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3ca:	50                   	push   %eax
 3cb:	ff 75 08             	pushl  0x8(%ebp)
 3ce:	e8 ad fe ff ff       	call   280 <write>
        putc(fd, c);
 3d3:	83 c4 10             	add    $0x10,%esp
 3d6:	eb 05                	jmp    3dd <printf+0x49>
      }
    } else if(state == '%'){
 3d8:	83 ff 25             	cmp    $0x25,%edi
 3db:	74 22                	je     3ff <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 3dd:	83 c6 01             	add    $0x1,%esi
 3e0:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 3e4:	84 db                	test   %bl,%bl
 3e6:	0f 84 6e 01 00 00    	je     55a <printf+0x1c6>
    c = fmt[i] & 0xff;
 3ec:	0f be d3             	movsbl %bl,%edx
 3ef:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3f2:	85 ff                	test   %edi,%edi
 3f4:	75 e2                	jne    3d8 <printf+0x44>
      if(c == '%'){
 3f6:	83 f8 25             	cmp    $0x25,%eax
 3f9:	75 c4                	jne    3bf <printf+0x2b>
        state = '%';
 3fb:	89 c7                	mov    %eax,%edi
 3fd:	eb de                	jmp    3dd <printf+0x49>
      if(c == 'd'){
 3ff:	83 f8 64             	cmp    $0x64,%eax
 402:	74 59                	je     45d <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 404:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 40a:	83 fa 70             	cmp    $0x70,%edx
 40d:	74 7a                	je     489 <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 40f:	83 f8 73             	cmp    $0x73,%eax
 412:	0f 84 9d 00 00 00    	je     4b5 <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 418:	83 f8 63             	cmp    $0x63,%eax
 41b:	0f 84 ec 00 00 00    	je     50d <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 421:	83 f8 25             	cmp    $0x25,%eax
 424:	0f 84 0f 01 00 00    	je     539 <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 42a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 42e:	83 ec 04             	sub    $0x4,%esp
 431:	6a 01                	push   $0x1
 433:	8d 45 e7             	lea    -0x19(%ebp),%eax
 436:	50                   	push   %eax
 437:	ff 75 08             	pushl  0x8(%ebp)
 43a:	e8 41 fe ff ff       	call   280 <write>
        putc(fd, c);
 43f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 442:	83 c4 0c             	add    $0xc,%esp
 445:	6a 01                	push   $0x1
 447:	8d 45 e7             	lea    -0x19(%ebp),%eax
 44a:	50                   	push   %eax
 44b:	ff 75 08             	pushl  0x8(%ebp)
 44e:	e8 2d fe ff ff       	call   280 <write>
        putc(fd, c);
 453:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 456:	bf 00 00 00 00       	mov    $0x0,%edi
 45b:	eb 80                	jmp    3dd <printf+0x49>
        printint(fd, *ap, 10, 1);
 45d:	83 ec 0c             	sub    $0xc,%esp
 460:	6a 01                	push   $0x1
 462:	b9 0a 00 00 00       	mov    $0xa,%ecx
 467:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 46a:	8b 17                	mov    (%edi),%edx
 46c:	8b 45 08             	mov    0x8(%ebp),%eax
 46f:	e8 8c fe ff ff       	call   300 <printint>
        ap++;
 474:	89 f8                	mov    %edi,%eax
 476:	83 c0 04             	add    $0x4,%eax
 479:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 47c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 47f:	bf 00 00 00 00       	mov    $0x0,%edi
 484:	e9 54 ff ff ff       	jmp    3dd <printf+0x49>
        printint(fd, *ap, 16, 0);
 489:	83 ec 0c             	sub    $0xc,%esp
 48c:	6a 00                	push   $0x0
 48e:	b9 10 00 00 00       	mov    $0x10,%ecx
 493:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 496:	8b 17                	mov    (%edi),%edx
 498:	8b 45 08             	mov    0x8(%ebp),%eax
 49b:	e8 60 fe ff ff       	call   300 <printint>
        ap++;
 4a0:	89 f8                	mov    %edi,%eax
 4a2:	83 c0 04             	add    $0x4,%eax
 4a5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 4a8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4ab:	bf 00 00 00 00       	mov    $0x0,%edi
 4b0:	e9 28 ff ff ff       	jmp    3dd <printf+0x49>
        s = (char*)*ap;
 4b5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 4b8:	8b 01                	mov    (%ecx),%eax
        ap++;
 4ba:	83 c1 04             	add    $0x4,%ecx
 4bd:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 4c0:	85 c0                	test   %eax,%eax
 4c2:	74 13                	je     4d7 <printf+0x143>
        s = (char*)*ap;
 4c4:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 4c6:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 4c9:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 4ce:	84 c0                	test   %al,%al
 4d0:	75 0f                	jne    4e1 <printf+0x14d>
 4d2:	e9 06 ff ff ff       	jmp    3dd <printf+0x49>
          s = "(null)";
 4d7:	bb d9 06 00 00       	mov    $0x6d9,%ebx
        while(*s != 0){
 4dc:	b8 28 00 00 00       	mov    $0x28,%eax
 4e1:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 4e4:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4e7:	83 ec 04             	sub    $0x4,%esp
 4ea:	6a 01                	push   $0x1
 4ec:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4ef:	50                   	push   %eax
 4f0:	57                   	push   %edi
 4f1:	e8 8a fd ff ff       	call   280 <write>
          s++;
 4f6:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4f9:	0f b6 03             	movzbl (%ebx),%eax
 4fc:	83 c4 10             	add    $0x10,%esp
 4ff:	84 c0                	test   %al,%al
 501:	75 e1                	jne    4e4 <printf+0x150>
      state = 0;
 503:	bf 00 00 00 00       	mov    $0x0,%edi
 508:	e9 d0 fe ff ff       	jmp    3dd <printf+0x49>
        putc(fd, *ap);
 50d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 510:	8b 07                	mov    (%edi),%eax
 512:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 515:	83 ec 04             	sub    $0x4,%esp
 518:	6a 01                	push   $0x1
 51a:	8d 45 e7             	lea    -0x19(%ebp),%eax
 51d:	50                   	push   %eax
 51e:	ff 75 08             	pushl  0x8(%ebp)
 521:	e8 5a fd ff ff       	call   280 <write>
        ap++;
 526:	83 c7 04             	add    $0x4,%edi
 529:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 52c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 52f:	bf 00 00 00 00       	mov    $0x0,%edi
 534:	e9 a4 fe ff ff       	jmp    3dd <printf+0x49>
        putc(fd, c);
 539:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 53c:	83 ec 04             	sub    $0x4,%esp
 53f:	6a 01                	push   $0x1
 541:	8d 45 e7             	lea    -0x19(%ebp),%eax
 544:	50                   	push   %eax
 545:	ff 75 08             	pushl  0x8(%ebp)
 548:	e8 33 fd ff ff       	call   280 <write>
 54d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 550:	bf 00 00 00 00       	mov    $0x0,%edi
 555:	e9 83 fe ff ff       	jmp    3dd <printf+0x49>
    }
  }
}
 55a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 55d:	5b                   	pop    %ebx
 55e:	5e                   	pop    %esi
 55f:	5f                   	pop    %edi
 560:	5d                   	pop    %ebp
 561:	c3                   	ret    

00000562 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 562:	f3 0f 1e fb          	endbr32 
 566:	55                   	push   %ebp
 567:	89 e5                	mov    %esp,%ebp
 569:	57                   	push   %edi
 56a:	56                   	push   %esi
 56b:	53                   	push   %ebx
 56c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 56f:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 572:	a1 54 09 00 00       	mov    0x954,%eax
 577:	eb 0c                	jmp    585 <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 579:	8b 10                	mov    (%eax),%edx
 57b:	39 c2                	cmp    %eax,%edx
 57d:	77 04                	ja     583 <free+0x21>
 57f:	39 ca                	cmp    %ecx,%edx
 581:	77 10                	ja     593 <free+0x31>
{
 583:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 585:	39 c8                	cmp    %ecx,%eax
 587:	73 f0                	jae    579 <free+0x17>
 589:	8b 10                	mov    (%eax),%edx
 58b:	39 ca                	cmp    %ecx,%edx
 58d:	77 04                	ja     593 <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 58f:	39 c2                	cmp    %eax,%edx
 591:	77 f0                	ja     583 <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 593:	8b 73 fc             	mov    -0x4(%ebx),%esi
 596:	8b 10                	mov    (%eax),%edx
 598:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 59b:	39 fa                	cmp    %edi,%edx
 59d:	74 19                	je     5b8 <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 59f:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 5a2:	8b 50 04             	mov    0x4(%eax),%edx
 5a5:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 5a8:	39 f1                	cmp    %esi,%ecx
 5aa:	74 1b                	je     5c7 <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 5ac:	89 08                	mov    %ecx,(%eax)
  freep = p;
 5ae:	a3 54 09 00 00       	mov    %eax,0x954
}
 5b3:	5b                   	pop    %ebx
 5b4:	5e                   	pop    %esi
 5b5:	5f                   	pop    %edi
 5b6:	5d                   	pop    %ebp
 5b7:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5b8:	03 72 04             	add    0x4(%edx),%esi
 5bb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5be:	8b 10                	mov    (%eax),%edx
 5c0:	8b 12                	mov    (%edx),%edx
 5c2:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5c5:	eb db                	jmp    5a2 <free+0x40>
    p->s.size += bp->s.size;
 5c7:	03 53 fc             	add    -0x4(%ebx),%edx
 5ca:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5cd:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5d0:	89 10                	mov    %edx,(%eax)
 5d2:	eb da                	jmp    5ae <free+0x4c>

000005d4 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5d4:	f3 0f 1e fb          	endbr32 
 5d8:	55                   	push   %ebp
 5d9:	89 e5                	mov    %esp,%ebp
 5db:	57                   	push   %edi
 5dc:	56                   	push   %esi
 5dd:	53                   	push   %ebx
 5de:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5e1:	8b 45 08             	mov    0x8(%ebp),%eax
 5e4:	8d 58 07             	lea    0x7(%eax),%ebx
 5e7:	c1 eb 03             	shr    $0x3,%ebx
 5ea:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5ed:	8b 15 54 09 00 00    	mov    0x954,%edx
 5f3:	85 d2                	test   %edx,%edx
 5f5:	74 20                	je     617 <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5f7:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5f9:	8b 48 04             	mov    0x4(%eax),%ecx
 5fc:	39 cb                	cmp    %ecx,%ebx
 5fe:	76 3c                	jbe    63c <malloc+0x68>
 600:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 606:	be 00 10 00 00       	mov    $0x1000,%esi
 60b:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 60e:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 615:	eb 72                	jmp    689 <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 617:	c7 05 54 09 00 00 58 	movl   $0x958,0x954
 61e:	09 00 00 
 621:	c7 05 58 09 00 00 58 	movl   $0x958,0x958
 628:	09 00 00 
    base.s.size = 0;
 62b:	c7 05 5c 09 00 00 00 	movl   $0x0,0x95c
 632:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 635:	b8 58 09 00 00       	mov    $0x958,%eax
 63a:	eb c4                	jmp    600 <malloc+0x2c>
      if(p->s.size == nunits)
 63c:	39 cb                	cmp    %ecx,%ebx
 63e:	74 1e                	je     65e <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 640:	29 d9                	sub    %ebx,%ecx
 642:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 645:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 648:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 64b:	89 15 54 09 00 00    	mov    %edx,0x954
      return (void*)(p + 1);
 651:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 654:	89 d0                	mov    %edx,%eax
 656:	8d 65 f4             	lea    -0xc(%ebp),%esp
 659:	5b                   	pop    %ebx
 65a:	5e                   	pop    %esi
 65b:	5f                   	pop    %edi
 65c:	5d                   	pop    %ebp
 65d:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 65e:	8b 08                	mov    (%eax),%ecx
 660:	89 0a                	mov    %ecx,(%edx)
 662:	eb e7                	jmp    64b <malloc+0x77>
  hp->s.size = nu;
 664:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 667:	83 ec 0c             	sub    $0xc,%esp
 66a:	83 c0 08             	add    $0x8,%eax
 66d:	50                   	push   %eax
 66e:	e8 ef fe ff ff       	call   562 <free>
  return freep;
 673:	8b 15 54 09 00 00    	mov    0x954,%edx
      if((p = morecore(nunits)) == 0)
 679:	83 c4 10             	add    $0x10,%esp
 67c:	85 d2                	test   %edx,%edx
 67e:	74 d4                	je     654 <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 680:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 682:	8b 48 04             	mov    0x4(%eax),%ecx
 685:	39 d9                	cmp    %ebx,%ecx
 687:	73 b3                	jae    63c <malloc+0x68>
    if(p == freep)
 689:	89 c2                	mov    %eax,%edx
 68b:	39 05 54 09 00 00    	cmp    %eax,0x954
 691:	75 ed                	jne    680 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 693:	83 ec 0c             	sub    $0xc,%esp
 696:	57                   	push   %edi
 697:	e8 4c fc ff ff       	call   2e8 <sbrk>
  if(p == (char*)-1)
 69c:	83 c4 10             	add    $0x10,%esp
 69f:	83 f8 ff             	cmp    $0xffffffff,%eax
 6a2:	75 c0                	jne    664 <malloc+0x90>
        return 0;
 6a4:	ba 00 00 00 00       	mov    $0x0,%edx
 6a9:	eb a9                	jmp    654 <malloc+0x80>
