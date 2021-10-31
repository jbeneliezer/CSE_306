
_kill:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/stat.h"
#include "user.h"

int
main(int argc, char **argv)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   8:	83 e4 f0             	and    $0xfffffff0,%esp
   b:	ff 71 fc             	pushl  -0x4(%ecx)
   e:	55                   	push   %ebp
   f:	89 e5                	mov    %esp,%ebp
  11:	56                   	push   %esi
  12:	53                   	push   %ebx
  13:	51                   	push   %ecx
  14:	83 ec 0c             	sub    $0xc,%esp
  17:	8b 01                	mov    (%ecx),%eax
  19:	8b 51 04             	mov    0x4(%ecx),%edx
  int i;

  if(argc < 2){
  1c:	83 f8 01             	cmp    $0x1,%eax
  1f:	7e 27                	jle    48 <main+0x48>
  21:	8d 5a 04             	lea    0x4(%edx),%ebx
  24:	8d 34 82             	lea    (%edx,%eax,4),%esi
    printf(2, "usage: kill pid...\n");
    exit();
  }
  for(i=1; i<argc; i++)
    kill(atoi(argv[i]));
  27:	83 ec 0c             	sub    $0xc,%esp
  2a:	ff 33                	pushl  (%ebx)
  2c:	e8 99 01 00 00       	call   1ca <atoi>
  31:	89 04 24             	mov    %eax,(%esp)
  34:	e8 39 02 00 00       	call   272 <kill>
  for(i=1; i<argc; i++)
  39:	83 c3 04             	add    $0x4,%ebx
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	39 f3                	cmp    %esi,%ebx
  41:	75 e4                	jne    27 <main+0x27>
  exit();
  43:	e8 fa 01 00 00       	call   242 <exit>
    printf(2, "usage: kill pid...\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 90 06 00 00       	push   $0x690
  50:	6a 02                	push   $0x2
  52:	e8 1f 03 00 00       	call   376 <printf>
    exit();
  57:	e8 e6 01 00 00       	call   242 <exit>

0000005c <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  5c:	f3 0f 1e fb          	endbr32 
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 4d 08             	mov    0x8(%ebp),%ecx
  67:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	b8 00 00 00 00       	mov    $0x0,%eax
  6f:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
  73:	88 14 01             	mov    %dl,(%ecx,%eax,1)
  76:	83 c0 01             	add    $0x1,%eax
  79:	84 d2                	test   %dl,%dl
  7b:	75 f2                	jne    6f <strcpy+0x13>
    ;
  return os;
}
  7d:	89 c8                	mov    %ecx,%eax
  7f:	5b                   	pop    %ebx
  80:	5d                   	pop    %ebp
  81:	c3                   	ret    

00000082 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  82:	f3 0f 1e fb          	endbr32 
  86:	55                   	push   %ebp
  87:	89 e5                	mov    %esp,%ebp
  89:	8b 4d 08             	mov    0x8(%ebp),%ecx
  8c:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
  8f:	0f b6 01             	movzbl (%ecx),%eax
  92:	84 c0                	test   %al,%al
  94:	74 11                	je     a7 <strcmp+0x25>
  96:	38 02                	cmp    %al,(%edx)
  98:	75 0d                	jne    a7 <strcmp+0x25>
    p++, q++;
  9a:	83 c1 01             	add    $0x1,%ecx
  9d:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  a0:	0f b6 01             	movzbl (%ecx),%eax
  a3:	84 c0                	test   %al,%al
  a5:	75 ef                	jne    96 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
  a7:	0f b6 c0             	movzbl %al,%eax
  aa:	0f b6 12             	movzbl (%edx),%edx
  ad:	29 d0                	sub    %edx,%eax
}
  af:	5d                   	pop    %ebp
  b0:	c3                   	ret    

000000b1 <strlen>:

uint
strlen(char *s)
{
  b1:	f3 0f 1e fb          	endbr32 
  b5:	55                   	push   %ebp
  b6:	89 e5                	mov    %esp,%ebp
  b8:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
  bb:	80 3a 00             	cmpb   $0x0,(%edx)
  be:	74 14                	je     d4 <strlen+0x23>
  c0:	b8 00 00 00 00       	mov    $0x0,%eax
  c5:	83 c0 01             	add    $0x1,%eax
  c8:	89 c1                	mov    %eax,%ecx
  ca:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
  ce:	75 f5                	jne    c5 <strlen+0x14>
    ;
  return n;
}
  d0:	89 c8                	mov    %ecx,%eax
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  for(n = 0; s[n]; n++)
  d4:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
  d9:	eb f5                	jmp    d0 <strlen+0x1f>

