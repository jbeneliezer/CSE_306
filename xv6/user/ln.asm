
_ln:     file format elf32-i386


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
  11:	53                   	push   %ebx
  12:	51                   	push   %ecx
  13:	8b 59 04             	mov    0x4(%ecx),%ebx
  if(argc != 3){
  16:	83 39 03             	cmpl   $0x3,(%ecx)
  19:	74 14                	je     2f <main+0x2f>
    printf(2, "Usage: ln old new\n");
  1b:	83 ec 08             	sub    $0x8,%esp
  1e:	68 94 06 00 00       	push   $0x694
  23:	6a 02                	push   $0x2
  25:	e8 50 03 00 00       	call   37a <printf>
    exit();
  2a:	e8 17 02 00 00       	call   246 <exit>
  }
  if(link(argv[1], argv[2]) < 0)
  2f:	83 ec 08             	sub    $0x8,%esp
  32:	ff 73 08             	pushl  0x8(%ebx)
  35:	ff 73 04             	pushl  0x4(%ebx)
  38:	e8 69 02 00 00       	call   2a6 <link>
  3d:	83 c4 10             	add    $0x10,%esp
  40:	85 c0                	test   %eax,%eax
  42:	78 05                	js     49 <main+0x49>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  exit();
  44:	e8 fd 01 00 00       	call   246 <exit>
    printf(2, "link %s %s: failed\n", argv[1], argv[2]);
  49:	ff 73 08             	pushl  0x8(%ebx)
  4c:	ff 73 04             	pushl  0x4(%ebx)
  4f:	68 a7 06 00 00       	push   $0x6a7
  54:	6a 02                	push   $0x2
  56:	e8 1f 03 00 00       	call   37a <printf>
  5b:	83 c4 10             	add    $0x10,%esp
  5e:	eb e4                	jmp    44 <main+0x44>

00000060 <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  60:	f3 0f 1e fb          	endbr32 
  64:	55                   	push   %ebp
  65:	89 e5                	mov    %esp,%ebp
  67:	53                   	push   %ebx
  68:	8b 4d 08             	mov    0x8(%ebp),%ecx
  6b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6e:	b8 00 00 00 00       	mov    $0x0,%eax
  73:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  77:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  7a:	83 c0 01             	add    $0x1,%eax
  7d:	84 d2                	test   %dl,%dl
  7f:	75 f2                	jne    73 <strcpy+0x13>
    ;
  return os;
}
  81:	89 c8                	mov    %ecx,%eax
  83:	5b                   	pop    %ebx
  84:	5d                   	pop    %ebp
  85:	c3                   	ret    

00000086 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  86:	f3 0f 1e fb          	endbr32 
  8a:	55                   	push   %ebp
  8b:	89 e5                	mov    %esp,%ebp
  8d:	8b 4d 08             	mov    0x8(%ebp),%ecx
  90:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  93:	0f b6 01             	movzbl (%ecx),%eax
  96:	84 c0                	test   %al,%al
  98:	74 11                	je     ab <strcmp+0x25>
  9a:	38 02                	cmp    %al,(%edx)
  9c:	75 0d                	jne    ab <strcmp+0x25>
    p++, q++;
  9e:	83 c1 01             	add    $0x1,%ecx
  a1:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  a4:	0f b6 01             	movzbl (%ecx),%eax
  a7:	84 c0                	test   %al,%al
  a9:	75 ef                	jne    9a <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  ab:	0f b6 c0             	movzbl %al,%eax
  ae:	0f b6 12             	movzbl (%edx),%edx
  b1:	29 d0                	sub    %edx,%eax
}
  b3:	5d                   	pop    %ebp
  b4:	c3                   	ret    

000000b5 <strlen>:

uint
strlen(char *s)
{
  b5:	f3 0f 1e fb          	endbr32 
  b9:	55                   	push   %ebp
  ba:	89 e5                	mov    %esp,%ebp
  bc:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  bf:	80 3a 00             	cmpb   $0x0,(%edx)
  c2:	74 14                	je     d8 <strlen+0x23>
  c4:	b8 00 00 00 00       	mov    $0x0,%eax
  c9:	83 c0 01             	add    $0x1,%eax
  cc:	89 c1                	mov    %eax,%ecx
  ce:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  d2:	75 f5                	jne    c9 <strlen+0x14>
    ;
  return n;
}
  d4:	89 c8                	mov    %ecx,%eax
  d6:	5d                   	pop    %ebp
  d7:	c3                   	ret    
  for(n = 0; s[n]; n++)
  d8:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
  dd:	eb f5                	jmp    d4 <strlen+0x1f>

