
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "kernel/fcntl.h"
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
  15:	81 ec 20 02 00 00    	sub    $0x220,%esp
  int fd, i;
  char path[] = "stressfs0";
  1b:	c7 45 de 73 74 72 65 	movl   $0x65727473,-0x22(%ebp)
  22:	c7 45 e2 73 73 66 73 	movl   $0x73667373,-0x1e(%ebp)
  29:	66 c7 45 e6 30 00    	movw   $0x30,-0x1a(%ebp)
  char data[512];

  printf(1, "stressfs starting\n");
  2f:	68 48 07 00 00       	push   $0x748
  34:	6a 01                	push   $0x1
  36:	e8 f4 03 00 00       	call   42f <printf>
  memset(data, 'a', sizeof(data));
  3b:	83 c4 0c             	add    $0xc,%esp
  3e:	68 00 02 00 00       	push   $0x200
  43:	6a 61                	push   $0x61
  45:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  4b:	50                   	push   %eax
  4c:	e8 43 01 00 00       	call   194 <memset>
  51:	83 c4 10             	add    $0x10,%esp

  for(i = 0; i < 4; i++)
  54:	bb 00 00 00 00       	mov    $0x0,%ebx
    if(fork() > 0)
  59:	e8 95 02 00 00       	call   2f3 <fork>
  5e:	85 c0                	test   %eax,%eax
  60:	7f 08                	jg     6a <main+0x6a>
  for(i = 0; i < 4; i++)
  62:	83 c3 01             	add    $0x1,%ebx
  65:	83 fb 04             	cmp    $0x4,%ebx
  68:	75 ef                	jne    59 <main+0x59>
      break;

  printf(1, "write %d\n", i);
  6a:	83 ec 04             	sub    $0x4,%esp
  6d:	53                   	push   %ebx
  6e:	68 5b 07 00 00       	push   $0x75b
  73:	6a 01                	push   $0x1
  75:	e8 b5 03 00 00       	call   42f <printf>

  path[8] += i;
  7a:	00 5d e6             	add    %bl,-0x1a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  7d:	83 c4 08             	add    $0x8,%esp
  80:	68 02 02 00 00       	push   $0x202
  85:	8d 45 de             	lea    -0x22(%ebp),%eax
  88:	50                   	push   %eax
  89:	e8 ad 02 00 00       	call   33b <open>
  8e:	89 c6                	mov    %eax,%esi
  90:	83 c4 10             	add    $0x10,%esp
  93:	bb 14 00 00 00       	mov    $0x14,%ebx
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  98:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  9e:	83 ec 04             	sub    $0x4,%esp
  a1:	68 00 02 00 00       	push   $0x200
  a6:	57                   	push   %edi
  a7:	56                   	push   %esi
  a8:	e8 6e 02 00 00       	call   31b <write>
  for(i = 0; i < 20; i++)
  ad:	83 c4 10             	add    $0x10,%esp
  b0:	83 eb 01             	sub    $0x1,%ebx
  b3:	75 e9                	jne    9e <main+0x9e>
  close(fd);
  b5:	83 ec 0c             	sub    $0xc,%esp
  b8:	56                   	push   %esi
  b9:	e8 65 02 00 00       	call   323 <close>

  printf(1, "read\n");
  be:	83 c4 08             	add    $0x8,%esp
  c1:	68 65 07 00 00       	push   $0x765
  c6:	6a 01                	push   $0x1
  c8:	e8 62 03 00 00       	call   42f <printf>

  fd = open(path, O_RDONLY);
  cd:	83 c4 08             	add    $0x8,%esp
  d0:	6a 00                	push   $0x0
  d2:	8d 45 de             	lea    -0x22(%ebp),%eax
  d5:	50                   	push   %eax
  d6:	e8 60 02 00 00       	call   33b <open>
  db:	89 c6                	mov    %eax,%esi
  dd:	83 c4 10             	add    $0x10,%esp
  e0:	bb 14 00 00 00       	mov    $0x14,%ebx
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
  e5:	8d bd de fd ff ff    	lea    -0x222(%ebp),%edi
  eb:	83 ec 04             	sub    $0x4,%esp
  ee:	68 00 02 00 00       	push   $0x200
  f3:	57                   	push   %edi
  f4:	56                   	push   %esi
  f5:	e8 19 02 00 00       	call   313 <read>
  for (i = 0; i < 20; i++)
  fa:	83 c4 10             	add    $0x10,%esp
  fd:	83 eb 01             	sub    $0x1,%ebx
 100:	75 e9                	jne    eb <main+0xeb>
  close(fd);
 102:	83 ec 0c             	sub    $0xc,%esp
 105:	56                   	push   %esi
 106:	e8 18 02 00 00       	call   323 <close>

  wait();
 10b:	e8 f3 01 00 00       	call   303 <wait>

  exit();
 110:	e8 e6 01 00 00       	call   2fb <exit>

