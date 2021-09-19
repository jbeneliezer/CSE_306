
_forktest:     file format elf32-i386


Disassembly of section .text:

00000000 <printf>:

#define N  1000

void
printf(int fd, char *s, ...)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	53                   	push   %ebx
   8:	83 ec 10             	sub    $0x10,%esp
   b:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  write(fd, s, strlen(s));
   e:	53                   	push   %ebx
   f:	e8 34 01 00 00       	call   148 <strlen>
  14:	83 c4 0c             	add    $0xc,%esp
  17:	50                   	push   %eax
  18:	53                   	push   %ebx
  19:	ff 75 08             	pushl  0x8(%ebp)
  1c:	e8 d8 02 00 00       	call   2f9 <write>
}
  21:	83 c4 10             	add    $0x10,%esp
  24:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  27:	c9                   	leave  
  28:	c3                   	ret    

00000029 <forktest>:

void
forktest(void)
{
  29:	f3 0f 1e fb          	endbr32 
  2d:	55                   	push   %ebp
  2e:	89 e5                	mov    %esp,%ebp
  30:	53                   	push   %ebx
  31:	83 ec 0c             	sub    $0xc,%esp
  int n, pid;

  printf(1, "fork test\n");
  34:	68 7c 03 00 00       	push   $0x37c
  39:	6a 01                	push   $0x1
  3b:	e8 c0 ff ff ff       	call   0 <printf>
  40:	83 c4 10             	add    $0x10,%esp

  for(n=0; n<N; n++){
  43:	bb 00 00 00 00       	mov    $0x0,%ebx
    pid = fork();
  48:	e8 84 02 00 00       	call   2d1 <fork>
    if(pid < 0)
  4d:	85 c0                	test   %eax,%eax
  4f:	78 2b                	js     7c <forktest+0x53>
      break;
    if(pid == 0)
  51:	74 24                	je     77 <forktest+0x4e>
  for(n=0; n<N; n++){
  53:	83 c3 01             	add    $0x1,%ebx
  56:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  5c:	75 ea                	jne    48 <forktest+0x1f>
      exit();
  }

  if(n == N){
    printf(1, "fork claimed to work N times!\n", N);
  5e:	83 ec 04             	sub    $0x4,%esp
  61:	68 e8 03 00 00       	push   $0x3e8
  66:	68 bc 03 00 00       	push   $0x3bc
  6b:	6a 01                	push   $0x1
  6d:	e8 8e ff ff ff       	call   0 <printf>
    exit();
  72:	e8 62 02 00 00       	call   2d9 <exit>
      exit();
  77:	e8 5d 02 00 00       	call   2d9 <exit>
  if(n == N){
  7c:	81 fb e8 03 00 00    	cmp    $0x3e8,%ebx
  82:	74 da                	je     5e <forktest+0x35>
  }

  for(; n > 0; n--){
  84:	85 db                	test   %ebx,%ebx
  86:	7e 0e                	jle    96 <forktest+0x6d>
    if(wait() < 0){
  88:	e8 54 02 00 00       	call   2e1 <wait>
  8d:	85 c0                	test   %eax,%eax
  8f:	78 26                	js     b7 <forktest+0x8e>
  for(; n > 0; n--){
  91:	83 eb 01             	sub    $0x1,%ebx
  94:	75 f2                	jne    88 <forktest+0x5f>
      printf(1, "wait stopped early\n");
      exit();
    }
  }

  if(wait() != -1){
  96:	e8 46 02 00 00       	call   2e1 <wait>
  9b:	83 f8 ff             	cmp    $0xffffffff,%eax
  9e:	75 2b                	jne    cb <forktest+0xa2>
    printf(1, "wait got too many\n");
    exit();
  }

  printf(1, "fork test OK\n");
  a0:	83 ec 08             	sub    $0x8,%esp
  a3:	68 ae 03 00 00       	push   $0x3ae
  a8:	6a 01                	push   $0x1
  aa:	e8 51 ff ff ff       	call   0 <printf>
}
  af:	83 c4 10             	add    $0x10,%esp
  b2:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  b5:	c9                   	leave  
  b6:	c3                   	ret    
      printf(1, "wait stopped early\n");
  b7:	83 ec 08             	sub    $0x8,%esp
  ba:	68 87 03 00 00       	push   $0x387
  bf:	6a 01                	push   $0x1
  c1:	e8 3a ff ff ff       	call   0 <printf>
      exit();
  c6:	e8 0e 02 00 00       	call   2d9 <exit>
    printf(1, "wait got too many\n");
  cb:	83 ec 08             	sub    $0x8,%esp
  ce:	68 9b 03 00 00       	push   $0x39b
  d3:	6a 01                	push   $0x1
  d5:	e8 26 ff ff ff       	call   0 <printf>
    exit();
  da:	e8 fa 01 00 00       	call   2d9 <exit>

000000df <main>:

int
main(void)
{
  df:	f3 0f 1e fb          	endbr32 
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	83 e4 f0             	and    $0xfffffff0,%esp
  forktest();
  e9:	e8 3b ff ff ff       	call   29 <forktest>
  exit();
  ee:	e8 e6 01 00 00       	call   2d9 <exit>

000000f3 <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
  f3:	f3 0f 1e fb          	endbr32 
  f7:	55                   	push   %ebp
  f8:	89 e5                	mov    %esp,%ebp
  fa:	53                   	push   %ebx
  fb:	8b 4d 08             	mov    0x8(%ebp),%ecx
  fe:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 101:	b8 00 00 00 00       	mov    $0x0,%eax
 106:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 10a:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 10d:	83 c0 01             	add    $0x1,%eax
 110:	84 d2                	test   %dl,%dl
 112:	75 f2                	jne    106 <strcpy+0x13>
    ;
  return os;
}
 114:	89 c8                	mov    %ecx,%eax
 116:	5b                   	pop    %ebx
 117:	5d                   	pop    %ebp
 118:	c3                   	ret    

00000119 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 119:	f3 0f 1e fb          	endbr32 
 11d:	55                   	push   %ebp
 11e:	89 e5                	mov    %esp,%ebp
 120:	8b 4d 08             	mov    0x8(%ebp),%ecx
 123:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 126:	0f b6 01             	movzbl (%ecx),%eax
 129:	84 c0                	test   %al,%al
 12b:	74 11                	je     13e <strcmp+0x25>
 12d:	38 02                	cmp    %al,(%edx)
 12f:	75 0d                	jne    13e <strcmp+0x25>
    p++, q++;
 131:	83 c1 01             	add    $0x1,%ecx
 134:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 137:	0f b6 01             	movzbl (%ecx),%eax
 13a:	84 c0                	test   %al,%al
 13c:	75 ef                	jne    12d <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 13e:	0f b6 c0             	movzbl %al,%eax
 141:	0f b6 12             	movzbl (%edx),%edx
 144:	29 d0                	sub    %edx,%eax
}
 146:	5d                   	pop    %ebp
 147:	c3                   	ret    

00000148 <strlen>:

uint
strlen(char *s)
{
 148:	f3 0f 1e fb          	endbr32 
 14c:	55                   	push   %ebp
 14d:	89 e5                	mov    %esp,%ebp
 14f:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 152:	80 3a 00             	cmpb   $0x0,(%edx)
 155:	74 14                	je     16b <strlen+0x23>
 157:	b8 00 00 00 00       	mov    $0x0,%eax
 15c:	83 c0 01             	add    $0x1,%eax
 15f:	89 c1                	mov    %eax,%ecx
 161:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 165:	75 f5                	jne    15c <strlen+0x14>
    ;
  return n;
}
 167:	89 c8                	mov    %ecx,%eax
 169:	5d                   	pop    %ebp
 16a:	c3                   	ret    
  for(n = 0; s[n]; n++)
 16b:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 170:	eb f5                	jmp    167 <strlen+0x1f>

00000172 <memset>:

void*
memset(void *dst, int c, uint n)
{
 172:	f3 0f 1e fb          	endbr32 
 176:	55                   	push   %ebp
 177:	89 e5                	mov    %esp,%ebp
 179:	57                   	push   %edi
 17a:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 17d:	89 d7                	mov    %edx,%edi
 17f:	8b 4d 10             	mov    0x10(%ebp),%ecx
 182:	8b 45 0c             	mov    0xc(%ebp),%eax
 185:	fc                   	cld    
 186:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 188:	89 d0                	mov    %edx,%eax
 18a:	5f                   	pop    %edi
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    

0000018d <strchr>:

char*
strchr(const char *s, char c)
{
 18d:	f3 0f 1e fb          	endbr32 
 191:	55                   	push   %ebp
 192:	89 e5                	mov    %esp,%ebp
 194:	8b 45 08             	mov    0x8(%ebp),%eax
 197:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 19b:	0f b6 10             	movzbl (%eax),%edx
 19e:	84 d2                	test   %dl,%dl
 1a0:	74 15                	je     1b7 <strchr+0x2a>
    if(*s == c)
 1a2:	38 d1                	cmp    %dl,%cl
 1a4:	74 0f                	je     1b5 <strchr+0x28>
  for(; *s; s++)
 1a6:	83 c0 01             	add    $0x1,%eax
 1a9:	0f b6 10             	movzbl (%eax),%edx
 1ac:	84 d2                	test   %dl,%dl
 1ae:	75 f2                	jne    1a2 <strchr+0x15>
      return (char*)s;
  return 0;
 1b0:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
  return 0;
 1b7:	b8 00 00 00 00       	mov    $0x0,%eax
 1bc:	eb f7                	jmp    1b5 <strchr+0x28>

000001be <gets>:

char*
gets(char *buf, int max)
{
 1be:	f3 0f 1e fb          	endbr32 
 1c2:	55                   	push   %ebp
 1c3:	89 e5                	mov    %esp,%ebp
 1c5:	57                   	push   %edi
 1c6:	56                   	push   %esi
 1c7:	53                   	push   %ebx
 1c8:	83 ec 2c             	sub    $0x2c,%esp
 1cb:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1ce:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 1d3:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1d6:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1d9:	83 c3 01             	add    $0x1,%ebx
 1dc:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1df:	7d 27                	jge    208 <gets+0x4a>
    cc = read(0, &c, 1);
 1e1:	83 ec 04             	sub    $0x4,%esp
 1e4:	6a 01                	push   $0x1
 1e6:	57                   	push   %edi
 1e7:	6a 00                	push   $0x0
 1e9:	e8 03 01 00 00       	call   2f1 <read>
    if(cc < 1)
 1ee:	83 c4 10             	add    $0x10,%esp
 1f1:	85 c0                	test   %eax,%eax
 1f3:	7e 13                	jle    208 <gets+0x4a>
      break;
    buf[i++] = c;
 1f5:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1f9:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 1fd:	3c 0a                	cmp    $0xa,%al
 1ff:	74 04                	je     205 <gets+0x47>
 201:	3c 0d                	cmp    $0xd,%al
 203:	75 d1                	jne    1d6 <gets+0x18>
  for(i=0; i+1 < max; ){
 205:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 208:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 20b:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 20f:	89 f0                	mov    %esi,%eax
 211:	8d 65 f4             	lea    -0xc(%ebp),%esp
 214:	5b                   	pop    %ebx
 215:	5e                   	pop    %esi
 216:	5f                   	pop    %edi
 217:	5d                   	pop    %ebp
 218:	c3                   	ret    

00000219 <stat>:

int
stat(char *n, struct stat *st)
{
 219:	f3 0f 1e fb          	endbr32 
 21d:	55                   	push   %ebp
 21e:	89 e5                	mov    %esp,%ebp
 220:	56                   	push   %esi
 221:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 222:	83 ec 08             	sub    $0x8,%esp
 225:	6a 00                	push   $0x0
 227:	ff 75 08             	pushl  0x8(%ebp)
 22a:	e8 ea 00 00 00       	call   319 <open>
  if(fd < 0)
 22f:	83 c4 10             	add    $0x10,%esp
 232:	85 c0                	test   %eax,%eax
 234:	78 24                	js     25a <stat+0x41>
 236:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 238:	83 ec 08             	sub    $0x8,%esp
 23b:	ff 75 0c             	pushl  0xc(%ebp)
 23e:	50                   	push   %eax
 23f:	e8 ed 00 00 00       	call   331 <fstat>
 244:	89 c6                	mov    %eax,%esi
  close(fd);
 246:	89 1c 24             	mov    %ebx,(%esp)
 249:	e8 b3 00 00 00       	call   301 <close>
  return r;
 24e:	83 c4 10             	add    $0x10,%esp
}
 251:	89 f0                	mov    %esi,%eax
 253:	8d 65 f8             	lea    -0x8(%ebp),%esp
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5d                   	pop    %ebp
 259:	c3                   	ret    
    return -1;
 25a:	be ff ff ff ff       	mov    $0xffffffff,%esi
 25f:	eb f0                	jmp    251 <stat+0x38>

00000261 <atoi>:

int
atoi(const char *s)
{
 261:	f3 0f 1e fb          	endbr32 
 265:	55                   	push   %ebp
 266:	89 e5                	mov    %esp,%ebp
 268:	53                   	push   %ebx
 269:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 26c:	0f b6 02             	movzbl (%edx),%eax
 26f:	8d 48 d0             	lea    -0x30(%eax),%ecx
 272:	80 f9 09             	cmp    $0x9,%cl
 275:	77 22                	ja     299 <atoi+0x38>
  n = 0;
 277:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 27c:	83 c2 01             	add    $0x1,%edx
 27f:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 282:	0f be c0             	movsbl %al,%eax
 285:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 289:	0f b6 02             	movzbl (%edx),%eax
 28c:	8d 58 d0             	lea    -0x30(%eax),%ebx
 28f:	80 fb 09             	cmp    $0x9,%bl
 292:	76 e8                	jbe    27c <atoi+0x1b>
  return n;
}
 294:	89 c8                	mov    %ecx,%eax
 296:	5b                   	pop    %ebx
 297:	5d                   	pop    %ebp
 298:	c3                   	ret    
  n = 0;
 299:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 29e:	eb f4                	jmp    294 <atoi+0x33>

000002a0 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2a0:	f3 0f 1e fb          	endbr32 
 2a4:	55                   	push   %ebp
 2a5:	89 e5                	mov    %esp,%ebp
 2a7:	56                   	push   %esi
 2a8:	53                   	push   %ebx
 2a9:	8b 75 08             	mov    0x8(%ebp),%esi
 2ac:	8b 55 0c             	mov    0xc(%ebp),%edx
 2af:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2b2:	85 db                	test   %ebx,%ebx
 2b4:	7e 15                	jle    2cb <memmove+0x2b>
 2b6:	01 f3                	add    %esi,%ebx
  dst = vdst;
 2b8:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 2ba:	83 c2 01             	add    $0x1,%edx
 2bd:	83 c0 01             	add    $0x1,%eax
 2c0:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 2c4:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 2c7:	39 c3                	cmp    %eax,%ebx
 2c9:	75 ef                	jne    2ba <memmove+0x1a>
  return vdst;
}
 2cb:	89 f0                	mov    %esi,%eax
 2cd:	5b                   	pop    %ebx
 2ce:	5e                   	pop    %esi
 2cf:	5d                   	pop    %ebp
 2d0:	c3                   	ret    

000002d1 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2d1:	b8 01 00 00 00       	mov    $0x1,%eax
 2d6:	cd 40                	int    $0x40
 2d8:	c3                   	ret    

000002d9 <exit>:
SYSCALL(exit)
 2d9:	b8 02 00 00 00       	mov    $0x2,%eax
 2de:	cd 40                	int    $0x40
 2e0:	c3                   	ret    

000002e1 <wait>:
SYSCALL(wait)
 2e1:	b8 03 00 00 00       	mov    $0x3,%eax
 2e6:	cd 40                	int    $0x40
 2e8:	c3                   	ret    

000002e9 <pipe>:
SYSCALL(pipe)
 2e9:	b8 04 00 00 00       	mov    $0x4,%eax
 2ee:	cd 40                	int    $0x40
 2f0:	c3                   	ret    

000002f1 <read>:
SYSCALL(read)
 2f1:	b8 05 00 00 00       	mov    $0x5,%eax
 2f6:	cd 40                	int    $0x40
 2f8:	c3                   	ret    

000002f9 <write>:
SYSCALL(write)
 2f9:	b8 10 00 00 00       	mov    $0x10,%eax
 2fe:	cd 40                	int    $0x40
 300:	c3                   	ret    

00000301 <close>:
SYSCALL(close)
 301:	b8 15 00 00 00       	mov    $0x15,%eax
 306:	cd 40                	int    $0x40
 308:	c3                   	ret    

00000309 <kill>:
SYSCALL(kill)
 309:	b8 06 00 00 00       	mov    $0x6,%eax
 30e:	cd 40                	int    $0x40
 310:	c3                   	ret    

00000311 <exec>:
SYSCALL(exec)
 311:	b8 07 00 00 00       	mov    $0x7,%eax
 316:	cd 40                	int    $0x40
 318:	c3                   	ret    

00000319 <open>:
SYSCALL(open)
 319:	b8 0f 00 00 00       	mov    $0xf,%eax
 31e:	cd 40                	int    $0x40
 320:	c3                   	ret    

00000321 <mknod>:
SYSCALL(mknod)
 321:	b8 11 00 00 00       	mov    $0x11,%eax
 326:	cd 40                	int    $0x40
 328:	c3                   	ret    

00000329 <unlink>:
SYSCALL(unlink)
 329:	b8 12 00 00 00       	mov    $0x12,%eax
 32e:	cd 40                	int    $0x40
 330:	c3                   	ret    

00000331 <fstat>:
SYSCALL(fstat)
 331:	b8 08 00 00 00       	mov    $0x8,%eax
 336:	cd 40                	int    $0x40
 338:	c3                   	ret    

00000339 <link>:
SYSCALL(link)
 339:	b8 13 00 00 00       	mov    $0x13,%eax
 33e:	cd 40                	int    $0x40
 340:	c3                   	ret    

00000341 <mkdir>:
SYSCALL(mkdir)
 341:	b8 14 00 00 00       	mov    $0x14,%eax
 346:	cd 40                	int    $0x40
 348:	c3                   	ret    

00000349 <chdir>:
SYSCALL(chdir)
 349:	b8 09 00 00 00       	mov    $0x9,%eax
 34e:	cd 40                	int    $0x40
 350:	c3                   	ret    

00000351 <dup>:
SYSCALL(dup)
 351:	b8 0a 00 00 00       	mov    $0xa,%eax
 356:	cd 40                	int    $0x40
 358:	c3                   	ret    

00000359 <getpid>:
SYSCALL(getpid)
 359:	b8 0b 00 00 00       	mov    $0xb,%eax
 35e:	cd 40                	int    $0x40
 360:	c3                   	ret    

00000361 <sbrk>:
SYSCALL(sbrk)
 361:	b8 0c 00 00 00       	mov    $0xc,%eax
 366:	cd 40                	int    $0x40
 368:	c3                   	ret    

00000369 <sleep>:
SYSCALL(sleep)
 369:	b8 0d 00 00 00       	mov    $0xd,%eax
 36e:	cd 40                	int    $0x40
 370:	c3                   	ret    

00000371 <uptime>:
SYSCALL(uptime)
 371:	b8 0e 00 00 00       	mov    $0xe,%eax
 376:	cd 40                	int    $0x40
 378:	c3                   	ret    
