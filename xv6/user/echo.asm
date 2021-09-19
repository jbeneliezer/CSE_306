
_echo:     file format elf32-i386


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
  18:	8b 01                	mov    (%ecx),%eax
  1a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  1d:	8b 79 04             	mov    0x4(%ecx),%edi
  int i;

  for(i = 1; i < argc; i++)
  20:	83 f8 01             	cmp    $0x1,%eax
  23:	7e 41                	jle    66 <main+0x66>
  25:	8d 5f 04             	lea    0x4(%edi),%ebx
  28:	8d 74 87 fc          	lea    -0x4(%edi,%eax,4),%esi
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  2c:	39 f3                	cmp    %esi,%ebx
  2e:	74 1b                	je     4b <main+0x4b>
  30:	68 9c 06 00 00       	push   $0x69c
  35:	ff 33                	pushl  (%ebx)
  37:	68 9e 06 00 00       	push   $0x69e
  3c:	6a 01                	push   $0x1
  3e:	e8 42 03 00 00       	call   385 <printf>
  for(i = 1; i < argc; i++)
  43:	83 c3 04             	add    $0x4,%ebx
  46:	83 c4 10             	add    $0x10,%esp
  49:	eb e1                	jmp    2c <main+0x2c>
    printf(1, "%s%s", argv[i], i+1 < argc ? " " : "\n");
  4b:	68 a3 06 00 00       	push   $0x6a3
  50:	8b 45 e4             	mov    -0x1c(%ebp),%eax
  53:	ff 74 87 fc          	pushl  -0x4(%edi,%eax,4)
  57:	68 9e 06 00 00       	push   $0x69e
  5c:	6a 01                	push   $0x1
  5e:	e8 22 03 00 00       	call   385 <printf>
  63:	83 c4 10             	add    $0x10,%esp
  exit();
  66:	e8 e6 01 00 00       	call   251 <exit>

0000006b <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  6b:	f3 0f 1e fb          	endbr32 
  6f:	55                   	push   %ebp
  70:	89 e5                	mov    %esp,%ebp
  72:	53                   	push   %ebx
  73:	8b 4d 08             	mov    0x8(%ebp),%ecx
  76:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  79:	b8 00 00 00 00       	mov    $0x0,%eax
  7e:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  82:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  85:	83 c0 01             	add    $0x1,%eax
  88:	84 d2                	test   %dl,%dl
  8a:	75 f2                	jne    7e <strcpy+0x13>
    ;
  return os;
}
  8c:	89 c8                	mov    %ecx,%eax
  8e:	5b                   	pop    %ebx
  8f:	5d                   	pop    %ebp
  90:	c3                   	ret    

00000091 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  91:	f3 0f 1e fb          	endbr32 
  95:	55                   	push   %ebp
  96:	89 e5                	mov    %esp,%ebp
  98:	8b 4d 08             	mov    0x8(%ebp),%ecx
  9b:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  9e:	0f b6 01             	movzbl (%ecx),%eax
  a1:	84 c0                	test   %al,%al
  a3:	74 11                	je     b6 <strcmp+0x25>
  a5:	38 02                	cmp    %al,(%edx)
  a7:	75 0d                	jne    b6 <strcmp+0x25>
    p++, q++;
  a9:	83 c1 01             	add    $0x1,%ecx
  ac:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  af:	0f b6 01             	movzbl (%ecx),%eax
  b2:	84 c0                	test   %al,%al
  b4:	75 ef                	jne    a5 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  b6:	0f b6 c0             	movzbl %al,%eax
  b9:	0f b6 12             	movzbl (%edx),%edx
  bc:	29 d0                	sub    %edx,%eax
}
  be:	5d                   	pop    %ebp
  bf:	c3                   	ret    

000000c0 <strlen>:

uint
strlen(char *s)
{
  c0:	f3 0f 1e fb          	endbr32 
  c4:	55                   	push   %ebp
  c5:	89 e5                	mov    %esp,%ebp
  c7:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  ca:	80 3a 00             	cmpb   $0x0,(%edx)
  cd:	74 14                	je     e3 <strlen+0x23>
  cf:	b8 00 00 00 00       	mov    $0x0,%eax
  d4:	83 c0 01             	add    $0x1,%eax
  d7:	89 c1                	mov    %eax,%ecx
  d9:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  dd:	75 f5                	jne    d4 <strlen+0x14>
    ;
  return n;
}
  df:	89 c8                	mov    %ecx,%eax
  e1:	5d                   	pop    %ebp
  e2:	c3                   	ret    
  for(n = 0; s[n]; n++)
  e3:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
  e8:	eb f5                	jmp    df <strlen+0x1f>

000000ea <memset>:

void*
memset(void *dst, int c, uint n)
{
  ea:	f3 0f 1e fb          	endbr32 
  ee:	55                   	push   %ebp
  ef:	89 e5                	mov    %esp,%ebp
  f1:	57                   	push   %edi
  f2:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  f5:	89 d7                	mov    %edx,%edi
  f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  fa:	8b 45 0c             	mov    0xc(%ebp),%eax
  fd:	fc                   	cld    
  fe:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 100:	89 d0                	mov    %edx,%eax
 102:	5f                   	pop    %edi
 103:	5d                   	pop    %ebp
 104:	c3                   	ret    

00000105 <strchr>:

char*
strchr(const char *s, char c)
{
 105:	f3 0f 1e fb          	endbr32 
 109:	55                   	push   %ebp
 10a:	89 e5                	mov    %esp,%ebp
 10c:	8b 45 08             	mov    0x8(%ebp),%eax
 10f:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 113:	0f b6 10             	movzbl (%eax),%edx
 116:	84 d2                	test   %dl,%dl
 118:	74 15                	je     12f <strchr+0x2a>
    if(*s == c)
 11a:	38 d1                	cmp    %dl,%cl
 11c:	74 0f                	je     12d <strchr+0x28>
  for(; *s; s++)
 11e:	83 c0 01             	add    $0x1,%eax
 121:	0f b6 10             	movzbl (%eax),%edx
 124:	84 d2                	test   %dl,%dl
 126:	75 f2                	jne    11a <strchr+0x15>
      return (char*)s;
  return 0;
 128:	b8 00 00 00 00       	mov    $0x0,%eax
}
 12d:	5d                   	pop    %ebp
 12e:	c3                   	ret    
  return 0;
 12f:	b8 00 00 00 00       	mov    $0x0,%eax
 134:	eb f7                	jmp    12d <strchr+0x28>

00000136 <gets>:

char*
gets(char *buf, int max)
{
 136:	f3 0f 1e fb          	endbr32 
 13a:	55                   	push   %ebp
 13b:	89 e5                	mov    %esp,%ebp
 13d:	57                   	push   %edi
 13e:	56                   	push   %esi
 13f:	53                   	push   %ebx
 140:	83 ec 2c             	sub    $0x2c,%esp
 143:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 14b:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 14e:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 151:	83 c3 01             	add    $0x1,%ebx
 154:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 157:	7d 27                	jge    180 <gets+0x4a>
    cc = read(0, &c, 1);
 159:	83 ec 04             	sub    $0x4,%esp
 15c:	6a 01                	push   $0x1
 15e:	57                   	push   %edi
 15f:	6a 00                	push   $0x0
 161:	e8 03 01 00 00       	call   269 <read>
    if(cc < 1)
 166:	83 c4 10             	add    $0x10,%esp
 169:	85 c0                	test   %eax,%eax
 16b:	7e 13                	jle    180 <gets+0x4a>
      break;
    buf[i++] = c;
 16d:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 171:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 175:	3c 0a                	cmp    $0xa,%al
 177:	74 04                	je     17d <gets+0x47>
 179:	3c 0d                	cmp    $0xd,%al
 17b:	75 d1                	jne    14e <gets+0x18>
  for(i=0; i+1 < max; ){
 17d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 180:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 183:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 187:	89 f0                	mov    %esi,%eax
 189:	8d 65 f4             	lea    -0xc(%ebp),%esp
 18c:	5b                   	pop    %ebx
 18d:	5e                   	pop    %esi
 18e:	5f                   	pop    %edi
 18f:	5d                   	pop    %ebp
 190:	c3                   	ret    

00000191 <stat>:

int
stat(char *n, struct stat *st)
{
 191:	f3 0f 1e fb          	endbr32 
 195:	55                   	push   %ebp
 196:	89 e5                	mov    %esp,%ebp
 198:	56                   	push   %esi
 199:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 19a:	83 ec 08             	sub    $0x8,%esp
 19d:	6a 00                	push   $0x0
 19f:	ff 75 08             	pushl  0x8(%ebp)
 1a2:	e8 ea 00 00 00       	call   291 <open>
  if(fd < 0)
 1a7:	83 c4 10             	add    $0x10,%esp
 1aa:	85 c0                	test   %eax,%eax
 1ac:	78 24                	js     1d2 <stat+0x41>
 1ae:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1b0:	83 ec 08             	sub    $0x8,%esp
 1b3:	ff 75 0c             	pushl  0xc(%ebp)
 1b6:	50                   	push   %eax
 1b7:	e8 ed 00 00 00       	call   2a9 <fstat>
 1bc:	89 c6                	mov    %eax,%esi
  close(fd);
 1be:	89 1c 24             	mov    %ebx,(%esp)
 1c1:	e8 b3 00 00 00       	call   279 <close>
  return r;
 1c6:	83 c4 10             	add    $0x10,%esp
}
 1c9:	89 f0                	mov    %esi,%eax
 1cb:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1ce:	5b                   	pop    %ebx
 1cf:	5e                   	pop    %esi
 1d0:	5d                   	pop    %ebp
 1d1:	c3                   	ret    
    return -1;
 1d2:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1d7:	eb f0                	jmp    1c9 <stat+0x38>

000001d9 <atoi>:

int
atoi(const char *s)
{
 1d9:	f3 0f 1e fb          	endbr32 
 1dd:	55                   	push   %ebp
 1de:	89 e5                	mov    %esp,%ebp
 1e0:	53                   	push   %ebx
 1e1:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1e4:	0f b6 02             	movzbl (%edx),%eax
 1e7:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1ea:	80 f9 09             	cmp    $0x9,%cl
 1ed:	77 22                	ja     211 <atoi+0x38>
  n = 0;
 1ef:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 1f4:	83 c2 01             	add    $0x1,%edx
 1f7:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 1fa:	0f be c0             	movsbl %al,%eax
 1fd:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 201:	0f b6 02             	movzbl (%edx),%eax
 204:	8d 58 d0             	lea    -0x30(%eax),%ebx
 207:	80 fb 09             	cmp    $0x9,%bl
 20a:	76 e8                	jbe    1f4 <atoi+0x1b>
  return n;
}
 20c:	89 c8                	mov    %ecx,%eax
 20e:	5b                   	pop    %ebx
 20f:	5d                   	pop    %ebp
 210:	c3                   	ret    
  n = 0;
 211:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 216:	eb f4                	jmp    20c <atoi+0x33>

00000218 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 218:	f3 0f 1e fb          	endbr32 
 21c:	55                   	push   %ebp
 21d:	89 e5                	mov    %esp,%ebp
 21f:	56                   	push   %esi
 220:	53                   	push   %ebx
 221:	8b 75 08             	mov    0x8(%ebp),%esi
 224:	8b 55 0c             	mov    0xc(%ebp),%edx
 227:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 22a:	85 db                	test   %ebx,%ebx
 22c:	7e 15                	jle    243 <memmove+0x2b>
 22e:	01 f3                	add    %esi,%ebx
  dst = vdst;
 230:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 232:	83 c2 01             	add    $0x1,%edx
 235:	83 c0 01             	add    $0x1,%eax
 238:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 23c:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 23f:	39 c3                	cmp    %eax,%ebx
 241:	75 ef                	jne    232 <memmove+0x1a>
  return vdst;
}
 243:	89 f0                	mov    %esi,%eax
 245:	5b                   	pop    %ebx
 246:	5e                   	pop    %esi
 247:	5d                   	pop    %ebp
 248:	c3                   	ret    

00000249 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 249:	b8 01 00 00 00       	mov    $0x1,%eax
 24e:	cd 40                	int    $0x40
 250:	c3                   	ret    

00000251 <exit>:
SYSCALL(exit)
 251:	b8 02 00 00 00       	mov    $0x2,%eax
 256:	cd 40                	int    $0x40
 258:	c3                   	ret    

00000259 <wait>:
SYSCALL(wait)
 259:	b8 03 00 00 00       	mov    $0x3,%eax
 25e:	cd 40                	int    $0x40
 260:	c3                   	ret    

00000261 <pipe>:
SYSCALL(pipe)
 261:	b8 04 00 00 00       	mov    $0x4,%eax
 266:	cd 40                	int    $0x40
 268:	c3                   	ret    

00000269 <read>:
SYSCALL(read)
 269:	b8 05 00 00 00       	mov    $0x5,%eax
 26e:	cd 40                	int    $0x40
 270:	c3                   	ret    

00000271 <write>:
SYSCALL(write)
 271:	b8 10 00 00 00       	mov    $0x10,%eax
 276:	cd 40                	int    $0x40
 278:	c3                   	ret    

00000279 <close>:
SYSCALL(close)
 279:	b8 15 00 00 00       	mov    $0x15,%eax
 27e:	cd 40                	int    $0x40
 280:	c3                   	ret    

00000281 <kill>:
SYSCALL(kill)
 281:	b8 06 00 00 00       	mov    $0x6,%eax
 286:	cd 40                	int    $0x40
 288:	c3                   	ret    

00000289 <exec>:
SYSCALL(exec)
 289:	b8 07 00 00 00       	mov    $0x7,%eax
 28e:	cd 40                	int    $0x40
 290:	c3                   	ret    

00000291 <open>:
SYSCALL(open)
 291:	b8 0f 00 00 00       	mov    $0xf,%eax
 296:	cd 40                	int    $0x40
 298:	c3                   	ret    

00000299 <mknod>:
SYSCALL(mknod)
 299:	b8 11 00 00 00       	mov    $0x11,%eax
 29e:	cd 40                	int    $0x40
 2a0:	c3                   	ret    

000002a1 <unlink>:
SYSCALL(unlink)
 2a1:	b8 12 00 00 00       	mov    $0x12,%eax
 2a6:	cd 40                	int    $0x40
 2a8:	c3                   	ret    

000002a9 <fstat>:
SYSCALL(fstat)
 2a9:	b8 08 00 00 00       	mov    $0x8,%eax
 2ae:	cd 40                	int    $0x40
 2b0:	c3                   	ret    

000002b1 <link>:
SYSCALL(link)
 2b1:	b8 13 00 00 00       	mov    $0x13,%eax
 2b6:	cd 40                	int    $0x40
 2b8:	c3                   	ret    

000002b9 <mkdir>:
SYSCALL(mkdir)
 2b9:	b8 14 00 00 00       	mov    $0x14,%eax
 2be:	cd 40                	int    $0x40
 2c0:	c3                   	ret    

000002c1 <chdir>:
SYSCALL(chdir)
 2c1:	b8 09 00 00 00       	mov    $0x9,%eax
 2c6:	cd 40                	int    $0x40
 2c8:	c3                   	ret    

000002c9 <dup>:
SYSCALL(dup)
 2c9:	b8 0a 00 00 00       	mov    $0xa,%eax
 2ce:	cd 40                	int    $0x40
 2d0:	c3                   	ret    

000002d1 <getpid>:
SYSCALL(getpid)
 2d1:	b8 0b 00 00 00       	mov    $0xb,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <sbrk>:
SYSCALL(sbrk)
 2d9:	b8 0c 00 00 00       	mov    $0xc,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <sleep>:
SYSCALL(sleep)
 2e1:	b8 0d 00 00 00       	mov    $0xd,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <uptime>:
SYSCALL(uptime)
 2e9:	b8 0e 00 00 00       	mov    $0xe,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2f1:	55                   	push   %ebp
 2f2:	89 e5                	mov    %esp,%ebp
 2f4:	57                   	push   %edi
 2f5:	56                   	push   %esi
 2f6:	53                   	push   %ebx
 2f7:	83 ec 3c             	sub    $0x3c,%esp
 2fa:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 2fd:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2ff:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 303:	74 77                	je     37c <printint+0x8b>
 305:	85 d2                	test   %edx,%edx
 307:	79 73                	jns    37c <printint+0x8b>
    neg = 1;
    x = -xx;
 309:	f7 db                	neg    %ebx
    neg = 1;
 30b:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 312:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 317:	89 f7                	mov    %esi,%edi
 319:	83 c6 01             	add    $0x1,%esi
 31c:	89 d8                	mov    %ebx,%eax
 31e:	ba 00 00 00 00       	mov    $0x0,%edx
 323:	f7 f1                	div    %ecx
 325:	0f b6 92 ac 06 00 00 	movzbl 0x6ac(%edx),%edx
 32c:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 330:	89 da                	mov    %ebx,%edx
 332:	89 c3                	mov    %eax,%ebx
 334:	39 d1                	cmp    %edx,%ecx
 336:	76 df                	jbe    317 <printint+0x26>
  if(neg)
 338:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 33c:	74 08                	je     346 <printint+0x55>
    buf[i++] = '-';
 33e:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 343:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 346:	85 f6                	test   %esi,%esi
 348:	7e 2a                	jle    374 <printint+0x83>
 34a:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 34e:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 351:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 354:	0f b6 03             	movzbl (%ebx),%eax
 357:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 35a:	83 ec 04             	sub    $0x4,%esp
 35d:	6a 01                	push   $0x1
 35f:	56                   	push   %esi
 360:	ff 75 c4             	pushl  -0x3c(%ebp)
 363:	e8 09 ff ff ff       	call   271 <write>
  while(--i >= 0)
 368:	89 d8                	mov    %ebx,%eax
 36a:	83 eb 01             	sub    $0x1,%ebx
 36d:	83 c4 10             	add    $0x10,%esp
 370:	39 f8                	cmp    %edi,%eax
 372:	75 e0                	jne    354 <printint+0x63>
}
 374:	8d 65 f4             	lea    -0xc(%ebp),%esp
 377:	5b                   	pop    %ebx
 378:	5e                   	pop    %esi
 379:	5f                   	pop    %edi
 37a:	5d                   	pop    %ebp
 37b:	c3                   	ret    
  neg = 0;
 37c:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 383:	eb 8d                	jmp    312 <printint+0x21>

00000385 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 385:	f3 0f 1e fb          	endbr32 
 389:	55                   	push   %ebp
 38a:	89 e5                	mov    %esp,%ebp
 38c:	57                   	push   %edi
 38d:	56                   	push   %esi
 38e:	53                   	push   %ebx
 38f:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 392:	8b 75 0c             	mov    0xc(%ebp),%esi
 395:	0f b6 1e             	movzbl (%esi),%ebx
 398:	84 db                	test   %bl,%bl
 39a:	0f 84 ab 01 00 00    	je     54b <printf+0x1c6>
 3a0:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 3a3:	8d 45 10             	lea    0x10(%ebp),%eax
 3a6:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 3a9:	bf 00 00 00 00       	mov    $0x0,%edi
 3ae:	eb 2d                	jmp    3dd <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3b0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 3b3:	83 ec 04             	sub    $0x4,%esp
 3b6:	6a 01                	push   $0x1
 3b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3bb:	50                   	push   %eax
 3bc:	ff 75 08             	pushl  0x8(%ebp)
 3bf:	e8 ad fe ff ff       	call   271 <write>
        putc(fd, c);
 3c4:	83 c4 10             	add    $0x10,%esp
 3c7:	eb 05                	jmp    3ce <printf+0x49>
      }
    } else if(state == '%'){
 3c9:	83 ff 25             	cmp    $0x25,%edi
 3cc:	74 22                	je     3f0 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 3ce:	83 c6 01             	add    $0x1,%esi
 3d1:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 3d5:	84 db                	test   %bl,%bl
 3d7:	0f 84 6e 01 00 00    	je     54b <printf+0x1c6>
    c = fmt[i] & 0xff;
 3dd:	0f be d3             	movsbl %bl,%edx
 3e0:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3e3:	85 ff                	test   %edi,%edi
 3e5:	75 e2                	jne    3c9 <printf+0x44>
      if(c == '%'){
 3e7:	83 f8 25             	cmp    $0x25,%eax
 3ea:	75 c4                	jne    3b0 <printf+0x2b>
        state = '%';
 3ec:	89 c7                	mov    %eax,%edi
 3ee:	eb de                	jmp    3ce <printf+0x49>
      if(c == 'd'){
 3f0:	83 f8 64             	cmp    $0x64,%eax
 3f3:	74 59                	je     44e <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3f5:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3fb:	83 fa 70             	cmp    $0x70,%edx
 3fe:	74 7a                	je     47a <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 400:	83 f8 73             	cmp    $0x73,%eax
 403:	0f 84 9d 00 00 00    	je     4a6 <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 409:	83 f8 63             	cmp    $0x63,%eax
 40c:	0f 84 ec 00 00 00    	je     4fe <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 412:	83 f8 25             	cmp    $0x25,%eax
 415:	0f 84 0f 01 00 00    	je     52a <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 41b:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 41f:	83 ec 04             	sub    $0x4,%esp
 422:	6a 01                	push   $0x1
 424:	8d 45 e7             	lea    -0x19(%ebp),%eax
 427:	50                   	push   %eax
 428:	ff 75 08             	pushl  0x8(%ebp)
 42b:	e8 41 fe ff ff       	call   271 <write>
        putc(fd, c);
 430:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 433:	83 c4 0c             	add    $0xc,%esp
 436:	6a 01                	push   $0x1
 438:	8d 45 e7             	lea    -0x19(%ebp),%eax
 43b:	50                   	push   %eax
 43c:	ff 75 08             	pushl  0x8(%ebp)
 43f:	e8 2d fe ff ff       	call   271 <write>
        putc(fd, c);
 444:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 447:	bf 00 00 00 00       	mov    $0x0,%edi
 44c:	eb 80                	jmp    3ce <printf+0x49>
        printint(fd, *ap, 10, 1);
 44e:	83 ec 0c             	sub    $0xc,%esp
 451:	6a 01                	push   $0x1
 453:	b9 0a 00 00 00       	mov    $0xa,%ecx
 458:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 45b:	8b 17                	mov    (%edi),%edx
 45d:	8b 45 08             	mov    0x8(%ebp),%eax
 460:	e8 8c fe ff ff       	call   2f1 <printint>
        ap++;
 465:	89 f8                	mov    %edi,%eax
 467:	83 c0 04             	add    $0x4,%eax
 46a:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 46d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 470:	bf 00 00 00 00       	mov    $0x0,%edi
 475:	e9 54 ff ff ff       	jmp    3ce <printf+0x49>
        printint(fd, *ap, 16, 0);
 47a:	83 ec 0c             	sub    $0xc,%esp
 47d:	6a 00                	push   $0x0
 47f:	b9 10 00 00 00       	mov    $0x10,%ecx
 484:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 487:	8b 17                	mov    (%edi),%edx
 489:	8b 45 08             	mov    0x8(%ebp),%eax
 48c:	e8 60 fe ff ff       	call   2f1 <printint>
        ap++;
 491:	89 f8                	mov    %edi,%eax
 493:	83 c0 04             	add    $0x4,%eax
 496:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 499:	83 c4 10             	add    $0x10,%esp
      state = 0;
 49c:	bf 00 00 00 00       	mov    $0x0,%edi
 4a1:	e9 28 ff ff ff       	jmp    3ce <printf+0x49>
        s = (char*)*ap;
 4a6:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 4a9:	8b 01                	mov    (%ecx),%eax
        ap++;
 4ab:	83 c1 04             	add    $0x4,%ecx
 4ae:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 4b1:	85 c0                	test   %eax,%eax
 4b3:	74 13                	je     4c8 <printf+0x143>
        s = (char*)*ap;
 4b5:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 4b7:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 4ba:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 4bf:	84 c0                	test   %al,%al
 4c1:	75 0f                	jne    4d2 <printf+0x14d>
 4c3:	e9 06 ff ff ff       	jmp    3ce <printf+0x49>
          s = "(null)";
 4c8:	bb a5 06 00 00       	mov    $0x6a5,%ebx
        while(*s != 0){
 4cd:	b8 28 00 00 00       	mov    $0x28,%eax
 4d2:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 4d5:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4d8:	83 ec 04             	sub    $0x4,%esp
 4db:	6a 01                	push   $0x1
 4dd:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e0:	50                   	push   %eax
 4e1:	57                   	push   %edi
 4e2:	e8 8a fd ff ff       	call   271 <write>
          s++;
 4e7:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4ea:	0f b6 03             	movzbl (%ebx),%eax
 4ed:	83 c4 10             	add    $0x10,%esp
 4f0:	84 c0                	test   %al,%al
 4f2:	75 e1                	jne    4d5 <printf+0x150>
      state = 0;
 4f4:	bf 00 00 00 00       	mov    $0x0,%edi
 4f9:	e9 d0 fe ff ff       	jmp    3ce <printf+0x49>
        putc(fd, *ap);
 4fe:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 501:	8b 07                	mov    (%edi),%eax
 503:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 506:	83 ec 04             	sub    $0x4,%esp
 509:	6a 01                	push   $0x1
 50b:	8d 45 e7             	lea    -0x19(%ebp),%eax
 50e:	50                   	push   %eax
 50f:	ff 75 08             	pushl  0x8(%ebp)
 512:	e8 5a fd ff ff       	call   271 <write>
        ap++;
 517:	83 c7 04             	add    $0x4,%edi
 51a:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 51d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 520:	bf 00 00 00 00       	mov    $0x0,%edi
 525:	e9 a4 fe ff ff       	jmp    3ce <printf+0x49>
        putc(fd, c);
 52a:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 52d:	83 ec 04             	sub    $0x4,%esp
 530:	6a 01                	push   $0x1
 532:	8d 45 e7             	lea    -0x19(%ebp),%eax
 535:	50                   	push   %eax
 536:	ff 75 08             	pushl  0x8(%ebp)
 539:	e8 33 fd ff ff       	call   271 <write>
 53e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 541:	bf 00 00 00 00       	mov    $0x0,%edi
 546:	e9 83 fe ff ff       	jmp    3ce <printf+0x49>
    }
  }
}
 54b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 54e:	5b                   	pop    %ebx
 54f:	5e                   	pop    %esi
 550:	5f                   	pop    %edi
 551:	5d                   	pop    %ebp
 552:	c3                   	ret    

00000553 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 553:	f3 0f 1e fb          	endbr32 
 557:	55                   	push   %ebp
 558:	89 e5                	mov    %esp,%ebp
 55a:	57                   	push   %edi
 55b:	56                   	push   %esi
 55c:	53                   	push   %ebx
 55d:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 560:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 563:	a1 20 09 00 00       	mov    0x920,%eax
 568:	eb 0c                	jmp    576 <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 56a:	8b 10                	mov    (%eax),%edx
 56c:	39 c2                	cmp    %eax,%edx
 56e:	77 04                	ja     574 <free+0x21>
 570:	39 ca                	cmp    %ecx,%edx
 572:	77 10                	ja     584 <free+0x31>
{
 574:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 576:	39 c8                	cmp    %ecx,%eax
 578:	73 f0                	jae    56a <free+0x17>
 57a:	8b 10                	mov    (%eax),%edx
 57c:	39 ca                	cmp    %ecx,%edx
 57e:	77 04                	ja     584 <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 580:	39 c2                	cmp    %eax,%edx
 582:	77 f0                	ja     574 <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 584:	8b 73 fc             	mov    -0x4(%ebx),%esi
 587:	8b 10                	mov    (%eax),%edx
 589:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 58c:	39 fa                	cmp    %edi,%edx
 58e:	74 19                	je     5a9 <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 590:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 593:	8b 50 04             	mov    0x4(%eax),%edx
 596:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 599:	39 f1                	cmp    %esi,%ecx
 59b:	74 1b                	je     5b8 <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 59d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 59f:	a3 20 09 00 00       	mov    %eax,0x920
}
 5a4:	5b                   	pop    %ebx
 5a5:	5e                   	pop    %esi
 5a6:	5f                   	pop    %edi
 5a7:	5d                   	pop    %ebp
 5a8:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 5a9:	03 72 04             	add    0x4(%edx),%esi
 5ac:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5af:	8b 10                	mov    (%eax),%edx
 5b1:	8b 12                	mov    (%edx),%edx
 5b3:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5b6:	eb db                	jmp    593 <free+0x40>
    p->s.size += bp->s.size;
 5b8:	03 53 fc             	add    -0x4(%ebx),%edx
 5bb:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5be:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5c1:	89 10                	mov    %edx,(%eax)
 5c3:	eb da                	jmp    59f <free+0x4c>

000005c5 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5c5:	f3 0f 1e fb          	endbr32 
 5c9:	55                   	push   %ebp
 5ca:	89 e5                	mov    %esp,%ebp
 5cc:	57                   	push   %edi
 5cd:	56                   	push   %esi
 5ce:	53                   	push   %ebx
 5cf:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5d2:	8b 45 08             	mov    0x8(%ebp),%eax
 5d5:	8d 58 07             	lea    0x7(%eax),%ebx
 5d8:	c1 eb 03             	shr    $0x3,%ebx
 5db:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5de:	8b 15 20 09 00 00    	mov    0x920,%edx
 5e4:	85 d2                	test   %edx,%edx
 5e6:	74 20                	je     608 <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5e8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5ea:	8b 48 04             	mov    0x4(%eax),%ecx
 5ed:	39 cb                	cmp    %ecx,%ebx
 5ef:	76 3c                	jbe    62d <malloc+0x68>
 5f1:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5f7:	be 00 10 00 00       	mov    $0x1000,%esi
 5fc:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5ff:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 606:	eb 72                	jmp    67a <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 608:	c7 05 20 09 00 00 24 	movl   $0x924,0x920
 60f:	09 00 00 
 612:	c7 05 24 09 00 00 24 	movl   $0x924,0x924
 619:	09 00 00 
    base.s.size = 0;
 61c:	c7 05 28 09 00 00 00 	movl   $0x0,0x928
 623:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 626:	b8 24 09 00 00       	mov    $0x924,%eax
 62b:	eb c4                	jmp    5f1 <malloc+0x2c>
      if(p->s.size == nunits)
 62d:	39 cb                	cmp    %ecx,%ebx
 62f:	74 1e                	je     64f <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 631:	29 d9                	sub    %ebx,%ecx
 633:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 636:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 639:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 63c:	89 15 20 09 00 00    	mov    %edx,0x920
      return (void*)(p + 1);
 642:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 645:	89 d0                	mov    %edx,%eax
 647:	8d 65 f4             	lea    -0xc(%ebp),%esp
 64a:	5b                   	pop    %ebx
 64b:	5e                   	pop    %esi
 64c:	5f                   	pop    %edi
 64d:	5d                   	pop    %ebp
 64e:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 64f:	8b 08                	mov    (%eax),%ecx
 651:	89 0a                	mov    %ecx,(%edx)
 653:	eb e7                	jmp    63c <malloc+0x77>
  hp->s.size = nu;
 655:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 658:	83 ec 0c             	sub    $0xc,%esp
 65b:	83 c0 08             	add    $0x8,%eax
 65e:	50                   	push   %eax
 65f:	e8 ef fe ff ff       	call   553 <free>
  return freep;
 664:	8b 15 20 09 00 00    	mov    0x920,%edx
      if((p = morecore(nunits)) == 0)
 66a:	83 c4 10             	add    $0x10,%esp
 66d:	85 d2                	test   %edx,%edx
 66f:	74 d4                	je     645 <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 671:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 673:	8b 48 04             	mov    0x4(%eax),%ecx
 676:	39 d9                	cmp    %ebx,%ecx
 678:	73 b3                	jae    62d <malloc+0x68>
    if(p == freep)
 67a:	89 c2                	mov    %eax,%edx
 67c:	39 05 20 09 00 00    	cmp    %eax,0x920
 682:	75 ed                	jne    671 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 684:	83 ec 0c             	sub    $0xc,%esp
 687:	57                   	push   %edi
 688:	e8 4c fc ff ff       	call   2d9 <sbrk>
  if(p == (char*)-1)
 68d:	83 c4 10             	add    $0x10,%esp
 690:	83 f8 ff             	cmp    $0xffffffff,%eax
 693:	75 c0                	jne    655 <malloc+0x90>
        return 0;
 695:	ba 00 00 00 00       	mov    $0x0,%edx
 69a:	eb a9                	jmp    645 <malloc+0x80>
