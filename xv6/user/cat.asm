
_cat:     file format elf32-i386


Disassembly of section .text:

00000000 <cat>:

char buf[512];

void
cat(int fd)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	56                   	push   %esi
   8:	53                   	push   %ebx
   9:	8b 75 08             	mov    0x8(%ebp),%esi
  int n;

  while((n = read(fd, buf, sizeof(buf))) > 0) {
   c:	83 ec 04             	sub    $0x4,%esp
   f:	68 00 02 00 00       	push   $0x200
  14:	68 40 0a 00 00       	push   $0xa40
  19:	56                   	push   %esi
  1a:	e8 e0 02 00 00       	call   2ff <read>
  1f:	89 c3                	mov    %eax,%ebx
  21:	83 c4 10             	add    $0x10,%esp
  24:	85 c0                	test   %eax,%eax
  26:	7e 2b                	jle    53 <cat+0x53>
    if (write(1, buf, n) != n) {
  28:	83 ec 04             	sub    $0x4,%esp
  2b:	53                   	push   %ebx
  2c:	68 40 0a 00 00       	push   $0xa40
  31:	6a 01                	push   $0x1
  33:	e8 cf 02 00 00       	call   307 <write>
  38:	83 c4 10             	add    $0x10,%esp
  3b:	39 d8                	cmp    %ebx,%eax
  3d:	74 cd                	je     c <cat+0xc>
      printf(1, "cat: write error\n");
  3f:	83 ec 08             	sub    $0x8,%esp
  42:	68 34 07 00 00       	push   $0x734
  47:	6a 01                	push   $0x1
  49:	e8 cd 03 00 00       	call   41b <printf>
      exit();
  4e:	e8 94 02 00 00       	call   2e7 <exit>
    }
  }
  if(n < 0){
  53:	78 07                	js     5c <cat+0x5c>
    printf(1, "cat: read error\n");
    exit();
  }
}
  55:	8d 65 f8             	lea    -0x8(%ebp),%esp
  58:	5b                   	pop    %ebx
  59:	5e                   	pop    %esi
  5a:	5d                   	pop    %ebp
  5b:	c3                   	ret    
    printf(1, "cat: read error\n");
  5c:	83 ec 08             	sub    $0x8,%esp
  5f:	68 46 07 00 00       	push   $0x746
  64:	6a 01                	push   $0x1
  66:	e8 b0 03 00 00       	call   41b <printf>
    exit();
  6b:	e8 77 02 00 00       	call   2e7 <exit>

00000070 <main>:

int
main(int argc, char *argv[])
{
  70:	f3 0f 1e fb          	endbr32 
  74:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  78:	83 e4 f0             	and    $0xfffffff0,%esp
  7b:	ff 71 fc             	pushl  -0x4(%ecx)
  7e:	55                   	push   %ebp
  7f:	89 e5                	mov    %esp,%ebp
  81:	57                   	push   %edi
  82:	56                   	push   %esi
  83:	53                   	push   %ebx
  84:	51                   	push   %ecx
  85:	83 ec 18             	sub    $0x18,%esp
  88:	8b 01                	mov    (%ecx),%eax
  8a:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  8d:	8b 71 04             	mov    0x4(%ecx),%esi
  int fd, i;

  if(argc <= 1){
  90:	83 c6 04             	add    $0x4,%esi
    cat(0);
    exit();
  }

  for(i = 1; i < argc; i++){
  93:	bf 01 00 00 00       	mov    $0x1,%edi
  if(argc <= 1){
  98:	83 f8 01             	cmp    $0x1,%eax
  9b:	7e 3c                	jle    d9 <main+0x69>
    if((fd = open(argv[i], 0)) < 0){
  9d:	89 75 e0             	mov    %esi,-0x20(%ebp)
  a0:	83 ec 08             	sub    $0x8,%esp
  a3:	6a 00                	push   $0x0
  a5:	ff 36                	pushl  (%esi)
  a7:	e8 7b 02 00 00       	call   327 <open>
  ac:	89 c3                	mov    %eax,%ebx
  ae:	83 c4 10             	add    $0x10,%esp
  b1:	85 c0                	test   %eax,%eax
  b3:	78 33                	js     e8 <main+0x78>
      printf(1, "cat: cannot open %s\n", argv[i]);
      exit();
    }
    cat(fd);
  b5:	83 ec 0c             	sub    $0xc,%esp
  b8:	50                   	push   %eax
  b9:	e8 42 ff ff ff       	call   0 <cat>
    close(fd);
  be:	89 1c 24             	mov    %ebx,(%esp)
  c1:	e8 49 02 00 00       	call   30f <close>
  for(i = 1; i < argc; i++){
  c6:	83 c7 01             	add    $0x1,%edi
  c9:	83 c6 04             	add    $0x4,%esi
  cc:	83 c4 10             	add    $0x10,%esp
  cf:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
  d2:	75 c9                	jne    9d <main+0x2d>
  }
  exit();
  d4:	e8 0e 02 00 00       	call   2e7 <exit>
    cat(0);
  d9:	83 ec 0c             	sub    $0xc,%esp
  dc:	6a 00                	push   $0x0
  de:	e8 1d ff ff ff       	call   0 <cat>
    exit();
  e3:	e8 ff 01 00 00       	call   2e7 <exit>
      printf(1, "cat: cannot open %s\n", argv[i]);
  e8:	83 ec 04             	sub    $0x4,%esp
  eb:	8b 45 e0             	mov    -0x20(%ebp),%eax
  ee:	ff 30                	pushl  (%eax)
  f0:	68 57 07 00 00       	push   $0x757
  f5:	6a 01                	push   $0x1
  f7:	e8 1f 03 00 00       	call   41b <printf>
      exit();
  fc:	e8 e6 01 00 00       	call   2e7 <exit>

00000101 <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 101:	f3 0f 1e fb          	endbr32 
 105:	55                   	push   %ebp
 106:	89 e5                	mov    %esp,%ebp
 108:	53                   	push   %ebx
 109:	8b 4d 08             	mov    0x8(%ebp),%ecx
 10c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 10f:	b8 00 00 00 00       	mov    $0x0,%eax
 114:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 118:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 11b:	83 c0 01             	add    $0x1,%eax
 11e:	84 d2                	test   %dl,%dl
 120:	75 f2                	jne    114 <strcpy+0x13>
    ;
  return os;
}
 122:	89 c8                	mov    %ecx,%eax
 124:	5b                   	pop    %ebx
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    

00000127 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 127:	f3 0f 1e fb          	endbr32 
 12b:	55                   	push   %ebp
 12c:	89 e5                	mov    %esp,%ebp
 12e:	8b 4d 08             	mov    0x8(%ebp),%ecx
 131:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 134:	0f b6 01             	movzbl (%ecx),%eax
 137:	84 c0                	test   %al,%al
 139:	74 11                	je     14c <strcmp+0x25>
 13b:	38 02                	cmp    %al,(%edx)
 13d:	75 0d                	jne    14c <strcmp+0x25>
    p++, q++;
 13f:	83 c1 01             	add    $0x1,%ecx
 142:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 145:	0f b6 01             	movzbl (%ecx),%eax
 148:	84 c0                	test   %al,%al
 14a:	75 ef                	jne    13b <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 14c:	0f b6 c0             	movzbl %al,%eax
 14f:	0f b6 12             	movzbl (%edx),%edx
 152:	29 d0                	sub    %edx,%eax
}
 154:	5d                   	pop    %ebp
 155:	c3                   	ret    

00000156 <strlen>:

uint
strlen(char *s)
{
 156:	f3 0f 1e fb          	endbr32 
 15a:	55                   	push   %ebp
 15b:	89 e5                	mov    %esp,%ebp
 15d:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 160:	80 3a 00             	cmpb   $0x0,(%edx)
 163:	74 14                	je     179 <strlen+0x23>
 165:	b8 00 00 00 00       	mov    $0x0,%eax
 16a:	83 c0 01             	add    $0x1,%eax
 16d:	89 c1                	mov    %eax,%ecx
 16f:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 173:	75 f5                	jne    16a <strlen+0x14>
    ;
  return n;
}
 175:	89 c8                	mov    %ecx,%eax
 177:	5d                   	pop    %ebp
 178:	c3                   	ret    
  for(n = 0; s[n]; n++)
 179:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 17e:	eb f5                	jmp    175 <strlen+0x1f>

00000180 <memset>:

void*
memset(void *dst, int c, uint n)
{
 180:	f3 0f 1e fb          	endbr32 
 184:	55                   	push   %ebp
 185:	89 e5                	mov    %esp,%ebp
 187:	57                   	push   %edi
 188:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 18b:	89 d7                	mov    %edx,%edi
 18d:	8b 4d 10             	mov    0x10(%ebp),%ecx
 190:	8b 45 0c             	mov    0xc(%ebp),%eax
 193:	fc                   	cld    
 194:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 196:	89 d0                	mov    %edx,%eax
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    

0000019b <strchr>:

char*
strchr(const char *s, char c)
{
 19b:	f3 0f 1e fb          	endbr32 
 19f:	55                   	push   %ebp
 1a0:	89 e5                	mov    %esp,%ebp
 1a2:	8b 45 08             	mov    0x8(%ebp),%eax
 1a5:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1a9:	0f b6 10             	movzbl (%eax),%edx
 1ac:	84 d2                	test   %dl,%dl
 1ae:	74 15                	je     1c5 <strchr+0x2a>
    if(*s == c)
 1b0:	38 d1                	cmp    %dl,%cl
 1b2:	74 0f                	je     1c3 <strchr+0x28>
  for(; *s; s++)
 1b4:	83 c0 01             	add    $0x1,%eax
 1b7:	0f b6 10             	movzbl (%eax),%edx
 1ba:	84 d2                	test   %dl,%dl
 1bc:	75 f2                	jne    1b0 <strchr+0x15>
      return (char*)s;
  return 0;
 1be:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1c3:	5d                   	pop    %ebp
 1c4:	c3                   	ret    
  return 0;
 1c5:	b8 00 00 00 00       	mov    $0x0,%eax
 1ca:	eb f7                	jmp    1c3 <strchr+0x28>

000001cc <gets>:

char*
gets(char *buf, int max)
{
 1cc:	f3 0f 1e fb          	endbr32 
 1d0:	55                   	push   %ebp
 1d1:	89 e5                	mov    %esp,%ebp
 1d3:	57                   	push   %edi
 1d4:	56                   	push   %esi
 1d5:	53                   	push   %ebx
 1d6:	83 ec 2c             	sub    $0x2c,%esp
 1d9:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1dc:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 1e1:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1e4:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1e7:	83 c3 01             	add    $0x1,%ebx
 1ea:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1ed:	7d 27                	jge    216 <gets+0x4a>
    cc = read(0, &c, 1);
 1ef:	83 ec 04             	sub    $0x4,%esp
 1f2:	6a 01                	push   $0x1
 1f4:	57                   	push   %edi
 1f5:	6a 00                	push   $0x0
 1f7:	e8 03 01 00 00       	call   2ff <read>
    if(cc < 1)
 1fc:	83 c4 10             	add    $0x10,%esp
 1ff:	85 c0                	test   %eax,%eax
 201:	7e 13                	jle    216 <gets+0x4a>
      break;
    buf[i++] = c;
 203:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 207:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 20b:	3c 0a                	cmp    $0xa,%al
 20d:	74 04                	je     213 <gets+0x47>
 20f:	3c 0d                	cmp    $0xd,%al
 211:	75 d1                	jne    1e4 <gets+0x18>
  for(i=0; i+1 < max; ){
 213:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 216:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 219:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 21d:	89 f0                	mov    %esi,%eax
 21f:	8d 65 f4             	lea    -0xc(%ebp),%esp
 222:	5b                   	pop    %ebx
 223:	5e                   	pop    %esi
 224:	5f                   	pop    %edi
 225:	5d                   	pop    %ebp
 226:	c3                   	ret    

00000227 <stat>:

int
stat(char *n, struct stat *st)
{
 227:	f3 0f 1e fb          	endbr32 
 22b:	55                   	push   %ebp
 22c:	89 e5                	mov    %esp,%ebp
 22e:	56                   	push   %esi
 22f:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 230:	83 ec 08             	sub    $0x8,%esp
 233:	6a 00                	push   $0x0
 235:	ff 75 08             	pushl  0x8(%ebp)
 238:	e8 ea 00 00 00       	call   327 <open>
  if(fd < 0)
 23d:	83 c4 10             	add    $0x10,%esp
 240:	85 c0                	test   %eax,%eax
 242:	78 24                	js     268 <stat+0x41>
 244:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 246:	83 ec 08             	sub    $0x8,%esp
 249:	ff 75 0c             	pushl  0xc(%ebp)
 24c:	50                   	push   %eax
 24d:	e8 ed 00 00 00       	call   33f <fstat>
 252:	89 c6                	mov    %eax,%esi
  close(fd);
 254:	89 1c 24             	mov    %ebx,(%esp)
 257:	e8 b3 00 00 00       	call   30f <close>
  return r;
 25c:	83 c4 10             	add    $0x10,%esp
}
 25f:	89 f0                	mov    %esi,%eax
 261:	8d 65 f8             	lea    -0x8(%ebp),%esp
 264:	5b                   	pop    %ebx
 265:	5e                   	pop    %esi
 266:	5d                   	pop    %ebp
 267:	c3                   	ret    
    return -1;
 268:	be ff ff ff ff       	mov    $0xffffffff,%esi
 26d:	eb f0                	jmp    25f <stat+0x38>

0000026f <atoi>:

int
atoi(const char *s)
{
 26f:	f3 0f 1e fb          	endbr32 
 273:	55                   	push   %ebp
 274:	89 e5                	mov    %esp,%ebp
 276:	53                   	push   %ebx
 277:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 27a:	0f b6 02             	movzbl (%edx),%eax
 27d:	8d 48 d0             	lea    -0x30(%eax),%ecx
 280:	80 f9 09             	cmp    $0x9,%cl
 283:	77 22                	ja     2a7 <atoi+0x38>
  n = 0;
 285:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 28a:	83 c2 01             	add    $0x1,%edx
 28d:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 290:	0f be c0             	movsbl %al,%eax
 293:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 297:	0f b6 02             	movzbl (%edx),%eax
 29a:	8d 58 d0             	lea    -0x30(%eax),%ebx
 29d:	80 fb 09             	cmp    $0x9,%bl
 2a0:	76 e8                	jbe    28a <atoi+0x1b>
  return n;
}
 2a2:	89 c8                	mov    %ecx,%eax
 2a4:	5b                   	pop    %ebx
 2a5:	5d                   	pop    %ebp
 2a6:	c3                   	ret    
  n = 0;
 2a7:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 2ac:	eb f4                	jmp    2a2 <atoi+0x33>

000002ae <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2ae:	f3 0f 1e fb          	endbr32 
 2b2:	55                   	push   %ebp
 2b3:	89 e5                	mov    %esp,%ebp
 2b5:	56                   	push   %esi
 2b6:	53                   	push   %ebx
 2b7:	8b 75 08             	mov    0x8(%ebp),%esi
 2ba:	8b 55 0c             	mov    0xc(%ebp),%edx
 2bd:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2c0:	85 db                	test   %ebx,%ebx
 2c2:	7e 15                	jle    2d9 <memmove+0x2b>
 2c4:	01 f3                	add    %esi,%ebx
  dst = vdst;
 2c6:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 2c8:	83 c2 01             	add    $0x1,%edx
 2cb:	83 c0 01             	add    $0x1,%eax
 2ce:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 2d2:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 2d5:	39 c3                	cmp    %eax,%ebx
 2d7:	75 ef                	jne    2c8 <memmove+0x1a>
  return vdst;
}
 2d9:	89 f0                	mov    %esi,%eax
 2db:	5b                   	pop    %ebx
 2dc:	5e                   	pop    %esi
 2dd:	5d                   	pop    %ebp
 2de:	c3                   	ret    

000002df <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2df:	b8 01 00 00 00       	mov    $0x1,%eax
 2e4:	cd 40                	int    $0x40
 2e6:	c3                   	ret    

000002e7 <exit>:
SYSCALL(exit)
 2e7:	b8 02 00 00 00       	mov    $0x2,%eax
 2ec:	cd 40                	int    $0x40
 2ee:	c3                   	ret    

000002ef <wait>:
SYSCALL(wait)
 2ef:	b8 03 00 00 00       	mov    $0x3,%eax
 2f4:	cd 40                	int    $0x40
 2f6:	c3                   	ret    

000002f7 <pipe>:
SYSCALL(pipe)
 2f7:	b8 04 00 00 00       	mov    $0x4,%eax
 2fc:	cd 40                	int    $0x40
 2fe:	c3                   	ret    

000002ff <read>:
SYSCALL(read)
 2ff:	b8 05 00 00 00       	mov    $0x5,%eax
 304:	cd 40                	int    $0x40
 306:	c3                   	ret    

00000307 <write>:
SYSCALL(write)
 307:	b8 10 00 00 00       	mov    $0x10,%eax
 30c:	cd 40                	int    $0x40
 30e:	c3                   	ret    

0000030f <close>:
SYSCALL(close)
 30f:	b8 15 00 00 00       	mov    $0x15,%eax
 314:	cd 40                	int    $0x40
 316:	c3                   	ret    

00000317 <kill>:
SYSCALL(kill)
 317:	b8 06 00 00 00       	mov    $0x6,%eax
 31c:	cd 40                	int    $0x40
 31e:	c3                   	ret    

0000031f <exec>:
SYSCALL(exec)
 31f:	b8 07 00 00 00       	mov    $0x7,%eax
 324:	cd 40                	int    $0x40
 326:	c3                   	ret    

00000327 <open>:
SYSCALL(open)
 327:	b8 0f 00 00 00       	mov    $0xf,%eax
 32c:	cd 40                	int    $0x40
 32e:	c3                   	ret    

0000032f <mknod>:
SYSCALL(mknod)
 32f:	b8 11 00 00 00       	mov    $0x11,%eax
 334:	cd 40                	int    $0x40
 336:	c3                   	ret    

00000337 <unlink>:
SYSCALL(unlink)
 337:	b8 12 00 00 00       	mov    $0x12,%eax
 33c:	cd 40                	int    $0x40
 33e:	c3                   	ret    

0000033f <fstat>:
SYSCALL(fstat)
 33f:	b8 08 00 00 00       	mov    $0x8,%eax
 344:	cd 40                	int    $0x40
 346:	c3                   	ret    

00000347 <link>:
SYSCALL(link)
 347:	b8 13 00 00 00       	mov    $0x13,%eax
 34c:	cd 40                	int    $0x40
 34e:	c3                   	ret    

0000034f <mkdir>:
SYSCALL(mkdir)
 34f:	b8 14 00 00 00       	mov    $0x14,%eax
 354:	cd 40                	int    $0x40
 356:	c3                   	ret    

00000357 <chdir>:
SYSCALL(chdir)
 357:	b8 09 00 00 00       	mov    $0x9,%eax
 35c:	cd 40                	int    $0x40
 35e:	c3                   	ret    

0000035f <dup>:
SYSCALL(dup)
 35f:	b8 0a 00 00 00       	mov    $0xa,%eax
 364:	cd 40                	int    $0x40
 366:	c3                   	ret    

00000367 <getpid>:
SYSCALL(getpid)
 367:	b8 0b 00 00 00       	mov    $0xb,%eax
 36c:	cd 40                	int    $0x40
 36e:	c3                   	ret    

0000036f <sbrk>:
SYSCALL(sbrk)
 36f:	b8 0c 00 00 00       	mov    $0xc,%eax
 374:	cd 40                	int    $0x40
 376:	c3                   	ret    

00000377 <sleep>:
SYSCALL(sleep)
 377:	b8 0d 00 00 00       	mov    $0xd,%eax
 37c:	cd 40                	int    $0x40
 37e:	c3                   	ret    

0000037f <uptime>:
SYSCALL(uptime)
 37f:	b8 0e 00 00 00       	mov    $0xe,%eax
 384:	cd 40                	int    $0x40
 386:	c3                   	ret    

00000387 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 387:	55                   	push   %ebp
 388:	89 e5                	mov    %esp,%ebp
 38a:	57                   	push   %edi
 38b:	56                   	push   %esi
 38c:	53                   	push   %ebx
 38d:	83 ec 3c             	sub    $0x3c,%esp
 390:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 393:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 395:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 399:	74 77                	je     412 <printint+0x8b>
 39b:	85 d2                	test   %edx,%edx
 39d:	79 73                	jns    412 <printint+0x8b>
    neg = 1;
    x = -xx;
 39f:	f7 db                	neg    %ebx
    neg = 1;
 3a1:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3a8:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 3ad:	89 f7                	mov    %esi,%edi
 3af:	83 c6 01             	add    $0x1,%esi
 3b2:	89 d8                	mov    %ebx,%eax
 3b4:	ba 00 00 00 00       	mov    $0x0,%edx
 3b9:	f7 f1                	div    %ecx
 3bb:	0f b6 92 74 07 00 00 	movzbl 0x774(%edx),%edx
 3c2:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3c6:	89 da                	mov    %ebx,%edx
 3c8:	89 c3                	mov    %eax,%ebx
 3ca:	39 d1                	cmp    %edx,%ecx
 3cc:	76 df                	jbe    3ad <printint+0x26>
  if(neg)
 3ce:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 3d2:	74 08                	je     3dc <printint+0x55>
    buf[i++] = '-';
 3d4:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3d9:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 3dc:	85 f6                	test   %esi,%esi
 3de:	7e 2a                	jle    40a <printint+0x83>
 3e0:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 3e4:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 3e7:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 3ea:	0f b6 03             	movzbl (%ebx),%eax
 3ed:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 3f0:	83 ec 04             	sub    $0x4,%esp
 3f3:	6a 01                	push   $0x1
 3f5:	56                   	push   %esi
 3f6:	ff 75 c4             	pushl  -0x3c(%ebp)
 3f9:	e8 09 ff ff ff       	call   307 <write>
  while(--i >= 0)
 3fe:	89 d8                	mov    %ebx,%eax
 400:	83 eb 01             	sub    $0x1,%ebx
 403:	83 c4 10             	add    $0x10,%esp
 406:	39 f8                	cmp    %edi,%eax
 408:	75 e0                	jne    3ea <printint+0x63>
}
 40a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 40d:	5b                   	pop    %ebx
 40e:	5e                   	pop    %esi
 40f:	5f                   	pop    %edi
 410:	5d                   	pop    %ebp
 411:	c3                   	ret    
  neg = 0;
 412:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 419:	eb 8d                	jmp    3a8 <printint+0x21>

0000041b <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 41b:	f3 0f 1e fb          	endbr32 
 41f:	55                   	push   %ebp
 420:	89 e5                	mov    %esp,%ebp
 422:	57                   	push   %edi
 423:	56                   	push   %esi
 424:	53                   	push   %ebx
 425:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 428:	8b 75 0c             	mov    0xc(%ebp),%esi
 42b:	0f b6 1e             	movzbl (%esi),%ebx
 42e:	84 db                	test   %bl,%bl
 430:	0f 84 ab 01 00 00    	je     5e1 <printf+0x1c6>
 436:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 439:	8d 45 10             	lea    0x10(%ebp),%eax
 43c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 43f:	bf 00 00 00 00       	mov    $0x0,%edi
 444:	eb 2d                	jmp    473 <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 446:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 449:	83 ec 04             	sub    $0x4,%esp
 44c:	6a 01                	push   $0x1
 44e:	8d 45 e7             	lea    -0x19(%ebp),%eax
 451:	50                   	push   %eax
 452:	ff 75 08             	pushl  0x8(%ebp)
 455:	e8 ad fe ff ff       	call   307 <write>
        putc(fd, c);
 45a:	83 c4 10             	add    $0x10,%esp
 45d:	eb 05                	jmp    464 <printf+0x49>
      }
    } else if(state == '%'){
 45f:	83 ff 25             	cmp    $0x25,%edi
 462:	74 22                	je     486 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 464:	83 c6 01             	add    $0x1,%esi
 467:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 46b:	84 db                	test   %bl,%bl
 46d:	0f 84 6e 01 00 00    	je     5e1 <printf+0x1c6>
    c = fmt[i] & 0xff;
 473:	0f be d3             	movsbl %bl,%edx
 476:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 479:	85 ff                	test   %edi,%edi
 47b:	75 e2                	jne    45f <printf+0x44>
      if(c == '%'){
 47d:	83 f8 25             	cmp    $0x25,%eax
 480:	75 c4                	jne    446 <printf+0x2b>
        state = '%';
 482:	89 c7                	mov    %eax,%edi
 484:	eb de                	jmp    464 <printf+0x49>
      if(c == 'd'){
 486:	83 f8 64             	cmp    $0x64,%eax
 489:	74 59                	je     4e4 <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 48b:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 491:	83 fa 70             	cmp    $0x70,%edx
 494:	74 7a                	je     510 <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 496:	83 f8 73             	cmp    $0x73,%eax
 499:	0f 84 9d 00 00 00    	je     53c <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 49f:	83 f8 63             	cmp    $0x63,%eax
 4a2:	0f 84 ec 00 00 00    	je     594 <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4a8:	83 f8 25             	cmp    $0x25,%eax
 4ab:	0f 84 0f 01 00 00    	je     5c0 <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4b1:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4b5:	83 ec 04             	sub    $0x4,%esp
 4b8:	6a 01                	push   $0x1
 4ba:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4bd:	50                   	push   %eax
 4be:	ff 75 08             	pushl  0x8(%ebp)
 4c1:	e8 41 fe ff ff       	call   307 <write>
        putc(fd, c);
 4c6:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4c9:	83 c4 0c             	add    $0xc,%esp
 4cc:	6a 01                	push   $0x1
 4ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 2d fe ff ff       	call   307 <write>
        putc(fd, c);
 4da:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4dd:	bf 00 00 00 00       	mov    $0x0,%edi
 4e2:	eb 80                	jmp    464 <printf+0x49>
        printint(fd, *ap, 10, 1);
 4e4:	83 ec 0c             	sub    $0xc,%esp
 4e7:	6a 01                	push   $0x1
 4e9:	b9 0a 00 00 00       	mov    $0xa,%ecx
 4ee:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f1:	8b 17                	mov    (%edi),%edx
 4f3:	8b 45 08             	mov    0x8(%ebp),%eax
 4f6:	e8 8c fe ff ff       	call   387 <printint>
        ap++;
 4fb:	89 f8                	mov    %edi,%eax
 4fd:	83 c0 04             	add    $0x4,%eax
 500:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 503:	83 c4 10             	add    $0x10,%esp
      state = 0;
 506:	bf 00 00 00 00       	mov    $0x0,%edi
 50b:	e9 54 ff ff ff       	jmp    464 <printf+0x49>
        printint(fd, *ap, 16, 0);
 510:	83 ec 0c             	sub    $0xc,%esp
 513:	6a 00                	push   $0x0
 515:	b9 10 00 00 00       	mov    $0x10,%ecx
 51a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 51d:	8b 17                	mov    (%edi),%edx
 51f:	8b 45 08             	mov    0x8(%ebp),%eax
 522:	e8 60 fe ff ff       	call   387 <printint>
        ap++;
 527:	89 f8                	mov    %edi,%eax
 529:	83 c0 04             	add    $0x4,%eax
 52c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 52f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 532:	bf 00 00 00 00       	mov    $0x0,%edi
 537:	e9 28 ff ff ff       	jmp    464 <printf+0x49>
        s = (char*)*ap;
 53c:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 53f:	8b 01                	mov    (%ecx),%eax
        ap++;
 541:	83 c1 04             	add    $0x4,%ecx
 544:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 547:	85 c0                	test   %eax,%eax
 549:	74 13                	je     55e <printf+0x143>
        s = (char*)*ap;
 54b:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 54d:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 550:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 555:	84 c0                	test   %al,%al
 557:	75 0f                	jne    568 <printf+0x14d>
 559:	e9 06 ff ff ff       	jmp    464 <printf+0x49>
          s = "(null)";
 55e:	bb 6c 07 00 00       	mov    $0x76c,%ebx
        while(*s != 0){
 563:	b8 28 00 00 00       	mov    $0x28,%eax
 568:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 56b:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 56e:	83 ec 04             	sub    $0x4,%esp
 571:	6a 01                	push   $0x1
 573:	8d 45 e7             	lea    -0x19(%ebp),%eax
 576:	50                   	push   %eax
 577:	57                   	push   %edi
 578:	e8 8a fd ff ff       	call   307 <write>
          s++;
 57d:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 580:	0f b6 03             	movzbl (%ebx),%eax
 583:	83 c4 10             	add    $0x10,%esp
 586:	84 c0                	test   %al,%al
 588:	75 e1                	jne    56b <printf+0x150>
      state = 0;
 58a:	bf 00 00 00 00       	mov    $0x0,%edi
 58f:	e9 d0 fe ff ff       	jmp    464 <printf+0x49>
        putc(fd, *ap);
 594:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 597:	8b 07                	mov    (%edi),%eax
 599:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 59c:	83 ec 04             	sub    $0x4,%esp
 59f:	6a 01                	push   $0x1
 5a1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5a4:	50                   	push   %eax
 5a5:	ff 75 08             	pushl  0x8(%ebp)
 5a8:	e8 5a fd ff ff       	call   307 <write>
        ap++;
 5ad:	83 c7 04             	add    $0x4,%edi
 5b0:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5b3:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5b6:	bf 00 00 00 00       	mov    $0x0,%edi
 5bb:	e9 a4 fe ff ff       	jmp    464 <printf+0x49>
        putc(fd, c);
 5c0:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5c3:	83 ec 04             	sub    $0x4,%esp
 5c6:	6a 01                	push   $0x1
 5c8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5cb:	50                   	push   %eax
 5cc:	ff 75 08             	pushl  0x8(%ebp)
 5cf:	e8 33 fd ff ff       	call   307 <write>
 5d4:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5d7:	bf 00 00 00 00       	mov    $0x0,%edi
 5dc:	e9 83 fe ff ff       	jmp    464 <printf+0x49>
    }
  }
}
 5e1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5e4:	5b                   	pop    %ebx
 5e5:	5e                   	pop    %esi
 5e6:	5f                   	pop    %edi
 5e7:	5d                   	pop    %ebp
 5e8:	c3                   	ret    

000005e9 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5e9:	f3 0f 1e fb          	endbr32 
 5ed:	55                   	push   %ebp
 5ee:	89 e5                	mov    %esp,%ebp
 5f0:	57                   	push   %edi
 5f1:	56                   	push   %esi
 5f2:	53                   	push   %ebx
 5f3:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 5f6:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 5f9:	a1 20 0a 00 00       	mov    0xa20,%eax
 5fe:	eb 0c                	jmp    60c <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 600:	8b 10                	mov    (%eax),%edx
 602:	39 c2                	cmp    %eax,%edx
 604:	77 04                	ja     60a <free+0x21>
 606:	39 ca                	cmp    %ecx,%edx
 608:	77 10                	ja     61a <free+0x31>
{
 60a:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60c:	39 c8                	cmp    %ecx,%eax
 60e:	73 f0                	jae    600 <free+0x17>
 610:	8b 10                	mov    (%eax),%edx
 612:	39 ca                	cmp    %ecx,%edx
 614:	77 04                	ja     61a <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 616:	39 c2                	cmp    %eax,%edx
 618:	77 f0                	ja     60a <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 61a:	8b 73 fc             	mov    -0x4(%ebx),%esi
 61d:	8b 10                	mov    (%eax),%edx
 61f:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 622:	39 fa                	cmp    %edi,%edx
 624:	74 19                	je     63f <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 626:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 629:	8b 50 04             	mov    0x4(%eax),%edx
 62c:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 62f:	39 f1                	cmp    %esi,%ecx
 631:	74 1b                	je     64e <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 633:	89 08                	mov    %ecx,(%eax)
  freep = p;
 635:	a3 20 0a 00 00       	mov    %eax,0xa20
}
 63a:	5b                   	pop    %ebx
 63b:	5e                   	pop    %esi
 63c:	5f                   	pop    %edi
 63d:	5d                   	pop    %ebp
 63e:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 63f:	03 72 04             	add    0x4(%edx),%esi
 642:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 645:	8b 10                	mov    (%eax),%edx
 647:	8b 12                	mov    (%edx),%edx
 649:	89 53 f8             	mov    %edx,-0x8(%ebx)
 64c:	eb db                	jmp    629 <free+0x40>
    p->s.size += bp->s.size;
 64e:	03 53 fc             	add    -0x4(%ebx),%edx
 651:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 654:	8b 53 f8             	mov    -0x8(%ebx),%edx
 657:	89 10                	mov    %edx,(%eax)
 659:	eb da                	jmp    635 <free+0x4c>

0000065b <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 65b:	f3 0f 1e fb          	endbr32 
 65f:	55                   	push   %ebp
 660:	89 e5                	mov    %esp,%ebp
 662:	57                   	push   %edi
 663:	56                   	push   %esi
 664:	53                   	push   %ebx
 665:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 668:	8b 45 08             	mov    0x8(%ebp),%eax
 66b:	8d 58 07             	lea    0x7(%eax),%ebx
 66e:	c1 eb 03             	shr    $0x3,%ebx
 671:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 674:	8b 15 20 0a 00 00    	mov    0xa20,%edx
 67a:	85 d2                	test   %edx,%edx
 67c:	74 20                	je     69e <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 67e:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 680:	8b 48 04             	mov    0x4(%eax),%ecx
 683:	39 cb                	cmp    %ecx,%ebx
 685:	76 3c                	jbe    6c3 <malloc+0x68>
 687:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 68d:	be 00 10 00 00       	mov    $0x1000,%esi
 692:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 695:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 69c:	eb 72                	jmp    710 <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 69e:	c7 05 20 0a 00 00 24 	movl   $0xa24,0xa20
 6a5:	0a 00 00 
 6a8:	c7 05 24 0a 00 00 24 	movl   $0xa24,0xa24
 6af:	0a 00 00 
    base.s.size = 0;
 6b2:	c7 05 28 0a 00 00 00 	movl   $0x0,0xa28
 6b9:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6bc:	b8 24 0a 00 00       	mov    $0xa24,%eax
 6c1:	eb c4                	jmp    687 <malloc+0x2c>
      if(p->s.size == nunits)
 6c3:	39 cb                	cmp    %ecx,%ebx
 6c5:	74 1e                	je     6e5 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6c7:	29 d9                	sub    %ebx,%ecx
 6c9:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6cc:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6cf:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6d2:	89 15 20 0a 00 00    	mov    %edx,0xa20
      return (void*)(p + 1);
 6d8:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6db:	89 d0                	mov    %edx,%eax
 6dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6e0:	5b                   	pop    %ebx
 6e1:	5e                   	pop    %esi
 6e2:	5f                   	pop    %edi
 6e3:	5d                   	pop    %ebp
 6e4:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6e5:	8b 08                	mov    (%eax),%ecx
 6e7:	89 0a                	mov    %ecx,(%edx)
 6e9:	eb e7                	jmp    6d2 <malloc+0x77>
  hp->s.size = nu;
 6eb:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 6ee:	83 ec 0c             	sub    $0xc,%esp
 6f1:	83 c0 08             	add    $0x8,%eax
 6f4:	50                   	push   %eax
 6f5:	e8 ef fe ff ff       	call   5e9 <free>
  return freep;
 6fa:	8b 15 20 0a 00 00    	mov    0xa20,%edx
      if((p = morecore(nunits)) == 0)
 700:	83 c4 10             	add    $0x10,%esp
 703:	85 d2                	test   %edx,%edx
 705:	74 d4                	je     6db <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 707:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 709:	8b 48 04             	mov    0x4(%eax),%ecx
 70c:	39 d9                	cmp    %ebx,%ecx
 70e:	73 b3                	jae    6c3 <malloc+0x68>
    if(p == freep)
 710:	89 c2                	mov    %eax,%edx
 712:	39 05 20 0a 00 00    	cmp    %eax,0xa20
 718:	75 ed                	jne    707 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 71a:	83 ec 0c             	sub    $0xc,%esp
 71d:	57                   	push   %edi
 71e:	e8 4c fc ff ff       	call   36f <sbrk>
  if(p == (char*)-1)
 723:	83 c4 10             	add    $0x10,%esp
 726:	83 f8 ff             	cmp    $0xffffffff,%eax
 729:	75 c0                	jne    6eb <malloc+0x90>
        return 0;
 72b:	ba 00 00 00 00       	mov    $0x0,%edx
 730:	eb a9                	jmp    6db <malloc+0x80>