000000df <memset>:

void*
memset(void *dst, int c, uint n)
{
  df:	f3 0f 1e fb          	endbr32 
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	57                   	push   %edi
  e7:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  ea:	89 d7                	mov    %edx,%edi
  ec:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ef:	8b 45 0c             	mov    0xc(%ebp),%eax
  f2:	fc                   	cld    
  f3:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f5:	89 d0                	mov    %edx,%eax
  f7:	5f                   	pop    %edi
  f8:	5d                   	pop    %ebp
  f9:	c3                   	ret    

000000fa <strchr>:

char*
strchr(const char *s, char c)
{
  fa:	f3 0f 1e fb          	endbr32 
  fe:	55                   	push   %ebp
  ff:	89 e5                	mov    %esp,%ebp
 101:	8b 45 08             	mov    0x8(%ebp),%eax
 104:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 108:	0f b6 10             	movzbl (%eax),%edx
 10b:	84 d2                	test   %dl,%dl
 10d:	74 15                	je     124 <strchr+0x2a>
    if(*s == c)
 10f:	38 d1                	cmp    %dl,%cl
 111:	74 0f                	je     122 <strchr+0x28>
  for(; *s; s++)
 113:	83 c0 01             	add    $0x1,%eax
 116:	0f b6 10             	movzbl (%eax),%edx
 119:	84 d2                	test   %dl,%dl
 11b:	75 f2                	jne    10f <strchr+0x15>
      return (char*)s;
  return 0;
 11d:	b8 00 00 00 00       	mov    $0x0,%eax
}
 122:	5d                   	pop    %ebp
 123:	c3                   	ret    
  return 0;
 124:	b8 00 00 00 00       	mov    $0x0,%eax
 129:	eb f7                	jmp    122 <strchr+0x28>

0000012b <gets>:

char*
gets(char *buf, int max)
{
 12b:	f3 0f 1e fb          	endbr32 
 12f:	55                   	push   %ebp
 130:	89 e5                	mov    %esp,%ebp
 132:	57                   	push   %edi
 133:	56                   	push   %esi
 134:	53                   	push   %ebx
 135:	83 ec 2c             	sub    $0x2c,%esp
 138:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 13b:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 140:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 143:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 146:	83 c3 01             	add    $0x1,%ebx
 149:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 14c:	7d 27                	jge    175 <gets+0x4a>
    cc = read(0, &c, 1);
 14e:	83 ec 04             	sub    $0x4,%esp
 151:	6a 01                	push   $0x1
 153:	57                   	push   %edi
 154:	6a 00                	push   $0x0
 156:	e8 03 01 00 00       	call   25e <read>
    if(cc < 1)
 15b:	83 c4 10             	add    $0x10,%esp
 15e:	85 c0                	test   %eax,%eax
 160:	7e 13                	jle    175 <gets+0x4a>
      break;
    buf[i++] = c;
 162:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 166:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 16a:	3c 0a                	cmp    $0xa,%al
 16c:	74 04                	je     172 <gets+0x47>
 16e:	3c 0d                	cmp    $0xd,%al
 170:	75 d1                	jne    143 <gets+0x18>
  for(i=0; i+1 < max; ){
 172:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 175:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 178:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 17c:	89 f0                	mov    %esi,%eax
 17e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 181:	5b                   	pop    %ebx
 182:	5e                   	pop    %esi
 183:	5f                   	pop    %edi
 184:	5d                   	pop    %ebp
 185:	c3                   	ret    

00000186 <stat>:

int
stat(char *n, struct stat *st)
{
 186:	f3 0f 1e fb          	endbr32 
 18a:	55                   	push   %ebp
 18b:	89 e5                	mov    %esp,%ebp
 18d:	56                   	push   %esi
 18e:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18f:	83 ec 08             	sub    $0x8,%esp
 192:	6a 00                	push   $0x0
 194:	ff 75 08             	pushl  0x8(%ebp)
 197:	e8 ea 00 00 00       	call   286 <open>
  if(fd < 0)
 19c:	83 c4 10             	add    $0x10,%esp
 19f:	85 c0                	test   %eax,%eax
 1a1:	78 24                	js     1c7 <stat+0x41>
 1a3:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a5:	83 ec 08             	sub    $0x8,%esp
 1a8:	ff 75 0c             	pushl  0xc(%ebp)
 1ab:	50                   	push   %eax
 1ac:	e8 ed 00 00 00       	call   29e <fstat>
 1b1:	89 c6                	mov    %eax,%esi
  close(fd);
 1b3:	89 1c 24             	mov    %ebx,(%esp)
 1b6:	e8 b3 00 00 00       	call   26e <close>
  return r;
 1bb:	83 c4 10             	add    $0x10,%esp
}
 1be:	89 f0                	mov    %esi,%eax
 1c0:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1c3:	5b                   	pop    %ebx
 1c4:	5e                   	pop    %esi
 1c5:	5d                   	pop    %ebp
 1c6:	c3                   	ret    
    return -1;
 1c7:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1cc:	eb f0                	jmp    1be <stat+0x38>

000001ce <atoi>:

int
atoi(const char *s)
{
 1ce:	f3 0f 1e fb          	endbr32 
 1d2:	55                   	push   %ebp
 1d3:	89 e5                	mov    %esp,%ebp
 1d5:	53                   	push   %ebx
 1d6:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d9:	0f b6 02             	movzbl (%edx),%eax
 1dc:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1df:	80 f9 09             	cmp    $0x9,%cl
 1e2:	77 22                	ja     206 <atoi+0x38>
  n = 0;
 1e4:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 1e9:	83 c2 01             	add    $0x1,%edx
 1ec:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 1ef:	0f be c0             	movsbl %al,%eax
 1f2:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 1f6:	0f b6 02             	movzbl (%edx),%eax
 1f9:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1fc:	80 fb 09             	cmp    $0x9,%bl
 1ff:	76 e8                	jbe    1e9 <atoi+0x1b>
  return n;
}
 201:	89 c8                	mov    %ecx,%eax
 203:	5b                   	pop    %ebx
 204:	5d                   	pop    %ebp
 205:	c3                   	ret    
  n = 0;
 206:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 20b:	eb f4                	jmp    201 <atoi+0x33>

0000020d <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 20d:	f3 0f 1e fb          	endbr32 
 211:	55                   	push   %ebp
 212:	89 e5                	mov    %esp,%ebp
 214:	56                   	push   %esi
 215:	53                   	push   %ebx
 216:	8b 75 08             	mov    0x8(%ebp),%esi
 219:	8b 55 0c             	mov    0xc(%ebp),%edx
 21c:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 21f:	85 db                	test   %ebx,%ebx
 221:	7e 15                	jle    238 <memmove+0x2b>
 223:	01 f3                	add    %esi,%ebx
  dst = vdst;
 225:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 227:	83 c2 01             	add    $0x1,%edx
 22a:	83 c0 01             	add    $0x1,%eax
 22d:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 231:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 234:	39 c3                	cmp    %eax,%ebx
 236:	75 ef                	jne    227 <memmove+0x1a>
  return vdst;
}
 238:	89 f0                	mov    %esi,%eax
 23a:	5b                   	pop    %ebx
 23b:	5e                   	pop    %esi
 23c:	5d                   	pop    %ebp
 23d:	c3                   	ret    

0000023e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 23e:	b8 01 00 00 00       	mov    $0x1,%eax
 243:	cd 40                	int    $0x40
 245:	c3                   	ret    

00000246 <exit>:
SYSCALL(exit)
 246:	b8 02 00 00 00       	mov    $0x2,%eax
 24b:	cd 40                	int    $0x40
 24d:	c3                   	ret    

0000024e <wait>:
SYSCALL(wait)
 24e:	b8 03 00 00 00       	mov    $0x3,%eax
 253:	cd 40                	int    $0x40
 255:	c3                   	ret    

00000256 <pipe>:
SYSCALL(pipe)
 256:	b8 04 00 00 00       	mov    $0x4,%eax
 25b:	cd 40                	int    $0x40
 25d:	c3                   	ret    

0000025e <read>:
SYSCALL(read)
 25e:	b8 05 00 00 00       	mov    $0x5,%eax
 263:	cd 40                	int    $0x40
 265:	c3                   	ret    

00000266 <write>:
SYSCALL(write)
 266:	b8 10 00 00 00       	mov    $0x10,%eax
 26b:	cd 40                	int    $0x40
 26d:	c3                   	ret    

0000026e <close>:
SYSCALL(close)
 26e:	b8 15 00 00 00       	mov    $0x15,%eax
 273:	cd 40                	int    $0x40
 275:	c3                   	ret    

00000276 <kill>:
SYSCALL(kill)
 276:	b8 06 00 00 00       	mov    $0x6,%eax
 27b:	cd 40                	int    $0x40
 27d:	c3                   	ret    

0000027e <exec>:
SYSCALL(exec)
 27e:	b8 07 00 00 00       	mov    $0x7,%eax
 283:	cd 40                	int    $0x40
 285:	c3                   	ret    

00000286 <open>:
SYSCALL(open)
 286:	b8 0f 00 00 00       	mov    $0xf,%eax
 28b:	cd 40                	int    $0x40
 28d:	c3                   	ret    

0000028e <mknod>:
SYSCALL(mknod)
 28e:	b8 11 00 00 00       	mov    $0x11,%eax
 293:	cd 40                	int    $0x40
 295:	c3                   	ret    

00000296 <unlink>:
SYSCALL(unlink)
 296:	b8 12 00 00 00       	mov    $0x12,%eax
 29b:	cd 40                	int    $0x40
 29d:	c3                   	ret    

0000029e <fstat>:
SYSCALL(fstat)
 29e:	b8 08 00 00 00       	mov    $0x8,%eax
 2a3:	cd 40                	int    $0x40
 2a5:	c3                   	ret    

000002a6 <link>:
SYSCALL(link)
 2a6:	b8 13 00 00 00       	mov    $0x13,%eax
 2ab:	cd 40                	int    $0x40
 2ad:	c3                   	ret    

000002ae <mkdir>:
SYSCALL(mkdir)
 2ae:	b8 14 00 00 00       	mov    $0x14,%eax
 2b3:	cd 40                	int    $0x40
 2b5:	c3                   	ret    

000002b6 <chdir>:
SYSCALL(chdir)
 2b6:	b8 09 00 00 00       	mov    $0x9,%eax
 2bb:	cd 40                	int    $0x40
 2bd:	c3                   	ret    

000002be <dup>:
SYSCALL(dup)
 2be:	b8 0a 00 00 00       	mov    $0xa,%eax
 2c3:	cd 40                	int    $0x40
 2c5:	c3                   	ret    

000002c6 <getpid>:
SYSCALL(getpid)
 2c6:	b8 0b 00 00 00       	mov    $0xb,%eax
 2cb:	cd 40                	int    $0x40
 2cd:	c3                   	ret    

000002ce <sbrk>:
SYSCALL(sbrk)
 2ce:	b8 0c 00 00 00       	mov    $0xc,%eax
 2d3:	cd 40                	int    $0x40
 2d5:	c3                   	ret    

000002d6 <sleep>:
SYSCALL(sleep)
 2d6:	b8 0d 00 00 00       	mov    $0xd,%eax
 2db:	cd 40                	int    $0x40
 2dd:	c3                   	ret    

000002de <uptime>:
SYSCALL(uptime)
 2de:	b8 0e 00 00 00       	mov    $0xe,%eax
 2e3:	cd 40                	int    $0x40
 2e5:	c3                   	ret    

000002e6 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2e6:	55                   	push   %ebp
 2e7:	89 e5                	mov    %esp,%ebp
 2e9:	57                   	push   %edi
 2ea:	56                   	push   %esi
 2eb:	53                   	push   %ebx
 2ec:	83 ec 3c             	sub    $0x3c,%esp
 2ef:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 2f2:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2f4:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2f8:	74 77                	je     371 <printint+0x8b>
 2fa:	85 d2                	test   %edx,%edx
 2fc:	79 73                	jns    371 <printint+0x8b>
    neg = 1;
    x = -xx;
 2fe:	f7 db                	neg    %ebx
    neg = 1;
 300:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 307:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 30c:	89 f7                	mov    %esi,%edi
 30e:	83 c6 01             	add    $0x1,%esi
 311:	89 d8                	mov    %ebx,%eax
 313:	ba 00 00 00 00       	mov    $0x0,%edx
 318:	f7 f1                	div    %ecx
 31a:	0f b6 92 c4 06 00 00 	movzbl 0x6c4(%edx),%edx
 321:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 325:	89 da                	mov    %ebx,%edx
 327:	89 c3                	mov    %eax,%ebx
 329:	39 d1                	cmp    %edx,%ecx
 32b:	76 df                	jbe    30c <printint+0x26>
  if(neg)
 32d:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 331:	74 08                	je     33b <printint+0x55>
    buf[i++] = '-';
 333:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 338:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 33b:	85 f6                	test   %esi,%esi
 33d:	7e 2a                	jle    369 <printint+0x83>
 33f:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 343:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 346:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 349:	0f b6 03             	movzbl (%ebx),%eax
 34c:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 34f:	83 ec 04             	sub    $0x4,%esp
 352:	6a 01                	push   $0x1
 354:	56                   	push   %esi
 355:	ff 75 c4             	pushl  -0x3c(%ebp)
 358:	e8 09 ff ff ff       	call   266 <write>
  while(--i >= 0)
 35d:	89 d8                	mov    %ebx,%eax
 35f:	83 eb 01             	sub    $0x1,%ebx
 362:	83 c4 10             	add    $0x10,%esp
 365:	39 f8                	cmp    %edi,%eax
 367:	75 e0                	jne    349 <printint+0x63>
}
 369:	8d 65 f4             	lea    -0xc(%ebp),%esp
 36c:	5b                   	pop    %ebx
 36d:	5e                   	pop    %esi
 36e:	5f                   	pop    %edi
 36f:	5d                   	pop    %ebp
 370:	c3                   	ret    
  neg = 0;
 371:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 378:	eb 8d                	jmp    307 <printint+0x21>

0000037a <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 37a:	f3 0f 1e fb          	endbr32 
 37e:	55                   	push   %ebp
 37f:	89 e5                	mov    %esp,%ebp
 381:	57                   	push   %edi
 382:	56                   	push   %esi
 383:	53                   	push   %ebx
 384:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 387:	8b 75 0c             	mov    0xc(%ebp),%esi
 38a:	0f b6 1e             	movzbl (%esi),%ebx
 38d:	84 db                	test   %bl,%bl
 38f:	0f 84 ab 01 00 00    	je     540 <printf+0x1c6>
 395:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 398:	8d 45 10             	lea    0x10(%ebp),%eax
 39b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 39e:	bf 00 00 00 00       	mov    $0x0,%edi
 3a3:	eb 2d                	jmp    3d2 <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3a5:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 3a8:	83 ec 04             	sub    $0x4,%esp
 3ab:	6a 01                	push   $0x1
 3ad:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3b0:	50                   	push   %eax
 3b1:	ff 75 08             	pushl  0x8(%ebp)
 3b4:	e8 ad fe ff ff       	call   266 <write>
        putc(fd, c);
 3b9:	83 c4 10             	add    $0x10,%esp
 3bc:	eb 05                	jmp    3c3 <printf+0x49>
      }
    } else if(state == '%'){
 3be:	83 ff 25             	cmp    $0x25,%edi
 3c1:	74 22                	je     3e5 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 3c3:	83 c6 01             	add    $0x1,%esi
 3c6:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 3ca:	84 db                	test   %bl,%bl
 3cc:	0f 84 6e 01 00 00    	je     540 <printf+0x1c6>
    c = fmt[i] & 0xff;
 3d2:	0f be d3             	movsbl %bl,%edx
 3d5:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3d8:	85 ff                	test   %edi,%edi
 3da:	75 e2                	jne    3be <printf+0x44>
      if(c == '%'){
 3dc:	83 f8 25             	cmp    $0x25,%eax
 3df:	75 c4                	jne    3a5 <printf+0x2b>
        state = '%';
 3e1:	89 c7                	mov    %eax,%edi
 3e3:	eb de                	jmp    3c3 <printf+0x49>
      if(c == 'd'){
 3e5:	83 f8 64             	cmp    $0x64,%eax
 3e8:	74 59                	je     443 <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3ea:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3f0:	83 fa 70             	cmp    $0x70,%edx
 3f3:	74 7a                	je     46f <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3f5:	83 f8 73             	cmp    $0x73,%eax
 3f8:	0f 84 9d 00 00 00    	je     49b <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3fe:	83 f8 63             	cmp    $0x63,%eax
 401:	0f 84 ec 00 00 00    	je     4f3 <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 407:	83 f8 25             	cmp    $0x25,%eax
 40a:	0f 84 0f 01 00 00    	je     51f <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 410:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 414:	83 ec 04             	sub    $0x4,%esp
 417:	6a 01                	push   $0x1
 419:	8d 45 e7             	lea    -0x19(%ebp),%eax
 41c:	50                   	push   %eax
 41d:	ff 75 08             	pushl  0x8(%ebp)
 420:	e8 41 fe ff ff       	call   266 <write>
        putc(fd, c);
 425:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 428:	83 c4 0c             	add    $0xc,%esp
 42b:	6a 01                	push   $0x1
 42d:	8d 45 e7             	lea    -0x19(%ebp),%eax
 430:	50                   	push   %eax
 431:	ff 75 08             	pushl  0x8(%ebp)
 434:	e8 2d fe ff ff       	call   266 <write>
        putc(fd, c);
 439:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 43c:	bf 00 00 00 00       	mov    $0x0,%edi
 441:	eb 80                	jmp    3c3 <printf+0x49>
        printint(fd, *ap, 10, 1);
 443:	83 ec 0c             	sub    $0xc,%esp
 446:	6a 01                	push   $0x1
 448:	b9 0a 00 00 00       	mov    $0xa,%ecx
 44d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 450:	8b 17                	mov    (%edi),%edx
 452:	8b 45 08             	mov    0x8(%ebp),%eax
 455:	e8 8c fe ff ff       	call   2e6 <printint>
        ap++;
 45a:	89 f8                	mov    %edi,%eax
 45c:	83 c0 04             	add    $0x4,%eax
 45f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 462:	83 c4 10             	add    $0x10,%esp
      state = 0;
 465:	bf 00 00 00 00       	mov    $0x0,%edi
 46a:	e9 54 ff ff ff       	jmp    3c3 <printf+0x49>
        printint(fd, *ap, 16, 0);
 46f:	83 ec 0c             	sub    $0xc,%esp
 472:	6a 00                	push   $0x0
 474:	b9 10 00 00 00       	mov    $0x10,%ecx
 479:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 47c:	8b 17                	mov    (%edi),%edx
 47e:	8b 45 08             	mov    0x8(%ebp),%eax
 481:	e8 60 fe ff ff       	call   2e6 <printint>
        ap++;
 486:	89 f8                	mov    %edi,%eax
 488:	83 c0 04             	add    $0x4,%eax
 48b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 48e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 491:	bf 00 00 00 00       	mov    $0x0,%edi
 496:	e9 28 ff ff ff       	jmp    3c3 <printf+0x49>
        s = (char*)*ap;
 49b:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 49e:	8b 01                	mov    (%ecx),%eax
        ap++;
 4a0:	83 c1 04             	add    $0x4,%ecx
 4a3:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 4a6:	85 c0                	test   %eax,%eax
 4a8:	74 13                	je     4bd <printf+0x143>
        s = (char*)*ap;
 4aa:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 4ac:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 4af:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 4b4:	84 c0                	test   %al,%al
 4b6:	75 0f                	jne    4c7 <printf+0x14d>
 4b8:	e9 06 ff ff ff       	jmp    3c3 <printf+0x49>
          s = "(null)";
 4bd:	bb bb 06 00 00       	mov    $0x6bb,%ebx
        while(*s != 0){
 4c2:	b8 28 00 00 00       	mov    $0x28,%eax
 4c7:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 4ca:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4cd:	83 ec 04             	sub    $0x4,%esp
 4d0:	6a 01                	push   $0x1
 4d2:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d5:	50                   	push   %eax
 4d6:	57                   	push   %edi
 4d7:	e8 8a fd ff ff       	call   266 <write>
          s++;
 4dc:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4df:	0f b6 03             	movzbl (%ebx),%eax
 4e2:	83 c4 10             	add    $0x10,%esp
 4e5:	84 c0                	test   %al,%al
 4e7:	75 e1                	jne    4ca <printf+0x150>
      state = 0;
 4e9:	bf 00 00 00 00       	mov    $0x0,%edi
 4ee:	e9 d0 fe ff ff       	jmp    3c3 <printf+0x49>
        putc(fd, *ap);
 4f3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f6:	8b 07                	mov    (%edi),%eax
 4f8:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4fb:	83 ec 04             	sub    $0x4,%esp
 4fe:	6a 01                	push   $0x1
 500:	8d 45 e7             	lea    -0x19(%ebp),%eax
 503:	50                   	push   %eax
 504:	ff 75 08             	pushl  0x8(%ebp)
 507:	e8 5a fd ff ff       	call   266 <write>
        ap++;
 50c:	83 c7 04             	add    $0x4,%edi
 50f:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 512:	83 c4 10             	add    $0x10,%esp
      state = 0;
 515:	bf 00 00 00 00       	mov    $0x0,%edi
 51a:	e9 a4 fe ff ff       	jmp    3c3 <printf+0x49>
        putc(fd, c);
 51f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 522:	83 ec 04             	sub    $0x4,%esp
 525:	6a 01                	push   $0x1
 527:	8d 45 e7             	lea    -0x19(%ebp),%eax
 52a:	50                   	push   %eax
 52b:	ff 75 08             	pushl  0x8(%ebp)
 52e:	e8 33 fd ff ff       	call   266 <write>
 533:	83 c4 10             	add    $0x10,%esp
      state = 0;
 536:	bf 00 00 00 00       	mov    $0x0,%edi
 53b:	e9 83 fe ff ff       	jmp    3c3 <printf+0x49>
    }
  }
}
 540:	8d 65 f4             	lea    -0xc(%ebp),%esp
 543:	5b                   	pop    %ebx
 544:	5e                   	pop    %esi
 545:	5f                   	pop    %edi
 546:	5d                   	pop    %ebp
 547:	c3                   	ret    

00000548 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 548:	f3 0f 1e fb          	endbr32 
 54c:	55                   	push   %ebp
 54d:	89 e5                	mov    %esp,%ebp
 54f:	57                   	push   %edi
 550:	56                   	push   %esi
 551:	53                   	push   %ebx
 552:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 555:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 558:	a1 30 09 00 00       	mov    0x930,%eax
 55d:	eb 0c                	jmp    56b <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55f:	8b 10                	mov    (%eax),%edx
 561:	39 c2                	cmp    %eax,%edx
 563:	77 04                	ja     569 <free+0x21>
 565:	39 ca                	cmp    %ecx,%edx
 567:	77 10                	ja     579 <free+0x31>
{
 569:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 56b:	39 c8                	cmp    %ecx,%eax
 56d:	73 f0                	jae    55f <free+0x17>
 56f:	8b 10                	mov    (%eax),%edx
 571:	39 ca                	cmp    %ecx,%edx
 573:	77 04                	ja     579 <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 575:	39 c2                	cmp    %eax,%edx
 577:	77 f0                	ja     569 <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 579:	8b 73 fc             	mov    -0x4(%ebx),%esi
 57c:	8b 10                	mov    (%eax),%edx
 57e:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 581:	39 fa                	cmp    %edi,%edx
 583:	74 19                	je     59e <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 585:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 588:	8b 50 04             	mov    0x4(%eax),%edx
 58b:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 58e:	39 f1                	cmp    %esi,%ecx
 590:	74 1b                	je     5ad <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 592:	89 08                	mov    %ecx,(%eax)
  freep = p;
 594:	a3 30 09 00 00       	mov    %eax,0x930
}
 599:	5b                   	pop    %ebx
 59a:	5e                   	pop    %esi
 59b:	5f                   	pop    %edi
 59c:	5d                   	pop    %ebp
 59d:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 59e:	03 72 04             	add    0x4(%edx),%esi
 5a1:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5a4:	8b 10                	mov    (%eax),%edx
 5a6:	8b 12                	mov    (%edx),%edx
 5a8:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5ab:	eb db                	jmp    588 <free+0x40>
    p->s.size += bp->s.size;
 5ad:	03 53 fc             	add    -0x4(%ebx),%edx
 5b0:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5b3:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5b6:	89 10                	mov    %edx,(%eax)
 5b8:	eb da                	jmp    594 <free+0x4c>

000005ba <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5ba:	f3 0f 1e fb          	endbr32 
 5be:	55                   	push   %ebp
 5bf:	89 e5                	mov    %esp,%ebp
 5c1:	57                   	push   %edi
 5c2:	56                   	push   %esi
 5c3:	53                   	push   %ebx
 5c4:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5c7:	8b 45 08             	mov    0x8(%ebp),%eax
 5ca:	8d 58 07             	lea    0x7(%eax),%ebx
 5cd:	c1 eb 03             	shr    $0x3,%ebx
 5d0:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5d3:	8b 15 30 09 00 00    	mov    0x930,%edx
 5d9:	85 d2                	test   %edx,%edx
 5db:	74 20                	je     5fd <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5dd:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5df:	8b 48 04             	mov    0x4(%eax),%ecx
 5e2:	39 cb                	cmp    %ecx,%ebx
 5e4:	76 3c                	jbe    622 <malloc+0x68>
 5e6:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5ec:	be 00 10 00 00       	mov    $0x1000,%esi
 5f1:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5f4:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 5fb:	eb 72                	jmp    66f <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 5fd:	c7 05 30 09 00 00 34 	movl   $0x934,0x930
 604:	09 00 00 
 607:	c7 05 34 09 00 00 34 	movl   $0x934,0x934
 60e:	09 00 00 
    base.s.size = 0;
 611:	c7 05 38 09 00 00 00 	movl   $0x0,0x938
 618:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 61b:	b8 34 09 00 00       	mov    $0x934,%eax
 620:	eb c4                	jmp    5e6 <malloc+0x2c>
      if(p->s.size == nunits)
 622:	39 cb                	cmp    %ecx,%ebx
 624:	74 1e                	je     644 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 626:	29 d9                	sub    %ebx,%ecx
 628:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 62b:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 62e:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 631:	89 15 30 09 00 00    	mov    %edx,0x930
      return (void*)(p + 1);
 637:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 63a:	89 d0                	mov    %edx,%eax
 63c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 63f:	5b                   	pop    %ebx
 640:	5e                   	pop    %esi
 641:	5f                   	pop    %edi
 642:	5d                   	pop    %ebp
 643:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 644:	8b 08                	mov    (%eax),%ecx
 646:	89 0a                	mov    %ecx,(%edx)
 648:	eb e7                	jmp    631 <malloc+0x77>
  hp->s.size = nu;
 64a:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 64d:	83 ec 0c             	sub    $0xc,%esp
 650:	83 c0 08             	add    $0x8,%eax
 653:	50                   	push   %eax
 654:	e8 ef fe ff ff       	call   548 <free>
  return freep;
 659:	8b 15 30 09 00 00    	mov    0x930,%edx
      if((p = morecore(nunits)) == 0)
 65f:	83 c4 10             	add    $0x10,%esp
 662:	85 d2                	test   %edx,%edx
 664:	74 d4                	je     63a <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 666:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 668:	8b 48 04             	mov    0x4(%eax),%ecx
 66b:	39 d9                	cmp    %ebx,%ecx
 66d:	73 b3                	jae    622 <malloc+0x68>
    if(p == freep)
 66f:	89 c2                	mov    %eax,%edx
 671:	39 05 30 09 00 00    	cmp    %eax,0x930
 677:	75 ed                	jne    666 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 679:	83 ec 0c             	sub    $0xc,%esp
 67c:	57                   	push   %edi
 67d:	e8 4c fc ff ff       	call   2ce <sbrk>
  if(p == (char*)-1)
 682:	83 c4 10             	add    $0x10,%esp
 685:	83 f8 ff             	cmp    $0xffffffff,%eax
 688:	75 c0                	jne    64a <malloc+0x90>
        return 0;
 68a:	ba 00 00 00 00       	mov    $0x0,%edx
 68f:	eb a9                	jmp    63a <malloc+0x80>
