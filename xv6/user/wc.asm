
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <wc>:

char buf[512];

void
wc(int fd, char *name)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	57                   	push   %edi
   8:	56                   	push   %esi
   9:	53                   	push   %ebx
   a:	83 ec 1c             	sub    $0x1c,%esp
  int i, n;
  int l, w, c, inword;

  l = w = c = 0;
  inword = 0;
   d:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  14:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  1b:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  22:	be 00 00 00 00       	mov    $0x0,%esi
  while((n = read(fd, buf, sizeof(buf))) > 0){
  27:	eb 4d                	jmp    76 <wc+0x76>
      c++;
      if(buf[i] == '\n')
        l++;
      if(strchr(" \r\t\n\v", buf[i]))
        inword = 0;
      else if(!inword){
  29:	83 7d e4 00          	cmpl   $0x0,-0x1c(%ebp)
  2d:	75 0b                	jne    3a <wc+0x3a>
        w++;
  2f:	83 45 e0 01          	addl   $0x1,-0x20(%ebp)
        inword = 1;
  33:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
  3a:	83 c3 01             	add    $0x1,%ebx
  3d:	39 df                	cmp    %ebx,%edi
  3f:	74 32                	je     73 <wc+0x73>
      if(buf[i] == '\n')
  41:	0f b6 83 c0 0a 00 00 	movzbl 0xac0(%ebx),%eax
        l++;
  48:	3c 0a                	cmp    $0xa,%al
  4a:	0f 94 c2             	sete   %dl
  4d:	0f b6 d2             	movzbl %dl,%edx
  50:	01 d6                	add    %edx,%esi
      if(strchr(" \r\t\n\v", buf[i]))
  52:	83 ec 08             	sub    $0x8,%esp
  55:	0f be c0             	movsbl %al,%eax
  58:	50                   	push   %eax
  59:	68 a0 07 00 00       	push   $0x7a0
  5e:	e8 a4 01 00 00       	call   207 <strchr>
  63:	83 c4 10             	add    $0x10,%esp
  66:	85 c0                	test   %eax,%eax
  68:	74 bf                	je     29 <wc+0x29>
        inword = 0;
  6a:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  71:	eb c7                	jmp    3a <wc+0x3a>
  73:	01 5d dc             	add    %ebx,-0x24(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  76:	83 ec 04             	sub    $0x4,%esp
  79:	68 00 02 00 00       	push   $0x200
  7e:	68 c0 0a 00 00       	push   $0xac0
  83:	ff 75 08             	pushl  0x8(%ebp)
  86:	e8 e0 02 00 00       	call   36b <read>
  8b:	89 c7                	mov    %eax,%edi
  8d:	83 c4 10             	add    $0x10,%esp
  90:	85 c0                	test   %eax,%eax
  92:	7e 07                	jle    9b <wc+0x9b>
    for(i=0; i<n; i++){
  94:	bb 00 00 00 00       	mov    $0x0,%ebx
  99:	eb a6                	jmp    41 <wc+0x41>
      }
    }
  }
  if(n < 0){
  9b:	78 24                	js     c1 <wc+0xc1>
    printf(1, "wc: read error\n");
    exit();
  }
  printf(1, "%d %d %d %s\n", l, w, c, name);
  9d:	83 ec 08             	sub    $0x8,%esp
  a0:	ff 75 0c             	pushl  0xc(%ebp)
  a3:	ff 75 dc             	pushl  -0x24(%ebp)
  a6:	ff 75 e0             	pushl  -0x20(%ebp)
  a9:	56                   	push   %esi
  aa:	68 b6 07 00 00       	push   $0x7b6
  af:	6a 01                	push   $0x1
  b1:	e8 d1 03 00 00       	call   487 <printf>
}
  b6:	83 c4 20             	add    $0x20,%esp
  b9:	8d 65 f4             	lea    -0xc(%ebp),%esp
  bc:	5b                   	pop    %ebx
  bd:	5e                   	pop    %esi
  be:	5f                   	pop    %edi
  bf:	5d                   	pop    %ebp
  c0:	c3                   	ret    
    printf(1, "wc: read error\n");
  c1:	83 ec 08             	sub    $0x8,%esp
  c4:	68 a6 07 00 00       	push   $0x7a6
  c9:	6a 01                	push   $0x1
  cb:	e8 b7 03 00 00       	call   487 <printf>
    exit();
  d0:	e8 7e 02 00 00       	call   353 <exit>

000000d5 <main>:

