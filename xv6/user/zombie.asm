
_zombie:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/stat.h"
#include "user.h"

int
main(void)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	51                   	push   %ecx
  12:	83 ec 04             	sub    $0x4,%esp
  if(fork() > 0)
  15:	e8 f6 01 00 00       	call   210 <fork>
  1a:	85 c0                	test   %eax,%eax
  1c:	7f 05                	jg     23 <main+0x23>
    sleep(5);  // Let child exit before parent.
  exit();
  1e:	e8 f5 01 00 00       	call   218 <exit>
    sleep(5);  // Let child exit before parent.
  23:	83 ec 0c             	sub    $0xc,%esp
  26:	6a 05                	push   $0x5
  28:	e8 7b 02 00 00       	call   2a8 <sleep>
  2d:	83 c4 10             	add    $0x10,%esp
  30:	eb ec                	jmp    1e <main+0x1e>

00000032 <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  32:	f3 0f 1e fb          	endbr32 
  36:	55                   	push   %ebp
  37:	89 e5                	mov    %esp,%ebp
  39:	53                   	push   %ebx
  3a:	8b 4d 08             	mov    0x8(%ebp),%ecx
  3d:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  40:	b8 00 00 00 00       	mov    $0x0,%eax
  45:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  49:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  4c:	83 c0 01             	add    $0x1,%eax
  4f:	84 d2                	test   %dl,%dl
  51:	75 f2                	jne    45 <strcpy+0x13>
    ;
  return os;
}
  53:	89 c8                	mov    %ecx,%eax
  55:	5b                   	pop    %ebx
  56:	5d                   	pop    %ebp
  57:	c3                   	ret    

00000058 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  58:	f3 0f 1e fb          	endbr32 
  5c:	55                   	push   %ebp
  5d:	89 e5                	mov    %esp,%ebp
  5f:	8b 4d 08             	mov    0x8(%ebp),%ecx
  62:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  65:	0f b6 01             	movzbl (%ecx),%eax
  68:	84 c0                	test   %al,%al
  6a:	74 11                	je     7d <strcmp+0x25>
  6c:	38 02                	cmp    %al,(%edx)
  6e:	75 0d                	jne    7d <strcmp+0x25>
    p++, q++;
  70:	83 c1 01             	add    $0x1,%ecx
  73:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  76:	0f b6 01             	movzbl (%ecx),%eax
  79:	84 c0                	test   %al,%al
  7b:	75 ef                	jne    6c <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  7d:	0f b6 c0             	movzbl %al,%eax
  80:	0f b6 12             	movzbl (%edx),%edx
  83:	29 d0                	sub    %edx,%eax
}
  85:	5d                   	pop    %ebp
  86:	c3                   	ret    

00000087 <strlen>:

uint
strlen(char *s)
{
  87:	f3 0f 1e fb          	endbr32 
  8b:	55                   	push   %ebp
  8c:	89 e5                	mov    %esp,%ebp
  8e:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  91:	80 3a 00             	cmpb   $0x0,(%edx)
  94:	74 14                	je     aa <strlen+0x23>
  96:	b8 00 00 00 00       	mov    $0x0,%eax
  9b:	83 c0 01             	add    $0x1,%eax
  9e:	89 c1                	mov    %eax,%ecx
  a0:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  a4:	75 f5                	jne    9b <strlen+0x14>
    ;
  return n;
}
  a6:	89 c8                	mov    %ecx,%eax
  a8:	5d                   	pop    %ebp
  a9:	c3                   	ret    
  for(n = 0; s[n]; n++)
  aa:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
  af:	eb f5                	jmp    a6 <strlen+0x1f>

000000b1 <memset>:

void*
memset(void *dst, int c, uint n)
{
  b1:	f3 0f 1e fb          	endbr32 
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  b8:	57                   	push   %edi
  b9:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  bc:	89 d7                	mov    %edx,%edi
  be:	8b 4d 10             	mov    0x10(%ebp),%ecx
  c1:	8b 45 0c             	mov    0xc(%ebp),%eax
  c4:	fc                   	cld    
  c5:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  c7:	89 d0                	mov    %edx,%eax
  c9:	5f                   	pop    %edi
  ca:	5d                   	pop    %ebp
  cb:	c3                   	ret    

000000cc <strchr>:

char*
strchr(const char *s, char c)
{
  cc:	f3 0f 1e fb          	endbr32 
  d0:	55                   	push   %ebp
  d1:	89 e5                	mov    %esp,%ebp
  d3:	8b 45 08             	mov    0x8(%ebp),%eax
  d6:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
  da:	0f b6 10             	movzbl (%eax),%edx
  dd:	84 d2                	test   %dl,%dl
  df:	74 15                	je     f6 <strchr+0x2a>
    if(*s == c)
  e1:	38 d1                	cmp    %dl,%cl
  e3:	74 0f                	je     f4 <strchr+0x28>
  for(; *s; s++)
  e5:	83 c0 01             	add    $0x1,%eax
  e8:	0f b6 10             	movzbl (%eax),%edx
  eb:	84 d2                	test   %dl,%dl
  ed:	75 f2                	jne    e1 <strchr+0x15>
      return (char*)s;
  return 0;
  ef:	b8 00 00 00 00       	mov    $0x0,%eax
}
  f4:	5d                   	pop    %ebp
  f5:	c3                   	ret    
  return 0;
  f6:	b8 00 00 00 00       	mov    $0x0,%eax
  fb:	eb f7                	jmp    f4 <strchr+0x28>

000000fd <gets>:

char*
gets(char *buf, int max)
{
  fd:	f3 0f 1e fb          	endbr32 
 101:	55                   	push   %ebp
 102:	89 e5                	mov    %esp,%ebp
 104:	57                   	push   %edi
 105:	56                   	push   %esi
 106:	53                   	push   %ebx
 107:	83 ec 2c             	sub    $0x2c,%esp
 10a:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 10d:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 112:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 115:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 118:	83 c3 01             	add    $0x1,%ebx
 11b:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 11e:	7d 27                	jge    147 <gets+0x4a>
    cc = read(0, &c, 1);
 120:	83 ec 04             	sub    $0x4,%esp
 123:	6a 01                	push   $0x1
 125:	57                   	push   %edi
 126:	6a 00                	push   $0x0
 128:	e8 03 01 00 00       	call   230 <read>
    if(cc < 1)
 12d:	83 c4 10             	add    $0x10,%esp
 130:	85 c0                	test   %eax,%eax
 132:	7e 13                	jle    147 <gets+0x4a>
      break;
    buf[i++] = c;
 134:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 138:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 13c:	3c 0a                	cmp    $0xa,%al
 13e:	74 04                	je     144 <gets+0x47>
 140:	3c 0d                	cmp    $0xd,%al
 142:	75 d1                	jne    115 <gets+0x18>
  for(i=0; i+1 < max; ){
 144:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 147:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 14a:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 14e:	89 f0                	mov    %esi,%eax
 150:	8d 65 f4             	lea    -0xc(%ebp),%esp
 153:	5b                   	pop    %ebx
 154:	5e                   	pop    %esi
 155:	5f                   	pop    %edi
 156:	5d                   	pop    %ebp
 157:	c3                   	ret    

00000158 <stat>:

int
stat(char *n, struct stat *st)
{
 158:	f3 0f 1e fb          	endbr32 
 15c:	55                   	push   %ebp
 15d:	89 e5                	mov    %esp,%ebp
 15f:	56                   	push   %esi
 160:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 161:	83 ec 08             	sub    $0x8,%esp
 164:	6a 00                	push   $0x0
 166:	ff 75 08             	pushl  0x8(%ebp)
 169:	e8 ea 00 00 00       	call   258 <open>
  if(fd < 0)
 16e:	83 c4 10             	add    $0x10,%esp
 171:	85 c0                	test   %eax,%eax
 173:	78 24                	js     199 <stat+0x41>
 175:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 177:	83 ec 08             	sub    $0x8,%esp
 17a:	ff 75 0c             	pushl  0xc(%ebp)
 17d:	50                   	push   %eax
 17e:	e8 ed 00 00 00       	call   270 <fstat>
 183:	89 c6                	mov    %eax,%esi
  close(fd);
 185:	89 1c 24             	mov    %ebx,(%esp)
 188:	e8 b3 00 00 00       	call   240 <close>
  return r;
 18d:	83 c4 10             	add    $0x10,%esp
}
 190:	89 f0                	mov    %esi,%eax
 192:	8d 65 f8             	lea    -0x8(%ebp),%esp
 195:	5b                   	pop    %ebx
 196:	5e                   	pop    %esi
 197:	5d                   	pop    %ebp
 198:	c3                   	ret    
    return -1;
 199:	be ff ff ff ff       	mov    $0xffffffff,%esi
 19e:	eb f0                	jmp    190 <stat+0x38>

000001a0 <atoi>:

int
atoi(const char *s)
{
 1a0:	f3 0f 1e fb          	endbr32 
 1a4:	55                   	push   %ebp
 1a5:	89 e5                	mov    %esp,%ebp
 1a7:	53                   	push   %ebx
 1a8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1ab:	0f b6 02             	movzbl (%edx),%eax
 1ae:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1b1:	80 f9 09             	cmp    $0x9,%cl
 1b4:	77 22                	ja     1d8 <atoi+0x38>
  n = 0;
 1b6:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 1bb:	83 c2 01             	add    $0x1,%edx
 1be:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 1c1:	0f be c0             	movsbl %al,%eax
 1c4:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 1c8:	0f b6 02             	movzbl (%edx),%eax
 1cb:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1ce:	80 fb 09             	cmp    $0x9,%bl
 1d1:	76 e8                	jbe    1bb <atoi+0x1b>
  return n;
}
 1d3:	89 c8                	mov    %ecx,%eax
 1d5:	5b                   	pop    %ebx
 1d6:	5d                   	pop    %ebp
 1d7:	c3                   	ret    
  n = 0;
 1d8:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 1dd:	eb f4                	jmp    1d3 <atoi+0x33>

000001df <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 1df:	f3 0f 1e fb          	endbr32 
 1e3:	55                   	push   %ebp
 1e4:	89 e5                	mov    %esp,%ebp
 1e6:	56                   	push   %esi
 1e7:	53                   	push   %ebx
 1e8:	8b 75 08             	mov    0x8(%ebp),%esi
 1eb:	8b 55 0c             	mov    0xc(%ebp),%edx
 1ee:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 1f1:	85 db                	test   %ebx,%ebx
 1f3:	7e 15                	jle    20a <memmove+0x2b>
 1f5:	01 f3                	add    %esi,%ebx
  dst = vdst;
 1f7:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 1f9:	83 c2 01             	add    $0x1,%edx
 1fc:	83 c0 01             	add    $0x1,%eax
 1ff:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 203:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 206:	39 c3                	cmp    %eax,%ebx
 208:	75 ef                	jne    1f9 <memmove+0x1a>
  return vdst;
}
 20a:	89 f0                	mov    %esi,%eax
 20c:	5b                   	pop    %ebx
 20d:	5e                   	pop    %esi
 20e:	5d                   	pop    %ebp
 20f:	c3                   	ret    

00000210 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 210:	b8 01 00 00 00       	mov    $0x1,%eax
 215:	cd 40                	int    $0x40
 217:	c3                   	ret    

00000218 <exit>:
SYSCALL(exit)
 218:	b8 02 00 00 00       	mov    $0x2,%eax
 21d:	cd 40                	int    $0x40
 21f:	c3                   	ret    

00000220 <wait>:
SYSCALL(wait)
 220:	b8 03 00 00 00       	mov    $0x3,%eax
 225:	cd 40                	int    $0x40
 227:	c3                   	ret    

00000228 <pipe>:
SYSCALL(pipe)
 228:	b8 04 00 00 00       	mov    $0x4,%eax
 22d:	cd 40                	int    $0x40
 22f:	c3                   	ret    

00000230 <read>:
SYSCALL(read)
 230:	b8 05 00 00 00       	mov    $0x5,%eax
 235:	cd 40                	int    $0x40
 237:	c3                   	ret    

00000238 <write>:
SYSCALL(write)
 238:	b8 10 00 00 00       	mov    $0x10,%eax
 23d:	cd 40                	int    $0x40
 23f:	c3                   	ret    

00000240 <close>:
SYSCALL(close)
 240:	b8 15 00 00 00       	mov    $0x15,%eax
 245:	cd 40                	int    $0x40
 247:	c3                   	ret    

00000248 <kill>:
SYSCALL(kill)
 248:	b8 06 00 00 00       	mov    $0x6,%eax
 24d:	cd 40                	int    $0x40
 24f:	c3                   	ret    

00000250 <exec>:
SYSCALL(exec)
 250:	b8 07 00 00 00       	mov    $0x7,%eax
 255:	cd 40                	int    $0x40
 257:	c3                   	ret    

00000258 <open>:
SYSCALL(open)
 258:	b8 0f 00 00 00       	mov    $0xf,%eax
 25d:	cd 40                	int    $0x40
 25f:	c3                   	ret    

00000260 <mknod>:
SYSCALL(mknod)
 260:	b8 11 00 00 00       	mov    $0x11,%eax
 265:	cd 40                	int    $0x40
 267:	c3                   	ret    

00000268 <unlink>:
SYSCALL(unlink)
 268:	b8 12 00 00 00       	mov    $0x12,%eax
 26d:	cd 40                	int    $0x40
 26f:	c3                   	ret    

00000270 <fstat>:
SYSCALL(fstat)
 270:	b8 08 00 00 00       	mov    $0x8,%eax
 275:	cd 40                	int    $0x40
 277:	c3                   	ret    

00000278 <link>:
SYSCALL(link)
 278:	b8 13 00 00 00       	mov    $0x13,%eax
 27d:	cd 40                	int    $0x40
 27f:	c3                   	ret    

00000280 <mkdir>:
SYSCALL(mkdir)
 280:	b8 14 00 00 00       	mov    $0x14,%eax
 285:	cd 40                	int    $0x40
 287:	c3                   	ret    

00000288 <chdir>:
SYSCALL(chdir)
 288:	b8 09 00 00 00       	mov    $0x9,%eax
 28d:	cd 40                	int    $0x40
 28f:	c3                   	ret    

00000290 <dup>:
SYSCALL(dup)
 290:	b8 0a 00 00 00       	mov    $0xa,%eax
 295:	cd 40                	int    $0x40
 297:	c3                   	ret    

00000298 <getpid>:
SYSCALL(getpid)
 298:	b8 0b 00 00 00       	mov    $0xb,%eax
 29d:	cd 40                	int    $0x40
 29f:	c3                   	ret    

000002a0 <sbrk>:
SYSCALL(sbrk)
 2a0:	b8 0c 00 00 00       	mov    $0xc,%eax
 2a5:	cd 40                	int    $0x40
 2a7:	c3                   	ret    

000002a8 <sleep>:
SYSCALL(sleep)
 2a8:	b8 0d 00 00 00       	mov    $0xd,%eax
 2ad:	cd 40                	int    $0x40
 2af:	c3                   	ret    

000002b0 <uptime>:
SYSCALL(uptime)
 2b0:	b8 0e 00 00 00       	mov    $0xe,%eax
 2b5:	cd 40                	int    $0x40
 2b7:	c3                   	ret    

000002b8 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2b8:	55                   	push   %ebp
 2b9:	89 e5                	mov    %esp,%ebp
 2bb:	57                   	push   %edi
 2bc:	56                   	push   %esi
 2bd:	53                   	push   %ebx
 2be:	83 ec 3c             	sub    $0x3c,%esp
 2c1:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 2c4:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2c6:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2ca:	74 77                	je     343 <printint+0x8b>
 2cc:	85 d2                	test   %edx,%edx
 2ce:	79 73                	jns    343 <printint+0x8b>
    neg = 1;
    x = -xx;
 2d0:	f7 db                	neg    %ebx
    neg = 1;
 2d2:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 2d9:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 2de:	89 f7                	mov    %esi,%edi
 2e0:	83 c6 01             	add    $0x1,%esi
 2e3:	89 d8                	mov    %ebx,%eax
 2e5:	ba 00 00 00 00       	mov    $0x0,%edx
 2ea:	f7 f1                	div    %ecx
 2ec:	0f b6 92 6c 06 00 00 	movzbl 0x66c(%edx),%edx
 2f3:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 2f7:	89 da                	mov    %ebx,%edx
 2f9:	89 c3                	mov    %eax,%ebx
 2fb:	39 d1                	cmp    %edx,%ecx
 2fd:	76 df                	jbe    2de <printint+0x26>
  if(neg)
 2ff:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 303:	74 08                	je     30d <printint+0x55>
    buf[i++] = '-';
 305:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 30a:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 30d:	85 f6                	test   %esi,%esi
 30f:	7e 2a                	jle    33b <printint+0x83>
 311:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 315:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 318:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 31b:	0f b6 03             	movzbl (%ebx),%eax
 31e:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 321:	83 ec 04             	sub    $0x4,%esp
 324:	6a 01                	push   $0x1
 326:	56                   	push   %esi
 327:	ff 75 c4             	pushl  -0x3c(%ebp)
 32a:	e8 09 ff ff ff       	call   238 <write>
  while(--i >= 0)
 32f:	89 d8                	mov    %ebx,%eax
 331:	83 eb 01             	sub    $0x1,%ebx
 334:	83 c4 10             	add    $0x10,%esp
 337:	39 f8                	cmp    %edi,%eax
 339:	75 e0                	jne    31b <printint+0x63>
}
 33b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 33e:	5b                   	pop    %ebx
 33f:	5e                   	pop    %esi
 340:	5f                   	pop    %edi
 341:	5d                   	pop    %ebp
 342:	c3                   	ret    
  neg = 0;
 343:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 34a:	eb 8d                	jmp    2d9 <printint+0x21>

0000034c <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 34c:	f3 0f 1e fb          	endbr32 
 350:	55                   	push   %ebp
 351:	89 e5                	mov    %esp,%ebp
 353:	57                   	push   %edi
 354:	56                   	push   %esi
 355:	53                   	push   %ebx
 356:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 359:	8b 75 0c             	mov    0xc(%ebp),%esi
 35c:	0f b6 1e             	movzbl (%esi),%ebx
 35f:	84 db                	test   %bl,%bl
 361:	0f 84 ab 01 00 00    	je     512 <printf+0x1c6>
 367:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 36a:	8d 45 10             	lea    0x10(%ebp),%eax
 36d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 370:	bf 00 00 00 00       	mov    $0x0,%edi
 375:	eb 2d                	jmp    3a4 <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 377:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 37a:	83 ec 04             	sub    $0x4,%esp
 37d:	6a 01                	push   $0x1
 37f:	8d 45 e7             	lea    -0x19(%ebp),%eax
 382:	50                   	push   %eax
 383:	ff 75 08             	pushl  0x8(%ebp)
 386:	e8 ad fe ff ff       	call   238 <write>
        putc(fd, c);
 38b:	83 c4 10             	add    $0x10,%esp
 38e:	eb 05                	jmp    395 <printf+0x49>
      }
    } else if(state == '%'){
 390:	83 ff 25             	cmp    $0x25,%edi
 393:	74 22                	je     3b7 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 395:	83 c6 01             	add    $0x1,%esi
 398:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 39c:	84 db                	test   %bl,%bl
 39e:	0f 84 6e 01 00 00    	je     512 <printf+0x1c6>
    c = fmt[i] & 0xff;
 3a4:	0f be d3             	movsbl %bl,%edx
 3a7:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3aa:	85 ff                	test   %edi,%edi
 3ac:	75 e2                	jne    390 <printf+0x44>
      if(c == '%'){
 3ae:	83 f8 25             	cmp    $0x25,%eax
 3b1:	75 c4                	jne    377 <printf+0x2b>
        state = '%';
 3b3:	89 c7                	mov    %eax,%edi
 3b5:	eb de                	jmp    395 <printf+0x49>
      if(c == 'd'){
 3b7:	83 f8 64             	cmp    $0x64,%eax
 3ba:	74 59                	je     415 <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3bc:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3c2:	83 fa 70             	cmp    $0x70,%edx
 3c5:	74 7a                	je     441 <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3c7:	83 f8 73             	cmp    $0x73,%eax
 3ca:	0f 84 9d 00 00 00    	je     46d <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3d0:	83 f8 63             	cmp    $0x63,%eax
 3d3:	0f 84 ec 00 00 00    	je     4c5 <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 3d9:	83 f8 25             	cmp    $0x25,%eax
 3dc:	0f 84 0f 01 00 00    	je     4f1 <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 3e2:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 3e6:	83 ec 04             	sub    $0x4,%esp
 3e9:	6a 01                	push   $0x1
 3eb:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3ee:	50                   	push   %eax
 3ef:	ff 75 08             	pushl  0x8(%ebp)
 3f2:	e8 41 fe ff ff       	call   238 <write>
        putc(fd, c);
 3f7:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 3fa:	83 c4 0c             	add    $0xc,%esp
 3fd:	6a 01                	push   $0x1
 3ff:	8d 45 e7             	lea    -0x19(%ebp),%eax
 402:	50                   	push   %eax
 403:	ff 75 08             	pushl  0x8(%ebp)
 406:	e8 2d fe ff ff       	call   238 <write>
        putc(fd, c);
 40b:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 40e:	bf 00 00 00 00       	mov    $0x0,%edi
 413:	eb 80                	jmp    395 <printf+0x49>
        printint(fd, *ap, 10, 1);
 415:	83 ec 0c             	sub    $0xc,%esp
 418:	6a 01                	push   $0x1
 41a:	b9 0a 00 00 00       	mov    $0xa,%ecx
 41f:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 422:	8b 17                	mov    (%edi),%edx
 424:	8b 45 08             	mov    0x8(%ebp),%eax
 427:	e8 8c fe ff ff       	call   2b8 <printint>
        ap++;
 42c:	89 f8                	mov    %edi,%eax
 42e:	83 c0 04             	add    $0x4,%eax
 431:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 434:	83 c4 10             	add    $0x10,%esp
      state = 0;
 437:	bf 00 00 00 00       	mov    $0x0,%edi
 43c:	e9 54 ff ff ff       	jmp    395 <printf+0x49>
        printint(fd, *ap, 16, 0);
 441:	83 ec 0c             	sub    $0xc,%esp
 444:	6a 00                	push   $0x0
 446:	b9 10 00 00 00       	mov    $0x10,%ecx
 44b:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 44e:	8b 17                	mov    (%edi),%edx
 450:	8b 45 08             	mov    0x8(%ebp),%eax
 453:	e8 60 fe ff ff       	call   2b8 <printint>
        ap++;
 458:	89 f8                	mov    %edi,%eax
 45a:	83 c0 04             	add    $0x4,%eax
 45d:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 460:	83 c4 10             	add    $0x10,%esp
      state = 0;
 463:	bf 00 00 00 00       	mov    $0x0,%edi
 468:	e9 28 ff ff ff       	jmp    395 <printf+0x49>
        s = (char*)*ap;
 46d:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 470:	8b 01                	mov    (%ecx),%eax
        ap++;
 472:	83 c1 04             	add    $0x4,%ecx
 475:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 478:	85 c0                	test   %eax,%eax
 47a:	74 13                	je     48f <printf+0x143>
        s = (char*)*ap;
 47c:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 47e:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 481:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 486:	84 c0                	test   %al,%al
 488:	75 0f                	jne    499 <printf+0x14d>
 48a:	e9 06 ff ff ff       	jmp    395 <printf+0x49>
          s = "(null)";
 48f:	bb 64 06 00 00       	mov    $0x664,%ebx
        while(*s != 0){
 494:	b8 28 00 00 00       	mov    $0x28,%eax
 499:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 49c:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 49f:	83 ec 04             	sub    $0x4,%esp
 4a2:	6a 01                	push   $0x1
 4a4:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4a7:	50                   	push   %eax
 4a8:	57                   	push   %edi
 4a9:	e8 8a fd ff ff       	call   238 <write>
          s++;
 4ae:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4b1:	0f b6 03             	movzbl (%ebx),%eax
 4b4:	83 c4 10             	add    $0x10,%esp
 4b7:	84 c0                	test   %al,%al
 4b9:	75 e1                	jne    49c <printf+0x150>
      state = 0;
 4bb:	bf 00 00 00 00       	mov    $0x0,%edi
 4c0:	e9 d0 fe ff ff       	jmp    395 <printf+0x49>
        putc(fd, *ap);
 4c5:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4c8:	8b 07                	mov    (%edi),%eax
 4ca:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4cd:	83 ec 04             	sub    $0x4,%esp
 4d0:	6a 01                	push   $0x1
 4d2:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d5:	50                   	push   %eax
 4d6:	ff 75 08             	pushl  0x8(%ebp)
 4d9:	e8 5a fd ff ff       	call   238 <write>
        ap++;
 4de:	83 c7 04             	add    $0x4,%edi
 4e1:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 4e4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 4e7:	bf 00 00 00 00       	mov    $0x0,%edi
 4ec:	e9 a4 fe ff ff       	jmp    395 <printf+0x49>
        putc(fd, c);
 4f1:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4f4:	83 ec 04             	sub    $0x4,%esp
 4f7:	6a 01                	push   $0x1
 4f9:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4fc:	50                   	push   %eax
 4fd:	ff 75 08             	pushl  0x8(%ebp)
 500:	e8 33 fd ff ff       	call   238 <write>
 505:	83 c4 10             	add    $0x10,%esp
      state = 0;
 508:	bf 00 00 00 00       	mov    $0x0,%edi
 50d:	e9 83 fe ff ff       	jmp    395 <printf+0x49>
    }
  }
}
 512:	8d 65 f4             	lea    -0xc(%ebp),%esp
 515:	5b                   	pop    %ebx
 516:	5e                   	pop    %esi
 517:	5f                   	pop    %edi
 518:	5d                   	pop    %ebp
 519:	c3                   	ret    

0000051a <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 51a:	f3 0f 1e fb          	endbr32 
 51e:	55                   	push   %ebp
 51f:	89 e5                	mov    %esp,%ebp
 521:	57                   	push   %edi
 522:	56                   	push   %esi
 523:	53                   	push   %ebx
 524:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 527:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 52a:	a1 d4 08 00 00       	mov    0x8d4,%eax
 52f:	eb 0c                	jmp    53d <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 531:	8b 10                	mov    (%eax),%edx
 533:	39 c2                	cmp    %eax,%edx
 535:	77 04                	ja     53b <free+0x21>
 537:	39 ca                	cmp    %ecx,%edx
 539:	77 10                	ja     54b <free+0x31>
{
 53b:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 53d:	39 c8                	cmp    %ecx,%eax
 53f:	73 f0                	jae    531 <free+0x17>
 541:	8b 10                	mov    (%eax),%edx
 543:	39 ca                	cmp    %ecx,%edx
 545:	77 04                	ja     54b <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 547:	39 c2                	cmp    %eax,%edx
 549:	77 f0                	ja     53b <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 54b:	8b 73 fc             	mov    -0x4(%ebx),%esi
 54e:	8b 10                	mov    (%eax),%edx
 550:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 553:	39 fa                	cmp    %edi,%edx
 555:	74 19                	je     570 <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 557:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 55a:	8b 50 04             	mov    0x4(%eax),%edx
 55d:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 560:	39 f1                	cmp    %esi,%ecx
 562:	74 1b                	je     57f <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 564:	89 08                	mov    %ecx,(%eax)
  freep = p;
 566:	a3 d4 08 00 00       	mov    %eax,0x8d4
}
 56b:	5b                   	pop    %ebx
 56c:	5e                   	pop    %esi
 56d:	5f                   	pop    %edi
 56e:	5d                   	pop    %ebp
 56f:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 570:	03 72 04             	add    0x4(%edx),%esi
 573:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 576:	8b 10                	mov    (%eax),%edx
 578:	8b 12                	mov    (%edx),%edx
 57a:	89 53 f8             	mov    %edx,-0x8(%ebx)
 57d:	eb db                	jmp    55a <free+0x40>
    p->s.size += bp->s.size;
 57f:	03 53 fc             	add    -0x4(%ebx),%edx
 582:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 585:	8b 53 f8             	mov    -0x8(%ebx),%edx
 588:	89 10                	mov    %edx,(%eax)
 58a:	eb da                	jmp    566 <free+0x4c>

0000058c <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 58c:	f3 0f 1e fb          	endbr32 
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	57                   	push   %edi
 594:	56                   	push   %esi
 595:	53                   	push   %ebx
 596:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 599:	8b 45 08             	mov    0x8(%ebp),%eax
 59c:	8d 58 07             	lea    0x7(%eax),%ebx
 59f:	c1 eb 03             	shr    $0x3,%ebx
 5a2:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5a5:	8b 15 d4 08 00 00    	mov    0x8d4,%edx
 5ab:	85 d2                	test   %edx,%edx
 5ad:	74 20                	je     5cf <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5af:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5b1:	8b 48 04             	mov    0x4(%eax),%ecx
 5b4:	39 cb                	cmp    %ecx,%ebx
 5b6:	76 3c                	jbe    5f4 <malloc+0x68>
 5b8:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5be:	be 00 10 00 00       	mov    $0x1000,%esi
 5c3:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5c6:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 5cd:	eb 72                	jmp    641 <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 5cf:	c7 05 d4 08 00 00 d8 	movl   $0x8d8,0x8d4
 5d6:	08 00 00 
 5d9:	c7 05 d8 08 00 00 d8 	movl   $0x8d8,0x8d8
 5e0:	08 00 00 
    base.s.size = 0;
 5e3:	c7 05 dc 08 00 00 00 	movl   $0x0,0x8dc
 5ea:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5ed:	b8 d8 08 00 00       	mov    $0x8d8,%eax
 5f2:	eb c4                	jmp    5b8 <malloc+0x2c>
      if(p->s.size == nunits)
 5f4:	39 cb                	cmp    %ecx,%ebx
 5f6:	74 1e                	je     616 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 5f8:	29 d9                	sub    %ebx,%ecx
 5fa:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 5fd:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 600:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 603:	89 15 d4 08 00 00    	mov    %edx,0x8d4
      return (void*)(p + 1);
 609:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 60c:	89 d0                	mov    %edx,%eax
 60e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 611:	5b                   	pop    %ebx
 612:	5e                   	pop    %esi
 613:	5f                   	pop    %edi
 614:	5d                   	pop    %ebp
 615:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 616:	8b 08                	mov    (%eax),%ecx
 618:	89 0a                	mov    %ecx,(%edx)
 61a:	eb e7                	jmp    603 <malloc+0x77>
  hp->s.size = nu;
 61c:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 61f:	83 ec 0c             	sub    $0xc,%esp
 622:	83 c0 08             	add    $0x8,%eax
 625:	50                   	push   %eax
 626:	e8 ef fe ff ff       	call   51a <free>
  return freep;
 62b:	8b 15 d4 08 00 00    	mov    0x8d4,%edx
      if((p = morecore(nunits)) == 0)
 631:	83 c4 10             	add    $0x10,%esp
 634:	85 d2                	test   %edx,%edx
 636:	74 d4                	je     60c <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 638:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 63a:	8b 48 04             	mov    0x4(%eax),%ecx
 63d:	39 d9                	cmp    %ebx,%ecx
 63f:	73 b3                	jae    5f4 <malloc+0x68>
    if(p == freep)
 641:	89 c2                	mov    %eax,%edx
 643:	39 05 d4 08 00 00    	cmp    %eax,0x8d4
 649:	75 ed                	jne    638 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 64b:	83 ec 0c             	sub    $0xc,%esp
 64e:	57                   	push   %edi
 64f:	e8 4c fc ff ff       	call   2a0 <sbrk>
  if(p == (char*)-1)
 654:	83 c4 10             	add    $0x10,%esp
 657:	83 f8 ff             	cmp    $0xffffffff,%eax
 65a:	75 c0                	jne    61c <malloc+0x90>
        return 0;
 65c:	ba 00 00 00 00       	mov    $0x0,%edx
 661:	eb a9                	jmp    60c <malloc+0x80>