000000db <memset>:

void*
memset(void *dst, int c, uint n)
{
  db:	f3 0f 1e fb          	endbr32 
  df:	55                   	push   %ebp
  e0:	89 e5                	mov    %esp,%ebp
  e2:	57                   	push   %edi
  e3:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e6:	89 d7                	mov    %edx,%edi
  e8:	8b 4d 10             	mov    0x10(%ebp),%ecx
  eb:	8b 45 0c             	mov    0xc(%ebp),%eax
  ee:	fc                   	cld    
  ef:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f1:	89 d0                	mov    %edx,%eax
  f3:	5f                   	pop    %edi
  f4:	5d                   	pop    %ebp
  f5:	c3                   	ret    

000000f6 <strchr>:

char*
strchr(const char *s, char c)
{
  f6:	f3 0f 1e fb          	endbr32 
  fa:	55                   	push   %ebp
  fb:	89 e5                	mov    %esp,%ebp
  fd:	8b 45 08             	mov    0x8(%ebp),%eax
 100:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 104:	0f b6 10             	movzbl (%eax),%edx
 107:	84 d2                	test   %dl,%dl
 109:	74 15                	je     120 <strchr+0x2a>
    if(*s == c)
 10b:	38 d1                	cmp    %dl,%cl
 10d:	74 0f                	je     11e <strchr+0x28>
  for(; *s; s++)
 10f:	83 c0 01             	add    $0x1,%eax
 112:	0f b6 10             	movzbl (%eax),%edx
 115:	84 d2                	test   %dl,%dl
 117:	75 f2                	jne    10b <strchr+0x15>
      return (char*)s;
  return 0;
 119:	b8 00 00 00 00       	mov    $0x0,%eax
}
 11e:	5d                   	pop    %ebp
 11f:	c3                   	ret    
  return 0;
 120:	b8 00 00 00 00       	mov    $0x0,%eax
 125:	eb f7                	jmp    11e <strchr+0x28>

00000127 <gets>:

char*
gets(char *buf, int max)
{
 127:	f3 0f 1e fb          	endbr32 
 12b:	55                   	push   %ebp
 12c:	89 e5                	mov    %esp,%ebp
 12e:	57                   	push   %edi
 12f:	56                   	push   %esi
 130:	53                   	push   %ebx
 131:	83 ec 2c             	sub    $0x2c,%esp
 134:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 137:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 13c:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 13f:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 142:	83 c3 01             	add    $0x1,%ebx
 145:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 148:	7d 27                	jge    171 <gets+0x4a>
    cc = read(0, &c, 1);
 14a:	83 ec 04             	sub    $0x4,%esp
 14d:	6a 01                	push   $0x1
 14f:	57                   	push   %edi
 150:	6a 00                	push   $0x0
 152:	e8 03 01 00 00       	call   25a <read>
    if(cc < 1)
 157:	83 c4 10             	add    $0x10,%esp
 15a:	85 c0                	test   %eax,%eax
 15c:	7e 13                	jle    171 <gets+0x4a>
      break;
    buf[i++] = c;
 15e:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 162:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 166:	3c 0a                	cmp    $0xa,%al
 168:	74 04                	je     16e <gets+0x47>
 16a:	3c 0d                	cmp    $0xd,%al
 16c:	75 d1                	jne    13f <gets+0x18>
  for(i=0; i+1 < max; ){
 16e:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 171:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 174:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 178:	89 f0                	mov    %esi,%eax
 17a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 17d:	5b                   	pop    %ebx
 17e:	5e                   	pop    %esi
 17f:	5f                   	pop    %edi
 180:	5d                   	pop    %ebp
 181:	c3                   	ret    

00000182 <stat>:

int
stat(char *n, struct stat *st)
{
 182:	f3 0f 1e fb          	endbr32 
 186:	55                   	push   %ebp
 187:	89 e5                	mov    %esp,%ebp
 189:	56                   	push   %esi
 18a:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 18b:	83 ec 08             	sub    $0x8,%esp
 18e:	6a 00                	push   $0x0
 190:	ff 75 08             	pushl  0x8(%ebp)
 193:	e8 ea 00 00 00       	call   282 <open>
  if(fd < 0)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	78 24                	js     1c3 <stat+0x41>
 19f:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 1a1:	83 ec 08             	sub    $0x8,%esp
 1a4:	ff 75 0c             	pushl  0xc(%ebp)
 1a7:	50                   	push   %eax
 1a8:	e8 ed 00 00 00       	call   29a <fstat>
 1ad:	89 c6                	mov    %eax,%esi
  close(fd);
 1af:	89 1c 24             	mov    %ebx,(%esp)
 1b2:	e8 b3 00 00 00       	call   26a <close>
  return r;
 1b7:	83 c4 10             	add    $0x10,%esp
}
 1ba:	89 f0                	mov    %esi,%eax
 1bc:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1bf:	5b                   	pop    %ebx
 1c0:	5e                   	pop    %esi
 1c1:	5d                   	pop    %ebp
 1c2:	c3                   	ret    
    return -1;
 1c3:	be ff ff ff ff       	mov    $0xffffffff,%esi
 1c8:	eb f0                	jmp    1ba <stat+0x38>

000001ca <atoi>:

int
atoi(const char *s)
{
 1ca:	f3 0f 1e fb          	endbr32 
 1ce:	55                   	push   %ebp
 1cf:	89 e5                	mov    %esp,%ebp
 1d1:	53                   	push   %ebx
 1d2:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 1d5:	0f b6 02             	movzbl (%edx),%eax
 1d8:	8d 48 d0             	lea    -0x30(%eax),%ecx
 1db:	80 f9 09             	cmp    $0x9,%cl
 1de:	77 22                	ja     202 <atoi+0x38>
  n = 0;
 1e0:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 1e5:	83 c2 01             	add    $0x1,%edx
 1e8:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 1eb:	0f be c0             	movsbl %al,%eax
 1ee:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 1f2:	0f b6 02             	movzbl (%edx),%eax
 1f5:	8d 58 d0             	lea    -0x30(%eax),%ebx
 1f8:	80 fb 09             	cmp    $0x9,%bl
 1fb:	76 e8                	jbe    1e5 <atoi+0x1b>
  return n;
}
 1fd:	89 c8                	mov    %ecx,%eax
 1ff:	5b                   	pop    %ebx
 200:	5d                   	pop    %ebp
 201:	c3                   	ret    
  n = 0;
 202:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 207:	eb f4                	jmp    1fd <atoi+0x33>

00000209 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 209:	f3 0f 1e fb          	endbr32 
 20d:	55                   	push   %ebp
 20e:	89 e5                	mov    %esp,%ebp
 210:	56                   	push   %esi
 211:	53                   	push   %ebx
 212:	8b 75 08             	mov    0x8(%ebp),%esi
 215:	8b 55 0c             	mov    0xc(%ebp),%edx
 218:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 21b:	85 db                	test   %ebx,%ebx
 21d:	7e 15                	jle    234 <memmove+0x2b>
 21f:	01 f3                	add    %esi,%ebx
  dst = vdst;
 221:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 223:	83 c2 01             	add    $0x1,%edx
 226:	83 c0 01             	add    $0x1,%eax
 229:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 22d:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 230:	39 c3                	cmp    %eax,%ebx
 232:	75 ef                	jne    223 <memmove+0x1a>
  return vdst;
}
 234:	89 f0                	mov    %esi,%eax
 236:	5b                   	pop    %ebx
 237:	5e                   	pop    %esi
 238:	5d                   	pop    %ebp
 239:	c3                   	ret    

0000023a <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 23a:	b8 01 00 00 00       	mov    $0x1,%eax
 23f:	cd 40                	int    $0x40
 241:	c3                   	ret    

00000242 <exit>:
SYSCALL(exit)
 242:	b8 02 00 00 00       	mov    $0x2,%eax
 247:	cd 40                	int    $0x40
 249:	c3                   	ret    

0000024a <wait>:
SYSCALL(wait)
 24a:	b8 03 00 00 00       	mov    $0x3,%eax
 24f:	cd 40                	int    $0x40
 251:	c3                   	ret    

00000252 <pipe>:
SYSCALL(pipe)
 252:	b8 04 00 00 00       	mov    $0x4,%eax
 257:	cd 40                	int    $0x40
 259:	c3                   	ret    

0000025a <read>:
SYSCALL(read)
 25a:	b8 05 00 00 00       	mov    $0x5,%eax
 25f:	cd 40                	int    $0x40
 261:	c3                   	ret    

00000262 <write>:
SYSCALL(write)
 262:	b8 10 00 00 00       	mov    $0x10,%eax
 267:	cd 40                	int    $0x40
 269:	c3                   	ret    

0000026a <close>:
SYSCALL(close)
 26a:	b8 15 00 00 00       	mov    $0x15,%eax
 26f:	cd 40                	int    $0x40
 271:	c3                   	ret    

00000272 <kill>:
SYSCALL(kill)
 272:	b8 06 00 00 00       	mov    $0x6,%eax
 277:	cd 40                	int    $0x40
 279:	c3                   	ret    

0000027a <exec>:
SYSCALL(exec)
 27a:	b8 07 00 00 00       	mov    $0x7,%eax
 27f:	cd 40                	int    $0x40
 281:	c3                   	ret    

00000282 <open>:
SYSCALL(open)
 282:	b8 0f 00 00 00       	mov    $0xf,%eax
 287:	cd 40                	int    $0x40
 289:	c3                   	ret    

0000028a <mknod>:
SYSCALL(mknod)
 28a:	b8 11 00 00 00       	mov    $0x11,%eax
 28f:	cd 40                	int    $0x40
 291:	c3                   	ret    

00000292 <unlink>:
SYSCALL(unlink)
 292:	b8 12 00 00 00       	mov    $0x12,%eax
 297:	cd 40                	int    $0x40
 299:	c3                   	ret    

0000029a <fstat>:
SYSCALL(fstat)
 29a:	b8 08 00 00 00       	mov    $0x8,%eax
 29f:	cd 40                	int    $0x40
 2a1:	c3                   	ret    

000002a2 <link>:
SYSCALL(link)
 2a2:	b8 13 00 00 00       	mov    $0x13,%eax
 2a7:	cd 40                	int    $0x40
 2a9:	c3                   	ret    

000002aa <mkdir>:
SYSCALL(mkdir)
 2aa:	b8 14 00 00 00       	mov    $0x14,%eax
 2af:	cd 40                	int    $0x40
 2b1:	c3                   	ret    

000002b2 <chdir>:
SYSCALL(chdir)
 2b2:	b8 09 00 00 00       	mov    $0x9,%eax
 2b7:	cd 40                	int    $0x40
 2b9:	c3                   	ret    

000002ba <dup>:
SYSCALL(dup)
 2ba:	b8 0a 00 00 00       	mov    $0xa,%eax
 2bf:	cd 40                	int    $0x40
 2c1:	c3                   	ret    

000002c2 <getpid>:
SYSCALL(getpid)
 2c2:	b8 0b 00 00 00       	mov    $0xb,%eax
 2c7:	cd 40                	int    $0x40
 2c9:	c3                   	ret    

000002ca <sbrk>:
SYSCALL(sbrk)
 2ca:	b8 0c 00 00 00       	mov    $0xc,%eax
 2cf:	cd 40                	int    $0x40
 2d1:	c3                   	ret    

000002d2 <sleep>:
SYSCALL(sleep)
 2d2:	b8 0d 00 00 00       	mov    $0xd,%eax
 2d7:	cd 40                	int    $0x40
 2d9:	c3                   	ret    

000002da <uptime>:
SYSCALL(uptime)
 2da:	b8 0e 00 00 00       	mov    $0xe,%eax
 2df:	cd 40                	int    $0x40
 2e1:	c3                   	ret    

000002e2 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 2e2:	55                   	push   %ebp
 2e3:	89 e5                	mov    %esp,%ebp
 2e5:	57                   	push   %edi
 2e6:	56                   	push   %esi
 2e7:	53                   	push   %ebx
 2e8:	83 ec 3c             	sub    $0x3c,%esp
 2eb:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 2ee:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 2f0:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 2f4:	74 77                	je     36d <printint+0x8b>
 2f6:	85 d2                	test   %edx,%edx
 2f8:	79 73                	jns    36d <printint+0x8b>
    neg = 1;
    x = -xx;
 2fa:	f7 db                	neg    %ebx
    neg = 1;
 2fc:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 303:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 308:	89 f7                	mov    %esi,%edi
 30a:	83 c6 01             	add    $0x1,%esi
 30d:	89 d8                	mov    %ebx,%eax
 30f:	ba 00 00 00 00       	mov    $0x0,%edx
 314:	f7 f1                	div    %ecx
 316:	0f b6 92 ac 06 00 00 	movzbl 0x6ac(%edx),%edx
 31d:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 321:	89 da                	mov    %ebx,%edx
 323:	89 c3                	mov    %eax,%ebx
 325:	39 d1                	cmp    %edx,%ecx
 327:	76 df                	jbe    308 <printint+0x26>
  if(neg)
 329:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 32d:	74 08                	je     337 <printint+0x55>
    buf[i++] = '-';
 32f:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 334:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 337:	85 f6                	test   %esi,%esi
 339:	7e 2a                	jle    365 <printint+0x83>
 33b:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 33f:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 342:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 345:	0f b6 03             	movzbl (%ebx),%eax
 348:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 34b:	83 ec 04             	sub    $0x4,%esp
 34e:	6a 01                	push   $0x1
 350:	56                   	push   %esi
 351:	ff 75 c4             	pushl  -0x3c(%ebp)
 354:	e8 09 ff ff ff       	call   262 <write>
  while(--i >= 0)
 359:	89 d8                	mov    %ebx,%eax
 35b:	83 eb 01             	sub    $0x1,%ebx
 35e:	83 c4 10             	add    $0x10,%esp
 361:	39 f8                	cmp    %edi,%eax
 363:	75 e0                	jne    345 <printint+0x63>
}
 365:	8d 65 f4             	lea    -0xc(%ebp),%esp
 368:	5b                   	pop    %ebx
 369:	5e                   	pop    %esi
 36a:	5f                   	pop    %edi
 36b:	5d                   	pop    %ebp
 36c:	c3                   	ret    
  neg = 0;
 36d:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 374:	eb 8d                	jmp    303 <printint+0x21>

00000376 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 376:	f3 0f 1e fb          	endbr32 
 37a:	55                   	push   %ebp
 37b:	89 e5                	mov    %esp,%ebp
 37d:	57                   	push   %edi
 37e:	56                   	push   %esi
 37f:	53                   	push   %ebx
 380:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 383:	8b 75 0c             	mov    0xc(%ebp),%esi
 386:	0f b6 1e             	movzbl (%esi),%ebx
 389:	84 db                	test   %bl,%bl
 38b:	0f 84 ab 01 00 00    	je     53c <printf+0x1c6>
 391:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 394:	8d 45 10             	lea    0x10(%ebp),%eax
 397:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 39a:	bf 00 00 00 00       	mov    $0x0,%edi
 39f:	eb 2d                	jmp    3ce <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 3a1:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 3a4:	83 ec 04             	sub    $0x4,%esp
 3a7:	6a 01                	push   $0x1
 3a9:	8d 45 e7             	lea    -0x19(%ebp),%eax
 3ac:	50                   	push   %eax
 3ad:	ff 75 08             	pushl  0x8(%ebp)
 3b0:	e8 ad fe ff ff       	call   262 <write>
        putc(fd, c);
 3b5:	83 c4 10             	add    $0x10,%esp
 3b8:	eb 05                	jmp    3bf <printf+0x49>
      }
    } else if(state == '%'){
 3ba:	83 ff 25             	cmp    $0x25,%edi
 3bd:	74 22                	je     3e1 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 3bf:	83 c6 01             	add    $0x1,%esi
 3c2:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 3c6:	84 db                	test   %bl,%bl
 3c8:	0f 84 6e 01 00 00    	je     53c <printf+0x1c6>
    c = fmt[i] & 0xff;
 3ce:	0f be d3             	movsbl %bl,%edx
 3d1:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 3d4:	85 ff                	test   %edi,%edi
 3d6:	75 e2                	jne    3ba <printf+0x44>
      if(c == '%'){
 3d8:	83 f8 25             	cmp    $0x25,%eax
 3db:	75 c4                	jne    3a1 <printf+0x2b>
        state = '%';
 3dd:	89 c7                	mov    %eax,%edi
 3df:	eb de                	jmp    3bf <printf+0x49>
      if(c == 'd'){
 3e1:	83 f8 64             	cmp    $0x64,%eax
 3e4:	74 59                	je     43f <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 3e6:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 3ec:	83 fa 70             	cmp    $0x70,%edx
 3ef:	74 7a                	je     46b <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 3f1:	83 f8 73             	cmp    $0x73,%eax
 3f4:	0f 84 9d 00 00 00    	je     497 <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 3fa:	83 f8 63             	cmp    $0x63,%eax
 3fd:	0f 84 ec 00 00 00    	je     4ef <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 403:	83 f8 25             	cmp    $0x25,%eax
 406:	0f 84 0f 01 00 00    	je     51b <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 40c:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 410:	83 ec 04             	sub    $0x4,%esp
 413:	6a 01                	push   $0x1
 415:	8d 45 e7             	lea    -0x19(%ebp),%eax
 418:	50                   	push   %eax
 419:	ff 75 08             	pushl  0x8(%ebp)
 41c:	e8 41 fe ff ff       	call   262 <write>
        putc(fd, c);
 421:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 424:	83 c4 0c             	add    $0xc,%esp
 427:	6a 01                	push   $0x1
 429:	8d 45 e7             	lea    -0x19(%ebp),%eax
 42c:	50                   	push   %eax
 42d:	ff 75 08             	pushl  0x8(%ebp)
 430:	e8 2d fe ff ff       	call   262 <write>
        putc(fd, c);
 435:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 438:	bf 00 00 00 00       	mov    $0x0,%edi
 43d:	eb 80                	jmp    3bf <printf+0x49>
        printint(fd, *ap, 10, 1);
 43f:	83 ec 0c             	sub    $0xc,%esp
 442:	6a 01                	push   $0x1
 444:	b9 0a 00 00 00       	mov    $0xa,%ecx
 449:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 44c:	8b 17                	mov    (%edi),%edx
 44e:	8b 45 08             	mov    0x8(%ebp),%eax
 451:	e8 8c fe ff ff       	call   2e2 <printint>
        ap++;
 456:	89 f8                	mov    %edi,%eax
 458:	83 c0 04             	add    $0x4,%eax
 45b:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 45e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 461:	bf 00 00 00 00       	mov    $0x0,%edi
 466:	e9 54 ff ff ff       	jmp    3bf <printf+0x49>
        printint(fd, *ap, 16, 0);
 46b:	83 ec 0c             	sub    $0xc,%esp
 46e:	6a 00                	push   $0x0
 470:	b9 10 00 00 00       	mov    $0x10,%ecx
 475:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 478:	8b 17                	mov    (%edi),%edx
 47a:	8b 45 08             	mov    0x8(%ebp),%eax
 47d:	e8 60 fe ff ff       	call   2e2 <printint>
        ap++;
 482:	89 f8                	mov    %edi,%eax
 484:	83 c0 04             	add    $0x4,%eax
 487:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 48a:	83 c4 10             	add    $0x10,%esp
      state = 0;
 48d:	bf 00 00 00 00       	mov    $0x0,%edi
 492:	e9 28 ff ff ff       	jmp    3bf <printf+0x49>
        s = (char*)*ap;
 497:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 49a:	8b 01                	mov    (%ecx),%eax
        ap++;
 49c:	83 c1 04             	add    $0x4,%ecx
 49f:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 4a2:	85 c0                	test   %eax,%eax
 4a4:	74 13                	je     4b9 <printf+0x143>
        s = (char*)*ap;
 4a6:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 4a8:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 4ab:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 4b0:	84 c0                	test   %al,%al
 4b2:	75 0f                	jne    4c3 <printf+0x14d>
 4b4:	e9 06 ff ff ff       	jmp    3bf <printf+0x49>
          s = "(null)";
 4b9:	bb a4 06 00 00       	mov    $0x6a4,%ebx
        while(*s != 0){
 4be:	b8 28 00 00 00       	mov    $0x28,%eax
 4c3:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 4c6:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4c9:	83 ec 04             	sub    $0x4,%esp
 4cc:	6a 01                	push   $0x1
 4ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d1:	50                   	push   %eax
 4d2:	57                   	push   %edi
 4d3:	e8 8a fd ff ff       	call   262 <write>
          s++;
 4d8:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 4db:	0f b6 03             	movzbl (%ebx),%eax
 4de:	83 c4 10             	add    $0x10,%esp
 4e1:	84 c0                	test   %al,%al
 4e3:	75 e1                	jne    4c6 <printf+0x150>
      state = 0;
 4e5:	bf 00 00 00 00       	mov    $0x0,%edi
 4ea:	e9 d0 fe ff ff       	jmp    3bf <printf+0x49>
        putc(fd, *ap);
 4ef:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 4f2:	8b 07                	mov    (%edi),%eax
 4f4:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 4f7:	83 ec 04             	sub    $0x4,%esp
 4fa:	6a 01                	push   $0x1
 4fc:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4ff:	50                   	push   %eax
 500:	ff 75 08             	pushl  0x8(%ebp)
 503:	e8 5a fd ff ff       	call   262 <write>
        ap++;
 508:	83 c7 04             	add    $0x4,%edi
 50b:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 50e:	83 c4 10             	add    $0x10,%esp
      state = 0;
 511:	bf 00 00 00 00       	mov    $0x0,%edi
 516:	e9 a4 fe ff ff       	jmp    3bf <printf+0x49>
        putc(fd, c);
 51b:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 51e:	83 ec 04             	sub    $0x4,%esp
 521:	6a 01                	push   $0x1
 523:	8d 45 e7             	lea    -0x19(%ebp),%eax
 526:	50                   	push   %eax
 527:	ff 75 08             	pushl  0x8(%ebp)
 52a:	e8 33 fd ff ff       	call   262 <write>
 52f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 532:	bf 00 00 00 00       	mov    $0x0,%edi
 537:	e9 83 fe ff ff       	jmp    3bf <printf+0x49>
    }
  }
}
 53c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 53f:	5b                   	pop    %ebx
 540:	5e                   	pop    %esi
 541:	5f                   	pop    %edi
 542:	5d                   	pop    %ebp
 543:	c3                   	ret    

00000544 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 544:	f3 0f 1e fb          	endbr32 
 548:	55                   	push   %ebp
 549:	89 e5                	mov    %esp,%ebp
 54b:	57                   	push   %edi
 54c:	56                   	push   %esi
 54d:	53                   	push   %ebx
 54e:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 551:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 554:	a1 1c 09 00 00       	mov    0x91c,%eax
 559:	eb 0c                	jmp    567 <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 55b:	8b 10                	mov    (%eax),%edx
 55d:	39 c2                	cmp    %eax,%edx
 55f:	77 04                	ja     565 <free+0x21>
 561:	39 ca                	cmp    %ecx,%edx
 563:	77 10                	ja     575 <free+0x31>
{
 565:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 567:	39 c8                	cmp    %ecx,%eax
 569:	73 f0                	jae    55b <free+0x17>
 56b:	8b 10                	mov    (%eax),%edx
 56d:	39 ca                	cmp    %ecx,%edx
 56f:	77 04                	ja     575 <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 571:	39 c2                	cmp    %eax,%edx
 573:	77 f0                	ja     565 <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 575:	8b 73 fc             	mov    -0x4(%ebx),%esi
 578:	8b 10                	mov    (%eax),%edx
 57a:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 57d:	39 fa                	cmp    %edi,%edx
 57f:	74 19                	je     59a <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 581:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 584:	8b 50 04             	mov    0x4(%eax),%edx
 587:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 58a:	39 f1                	cmp    %esi,%ecx
 58c:	74 1b                	je     5a9 <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 58e:	89 08                	mov    %ecx,(%eax)
  freep = p;
 590:	a3 1c 09 00 00       	mov    %eax,0x91c
}
 595:	5b                   	pop    %ebx
 596:	5e                   	pop    %esi
 597:	5f                   	pop    %edi
 598:	5d                   	pop    %ebp
 599:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 59a:	03 72 04             	add    0x4(%edx),%esi
 59d:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 5a0:	8b 10                	mov    (%eax),%edx
 5a2:	8b 12                	mov    (%edx),%edx
 5a4:	89 53 f8             	mov    %edx,-0x8(%ebx)
 5a7:	eb db                	jmp    584 <free+0x40>
    p->s.size += bp->s.size;
 5a9:	03 53 fc             	add    -0x4(%ebx),%edx
 5ac:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 5af:	8b 53 f8             	mov    -0x8(%ebx),%edx
 5b2:	89 10                	mov    %edx,(%eax)
 5b4:	eb da                	jmp    590 <free+0x4c>

000005b6 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 5b6:	f3 0f 1e fb          	endbr32 
 5ba:	55                   	push   %ebp
 5bb:	89 e5                	mov    %esp,%ebp
 5bd:	57                   	push   %edi
 5be:	56                   	push   %esi
 5bf:	53                   	push   %ebx
 5c0:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 5c3:	8b 45 08             	mov    0x8(%ebp),%eax
 5c6:	8d 58 07             	lea    0x7(%eax),%ebx
 5c9:	c1 eb 03             	shr    $0x3,%ebx
 5cc:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 5cf:	8b 15 1c 09 00 00    	mov    0x91c,%edx
 5d5:	85 d2                	test   %edx,%edx
 5d7:	74 20                	je     5f9 <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 5d9:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 5db:	8b 48 04             	mov    0x4(%eax),%ecx
 5de:	39 cb                	cmp    %ecx,%ebx
 5e0:	76 3c                	jbe    61e <malloc+0x68>
 5e2:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 5e8:	be 00 10 00 00       	mov    $0x1000,%esi
 5ed:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 5f0:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 5f7:	eb 72                	jmp    66b <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 5f9:	c7 05 1c 09 00 00 20 	movl   $0x920,0x91c
 600:	09 00 00 
 603:	c7 05 20 09 00 00 20 	movl   $0x920,0x920
 60a:	09 00 00 
    base.s.size = 0;
 60d:	c7 05 24 09 00 00 00 	movl   $0x0,0x924
 614:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 617:	b8 20 09 00 00       	mov    $0x920,%eax
 61c:	eb c4                	jmp    5e2 <malloc+0x2c>
      if(p->s.size == nunits)
 61e:	39 cb                	cmp    %ecx,%ebx
 620:	74 1e                	je     640 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 622:	29 d9                	sub    %ebx,%ecx
 624:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 627:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 62a:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 62d:	89 15 1c 09 00 00    	mov    %edx,0x91c
      return (void*)(p + 1);
 633:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 636:	89 d0                	mov    %edx,%eax
 638:	8d 65 f4             	lea    -0xc(%ebp),%esp
 63b:	5b                   	pop    %ebx
 63c:	5e                   	pop    %esi
 63d:	5f                   	pop    %edi
 63e:	5d                   	pop    %ebp
 63f:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 640:	8b 08                	mov    (%eax),%ecx
 642:	89 0a                	mov    %ecx,(%edx)
 644:	eb e7                	jmp    62d <malloc+0x77>
  hp->s.size = nu;
 646:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 649:	83 ec 0c             	sub    $0xc,%esp
 64c:	83 c0 08             	add    $0x8,%eax
 64f:	50                   	push   %eax
 650:	e8 ef fe ff ff       	call   544 <free>
  return freep;
 655:	8b 15 1c 09 00 00    	mov    0x91c,%edx
      if((p = morecore(nunits)) == 0)
 65b:	83 c4 10             	add    $0x10,%esp
 65e:	85 d2                	test   %edx,%edx
 660:	74 d4                	je     636 <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 662:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 664:	8b 48 04             	mov    0x4(%eax),%ecx
 667:	39 d9                	cmp    %ebx,%ecx
 669:	73 b3                	jae    61e <malloc+0x68>
    if(p == freep)
 66b:	89 c2                	mov    %eax,%edx
 66d:	39 05 1c 09 00 00    	cmp    %eax,0x91c
 673:	75 ed                	jne    662 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 675:	83 ec 0c             	sub    $0xc,%esp
 678:	57                   	push   %edi
 679:	e8 4c fc ff ff       	call   2ca <sbrk>
  if(p == (char*)-1)
 67e:	83 c4 10             	add    $0x10,%esp
 681:	83 f8 ff             	cmp    $0xffffffff,%eax
 684:	75 c0                	jne    646 <malloc+0x90>
        return 0;
 686:	ba 00 00 00 00       	mov    $0x0,%edx
 68b:	eb a9                	jmp    636 <malloc+0x80>