int
main(int argc, char *argv[])
{
  d5:	f3 0f 1e fb          	endbr32 
  d9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
  dd:	83 e4 f0             	and    $0xfffffff0,%esp
  e0:	ff 71 fc             	pushl  -0x4(%ecx)
  e3:	55                   	push   %ebp
  e4:	89 e5                	mov    %esp,%ebp
  e6:	57                   	push   %edi
  e7:	56                   	push   %esi
  e8:	53                   	push   %ebx
  e9:	51                   	push   %ecx
  ea:	83 ec 18             	sub    $0x18,%esp
  ed:	8b 01                	mov    (%ecx),%eax
  ef:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  f2:	8b 71 04             	mov    0x4(%ecx),%esi
  int fd, i;

  if(argc <= 1){
  f5:	83 c6 04             	add    $0x4,%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
  f8:	bf 01 00 00 00       	mov    $0x1,%edi
  if(argc <= 1){
  fd:	83 f8 01             	cmp    $0x1,%eax
 100:	7e 3e                	jle    140 <main+0x6b>
    if((fd = open(argv[i], 0)) < 0){
 102:	89 75 e0             	mov    %esi,-0x20(%ebp)
 105:	83 ec 08             	sub    $0x8,%esp
 108:	6a 00                	push   $0x0
 10a:	ff 36                	pushl  (%esi)
 10c:	e8 82 02 00 00       	call   393 <open>
 111:	89 c3                	mov    %eax,%ebx
 113:	83 c4 10             	add    $0x10,%esp
 116:	85 c0                	test   %eax,%eax
 118:	78 3a                	js     154 <main+0x7f>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
 11a:	83 ec 08             	sub    $0x8,%esp
 11d:	ff 36                	pushl  (%esi)
 11f:	50                   	push   %eax
 120:	e8 db fe ff ff       	call   0 <wc>
    close(fd);
 125:	89 1c 24             	mov    %ebx,(%esp)
 128:	e8 4e 02 00 00       	call   37b <close>
  for(i = 1; i < argc; i++){
 12d:	83 c7 01             	add    $0x1,%edi
 130:	83 c6 04             	add    $0x4,%esi
 133:	83 c4 10             	add    $0x10,%esp
 136:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 139:	75 c7                	jne    102 <main+0x2d>
  }
  exit();
 13b:	e8 13 02 00 00       	call   353 <exit>
    wc(0, "");
 140:	83 ec 08             	sub    $0x8,%esp
 143:	68 b5 07 00 00       	push   $0x7b5
 148:	6a 00                	push   $0x0
 14a:	e8 b1 fe ff ff       	call   0 <wc>
    exit();
 14f:	e8 ff 01 00 00       	call   353 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
 154:	83 ec 04             	sub    $0x4,%esp
 157:	8b 45 e0             	mov    -0x20(%ebp),%eax
 15a:	ff 30                	pushl  (%eax)
 15c:	68 c3 07 00 00       	push   $0x7c3
 161:	6a 01                	push   $0x1
 163:	e8 1f 03 00 00       	call   487 <printf>
      exit();
 168:	e8 e6 01 00 00       	call   353 <exit>

0000016d <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 16d:	f3 0f 1e fb          	endbr32 
 171:	55                   	push   %ebp
 172:	89 e5                	mov    %esp,%ebp
 174:	53                   	push   %ebx
 175:	8b 4d 08             	mov    0x8(%ebp),%ecx
 178:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 17b:	b8 00 00 00 00       	mov    $0x0,%eax
 180:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 184:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 187:	83 c0 01             	add    $0x1,%eax
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strcpy+0x13>
    ;
  return os;
}
 18e:	89 c8                	mov    %ecx,%eax
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    

00000193 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 193:	f3 0f 1e fb          	endbr32 
 197:	55                   	push   %ebp
 198:	89 e5                	mov    %esp,%ebp
 19a:	8b 4d 08             	mov    0x8(%ebp),%ecx
 19d:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 1a0:	0f b6 01             	movzbl (%ecx),%eax
 1a3:	84 c0                	test   %al,%al
 1a5:	74 11                	je     1b8 <strcmp+0x25>
 1a7:	38 02                	cmp    %al,(%edx)
 1a9:	75 0d                	jne    1b8 <strcmp+0x25>
    p++, q++;
 1ab:	83 c1 01             	add    $0x1,%ecx
 1ae:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1b1:	0f b6 01             	movzbl (%ecx),%eax
 1b4:	84 c0                	test   %al,%al
 1b6:	75 ef                	jne    1a7 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 1b8:	0f b6 c0             	movzbl %al,%eax
 1bb:	0f b6 12             	movzbl (%edx),%edx
 1be:	29 d0                	sub    %edx,%eax
}
 1c0:	5d                   	pop    %ebp
 1c1:	c3                   	ret    

000001c2 <strlen>:

uint
strlen(char *s)
{
 1c2:	f3 0f 1e fb          	endbr32 
 1c6:	55                   	push   %ebp
 1c7:	89 e5                	mov    %esp,%ebp
 1c9:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 1cc:	80 3a 00             	cmpb   $0x0,(%edx)
 1cf:	74 14                	je     1e5 <strlen+0x23>
 1d1:	b8 00 00 00 00       	mov    $0x0,%eax
 1d6:	83 c0 01             	add    $0x1,%eax
 1d9:	89 c1                	mov    %eax,%ecx
 1db:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 1df:	75 f5                	jne    1d6 <strlen+0x14>
    ;
  return n;
}
 1e1:	89 c8                	mov    %ecx,%eax
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
  for(n = 0; s[n]; n++)
 1e5:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 1ea:	eb f5                	jmp    1e1 <strlen+0x1f>

000001ec <memset>:

void*
memset(void *dst, int c, uint n)
{
 1ec:	f3 0f 1e fb          	endbr32 
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	89 d7                	mov    %edx,%edi
 1f9:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fc:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    

00000207 <strchr>:

char*
strchr(const char *s, char c)
{
 207:	f3 0f 1e fb          	endbr32 
 20b:	55                   	push   %ebp
 20c:	89 e5                	mov    %esp,%ebp
 20e:	8b 45 08             	mov    0x8(%ebp),%eax
 211:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 215:	0f b6 10             	movzbl (%eax),%edx
 218:	84 d2                	test   %dl,%dl
 21a:	74 15                	je     231 <strchr+0x2a>
    if(*s == c)
 21c:	38 d1                	cmp    %dl,%cl
 21e:	74 0f                	je     22f <strchr+0x28>
  for(; *s; s++)
 220:	83 c0 01             	add    $0x1,%eax
 223:	0f b6 10             	movzbl (%eax),%edx
 226:	84 d2                	test   %dl,%dl
 228:	75 f2                	jne    21c <strchr+0x15>
      return (char*)s;
  return 0;
 22a:	b8 00 00 00 00       	mov    $0x0,%eax
}
 22f:	5d                   	pop    %ebp
 230:	c3                   	ret    
  return 0;
 231:	b8 00 00 00 00       	mov    $0x0,%eax
 236:	eb f7                	jmp    22f <strchr+0x28>

00000238 <gets>:

char*
gets(char *buf, int max)
{
 238:	f3 0f 1e fb          	endbr32 
 23c:	55                   	push   %ebp
 23d:	89 e5                	mov    %esp,%ebp
 23f:	57                   	push   %edi
 240:	56                   	push   %esi
 241:	53                   	push   %ebx
 242:	83 ec 2c             	sub    $0x2c,%esp
 245:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 248:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 24d:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 250:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 253:	83 c3 01             	add    $0x1,%ebx
 256:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 259:	7d 27                	jge    282 <gets+0x4a>
    cc = read(0, &c, 1);
 25b:	83 ec 04             	sub    $0x4,%esp
 25e:	6a 01                	push   $0x1
 260:	57                   	push   %edi
 261:	6a 00                	push   $0x0
 263:	e8 03 01 00 00       	call   36b <read>
    if(cc < 1)
 268:	83 c4 10             	add    $0x10,%esp
 26b:	85 c0                	test   %eax,%eax
 26d:	7e 13                	jle    282 <gets+0x4a>
      break;
    buf[i++] = c;
 26f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 273:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 277:	3c 0a                	cmp    $0xa,%al
 279:	74 04                	je     27f <gets+0x47>
 27b:	3c 0d                	cmp    $0xd,%al
 27d:	75 d1                	jne    250 <gets+0x18>
  for(i=0; i+1 < max; ){
 27f:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 282:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 285:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 289:	89 f0                	mov    %esi,%eax
 28b:	8d 65 f4             	lea    -0xc(%ebp),%esp
 28e:	5b                   	pop    %ebx
 28f:	5e                   	pop    %esi
 290:	5f                   	pop    %edi
 291:	5d                   	pop    %ebp
 292:	c3                   	ret    

00000293 <stat>:

int
stat(char *n, struct stat *st)
{
 293:	f3 0f 1e fb          	endbr32 
 297:	55                   	push   %ebp
 298:	89 e5                	mov    %esp,%ebp
 29a:	56                   	push   %esi
 29b:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 29c:	83 ec 08             	sub    $0x8,%esp
 29f:	6a 00                	push   $0x0
 2a1:	ff 75 08             	pushl  0x8(%ebp)
 2a4:	e8 ea 00 00 00       	call   393 <open>
  if(fd < 0)
 2a9:	83 c4 10             	add    $0x10,%esp
 2ac:	85 c0                	test   %eax,%eax
 2ae:	78 24                	js     2d4 <stat+0x41>
 2b0:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 2b2:	83 ec 08             	sub    $0x8,%esp
 2b5:	ff 75 0c             	pushl  0xc(%ebp)
 2b8:	50                   	push   %eax
 2b9:	e8 ed 00 00 00       	call   3ab <fstat>
 2be:	89 c6                	mov    %eax,%esi
  close(fd);
 2c0:	89 1c 24             	mov    %ebx,(%esp)
 2c3:	e8 b3 00 00 00       	call   37b <close>
  return r;
 2c8:	83 c4 10             	add    $0x10,%esp
}
 2cb:	89 f0                	mov    %esi,%eax
 2cd:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2d0:	5b                   	pop    %ebx
 2d1:	5e                   	pop    %esi
 2d2:	5d                   	pop    %ebp
 2d3:	c3                   	ret    
    return -1;
 2d4:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2d9:	eb f0                	jmp    2cb <stat+0x38>

000002db <atoi>:

int
atoi(const char *s)
{
 2db:	f3 0f 1e fb          	endbr32 
 2df:	55                   	push   %ebp
 2e0:	89 e5                	mov    %esp,%ebp
 2e2:	53                   	push   %ebx
 2e3:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2e6:	0f b6 02             	movzbl (%edx),%eax
 2e9:	8d 48 d0             	lea    -0x30(%eax),%ecx
 2ec:	80 f9 09             	cmp    $0x9,%cl
 2ef:	77 22                	ja     313 <atoi+0x38>
  n = 0;
 2f1:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 2f6:	83 c2 01             	add    $0x1,%edx
 2f9:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 2fc:	0f be c0             	movsbl %al,%eax
 2ff:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 303:	0f b6 02             	movzbl (%edx),%eax
 306:	8d 58 d0             	lea    -0x30(%eax),%ebx
 309:	80 fb 09             	cmp    $0x9,%bl
 30c:	76 e8                	jbe    2f6 <atoi+0x1b>
  return n;
}
 30e:	89 c8                	mov    %ecx,%eax
 310:	5b                   	pop    %ebx
 311:	5d                   	pop    %ebp
 312:	c3                   	ret    
  n = 0;
 313:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 318:	eb f4                	jmp    30e <atoi+0x33>

0000031a <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 31a:	f3 0f 1e fb          	endbr32 
 31e:	55                   	push   %ebp
 31f:	89 e5                	mov    %esp,%ebp
 321:	56                   	push   %esi
 322:	53                   	push   %ebx
 323:	8b 75 08             	mov    0x8(%ebp),%esi
 326:	8b 55 0c             	mov    0xc(%ebp),%edx
 329:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 32c:	85 db                	test   %ebx,%ebx
 32e:	7e 15                	jle    345 <memmove+0x2b>
 330:	01 f3                	add    %esi,%ebx
  dst = vdst;
 332:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 334:	83 c2 01             	add    $0x1,%edx
 337:	83 c0 01             	add    $0x1,%eax
 33a:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 33e:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 341:	39 c3                	cmp    %eax,%ebx
 343:	75 ef                	jne    334 <memmove+0x1a>
  return vdst;
}
 345:	89 f0                	mov    %esi,%eax
 347:	5b                   	pop    %ebx
 348:	5e                   	pop    %esi
 349:	5d                   	pop    %ebp
 34a:	c3                   	ret    

0000034b <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 34b:	b8 01 00 00 00       	mov    $0x1,%eax
 350:	cd 40                	int    $0x40
 352:	c3                   	ret    

00000353 <exit>:
SYSCALL(exit)
 353:	b8 02 00 00 00       	mov    $0x2,%eax
 358:	cd 40                	int    $0x40
 35a:	c3                   	ret    

0000035b <wait>:
SYSCALL(wait)
 35b:	b8 03 00 00 00       	mov    $0x3,%eax
 360:	cd 40                	int    $0x40
 362:	c3                   	ret    

00000363 <pipe>:
SYSCALL(pipe)
 363:	b8 04 00 00 00       	mov    $0x4,%eax
 368:	cd 40                	int    $0x40
 36a:	c3                   	ret    

0000036b <read>:
SYSCALL(read)
 36b:	b8 05 00 00 00       	mov    $0x5,%eax
 370:	cd 40                	int    $0x40
 372:	c3                   	ret    

00000373 <write>:
SYSCALL(write)
 373:	b8 10 00 00 00       	mov    $0x10,%eax
 378:	cd 40                	int    $0x40
 37a:	c3                   	ret    

0000037b <close>:
SYSCALL(close)
 37b:	b8 15 00 00 00       	mov    $0x15,%eax
 380:	cd 40                	int    $0x40
 382:	c3                   	ret    

00000383 <kill>:
SYSCALL(kill)
 383:	b8 06 00 00 00       	mov    $0x6,%eax
 388:	cd 40                	int    $0x40
 38a:	c3                   	ret    

0000038b <exec>:
SYSCALL(exec)
 38b:	b8 07 00 00 00       	mov    $0x7,%eax
 390:	cd 40                	int    $0x40
 392:	c3                   	ret    

00000393 <open>:
SYSCALL(open)
 393:	b8 0f 00 00 00       	mov    $0xf,%eax
 398:	cd 40                	int    $0x40
 39a:	c3                   	ret    

0000039b <mknod>:
SYSCALL(mknod)
 39b:	b8 11 00 00 00       	mov    $0x11,%eax
 3a0:	cd 40                	int    $0x40
 3a2:	c3                   	ret    

000003a3 <unlink>:
SYSCALL(unlink)
 3a3:	b8 12 00 00 00       	mov    $0x12,%eax
 3a8:	cd 40                	int    $0x40
 3aa:	c3                   	ret    

000003ab <fstat>:
SYSCALL(fstat)
 3ab:	b8 08 00 00 00       	mov    $0x8,%eax
 3b0:	cd 40                	int    $0x40
 3b2:	c3                   	ret    

000003b3 <link>:
SYSCALL(link)
 3b3:	b8 13 00 00 00       	mov    $0x13,%eax
 3b8:	cd 40                	int    $0x40
 3ba:	c3                   	ret    

000003bb <mkdir>:
SYSCALL(mkdir)
 3bb:	b8 14 00 00 00       	mov    $0x14,%eax
 3c0:	cd 40                	int    $0x40
 3c2:	c3                   	ret    

000003c3 <chdir>:
SYSCALL(chdir)
 3c3:	b8 09 00 00 00       	mov    $0x9,%eax
 3c8:	cd 40                	int    $0x40
 3ca:	c3                   	ret    

000003cb <dup>:
SYSCALL(dup)
 3cb:	b8 0a 00 00 00       	mov    $0xa,%eax
 3d0:	cd 40                	int    $0x40
 3d2:	c3                   	ret    

000003d3 <getpid>:
SYSCALL(getpid)
 3d3:	b8 0b 00 00 00       	mov    $0xb,%eax
 3d8:	cd 40                	int    $0x40
 3da:	c3                   	ret    

000003db <sbrk>:
SYSCALL(sbrk)
 3db:	b8 0c 00 00 00       	mov    $0xc,%eax
 3e0:	cd 40                	int    $0x40
 3e2:	c3                   	ret    

000003e3 <sleep>:
SYSCALL(sleep)
 3e3:	b8 0d 00 00 00       	mov    $0xd,%eax
 3e8:	cd 40                	int    $0x40
 3ea:	c3                   	ret    

000003eb <uptime>:
SYSCALL(uptime)
 3eb:	b8 0e 00 00 00       	mov    $0xe,%eax
 3f0:	cd 40                	int    $0x40
 3f2:	c3                   	ret    

000003f3 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 3f3:	55                   	push   %ebp
 3f4:	89 e5                	mov    %esp,%ebp
 3f6:	57                   	push   %edi
 3f7:	56                   	push   %esi
 3f8:	53                   	push   %ebx
 3f9:	83 ec 3c             	sub    $0x3c,%esp
 3fc:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 3ff:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 401:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 405:	74 77                	je     47e <printint+0x8b>
 407:	85 d2                	test   %edx,%edx
 409:	79 73                	jns    47e <printint+0x8b>
    neg = 1;
    x = -xx;
 40b:	f7 db                	neg    %ebx
    neg = 1;
 40d:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 414:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 419:	89 f7                	mov    %esi,%edi
 41b:	83 c6 01             	add    $0x1,%esi
 41e:	89 d8                	mov    %ebx,%eax
 420:	ba 00 00 00 00       	mov    $0x0,%edx
 425:	f7 f1                	div    %ecx
 427:	0f b6 92 e0 07 00 00 	movzbl 0x7e0(%edx),%edx
 42e:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 432:	89 da                	mov    %ebx,%edx
 434:	89 c3                	mov    %eax,%ebx
 436:	39 d1                	cmp    %edx,%ecx
 438:	76 df                	jbe    419 <printint+0x26>
  if(neg)
 43a:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 43e:	74 08                	je     448 <printint+0x55>
    buf[i++] = '-';
 440:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 445:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 448:	85 f6                	test   %esi,%esi
 44a:	7e 2a                	jle    476 <printint+0x83>
 44c:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 450:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 453:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 456:	0f b6 03             	movzbl (%ebx),%eax
 459:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 45c:	83 ec 04             	sub    $0x4,%esp
 45f:	6a 01                	push   $0x1
 461:	56                   	push   %esi
 462:	ff 75 c4             	pushl  -0x3c(%ebp)
 465:	e8 09 ff ff ff       	call   373 <write>
  while(--i >= 0)
 46a:	89 d8                	mov    %ebx,%eax
 46c:	83 eb 01             	sub    $0x1,%ebx
 46f:	83 c4 10             	add    $0x10,%esp
 472:	39 f8                	cmp    %edi,%eax
 474:	75 e0                	jne    456 <printint+0x63>
}
 476:	8d 65 f4             	lea    -0xc(%ebp),%esp
 479:	5b                   	pop    %ebx
 47a:	5e                   	pop    %esi
 47b:	5f                   	pop    %edi
 47c:	5d                   	pop    %ebp
 47d:	c3                   	ret    
  neg = 0;
 47e:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 485:	eb 8d                	jmp    414 <printint+0x21>

00000487 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 487:	f3 0f 1e fb          	endbr32 
 48b:	55                   	push   %ebp
 48c:	89 e5                	mov    %esp,%ebp
 48e:	57                   	push   %edi
 48f:	56                   	push   %esi
 490:	53                   	push   %ebx
 491:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 494:	8b 75 0c             	mov    0xc(%ebp),%esi
 497:	0f b6 1e             	movzbl (%esi),%ebx
 49a:	84 db                	test   %bl,%bl
 49c:	0f 84 ab 01 00 00    	je     64d <printf+0x1c6>
 4a2:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 4a5:	8d 45 10             	lea    0x10(%ebp),%eax
 4a8:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 4ab:	bf 00 00 00 00       	mov    $0x0,%edi
 4b0:	eb 2d                	jmp    4df <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 4b2:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 4b5:	83 ec 04             	sub    $0x4,%esp
 4b8:	6a 01                	push   $0x1
 4ba:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4bd:	50                   	push   %eax
 4be:	ff 75 08             	pushl  0x8(%ebp)
 4c1:	e8 ad fe ff ff       	call   373 <write>
        putc(fd, c);
 4c6:	83 c4 10             	add    $0x10,%esp
 4c9:	eb 05                	jmp    4d0 <printf+0x49>
      }
    } else if(state == '%'){
 4cb:	83 ff 25             	cmp    $0x25,%edi
 4ce:	74 22                	je     4f2 <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 4d0:	83 c6 01             	add    $0x1,%esi
 4d3:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 4d7:	84 db                	test   %bl,%bl
 4d9:	0f 84 6e 01 00 00    	je     64d <printf+0x1c6>
    c = fmt[i] & 0xff;
 4df:	0f be d3             	movsbl %bl,%edx
 4e2:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 4e5:	85 ff                	test   %edi,%edi
 4e7:	75 e2                	jne    4cb <printf+0x44>
      if(c == '%'){
 4e9:	83 f8 25             	cmp    $0x25,%eax
 4ec:	75 c4                	jne    4b2 <printf+0x2b>
        state = '%';
 4ee:	89 c7                	mov    %eax,%edi
 4f0:	eb de                	jmp    4d0 <printf+0x49>
      if(c == 'd'){
 4f2:	83 f8 64             	cmp    $0x64,%eax
 4f5:	74 59                	je     550 <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 4f7:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 4fd:	83 fa 70             	cmp    $0x70,%edx
 500:	74 7a                	je     57c <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 502:	83 f8 73             	cmp    $0x73,%eax
 505:	0f 84 9d 00 00 00    	je     5a8 <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 50b:	83 f8 63             	cmp    $0x63,%eax
 50e:	0f 84 ec 00 00 00    	je     600 <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 514:	83 f8 25             	cmp    $0x25,%eax
 517:	0f 84 0f 01 00 00    	je     62c <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 51d:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 521:	83 ec 04             	sub    $0x4,%esp
 524:	6a 01                	push   $0x1
 526:	8d 45 e7             	lea    -0x19(%ebp),%eax
 529:	50                   	push   %eax
 52a:	ff 75 08             	pushl  0x8(%ebp)
 52d:	e8 41 fe ff ff       	call   373 <write>
        putc(fd, c);
 532:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 535:	83 c4 0c             	add    $0xc,%esp
 538:	6a 01                	push   $0x1
 53a:	8d 45 e7             	lea    -0x19(%ebp),%eax
 53d:	50                   	push   %eax
 53e:	ff 75 08             	pushl  0x8(%ebp)
 541:	e8 2d fe ff ff       	call   373 <write>
        putc(fd, c);
 546:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 549:	bf 00 00 00 00       	mov    $0x0,%edi
 54e:	eb 80                	jmp    4d0 <printf+0x49>
        printint(fd, *ap, 10, 1);
 550:	83 ec 0c             	sub    $0xc,%esp
 553:	6a 01                	push   $0x1
 555:	b9 0a 00 00 00       	mov    $0xa,%ecx
 55a:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 55d:	8b 17                	mov    (%edi),%edx
 55f:	8b 45 08             	mov    0x8(%ebp),%eax
 562:	e8 8c fe ff ff       	call   3f3 <printint>
        ap++;
 567:	89 f8                	mov    %edi,%eax
 569:	83 c0 04             	add    $0x4,%eax
 56c:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 56f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 572:	bf 00 00 00 00       	mov    $0x0,%edi
 577:	e9 54 ff ff ff       	jmp    4d0 <printf+0x49>
        printint(fd, *ap, 16, 0);
 57c:	83 ec 0c             	sub    $0xc,%esp
 57f:	6a 00                	push   $0x0
 581:	b9 10 00 00 00       	mov    $0x10,%ecx
 586:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 589:	8b 17                	mov    (%edi),%edx
 58b:	8b 45 08             	mov    0x8(%ebp),%eax
 58e:	e8 60 fe ff ff       	call   3f3 <printint>
        ap++;
 593:	89 f8                	mov    %edi,%eax
 595:	83 c0 04             	add    $0x4,%eax
 598:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 59b:	83 c4 10             	add    $0x10,%esp
      state = 0;
 59e:	bf 00 00 00 00       	mov    $0x0,%edi
 5a3:	e9 28 ff ff ff       	jmp    4d0 <printf+0x49>
        s = (char*)*ap;
 5a8:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 5ab:	8b 01                	mov    (%ecx),%eax
        ap++;
 5ad:	83 c1 04             	add    $0x4,%ecx
 5b0:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 5b3:	85 c0                	test   %eax,%eax
 5b5:	74 13                	je     5ca <printf+0x143>
        s = (char*)*ap;
 5b7:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 5b9:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 5bc:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 5c1:	84 c0                	test   %al,%al
 5c3:	75 0f                	jne    5d4 <printf+0x14d>
 5c5:	e9 06 ff ff ff       	jmp    4d0 <printf+0x49>
          s = "(null)";
 5ca:	bb d7 07 00 00       	mov    $0x7d7,%ebx
        while(*s != 0){
 5cf:	b8 28 00 00 00       	mov    $0x28,%eax
 5d4:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 5d7:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 5da:	83 ec 04             	sub    $0x4,%esp
 5dd:	6a 01                	push   $0x1
 5df:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5e2:	50                   	push   %eax
 5e3:	57                   	push   %edi
 5e4:	e8 8a fd ff ff       	call   373 <write>
          s++;
 5e9:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 5ec:	0f b6 03             	movzbl (%ebx),%eax
 5ef:	83 c4 10             	add    $0x10,%esp
 5f2:	84 c0                	test   %al,%al
 5f4:	75 e1                	jne    5d7 <printf+0x150>
      state = 0;
 5f6:	bf 00 00 00 00       	mov    $0x0,%edi
 5fb:	e9 d0 fe ff ff       	jmp    4d0 <printf+0x49>
        putc(fd, *ap);
 600:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 603:	8b 07                	mov    (%edi),%eax
 605:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 608:	83 ec 04             	sub    $0x4,%esp
 60b:	6a 01                	push   $0x1
 60d:	8d 45 e7             	lea    -0x19(%ebp),%eax
 610:	50                   	push   %eax
 611:	ff 75 08             	pushl  0x8(%ebp)
 614:	e8 5a fd ff ff       	call   373 <write>
        ap++;
 619:	83 c7 04             	add    $0x4,%edi
 61c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 61f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 622:	bf 00 00 00 00       	mov    $0x0,%edi
 627:	e9 a4 fe ff ff       	jmp    4d0 <printf+0x49>
        putc(fd, c);
 62c:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 62f:	83 ec 04             	sub    $0x4,%esp
 632:	6a 01                	push   $0x1
 634:	8d 45 e7             	lea    -0x19(%ebp),%eax
 637:	50                   	push   %eax
 638:	ff 75 08             	pushl  0x8(%ebp)
 63b:	e8 33 fd ff ff       	call   373 <write>
 640:	83 c4 10             	add    $0x10,%esp
      state = 0;
 643:	bf 00 00 00 00       	mov    $0x0,%edi
 648:	e9 83 fe ff ff       	jmp    4d0 <printf+0x49>
    }
  }
}
 64d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 650:	5b                   	pop    %ebx
 651:	5e                   	pop    %esi
 652:	5f                   	pop    %edi
 653:	5d                   	pop    %ebp
 654:	c3                   	ret    

00000655 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 655:	f3 0f 1e fb          	endbr32 
 659:	55                   	push   %ebp
 65a:	89 e5                	mov    %esp,%ebp
 65c:	57                   	push   %edi
 65d:	56                   	push   %esi
 65e:	53                   	push   %ebx
 65f:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 662:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 665:	a1 a0 0a 00 00       	mov    0xaa0,%eax
 66a:	eb 0c                	jmp    678 <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 66c:	8b 10                	mov    (%eax),%edx
 66e:	39 c2                	cmp    %eax,%edx
 670:	77 04                	ja     676 <free+0x21>
 672:	39 ca                	cmp    %ecx,%edx
 674:	77 10                	ja     686 <free+0x31>
{
 676:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 678:	39 c8                	cmp    %ecx,%eax
 67a:	73 f0                	jae    66c <free+0x17>
 67c:	8b 10                	mov    (%eax),%edx
 67e:	39 ca                	cmp    %ecx,%edx
 680:	77 04                	ja     686 <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 682:	39 c2                	cmp    %eax,%edx
 684:	77 f0                	ja     676 <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 686:	8b 73 fc             	mov    -0x4(%ebx),%esi
 689:	8b 10                	mov    (%eax),%edx
 68b:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 68e:	39 fa                	cmp    %edi,%edx
 690:	74 19                	je     6ab <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 692:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 695:	8b 50 04             	mov    0x4(%eax),%edx
 698:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 69b:	39 f1                	cmp    %esi,%ecx
 69d:	74 1b                	je     6ba <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 69f:	89 08                	mov    %ecx,(%eax)
  freep = p;
 6a1:	a3 a0 0a 00 00       	mov    %eax,0xaa0
}
 6a6:	5b                   	pop    %ebx
 6a7:	5e                   	pop    %esi
 6a8:	5f                   	pop    %edi
 6a9:	5d                   	pop    %ebp
 6aa:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 6ab:	03 72 04             	add    0x4(%edx),%esi
 6ae:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 6b1:	8b 10                	mov    (%eax),%edx
 6b3:	8b 12                	mov    (%edx),%edx
 6b5:	89 53 f8             	mov    %edx,-0x8(%ebx)
 6b8:	eb db                	jmp    695 <free+0x40>
    p->s.size += bp->s.size;
 6ba:	03 53 fc             	add    -0x4(%ebx),%edx
 6bd:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 6c0:	8b 53 f8             	mov    -0x8(%ebx),%edx
 6c3:	89 10                	mov    %edx,(%eax)
 6c5:	eb da                	jmp    6a1 <free+0x4c>

000006c7 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 6c7:	f3 0f 1e fb          	endbr32 
 6cb:	55                   	push   %ebp
 6cc:	89 e5                	mov    %esp,%ebp
 6ce:	57                   	push   %edi
 6cf:	56                   	push   %esi
 6d0:	53                   	push   %ebx
 6d1:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 6d4:	8b 45 08             	mov    0x8(%ebp),%eax
 6d7:	8d 58 07             	lea    0x7(%eax),%ebx
 6da:	c1 eb 03             	shr    $0x3,%ebx
 6dd:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 6e0:	8b 15 a0 0a 00 00    	mov    0xaa0,%edx
 6e6:	85 d2                	test   %edx,%edx
 6e8:	74 20                	je     70a <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 6ea:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 6ec:	8b 48 04             	mov    0x4(%eax),%ecx
 6ef:	39 cb                	cmp    %ecx,%ebx
 6f1:	76 3c                	jbe    72f <malloc+0x68>
 6f3:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 6f9:	be 00 10 00 00       	mov    $0x1000,%esi
 6fe:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 701:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 708:	eb 72                	jmp    77c <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 70a:	c7 05 a0 0a 00 00 a4 	movl   $0xaa4,0xaa0
 711:	0a 00 00 
 714:	c7 05 a4 0a 00 00 a4 	movl   $0xaa4,0xaa4
 71b:	0a 00 00 
    base.s.size = 0;
 71e:	c7 05 a8 0a 00 00 00 	movl   $0x0,0xaa8
 725:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 728:	b8 a4 0a 00 00       	mov    $0xaa4,%eax
 72d:	eb c4                	jmp    6f3 <malloc+0x2c>
      if(p->s.size == nunits)
 72f:	39 cb                	cmp    %ecx,%ebx
 731:	74 1e                	je     751 <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 733:	29 d9                	sub    %ebx,%ecx
 735:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 738:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 73b:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 73e:	89 15 a0 0a 00 00    	mov    %edx,0xaa0
      return (void*)(p + 1);
 744:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 747:	89 d0                	mov    %edx,%eax
 749:	8d 65 f4             	lea    -0xc(%ebp),%esp
 74c:	5b                   	pop    %ebx
 74d:	5e                   	pop    %esi
 74e:	5f                   	pop    %edi
 74f:	5d                   	pop    %ebp
 750:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 751:	8b 08                	mov    (%eax),%ecx
 753:	89 0a                	mov    %ecx,(%edx)
 755:	eb e7                	jmp    73e <malloc+0x77>
  hp->s.size = nu;
 757:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 75a:	83 ec 0c             	sub    $0xc,%esp
 75d:	83 c0 08             	add    $0x8,%eax
 760:	50                   	push   %eax
 761:	e8 ef fe ff ff       	call   655 <free>
  return freep;
 766:	8b 15 a0 0a 00 00    	mov    0xaa0,%edx
      if((p = morecore(nunits)) == 0)
 76c:	83 c4 10             	add    $0x10,%esp
 76f:	85 d2                	test   %edx,%edx
 771:	74 d4                	je     747 <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 773:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 775:	8b 48 04             	mov    0x4(%eax),%ecx
 778:	39 d9                	cmp    %ebx,%ecx
 77a:	73 b3                	jae    72f <malloc+0x68>
    if(p == freep)
 77c:	89 c2                	mov    %eax,%edx
 77e:	39 05 a0 0a 00 00    	cmp    %eax,0xaa0
 784:	75 ed                	jne    773 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 786:	83 ec 0c             	sub    $0xc,%esp
 789:	57                   	push   %edi
 78a:	e8 4c fc ff ff       	call   3db <sbrk>
  if(p == (char*)-1)
 78f:	83 c4 10             	add    $0x10,%esp
 792:	83 f8 ff             	cmp    $0xffffffff,%eax
 795:	75 c0                	jne    757 <malloc+0x90>
        return 0;
 797:	ba 00 00 00 00       	mov    $0x0,%edx
 79c:	eb a9                	jmp    747 <malloc+0x80>
