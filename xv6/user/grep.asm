
_grep:     file format elf32-i386


Disassembly of section .text:

00000000 <matchstar>:
  return 0;
}

// matchstar: search for c*re at beginning of text
int matchstar(int c, char *re, char *text)
{
   0:	f3 0f 1e fb          	endbr32 
   4:	55                   	push   %ebp
   5:	89 e5                	mov    %esp,%ebp
   7:	57                   	push   %edi
   8:	56                   	push   %esi
   9:	53                   	push   %ebx
   a:	83 ec 0c             	sub    $0xc,%esp
   d:	8b 75 08             	mov    0x8(%ebp),%esi
  10:	8b 7d 0c             	mov    0xc(%ebp),%edi
  13:	8b 5d 10             	mov    0x10(%ebp),%ebx
  do{  // a * matches zero or more instances
    if(matchhere(re, text))
  16:	83 ec 08             	sub    $0x8,%esp
  19:	53                   	push   %ebx
  1a:	57                   	push   %edi
  1b:	e8 2c 00 00 00       	call   4c <matchhere>
  20:	83 c4 10             	add    $0x10,%esp
  23:	85 c0                	test   %eax,%eax
  25:	75 18                	jne    3f <matchstar+0x3f>
      return 1;
  }while(*text!='\0' && (*text++==c || c=='.'));
  27:	0f b6 13             	movzbl (%ebx),%edx
  2a:	84 d2                	test   %dl,%dl
  2c:	74 16                	je     44 <matchstar+0x44>
  2e:	83 c3 01             	add    $0x1,%ebx
  31:	83 fe 2e             	cmp    $0x2e,%esi
  34:	74 e0                	je     16 <matchstar+0x16>
  36:	0f be d2             	movsbl %dl,%edx
  39:	39 f2                	cmp    %esi,%edx
  3b:	74 d9                	je     16 <matchstar+0x16>
  3d:	eb 05                	jmp    44 <matchstar+0x44>
      return 1;
  3f:	b8 01 00 00 00       	mov    $0x1,%eax
  return 0;
}
  44:	8d 65 f4             	lea    -0xc(%ebp),%esp
  47:	5b                   	pop    %ebx
  48:	5e                   	pop    %esi
  49:	5f                   	pop    %edi
  4a:	5d                   	pop    %ebp
  4b:	c3                   	ret    

0000004c <matchhere>:
{
  4c:	f3 0f 1e fb          	endbr32 
  50:	55                   	push   %ebp
  51:	89 e5                	mov    %esp,%ebp
  53:	53                   	push   %ebx
  54:	83 ec 04             	sub    $0x4,%esp
  57:	8b 55 08             	mov    0x8(%ebp),%edx
  if(re[0] == '\0')
  5a:	0f b6 0a             	movzbl (%edx),%ecx
    return 1;
  5d:	b8 01 00 00 00       	mov    $0x1,%eax
  if(re[0] == '\0')
  62:	84 c9                	test   %cl,%cl
  64:	74 29                	je     8f <matchhere+0x43>
  if(re[1] == '*')
  66:	0f b6 42 01          	movzbl 0x1(%edx),%eax
  6a:	3c 2a                	cmp    $0x2a,%al
  6c:	74 26                	je     94 <matchhere+0x48>
  if(re[0] == '$' && re[1] == '\0')
  6e:	84 c0                	test   %al,%al
  70:	75 05                	jne    77 <matchhere+0x2b>
  72:	80 f9 24             	cmp    $0x24,%cl
  75:	74 35                	je     ac <matchhere+0x60>
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  77:	8b 45 0c             	mov    0xc(%ebp),%eax
  7a:	0f b6 18             	movzbl (%eax),%ebx
  return 0;
  7d:	b8 00 00 00 00       	mov    $0x0,%eax
  if(*text!='\0' && (re[0]=='.' || re[0]==*text))
  82:	84 db                	test   %bl,%bl
  84:	74 09                	je     8f <matchhere+0x43>
  86:	38 d9                	cmp    %bl,%cl
  88:	74 30                	je     ba <matchhere+0x6e>
  8a:	80 f9 2e             	cmp    $0x2e,%cl
  8d:	74 2b                	je     ba <matchhere+0x6e>
}
  8f:	8b 5d fc             	mov    -0x4(%ebp),%ebx
  92:	c9                   	leave  
  93:	c3                   	ret    
    return matchstar(re[0], re+2, text);
  94:	83 ec 04             	sub    $0x4,%esp
  97:	ff 75 0c             	pushl  0xc(%ebp)
  9a:	83 c2 02             	add    $0x2,%edx
  9d:	52                   	push   %edx
  9e:	0f be c9             	movsbl %cl,%ecx
  a1:	51                   	push   %ecx
  a2:	e8 59 ff ff ff       	call   0 <matchstar>
  a7:	83 c4 10             	add    $0x10,%esp
  aa:	eb e3                	jmp    8f <matchhere+0x43>
    return *text == '\0';
  ac:	8b 45 0c             	mov    0xc(%ebp),%eax
  af:	80 38 00             	cmpb   $0x0,(%eax)
  b2:	0f 94 c0             	sete   %al
  b5:	0f b6 c0             	movzbl %al,%eax
  b8:	eb d5                	jmp    8f <matchhere+0x43>
    return matchhere(re+1, text+1);
  ba:	83 ec 08             	sub    $0x8,%esp
  bd:	8b 45 0c             	mov    0xc(%ebp),%eax
  c0:	83 c0 01             	add    $0x1,%eax
  c3:	50                   	push   %eax
  c4:	83 c2 01             	add    $0x1,%edx
  c7:	52                   	push   %edx
  c8:	e8 7f ff ff ff       	call   4c <matchhere>
  cd:	83 c4 10             	add    $0x10,%esp
  d0:	eb bd                	jmp    8f <matchhere+0x43>

000000d2 <match>:
{
  d2:	f3 0f 1e fb          	endbr32 
  d6:	55                   	push   %ebp
  d7:	89 e5                	mov    %esp,%ebp
  d9:	56                   	push   %esi
  da:	53                   	push   %ebx
  db:	8b 75 08             	mov    0x8(%ebp),%esi
  de:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  if(re[0] == '^')
  e1:	80 3e 5e             	cmpb   $0x5e,(%esi)
  e4:	74 1c                	je     102 <match+0x30>
    if(matchhere(re, text))
  e6:	83 ec 08             	sub    $0x8,%esp
  e9:	53                   	push   %ebx
  ea:	56                   	push   %esi
  eb:	e8 5c ff ff ff       	call   4c <matchhere>
  f0:	83 c4 10             	add    $0x10,%esp
  f3:	85 c0                	test   %eax,%eax
  f5:	75 1d                	jne    114 <match+0x42>
  }while(*text++ != '\0');
  f7:	83 c3 01             	add    $0x1,%ebx
  fa:	80 7b ff 00          	cmpb   $0x0,-0x1(%ebx)
  fe:	75 e6                	jne    e6 <match+0x14>
 100:	eb 17                	jmp    119 <match+0x47>
    return matchhere(re+1, text);
 102:	83 ec 08             	sub    $0x8,%esp
 105:	53                   	push   %ebx
 106:	83 c6 01             	add    $0x1,%esi
 109:	56                   	push   %esi
 10a:	e8 3d ff ff ff       	call   4c <matchhere>
 10f:	83 c4 10             	add    $0x10,%esp
 112:	eb 05                	jmp    119 <match+0x47>
      return 1;
 114:	b8 01 00 00 00       	mov    $0x1,%eax
}
 119:	8d 65 f8             	lea    -0x8(%ebp),%esp
 11c:	5b                   	pop    %ebx
 11d:	5e                   	pop    %esi
 11e:	5d                   	pop    %ebp
 11f:	c3                   	ret    