00000115 <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 115:	f3 0f 1e fb          	endbr32 
 119:	55                   	push   %ebp
 11a:	89 e5                	mov    %esp,%ebp
 11c:	53                   	push   %ebx
 11d:	8b 4d 08             	mov    0x8(%ebp),%ecx
 120:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 123:	b8 00 00 00 00       	mov    $0x0,%eax
 128:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 12c:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 12f:	83 c0 01             	add    $0x1,%eax
 132:	84 d2                	test   %dl,%dl
 134:	75 f2                	jne    128 <strcpy+0x13>
    ;
  return os;
}
 136:	89 c8                	mov    %ecx,%eax
 138:	5b                   	pop    %ebx
 139:	5d                   	pop    %ebp
 13a:	c3                   	ret    

0000013b <strcmp>:

int
strcmp(const char *p, const char *q)
{
 13b:	f3 0f 1e fb          	endbr32 
 13f:	55                   	push   %ebp
 140:	89 e5                	mov    %esp,%ebp
 142:	8b 4d 08             	mov    0x8(%ebp),%ecx
 145:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 148:	0f b6 01             	movzbl (%ecx),%eax
 14b:	84 c0                	test   %al,%al
 14d:	74 11                	je     160 <strcmp+0x25>
 14f:	38 02                	cmp    %al,(%edx)
 151:	75 0d                	jne    160 <strcmp+0x25>
    p++, q++;
 153:	83 c1 01             	add    $0x1,%ecx
 156:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 159:	0f b6 01             	movzbl (%ecx),%eax
 15c:	84 c0                	test   %al,%al
 15e:	75 ef                	jne    14f <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 160:	0f b6 c0             	movzbl %al,%eax
 163:	0f b6 12             	movzbl (%edx),%edx
 166:	29 d0                	sub    %edx,%eax
}
 168:	5d                   	pop    %ebp
 169:	c3                   	ret    

0000016a <strlen>:

uint
strlen(char *s)
{
 16a:	f3 0f 1e fb          	endbr32 
 16e:	55                   	push   %ebp
 16f:	89 e5                	mov    %esp,%ebp
 171:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 174:	80 3a 00             	cmpb   $0x0,(%edx)
 177:	74 14                	je     18d <strlen+0x23>
 179:	b8 00 00 00 00       	mov    $0x0,%eax
 17e:	83 c0 01             	add    $0x1,%eax
 181:	89 c1                	mov    %eax,%ecx
 183:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 187:	75 f5                	jne    17e <strlen+0x14>
    ;
  return n;
}
 189:	89 c8                	mov    %ecx,%eax
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
  for(n = 0; s[n]; n++)
 18d:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 192:	eb f5                	jmp    189 <strlen+0x1f>

00000194 <memset>:

void*
memset(void *dst, int c, uint n)
{
 194:	f3 0f 1e fb          	endbr32 
 198:	55                   	push   %ebp
 199:	89 e5                	mov    %esp,%ebp
 19b:	57                   	push   %edi
 19c:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 19f:	89 d7                	mov    %edx,%edi
 1a1:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1a4:	8b 45 0c             	mov    0xc(%ebp),%eax
 1a7:	fc                   	cld    
 1a8:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1aa:	89 d0                	mov    %edx,%eax
 1ac:	5f                   	pop    %edi
 1ad:	5d                   	pop    %ebp
 1ae:	c3                   	ret    

000001af <strchr>:

char*
strchr(const char *s, char c)
{
 1af:	f3 0f 1e fb          	endbr32 
 1b3:	55                   	push   %ebp
 1b4:	89 e5                	mov    %esp,%ebp
 1b6:	8b 45 08             	mov    0x8(%ebp),%eax
 1b9:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 1bd:	0f b6 10             	movzbl (%eax),%edx
 1c0:	84 d2                	test   %dl,%dl
 1c2:	74 15                	je     1d9 <strchr+0x2a>
    if(*s == c)
 1c4:	38 d1                	cmp    %dl,%cl
 1c6:	74 0f                	je     1d7 <strchr+0x28>
  for(; *s; s++)
 1c8:	83 c0 01             	add    $0x1,%eax
 1cb:	0f b6 10             	movzbl (%eax),%edx
 1ce:	84 d2                	test   %dl,%dl
 1d0:	75 f2                	jne    1c4 <strchr+0x15>
      return (char*)s;
  return 0;
 1d2:	b8 00 00 00 00       	mov    $0x0,%eax
}
 1d7:	5d                   	pop    %ebp
 1d8:	c3                   	ret    
  return 0;
 1d9:	b8 00 00 00 00       	mov    $0x0,%eax
 1de:	eb f7                	jmp    1d7 <strchr+0x28>

000001e0 <gets>:

char*
gets(char *buf, int max)
{
 1e0:	f3 0f 1e fb          	endbr32 
 1e4:	55                   	push   %ebp
 1e5:	89 e5                	mov    %esp,%ebp
 1e7:	57                   	push   %edi
 1e8:	56                   	push   %esi
 1e9:	53                   	push   %ebx
 1ea:	83 ec 2c             	sub    $0x2c,%esp
 1ed:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1f0:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 1f5:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 1f8:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 1fb:	83 c3 01             	add    $0x1,%ebx
 1fe:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 201:	7d 27                	jge    22a <gets+0x4a>
    cc = read(0, &c, 1);
 203:	83 ec 04             	sub    $0x4,%esp
 206:	6a 01                	push   $0x1
 208:	57                   	push   %edi
 209:	6a 00                	push   $0x0
 20b:	e8 03 01 00 00       	call   313 <read>
    if(cc < 1)
 210:	83 c4 10             	add    $0x10,%esp
 213:	85 c0                	test   %eax,%eax
 215:	7e 13                	jle    22a <gets+0x4a>
      break;
    buf[i++] = c;
 217:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 21b:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 21f:	3c 0a                	cmp    $0xa,%al
 221:	74 04                	je     227 <gets+0x47>
 223:	3c 0d                	cmp    $0xd,%al
 225:	75 d1                	jne    1f8 <gets+0x18>
  for(i=0; i+1 < max; ){
 227:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 22a:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 22d:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 231:	89 f0                	mov    %esi,%eax
 233:	8d 65 f4             	lea    -0xc(%ebp),%esp
 236:	5b                   	pop    %ebx
 237:	5e                   	pop    %esi
 238:	5f                   	pop    %edi
 239:	5d                   	pop    %ebp
 23a:	c3                   	ret    

0000023b <stat>:

int
stat(char *n, struct stat *st)
{
 23b:	f3 0f 1e fb          	endbr32 
 23f:	55                   	push   %ebp
 240:	89 e5                	mov    %esp,%ebp
 242:	56                   	push   %esi
 243:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 244:	83 ec 08             	sub    $0x8,%esp
 247:	6a 00                	push   $0x0
 249:	ff 75 08             	pushl  0x8(%ebp)
 24c:	e8 ea 00 00 00       	call   33b <open>
  if(fd < 0)
 251:	83 c4 10             	add    $0x10,%esp
 254:	85 c0                	test   %eax,%eax
 256:	78 24                	js     27c <stat+0x41>
 258:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 25a:	83 ec 08             	sub    $0x8,%esp
 25d:	ff 75 0c             	pushl  0xc(%ebp)
 260:	50                   	push   %eax
 261:	e8 ed 00 00 00       	call   353 <fstat>
 266:	89 c6                	mov    %eax,%esi
  close(fd);
 268:	89 1c 24             	mov    %ebx,(%esp)
 26b:	e8 b3 00 00 00       	call   323 <close>
  return r;
 270:	83 c4 10             	add    $0x10,%esp
}
 273:	89 f0                	mov    %esi,%eax
 275:	8d 65 f8             	lea    -0x8(%ebp),%esp
 278:	5b                   	pop    %ebx
 279:	5e                   	pop    %esi
 27a:	5d                   	pop    %ebp
 27b:	c3                   	ret    
    return -1;
 27c:	be ff ff ff ff       	mov    $0xffffffff,%esi
 281:	eb f0                	jmp    273 <stat+0x38>

00000283 <atoi>:

int
atoi(const char *s)
{
 283:	f3 0f 1e fb          	endbr32 
 287:	55                   	push   %ebp
 288:	89 e5                	mov    %esp,%ebp
 28a:	53                   	push   %ebx
 28b:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 28e:	0f b6 02             	movzbl (%edx),%eax
 291:	8d 48 d0             	lea    -0x30(%eax),%ecx
 294:	80 f9 09             	cmp    $0x9,%cl
 297:	77 22                	ja     2bb <atoi+0x38>
  n = 0;
 299:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 29e:	83 c2 01             	add    $0x1,%edx
 2a1:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2a4:	0f be c0             	movsbl %al,%eax
 2a7:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 2ab:	0f b6 02             	movzbl (%edx),%eax
 2ae:	8d 58 d0             	lea    -0x30(%eax),%ebx
 2b1:	80 fb 09             	cmp    $0x9,%bl
 2b4:	76 e8                	jbe    29e <atoi+0x1b>
  return n;
}
 2b6:	89 c8                	mov    %ecx,%eax
 2b8:	5b                   	pop    %ebx
 2b9:	5d                   	pop    %ebp
 2ba:	c3                   	ret    
  n = 0;
 2bb:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 2c0:	eb f4                	jmp    2b6 <atoi+0x33>

000002c2 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 2c2:	f3 0f 1e fb          	endbr32 
 2c6:	55                   	push   %ebp
 2c7:	89 e5                	mov    %esp,%ebp
 2c9:	56                   	push   %esi
 2ca:	53                   	push   %ebx
 2cb:	8b 75 08             	mov    0x8(%ebp),%esi
 2ce:	8b 55 0c             	mov    0xc(%ebp),%edx
 2d1:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2d4:	85 db                	test   %ebx,%ebx
 2d6:	7e 15                	jle    2ed <memmove+0x2b>
 2d8:	01 f3                	add    %esi,%ebx
  dst = vdst;
 2da:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 2dc:	83 c2 01             	add    $0x1,%edx
 2df:	83 c0 01             	add    $0x1,%eax
 2e2:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 2e6:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 2e9:	39 c3                	cmp    %eax,%ebx
 2eb:	75 ef                	jne    2dc <memmove+0x1a>
  return vdst;
}
 2ed:	89 f0                	mov    %esi,%eax
 2ef:	5b                   	pop    %ebx
 2f0:	5e                   	pop    %esi
 2f1:	5d                   	pop    %ebp
 2f2:	c3                   	ret    

000002f3 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 2f3:	b8 01 00 00 00       	mov    $0x1,%eax
 2f8:	cd 40                	int    $0x40
 2fa:	c3                   	ret    

000002fb <exit>:
SYSCALL(exit)
 2fb:	b8 02 00 00 00       	mov    $0x2,%eax
 300:	cd 40                	int    $0x40
 302:	c3                   	ret    

00000303 <wait>:
SYSCALL(wait)
 303:	b8 03 00 00 00       	mov    $0x3,%eax
 308:	cd 40                	int    $0x40
 30a:	c3                   	ret    

0000030b <pipe>:
SYSCALL(pipe)
 30b:	b8 04 00 00 00       	mov    $0x4,%eax
 310:	cd 40                	int    $0x40
 312:	c3                   	ret    

00000313 <read>:
SYSCALL(read)
 313:	b8 05 00 00 00       	mov    $0x5,%eax
 318:	cd 40                	int    $0x40
 31a:	c3                   	ret    

0000031b <write>:
SYSCALL(write)
 31b:	b8 10 00 00 00       	mov    $0x10,%eax
 320:	cd 40                	int    $0x40
 322:	c3                   	ret    

00000323 <close>:
SYSCALL(close)
 323:	b8 15 00 00 00       	mov    $0x15,%eax
 328:	cd 40                	int    $0x40
 32a:	c3                   	ret    

0000032b <kill>:
SYSCALL(kill)
 32b:	b8 06 00 00 00       	mov    $0x6,%eax
 330:	cd 40                	int    $0x40
 332:	c3                   	ret    

00000333 <exec>:
SYSCALL(exec)
 333:	b8 07 00 00 00       	mov    $0x7,%eax
 338:	cd 40                	int    $0x40
 33a:	c3                   	ret    

0000033b <open>:
SYSCALL(open)
 33b:	b8 0f 00 00 00       	mov    $0xf,%eax
 340:	cd 40                	int    $0x40
 342:	c3                   	ret    

00000343 <mknod>:
SYSCALL(mknod)
 343:	b8 11 00 00 00       	mov    $0x11,%eax
 348:	cd 40                	int    $0x40
 34a:	c3                   	ret    

0000034b <unlink>:
SYSCALL(unlink)
 34b:	b8 12 00 00 00       	mov    $0x12,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <fstat>:
SYSCALL(fstat)
 353:	b8 08 00 00 00       	mov    $0x8,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <link>:
SYSCALL(link)
 35b:	b8 13 00 00 00       	mov    $0x13,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <mkdir>:
SYSCALL(mkdir)
 363:	b8 14 00 00 00       	mov    $0x14,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <chdir>:
SYSCALL(chdir)
 36b:	b8 09 00 00 00       	mov    $0x9,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <dup>:
SYSCALL(dup)
 373:	b8 0a 00 00 00       	mov    $0xa,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <getpid>:
SYSCALL(getpid)
 37b:	b8 0b 00 00 00       	mov    $0xb,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <sbrk>:
SYSCALL(sbrk)
 383:	b8 0c 00 00 00       	mov    $0xc,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <sleep>:
SYSCALL(sleep)
 38b:	b8 0d 00 00 00       	mov    $0xd,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <uptime>:
SYSCALL(uptime)
 393:	b8 0e 00 00 00       	mov    $0xe,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 39b:	55                   	push   %ebp
 39c:	89 e5                	mov    %esp,%ebp
 39e:	57                   	push   %edi
 39f:	56                   	push   %esi
 3a0:	53                   	push   %ebx
 3a1:	83 ec 3c             	sub    $0x3c,%esp
 3a4:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3a7:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 3a9:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 3ad:	74 77                	je     426 <printint+0x8b>
 3af:	85 d2                	test   %edx,%edx
 3b1:	79 73                	jns    426 <printint+0x8b>
    neg = 1;
    x = -xx;
 3b3:	f7 db                	neg    %ebx
    neg = 1;
 3b5:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 3bc:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 3c1:	89 f7                	mov    %esi,%edi
 3c3:	83 c6 01             	add    $0x1,%esi
 3c6:	89 d8                	mov    %ebx,%eax
 3c8:	ba 00 00 00 00       	mov    $0x0,%edx
 3cd:	f7 f1                	div    %ecx
 3cf:	0f b6 92 74 07 00 00 	movzbl 0x774(%edx),%edx
 3d6:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 3da:	89 da                	mov    %ebx,%edx
 3dc:	89 c3                	mov    %eax,%ebx
 3de:	39 d1                	cmp    %edx,%ecx
 3e0:	76 df                	jbe    3c1 <printint+0x26>
  if(neg)
 3e2:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 3e6:	74 08                	je     3f0 <printint+0x55>
    buf[i++] = '-';
 3e8:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 3ed:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 3f0:	85 f6                	test   %esi,%esi
 3f2:	7e 2a                	jle    41e <printint+0x83>
 3f4:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 3f8:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 3fb:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 3fe:	0f b6 03             	movzbl (%ebx),%eax
 401:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 404:	83 ec 04             	sub    $0x4,%esp
 407:	6a 01                	push   $0x1
 409:	56                   	push   %esi
 40a:	ff 75 c4             	pushl  -0x3c(%ebp)
 40d:	e8 09 ff ff ff       	call   31b <write>
  while(--i >= 0)
 412:	89 d8                	mov    %ebx,%eax
 414:	83 eb 01             	sub    $0x1,%ebx
 417:	83 c4 10             	add    $0x10,%esp
 41a:	39 f8                	cmp    %edi,%eax
 41c:	75 e0                	jne    3fe <printint+0x63>
}
 41e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 421:	5b                   	pop    %ebx
 422:	5e                   	pop    %esi
 423:	5f                   	pop    %edi
 424:	5d                   	pop    %ebp
 425:	c3                   	ret    
  neg = 0;
 426:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 42d:	eb 8d                	jmp    3bc <printint+0x21>

0000042f <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 42f:	f3 0f 1e fb          	endbr32 
 433:	55                   	push   %ebp
 434:	89 e5                	mov    %esp,%ebp
 436:	57                   	push   %edi
 437:	56                   	push   %esi
 438:	53                   	push   %ebx
 439:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 43c:	8b 75 0c             	mov    0xc(%ebp),%esi
 43f:	0f b6 1e             	movzbl (%esi),%ebx
 442:	84 db                	test   %bl,%bl
 444:	0f 84 ab 01 00 00    	je     5f5 <printf+0x1c6>
 44a:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 44d:	8d 45 10             	lea    0x10(%ebp),%eax
 450:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 453:	bf 00 00 00 00       	mov    $0x0,%edi
 458:	eb 2d                	jmp    487 <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 45a:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 45d:	83 ec 04             	sub    $0x4,%esp
 460:	6a 01                	push   $0x1
 462:	8d 45 e7             	lea    -0x19(%ebp),%eax
 465:	50                   	push   %eax
 466:	ff 75 08             	pushl  0x8(%ebp)
 469:	e8 ad fe ff ff       	call   31b <write>
        putc(fd, c);
 46e:	83 c4 10             	add    $0x10,%esp
 471:	eb 05                	jmp    478 <printf+0x49>
      }
    } else if(state == '%'){
 473:	83 ff 25             	cmp    $0x25,%edi
 476:	74 22                	je     49a <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 478:	83 c6 01             	add    $0x1,%esi
 47b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 47f:	84 db                	test   %bl,%bl
 481:	0f 84 6e 01 00 00    	je     5f5 <printf+0x1c6>
    c = fmt[i] & 0xff;
 487:	0f be d3             	movsbl %bl,%edx
 48a:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 48d:	85 ff                	test   %edi,%edi
 48f:	75 e2                	jne    473 <printf+0x44>
      if(c == '%'){
 491:	83 f8 25             	cmp    $0x25,%eax
 494:	75 c4                	jne    45a <printf+0x2b>
        state = '%';
 496:	89 c7                	mov    %eax,%edi
 498:	eb de                	jmp    478 <printf+0x49>
      if(c == 'd'){
 49a:	83 f8 64             	cmp    $0x64,%eax
 49d:	74 59                	je     4f8 <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 49f:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 4a5:	83 fa 70             	cmp    $0x70,%edx
 4a8:	74 7a                	je     524 <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 4aa:	83 f8 73             	cmp    $0x73,%eax
 4ad:	0f 84 9d 00 00 00    	je     550 <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 4b3:	83 f8 63             	cmp    $0x63,%eax
 4b6:	0f 84 ec 00 00 00    	je     5a8 <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 4bc:	83 f8 25             	cmp    $0x25,%eax
 4bf:	0f 84 0f 01 00 00    	je     5d4 <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 4c5:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 4c9:	83 ec 04             	sub    $0x4,%esp
 4cc:	6a 01                	push   $0x1
 4ce:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4d1:	50                   	push   %eax
 4d2:	ff 75 08             	pushl  0x8(%ebp)
 4d5:	e8 41 fe ff ff       	call   31b <write>
        putc(fd, c);
 4da:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4dd:	83 c4 0c             	add    $0xc,%esp
 4e0:	6a 01                	push   $0x1
 4e2:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4e5:	50                   	push   %eax
 4e6:	ff 75 08             	pushl  0x8(%ebp)
 4e9:	e8 2d fe ff ff       	call   31b <write>
        putc(fd, c);
 4ee:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 4f1:	bf 00 00 00 00       	mov    $0x0,%edi
 4f6:	eb 80                	jmp    478 <printf+0x49>
        printint(fd, *ap, 10, 1);
 4f8:	83 ec 0c             	sub    $0xc,%esp
 4fb:	6a 01                	push   $0x1
 4fd:	b9 0a 00 00 00       	mov    $0xa,%ecx
 502:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 505:	8b 17                	mov    (%edi),%edx
 507:	8b 45 08             	mov    0x8(%ebp),%eax
 50a:	e8 8c fe ff ff       	call   39b <printint>
        ap++;
 50f:	89 f8                	mov    %edi,%eax
 511:	83 c0 04             	add    $0x4,%eax
 514:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 517:	83 c4 10             	add    $0x10,%esp
      state = 0;
 51a:	bf 00 00 00 00       	mov    $0x0,%edi
 51f:	e9 54 ff ff ff       	jmp    478 <printf+0x49>
        printint(fd, *ap, 16, 0);
 524:	83 ec 0c             	sub    $0xc,%esp
 527:	6a 00                	push   $0x0
 529:	b9 10 00 00 00       	mov    $0x10,%ecx
 52e:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 531:	8b 17                	mov    (%edi),%edx
 533:	8b 45 08             	mov    0x8(%ebp),%eax
 536:	e8 60 fe ff ff       	call   39b <printint>
        ap++;
 53b:	89 f8                	mov    %edi,%eax
 53d:	83 c0 04             	add    $0x4,%eax
 540:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 543:	83 c4 10             	add    $0x10,%esp
      state = 0;
 546:	bf 00 00 00 00       	mov    $0x0,%edi
 54b:	e9 28 ff ff ff       	jmp    478 <printf+0x49>
        s = (char*)*ap;
 550:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 553:	8b 01                	mov    (%ecx),%eax
        ap++;
 555:	83 c1 04             	add    $0x4,%ecx
 558:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 55b:	85 c0                	test   %eax,%eax
 55d:	74 13                	je     572 <printf+0x143>
        s = (char*)*ap;
 55f:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 561:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 564:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 569:	84 c0                	test   %al,%al
 56b:	75 0f                	jne    57c <printf+0x14d>
 56d:	e9 06 ff ff ff       	jmp    478 <printf+0x49>
          s = "(null)";
 572:	bb 6b 07 00 00       	mov    $0x76b,%ebx
        while(*s != 0){
 577:	b8 28 00 00 00       	mov    $0x28,%eax
 57c:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 57f:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 582:	83 ec 04             	sub    $0x4,%esp
 585:	6a 01                	push   $0x1
 587:	8d 45 e7             	lea    -0x19(%ebp),%eax
 58a:	50                   	push   %eax
 58b:	57                   	push   %edi
 58c:	e8 8a fd ff ff       	call   31b <write>
          s++;
 591:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 594:	0f b6 03             	movzbl (%ebx),%eax
 597:	83 c4 10             	add    $0x10,%esp
 59a:	84 c0                	test   %al,%al
 59c:	75 e1                	jne    57f <printf+0x150>
      state = 0;
 59e:	bf 00 00 00 00       	mov    $0x0,%edi
 5a3:	e9 d0 fe ff ff       	jmp    478 <printf+0x49>
        putc(fd, *ap);
 5a8:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 5ab:	8b 07                	mov    (%edi),%eax
 5ad:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5b0:	83 ec 04             	sub    $0x4,%esp
 5b3:	6a 01                	push   $0x1
 5b5:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5b8:	50                   	push   %eax
 5b9:	ff 75 08             	pushl  0x8(%ebp)
 5bc:	e8 5a fd ff ff       	call   31b <write>
        ap++;
 5c1:	83 c7 04             	add    $0x4,%edi
 5c4:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 5c7:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5ca:	bf 00 00 00 00       	mov    $0x0,%edi
 5cf:	e9 a4 fe ff ff       	jmp    478 <printf+0x49>
        putc(fd, c);
 5d4:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5d7:	83 ec 04             	sub    $0x4,%esp
 5da:	6a 01                	push   $0x1
 5dc:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5df:	50                   	push   %eax
 5e0:	ff 75 08             	pushl  0x8(%ebp)
 5e3:	e8 33 fd ff ff       	call   31b <write>
 5e8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 5eb:	bf 00 00 00 00       	mov    $0x0,%edi
 5f0:	e9 83 fe ff ff       	jmp    478 <printf+0x49>
    }
  }
}
 5f5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f8:	5b                   	pop    %ebx
 5f9:	5e                   	pop    %esi
 5fa:	5f                   	pop    %edi
 5fb:	5d                   	pop    %ebp
 5fc:	c3                   	ret    

000005fd <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 5fd:	f3 0f 1e fb          	endbr32 
 601:	55                   	push   %ebp
 602:	89 e5                	mov    %esp,%ebp
 604:	57                   	push   %edi
 605:	56                   	push   %esi
 606:	53                   	push   %ebx
 607:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 60a:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 60d:	a1 e8 09 00 00       	mov    0x9e8,%eax
 612:	eb 0c                	jmp    620 <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 614:	8b 10                	mov    (%eax),%edx
 616:	39 c2                	cmp    %eax,%edx
 618:	77 04                	ja     61e <free+0x21>
 61a:	39 ca                	cmp    %ecx,%edx
 61c:	77 10                	ja     62e <free+0x31>
{
 61e:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 620:	39 c8                	cmp    %ecx,%eax
 622:	73 f0                	jae    614 <free+0x17>
 624:	8b 10                	mov    (%eax),%edx
 626:	39 ca                	cmp    %ecx,%edx
 628:	77 04                	ja     62e <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 62a:	39 c2                	cmp    %eax,%edx
 62c:	77 f0                	ja     61e <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 62e:	8b 73 fc             	mov    -0x4(%ebx),%esi
 631:	8b 10                	mov    (%eax),%edx
 633:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 636:	39 fa                	cmp    %edi,%edx
 638:	74 19                	je     653 <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 63a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 63d:	8b 50 04             	mov    0x4(%eax),%edx
 640:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 643:	39 f1                	cmp    %esi,%ecx
 645:	74 1b                	je     662 <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 647:	89 08                	mov    %ecx,(%eax)
  freep = p;
 649:	a3 e8 09 00 00       	mov    %eax,0x9e8
}
 64e:	5b                   	pop    %ebx
 64f:	5e                   	pop    %esi
 650:	5f                   	pop    %edi
 651:	5d                   	pop    %ebp
 652:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 653:	03 72 04             	add    0x4(%edx),%esi
 656:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 659:	8b 10                	mov    (%eax),%edx
 65b:	8b 12                	mov    (%edx),%edx
 65d:	89 53 f8             	mov    %edx,-0x8(%ebx)
 660:	eb db                	jmp    63d <free+0x40>
    p->s.size += bp->s.size;
 662:	03 53 fc             	add    -0x4(%ebx),%edx
 665:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 668:	8b 53 f8             	mov    -0x8(%ebx),%edx
 66b:	89 10                	mov    %edx,(%eax)
 66d:	eb da                	jmp    649 <free+0x4c>

0000066f <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 66f:	f3 0f 1e fb          	endbr32 
 673:	55                   	push   %ebp
 674:	89 e5                	mov    %esp,%ebp
 676:	57                   	push   %edi
 677:	56                   	push   %esi
 678:	53                   	push   %ebx
 679:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 67c:	8b 45 08             	mov    0x8(%ebp),%eax
 67f:	8d 58 07             	lea    0x7(%eax),%ebx
 682:	c1 eb 03             	shr    $0x3,%ebx
 685:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 688:	8b 15 e8 09 00 00    	mov    0x9e8,%edx
 68e:	85 d2                	test   %edx,%edx
 690:	74 20                	je     6b2 <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 692:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 694:	8b 48 04             	mov    0x4(%eax),%ecx
 697:	39 cb                	cmp    %ecx,%ebx
 699:	76 3c                	jbe    6d7 <malloc+0x68>
 69b:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 6a1:	be 00 10 00 00       	mov    $0x1000,%esi
 6a6:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 6a9:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 6b0:	eb 72                	jmp    724 <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 6b2:	c7 05 e8 09 00 00 ec 	movl   $0x9ec,0x9e8
 6b9:	09 00 00 
 6bc:	c7 05 ec 09 00 00 ec 	movl   $0x9ec,0x9ec
 6c3:	09 00 00 
    base.s.size = 0;
 6c6:	c7 05 f0 09 00 00 00 	movl   $0x0,0x9f0
 6cd:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6d0:	b8 ec 09 00 00       	mov    $0x9ec,%eax
 6d5:	eb c4                	jmp    69b <malloc+0x2c>
      if(p->s.size == nunits)
 6d7:	39 cb                	cmp    %ecx,%ebx
 6d9:	74 1e                	je     6f9 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 6db:	29 d9                	sub    %ebx,%ecx
 6dd:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 6e0:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 6e3:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 6e6:	89 15 e8 09 00 00    	mov    %edx,0x9e8
      return (void*)(p + 1);
 6ec:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 6ef:	89 d0                	mov    %edx,%eax
 6f1:	8d 65 f4             	lea    -0xc(%ebp),%esp
 6f4:	5b                   	pop    %ebx
 6f5:	5e                   	pop    %esi
 6f6:	5f                   	pop    %edi
 6f7:	5d                   	pop    %ebp
 6f8:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 6f9:	8b 08                	mov    (%eax),%ecx
 6fb:	89 0a                	mov    %ecx,(%edx)
 6fd:	eb e7                	jmp    6e6 <malloc+0x77>
  hp->s.size = nu;
 6ff:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 702:	83 ec 0c             	sub    $0xc,%esp
 705:	83 c0 08             	add    $0x8,%eax
 708:	50                   	push   %eax
 709:	e8 ef fe ff ff       	call   5fd <free>
  return freep;
 70e:	8b 15 e8 09 00 00    	mov    0x9e8,%edx
      if((p = morecore(nunits)) == 0)
 714:	83 c4 10             	add    $0x10,%esp
 717:	85 d2                	test   %edx,%edx
 719:	74 d4                	je     6ef <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 71b:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 71d:	8b 48 04             	mov    0x4(%eax),%ecx
 720:	39 d9                	cmp    %ebx,%ecx
 722:	73 b3                	jae    6d7 <malloc+0x68>
    if(p == freep)
 724:	89 c2                	mov    %eax,%edx
 726:	39 05 e8 09 00 00    	cmp    %eax,0x9e8
 72c:	75 ed                	jne    71b <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 72e:	83 ec 0c             	sub    $0xc,%esp
 731:	57                   	push   %edi
 732:	e8 4c fc ff ff       	call   383 <sbrk>
  if(p == (char*)-1)
 737:	83 c4 10             	add    $0x10,%esp
 73a:	83 f8 ff             	cmp    $0xffffffff,%eax
 73d:	75 c0                	jne    6ff <malloc+0x90>
        return 0;
 73f:	ba 00 00 00 00       	mov    $0x0,%edx
 744:	eb a9                	jmp    6ef <malloc+0x80>