00000120 <grep>:
{
 120:	f3 0f 1e fb          	endbr32 
 124:	55                   	push   %ebp
 125:	89 e5                	mov    %esp,%ebp
 127:	57                   	push   %edi
 128:	56                   	push   %esi
 129:	53                   	push   %ebx
 12a:	83 ec 1c             	sub    $0x1c,%esp
 12d:	8b 7d 08             	mov    0x8(%ebp),%edi
  m = 0;
 130:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 137:	eb 53                	jmp    18c <grep+0x6c>
        *q = '\n';
 139:	c6 03 0a             	movb   $0xa,(%ebx)
        write(1, p, q+1 - p);
 13c:	83 ec 04             	sub    $0x4,%esp
 13f:	8d 43 01             	lea    0x1(%ebx),%eax
 142:	29 f0                	sub    %esi,%eax
 144:	50                   	push   %eax
 145:	56                   	push   %esi
 146:	6a 01                	push   $0x1
 148:	e8 63 03 00 00       	call   4b0 <write>
 14d:	83 c4 10             	add    $0x10,%esp
      p = q+1;
 150:	8d 73 01             	lea    0x1(%ebx),%esi
    while((q = strchr(p, '\n')) != 0){
 153:	83 ec 08             	sub    $0x8,%esp
 156:	6a 0a                	push   $0xa
 158:	56                   	push   %esi
 159:	e8 e6 01 00 00       	call   344 <strchr>
 15e:	89 c3                	mov    %eax,%ebx
 160:	83 c4 10             	add    $0x10,%esp
 163:	85 c0                	test   %eax,%eax
 165:	74 16                	je     17d <grep+0x5d>
      *q = 0;
 167:	c6 03 00             	movb   $0x0,(%ebx)
      if(match(pattern, p)){
 16a:	83 ec 08             	sub    $0x8,%esp
 16d:	56                   	push   %esi
 16e:	57                   	push   %edi
 16f:	e8 5e ff ff ff       	call   d2 <match>
 174:	83 c4 10             	add    $0x10,%esp
 177:	85 c0                	test   %eax,%eax
 179:	74 d5                	je     150 <grep+0x30>
 17b:	eb bc                	jmp    139 <grep+0x19>
    if(p == buf)
 17d:	81 fe 60 0c 00 00    	cmp    $0xc60,%esi
 183:	74 5f                	je     1e4 <grep+0xc4>
    if(m > 0){
 185:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 188:	85 c9                	test   %ecx,%ecx
 18a:	7f 38                	jg     1c4 <grep+0xa4>
  while((n = read(fd, buf+m, sizeof(buf)-m-1)) > 0){
 18c:	83 ec 04             	sub    $0x4,%esp
 18f:	b8 ff 03 00 00       	mov    $0x3ff,%eax
 194:	8b 4d e4             	mov    -0x1c(%ebp),%ecx
 197:	29 c8                	sub    %ecx,%eax
 199:	50                   	push   %eax
 19a:	8d 81 60 0c 00 00    	lea    0xc60(%ecx),%eax
 1a0:	50                   	push   %eax
 1a1:	ff 75 0c             	pushl  0xc(%ebp)
 1a4:	e8 ff 02 00 00       	call   4a8 <read>
 1a9:	83 c4 10             	add    $0x10,%esp
 1ac:	85 c0                	test   %eax,%eax
 1ae:	7e 3d                	jle    1ed <grep+0xcd>
    m += n;
 1b0:	01 45 e4             	add    %eax,-0x1c(%ebp)
 1b3:	8b 55 e4             	mov    -0x1c(%ebp),%edx
    buf[m] = '\0';
 1b6:	c6 82 60 0c 00 00 00 	movb   $0x0,0xc60(%edx)
    p = buf;
 1bd:	be 60 0c 00 00       	mov    $0xc60,%esi
    while((q = strchr(p, '\n')) != 0){
 1c2:	eb 8f                	jmp    153 <grep+0x33>
      m -= p - buf;
 1c4:	89 f0                	mov    %esi,%eax
 1c6:	2d 60 0c 00 00       	sub    $0xc60,%eax
 1cb:	29 c1                	sub    %eax,%ecx
 1cd:	89 4d e4             	mov    %ecx,-0x1c(%ebp)
      memmove(buf, p, m);
 1d0:	83 ec 04             	sub    $0x4,%esp
 1d3:	51                   	push   %ecx
 1d4:	56                   	push   %esi
 1d5:	68 60 0c 00 00       	push   $0xc60
 1da:	e8 78 02 00 00       	call   457 <memmove>
 1df:	83 c4 10             	add    $0x10,%esp
 1e2:	eb a8                	jmp    18c <grep+0x6c>
      m = 0;
 1e4:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
 1eb:	eb 9f                	jmp    18c <grep+0x6c>
}
 1ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f0:	5b                   	pop    %ebx
 1f1:	5e                   	pop    %esi
 1f2:	5f                   	pop    %edi
 1f3:	5d                   	pop    %ebp
 1f4:	c3                   	ret    

000001f5 <main>:
{
 1f5:	f3 0f 1e fb          	endbr32 
 1f9:	8d 4c 24 04          	lea    0x4(%esp),%ecx
 1fd:	83 e4 f0             	and    $0xfffffff0,%esp
 200:	ff 71 fc             	pushl  -0x4(%ecx)
 203:	55                   	push   %ebp
 204:	89 e5                	mov    %esp,%ebp
 206:	57                   	push   %edi
 207:	56                   	push   %esi
 208:	53                   	push   %ebx
 209:	51                   	push   %ecx
 20a:	83 ec 18             	sub    $0x18,%esp
 20d:	8b 01                	mov    (%ecx),%eax
 20f:	89 45 e4             	mov    %eax,-0x1c(%ebp)
 212:	8b 71 04             	mov    0x4(%ecx),%esi
  if(argc <= 1){
 215:	83 f8 01             	cmp    $0x1,%eax
 218:	7e 53                	jle    26d <main+0x78>
  pattern = argv[1];
 21a:	8b 46 04             	mov    0x4(%esi),%eax
 21d:	89 45 e0             	mov    %eax,-0x20(%ebp)
  if(argc <= 2){
 220:	83 c6 08             	add    $0x8,%esi
  for(i = 2; i < argc; i++){
 223:	bf 02 00 00 00       	mov    $0x2,%edi
  if(argc <= 2){
 228:	83 7d e4 02          	cmpl   $0x2,-0x1c(%ebp)
 22c:	7e 53                	jle    281 <main+0x8c>
    if((fd = open(argv[i], 0)) < 0){
 22e:	89 75 dc             	mov    %esi,-0x24(%ebp)
 231:	83 ec 08             	sub    $0x8,%esp
 234:	6a 00                	push   $0x0
 236:	ff 36                	pushl  (%esi)
 238:	e8 93 02 00 00       	call   4d0 <open>
 23d:	89 c3                	mov    %eax,%ebx
 23f:	83 c4 10             	add    $0x10,%esp
 242:	85 c0                	test   %eax,%eax
 244:	78 4b                	js     291 <main+0x9c>
    grep(pattern, fd);
 246:	83 ec 08             	sub    $0x8,%esp
 249:	50                   	push   %eax
 24a:	ff 75 e0             	pushl  -0x20(%ebp)
 24d:	e8 ce fe ff ff       	call   120 <grep>
    close(fd);
 252:	89 1c 24             	mov    %ebx,(%esp)
 255:	e8 5e 02 00 00       	call   4b8 <close>
  for(i = 2; i < argc; i++){
 25a:	83 c7 01             	add    $0x1,%edi
 25d:	83 c6 04             	add    $0x4,%esi
 260:	83 c4 10             	add    $0x10,%esp
 263:	39 7d e4             	cmp    %edi,-0x1c(%ebp)
 266:	75 c6                	jne    22e <main+0x39>
  exit();
 268:	e8 23 02 00 00       	call   490 <exit>
    printf(2, "usage: grep pattern [file ...]\n");
 26d:	83 ec 08             	sub    $0x8,%esp
 270:	68 dc 08 00 00       	push   $0x8dc
 275:	6a 02                	push   $0x2
 277:	e8 48 03 00 00       	call   5c4 <printf>
    exit();
 27c:	e8 0f 02 00 00       	call   490 <exit>
    grep(pattern, 0);
 281:	83 ec 08             	sub    $0x8,%esp
 284:	6a 00                	push   $0x0
 286:	50                   	push   %eax
 287:	e8 94 fe ff ff       	call   120 <grep>
    exit();
 28c:	e8 ff 01 00 00       	call   490 <exit>
      printf(1, "grep: cannot open %s\n", argv[i]);
 291:	83 ec 04             	sub    $0x4,%esp
 294:	8b 45 dc             	mov    -0x24(%ebp),%eax
 297:	ff 30                	pushl  (%eax)
 299:	68 fc 08 00 00       	push   $0x8fc
 29e:	6a 01                	push   $0x1
 2a0:	e8 1f 03 00 00       	call   5c4 <printf>
      exit();
 2a5:	e8 e6 01 00 00       	call   490 <exit>

000002aa <strcpy>:
#include "kernel/x86.h"
#include "user.h"

char*
strcpy(char *s, char *t)
{
 2aa:	f3 0f 1e fb          	endbr32 
 2ae:	55                   	push   %ebp
 2af:	89 e5                	mov    %esp,%ebp
 2b1:	53                   	push   %ebx
 2b2:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2b5:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 2b8:	b8 00 00 00 00       	mov    $0x0,%eax
 2bd:	0f b6 14 03          	movzbl (%ebx,%eax,1),%edx
 2c1:	88 14 01             	mov    %dl,(%ecx,%eax,1)
 2c4:	83 c0 01             	add    $0x1,%eax
 2c7:	84 d2                	test   %dl,%dl
 2c9:	75 f2                	jne    2bd <strcpy+0x13>
    ;
  return os;
}
 2cb:	89 c8                	mov    %ecx,%eax
 2cd:	5b                   	pop    %ebx
 2ce:	5d                   	pop    %ebp
 2cf:	c3                   	ret    

000002d0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 2d0:	f3 0f 1e fb          	endbr32 
 2d4:	55                   	push   %ebp
 2d5:	89 e5                	mov    %esp,%ebp
 2d7:	8b 4d 08             	mov    0x8(%ebp),%ecx
 2da:	8b 55 0c             	mov    0xc(%ebp),%edx
  while(*p && *p == *q)
 2dd:	0f b6 01             	movzbl (%ecx),%eax
 2e0:	84 c0                	test   %al,%al
 2e2:	74 11                	je     2f5 <strcmp+0x25>
 2e4:	38 02                	cmp    %al,(%edx)
 2e6:	75 0d                	jne    2f5 <strcmp+0x25>
    p++, q++;
 2e8:	83 c1 01             	add    $0x1,%ecx
 2eb:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 2ee:	0f b6 01             	movzbl (%ecx),%eax
 2f1:	84 c0                	test   %al,%al
 2f3:	75 ef                	jne    2e4 <strcmp+0x14>
  return (uchar)*p - (uchar)*q;
 2f5:	0f b6 c0             	movzbl %al,%eax
 2f8:	0f b6 12             	movzbl (%edx),%edx
 2fb:	29 d0                	sub    %edx,%eax
}
 2fd:	5d                   	pop    %ebp
 2fe:	c3                   	ret    

000002ff <strlen>:

uint
strlen(char *s)
{
 2ff:	f3 0f 1e fb          	endbr32 
 303:	55                   	push   %ebp
 304:	89 e5                	mov    %esp,%ebp
 306:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  for(n = 0; s[n]; n++)
 309:	80 3a 00             	cmpb   $0x0,(%edx)
 30c:	74 14                	je     322 <strlen+0x23>
 30e:	b8 00 00 00 00       	mov    $0x0,%eax
 313:	83 c0 01             	add    $0x1,%eax
 316:	89 c1                	mov    %eax,%ecx
 318:	80 3c 02 00          	cmpb   $0x0,(%edx,%eax,1)
 31c:	75 f5                	jne    313 <strlen+0x14>
    ;
  return n;
}
 31e:	89 c8                	mov    %ecx,%eax
 320:	5d                   	pop    %ebp
 321:	c3                   	ret    
  for(n = 0; s[n]; n++)
 322:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 327:	eb f5                	jmp    31e <strlen+0x1f>

00000329 <memset>:

void*
memset(void *dst, int c, uint n)
{
 329:	f3 0f 1e fb          	endbr32 
 32d:	55                   	push   %ebp
 32e:	89 e5                	mov    %esp,%ebp
 330:	57                   	push   %edi
 331:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 334:	89 d7                	mov    %edx,%edi
 336:	8b 4d 10             	mov    0x10(%ebp),%ecx
 339:	8b 45 0c             	mov    0xc(%ebp),%eax
 33c:	fc                   	cld    
 33d:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 33f:	89 d0                	mov    %edx,%eax
 341:	5f                   	pop    %edi
 342:	5d                   	pop    %ebp
 343:	c3                   	ret    

00000344 <strchr>:

char*
strchr(const char *s, char c)
{
 344:	f3 0f 1e fb          	endbr32 
 348:	55                   	push   %ebp
 349:	89 e5                	mov    %esp,%ebp
 34b:	8b 45 08             	mov    0x8(%ebp),%eax
 34e:	0f b6 4d 0c          	movzbl 0xc(%ebp),%ecx
  for(; *s; s++)
 352:	0f b6 10             	movzbl (%eax),%edx
 355:	84 d2                	test   %dl,%dl
 357:	74 15                	je     36e <strchr+0x2a>
    if(*s == c)
 359:	38 d1                	cmp    %dl,%cl
 35b:	74 0f                	je     36c <strchr+0x28>
  for(; *s; s++)
 35d:	83 c0 01             	add    $0x1,%eax
 360:	0f b6 10             	movzbl (%eax),%edx
 363:	84 d2                	test   %dl,%dl
 365:	75 f2                	jne    359 <strchr+0x15>
      return (char*)s;
  return 0;
 367:	b8 00 00 00 00       	mov    $0x0,%eax
}
 36c:	5d                   	pop    %ebp
 36d:	c3                   	ret    
  return 0;
 36e:	b8 00 00 00 00       	mov    $0x0,%eax
 373:	eb f7                	jmp    36c <strchr+0x28>

00000375 <gets>:

char*
gets(char *buf, int max)
{
 375:	f3 0f 1e fb          	endbr32 
 379:	55                   	push   %ebp
 37a:	89 e5                	mov    %esp,%ebp
 37c:	57                   	push   %edi
 37d:	56                   	push   %esi
 37e:	53                   	push   %ebx
 37f:	83 ec 2c             	sub    $0x2c,%esp
 382:	8b 75 08             	mov    0x8(%ebp),%esi
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 385:	bb 00 00 00 00       	mov    $0x0,%ebx
    cc = read(0, &c, 1);
 38a:	8d 7d e7             	lea    -0x19(%ebp),%edi
  for(i=0; i+1 < max; ){
 38d:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
 390:	83 c3 01             	add    $0x1,%ebx
 393:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 396:	7d 27                	jge    3bf <gets+0x4a>
    cc = read(0, &c, 1);
 398:	83 ec 04             	sub    $0x4,%esp
 39b:	6a 01                	push   $0x1
 39d:	57                   	push   %edi
 39e:	6a 00                	push   $0x0
 3a0:	e8 03 01 00 00       	call   4a8 <read>
    if(cc < 1)
 3a5:	83 c4 10             	add    $0x10,%esp
 3a8:	85 c0                	test   %eax,%eax
 3aa:	7e 13                	jle    3bf <gets+0x4a>
      break;
    buf[i++] = c;
 3ac:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 3b0:	88 44 1e ff          	mov    %al,-0x1(%esi,%ebx,1)
    if(c == '\n' || c == '\r')
 3b4:	3c 0a                	cmp    $0xa,%al
 3b6:	74 04                	je     3bc <gets+0x47>
 3b8:	3c 0d                	cmp    $0xd,%al
 3ba:	75 d1                	jne    38d <gets+0x18>
  for(i=0; i+1 < max; ){
 3bc:	89 5d d4             	mov    %ebx,-0x2c(%ebp)
      break;
  }
  buf[i] = '\0';
 3bf:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 3c2:	c6 04 06 00          	movb   $0x0,(%esi,%eax,1)
  return buf;
}
 3c6:	89 f0                	mov    %esi,%eax
 3c8:	8d 65 f4             	lea    -0xc(%ebp),%esp
 3cb:	5b                   	pop    %ebx
 3cc:	5e                   	pop    %esi
 3cd:	5f                   	pop    %edi
 3ce:	5d                   	pop    %ebp
 3cf:	c3                   	ret    

000003d0 <stat>:

int
stat(char *n, struct stat *st)
{
 3d0:	f3 0f 1e fb          	endbr32 
 3d4:	55                   	push   %ebp
 3d5:	89 e5                	mov    %esp,%ebp
 3d7:	56                   	push   %esi
 3d8:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 3d9:	83 ec 08             	sub    $0x8,%esp
 3dc:	6a 00                	push   $0x0
 3de:	ff 75 08             	pushl  0x8(%ebp)
 3e1:	e8 ea 00 00 00       	call   4d0 <open>
  if(fd < 0)
 3e6:	83 c4 10             	add    $0x10,%esp
 3e9:	85 c0                	test   %eax,%eax
 3eb:	78 24                	js     411 <stat+0x41>
 3ed:	89 c3                	mov    %eax,%ebx
    return -1;
  r = fstat(fd, st);
 3ef:	83 ec 08             	sub    $0x8,%esp
 3f2:	ff 75 0c             	pushl  0xc(%ebp)
 3f5:	50                   	push   %eax
 3f6:	e8 ed 00 00 00       	call   4e8 <fstat>
 3fb:	89 c6                	mov    %eax,%esi
  close(fd);
 3fd:	89 1c 24             	mov    %ebx,(%esp)
 400:	e8 b3 00 00 00       	call   4b8 <close>
  return r;
 405:	83 c4 10             	add    $0x10,%esp
}
 408:	89 f0                	mov    %esi,%eax
 40a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 40d:	5b                   	pop    %ebx
 40e:	5e                   	pop    %esi
 40f:	5d                   	pop    %ebp
 410:	c3                   	ret    
    return -1;
 411:	be ff ff ff ff       	mov    $0xffffffff,%esi
 416:	eb f0                	jmp    408 <stat+0x38>

00000418 <atoi>:

int
atoi(const char *s)
{
 418:	f3 0f 1e fb          	endbr32 
 41c:	55                   	push   %ebp
 41d:	89 e5                	mov    %esp,%ebp
 41f:	53                   	push   %ebx
 420:	8b 55 08             	mov    0x8(%ebp),%edx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 423:	0f b6 02             	movzbl (%edx),%eax
 426:	8d 48 d0             	lea    -0x30(%eax),%ecx
 429:	80 f9 09             	cmp    $0x9,%cl
 42c:	77 22                	ja     450 <atoi+0x38>
  n = 0;
 42e:	b9 00 00 00 00       	mov    $0x0,%ecx
    n = n*10 + *s++ - '0';
 433:	83 c2 01             	add    $0x1,%edx
 436:	8d 0c 89             	lea    (%ecx,%ecx,4),%ecx
 439:	0f be c0             	movsbl %al,%eax
 43c:	8d 4c 48 d0          	lea    -0x30(%eax,%ecx,2),%ecx
  while('0' <= *s && *s <= '9')
 440:	0f b6 02             	movzbl (%edx),%eax
 443:	8d 58 d0             	lea    -0x30(%eax),%ebx
 446:	80 fb 09             	cmp    $0x9,%bl
 449:	76 e8                	jbe    433 <atoi+0x1b>
  return n;
}
 44b:	89 c8                	mov    %ecx,%eax
 44d:	5b                   	pop    %ebx
 44e:	5d                   	pop    %ebp
 44f:	c3                   	ret    
  n = 0;
 450:	b9 00 00 00 00       	mov    $0x0,%ecx
  return n;
 455:	eb f4                	jmp    44b <atoi+0x33>

00000457 <memmove>:

void*
memmove(void *vdst, void *vsrc, int n)
{
 457:	f3 0f 1e fb          	endbr32 
 45b:	55                   	push   %ebp
 45c:	89 e5                	mov    %esp,%ebp
 45e:	56                   	push   %esi
 45f:	53                   	push   %ebx
 460:	8b 75 08             	mov    0x8(%ebp),%esi
 463:	8b 55 0c             	mov    0xc(%ebp),%edx
 466:	8b 5d 10             	mov    0x10(%ebp),%ebx
  char *dst, *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 469:	85 db                	test   %ebx,%ebx
 46b:	7e 15                	jle    482 <memmove+0x2b>
 46d:	01 f3                	add    %esi,%ebx
  dst = vdst;
 46f:	89 f0                	mov    %esi,%eax
    *dst++ = *src++;
 471:	83 c2 01             	add    $0x1,%edx
 474:	83 c0 01             	add    $0x1,%eax
 477:	0f b6 4a ff          	movzbl -0x1(%edx),%ecx
 47b:	88 48 ff             	mov    %cl,-0x1(%eax)
  while(n-- > 0)
 47e:	39 c3                	cmp    %eax,%ebx
 480:	75 ef                	jne    471 <memmove+0x1a>
  return vdst;
}
 482:	89 f0                	mov    %esi,%eax
 484:	5b                   	pop    %ebx
 485:	5e                   	pop    %esi
 486:	5d                   	pop    %ebp
 487:	c3                   	ret    

00000488 <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 488:	b8 01 00 00 00       	mov    $0x1,%eax
 48d:	cd 40                	int    $0x40
 48f:	c3                   	ret    

00000490 <exit>:
SYSCALL(exit)
 490:	b8 02 00 00 00       	mov    $0x2,%eax
 495:	cd 40                	int    $0x40
 497:	c3                   	ret    

00000498 <wait>:
SYSCALL(wait)
 498:	b8 03 00 00 00       	mov    $0x3,%eax
 49d:	cd 40                	int    $0x40
 49f:	c3                   	ret    

000004a0 <pipe>:
SYSCALL(pipe)
 4a0:	b8 04 00 00 00       	mov    $0x4,%eax
 4a5:	cd 40                	int    $0x40
 4a7:	c3                   	ret    

000004a8 <read>:
SYSCALL(read)
 4a8:	b8 05 00 00 00       	mov    $0x5,%eax
 4ad:	cd 40                	int    $0x40
 4af:	c3                   	ret    

000004b0 <write>:
SYSCALL(write)
 4b0:	b8 10 00 00 00       	mov    $0x10,%eax
 4b5:	cd 40                	int    $0x40
 4b7:	c3                   	ret    

000004b8 <close>:
SYSCALL(close)
 4b8:	b8 15 00 00 00       	mov    $0x15,%eax
 4bd:	cd 40                	int    $0x40
 4bf:	c3                   	ret    

000004c0 <kill>:
SYSCALL(kill)
 4c0:	b8 06 00 00 00       	mov    $0x6,%eax
 4c5:	cd 40                	int    $0x40
 4c7:	c3                   	ret    

000004c8 <exec>:
SYSCALL(exec)
 4c8:	b8 07 00 00 00       	mov    $0x7,%eax
 4cd:	cd 40                	int    $0x40
 4cf:	c3                   	ret    

000004d0 <open>:
SYSCALL(open)
 4d0:	b8 0f 00 00 00       	mov    $0xf,%eax
 4d5:	cd 40                	int    $0x40
 4d7:	c3                   	ret    

000004d8 <mknod>:
SYSCALL(mknod)
 4d8:	b8 11 00 00 00       	mov    $0x11,%eax
 4dd:	cd 40                	int    $0x40
 4df:	c3                   	ret    

000004e0 <unlink>:
SYSCALL(unlink)
 4e0:	b8 12 00 00 00       	mov    $0x12,%eax
 4e5:	cd 40                	int    $0x40
 4e7:	c3                   	ret    

000004e8 <fstat>:
SYSCALL(fstat)
 4e8:	b8 08 00 00 00       	mov    $0x8,%eax
 4ed:	cd 40                	int    $0x40
 4ef:	c3                   	ret    

000004f0 <link>:
SYSCALL(link)
 4f0:	b8 13 00 00 00       	mov    $0x13,%eax
 4f5:	cd 40                	int    $0x40
 4f7:	c3                   	ret    

000004f8 <mkdir>:
SYSCALL(mkdir)
 4f8:	b8 14 00 00 00       	mov    $0x14,%eax
 4fd:	cd 40                	int    $0x40
 4ff:	c3                   	ret    

00000500 <chdir>:
SYSCALL(chdir)
 500:	b8 09 00 00 00       	mov    $0x9,%eax
 505:	cd 40                	int    $0x40
 507:	c3                   	ret    

00000508 <dup>:
SYSCALL(dup)
 508:	b8 0a 00 00 00       	mov    $0xa,%eax
 50d:	cd 40                	int    $0x40
 50f:	c3                   	ret    

00000510 <getpid>:
SYSCALL(getpid)
 510:	b8 0b 00 00 00       	mov    $0xb,%eax
 515:	cd 40                	int    $0x40
 517:	c3                   	ret    

00000518 <sbrk>:
SYSCALL(sbrk)
 518:	b8 0c 00 00 00       	mov    $0xc,%eax
 51d:	cd 40                	int    $0x40
 51f:	c3                   	ret    

00000520 <sleep>:
SYSCALL(sleep)
 520:	b8 0d 00 00 00       	mov    $0xd,%eax
 525:	cd 40                	int    $0x40
 527:	c3                   	ret    

00000528 <uptime>:
SYSCALL(uptime)
 528:	b8 0e 00 00 00       	mov    $0xe,%eax
 52d:	cd 40                	int    $0x40
 52f:	c3                   	ret    

00000530 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 530:	55                   	push   %ebp
 531:	89 e5                	mov    %esp,%ebp
 533:	57                   	push   %edi
 534:	56                   	push   %esi
 535:	53                   	push   %ebx
 536:	83 ec 3c             	sub    $0x3c,%esp
 539:	89 45 c4             	mov    %eax,-0x3c(%ebp)
 53c:	89 d3                	mov    %edx,%ebx
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 53e:	83 7d 08 00          	cmpl   $0x0,0x8(%ebp)
 542:	74 77                	je     5bb <printint+0x8b>
 544:	85 d2                	test   %edx,%edx
 546:	79 73                	jns    5bb <printint+0x8b>
    neg = 1;
    x = -xx;
 548:	f7 db                	neg    %ebx
    neg = 1;
 54a:	c7 45 c0 01 00 00 00 	movl   $0x1,-0x40(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 551:	be 00 00 00 00       	mov    $0x0,%esi
  do{
    buf[i++] = digits[x % base];
 556:	89 f7                	mov    %esi,%edi
 558:	83 c6 01             	add    $0x1,%esi
 55b:	89 d8                	mov    %ebx,%eax
 55d:	ba 00 00 00 00       	mov    $0x0,%edx
 562:	f7 f1                	div    %ecx
 564:	0f b6 92 1c 09 00 00 	movzbl 0x91c(%edx),%edx
 56b:	88 54 35 d7          	mov    %dl,-0x29(%ebp,%esi,1)
  }while((x /= base) != 0);
 56f:	89 da                	mov    %ebx,%edx
 571:	89 c3                	mov    %eax,%ebx
 573:	39 d1                	cmp    %edx,%ecx
 575:	76 df                	jbe    556 <printint+0x26>
  if(neg)
 577:	83 7d c0 00          	cmpl   $0x0,-0x40(%ebp)
 57b:	74 08                	je     585 <printint+0x55>
    buf[i++] = '-';
 57d:	c6 44 35 d8 2d       	movb   $0x2d,-0x28(%ebp,%esi,1)
 582:	8d 77 02             	lea    0x2(%edi),%esi

  while(--i >= 0)
 585:	85 f6                	test   %esi,%esi
 587:	7e 2a                	jle    5b3 <printint+0x83>
 589:	8d 5c 35 d7          	lea    -0x29(%ebp,%esi,1),%ebx
 58d:	8d 7d d8             	lea    -0x28(%ebp),%edi
  write(fd, &c, 1);
 590:	8d 75 d7             	lea    -0x29(%ebp),%esi
    putc(fd, buf[i]);
 593:	0f b6 03             	movzbl (%ebx),%eax
 596:	88 45 d7             	mov    %al,-0x29(%ebp)
  write(fd, &c, 1);
 599:	83 ec 04             	sub    $0x4,%esp
 59c:	6a 01                	push   $0x1
 59e:	56                   	push   %esi
 59f:	ff 75 c4             	pushl  -0x3c(%ebp)
 5a2:	e8 09 ff ff ff       	call   4b0 <write>
  while(--i >= 0)
 5a7:	89 d8                	mov    %ebx,%eax
 5a9:	83 eb 01             	sub    $0x1,%ebx
 5ac:	83 c4 10             	add    $0x10,%esp
 5af:	39 f8                	cmp    %edi,%eax
 5b1:	75 e0                	jne    593 <printint+0x63>
}
 5b3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5b6:	5b                   	pop    %ebx
 5b7:	5e                   	pop    %esi
 5b8:	5f                   	pop    %edi
 5b9:	5d                   	pop    %ebp
 5ba:	c3                   	ret    
  neg = 0;
 5bb:	c7 45 c0 00 00 00 00 	movl   $0x0,-0x40(%ebp)
 5c2:	eb 8d                	jmp    551 <printint+0x21>

000005c4 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, char *fmt, ...)
{
 5c4:	f3 0f 1e fb          	endbr32 
 5c8:	55                   	push   %ebp
 5c9:	89 e5                	mov    %esp,%ebp
 5cb:	57                   	push   %edi
 5cc:	56                   	push   %esi
 5cd:	53                   	push   %ebx
 5ce:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 5d1:	8b 75 0c             	mov    0xc(%ebp),%esi
 5d4:	0f b6 1e             	movzbl (%esi),%ebx
 5d7:	84 db                	test   %bl,%bl
 5d9:	0f 84 ab 01 00 00    	je     78a <printf+0x1c6>
 5df:	83 c6 01             	add    $0x1,%esi
  ap = (uint*)(void*)&fmt + 1;
 5e2:	8d 45 10             	lea    0x10(%ebp),%eax
 5e5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  state = 0;
 5e8:	bf 00 00 00 00       	mov    $0x0,%edi
 5ed:	eb 2d                	jmp    61c <printf+0x58>
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
 5ef:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 5f2:	83 ec 04             	sub    $0x4,%esp
 5f5:	6a 01                	push   $0x1
 5f7:	8d 45 e7             	lea    -0x19(%ebp),%eax
 5fa:	50                   	push   %eax
 5fb:	ff 75 08             	pushl  0x8(%ebp)
 5fe:	e8 ad fe ff ff       	call   4b0 <write>
        putc(fd, c);
 603:	83 c4 10             	add    $0x10,%esp
 606:	eb 05                	jmp    60d <printf+0x49>
      }
    } else if(state == '%'){
 608:	83 ff 25             	cmp    $0x25,%edi
 60b:	74 22                	je     62f <printf+0x6b>
  for(i = 0; fmt[i]; i++){
 60d:	83 c6 01             	add    $0x1,%esi
 610:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 614:	84 db                	test   %bl,%bl
 616:	0f 84 6e 01 00 00    	je     78a <printf+0x1c6>
    c = fmt[i] & 0xff;
 61c:	0f be d3             	movsbl %bl,%edx
 61f:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 622:	85 ff                	test   %edi,%edi
 624:	75 e2                	jne    608 <printf+0x44>
      if(c == '%'){
 626:	83 f8 25             	cmp    $0x25,%eax
 629:	75 c4                	jne    5ef <printf+0x2b>
        state = '%';
 62b:	89 c7                	mov    %eax,%edi
 62d:	eb de                	jmp    60d <printf+0x49>
      if(c == 'd'){
 62f:	83 f8 64             	cmp    $0x64,%eax
 632:	74 59                	je     68d <printf+0xc9>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 634:	81 e2 f7 00 00 00    	and    $0xf7,%edx
 63a:	83 fa 70             	cmp    $0x70,%edx
 63d:	74 7a                	je     6b9 <printf+0xf5>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 63f:	83 f8 73             	cmp    $0x73,%eax
 642:	0f 84 9d 00 00 00    	je     6e5 <printf+0x121>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 648:	83 f8 63             	cmp    $0x63,%eax
 64b:	0f 84 ec 00 00 00    	je     73d <printf+0x179>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 651:	83 f8 25             	cmp    $0x25,%eax
 654:	0f 84 0f 01 00 00    	je     769 <printf+0x1a5>
        putc(fd, c);
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
 65a:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
  write(fd, &c, 1);
 65e:	83 ec 04             	sub    $0x4,%esp
 661:	6a 01                	push   $0x1
 663:	8d 45 e7             	lea    -0x19(%ebp),%eax
 666:	50                   	push   %eax
 667:	ff 75 08             	pushl  0x8(%ebp)
 66a:	e8 41 fe ff ff       	call   4b0 <write>
        putc(fd, c);
 66f:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 672:	83 c4 0c             	add    $0xc,%esp
 675:	6a 01                	push   $0x1
 677:	8d 45 e7             	lea    -0x19(%ebp),%eax
 67a:	50                   	push   %eax
 67b:	ff 75 08             	pushl  0x8(%ebp)
 67e:	e8 2d fe ff ff       	call   4b0 <write>
        putc(fd, c);
 683:	83 c4 10             	add    $0x10,%esp
      }
      state = 0;
 686:	bf 00 00 00 00       	mov    $0x0,%edi
 68b:	eb 80                	jmp    60d <printf+0x49>
        printint(fd, *ap, 10, 1);
 68d:	83 ec 0c             	sub    $0xc,%esp
 690:	6a 01                	push   $0x1
 692:	b9 0a 00 00 00       	mov    $0xa,%ecx
 697:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 69a:	8b 17                	mov    (%edi),%edx
 69c:	8b 45 08             	mov    0x8(%ebp),%eax
 69f:	e8 8c fe ff ff       	call   530 <printint>
        ap++;
 6a4:	89 f8                	mov    %edi,%eax
 6a6:	83 c0 04             	add    $0x4,%eax
 6a9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6ac:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6af:	bf 00 00 00 00       	mov    $0x0,%edi
 6b4:	e9 54 ff ff ff       	jmp    60d <printf+0x49>
        printint(fd, *ap, 16, 0);
 6b9:	83 ec 0c             	sub    $0xc,%esp
 6bc:	6a 00                	push   $0x0
 6be:	b9 10 00 00 00       	mov    $0x10,%ecx
 6c3:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 6c6:	8b 17                	mov    (%edi),%edx
 6c8:	8b 45 08             	mov    0x8(%ebp),%eax
 6cb:	e8 60 fe ff ff       	call   530 <printint>
        ap++;
 6d0:	89 f8                	mov    %edi,%eax
 6d2:	83 c0 04             	add    $0x4,%eax
 6d5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 6d8:	83 c4 10             	add    $0x10,%esp
      state = 0;
 6db:	bf 00 00 00 00       	mov    $0x0,%edi
 6e0:	e9 28 ff ff ff       	jmp    60d <printf+0x49>
        s = (char*)*ap;
 6e5:	8b 4d d4             	mov    -0x2c(%ebp),%ecx
 6e8:	8b 01                	mov    (%ecx),%eax
        ap++;
 6ea:	83 c1 04             	add    $0x4,%ecx
 6ed:	89 4d d4             	mov    %ecx,-0x2c(%ebp)
        if(s == 0)
 6f0:	85 c0                	test   %eax,%eax
 6f2:	74 13                	je     707 <printf+0x143>
        s = (char*)*ap;
 6f4:	89 c3                	mov    %eax,%ebx
        while(*s != 0){
 6f6:	0f b6 00             	movzbl (%eax),%eax
      state = 0;
 6f9:	bf 00 00 00 00       	mov    $0x0,%edi
        while(*s != 0){
 6fe:	84 c0                	test   %al,%al
 700:	75 0f                	jne    711 <printf+0x14d>
 702:	e9 06 ff ff ff       	jmp    60d <printf+0x49>
          s = "(null)";
 707:	bb 12 09 00 00       	mov    $0x912,%ebx
        while(*s != 0){
 70c:	b8 28 00 00 00       	mov    $0x28,%eax
 711:	8b 7d 08             	mov    0x8(%ebp),%edi
          putc(fd, *s);
 714:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 717:	83 ec 04             	sub    $0x4,%esp
 71a:	6a 01                	push   $0x1
 71c:	8d 45 e7             	lea    -0x19(%ebp),%eax
 71f:	50                   	push   %eax
 720:	57                   	push   %edi
 721:	e8 8a fd ff ff       	call   4b0 <write>
          s++;
 726:	83 c3 01             	add    $0x1,%ebx
        while(*s != 0){
 729:	0f b6 03             	movzbl (%ebx),%eax
 72c:	83 c4 10             	add    $0x10,%esp
 72f:	84 c0                	test   %al,%al
 731:	75 e1                	jne    714 <printf+0x150>
      state = 0;
 733:	bf 00 00 00 00       	mov    $0x0,%edi
 738:	e9 d0 fe ff ff       	jmp    60d <printf+0x49>
        putc(fd, *ap);
 73d:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 740:	8b 07                	mov    (%edi),%eax
 742:	88 45 e7             	mov    %al,-0x19(%ebp)
  write(fd, &c, 1);
 745:	83 ec 04             	sub    $0x4,%esp
 748:	6a 01                	push   $0x1
 74a:	8d 45 e7             	lea    -0x19(%ebp),%eax
 74d:	50                   	push   %eax
 74e:	ff 75 08             	pushl  0x8(%ebp)
 751:	e8 5a fd ff ff       	call   4b0 <write>
        ap++;
 756:	83 c7 04             	add    $0x4,%edi
 759:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 75c:	83 c4 10             	add    $0x10,%esp
      state = 0;
 75f:	bf 00 00 00 00       	mov    $0x0,%edi
 764:	e9 a4 fe ff ff       	jmp    60d <printf+0x49>
        putc(fd, c);
 769:	88 5d e7             	mov    %bl,-0x19(%ebp)
  write(fd, &c, 1);
 76c:	83 ec 04             	sub    $0x4,%esp
 76f:	6a 01                	push   $0x1
 771:	8d 45 e7             	lea    -0x19(%ebp),%eax
 774:	50                   	push   %eax
 775:	ff 75 08             	pushl  0x8(%ebp)
 778:	e8 33 fd ff ff       	call   4b0 <write>
 77d:	83 c4 10             	add    $0x10,%esp
      state = 0;
 780:	bf 00 00 00 00       	mov    $0x0,%edi
 785:	e9 83 fe ff ff       	jmp    60d <printf+0x49>
    }
  }
}
 78a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 78d:	5b                   	pop    %ebx
 78e:	5e                   	pop    %esi
 78f:	5f                   	pop    %edi
 790:	5d                   	pop    %ebp
 791:	c3                   	ret    

00000792 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 792:	f3 0f 1e fb          	endbr32 
 796:	55                   	push   %ebp
 797:	89 e5                	mov    %esp,%ebp
 799:	57                   	push   %edi
 79a:	56                   	push   %esi
 79b:	53                   	push   %ebx
 79c:	8b 5d 08             	mov    0x8(%ebp),%ebx
  Header *bp, *p;

  bp = (Header*)ap - 1;
 79f:	8d 4b f8             	lea    -0x8(%ebx),%ecx
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7a2:	a1 40 0c 00 00       	mov    0xc40,%eax
 7a7:	eb 0c                	jmp    7b5 <free+0x23>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7a9:	8b 10                	mov    (%eax),%edx
 7ab:	39 c2                	cmp    %eax,%edx
 7ad:	77 04                	ja     7b3 <free+0x21>
 7af:	39 ca                	cmp    %ecx,%edx
 7b1:	77 10                	ja     7c3 <free+0x31>
{
 7b3:	89 d0                	mov    %edx,%eax
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 7b5:	39 c8                	cmp    %ecx,%eax
 7b7:	73 f0                	jae    7a9 <free+0x17>
 7b9:	8b 10                	mov    (%eax),%edx
 7bb:	39 ca                	cmp    %ecx,%edx
 7bd:	77 04                	ja     7c3 <free+0x31>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 7bf:	39 c2                	cmp    %eax,%edx
 7c1:	77 f0                	ja     7b3 <free+0x21>
      break;
  if(bp + bp->s.size == p->s.ptr){
 7c3:	8b 73 fc             	mov    -0x4(%ebx),%esi
 7c6:	8b 10                	mov    (%eax),%edx
 7c8:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 7cb:	39 fa                	cmp    %edi,%edx
 7cd:	74 19                	je     7e8 <free+0x56>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 7cf:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 7d2:	8b 50 04             	mov    0x4(%eax),%edx
 7d5:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 7d8:	39 f1                	cmp    %esi,%ecx
 7da:	74 1b                	je     7f7 <free+0x65>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 7dc:	89 08                	mov    %ecx,(%eax)
  freep = p;
 7de:	a3 40 0c 00 00       	mov    %eax,0xc40
}
 7e3:	5b                   	pop    %ebx
 7e4:	5e                   	pop    %esi
 7e5:	5f                   	pop    %edi
 7e6:	5d                   	pop    %ebp
 7e7:	c3                   	ret    
    bp->s.size += p->s.ptr->s.size;
 7e8:	03 72 04             	add    0x4(%edx),%esi
 7eb:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 7ee:	8b 10                	mov    (%eax),%edx
 7f0:	8b 12                	mov    (%edx),%edx
 7f2:	89 53 f8             	mov    %edx,-0x8(%ebx)
 7f5:	eb db                	jmp    7d2 <free+0x40>
    p->s.size += bp->s.size;
 7f7:	03 53 fc             	add    -0x4(%ebx),%edx
 7fa:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 7fd:	8b 53 f8             	mov    -0x8(%ebx),%edx
 800:	89 10                	mov    %edx,(%eax)
 802:	eb da                	jmp    7de <free+0x4c>

00000804 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 804:	f3 0f 1e fb          	endbr32 
 808:	55                   	push   %ebp
 809:	89 e5                	mov    %esp,%ebp
 80b:	57                   	push   %edi
 80c:	56                   	push   %esi
 80d:	53                   	push   %ebx
 80e:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 811:	8b 45 08             	mov    0x8(%ebp),%eax
 814:	8d 58 07             	lea    0x7(%eax),%ebx
 817:	c1 eb 03             	shr    $0x3,%ebx
 81a:	83 c3 01             	add    $0x1,%ebx
  if((prevp = freep) == 0){
 81d:	8b 15 40 0c 00 00    	mov    0xc40,%edx
 823:	85 d2                	test   %edx,%edx
 825:	74 20                	je     847 <malloc+0x43>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 827:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 829:	8b 48 04             	mov    0x4(%eax),%ecx
 82c:	39 cb                	cmp    %ecx,%ebx
 82e:	76 3c                	jbe    86c <malloc+0x68>
 830:	81 fb 00 10 00 00    	cmp    $0x1000,%ebx
 836:	be 00 10 00 00       	mov    $0x1000,%esi
 83b:	0f 43 f3             	cmovae %ebx,%esi
  p = sbrk(nu * sizeof(Header));
 83e:	8d 3c f5 00 00 00 00 	lea    0x0(,%esi,8),%edi
 845:	eb 72                	jmp    8b9 <malloc+0xb5>
    base.s.ptr = freep = prevp = &base;
 847:	c7 05 40 0c 00 00 44 	movl   $0xc44,0xc40
 84e:	0c 00 00 
 851:	c7 05 44 0c 00 00 44 	movl   $0xc44,0xc44
 858:	0c 00 00 
    base.s.size = 0;
 85b:	c7 05 48 0c 00 00 00 	movl   $0x0,0xc48
 862:	00 00 00 
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 865:	b8 44 0c 00 00       	mov    $0xc44,%eax
 86a:	eb c4                	jmp    830 <malloc+0x2c>
      if(p->s.size == nunits)
 86c:	39 cb                	cmp    %ecx,%ebx
 86e:	74 1e                	je     88e <malloc+0x8a>
        prevp->s.ptr = p->s.ptr;
      else {
        p->s.size -= nunits;
 870:	29 d9                	sub    %ebx,%ecx
 872:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 875:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 878:	89 58 04             	mov    %ebx,0x4(%eax)
      }
      freep = prevp;
 87b:	89 15 40 0c 00 00    	mov    %edx,0xc40
      return (void*)(p + 1);
 881:	8d 50 08             	lea    0x8(%eax),%edx
    }
    if(p == freep)
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
 884:	89 d0                	mov    %edx,%eax
 886:	8d 65 f4             	lea    -0xc(%ebp),%esp
 889:	5b                   	pop    %ebx
 88a:	5e                   	pop    %esi
 88b:	5f                   	pop    %edi
 88c:	5d                   	pop    %ebp
 88d:	c3                   	ret    
        prevp->s.ptr = p->s.ptr;
 88e:	8b 08                	mov    (%eax),%ecx
 890:	89 0a                	mov    %ecx,(%edx)
 892:	eb e7                	jmp    87b <malloc+0x77>
  hp->s.size = nu;
 894:	89 70 04             	mov    %esi,0x4(%eax)
  free((void*)(hp + 1));
 897:	83 ec 0c             	sub    $0xc,%esp
 89a:	83 c0 08             	add    $0x8,%eax
 89d:	50                   	push   %eax
 89e:	e8 ef fe ff ff       	call   792 <free>
  return freep;
 8a3:	8b 15 40 0c 00 00    	mov    0xc40,%edx
      if((p = morecore(nunits)) == 0)
 8a9:	83 c4 10             	add    $0x10,%esp
 8ac:	85 d2                	test   %edx,%edx
 8ae:	74 d4                	je     884 <malloc+0x80>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 8b0:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 8b2:	8b 48 04             	mov    0x4(%eax),%ecx
 8b5:	39 d9                	cmp    %ebx,%ecx
 8b7:	73 b3                	jae    86c <malloc+0x68>
    if(p == freep)
 8b9:	89 c2                	mov    %eax,%edx
 8bb:	39 05 40 0c 00 00    	cmp    %eax,0xc40
 8c1:	75 ed                	jne    8b0 <malloc+0xac>
  p = sbrk(nu * sizeof(Header));
 8c3:	83 ec 0c             	sub    $0xc,%esp
 8c6:	57                   	push   %edi
 8c7:	e8 4c fc ff ff       	call   518 <sbrk>
  if(p == (char*)-1)
 8cc:	83 c4 10             	add    $0x10,%esp
 8cf:	83 f8 ff             	cmp    $0xffffffff,%eax
 8d2:	75 c0                	jne    894 <malloc+0x90>
        return 0;
 8d4:	ba 00 00 00 00       	mov    $0x0,%edx
 8d9:	eb a9                	jmp    884 <malloc+0x80>
