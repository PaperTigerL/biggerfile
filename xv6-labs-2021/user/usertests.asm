
user/_usertests:     file format elf64-littleriscv


Disassembly of section .text:

0000000000000000 <copyinstr1>:
}

// what if you pass ridiculous string pointers to system calls?
void
copyinstr1(char *s)
{
       0:	1141                	addi	sp,sp,-16
       2:	e406                	sd	ra,8(sp)
       4:	e022                	sd	s0,0(sp)
       6:	0800                	addi	s0,sp,16
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };

  for(int ai = 0; ai < 2; ai++){
    uint64 addr = addrs[ai];

    int fd = open((char *)addr, O_CREATE|O_WRONLY);
       8:	20100593          	li	a1,513
       c:	4505                	li	a0,1
       e:	057e                	slli	a0,a0,0x1f
      10:	00006097          	auipc	ra,0x6
      14:	874080e7          	jalr	-1932(ra) # 5884 <open>
    if(fd >= 0){
      18:	02055063          	bgez	a0,38 <copyinstr1+0x38>
    int fd = open((char *)addr, O_CREATE|O_WRONLY);
      1c:	20100593          	li	a1,513
      20:	557d                	li	a0,-1
      22:	00006097          	auipc	ra,0x6
      26:	862080e7          	jalr	-1950(ra) # 5884 <open>
    uint64 addr = addrs[ai];
      2a:	55fd                	li	a1,-1
    if(fd >= 0){
      2c:	00055863          	bgez	a0,3c <copyinstr1+0x3c>
      printf("open(%p) returned %d, not -1\n", addr, fd);
      exit(1);
    }
  }
}
      30:	60a2                	ld	ra,8(sp)
      32:	6402                	ld	s0,0(sp)
      34:	0141                	addi	sp,sp,16
      36:	8082                	ret
    uint64 addr = addrs[ai];
      38:	4585                	li	a1,1
      3a:	05fe                	slli	a1,a1,0x1f
      printf("open(%p) returned %d, not -1\n", addr, fd);
      3c:	862a                	mv	a2,a0
      3e:	00006517          	auipc	a0,0x6
      42:	d2250513          	addi	a0,a0,-734 # 5d60 <malloc+0xea>
      46:	00006097          	auipc	ra,0x6
      4a:	b78080e7          	jalr	-1160(ra) # 5bbe <printf>
      exit(1);
      4e:	4505                	li	a0,1
      50:	00005097          	auipc	ra,0x5
      54:	7f4080e7          	jalr	2036(ra) # 5844 <exit>

0000000000000058 <bsstest>:
void
bsstest(char *s)
{
  int i;

  for(i = 0; i < sizeof(uninit); i++){
      58:	00009797          	auipc	a5,0x9
      5c:	67078793          	addi	a5,a5,1648 # 96c8 <uninit>
      60:	0000c697          	auipc	a3,0xc
      64:	d7868693          	addi	a3,a3,-648 # bdd8 <buf>
    if(uninit[i] != '\0'){
      68:	0007c703          	lbu	a4,0(a5)
      6c:	e709                	bnez	a4,76 <bsstest+0x1e>
  for(i = 0; i < sizeof(uninit); i++){
      6e:	0785                	addi	a5,a5,1
      70:	fed79ce3          	bne	a5,a3,68 <bsstest+0x10>
      74:	8082                	ret
{
      76:	1141                	addi	sp,sp,-16
      78:	e406                	sd	ra,8(sp)
      7a:	e022                	sd	s0,0(sp)
      7c:	0800                	addi	s0,sp,16
      printf("%s: bss test failed\n", s);
      7e:	85aa                	mv	a1,a0
      80:	00006517          	auipc	a0,0x6
      84:	d0050513          	addi	a0,a0,-768 # 5d80 <malloc+0x10a>
      88:	00006097          	auipc	ra,0x6
      8c:	b36080e7          	jalr	-1226(ra) # 5bbe <printf>
      exit(1);
      90:	4505                	li	a0,1
      92:	00005097          	auipc	ra,0x5
      96:	7b2080e7          	jalr	1970(ra) # 5844 <exit>

000000000000009a <opentest>:
{
      9a:	1101                	addi	sp,sp,-32
      9c:	ec06                	sd	ra,24(sp)
      9e:	e822                	sd	s0,16(sp)
      a0:	e426                	sd	s1,8(sp)
      a2:	1000                	addi	s0,sp,32
      a4:	84aa                	mv	s1,a0
  fd = open("echo", 0);
      a6:	4581                	li	a1,0
      a8:	00006517          	auipc	a0,0x6
      ac:	cf050513          	addi	a0,a0,-784 # 5d98 <malloc+0x122>
      b0:	00005097          	auipc	ra,0x5
      b4:	7d4080e7          	jalr	2004(ra) # 5884 <open>
  if(fd < 0){
      b8:	02054663          	bltz	a0,e4 <opentest+0x4a>
  close(fd);
      bc:	00005097          	auipc	ra,0x5
      c0:	7b0080e7          	jalr	1968(ra) # 586c <close>
  fd = open("doesnotexist", 0);
      c4:	4581                	li	a1,0
      c6:	00006517          	auipc	a0,0x6
      ca:	cf250513          	addi	a0,a0,-782 # 5db8 <malloc+0x142>
      ce:	00005097          	auipc	ra,0x5
      d2:	7b6080e7          	jalr	1974(ra) # 5884 <open>
  if(fd >= 0){
      d6:	02055563          	bgez	a0,100 <opentest+0x66>
}
      da:	60e2                	ld	ra,24(sp)
      dc:	6442                	ld	s0,16(sp)
      de:	64a2                	ld	s1,8(sp)
      e0:	6105                	addi	sp,sp,32
      e2:	8082                	ret
    printf("%s: open echo failed!\n", s);
      e4:	85a6                	mv	a1,s1
      e6:	00006517          	auipc	a0,0x6
      ea:	cba50513          	addi	a0,a0,-838 # 5da0 <malloc+0x12a>
      ee:	00006097          	auipc	ra,0x6
      f2:	ad0080e7          	jalr	-1328(ra) # 5bbe <printf>
    exit(1);
      f6:	4505                	li	a0,1
      f8:	00005097          	auipc	ra,0x5
      fc:	74c080e7          	jalr	1868(ra) # 5844 <exit>
    printf("%s: open doesnotexist succeeded!\n", s);
     100:	85a6                	mv	a1,s1
     102:	00006517          	auipc	a0,0x6
     106:	cc650513          	addi	a0,a0,-826 # 5dc8 <malloc+0x152>
     10a:	00006097          	auipc	ra,0x6
     10e:	ab4080e7          	jalr	-1356(ra) # 5bbe <printf>
    exit(1);
     112:	4505                	li	a0,1
     114:	00005097          	auipc	ra,0x5
     118:	730080e7          	jalr	1840(ra) # 5844 <exit>

000000000000011c <truncate2>:
{
     11c:	7179                	addi	sp,sp,-48
     11e:	f406                	sd	ra,40(sp)
     120:	f022                	sd	s0,32(sp)
     122:	ec26                	sd	s1,24(sp)
     124:	e84a                	sd	s2,16(sp)
     126:	e44e                	sd	s3,8(sp)
     128:	1800                	addi	s0,sp,48
     12a:	89aa                	mv	s3,a0
  unlink("truncfile");
     12c:	00006517          	auipc	a0,0x6
     130:	cc450513          	addi	a0,a0,-828 # 5df0 <malloc+0x17a>
     134:	00005097          	auipc	ra,0x5
     138:	760080e7          	jalr	1888(ra) # 5894 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_TRUNC|O_WRONLY);
     13c:	60100593          	li	a1,1537
     140:	00006517          	auipc	a0,0x6
     144:	cb050513          	addi	a0,a0,-848 # 5df0 <malloc+0x17a>
     148:	00005097          	auipc	ra,0x5
     14c:	73c080e7          	jalr	1852(ra) # 5884 <open>
     150:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     152:	4611                	li	a2,4
     154:	00006597          	auipc	a1,0x6
     158:	cac58593          	addi	a1,a1,-852 # 5e00 <malloc+0x18a>
     15c:	00005097          	auipc	ra,0x5
     160:	708080e7          	jalr	1800(ra) # 5864 <write>
  int fd2 = open("truncfile", O_TRUNC|O_WRONLY);
     164:	40100593          	li	a1,1025
     168:	00006517          	auipc	a0,0x6
     16c:	c8850513          	addi	a0,a0,-888 # 5df0 <malloc+0x17a>
     170:	00005097          	auipc	ra,0x5
     174:	714080e7          	jalr	1812(ra) # 5884 <open>
     178:	892a                	mv	s2,a0
  int n = write(fd1, "x", 1);
     17a:	4605                	li	a2,1
     17c:	00006597          	auipc	a1,0x6
     180:	c8c58593          	addi	a1,a1,-884 # 5e08 <malloc+0x192>
     184:	8526                	mv	a0,s1
     186:	00005097          	auipc	ra,0x5
     18a:	6de080e7          	jalr	1758(ra) # 5864 <write>
  if(n != -1){
     18e:	57fd                	li	a5,-1
     190:	02f51b63          	bne	a0,a5,1c6 <truncate2+0xaa>
  unlink("truncfile");
     194:	00006517          	auipc	a0,0x6
     198:	c5c50513          	addi	a0,a0,-932 # 5df0 <malloc+0x17a>
     19c:	00005097          	auipc	ra,0x5
     1a0:	6f8080e7          	jalr	1784(ra) # 5894 <unlink>
  close(fd1);
     1a4:	8526                	mv	a0,s1
     1a6:	00005097          	auipc	ra,0x5
     1aa:	6c6080e7          	jalr	1734(ra) # 586c <close>
  close(fd2);
     1ae:	854a                	mv	a0,s2
     1b0:	00005097          	auipc	ra,0x5
     1b4:	6bc080e7          	jalr	1724(ra) # 586c <close>
}
     1b8:	70a2                	ld	ra,40(sp)
     1ba:	7402                	ld	s0,32(sp)
     1bc:	64e2                	ld	s1,24(sp)
     1be:	6942                	ld	s2,16(sp)
     1c0:	69a2                	ld	s3,8(sp)
     1c2:	6145                	addi	sp,sp,48
     1c4:	8082                	ret
    printf("%s: write returned %d, expected -1\n", s, n);
     1c6:	862a                	mv	a2,a0
     1c8:	85ce                	mv	a1,s3
     1ca:	00006517          	auipc	a0,0x6
     1ce:	c4650513          	addi	a0,a0,-954 # 5e10 <malloc+0x19a>
     1d2:	00006097          	auipc	ra,0x6
     1d6:	9ec080e7          	jalr	-1556(ra) # 5bbe <printf>
    exit(1);
     1da:	4505                	li	a0,1
     1dc:	00005097          	auipc	ra,0x5
     1e0:	668080e7          	jalr	1640(ra) # 5844 <exit>

00000000000001e4 <createtest>:
{
     1e4:	7179                	addi	sp,sp,-48
     1e6:	f406                	sd	ra,40(sp)
     1e8:	f022                	sd	s0,32(sp)
     1ea:	ec26                	sd	s1,24(sp)
     1ec:	e84a                	sd	s2,16(sp)
     1ee:	1800                	addi	s0,sp,48
  name[0] = 'a';
     1f0:	06100793          	li	a5,97
     1f4:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     1f8:	fc040d23          	sb	zero,-38(s0)
     1fc:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     200:	06400913          	li	s2,100
    name[1] = '0' + i;
     204:	fc940ca3          	sb	s1,-39(s0)
    fd = open(name, O_CREATE|O_RDWR);
     208:	20200593          	li	a1,514
     20c:	fd840513          	addi	a0,s0,-40
     210:	00005097          	auipc	ra,0x5
     214:	674080e7          	jalr	1652(ra) # 5884 <open>
    close(fd);
     218:	00005097          	auipc	ra,0x5
     21c:	654080e7          	jalr	1620(ra) # 586c <close>
  for(i = 0; i < N; i++){
     220:	2485                	addiw	s1,s1,1
     222:	0ff4f493          	zext.b	s1,s1
     226:	fd249fe3          	bne	s1,s2,204 <createtest+0x20>
  name[0] = 'a';
     22a:	06100793          	li	a5,97
     22e:	fcf40c23          	sb	a5,-40(s0)
  name[2] = '\0';
     232:	fc040d23          	sb	zero,-38(s0)
     236:	03000493          	li	s1,48
  for(i = 0; i < N; i++){
     23a:	06400913          	li	s2,100
    name[1] = '0' + i;
     23e:	fc940ca3          	sb	s1,-39(s0)
    unlink(name);
     242:	fd840513          	addi	a0,s0,-40
     246:	00005097          	auipc	ra,0x5
     24a:	64e080e7          	jalr	1614(ra) # 5894 <unlink>
  for(i = 0; i < N; i++){
     24e:	2485                	addiw	s1,s1,1
     250:	0ff4f493          	zext.b	s1,s1
     254:	ff2495e3          	bne	s1,s2,23e <createtest+0x5a>
}
     258:	70a2                	ld	ra,40(sp)
     25a:	7402                	ld	s0,32(sp)
     25c:	64e2                	ld	s1,24(sp)
     25e:	6942                	ld	s2,16(sp)
     260:	6145                	addi	sp,sp,48
     262:	8082                	ret

0000000000000264 <bigwrite>:
{
     264:	715d                	addi	sp,sp,-80
     266:	e486                	sd	ra,72(sp)
     268:	e0a2                	sd	s0,64(sp)
     26a:	fc26                	sd	s1,56(sp)
     26c:	f84a                	sd	s2,48(sp)
     26e:	f44e                	sd	s3,40(sp)
     270:	f052                	sd	s4,32(sp)
     272:	ec56                	sd	s5,24(sp)
     274:	e85a                	sd	s6,16(sp)
     276:	e45e                	sd	s7,8(sp)
     278:	0880                	addi	s0,sp,80
     27a:	8baa                	mv	s7,a0
  unlink("bigwrite");
     27c:	00006517          	auipc	a0,0x6
     280:	bbc50513          	addi	a0,a0,-1092 # 5e38 <malloc+0x1c2>
     284:	00005097          	auipc	ra,0x5
     288:	610080e7          	jalr	1552(ra) # 5894 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     28c:	1f300493          	li	s1,499
    fd = open("bigwrite", O_CREATE | O_RDWR);
     290:	00006a97          	auipc	s5,0x6
     294:	ba8a8a93          	addi	s5,s5,-1112 # 5e38 <malloc+0x1c2>
      int cc = write(fd, buf, sz);
     298:	0000ca17          	auipc	s4,0xc
     29c:	b40a0a13          	addi	s4,s4,-1216 # bdd8 <buf>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2a0:	6b0d                	lui	s6,0x3
     2a2:	1c9b0b13          	addi	s6,s6,457 # 31c9 <dirtest+0x95>
    fd = open("bigwrite", O_CREATE | O_RDWR);
     2a6:	20200593          	li	a1,514
     2aa:	8556                	mv	a0,s5
     2ac:	00005097          	auipc	ra,0x5
     2b0:	5d8080e7          	jalr	1496(ra) # 5884 <open>
     2b4:	892a                	mv	s2,a0
    if(fd < 0){
     2b6:	04054d63          	bltz	a0,310 <bigwrite+0xac>
      int cc = write(fd, buf, sz);
     2ba:	8626                	mv	a2,s1
     2bc:	85d2                	mv	a1,s4
     2be:	00005097          	auipc	ra,0x5
     2c2:	5a6080e7          	jalr	1446(ra) # 5864 <write>
     2c6:	89aa                	mv	s3,a0
      if(cc != sz){
     2c8:	06a49263          	bne	s1,a0,32c <bigwrite+0xc8>
      int cc = write(fd, buf, sz);
     2cc:	8626                	mv	a2,s1
     2ce:	85d2                	mv	a1,s4
     2d0:	854a                	mv	a0,s2
     2d2:	00005097          	auipc	ra,0x5
     2d6:	592080e7          	jalr	1426(ra) # 5864 <write>
      if(cc != sz){
     2da:	04951a63          	bne	a0,s1,32e <bigwrite+0xca>
    close(fd);
     2de:	854a                	mv	a0,s2
     2e0:	00005097          	auipc	ra,0x5
     2e4:	58c080e7          	jalr	1420(ra) # 586c <close>
    unlink("bigwrite");
     2e8:	8556                	mv	a0,s5
     2ea:	00005097          	auipc	ra,0x5
     2ee:	5aa080e7          	jalr	1450(ra) # 5894 <unlink>
  for(sz = 499; sz < (MAXOPBLOCKS+2)*BSIZE; sz += 471){
     2f2:	1d74849b          	addiw	s1,s1,471
     2f6:	fb6498e3          	bne	s1,s6,2a6 <bigwrite+0x42>
}
     2fa:	60a6                	ld	ra,72(sp)
     2fc:	6406                	ld	s0,64(sp)
     2fe:	74e2                	ld	s1,56(sp)
     300:	7942                	ld	s2,48(sp)
     302:	79a2                	ld	s3,40(sp)
     304:	7a02                	ld	s4,32(sp)
     306:	6ae2                	ld	s5,24(sp)
     308:	6b42                	ld	s6,16(sp)
     30a:	6ba2                	ld	s7,8(sp)
     30c:	6161                	addi	sp,sp,80
     30e:	8082                	ret
      printf("%s: cannot create bigwrite\n", s);
     310:	85de                	mv	a1,s7
     312:	00006517          	auipc	a0,0x6
     316:	b3650513          	addi	a0,a0,-1226 # 5e48 <malloc+0x1d2>
     31a:	00006097          	auipc	ra,0x6
     31e:	8a4080e7          	jalr	-1884(ra) # 5bbe <printf>
      exit(1);
     322:	4505                	li	a0,1
     324:	00005097          	auipc	ra,0x5
     328:	520080e7          	jalr	1312(ra) # 5844 <exit>
      if(cc != sz){
     32c:	89a6                	mv	s3,s1
        printf("%s: write(%d) ret %d\n", s, sz, cc);
     32e:	86aa                	mv	a3,a0
     330:	864e                	mv	a2,s3
     332:	85de                	mv	a1,s7
     334:	00006517          	auipc	a0,0x6
     338:	b3450513          	addi	a0,a0,-1228 # 5e68 <malloc+0x1f2>
     33c:	00006097          	auipc	ra,0x6
     340:	882080e7          	jalr	-1918(ra) # 5bbe <printf>
        exit(1);
     344:	4505                	li	a0,1
     346:	00005097          	auipc	ra,0x5
     34a:	4fe080e7          	jalr	1278(ra) # 5844 <exit>

000000000000034e <copyin>:
{
     34e:	715d                	addi	sp,sp,-80
     350:	e486                	sd	ra,72(sp)
     352:	e0a2                	sd	s0,64(sp)
     354:	fc26                	sd	s1,56(sp)
     356:	f84a                	sd	s2,48(sp)
     358:	f44e                	sd	s3,40(sp)
     35a:	f052                	sd	s4,32(sp)
     35c:	0880                	addi	s0,sp,80
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     35e:	4785                	li	a5,1
     360:	07fe                	slli	a5,a5,0x1f
     362:	fcf43023          	sd	a5,-64(s0)
     366:	57fd                	li	a5,-1
     368:	fcf43423          	sd	a5,-56(s0)
  for(int ai = 0; ai < 2; ai++){
     36c:	fc040913          	addi	s2,s0,-64
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     370:	00006a17          	auipc	s4,0x6
     374:	b10a0a13          	addi	s4,s4,-1264 # 5e80 <malloc+0x20a>
    uint64 addr = addrs[ai];
     378:	00093983          	ld	s3,0(s2)
    int fd = open("copyin1", O_CREATE|O_WRONLY);
     37c:	20100593          	li	a1,513
     380:	8552                	mv	a0,s4
     382:	00005097          	auipc	ra,0x5
     386:	502080e7          	jalr	1282(ra) # 5884 <open>
     38a:	84aa                	mv	s1,a0
    if(fd < 0){
     38c:	08054863          	bltz	a0,41c <copyin+0xce>
    int n = write(fd, (void*)addr, 8192);
     390:	6609                	lui	a2,0x2
     392:	85ce                	mv	a1,s3
     394:	00005097          	auipc	ra,0x5
     398:	4d0080e7          	jalr	1232(ra) # 5864 <write>
    if(n >= 0){
     39c:	08055d63          	bgez	a0,436 <copyin+0xe8>
    close(fd);
     3a0:	8526                	mv	a0,s1
     3a2:	00005097          	auipc	ra,0x5
     3a6:	4ca080e7          	jalr	1226(ra) # 586c <close>
    unlink("copyin1");
     3aa:	8552                	mv	a0,s4
     3ac:	00005097          	auipc	ra,0x5
     3b0:	4e8080e7          	jalr	1256(ra) # 5894 <unlink>
    n = write(1, (char*)addr, 8192);
     3b4:	6609                	lui	a2,0x2
     3b6:	85ce                	mv	a1,s3
     3b8:	4505                	li	a0,1
     3ba:	00005097          	auipc	ra,0x5
     3be:	4aa080e7          	jalr	1194(ra) # 5864 <write>
    if(n > 0){
     3c2:	08a04963          	bgtz	a0,454 <copyin+0x106>
    if(pipe(fds) < 0){
     3c6:	fb840513          	addi	a0,s0,-72
     3ca:	00005097          	auipc	ra,0x5
     3ce:	48a080e7          	jalr	1162(ra) # 5854 <pipe>
     3d2:	0a054063          	bltz	a0,472 <copyin+0x124>
    n = write(fds[1], (char*)addr, 8192);
     3d6:	6609                	lui	a2,0x2
     3d8:	85ce                	mv	a1,s3
     3da:	fbc42503          	lw	a0,-68(s0)
     3de:	00005097          	auipc	ra,0x5
     3e2:	486080e7          	jalr	1158(ra) # 5864 <write>
    if(n > 0){
     3e6:	0aa04363          	bgtz	a0,48c <copyin+0x13e>
    close(fds[0]);
     3ea:	fb842503          	lw	a0,-72(s0)
     3ee:	00005097          	auipc	ra,0x5
     3f2:	47e080e7          	jalr	1150(ra) # 586c <close>
    close(fds[1]);
     3f6:	fbc42503          	lw	a0,-68(s0)
     3fa:	00005097          	auipc	ra,0x5
     3fe:	472080e7          	jalr	1138(ra) # 586c <close>
  for(int ai = 0; ai < 2; ai++){
     402:	0921                	addi	s2,s2,8
     404:	fd040793          	addi	a5,s0,-48
     408:	f6f918e3          	bne	s2,a5,378 <copyin+0x2a>
}
     40c:	60a6                	ld	ra,72(sp)
     40e:	6406                	ld	s0,64(sp)
     410:	74e2                	ld	s1,56(sp)
     412:	7942                	ld	s2,48(sp)
     414:	79a2                	ld	s3,40(sp)
     416:	7a02                	ld	s4,32(sp)
     418:	6161                	addi	sp,sp,80
     41a:	8082                	ret
      printf("open(copyin1) failed\n");
     41c:	00006517          	auipc	a0,0x6
     420:	a6c50513          	addi	a0,a0,-1428 # 5e88 <malloc+0x212>
     424:	00005097          	auipc	ra,0x5
     428:	79a080e7          	jalr	1946(ra) # 5bbe <printf>
      exit(1);
     42c:	4505                	li	a0,1
     42e:	00005097          	auipc	ra,0x5
     432:	416080e7          	jalr	1046(ra) # 5844 <exit>
      printf("write(fd, %p, 8192) returned %d, not -1\n", addr, n);
     436:	862a                	mv	a2,a0
     438:	85ce                	mv	a1,s3
     43a:	00006517          	auipc	a0,0x6
     43e:	a6650513          	addi	a0,a0,-1434 # 5ea0 <malloc+0x22a>
     442:	00005097          	auipc	ra,0x5
     446:	77c080e7          	jalr	1916(ra) # 5bbe <printf>
      exit(1);
     44a:	4505                	li	a0,1
     44c:	00005097          	auipc	ra,0x5
     450:	3f8080e7          	jalr	1016(ra) # 5844 <exit>
      printf("write(1, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     454:	862a                	mv	a2,a0
     456:	85ce                	mv	a1,s3
     458:	00006517          	auipc	a0,0x6
     45c:	a7850513          	addi	a0,a0,-1416 # 5ed0 <malloc+0x25a>
     460:	00005097          	auipc	ra,0x5
     464:	75e080e7          	jalr	1886(ra) # 5bbe <printf>
      exit(1);
     468:	4505                	li	a0,1
     46a:	00005097          	auipc	ra,0x5
     46e:	3da080e7          	jalr	986(ra) # 5844 <exit>
      printf("pipe() failed\n");
     472:	00006517          	auipc	a0,0x6
     476:	a8e50513          	addi	a0,a0,-1394 # 5f00 <malloc+0x28a>
     47a:	00005097          	auipc	ra,0x5
     47e:	744080e7          	jalr	1860(ra) # 5bbe <printf>
      exit(1);
     482:	4505                	li	a0,1
     484:	00005097          	auipc	ra,0x5
     488:	3c0080e7          	jalr	960(ra) # 5844 <exit>
      printf("write(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     48c:	862a                	mv	a2,a0
     48e:	85ce                	mv	a1,s3
     490:	00006517          	auipc	a0,0x6
     494:	a8050513          	addi	a0,a0,-1408 # 5f10 <malloc+0x29a>
     498:	00005097          	auipc	ra,0x5
     49c:	726080e7          	jalr	1830(ra) # 5bbe <printf>
      exit(1);
     4a0:	4505                	li	a0,1
     4a2:	00005097          	auipc	ra,0x5
     4a6:	3a2080e7          	jalr	930(ra) # 5844 <exit>

00000000000004aa <copyout>:
{
     4aa:	711d                	addi	sp,sp,-96
     4ac:	ec86                	sd	ra,88(sp)
     4ae:	e8a2                	sd	s0,80(sp)
     4b0:	e4a6                	sd	s1,72(sp)
     4b2:	e0ca                	sd	s2,64(sp)
     4b4:	fc4e                	sd	s3,56(sp)
     4b6:	f852                	sd	s4,48(sp)
     4b8:	f456                	sd	s5,40(sp)
     4ba:	1080                	addi	s0,sp,96
  uint64 addrs[] = { 0x80000000LL, 0xffffffffffffffff };
     4bc:	4785                	li	a5,1
     4be:	07fe                	slli	a5,a5,0x1f
     4c0:	faf43823          	sd	a5,-80(s0)
     4c4:	57fd                	li	a5,-1
     4c6:	faf43c23          	sd	a5,-72(s0)
  for(int ai = 0; ai < 2; ai++){
     4ca:	fb040913          	addi	s2,s0,-80
    int fd = open("README", 0);
     4ce:	00006a17          	auipc	s4,0x6
     4d2:	a72a0a13          	addi	s4,s4,-1422 # 5f40 <malloc+0x2ca>
    n = write(fds[1], "x", 1);
     4d6:	00006a97          	auipc	s5,0x6
     4da:	932a8a93          	addi	s5,s5,-1742 # 5e08 <malloc+0x192>
    uint64 addr = addrs[ai];
     4de:	00093983          	ld	s3,0(s2)
    int fd = open("README", 0);
     4e2:	4581                	li	a1,0
     4e4:	8552                	mv	a0,s4
     4e6:	00005097          	auipc	ra,0x5
     4ea:	39e080e7          	jalr	926(ra) # 5884 <open>
     4ee:	84aa                	mv	s1,a0
    if(fd < 0){
     4f0:	08054663          	bltz	a0,57c <copyout+0xd2>
    int n = read(fd, (void*)addr, 8192);
     4f4:	6609                	lui	a2,0x2
     4f6:	85ce                	mv	a1,s3
     4f8:	00005097          	auipc	ra,0x5
     4fc:	364080e7          	jalr	868(ra) # 585c <read>
    if(n > 0){
     500:	08a04b63          	bgtz	a0,596 <copyout+0xec>
    close(fd);
     504:	8526                	mv	a0,s1
     506:	00005097          	auipc	ra,0x5
     50a:	366080e7          	jalr	870(ra) # 586c <close>
    if(pipe(fds) < 0){
     50e:	fa840513          	addi	a0,s0,-88
     512:	00005097          	auipc	ra,0x5
     516:	342080e7          	jalr	834(ra) # 5854 <pipe>
     51a:	08054d63          	bltz	a0,5b4 <copyout+0x10a>
    n = write(fds[1], "x", 1);
     51e:	4605                	li	a2,1
     520:	85d6                	mv	a1,s5
     522:	fac42503          	lw	a0,-84(s0)
     526:	00005097          	auipc	ra,0x5
     52a:	33e080e7          	jalr	830(ra) # 5864 <write>
    if(n != 1){
     52e:	4785                	li	a5,1
     530:	08f51f63          	bne	a0,a5,5ce <copyout+0x124>
    n = read(fds[0], (void*)addr, 8192);
     534:	6609                	lui	a2,0x2
     536:	85ce                	mv	a1,s3
     538:	fa842503          	lw	a0,-88(s0)
     53c:	00005097          	auipc	ra,0x5
     540:	320080e7          	jalr	800(ra) # 585c <read>
    if(n > 0){
     544:	0aa04263          	bgtz	a0,5e8 <copyout+0x13e>
    close(fds[0]);
     548:	fa842503          	lw	a0,-88(s0)
     54c:	00005097          	auipc	ra,0x5
     550:	320080e7          	jalr	800(ra) # 586c <close>
    close(fds[1]);
     554:	fac42503          	lw	a0,-84(s0)
     558:	00005097          	auipc	ra,0x5
     55c:	314080e7          	jalr	788(ra) # 586c <close>
  for(int ai = 0; ai < 2; ai++){
     560:	0921                	addi	s2,s2,8
     562:	fc040793          	addi	a5,s0,-64
     566:	f6f91ce3          	bne	s2,a5,4de <copyout+0x34>
}
     56a:	60e6                	ld	ra,88(sp)
     56c:	6446                	ld	s0,80(sp)
     56e:	64a6                	ld	s1,72(sp)
     570:	6906                	ld	s2,64(sp)
     572:	79e2                	ld	s3,56(sp)
     574:	7a42                	ld	s4,48(sp)
     576:	7aa2                	ld	s5,40(sp)
     578:	6125                	addi	sp,sp,96
     57a:	8082                	ret
      printf("open(README) failed\n");
     57c:	00006517          	auipc	a0,0x6
     580:	9cc50513          	addi	a0,a0,-1588 # 5f48 <malloc+0x2d2>
     584:	00005097          	auipc	ra,0x5
     588:	63a080e7          	jalr	1594(ra) # 5bbe <printf>
      exit(1);
     58c:	4505                	li	a0,1
     58e:	00005097          	auipc	ra,0x5
     592:	2b6080e7          	jalr	694(ra) # 5844 <exit>
      printf("read(fd, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     596:	862a                	mv	a2,a0
     598:	85ce                	mv	a1,s3
     59a:	00006517          	auipc	a0,0x6
     59e:	9c650513          	addi	a0,a0,-1594 # 5f60 <malloc+0x2ea>
     5a2:	00005097          	auipc	ra,0x5
     5a6:	61c080e7          	jalr	1564(ra) # 5bbe <printf>
      exit(1);
     5aa:	4505                	li	a0,1
     5ac:	00005097          	auipc	ra,0x5
     5b0:	298080e7          	jalr	664(ra) # 5844 <exit>
      printf("pipe() failed\n");
     5b4:	00006517          	auipc	a0,0x6
     5b8:	94c50513          	addi	a0,a0,-1716 # 5f00 <malloc+0x28a>
     5bc:	00005097          	auipc	ra,0x5
     5c0:	602080e7          	jalr	1538(ra) # 5bbe <printf>
      exit(1);
     5c4:	4505                	li	a0,1
     5c6:	00005097          	auipc	ra,0x5
     5ca:	27e080e7          	jalr	638(ra) # 5844 <exit>
      printf("pipe write failed\n");
     5ce:	00006517          	auipc	a0,0x6
     5d2:	9c250513          	addi	a0,a0,-1598 # 5f90 <malloc+0x31a>
     5d6:	00005097          	auipc	ra,0x5
     5da:	5e8080e7          	jalr	1512(ra) # 5bbe <printf>
      exit(1);
     5de:	4505                	li	a0,1
     5e0:	00005097          	auipc	ra,0x5
     5e4:	264080e7          	jalr	612(ra) # 5844 <exit>
      printf("read(pipe, %p, 8192) returned %d, not -1 or 0\n", addr, n);
     5e8:	862a                	mv	a2,a0
     5ea:	85ce                	mv	a1,s3
     5ec:	00006517          	auipc	a0,0x6
     5f0:	9bc50513          	addi	a0,a0,-1604 # 5fa8 <malloc+0x332>
     5f4:	00005097          	auipc	ra,0x5
     5f8:	5ca080e7          	jalr	1482(ra) # 5bbe <printf>
      exit(1);
     5fc:	4505                	li	a0,1
     5fe:	00005097          	auipc	ra,0x5
     602:	246080e7          	jalr	582(ra) # 5844 <exit>

0000000000000606 <truncate1>:
{
     606:	711d                	addi	sp,sp,-96
     608:	ec86                	sd	ra,88(sp)
     60a:	e8a2                	sd	s0,80(sp)
     60c:	e4a6                	sd	s1,72(sp)
     60e:	e0ca                	sd	s2,64(sp)
     610:	fc4e                	sd	s3,56(sp)
     612:	f852                	sd	s4,48(sp)
     614:	f456                	sd	s5,40(sp)
     616:	1080                	addi	s0,sp,96
     618:	8aaa                	mv	s5,a0
  unlink("truncfile");
     61a:	00005517          	auipc	a0,0x5
     61e:	7d650513          	addi	a0,a0,2006 # 5df0 <malloc+0x17a>
     622:	00005097          	auipc	ra,0x5
     626:	272080e7          	jalr	626(ra) # 5894 <unlink>
  int fd1 = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
     62a:	60100593          	li	a1,1537
     62e:	00005517          	auipc	a0,0x5
     632:	7c250513          	addi	a0,a0,1986 # 5df0 <malloc+0x17a>
     636:	00005097          	auipc	ra,0x5
     63a:	24e080e7          	jalr	590(ra) # 5884 <open>
     63e:	84aa                	mv	s1,a0
  write(fd1, "abcd", 4);
     640:	4611                	li	a2,4
     642:	00005597          	auipc	a1,0x5
     646:	7be58593          	addi	a1,a1,1982 # 5e00 <malloc+0x18a>
     64a:	00005097          	auipc	ra,0x5
     64e:	21a080e7          	jalr	538(ra) # 5864 <write>
  close(fd1);
     652:	8526                	mv	a0,s1
     654:	00005097          	auipc	ra,0x5
     658:	218080e7          	jalr	536(ra) # 586c <close>
  int fd2 = open("truncfile", O_RDONLY);
     65c:	4581                	li	a1,0
     65e:	00005517          	auipc	a0,0x5
     662:	79250513          	addi	a0,a0,1938 # 5df0 <malloc+0x17a>
     666:	00005097          	auipc	ra,0x5
     66a:	21e080e7          	jalr	542(ra) # 5884 <open>
     66e:	84aa                	mv	s1,a0
  int n = read(fd2, buf, sizeof(buf));
     670:	02000613          	li	a2,32
     674:	fa040593          	addi	a1,s0,-96
     678:	00005097          	auipc	ra,0x5
     67c:	1e4080e7          	jalr	484(ra) # 585c <read>
  if(n != 4){
     680:	4791                	li	a5,4
     682:	0cf51e63          	bne	a0,a5,75e <truncate1+0x158>
  fd1 = open("truncfile", O_WRONLY|O_TRUNC);
     686:	40100593          	li	a1,1025
     68a:	00005517          	auipc	a0,0x5
     68e:	76650513          	addi	a0,a0,1894 # 5df0 <malloc+0x17a>
     692:	00005097          	auipc	ra,0x5
     696:	1f2080e7          	jalr	498(ra) # 5884 <open>
     69a:	89aa                	mv	s3,a0
  int fd3 = open("truncfile", O_RDONLY);
     69c:	4581                	li	a1,0
     69e:	00005517          	auipc	a0,0x5
     6a2:	75250513          	addi	a0,a0,1874 # 5df0 <malloc+0x17a>
     6a6:	00005097          	auipc	ra,0x5
     6aa:	1de080e7          	jalr	478(ra) # 5884 <open>
     6ae:	892a                	mv	s2,a0
  n = read(fd3, buf, sizeof(buf));
     6b0:	02000613          	li	a2,32
     6b4:	fa040593          	addi	a1,s0,-96
     6b8:	00005097          	auipc	ra,0x5
     6bc:	1a4080e7          	jalr	420(ra) # 585c <read>
     6c0:	8a2a                	mv	s4,a0
  if(n != 0){
     6c2:	ed4d                	bnez	a0,77c <truncate1+0x176>
  n = read(fd2, buf, sizeof(buf));
     6c4:	02000613          	li	a2,32
     6c8:	fa040593          	addi	a1,s0,-96
     6cc:	8526                	mv	a0,s1
     6ce:	00005097          	auipc	ra,0x5
     6d2:	18e080e7          	jalr	398(ra) # 585c <read>
     6d6:	8a2a                	mv	s4,a0
  if(n != 0){
     6d8:	e971                	bnez	a0,7ac <truncate1+0x1a6>
  write(fd1, "abcdef", 6);
     6da:	4619                	li	a2,6
     6dc:	00006597          	auipc	a1,0x6
     6e0:	95c58593          	addi	a1,a1,-1700 # 6038 <malloc+0x3c2>
     6e4:	854e                	mv	a0,s3
     6e6:	00005097          	auipc	ra,0x5
     6ea:	17e080e7          	jalr	382(ra) # 5864 <write>
  n = read(fd3, buf, sizeof(buf));
     6ee:	02000613          	li	a2,32
     6f2:	fa040593          	addi	a1,s0,-96
     6f6:	854a                	mv	a0,s2
     6f8:	00005097          	auipc	ra,0x5
     6fc:	164080e7          	jalr	356(ra) # 585c <read>
  if(n != 6){
     700:	4799                	li	a5,6
     702:	0cf51d63          	bne	a0,a5,7dc <truncate1+0x1d6>
  n = read(fd2, buf, sizeof(buf));
     706:	02000613          	li	a2,32
     70a:	fa040593          	addi	a1,s0,-96
     70e:	8526                	mv	a0,s1
     710:	00005097          	auipc	ra,0x5
     714:	14c080e7          	jalr	332(ra) # 585c <read>
  if(n != 2){
     718:	4789                	li	a5,2
     71a:	0ef51063          	bne	a0,a5,7fa <truncate1+0x1f4>
  unlink("truncfile");
     71e:	00005517          	auipc	a0,0x5
     722:	6d250513          	addi	a0,a0,1746 # 5df0 <malloc+0x17a>
     726:	00005097          	auipc	ra,0x5
     72a:	16e080e7          	jalr	366(ra) # 5894 <unlink>
  close(fd1);
     72e:	854e                	mv	a0,s3
     730:	00005097          	auipc	ra,0x5
     734:	13c080e7          	jalr	316(ra) # 586c <close>
  close(fd2);
     738:	8526                	mv	a0,s1
     73a:	00005097          	auipc	ra,0x5
     73e:	132080e7          	jalr	306(ra) # 586c <close>
  close(fd3);
     742:	854a                	mv	a0,s2
     744:	00005097          	auipc	ra,0x5
     748:	128080e7          	jalr	296(ra) # 586c <close>
}
     74c:	60e6                	ld	ra,88(sp)
     74e:	6446                	ld	s0,80(sp)
     750:	64a6                	ld	s1,72(sp)
     752:	6906                	ld	s2,64(sp)
     754:	79e2                	ld	s3,56(sp)
     756:	7a42                	ld	s4,48(sp)
     758:	7aa2                	ld	s5,40(sp)
     75a:	6125                	addi	sp,sp,96
     75c:	8082                	ret
    printf("%s: read %d bytes, wanted 4\n", s, n);
     75e:	862a                	mv	a2,a0
     760:	85d6                	mv	a1,s5
     762:	00006517          	auipc	a0,0x6
     766:	87650513          	addi	a0,a0,-1930 # 5fd8 <malloc+0x362>
     76a:	00005097          	auipc	ra,0x5
     76e:	454080e7          	jalr	1108(ra) # 5bbe <printf>
    exit(1);
     772:	4505                	li	a0,1
     774:	00005097          	auipc	ra,0x5
     778:	0d0080e7          	jalr	208(ra) # 5844 <exit>
    printf("aaa fd3=%d\n", fd3);
     77c:	85ca                	mv	a1,s2
     77e:	00006517          	auipc	a0,0x6
     782:	87a50513          	addi	a0,a0,-1926 # 5ff8 <malloc+0x382>
     786:	00005097          	auipc	ra,0x5
     78a:	438080e7          	jalr	1080(ra) # 5bbe <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     78e:	8652                	mv	a2,s4
     790:	85d6                	mv	a1,s5
     792:	00006517          	auipc	a0,0x6
     796:	87650513          	addi	a0,a0,-1930 # 6008 <malloc+0x392>
     79a:	00005097          	auipc	ra,0x5
     79e:	424080e7          	jalr	1060(ra) # 5bbe <printf>
    exit(1);
     7a2:	4505                	li	a0,1
     7a4:	00005097          	auipc	ra,0x5
     7a8:	0a0080e7          	jalr	160(ra) # 5844 <exit>
    printf("bbb fd2=%d\n", fd2);
     7ac:	85a6                	mv	a1,s1
     7ae:	00006517          	auipc	a0,0x6
     7b2:	87a50513          	addi	a0,a0,-1926 # 6028 <malloc+0x3b2>
     7b6:	00005097          	auipc	ra,0x5
     7ba:	408080e7          	jalr	1032(ra) # 5bbe <printf>
    printf("%s: read %d bytes, wanted 0\n", s, n);
     7be:	8652                	mv	a2,s4
     7c0:	85d6                	mv	a1,s5
     7c2:	00006517          	auipc	a0,0x6
     7c6:	84650513          	addi	a0,a0,-1978 # 6008 <malloc+0x392>
     7ca:	00005097          	auipc	ra,0x5
     7ce:	3f4080e7          	jalr	1012(ra) # 5bbe <printf>
    exit(1);
     7d2:	4505                	li	a0,1
     7d4:	00005097          	auipc	ra,0x5
     7d8:	070080e7          	jalr	112(ra) # 5844 <exit>
    printf("%s: read %d bytes, wanted 6\n", s, n);
     7dc:	862a                	mv	a2,a0
     7de:	85d6                	mv	a1,s5
     7e0:	00006517          	auipc	a0,0x6
     7e4:	86050513          	addi	a0,a0,-1952 # 6040 <malloc+0x3ca>
     7e8:	00005097          	auipc	ra,0x5
     7ec:	3d6080e7          	jalr	982(ra) # 5bbe <printf>
    exit(1);
     7f0:	4505                	li	a0,1
     7f2:	00005097          	auipc	ra,0x5
     7f6:	052080e7          	jalr	82(ra) # 5844 <exit>
    printf("%s: read %d bytes, wanted 2\n", s, n);
     7fa:	862a                	mv	a2,a0
     7fc:	85d6                	mv	a1,s5
     7fe:	00006517          	auipc	a0,0x6
     802:	86250513          	addi	a0,a0,-1950 # 6060 <malloc+0x3ea>
     806:	00005097          	auipc	ra,0x5
     80a:	3b8080e7          	jalr	952(ra) # 5bbe <printf>
    exit(1);
     80e:	4505                	li	a0,1
     810:	00005097          	auipc	ra,0x5
     814:	034080e7          	jalr	52(ra) # 5844 <exit>

0000000000000818 <writetest>:
{
     818:	7139                	addi	sp,sp,-64
     81a:	fc06                	sd	ra,56(sp)
     81c:	f822                	sd	s0,48(sp)
     81e:	f426                	sd	s1,40(sp)
     820:	f04a                	sd	s2,32(sp)
     822:	ec4e                	sd	s3,24(sp)
     824:	e852                	sd	s4,16(sp)
     826:	e456                	sd	s5,8(sp)
     828:	e05a                	sd	s6,0(sp)
     82a:	0080                	addi	s0,sp,64
     82c:	8b2a                	mv	s6,a0
  fd = open("small", O_CREATE|O_RDWR);
     82e:	20200593          	li	a1,514
     832:	00006517          	auipc	a0,0x6
     836:	84e50513          	addi	a0,a0,-1970 # 6080 <malloc+0x40a>
     83a:	00005097          	auipc	ra,0x5
     83e:	04a080e7          	jalr	74(ra) # 5884 <open>
  if(fd < 0){
     842:	0a054d63          	bltz	a0,8fc <writetest+0xe4>
     846:	892a                	mv	s2,a0
     848:	4481                	li	s1,0
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     84a:	00006997          	auipc	s3,0x6
     84e:	85e98993          	addi	s3,s3,-1954 # 60a8 <malloc+0x432>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     852:	00006a97          	auipc	s5,0x6
     856:	88ea8a93          	addi	s5,s5,-1906 # 60e0 <malloc+0x46a>
  for(i = 0; i < N; i++){
     85a:	06400a13          	li	s4,100
    if(write(fd, "aaaaaaaaaa", SZ) != SZ){
     85e:	4629                	li	a2,10
     860:	85ce                	mv	a1,s3
     862:	854a                	mv	a0,s2
     864:	00005097          	auipc	ra,0x5
     868:	000080e7          	jalr	ra # 5864 <write>
     86c:	47a9                	li	a5,10
     86e:	0af51563          	bne	a0,a5,918 <writetest+0x100>
    if(write(fd, "bbbbbbbbbb", SZ) != SZ){
     872:	4629                	li	a2,10
     874:	85d6                	mv	a1,s5
     876:	854a                	mv	a0,s2
     878:	00005097          	auipc	ra,0x5
     87c:	fec080e7          	jalr	-20(ra) # 5864 <write>
     880:	47a9                	li	a5,10
     882:	0af51a63          	bne	a0,a5,936 <writetest+0x11e>
  for(i = 0; i < N; i++){
     886:	2485                	addiw	s1,s1,1
     888:	fd449be3          	bne	s1,s4,85e <writetest+0x46>
  close(fd);
     88c:	854a                	mv	a0,s2
     88e:	00005097          	auipc	ra,0x5
     892:	fde080e7          	jalr	-34(ra) # 586c <close>
  fd = open("small", O_RDONLY);
     896:	4581                	li	a1,0
     898:	00005517          	auipc	a0,0x5
     89c:	7e850513          	addi	a0,a0,2024 # 6080 <malloc+0x40a>
     8a0:	00005097          	auipc	ra,0x5
     8a4:	fe4080e7          	jalr	-28(ra) # 5884 <open>
     8a8:	84aa                	mv	s1,a0
  if(fd < 0){
     8aa:	0a054563          	bltz	a0,954 <writetest+0x13c>
  i = read(fd, buf, N*SZ*2);
     8ae:	7d000613          	li	a2,2000
     8b2:	0000b597          	auipc	a1,0xb
     8b6:	52658593          	addi	a1,a1,1318 # bdd8 <buf>
     8ba:	00005097          	auipc	ra,0x5
     8be:	fa2080e7          	jalr	-94(ra) # 585c <read>
  if(i != N*SZ*2){
     8c2:	7d000793          	li	a5,2000
     8c6:	0af51563          	bne	a0,a5,970 <writetest+0x158>
  close(fd);
     8ca:	8526                	mv	a0,s1
     8cc:	00005097          	auipc	ra,0x5
     8d0:	fa0080e7          	jalr	-96(ra) # 586c <close>
  if(unlink("small") < 0){
     8d4:	00005517          	auipc	a0,0x5
     8d8:	7ac50513          	addi	a0,a0,1964 # 6080 <malloc+0x40a>
     8dc:	00005097          	auipc	ra,0x5
     8e0:	fb8080e7          	jalr	-72(ra) # 5894 <unlink>
     8e4:	0a054463          	bltz	a0,98c <writetest+0x174>
}
     8e8:	70e2                	ld	ra,56(sp)
     8ea:	7442                	ld	s0,48(sp)
     8ec:	74a2                	ld	s1,40(sp)
     8ee:	7902                	ld	s2,32(sp)
     8f0:	69e2                	ld	s3,24(sp)
     8f2:	6a42                	ld	s4,16(sp)
     8f4:	6aa2                	ld	s5,8(sp)
     8f6:	6b02                	ld	s6,0(sp)
     8f8:	6121                	addi	sp,sp,64
     8fa:	8082                	ret
    printf("%s: error: creat small failed!\n", s);
     8fc:	85da                	mv	a1,s6
     8fe:	00005517          	auipc	a0,0x5
     902:	78a50513          	addi	a0,a0,1930 # 6088 <malloc+0x412>
     906:	00005097          	auipc	ra,0x5
     90a:	2b8080e7          	jalr	696(ra) # 5bbe <printf>
    exit(1);
     90e:	4505                	li	a0,1
     910:	00005097          	auipc	ra,0x5
     914:	f34080e7          	jalr	-204(ra) # 5844 <exit>
      printf("%s: error: write aa %d new file failed\n", s, i);
     918:	8626                	mv	a2,s1
     91a:	85da                	mv	a1,s6
     91c:	00005517          	auipc	a0,0x5
     920:	79c50513          	addi	a0,a0,1948 # 60b8 <malloc+0x442>
     924:	00005097          	auipc	ra,0x5
     928:	29a080e7          	jalr	666(ra) # 5bbe <printf>
      exit(1);
     92c:	4505                	li	a0,1
     92e:	00005097          	auipc	ra,0x5
     932:	f16080e7          	jalr	-234(ra) # 5844 <exit>
      printf("%s: error: write bb %d new file failed\n", s, i);
     936:	8626                	mv	a2,s1
     938:	85da                	mv	a1,s6
     93a:	00005517          	auipc	a0,0x5
     93e:	7b650513          	addi	a0,a0,1974 # 60f0 <malloc+0x47a>
     942:	00005097          	auipc	ra,0x5
     946:	27c080e7          	jalr	636(ra) # 5bbe <printf>
      exit(1);
     94a:	4505                	li	a0,1
     94c:	00005097          	auipc	ra,0x5
     950:	ef8080e7          	jalr	-264(ra) # 5844 <exit>
    printf("%s: error: open small failed!\n", s);
     954:	85da                	mv	a1,s6
     956:	00005517          	auipc	a0,0x5
     95a:	7c250513          	addi	a0,a0,1986 # 6118 <malloc+0x4a2>
     95e:	00005097          	auipc	ra,0x5
     962:	260080e7          	jalr	608(ra) # 5bbe <printf>
    exit(1);
     966:	4505                	li	a0,1
     968:	00005097          	auipc	ra,0x5
     96c:	edc080e7          	jalr	-292(ra) # 5844 <exit>
    printf("%s: read failed\n", s);
     970:	85da                	mv	a1,s6
     972:	00005517          	auipc	a0,0x5
     976:	7c650513          	addi	a0,a0,1990 # 6138 <malloc+0x4c2>
     97a:	00005097          	auipc	ra,0x5
     97e:	244080e7          	jalr	580(ra) # 5bbe <printf>
    exit(1);
     982:	4505                	li	a0,1
     984:	00005097          	auipc	ra,0x5
     988:	ec0080e7          	jalr	-320(ra) # 5844 <exit>
    printf("%s: unlink small failed\n", s);
     98c:	85da                	mv	a1,s6
     98e:	00005517          	auipc	a0,0x5
     992:	7c250513          	addi	a0,a0,1986 # 6150 <malloc+0x4da>
     996:	00005097          	auipc	ra,0x5
     99a:	228080e7          	jalr	552(ra) # 5bbe <printf>
    exit(1);
     99e:	4505                	li	a0,1
     9a0:	00005097          	auipc	ra,0x5
     9a4:	ea4080e7          	jalr	-348(ra) # 5844 <exit>

00000000000009a8 <writebig>:
{
     9a8:	7139                	addi	sp,sp,-64
     9aa:	fc06                	sd	ra,56(sp)
     9ac:	f822                	sd	s0,48(sp)
     9ae:	f426                	sd	s1,40(sp)
     9b0:	f04a                	sd	s2,32(sp)
     9b2:	ec4e                	sd	s3,24(sp)
     9b4:	e852                	sd	s4,16(sp)
     9b6:	e456                	sd	s5,8(sp)
     9b8:	0080                	addi	s0,sp,64
     9ba:	8aaa                	mv	s5,a0
  fd = open("big", O_CREATE|O_RDWR);
     9bc:	20200593          	li	a1,514
     9c0:	00005517          	auipc	a0,0x5
     9c4:	7b050513          	addi	a0,a0,1968 # 6170 <malloc+0x4fa>
     9c8:	00005097          	auipc	ra,0x5
     9cc:	ebc080e7          	jalr	-324(ra) # 5884 <open>
  if(fd < 0){
     9d0:	08054563          	bltz	a0,a5a <writebig+0xb2>
     9d4:	89aa                	mv	s3,a0
     9d6:	4481                	li	s1,0
    ((int*)buf)[0] = i;
     9d8:	0000b917          	auipc	s2,0xb
     9dc:	40090913          	addi	s2,s2,1024 # bdd8 <buf>
  for(i = 0; i < MAXFILE; i++){
     9e0:	6a41                	lui	s4,0x10
     9e2:	10ba0a13          	addi	s4,s4,267 # 1010b <__BSS_END__+0x1323>
    ((int*)buf)[0] = i;
     9e6:	00992023          	sw	s1,0(s2)
    if(write(fd, buf, BSIZE) != BSIZE){
     9ea:	40000613          	li	a2,1024
     9ee:	85ca                	mv	a1,s2
     9f0:	854e                	mv	a0,s3
     9f2:	00005097          	auipc	ra,0x5
     9f6:	e72080e7          	jalr	-398(ra) # 5864 <write>
     9fa:	40000793          	li	a5,1024
     9fe:	06f51c63          	bne	a0,a5,a76 <writebig+0xce>
  for(i = 0; i < MAXFILE; i++){
     a02:	2485                	addiw	s1,s1,1
     a04:	ff4491e3          	bne	s1,s4,9e6 <writebig+0x3e>
  close(fd);
     a08:	854e                	mv	a0,s3
     a0a:	00005097          	auipc	ra,0x5
     a0e:	e62080e7          	jalr	-414(ra) # 586c <close>
  fd = open("big", O_RDONLY);
     a12:	4581                	li	a1,0
     a14:	00005517          	auipc	a0,0x5
     a18:	75c50513          	addi	a0,a0,1884 # 6170 <malloc+0x4fa>
     a1c:	00005097          	auipc	ra,0x5
     a20:	e68080e7          	jalr	-408(ra) # 5884 <open>
     a24:	89aa                	mv	s3,a0
  n = 0;
     a26:	4481                	li	s1,0
    i = read(fd, buf, BSIZE);
     a28:	0000b917          	auipc	s2,0xb
     a2c:	3b090913          	addi	s2,s2,944 # bdd8 <buf>
  if(fd < 0){
     a30:	06054263          	bltz	a0,a94 <writebig+0xec>
    i = read(fd, buf, BSIZE);
     a34:	40000613          	li	a2,1024
     a38:	85ca                	mv	a1,s2
     a3a:	854e                	mv	a0,s3
     a3c:	00005097          	auipc	ra,0x5
     a40:	e20080e7          	jalr	-480(ra) # 585c <read>
    if(i == 0){
     a44:	c535                	beqz	a0,ab0 <writebig+0x108>
    } else if(i != BSIZE){
     a46:	40000793          	li	a5,1024
     a4a:	0af51f63          	bne	a0,a5,b08 <writebig+0x160>
    if(((int*)buf)[0] != n){
     a4e:	00092683          	lw	a3,0(s2)
     a52:	0c969a63          	bne	a3,s1,b26 <writebig+0x17e>
    n++;
     a56:	2485                	addiw	s1,s1,1
    i = read(fd, buf, BSIZE);
     a58:	bff1                	j	a34 <writebig+0x8c>
    printf("%s: error: creat big failed!\n", s);
     a5a:	85d6                	mv	a1,s5
     a5c:	00005517          	auipc	a0,0x5
     a60:	71c50513          	addi	a0,a0,1820 # 6178 <malloc+0x502>
     a64:	00005097          	auipc	ra,0x5
     a68:	15a080e7          	jalr	346(ra) # 5bbe <printf>
    exit(1);
     a6c:	4505                	li	a0,1
     a6e:	00005097          	auipc	ra,0x5
     a72:	dd6080e7          	jalr	-554(ra) # 5844 <exit>
      printf("%s: error: write big file failed\n", s, i);
     a76:	8626                	mv	a2,s1
     a78:	85d6                	mv	a1,s5
     a7a:	00005517          	auipc	a0,0x5
     a7e:	71e50513          	addi	a0,a0,1822 # 6198 <malloc+0x522>
     a82:	00005097          	auipc	ra,0x5
     a86:	13c080e7          	jalr	316(ra) # 5bbe <printf>
      exit(1);
     a8a:	4505                	li	a0,1
     a8c:	00005097          	auipc	ra,0x5
     a90:	db8080e7          	jalr	-584(ra) # 5844 <exit>
    printf("%s: error: open big failed!\n", s);
     a94:	85d6                	mv	a1,s5
     a96:	00005517          	auipc	a0,0x5
     a9a:	72a50513          	addi	a0,a0,1834 # 61c0 <malloc+0x54a>
     a9e:	00005097          	auipc	ra,0x5
     aa2:	120080e7          	jalr	288(ra) # 5bbe <printf>
    exit(1);
     aa6:	4505                	li	a0,1
     aa8:	00005097          	auipc	ra,0x5
     aac:	d9c080e7          	jalr	-612(ra) # 5844 <exit>
      if(n == MAXFILE - 1){
     ab0:	67c1                	lui	a5,0x10
     ab2:	10a78793          	addi	a5,a5,266 # 1010a <__BSS_END__+0x1322>
     ab6:	02f48a63          	beq	s1,a5,aea <writebig+0x142>
  close(fd);
     aba:	854e                	mv	a0,s3
     abc:	00005097          	auipc	ra,0x5
     ac0:	db0080e7          	jalr	-592(ra) # 586c <close>
  if(unlink("big") < 0){
     ac4:	00005517          	auipc	a0,0x5
     ac8:	6ac50513          	addi	a0,a0,1708 # 6170 <malloc+0x4fa>
     acc:	00005097          	auipc	ra,0x5
     ad0:	dc8080e7          	jalr	-568(ra) # 5894 <unlink>
     ad4:	06054863          	bltz	a0,b44 <writebig+0x19c>
}
     ad8:	70e2                	ld	ra,56(sp)
     ada:	7442                	ld	s0,48(sp)
     adc:	74a2                	ld	s1,40(sp)
     ade:	7902                	ld	s2,32(sp)
     ae0:	69e2                	ld	s3,24(sp)
     ae2:	6a42                	ld	s4,16(sp)
     ae4:	6aa2                	ld	s5,8(sp)
     ae6:	6121                	addi	sp,sp,64
     ae8:	8082                	ret
        printf("%s: read only %d blocks from big", s, n);
     aea:	863e                	mv	a2,a5
     aec:	85d6                	mv	a1,s5
     aee:	00005517          	auipc	a0,0x5
     af2:	6f250513          	addi	a0,a0,1778 # 61e0 <malloc+0x56a>
     af6:	00005097          	auipc	ra,0x5
     afa:	0c8080e7          	jalr	200(ra) # 5bbe <printf>
        exit(1);
     afe:	4505                	li	a0,1
     b00:	00005097          	auipc	ra,0x5
     b04:	d44080e7          	jalr	-700(ra) # 5844 <exit>
      printf("%s: read failed %d\n", s, i);
     b08:	862a                	mv	a2,a0
     b0a:	85d6                	mv	a1,s5
     b0c:	00005517          	auipc	a0,0x5
     b10:	6fc50513          	addi	a0,a0,1788 # 6208 <malloc+0x592>
     b14:	00005097          	auipc	ra,0x5
     b18:	0aa080e7          	jalr	170(ra) # 5bbe <printf>
      exit(1);
     b1c:	4505                	li	a0,1
     b1e:	00005097          	auipc	ra,0x5
     b22:	d26080e7          	jalr	-730(ra) # 5844 <exit>
      printf("%s: read content of block %d is %d\n", s,
     b26:	8626                	mv	a2,s1
     b28:	85d6                	mv	a1,s5
     b2a:	00005517          	auipc	a0,0x5
     b2e:	6f650513          	addi	a0,a0,1782 # 6220 <malloc+0x5aa>
     b32:	00005097          	auipc	ra,0x5
     b36:	08c080e7          	jalr	140(ra) # 5bbe <printf>
      exit(1);
     b3a:	4505                	li	a0,1
     b3c:	00005097          	auipc	ra,0x5
     b40:	d08080e7          	jalr	-760(ra) # 5844 <exit>
    printf("%s: unlink big failed\n", s);
     b44:	85d6                	mv	a1,s5
     b46:	00005517          	auipc	a0,0x5
     b4a:	70250513          	addi	a0,a0,1794 # 6248 <malloc+0x5d2>
     b4e:	00005097          	auipc	ra,0x5
     b52:	070080e7          	jalr	112(ra) # 5bbe <printf>
    exit(1);
     b56:	4505                	li	a0,1
     b58:	00005097          	auipc	ra,0x5
     b5c:	cec080e7          	jalr	-788(ra) # 5844 <exit>

0000000000000b60 <unlinkread>:
{
     b60:	7179                	addi	sp,sp,-48
     b62:	f406                	sd	ra,40(sp)
     b64:	f022                	sd	s0,32(sp)
     b66:	ec26                	sd	s1,24(sp)
     b68:	e84a                	sd	s2,16(sp)
     b6a:	e44e                	sd	s3,8(sp)
     b6c:	1800                	addi	s0,sp,48
     b6e:	89aa                	mv	s3,a0
  fd = open("unlinkread", O_CREATE | O_RDWR);
     b70:	20200593          	li	a1,514
     b74:	00005517          	auipc	a0,0x5
     b78:	6ec50513          	addi	a0,a0,1772 # 6260 <malloc+0x5ea>
     b7c:	00005097          	auipc	ra,0x5
     b80:	d08080e7          	jalr	-760(ra) # 5884 <open>
  if(fd < 0){
     b84:	0e054563          	bltz	a0,c6e <unlinkread+0x10e>
     b88:	84aa                	mv	s1,a0
  write(fd, "hello", SZ);
     b8a:	4615                	li	a2,5
     b8c:	00005597          	auipc	a1,0x5
     b90:	70458593          	addi	a1,a1,1796 # 6290 <malloc+0x61a>
     b94:	00005097          	auipc	ra,0x5
     b98:	cd0080e7          	jalr	-816(ra) # 5864 <write>
  close(fd);
     b9c:	8526                	mv	a0,s1
     b9e:	00005097          	auipc	ra,0x5
     ba2:	cce080e7          	jalr	-818(ra) # 586c <close>
  fd = open("unlinkread", O_RDWR);
     ba6:	4589                	li	a1,2
     ba8:	00005517          	auipc	a0,0x5
     bac:	6b850513          	addi	a0,a0,1720 # 6260 <malloc+0x5ea>
     bb0:	00005097          	auipc	ra,0x5
     bb4:	cd4080e7          	jalr	-812(ra) # 5884 <open>
     bb8:	84aa                	mv	s1,a0
  if(fd < 0){
     bba:	0c054863          	bltz	a0,c8a <unlinkread+0x12a>
  if(unlink("unlinkread") != 0){
     bbe:	00005517          	auipc	a0,0x5
     bc2:	6a250513          	addi	a0,a0,1698 # 6260 <malloc+0x5ea>
     bc6:	00005097          	auipc	ra,0x5
     bca:	cce080e7          	jalr	-818(ra) # 5894 <unlink>
     bce:	ed61                	bnez	a0,ca6 <unlinkread+0x146>
  fd1 = open("unlinkread", O_CREATE | O_RDWR);
     bd0:	20200593          	li	a1,514
     bd4:	00005517          	auipc	a0,0x5
     bd8:	68c50513          	addi	a0,a0,1676 # 6260 <malloc+0x5ea>
     bdc:	00005097          	auipc	ra,0x5
     be0:	ca8080e7          	jalr	-856(ra) # 5884 <open>
     be4:	892a                	mv	s2,a0
  write(fd1, "yyy", 3);
     be6:	460d                	li	a2,3
     be8:	00005597          	auipc	a1,0x5
     bec:	6f058593          	addi	a1,a1,1776 # 62d8 <malloc+0x662>
     bf0:	00005097          	auipc	ra,0x5
     bf4:	c74080e7          	jalr	-908(ra) # 5864 <write>
  close(fd1);
     bf8:	854a                	mv	a0,s2
     bfa:	00005097          	auipc	ra,0x5
     bfe:	c72080e7          	jalr	-910(ra) # 586c <close>
  if(read(fd, buf, sizeof(buf)) != SZ){
     c02:	660d                	lui	a2,0x3
     c04:	0000b597          	auipc	a1,0xb
     c08:	1d458593          	addi	a1,a1,468 # bdd8 <buf>
     c0c:	8526                	mv	a0,s1
     c0e:	00005097          	auipc	ra,0x5
     c12:	c4e080e7          	jalr	-946(ra) # 585c <read>
     c16:	4795                	li	a5,5
     c18:	0af51563          	bne	a0,a5,cc2 <unlinkread+0x162>
  if(buf[0] != 'h'){
     c1c:	0000b717          	auipc	a4,0xb
     c20:	1bc74703          	lbu	a4,444(a4) # bdd8 <buf>
     c24:	06800793          	li	a5,104
     c28:	0af71b63          	bne	a4,a5,cde <unlinkread+0x17e>
  if(write(fd, buf, 10) != 10){
     c2c:	4629                	li	a2,10
     c2e:	0000b597          	auipc	a1,0xb
     c32:	1aa58593          	addi	a1,a1,426 # bdd8 <buf>
     c36:	8526                	mv	a0,s1
     c38:	00005097          	auipc	ra,0x5
     c3c:	c2c080e7          	jalr	-980(ra) # 5864 <write>
     c40:	47a9                	li	a5,10
     c42:	0af51c63          	bne	a0,a5,cfa <unlinkread+0x19a>
  close(fd);
     c46:	8526                	mv	a0,s1
     c48:	00005097          	auipc	ra,0x5
     c4c:	c24080e7          	jalr	-988(ra) # 586c <close>
  unlink("unlinkread");
     c50:	00005517          	auipc	a0,0x5
     c54:	61050513          	addi	a0,a0,1552 # 6260 <malloc+0x5ea>
     c58:	00005097          	auipc	ra,0x5
     c5c:	c3c080e7          	jalr	-964(ra) # 5894 <unlink>
}
     c60:	70a2                	ld	ra,40(sp)
     c62:	7402                	ld	s0,32(sp)
     c64:	64e2                	ld	s1,24(sp)
     c66:	6942                	ld	s2,16(sp)
     c68:	69a2                	ld	s3,8(sp)
     c6a:	6145                	addi	sp,sp,48
     c6c:	8082                	ret
    printf("%s: create unlinkread failed\n", s);
     c6e:	85ce                	mv	a1,s3
     c70:	00005517          	auipc	a0,0x5
     c74:	60050513          	addi	a0,a0,1536 # 6270 <malloc+0x5fa>
     c78:	00005097          	auipc	ra,0x5
     c7c:	f46080e7          	jalr	-186(ra) # 5bbe <printf>
    exit(1);
     c80:	4505                	li	a0,1
     c82:	00005097          	auipc	ra,0x5
     c86:	bc2080e7          	jalr	-1086(ra) # 5844 <exit>
    printf("%s: open unlinkread failed\n", s);
     c8a:	85ce                	mv	a1,s3
     c8c:	00005517          	auipc	a0,0x5
     c90:	60c50513          	addi	a0,a0,1548 # 6298 <malloc+0x622>
     c94:	00005097          	auipc	ra,0x5
     c98:	f2a080e7          	jalr	-214(ra) # 5bbe <printf>
    exit(1);
     c9c:	4505                	li	a0,1
     c9e:	00005097          	auipc	ra,0x5
     ca2:	ba6080e7          	jalr	-1114(ra) # 5844 <exit>
    printf("%s: unlink unlinkread failed\n", s);
     ca6:	85ce                	mv	a1,s3
     ca8:	00005517          	auipc	a0,0x5
     cac:	61050513          	addi	a0,a0,1552 # 62b8 <malloc+0x642>
     cb0:	00005097          	auipc	ra,0x5
     cb4:	f0e080e7          	jalr	-242(ra) # 5bbe <printf>
    exit(1);
     cb8:	4505                	li	a0,1
     cba:	00005097          	auipc	ra,0x5
     cbe:	b8a080e7          	jalr	-1142(ra) # 5844 <exit>
    printf("%s: unlinkread read failed", s);
     cc2:	85ce                	mv	a1,s3
     cc4:	00005517          	auipc	a0,0x5
     cc8:	61c50513          	addi	a0,a0,1564 # 62e0 <malloc+0x66a>
     ccc:	00005097          	auipc	ra,0x5
     cd0:	ef2080e7          	jalr	-270(ra) # 5bbe <printf>
    exit(1);
     cd4:	4505                	li	a0,1
     cd6:	00005097          	auipc	ra,0x5
     cda:	b6e080e7          	jalr	-1170(ra) # 5844 <exit>
    printf("%s: unlinkread wrong data\n", s);
     cde:	85ce                	mv	a1,s3
     ce0:	00005517          	auipc	a0,0x5
     ce4:	62050513          	addi	a0,a0,1568 # 6300 <malloc+0x68a>
     ce8:	00005097          	auipc	ra,0x5
     cec:	ed6080e7          	jalr	-298(ra) # 5bbe <printf>
    exit(1);
     cf0:	4505                	li	a0,1
     cf2:	00005097          	auipc	ra,0x5
     cf6:	b52080e7          	jalr	-1198(ra) # 5844 <exit>
    printf("%s: unlinkread write failed\n", s);
     cfa:	85ce                	mv	a1,s3
     cfc:	00005517          	auipc	a0,0x5
     d00:	62450513          	addi	a0,a0,1572 # 6320 <malloc+0x6aa>
     d04:	00005097          	auipc	ra,0x5
     d08:	eba080e7          	jalr	-326(ra) # 5bbe <printf>
    exit(1);
     d0c:	4505                	li	a0,1
     d0e:	00005097          	auipc	ra,0x5
     d12:	b36080e7          	jalr	-1226(ra) # 5844 <exit>

0000000000000d16 <linktest>:
{
     d16:	1101                	addi	sp,sp,-32
     d18:	ec06                	sd	ra,24(sp)
     d1a:	e822                	sd	s0,16(sp)
     d1c:	e426                	sd	s1,8(sp)
     d1e:	e04a                	sd	s2,0(sp)
     d20:	1000                	addi	s0,sp,32
     d22:	892a                	mv	s2,a0
  unlink("lf1");
     d24:	00005517          	auipc	a0,0x5
     d28:	61c50513          	addi	a0,a0,1564 # 6340 <malloc+0x6ca>
     d2c:	00005097          	auipc	ra,0x5
     d30:	b68080e7          	jalr	-1176(ra) # 5894 <unlink>
  unlink("lf2");
     d34:	00005517          	auipc	a0,0x5
     d38:	61450513          	addi	a0,a0,1556 # 6348 <malloc+0x6d2>
     d3c:	00005097          	auipc	ra,0x5
     d40:	b58080e7          	jalr	-1192(ra) # 5894 <unlink>
  fd = open("lf1", O_CREATE|O_RDWR);
     d44:	20200593          	li	a1,514
     d48:	00005517          	auipc	a0,0x5
     d4c:	5f850513          	addi	a0,a0,1528 # 6340 <malloc+0x6ca>
     d50:	00005097          	auipc	ra,0x5
     d54:	b34080e7          	jalr	-1228(ra) # 5884 <open>
  if(fd < 0){
     d58:	10054763          	bltz	a0,e66 <linktest+0x150>
     d5c:	84aa                	mv	s1,a0
  if(write(fd, "hello", SZ) != SZ){
     d5e:	4615                	li	a2,5
     d60:	00005597          	auipc	a1,0x5
     d64:	53058593          	addi	a1,a1,1328 # 6290 <malloc+0x61a>
     d68:	00005097          	auipc	ra,0x5
     d6c:	afc080e7          	jalr	-1284(ra) # 5864 <write>
     d70:	4795                	li	a5,5
     d72:	10f51863          	bne	a0,a5,e82 <linktest+0x16c>
  close(fd);
     d76:	8526                	mv	a0,s1
     d78:	00005097          	auipc	ra,0x5
     d7c:	af4080e7          	jalr	-1292(ra) # 586c <close>
  if(link("lf1", "lf2") < 0){
     d80:	00005597          	auipc	a1,0x5
     d84:	5c858593          	addi	a1,a1,1480 # 6348 <malloc+0x6d2>
     d88:	00005517          	auipc	a0,0x5
     d8c:	5b850513          	addi	a0,a0,1464 # 6340 <malloc+0x6ca>
     d90:	00005097          	auipc	ra,0x5
     d94:	b14080e7          	jalr	-1260(ra) # 58a4 <link>
     d98:	10054363          	bltz	a0,e9e <linktest+0x188>
  unlink("lf1");
     d9c:	00005517          	auipc	a0,0x5
     da0:	5a450513          	addi	a0,a0,1444 # 6340 <malloc+0x6ca>
     da4:	00005097          	auipc	ra,0x5
     da8:	af0080e7          	jalr	-1296(ra) # 5894 <unlink>
  if(open("lf1", 0) >= 0){
     dac:	4581                	li	a1,0
     dae:	00005517          	auipc	a0,0x5
     db2:	59250513          	addi	a0,a0,1426 # 6340 <malloc+0x6ca>
     db6:	00005097          	auipc	ra,0x5
     dba:	ace080e7          	jalr	-1330(ra) # 5884 <open>
     dbe:	0e055e63          	bgez	a0,eba <linktest+0x1a4>
  fd = open("lf2", 0);
     dc2:	4581                	li	a1,0
     dc4:	00005517          	auipc	a0,0x5
     dc8:	58450513          	addi	a0,a0,1412 # 6348 <malloc+0x6d2>
     dcc:	00005097          	auipc	ra,0x5
     dd0:	ab8080e7          	jalr	-1352(ra) # 5884 <open>
     dd4:	84aa                	mv	s1,a0
  if(fd < 0){
     dd6:	10054063          	bltz	a0,ed6 <linktest+0x1c0>
  if(read(fd, buf, sizeof(buf)) != SZ){
     dda:	660d                	lui	a2,0x3
     ddc:	0000b597          	auipc	a1,0xb
     de0:	ffc58593          	addi	a1,a1,-4 # bdd8 <buf>
     de4:	00005097          	auipc	ra,0x5
     de8:	a78080e7          	jalr	-1416(ra) # 585c <read>
     dec:	4795                	li	a5,5
     dee:	10f51263          	bne	a0,a5,ef2 <linktest+0x1dc>
  close(fd);
     df2:	8526                	mv	a0,s1
     df4:	00005097          	auipc	ra,0x5
     df8:	a78080e7          	jalr	-1416(ra) # 586c <close>
  if(link("lf2", "lf2") >= 0){
     dfc:	00005597          	auipc	a1,0x5
     e00:	54c58593          	addi	a1,a1,1356 # 6348 <malloc+0x6d2>
     e04:	852e                	mv	a0,a1
     e06:	00005097          	auipc	ra,0x5
     e0a:	a9e080e7          	jalr	-1378(ra) # 58a4 <link>
     e0e:	10055063          	bgez	a0,f0e <linktest+0x1f8>
  unlink("lf2");
     e12:	00005517          	auipc	a0,0x5
     e16:	53650513          	addi	a0,a0,1334 # 6348 <malloc+0x6d2>
     e1a:	00005097          	auipc	ra,0x5
     e1e:	a7a080e7          	jalr	-1414(ra) # 5894 <unlink>
  if(link("lf2", "lf1") >= 0){
     e22:	00005597          	auipc	a1,0x5
     e26:	51e58593          	addi	a1,a1,1310 # 6340 <malloc+0x6ca>
     e2a:	00005517          	auipc	a0,0x5
     e2e:	51e50513          	addi	a0,a0,1310 # 6348 <malloc+0x6d2>
     e32:	00005097          	auipc	ra,0x5
     e36:	a72080e7          	jalr	-1422(ra) # 58a4 <link>
     e3a:	0e055863          	bgez	a0,f2a <linktest+0x214>
  if(link(".", "lf1") >= 0){
     e3e:	00005597          	auipc	a1,0x5
     e42:	50258593          	addi	a1,a1,1282 # 6340 <malloc+0x6ca>
     e46:	00005517          	auipc	a0,0x5
     e4a:	60a50513          	addi	a0,a0,1546 # 6450 <malloc+0x7da>
     e4e:	00005097          	auipc	ra,0x5
     e52:	a56080e7          	jalr	-1450(ra) # 58a4 <link>
     e56:	0e055863          	bgez	a0,f46 <linktest+0x230>
}
     e5a:	60e2                	ld	ra,24(sp)
     e5c:	6442                	ld	s0,16(sp)
     e5e:	64a2                	ld	s1,8(sp)
     e60:	6902                	ld	s2,0(sp)
     e62:	6105                	addi	sp,sp,32
     e64:	8082                	ret
    printf("%s: create lf1 failed\n", s);
     e66:	85ca                	mv	a1,s2
     e68:	00005517          	auipc	a0,0x5
     e6c:	4e850513          	addi	a0,a0,1256 # 6350 <malloc+0x6da>
     e70:	00005097          	auipc	ra,0x5
     e74:	d4e080e7          	jalr	-690(ra) # 5bbe <printf>
    exit(1);
     e78:	4505                	li	a0,1
     e7a:	00005097          	auipc	ra,0x5
     e7e:	9ca080e7          	jalr	-1590(ra) # 5844 <exit>
    printf("%s: write lf1 failed\n", s);
     e82:	85ca                	mv	a1,s2
     e84:	00005517          	auipc	a0,0x5
     e88:	4e450513          	addi	a0,a0,1252 # 6368 <malloc+0x6f2>
     e8c:	00005097          	auipc	ra,0x5
     e90:	d32080e7          	jalr	-718(ra) # 5bbe <printf>
    exit(1);
     e94:	4505                	li	a0,1
     e96:	00005097          	auipc	ra,0x5
     e9a:	9ae080e7          	jalr	-1618(ra) # 5844 <exit>
    printf("%s: link lf1 lf2 failed\n", s);
     e9e:	85ca                	mv	a1,s2
     ea0:	00005517          	auipc	a0,0x5
     ea4:	4e050513          	addi	a0,a0,1248 # 6380 <malloc+0x70a>
     ea8:	00005097          	auipc	ra,0x5
     eac:	d16080e7          	jalr	-746(ra) # 5bbe <printf>
    exit(1);
     eb0:	4505                	li	a0,1
     eb2:	00005097          	auipc	ra,0x5
     eb6:	992080e7          	jalr	-1646(ra) # 5844 <exit>
    printf("%s: unlinked lf1 but it is still there!\n", s);
     eba:	85ca                	mv	a1,s2
     ebc:	00005517          	auipc	a0,0x5
     ec0:	4e450513          	addi	a0,a0,1252 # 63a0 <malloc+0x72a>
     ec4:	00005097          	auipc	ra,0x5
     ec8:	cfa080e7          	jalr	-774(ra) # 5bbe <printf>
    exit(1);
     ecc:	4505                	li	a0,1
     ece:	00005097          	auipc	ra,0x5
     ed2:	976080e7          	jalr	-1674(ra) # 5844 <exit>
    printf("%s: open lf2 failed\n", s);
     ed6:	85ca                	mv	a1,s2
     ed8:	00005517          	auipc	a0,0x5
     edc:	4f850513          	addi	a0,a0,1272 # 63d0 <malloc+0x75a>
     ee0:	00005097          	auipc	ra,0x5
     ee4:	cde080e7          	jalr	-802(ra) # 5bbe <printf>
    exit(1);
     ee8:	4505                	li	a0,1
     eea:	00005097          	auipc	ra,0x5
     eee:	95a080e7          	jalr	-1702(ra) # 5844 <exit>
    printf("%s: read lf2 failed\n", s);
     ef2:	85ca                	mv	a1,s2
     ef4:	00005517          	auipc	a0,0x5
     ef8:	4f450513          	addi	a0,a0,1268 # 63e8 <malloc+0x772>
     efc:	00005097          	auipc	ra,0x5
     f00:	cc2080e7          	jalr	-830(ra) # 5bbe <printf>
    exit(1);
     f04:	4505                	li	a0,1
     f06:	00005097          	auipc	ra,0x5
     f0a:	93e080e7          	jalr	-1730(ra) # 5844 <exit>
    printf("%s: link lf2 lf2 succeeded! oops\n", s);
     f0e:	85ca                	mv	a1,s2
     f10:	00005517          	auipc	a0,0x5
     f14:	4f050513          	addi	a0,a0,1264 # 6400 <malloc+0x78a>
     f18:	00005097          	auipc	ra,0x5
     f1c:	ca6080e7          	jalr	-858(ra) # 5bbe <printf>
    exit(1);
     f20:	4505                	li	a0,1
     f22:	00005097          	auipc	ra,0x5
     f26:	922080e7          	jalr	-1758(ra) # 5844 <exit>
    printf("%s: link non-existent succeeded! oops\n", s);
     f2a:	85ca                	mv	a1,s2
     f2c:	00005517          	auipc	a0,0x5
     f30:	4fc50513          	addi	a0,a0,1276 # 6428 <malloc+0x7b2>
     f34:	00005097          	auipc	ra,0x5
     f38:	c8a080e7          	jalr	-886(ra) # 5bbe <printf>
    exit(1);
     f3c:	4505                	li	a0,1
     f3e:	00005097          	auipc	ra,0x5
     f42:	906080e7          	jalr	-1786(ra) # 5844 <exit>
    printf("%s: link . lf1 succeeded! oops\n", s);
     f46:	85ca                	mv	a1,s2
     f48:	00005517          	auipc	a0,0x5
     f4c:	51050513          	addi	a0,a0,1296 # 6458 <malloc+0x7e2>
     f50:	00005097          	auipc	ra,0x5
     f54:	c6e080e7          	jalr	-914(ra) # 5bbe <printf>
    exit(1);
     f58:	4505                	li	a0,1
     f5a:	00005097          	auipc	ra,0x5
     f5e:	8ea080e7          	jalr	-1814(ra) # 5844 <exit>

0000000000000f62 <bigdir>:
{
     f62:	715d                	addi	sp,sp,-80
     f64:	e486                	sd	ra,72(sp)
     f66:	e0a2                	sd	s0,64(sp)
     f68:	fc26                	sd	s1,56(sp)
     f6a:	f84a                	sd	s2,48(sp)
     f6c:	f44e                	sd	s3,40(sp)
     f6e:	f052                	sd	s4,32(sp)
     f70:	ec56                	sd	s5,24(sp)
     f72:	e85a                	sd	s6,16(sp)
     f74:	0880                	addi	s0,sp,80
     f76:	89aa                	mv	s3,a0
  unlink("bd");
     f78:	00005517          	auipc	a0,0x5
     f7c:	50050513          	addi	a0,a0,1280 # 6478 <malloc+0x802>
     f80:	00005097          	auipc	ra,0x5
     f84:	914080e7          	jalr	-1772(ra) # 5894 <unlink>
  fd = open("bd", O_CREATE);
     f88:	20000593          	li	a1,512
     f8c:	00005517          	auipc	a0,0x5
     f90:	4ec50513          	addi	a0,a0,1260 # 6478 <malloc+0x802>
     f94:	00005097          	auipc	ra,0x5
     f98:	8f0080e7          	jalr	-1808(ra) # 5884 <open>
  if(fd < 0){
     f9c:	0c054963          	bltz	a0,106e <bigdir+0x10c>
  close(fd);
     fa0:	00005097          	auipc	ra,0x5
     fa4:	8cc080e7          	jalr	-1844(ra) # 586c <close>
  for(i = 0; i < N; i++){
     fa8:	4901                	li	s2,0
    name[0] = 'x';
     faa:	07800a93          	li	s5,120
    if(link("bd", name) != 0){
     fae:	00005a17          	auipc	s4,0x5
     fb2:	4caa0a13          	addi	s4,s4,1226 # 6478 <malloc+0x802>
  for(i = 0; i < N; i++){
     fb6:	1f400b13          	li	s6,500
    name[0] = 'x';
     fba:	fb540823          	sb	s5,-80(s0)
    name[1] = '0' + (i / 64);
     fbe:	41f9571b          	sraiw	a4,s2,0x1f
     fc2:	01a7571b          	srliw	a4,a4,0x1a
     fc6:	012707bb          	addw	a5,a4,s2
     fca:	4067d69b          	sraiw	a3,a5,0x6
     fce:	0306869b          	addiw	a3,a3,48
     fd2:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
     fd6:	03f7f793          	andi	a5,a5,63
     fda:	9f99                	subw	a5,a5,a4
     fdc:	0307879b          	addiw	a5,a5,48
     fe0:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
     fe4:	fa0409a3          	sb	zero,-77(s0)
    if(link("bd", name) != 0){
     fe8:	fb040593          	addi	a1,s0,-80
     fec:	8552                	mv	a0,s4
     fee:	00005097          	auipc	ra,0x5
     ff2:	8b6080e7          	jalr	-1866(ra) # 58a4 <link>
     ff6:	84aa                	mv	s1,a0
     ff8:	e949                	bnez	a0,108a <bigdir+0x128>
  for(i = 0; i < N; i++){
     ffa:	2905                	addiw	s2,s2,1
     ffc:	fb691fe3          	bne	s2,s6,fba <bigdir+0x58>
  unlink("bd");
    1000:	00005517          	auipc	a0,0x5
    1004:	47850513          	addi	a0,a0,1144 # 6478 <malloc+0x802>
    1008:	00005097          	auipc	ra,0x5
    100c:	88c080e7          	jalr	-1908(ra) # 5894 <unlink>
    name[0] = 'x';
    1010:	07800913          	li	s2,120
  for(i = 0; i < N; i++){
    1014:	1f400a13          	li	s4,500
    name[0] = 'x';
    1018:	fb240823          	sb	s2,-80(s0)
    name[1] = '0' + (i / 64);
    101c:	41f4d71b          	sraiw	a4,s1,0x1f
    1020:	01a7571b          	srliw	a4,a4,0x1a
    1024:	009707bb          	addw	a5,a4,s1
    1028:	4067d69b          	sraiw	a3,a5,0x6
    102c:	0306869b          	addiw	a3,a3,48
    1030:	fad408a3          	sb	a3,-79(s0)
    name[2] = '0' + (i % 64);
    1034:	03f7f793          	andi	a5,a5,63
    1038:	9f99                	subw	a5,a5,a4
    103a:	0307879b          	addiw	a5,a5,48
    103e:	faf40923          	sb	a5,-78(s0)
    name[3] = '\0';
    1042:	fa0409a3          	sb	zero,-77(s0)
    if(unlink(name) != 0){
    1046:	fb040513          	addi	a0,s0,-80
    104a:	00005097          	auipc	ra,0x5
    104e:	84a080e7          	jalr	-1974(ra) # 5894 <unlink>
    1052:	ed21                	bnez	a0,10aa <bigdir+0x148>
  for(i = 0; i < N; i++){
    1054:	2485                	addiw	s1,s1,1
    1056:	fd4491e3          	bne	s1,s4,1018 <bigdir+0xb6>
}
    105a:	60a6                	ld	ra,72(sp)
    105c:	6406                	ld	s0,64(sp)
    105e:	74e2                	ld	s1,56(sp)
    1060:	7942                	ld	s2,48(sp)
    1062:	79a2                	ld	s3,40(sp)
    1064:	7a02                	ld	s4,32(sp)
    1066:	6ae2                	ld	s5,24(sp)
    1068:	6b42                	ld	s6,16(sp)
    106a:	6161                	addi	sp,sp,80
    106c:	8082                	ret
    printf("%s: bigdir create failed\n", s);
    106e:	85ce                	mv	a1,s3
    1070:	00005517          	auipc	a0,0x5
    1074:	41050513          	addi	a0,a0,1040 # 6480 <malloc+0x80a>
    1078:	00005097          	auipc	ra,0x5
    107c:	b46080e7          	jalr	-1210(ra) # 5bbe <printf>
    exit(1);
    1080:	4505                	li	a0,1
    1082:	00004097          	auipc	ra,0x4
    1086:	7c2080e7          	jalr	1986(ra) # 5844 <exit>
      printf("%s: bigdir link(bd, %s) failed\n", s, name);
    108a:	fb040613          	addi	a2,s0,-80
    108e:	85ce                	mv	a1,s3
    1090:	00005517          	auipc	a0,0x5
    1094:	41050513          	addi	a0,a0,1040 # 64a0 <malloc+0x82a>
    1098:	00005097          	auipc	ra,0x5
    109c:	b26080e7          	jalr	-1242(ra) # 5bbe <printf>
      exit(1);
    10a0:	4505                	li	a0,1
    10a2:	00004097          	auipc	ra,0x4
    10a6:	7a2080e7          	jalr	1954(ra) # 5844 <exit>
      printf("%s: bigdir unlink failed", s);
    10aa:	85ce                	mv	a1,s3
    10ac:	00005517          	auipc	a0,0x5
    10b0:	41450513          	addi	a0,a0,1044 # 64c0 <malloc+0x84a>
    10b4:	00005097          	auipc	ra,0x5
    10b8:	b0a080e7          	jalr	-1270(ra) # 5bbe <printf>
      exit(1);
    10bc:	4505                	li	a0,1
    10be:	00004097          	auipc	ra,0x4
    10c2:	786080e7          	jalr	1926(ra) # 5844 <exit>

00000000000010c6 <validatetest>:
{
    10c6:	7139                	addi	sp,sp,-64
    10c8:	fc06                	sd	ra,56(sp)
    10ca:	f822                	sd	s0,48(sp)
    10cc:	f426                	sd	s1,40(sp)
    10ce:	f04a                	sd	s2,32(sp)
    10d0:	ec4e                	sd	s3,24(sp)
    10d2:	e852                	sd	s4,16(sp)
    10d4:	e456                	sd	s5,8(sp)
    10d6:	e05a                	sd	s6,0(sp)
    10d8:	0080                	addi	s0,sp,64
    10da:	8b2a                	mv	s6,a0
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10dc:	4481                	li	s1,0
    if(link("nosuchfile", (char*)p) != -1){
    10de:	00005997          	auipc	s3,0x5
    10e2:	40298993          	addi	s3,s3,1026 # 64e0 <malloc+0x86a>
    10e6:	597d                	li	s2,-1
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10e8:	6a85                	lui	s5,0x1
    10ea:	00114a37          	lui	s4,0x114
    if(link("nosuchfile", (char*)p) != -1){
    10ee:	85a6                	mv	a1,s1
    10f0:	854e                	mv	a0,s3
    10f2:	00004097          	auipc	ra,0x4
    10f6:	7b2080e7          	jalr	1970(ra) # 58a4 <link>
    10fa:	01251f63          	bne	a0,s2,1118 <validatetest+0x52>
  for(p = 0; p <= (uint)hi; p += PGSIZE){
    10fe:	94d6                	add	s1,s1,s5
    1100:	ff4497e3          	bne	s1,s4,10ee <validatetest+0x28>
}
    1104:	70e2                	ld	ra,56(sp)
    1106:	7442                	ld	s0,48(sp)
    1108:	74a2                	ld	s1,40(sp)
    110a:	7902                	ld	s2,32(sp)
    110c:	69e2                	ld	s3,24(sp)
    110e:	6a42                	ld	s4,16(sp)
    1110:	6aa2                	ld	s5,8(sp)
    1112:	6b02                	ld	s6,0(sp)
    1114:	6121                	addi	sp,sp,64
    1116:	8082                	ret
      printf("%s: link should not succeed\n", s);
    1118:	85da                	mv	a1,s6
    111a:	00005517          	auipc	a0,0x5
    111e:	3d650513          	addi	a0,a0,982 # 64f0 <malloc+0x87a>
    1122:	00005097          	auipc	ra,0x5
    1126:	a9c080e7          	jalr	-1380(ra) # 5bbe <printf>
      exit(1);
    112a:	4505                	li	a0,1
    112c:	00004097          	auipc	ra,0x4
    1130:	718080e7          	jalr	1816(ra) # 5844 <exit>

0000000000001134 <pgbug>:
// regression test. copyin(), copyout(), and copyinstr() used to cast
// the virtual page address to uint, which (with certain wild system
// call arguments) resulted in a kernel page faults.
void
pgbug(char *s)
{
    1134:	7179                	addi	sp,sp,-48
    1136:	f406                	sd	ra,40(sp)
    1138:	f022                	sd	s0,32(sp)
    113a:	ec26                	sd	s1,24(sp)
    113c:	1800                	addi	s0,sp,48
  char *argv[1];
  argv[0] = 0;
    113e:	fc043c23          	sd	zero,-40(s0)
  exec((char*)0xeaeb0b5b00002f5e, argv);
    1142:	00007497          	auipc	s1,0x7
    1146:	46e4b483          	ld	s1,1134(s1) # 85b0 <__SDATA_BEGIN__>
    114a:	fd840593          	addi	a1,s0,-40
    114e:	8526                	mv	a0,s1
    1150:	00004097          	auipc	ra,0x4
    1154:	72c080e7          	jalr	1836(ra) # 587c <exec>

  pipe((int*)0xeaeb0b5b00002f5e);
    1158:	8526                	mv	a0,s1
    115a:	00004097          	auipc	ra,0x4
    115e:	6fa080e7          	jalr	1786(ra) # 5854 <pipe>

  exit(0);
    1162:	4501                	li	a0,0
    1164:	00004097          	auipc	ra,0x4
    1168:	6e0080e7          	jalr	1760(ra) # 5844 <exit>

000000000000116c <badarg>:

// regression test. test whether exec() leaks memory if one of the
// arguments is invalid. the test passes if the kernel doesn't panic.
void
badarg(char *s)
{
    116c:	7139                	addi	sp,sp,-64
    116e:	fc06                	sd	ra,56(sp)
    1170:	f822                	sd	s0,48(sp)
    1172:	f426                	sd	s1,40(sp)
    1174:	f04a                	sd	s2,32(sp)
    1176:	ec4e                	sd	s3,24(sp)
    1178:	0080                	addi	s0,sp,64
    117a:	64b1                	lui	s1,0xc
    117c:	35048493          	addi	s1,s1,848 # c350 <buf+0x578>
  for(int i = 0; i < 50000; i++){
    char *argv[2];
    argv[0] = (char*)0xffffffff;
    1180:	597d                	li	s2,-1
    1182:	02095913          	srli	s2,s2,0x20
    argv[1] = 0;
    exec("echo", argv);
    1186:	00005997          	auipc	s3,0x5
    118a:	c1298993          	addi	s3,s3,-1006 # 5d98 <malloc+0x122>
    argv[0] = (char*)0xffffffff;
    118e:	fd243023          	sd	s2,-64(s0)
    argv[1] = 0;
    1192:	fc043423          	sd	zero,-56(s0)
    exec("echo", argv);
    1196:	fc040593          	addi	a1,s0,-64
    119a:	854e                	mv	a0,s3
    119c:	00004097          	auipc	ra,0x4
    11a0:	6e0080e7          	jalr	1760(ra) # 587c <exec>
  for(int i = 0; i < 50000; i++){
    11a4:	34fd                	addiw	s1,s1,-1
    11a6:	f4e5                	bnez	s1,118e <badarg+0x22>
  }
  
  exit(0);
    11a8:	4501                	li	a0,0
    11aa:	00004097          	auipc	ra,0x4
    11ae:	69a080e7          	jalr	1690(ra) # 5844 <exit>

00000000000011b2 <copyinstr2>:
{
    11b2:	7155                	addi	sp,sp,-208
    11b4:	e586                	sd	ra,200(sp)
    11b6:	e1a2                	sd	s0,192(sp)
    11b8:	0980                	addi	s0,sp,208
  for(int i = 0; i < MAXPATH; i++)
    11ba:	f6840793          	addi	a5,s0,-152
    11be:	fe840693          	addi	a3,s0,-24
    b[i] = 'x';
    11c2:	07800713          	li	a4,120
    11c6:	00e78023          	sb	a4,0(a5)
  for(int i = 0; i < MAXPATH; i++)
    11ca:	0785                	addi	a5,a5,1
    11cc:	fed79de3          	bne	a5,a3,11c6 <copyinstr2+0x14>
  b[MAXPATH] = '\0';
    11d0:	fe040423          	sb	zero,-24(s0)
  int ret = unlink(b);
    11d4:	f6840513          	addi	a0,s0,-152
    11d8:	00004097          	auipc	ra,0x4
    11dc:	6bc080e7          	jalr	1724(ra) # 5894 <unlink>
  if(ret != -1){
    11e0:	57fd                	li	a5,-1
    11e2:	0ef51063          	bne	a0,a5,12c2 <copyinstr2+0x110>
  int fd = open(b, O_CREATE | O_WRONLY);
    11e6:	20100593          	li	a1,513
    11ea:	f6840513          	addi	a0,s0,-152
    11ee:	00004097          	auipc	ra,0x4
    11f2:	696080e7          	jalr	1686(ra) # 5884 <open>
  if(fd != -1){
    11f6:	57fd                	li	a5,-1
    11f8:	0ef51563          	bne	a0,a5,12e2 <copyinstr2+0x130>
  ret = link(b, b);
    11fc:	f6840593          	addi	a1,s0,-152
    1200:	852e                	mv	a0,a1
    1202:	00004097          	auipc	ra,0x4
    1206:	6a2080e7          	jalr	1698(ra) # 58a4 <link>
  if(ret != -1){
    120a:	57fd                	li	a5,-1
    120c:	0ef51b63          	bne	a0,a5,1302 <copyinstr2+0x150>
  char *args[] = { "xx", 0 };
    1210:	00006797          	auipc	a5,0x6
    1214:	4d878793          	addi	a5,a5,1240 # 76e8 <malloc+0x1a72>
    1218:	f4f43c23          	sd	a5,-168(s0)
    121c:	f6043023          	sd	zero,-160(s0)
  ret = exec(b, args);
    1220:	f5840593          	addi	a1,s0,-168
    1224:	f6840513          	addi	a0,s0,-152
    1228:	00004097          	auipc	ra,0x4
    122c:	654080e7          	jalr	1620(ra) # 587c <exec>
  if(ret != -1){
    1230:	57fd                	li	a5,-1
    1232:	0ef51963          	bne	a0,a5,1324 <copyinstr2+0x172>
  int pid = fork();
    1236:	00004097          	auipc	ra,0x4
    123a:	606080e7          	jalr	1542(ra) # 583c <fork>
  if(pid < 0){
    123e:	10054363          	bltz	a0,1344 <copyinstr2+0x192>
  if(pid == 0){
    1242:	12051463          	bnez	a0,136a <copyinstr2+0x1b8>
    1246:	00007797          	auipc	a5,0x7
    124a:	47a78793          	addi	a5,a5,1146 # 86c0 <big.0>
    124e:	00008697          	auipc	a3,0x8
    1252:	47268693          	addi	a3,a3,1138 # 96c0 <__global_pointer$+0x910>
      big[i] = 'x';
    1256:	07800713          	li	a4,120
    125a:	00e78023          	sb	a4,0(a5)
    for(int i = 0; i < PGSIZE; i++)
    125e:	0785                	addi	a5,a5,1
    1260:	fed79de3          	bne	a5,a3,125a <copyinstr2+0xa8>
    big[PGSIZE] = '\0';
    1264:	00008797          	auipc	a5,0x8
    1268:	44078e23          	sb	zero,1116(a5) # 96c0 <__global_pointer$+0x910>
    char *args2[] = { big, big, big, 0 };
    126c:	00007797          	auipc	a5,0x7
    1270:	ebc78793          	addi	a5,a5,-324 # 8128 <malloc+0x24b2>
    1274:	6390                	ld	a2,0(a5)
    1276:	6794                	ld	a3,8(a5)
    1278:	6b98                	ld	a4,16(a5)
    127a:	6f9c                	ld	a5,24(a5)
    127c:	f2c43823          	sd	a2,-208(s0)
    1280:	f2d43c23          	sd	a3,-200(s0)
    1284:	f4e43023          	sd	a4,-192(s0)
    1288:	f4f43423          	sd	a5,-184(s0)
    ret = exec("echo", args2);
    128c:	f3040593          	addi	a1,s0,-208
    1290:	00005517          	auipc	a0,0x5
    1294:	b0850513          	addi	a0,a0,-1272 # 5d98 <malloc+0x122>
    1298:	00004097          	auipc	ra,0x4
    129c:	5e4080e7          	jalr	1508(ra) # 587c <exec>
    if(ret != -1){
    12a0:	57fd                	li	a5,-1
    12a2:	0af50e63          	beq	a0,a5,135e <copyinstr2+0x1ac>
      printf("exec(echo, BIG) returned %d, not -1\n", fd);
    12a6:	55fd                	li	a1,-1
    12a8:	00005517          	auipc	a0,0x5
    12ac:	2f050513          	addi	a0,a0,752 # 6598 <malloc+0x922>
    12b0:	00005097          	auipc	ra,0x5
    12b4:	90e080e7          	jalr	-1778(ra) # 5bbe <printf>
      exit(1);
    12b8:	4505                	li	a0,1
    12ba:	00004097          	auipc	ra,0x4
    12be:	58a080e7          	jalr	1418(ra) # 5844 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    12c2:	862a                	mv	a2,a0
    12c4:	f6840593          	addi	a1,s0,-152
    12c8:	00005517          	auipc	a0,0x5
    12cc:	24850513          	addi	a0,a0,584 # 6510 <malloc+0x89a>
    12d0:	00005097          	auipc	ra,0x5
    12d4:	8ee080e7          	jalr	-1810(ra) # 5bbe <printf>
    exit(1);
    12d8:	4505                	li	a0,1
    12da:	00004097          	auipc	ra,0x4
    12de:	56a080e7          	jalr	1386(ra) # 5844 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    12e2:	862a                	mv	a2,a0
    12e4:	f6840593          	addi	a1,s0,-152
    12e8:	00005517          	auipc	a0,0x5
    12ec:	24850513          	addi	a0,a0,584 # 6530 <malloc+0x8ba>
    12f0:	00005097          	auipc	ra,0x5
    12f4:	8ce080e7          	jalr	-1842(ra) # 5bbe <printf>
    exit(1);
    12f8:	4505                	li	a0,1
    12fa:	00004097          	auipc	ra,0x4
    12fe:	54a080e7          	jalr	1354(ra) # 5844 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    1302:	86aa                	mv	a3,a0
    1304:	f6840613          	addi	a2,s0,-152
    1308:	85b2                	mv	a1,a2
    130a:	00005517          	auipc	a0,0x5
    130e:	24650513          	addi	a0,a0,582 # 6550 <malloc+0x8da>
    1312:	00005097          	auipc	ra,0x5
    1316:	8ac080e7          	jalr	-1876(ra) # 5bbe <printf>
    exit(1);
    131a:	4505                	li	a0,1
    131c:	00004097          	auipc	ra,0x4
    1320:	528080e7          	jalr	1320(ra) # 5844 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    1324:	567d                	li	a2,-1
    1326:	f6840593          	addi	a1,s0,-152
    132a:	00005517          	auipc	a0,0x5
    132e:	24e50513          	addi	a0,a0,590 # 6578 <malloc+0x902>
    1332:	00005097          	auipc	ra,0x5
    1336:	88c080e7          	jalr	-1908(ra) # 5bbe <printf>
    exit(1);
    133a:	4505                	li	a0,1
    133c:	00004097          	auipc	ra,0x4
    1340:	508080e7          	jalr	1288(ra) # 5844 <exit>
    printf("fork failed\n");
    1344:	00005517          	auipc	a0,0x5
    1348:	6cc50513          	addi	a0,a0,1740 # 6a10 <malloc+0xd9a>
    134c:	00005097          	auipc	ra,0x5
    1350:	872080e7          	jalr	-1934(ra) # 5bbe <printf>
    exit(1);
    1354:	4505                	li	a0,1
    1356:	00004097          	auipc	ra,0x4
    135a:	4ee080e7          	jalr	1262(ra) # 5844 <exit>
    exit(747); // OK
    135e:	2eb00513          	li	a0,747
    1362:	00004097          	auipc	ra,0x4
    1366:	4e2080e7          	jalr	1250(ra) # 5844 <exit>
  int st = 0;
    136a:	f4042a23          	sw	zero,-172(s0)
  wait(&st);
    136e:	f5440513          	addi	a0,s0,-172
    1372:	00004097          	auipc	ra,0x4
    1376:	4da080e7          	jalr	1242(ra) # 584c <wait>
  if(st != 747){
    137a:	f5442703          	lw	a4,-172(s0)
    137e:	2eb00793          	li	a5,747
    1382:	00f71663          	bne	a4,a5,138e <copyinstr2+0x1dc>
}
    1386:	60ae                	ld	ra,200(sp)
    1388:	640e                	ld	s0,192(sp)
    138a:	6169                	addi	sp,sp,208
    138c:	8082                	ret
    printf("exec(echo, BIG) succeeded, should have failed\n");
    138e:	00005517          	auipc	a0,0x5
    1392:	23250513          	addi	a0,a0,562 # 65c0 <malloc+0x94a>
    1396:	00005097          	auipc	ra,0x5
    139a:	828080e7          	jalr	-2008(ra) # 5bbe <printf>
    exit(1);
    139e:	4505                	li	a0,1
    13a0:	00004097          	auipc	ra,0x4
    13a4:	4a4080e7          	jalr	1188(ra) # 5844 <exit>

00000000000013a8 <truncate3>:
{
    13a8:	7159                	addi	sp,sp,-112
    13aa:	f486                	sd	ra,104(sp)
    13ac:	f0a2                	sd	s0,96(sp)
    13ae:	eca6                	sd	s1,88(sp)
    13b0:	e8ca                	sd	s2,80(sp)
    13b2:	e4ce                	sd	s3,72(sp)
    13b4:	e0d2                	sd	s4,64(sp)
    13b6:	fc56                	sd	s5,56(sp)
    13b8:	1880                	addi	s0,sp,112
    13ba:	892a                	mv	s2,a0
  close(open("truncfile", O_CREATE|O_TRUNC|O_WRONLY));
    13bc:	60100593          	li	a1,1537
    13c0:	00005517          	auipc	a0,0x5
    13c4:	a3050513          	addi	a0,a0,-1488 # 5df0 <malloc+0x17a>
    13c8:	00004097          	auipc	ra,0x4
    13cc:	4bc080e7          	jalr	1212(ra) # 5884 <open>
    13d0:	00004097          	auipc	ra,0x4
    13d4:	49c080e7          	jalr	1180(ra) # 586c <close>
  pid = fork();
    13d8:	00004097          	auipc	ra,0x4
    13dc:	464080e7          	jalr	1124(ra) # 583c <fork>
  if(pid < 0){
    13e0:	08054063          	bltz	a0,1460 <truncate3+0xb8>
  if(pid == 0){
    13e4:	e969                	bnez	a0,14b6 <truncate3+0x10e>
    13e6:	06400993          	li	s3,100
      int fd = open("truncfile", O_WRONLY);
    13ea:	00005a17          	auipc	s4,0x5
    13ee:	a06a0a13          	addi	s4,s4,-1530 # 5df0 <malloc+0x17a>
      int n = write(fd, "1234567890", 10);
    13f2:	00005a97          	auipc	s5,0x5
    13f6:	22ea8a93          	addi	s5,s5,558 # 6620 <malloc+0x9aa>
      int fd = open("truncfile", O_WRONLY);
    13fa:	4585                	li	a1,1
    13fc:	8552                	mv	a0,s4
    13fe:	00004097          	auipc	ra,0x4
    1402:	486080e7          	jalr	1158(ra) # 5884 <open>
    1406:	84aa                	mv	s1,a0
      if(fd < 0){
    1408:	06054a63          	bltz	a0,147c <truncate3+0xd4>
      int n = write(fd, "1234567890", 10);
    140c:	4629                	li	a2,10
    140e:	85d6                	mv	a1,s5
    1410:	00004097          	auipc	ra,0x4
    1414:	454080e7          	jalr	1108(ra) # 5864 <write>
      if(n != 10){
    1418:	47a9                	li	a5,10
    141a:	06f51f63          	bne	a0,a5,1498 <truncate3+0xf0>
      close(fd);
    141e:	8526                	mv	a0,s1
    1420:	00004097          	auipc	ra,0x4
    1424:	44c080e7          	jalr	1100(ra) # 586c <close>
      fd = open("truncfile", O_RDONLY);
    1428:	4581                	li	a1,0
    142a:	8552                	mv	a0,s4
    142c:	00004097          	auipc	ra,0x4
    1430:	458080e7          	jalr	1112(ra) # 5884 <open>
    1434:	84aa                	mv	s1,a0
      read(fd, buf, sizeof(buf));
    1436:	02000613          	li	a2,32
    143a:	f9840593          	addi	a1,s0,-104
    143e:	00004097          	auipc	ra,0x4
    1442:	41e080e7          	jalr	1054(ra) # 585c <read>
      close(fd);
    1446:	8526                	mv	a0,s1
    1448:	00004097          	auipc	ra,0x4
    144c:	424080e7          	jalr	1060(ra) # 586c <close>
    for(int i = 0; i < 100; i++){
    1450:	39fd                	addiw	s3,s3,-1
    1452:	fa0994e3          	bnez	s3,13fa <truncate3+0x52>
    exit(0);
    1456:	4501                	li	a0,0
    1458:	00004097          	auipc	ra,0x4
    145c:	3ec080e7          	jalr	1004(ra) # 5844 <exit>
    printf("%s: fork failed\n", s);
    1460:	85ca                	mv	a1,s2
    1462:	00005517          	auipc	a0,0x5
    1466:	18e50513          	addi	a0,a0,398 # 65f0 <malloc+0x97a>
    146a:	00004097          	auipc	ra,0x4
    146e:	754080e7          	jalr	1876(ra) # 5bbe <printf>
    exit(1);
    1472:	4505                	li	a0,1
    1474:	00004097          	auipc	ra,0x4
    1478:	3d0080e7          	jalr	976(ra) # 5844 <exit>
        printf("%s: open failed\n", s);
    147c:	85ca                	mv	a1,s2
    147e:	00005517          	auipc	a0,0x5
    1482:	18a50513          	addi	a0,a0,394 # 6608 <malloc+0x992>
    1486:	00004097          	auipc	ra,0x4
    148a:	738080e7          	jalr	1848(ra) # 5bbe <printf>
        exit(1);
    148e:	4505                	li	a0,1
    1490:	00004097          	auipc	ra,0x4
    1494:	3b4080e7          	jalr	948(ra) # 5844 <exit>
        printf("%s: write got %d, expected 10\n", s, n);
    1498:	862a                	mv	a2,a0
    149a:	85ca                	mv	a1,s2
    149c:	00005517          	auipc	a0,0x5
    14a0:	19450513          	addi	a0,a0,404 # 6630 <malloc+0x9ba>
    14a4:	00004097          	auipc	ra,0x4
    14a8:	71a080e7          	jalr	1818(ra) # 5bbe <printf>
        exit(1);
    14ac:	4505                	li	a0,1
    14ae:	00004097          	auipc	ra,0x4
    14b2:	396080e7          	jalr	918(ra) # 5844 <exit>
    14b6:	09600993          	li	s3,150
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14ba:	00005a17          	auipc	s4,0x5
    14be:	936a0a13          	addi	s4,s4,-1738 # 5df0 <malloc+0x17a>
    int n = write(fd, "xxx", 3);
    14c2:	00005a97          	auipc	s5,0x5
    14c6:	18ea8a93          	addi	s5,s5,398 # 6650 <malloc+0x9da>
    int fd = open("truncfile", O_CREATE|O_WRONLY|O_TRUNC);
    14ca:	60100593          	li	a1,1537
    14ce:	8552                	mv	a0,s4
    14d0:	00004097          	auipc	ra,0x4
    14d4:	3b4080e7          	jalr	948(ra) # 5884 <open>
    14d8:	84aa                	mv	s1,a0
    if(fd < 0){
    14da:	04054763          	bltz	a0,1528 <truncate3+0x180>
    int n = write(fd, "xxx", 3);
    14de:	460d                	li	a2,3
    14e0:	85d6                	mv	a1,s5
    14e2:	00004097          	auipc	ra,0x4
    14e6:	382080e7          	jalr	898(ra) # 5864 <write>
    if(n != 3){
    14ea:	478d                	li	a5,3
    14ec:	04f51c63          	bne	a0,a5,1544 <truncate3+0x19c>
    close(fd);
    14f0:	8526                	mv	a0,s1
    14f2:	00004097          	auipc	ra,0x4
    14f6:	37a080e7          	jalr	890(ra) # 586c <close>
  for(int i = 0; i < 150; i++){
    14fa:	39fd                	addiw	s3,s3,-1
    14fc:	fc0997e3          	bnez	s3,14ca <truncate3+0x122>
  wait(&xstatus);
    1500:	fbc40513          	addi	a0,s0,-68
    1504:	00004097          	auipc	ra,0x4
    1508:	348080e7          	jalr	840(ra) # 584c <wait>
  unlink("truncfile");
    150c:	00005517          	auipc	a0,0x5
    1510:	8e450513          	addi	a0,a0,-1820 # 5df0 <malloc+0x17a>
    1514:	00004097          	auipc	ra,0x4
    1518:	380080e7          	jalr	896(ra) # 5894 <unlink>
  exit(xstatus);
    151c:	fbc42503          	lw	a0,-68(s0)
    1520:	00004097          	auipc	ra,0x4
    1524:	324080e7          	jalr	804(ra) # 5844 <exit>
      printf("%s: open failed\n", s);
    1528:	85ca                	mv	a1,s2
    152a:	00005517          	auipc	a0,0x5
    152e:	0de50513          	addi	a0,a0,222 # 6608 <malloc+0x992>
    1532:	00004097          	auipc	ra,0x4
    1536:	68c080e7          	jalr	1676(ra) # 5bbe <printf>
      exit(1);
    153a:	4505                	li	a0,1
    153c:	00004097          	auipc	ra,0x4
    1540:	308080e7          	jalr	776(ra) # 5844 <exit>
      printf("%s: write got %d, expected 3\n", s, n);
    1544:	862a                	mv	a2,a0
    1546:	85ca                	mv	a1,s2
    1548:	00005517          	auipc	a0,0x5
    154c:	11050513          	addi	a0,a0,272 # 6658 <malloc+0x9e2>
    1550:	00004097          	auipc	ra,0x4
    1554:	66e080e7          	jalr	1646(ra) # 5bbe <printf>
      exit(1);
    1558:	4505                	li	a0,1
    155a:	00004097          	auipc	ra,0x4
    155e:	2ea080e7          	jalr	746(ra) # 5844 <exit>

0000000000001562 <exectest>:
{
    1562:	715d                	addi	sp,sp,-80
    1564:	e486                	sd	ra,72(sp)
    1566:	e0a2                	sd	s0,64(sp)
    1568:	fc26                	sd	s1,56(sp)
    156a:	f84a                	sd	s2,48(sp)
    156c:	0880                	addi	s0,sp,80
    156e:	892a                	mv	s2,a0
  char *echoargv[] = { "echo", "OK", 0 };
    1570:	00005797          	auipc	a5,0x5
    1574:	82878793          	addi	a5,a5,-2008 # 5d98 <malloc+0x122>
    1578:	fcf43023          	sd	a5,-64(s0)
    157c:	00005797          	auipc	a5,0x5
    1580:	0fc78793          	addi	a5,a5,252 # 6678 <malloc+0xa02>
    1584:	fcf43423          	sd	a5,-56(s0)
    1588:	fc043823          	sd	zero,-48(s0)
  unlink("echo-ok");
    158c:	00005517          	auipc	a0,0x5
    1590:	0f450513          	addi	a0,a0,244 # 6680 <malloc+0xa0a>
    1594:	00004097          	auipc	ra,0x4
    1598:	300080e7          	jalr	768(ra) # 5894 <unlink>
  pid = fork();
    159c:	00004097          	auipc	ra,0x4
    15a0:	2a0080e7          	jalr	672(ra) # 583c <fork>
  if(pid < 0) {
    15a4:	04054663          	bltz	a0,15f0 <exectest+0x8e>
    15a8:	84aa                	mv	s1,a0
  if(pid == 0) {
    15aa:	e959                	bnez	a0,1640 <exectest+0xde>
    close(1);
    15ac:	4505                	li	a0,1
    15ae:	00004097          	auipc	ra,0x4
    15b2:	2be080e7          	jalr	702(ra) # 586c <close>
    fd = open("echo-ok", O_CREATE|O_WRONLY);
    15b6:	20100593          	li	a1,513
    15ba:	00005517          	auipc	a0,0x5
    15be:	0c650513          	addi	a0,a0,198 # 6680 <malloc+0xa0a>
    15c2:	00004097          	auipc	ra,0x4
    15c6:	2c2080e7          	jalr	706(ra) # 5884 <open>
    if(fd < 0) {
    15ca:	04054163          	bltz	a0,160c <exectest+0xaa>
    if(fd != 1) {
    15ce:	4785                	li	a5,1
    15d0:	04f50c63          	beq	a0,a5,1628 <exectest+0xc6>
      printf("%s: wrong fd\n", s);
    15d4:	85ca                	mv	a1,s2
    15d6:	00005517          	auipc	a0,0x5
    15da:	0ca50513          	addi	a0,a0,202 # 66a0 <malloc+0xa2a>
    15de:	00004097          	auipc	ra,0x4
    15e2:	5e0080e7          	jalr	1504(ra) # 5bbe <printf>
      exit(1);
    15e6:	4505                	li	a0,1
    15e8:	00004097          	auipc	ra,0x4
    15ec:	25c080e7          	jalr	604(ra) # 5844 <exit>
     printf("%s: fork failed\n", s);
    15f0:	85ca                	mv	a1,s2
    15f2:	00005517          	auipc	a0,0x5
    15f6:	ffe50513          	addi	a0,a0,-2 # 65f0 <malloc+0x97a>
    15fa:	00004097          	auipc	ra,0x4
    15fe:	5c4080e7          	jalr	1476(ra) # 5bbe <printf>
     exit(1);
    1602:	4505                	li	a0,1
    1604:	00004097          	auipc	ra,0x4
    1608:	240080e7          	jalr	576(ra) # 5844 <exit>
      printf("%s: create failed\n", s);
    160c:	85ca                	mv	a1,s2
    160e:	00005517          	auipc	a0,0x5
    1612:	07a50513          	addi	a0,a0,122 # 6688 <malloc+0xa12>
    1616:	00004097          	auipc	ra,0x4
    161a:	5a8080e7          	jalr	1448(ra) # 5bbe <printf>
      exit(1);
    161e:	4505                	li	a0,1
    1620:	00004097          	auipc	ra,0x4
    1624:	224080e7          	jalr	548(ra) # 5844 <exit>
    if(exec("echo", echoargv) < 0){
    1628:	fc040593          	addi	a1,s0,-64
    162c:	00004517          	auipc	a0,0x4
    1630:	76c50513          	addi	a0,a0,1900 # 5d98 <malloc+0x122>
    1634:	00004097          	auipc	ra,0x4
    1638:	248080e7          	jalr	584(ra) # 587c <exec>
    163c:	02054163          	bltz	a0,165e <exectest+0xfc>
  if (wait(&xstatus) != pid) {
    1640:	fdc40513          	addi	a0,s0,-36
    1644:	00004097          	auipc	ra,0x4
    1648:	208080e7          	jalr	520(ra) # 584c <wait>
    164c:	02951763          	bne	a0,s1,167a <exectest+0x118>
  if(xstatus != 0)
    1650:	fdc42503          	lw	a0,-36(s0)
    1654:	cd0d                	beqz	a0,168e <exectest+0x12c>
    exit(xstatus);
    1656:	00004097          	auipc	ra,0x4
    165a:	1ee080e7          	jalr	494(ra) # 5844 <exit>
      printf("%s: exec echo failed\n", s);
    165e:	85ca                	mv	a1,s2
    1660:	00005517          	auipc	a0,0x5
    1664:	05050513          	addi	a0,a0,80 # 66b0 <malloc+0xa3a>
    1668:	00004097          	auipc	ra,0x4
    166c:	556080e7          	jalr	1366(ra) # 5bbe <printf>
      exit(1);
    1670:	4505                	li	a0,1
    1672:	00004097          	auipc	ra,0x4
    1676:	1d2080e7          	jalr	466(ra) # 5844 <exit>
    printf("%s: wait failed!\n", s);
    167a:	85ca                	mv	a1,s2
    167c:	00005517          	auipc	a0,0x5
    1680:	04c50513          	addi	a0,a0,76 # 66c8 <malloc+0xa52>
    1684:	00004097          	auipc	ra,0x4
    1688:	53a080e7          	jalr	1338(ra) # 5bbe <printf>
    168c:	b7d1                	j	1650 <exectest+0xee>
  fd = open("echo-ok", O_RDONLY);
    168e:	4581                	li	a1,0
    1690:	00005517          	auipc	a0,0x5
    1694:	ff050513          	addi	a0,a0,-16 # 6680 <malloc+0xa0a>
    1698:	00004097          	auipc	ra,0x4
    169c:	1ec080e7          	jalr	492(ra) # 5884 <open>
  if(fd < 0) {
    16a0:	02054a63          	bltz	a0,16d4 <exectest+0x172>
  if (read(fd, buf, 2) != 2) {
    16a4:	4609                	li	a2,2
    16a6:	fb840593          	addi	a1,s0,-72
    16aa:	00004097          	auipc	ra,0x4
    16ae:	1b2080e7          	jalr	434(ra) # 585c <read>
    16b2:	4789                	li	a5,2
    16b4:	02f50e63          	beq	a0,a5,16f0 <exectest+0x18e>
    printf("%s: read failed\n", s);
    16b8:	85ca                	mv	a1,s2
    16ba:	00005517          	auipc	a0,0x5
    16be:	a7e50513          	addi	a0,a0,-1410 # 6138 <malloc+0x4c2>
    16c2:	00004097          	auipc	ra,0x4
    16c6:	4fc080e7          	jalr	1276(ra) # 5bbe <printf>
    exit(1);
    16ca:	4505                	li	a0,1
    16cc:	00004097          	auipc	ra,0x4
    16d0:	178080e7          	jalr	376(ra) # 5844 <exit>
    printf("%s: open failed\n", s);
    16d4:	85ca                	mv	a1,s2
    16d6:	00005517          	auipc	a0,0x5
    16da:	f3250513          	addi	a0,a0,-206 # 6608 <malloc+0x992>
    16de:	00004097          	auipc	ra,0x4
    16e2:	4e0080e7          	jalr	1248(ra) # 5bbe <printf>
    exit(1);
    16e6:	4505                	li	a0,1
    16e8:	00004097          	auipc	ra,0x4
    16ec:	15c080e7          	jalr	348(ra) # 5844 <exit>
  unlink("echo-ok");
    16f0:	00005517          	auipc	a0,0x5
    16f4:	f9050513          	addi	a0,a0,-112 # 6680 <malloc+0xa0a>
    16f8:	00004097          	auipc	ra,0x4
    16fc:	19c080e7          	jalr	412(ra) # 5894 <unlink>
  if(buf[0] == 'O' && buf[1] == 'K')
    1700:	fb844703          	lbu	a4,-72(s0)
    1704:	04f00793          	li	a5,79
    1708:	00f71863          	bne	a4,a5,1718 <exectest+0x1b6>
    170c:	fb944703          	lbu	a4,-71(s0)
    1710:	04b00793          	li	a5,75
    1714:	02f70063          	beq	a4,a5,1734 <exectest+0x1d2>
    printf("%s: wrong output\n", s);
    1718:	85ca                	mv	a1,s2
    171a:	00005517          	auipc	a0,0x5
    171e:	fc650513          	addi	a0,a0,-58 # 66e0 <malloc+0xa6a>
    1722:	00004097          	auipc	ra,0x4
    1726:	49c080e7          	jalr	1180(ra) # 5bbe <printf>
    exit(1);
    172a:	4505                	li	a0,1
    172c:	00004097          	auipc	ra,0x4
    1730:	118080e7          	jalr	280(ra) # 5844 <exit>
    exit(0);
    1734:	4501                	li	a0,0
    1736:	00004097          	auipc	ra,0x4
    173a:	10e080e7          	jalr	270(ra) # 5844 <exit>

000000000000173e <pipe1>:
{
    173e:	711d                	addi	sp,sp,-96
    1740:	ec86                	sd	ra,88(sp)
    1742:	e8a2                	sd	s0,80(sp)
    1744:	e4a6                	sd	s1,72(sp)
    1746:	e0ca                	sd	s2,64(sp)
    1748:	fc4e                	sd	s3,56(sp)
    174a:	f852                	sd	s4,48(sp)
    174c:	f456                	sd	s5,40(sp)
    174e:	f05a                	sd	s6,32(sp)
    1750:	ec5e                	sd	s7,24(sp)
    1752:	1080                	addi	s0,sp,96
    1754:	892a                	mv	s2,a0
  if(pipe(fds) != 0){
    1756:	fa840513          	addi	a0,s0,-88
    175a:	00004097          	auipc	ra,0x4
    175e:	0fa080e7          	jalr	250(ra) # 5854 <pipe>
    1762:	e93d                	bnez	a0,17d8 <pipe1+0x9a>
    1764:	84aa                	mv	s1,a0
  pid = fork();
    1766:	00004097          	auipc	ra,0x4
    176a:	0d6080e7          	jalr	214(ra) # 583c <fork>
    176e:	8a2a                	mv	s4,a0
  if(pid == 0){
    1770:	c151                	beqz	a0,17f4 <pipe1+0xb6>
  } else if(pid > 0){
    1772:	16a05d63          	blez	a0,18ec <pipe1+0x1ae>
    close(fds[1]);
    1776:	fac42503          	lw	a0,-84(s0)
    177a:	00004097          	auipc	ra,0x4
    177e:	0f2080e7          	jalr	242(ra) # 586c <close>
    total = 0;
    1782:	8a26                	mv	s4,s1
    cc = 1;
    1784:	4985                	li	s3,1
    while((n = read(fds[0], buf, cc)) > 0){
    1786:	0000aa97          	auipc	s5,0xa
    178a:	652a8a93          	addi	s5,s5,1618 # bdd8 <buf>
      if(cc > sizeof(buf))
    178e:	6b0d                	lui	s6,0x3
    while((n = read(fds[0], buf, cc)) > 0){
    1790:	864e                	mv	a2,s3
    1792:	85d6                	mv	a1,s5
    1794:	fa842503          	lw	a0,-88(s0)
    1798:	00004097          	auipc	ra,0x4
    179c:	0c4080e7          	jalr	196(ra) # 585c <read>
    17a0:	10a05163          	blez	a0,18a2 <pipe1+0x164>
      for(i = 0; i < n; i++){
    17a4:	0000a717          	auipc	a4,0xa
    17a8:	63470713          	addi	a4,a4,1588 # bdd8 <buf>
    17ac:	00a4863b          	addw	a2,s1,a0
        if((buf[i] & 0xff) != (seq++ & 0xff)){
    17b0:	00074683          	lbu	a3,0(a4)
    17b4:	0ff4f793          	zext.b	a5,s1
    17b8:	2485                	addiw	s1,s1,1
    17ba:	0cf69063          	bne	a3,a5,187a <pipe1+0x13c>
      for(i = 0; i < n; i++){
    17be:	0705                	addi	a4,a4,1
    17c0:	fec498e3          	bne	s1,a2,17b0 <pipe1+0x72>
      total += n;
    17c4:	00aa0a3b          	addw	s4,s4,a0
      cc = cc * 2;
    17c8:	0019979b          	slliw	a5,s3,0x1
    17cc:	0007899b          	sext.w	s3,a5
      if(cc > sizeof(buf))
    17d0:	fd3b70e3          	bgeu	s6,s3,1790 <pipe1+0x52>
        cc = sizeof(buf);
    17d4:	89da                	mv	s3,s6
    17d6:	bf6d                	j	1790 <pipe1+0x52>
    printf("%s: pipe() failed\n", s);
    17d8:	85ca                	mv	a1,s2
    17da:	00005517          	auipc	a0,0x5
    17de:	f1e50513          	addi	a0,a0,-226 # 66f8 <malloc+0xa82>
    17e2:	00004097          	auipc	ra,0x4
    17e6:	3dc080e7          	jalr	988(ra) # 5bbe <printf>
    exit(1);
    17ea:	4505                	li	a0,1
    17ec:	00004097          	auipc	ra,0x4
    17f0:	058080e7          	jalr	88(ra) # 5844 <exit>
    close(fds[0]);
    17f4:	fa842503          	lw	a0,-88(s0)
    17f8:	00004097          	auipc	ra,0x4
    17fc:	074080e7          	jalr	116(ra) # 586c <close>
    for(n = 0; n < N; n++){
    1800:	0000ab17          	auipc	s6,0xa
    1804:	5d8b0b13          	addi	s6,s6,1496 # bdd8 <buf>
    1808:	416004bb          	negw	s1,s6
    180c:	0ff4f493          	zext.b	s1,s1
    1810:	409b0993          	addi	s3,s6,1033
      if(write(fds[1], buf, SZ) != SZ){
    1814:	8bda                	mv	s7,s6
    for(n = 0; n < N; n++){
    1816:	6a85                	lui	s5,0x1
    1818:	42da8a93          	addi	s5,s5,1069 # 142d <truncate3+0x85>
{
    181c:	87da                	mv	a5,s6
        buf[i] = seq++;
    181e:	0097873b          	addw	a4,a5,s1
    1822:	00e78023          	sb	a4,0(a5)
      for(i = 0; i < SZ; i++)
    1826:	0785                	addi	a5,a5,1
    1828:	fef99be3          	bne	s3,a5,181e <pipe1+0xe0>
        buf[i] = seq++;
    182c:	409a0a1b          	addiw	s4,s4,1033
      if(write(fds[1], buf, SZ) != SZ){
    1830:	40900613          	li	a2,1033
    1834:	85de                	mv	a1,s7
    1836:	fac42503          	lw	a0,-84(s0)
    183a:	00004097          	auipc	ra,0x4
    183e:	02a080e7          	jalr	42(ra) # 5864 <write>
    1842:	40900793          	li	a5,1033
    1846:	00f51c63          	bne	a0,a5,185e <pipe1+0x120>
    for(n = 0; n < N; n++){
    184a:	24a5                	addiw	s1,s1,9
    184c:	0ff4f493          	zext.b	s1,s1
    1850:	fd5a16e3          	bne	s4,s5,181c <pipe1+0xde>
    exit(0);
    1854:	4501                	li	a0,0
    1856:	00004097          	auipc	ra,0x4
    185a:	fee080e7          	jalr	-18(ra) # 5844 <exit>
        printf("%s: pipe1 oops 1\n", s);
    185e:	85ca                	mv	a1,s2
    1860:	00005517          	auipc	a0,0x5
    1864:	eb050513          	addi	a0,a0,-336 # 6710 <malloc+0xa9a>
    1868:	00004097          	auipc	ra,0x4
    186c:	356080e7          	jalr	854(ra) # 5bbe <printf>
        exit(1);
    1870:	4505                	li	a0,1
    1872:	00004097          	auipc	ra,0x4
    1876:	fd2080e7          	jalr	-46(ra) # 5844 <exit>
          printf("%s: pipe1 oops 2\n", s);
    187a:	85ca                	mv	a1,s2
    187c:	00005517          	auipc	a0,0x5
    1880:	eac50513          	addi	a0,a0,-340 # 6728 <malloc+0xab2>
    1884:	00004097          	auipc	ra,0x4
    1888:	33a080e7          	jalr	826(ra) # 5bbe <printf>
}
    188c:	60e6                	ld	ra,88(sp)
    188e:	6446                	ld	s0,80(sp)
    1890:	64a6                	ld	s1,72(sp)
    1892:	6906                	ld	s2,64(sp)
    1894:	79e2                	ld	s3,56(sp)
    1896:	7a42                	ld	s4,48(sp)
    1898:	7aa2                	ld	s5,40(sp)
    189a:	7b02                	ld	s6,32(sp)
    189c:	6be2                	ld	s7,24(sp)
    189e:	6125                	addi	sp,sp,96
    18a0:	8082                	ret
    if(total != N * SZ){
    18a2:	6785                	lui	a5,0x1
    18a4:	42d78793          	addi	a5,a5,1069 # 142d <truncate3+0x85>
    18a8:	02fa0063          	beq	s4,a5,18c8 <pipe1+0x18a>
      printf("%s: pipe1 oops 3 total %d\n", total);
    18ac:	85d2                	mv	a1,s4
    18ae:	00005517          	auipc	a0,0x5
    18b2:	e9250513          	addi	a0,a0,-366 # 6740 <malloc+0xaca>
    18b6:	00004097          	auipc	ra,0x4
    18ba:	308080e7          	jalr	776(ra) # 5bbe <printf>
      exit(1);
    18be:	4505                	li	a0,1
    18c0:	00004097          	auipc	ra,0x4
    18c4:	f84080e7          	jalr	-124(ra) # 5844 <exit>
    close(fds[0]);
    18c8:	fa842503          	lw	a0,-88(s0)
    18cc:	00004097          	auipc	ra,0x4
    18d0:	fa0080e7          	jalr	-96(ra) # 586c <close>
    wait(&xstatus);
    18d4:	fa440513          	addi	a0,s0,-92
    18d8:	00004097          	auipc	ra,0x4
    18dc:	f74080e7          	jalr	-140(ra) # 584c <wait>
    exit(xstatus);
    18e0:	fa442503          	lw	a0,-92(s0)
    18e4:	00004097          	auipc	ra,0x4
    18e8:	f60080e7          	jalr	-160(ra) # 5844 <exit>
    printf("%s: fork() failed\n", s);
    18ec:	85ca                	mv	a1,s2
    18ee:	00005517          	auipc	a0,0x5
    18f2:	e7250513          	addi	a0,a0,-398 # 6760 <malloc+0xaea>
    18f6:	00004097          	auipc	ra,0x4
    18fa:	2c8080e7          	jalr	712(ra) # 5bbe <printf>
    exit(1);
    18fe:	4505                	li	a0,1
    1900:	00004097          	auipc	ra,0x4
    1904:	f44080e7          	jalr	-188(ra) # 5844 <exit>

0000000000001908 <exitwait>:
{
    1908:	7139                	addi	sp,sp,-64
    190a:	fc06                	sd	ra,56(sp)
    190c:	f822                	sd	s0,48(sp)
    190e:	f426                	sd	s1,40(sp)
    1910:	f04a                	sd	s2,32(sp)
    1912:	ec4e                	sd	s3,24(sp)
    1914:	e852                	sd	s4,16(sp)
    1916:	0080                	addi	s0,sp,64
    1918:	8a2a                	mv	s4,a0
  for(i = 0; i < 100; i++){
    191a:	4901                	li	s2,0
    191c:	06400993          	li	s3,100
    pid = fork();
    1920:	00004097          	auipc	ra,0x4
    1924:	f1c080e7          	jalr	-228(ra) # 583c <fork>
    1928:	84aa                	mv	s1,a0
    if(pid < 0){
    192a:	02054a63          	bltz	a0,195e <exitwait+0x56>
    if(pid){
    192e:	c151                	beqz	a0,19b2 <exitwait+0xaa>
      if(wait(&xstate) != pid){
    1930:	fcc40513          	addi	a0,s0,-52
    1934:	00004097          	auipc	ra,0x4
    1938:	f18080e7          	jalr	-232(ra) # 584c <wait>
    193c:	02951f63          	bne	a0,s1,197a <exitwait+0x72>
      if(i != xstate) {
    1940:	fcc42783          	lw	a5,-52(s0)
    1944:	05279963          	bne	a5,s2,1996 <exitwait+0x8e>
  for(i = 0; i < 100; i++){
    1948:	2905                	addiw	s2,s2,1
    194a:	fd391be3          	bne	s2,s3,1920 <exitwait+0x18>
}
    194e:	70e2                	ld	ra,56(sp)
    1950:	7442                	ld	s0,48(sp)
    1952:	74a2                	ld	s1,40(sp)
    1954:	7902                	ld	s2,32(sp)
    1956:	69e2                	ld	s3,24(sp)
    1958:	6a42                	ld	s4,16(sp)
    195a:	6121                	addi	sp,sp,64
    195c:	8082                	ret
      printf("%s: fork failed\n", s);
    195e:	85d2                	mv	a1,s4
    1960:	00005517          	auipc	a0,0x5
    1964:	c9050513          	addi	a0,a0,-880 # 65f0 <malloc+0x97a>
    1968:	00004097          	auipc	ra,0x4
    196c:	256080e7          	jalr	598(ra) # 5bbe <printf>
      exit(1);
    1970:	4505                	li	a0,1
    1972:	00004097          	auipc	ra,0x4
    1976:	ed2080e7          	jalr	-302(ra) # 5844 <exit>
        printf("%s: wait wrong pid\n", s);
    197a:	85d2                	mv	a1,s4
    197c:	00005517          	auipc	a0,0x5
    1980:	dfc50513          	addi	a0,a0,-516 # 6778 <malloc+0xb02>
    1984:	00004097          	auipc	ra,0x4
    1988:	23a080e7          	jalr	570(ra) # 5bbe <printf>
        exit(1);
    198c:	4505                	li	a0,1
    198e:	00004097          	auipc	ra,0x4
    1992:	eb6080e7          	jalr	-330(ra) # 5844 <exit>
        printf("%s: wait wrong exit status\n", s);
    1996:	85d2                	mv	a1,s4
    1998:	00005517          	auipc	a0,0x5
    199c:	df850513          	addi	a0,a0,-520 # 6790 <malloc+0xb1a>
    19a0:	00004097          	auipc	ra,0x4
    19a4:	21e080e7          	jalr	542(ra) # 5bbe <printf>
        exit(1);
    19a8:	4505                	li	a0,1
    19aa:	00004097          	auipc	ra,0x4
    19ae:	e9a080e7          	jalr	-358(ra) # 5844 <exit>
      exit(i);
    19b2:	854a                	mv	a0,s2
    19b4:	00004097          	auipc	ra,0x4
    19b8:	e90080e7          	jalr	-368(ra) # 5844 <exit>

00000000000019bc <twochildren>:
{
    19bc:	1101                	addi	sp,sp,-32
    19be:	ec06                	sd	ra,24(sp)
    19c0:	e822                	sd	s0,16(sp)
    19c2:	e426                	sd	s1,8(sp)
    19c4:	e04a                	sd	s2,0(sp)
    19c6:	1000                	addi	s0,sp,32
    19c8:	892a                	mv	s2,a0
    19ca:	3e800493          	li	s1,1000
    int pid1 = fork();
    19ce:	00004097          	auipc	ra,0x4
    19d2:	e6e080e7          	jalr	-402(ra) # 583c <fork>
    if(pid1 < 0){
    19d6:	02054c63          	bltz	a0,1a0e <twochildren+0x52>
    if(pid1 == 0){
    19da:	c921                	beqz	a0,1a2a <twochildren+0x6e>
      int pid2 = fork();
    19dc:	00004097          	auipc	ra,0x4
    19e0:	e60080e7          	jalr	-416(ra) # 583c <fork>
      if(pid2 < 0){
    19e4:	04054763          	bltz	a0,1a32 <twochildren+0x76>
      if(pid2 == 0){
    19e8:	c13d                	beqz	a0,1a4e <twochildren+0x92>
        wait(0);
    19ea:	4501                	li	a0,0
    19ec:	00004097          	auipc	ra,0x4
    19f0:	e60080e7          	jalr	-416(ra) # 584c <wait>
        wait(0);
    19f4:	4501                	li	a0,0
    19f6:	00004097          	auipc	ra,0x4
    19fa:	e56080e7          	jalr	-426(ra) # 584c <wait>
  for(int i = 0; i < 1000; i++){
    19fe:	34fd                	addiw	s1,s1,-1
    1a00:	f4f9                	bnez	s1,19ce <twochildren+0x12>
}
    1a02:	60e2                	ld	ra,24(sp)
    1a04:	6442                	ld	s0,16(sp)
    1a06:	64a2                	ld	s1,8(sp)
    1a08:	6902                	ld	s2,0(sp)
    1a0a:	6105                	addi	sp,sp,32
    1a0c:	8082                	ret
      printf("%s: fork failed\n", s);
    1a0e:	85ca                	mv	a1,s2
    1a10:	00005517          	auipc	a0,0x5
    1a14:	be050513          	addi	a0,a0,-1056 # 65f0 <malloc+0x97a>
    1a18:	00004097          	auipc	ra,0x4
    1a1c:	1a6080e7          	jalr	422(ra) # 5bbe <printf>
      exit(1);
    1a20:	4505                	li	a0,1
    1a22:	00004097          	auipc	ra,0x4
    1a26:	e22080e7          	jalr	-478(ra) # 5844 <exit>
      exit(0);
    1a2a:	00004097          	auipc	ra,0x4
    1a2e:	e1a080e7          	jalr	-486(ra) # 5844 <exit>
        printf("%s: fork failed\n", s);
    1a32:	85ca                	mv	a1,s2
    1a34:	00005517          	auipc	a0,0x5
    1a38:	bbc50513          	addi	a0,a0,-1092 # 65f0 <malloc+0x97a>
    1a3c:	00004097          	auipc	ra,0x4
    1a40:	182080e7          	jalr	386(ra) # 5bbe <printf>
        exit(1);
    1a44:	4505                	li	a0,1
    1a46:	00004097          	auipc	ra,0x4
    1a4a:	dfe080e7          	jalr	-514(ra) # 5844 <exit>
        exit(0);
    1a4e:	00004097          	auipc	ra,0x4
    1a52:	df6080e7          	jalr	-522(ra) # 5844 <exit>

0000000000001a56 <forkfork>:
{
    1a56:	7179                	addi	sp,sp,-48
    1a58:	f406                	sd	ra,40(sp)
    1a5a:	f022                	sd	s0,32(sp)
    1a5c:	ec26                	sd	s1,24(sp)
    1a5e:	1800                	addi	s0,sp,48
    1a60:	84aa                	mv	s1,a0
    int pid = fork();
    1a62:	00004097          	auipc	ra,0x4
    1a66:	dda080e7          	jalr	-550(ra) # 583c <fork>
    if(pid < 0){
    1a6a:	04054163          	bltz	a0,1aac <forkfork+0x56>
    if(pid == 0){
    1a6e:	cd29                	beqz	a0,1ac8 <forkfork+0x72>
    int pid = fork();
    1a70:	00004097          	auipc	ra,0x4
    1a74:	dcc080e7          	jalr	-564(ra) # 583c <fork>
    if(pid < 0){
    1a78:	02054a63          	bltz	a0,1aac <forkfork+0x56>
    if(pid == 0){
    1a7c:	c531                	beqz	a0,1ac8 <forkfork+0x72>
    wait(&xstatus);
    1a7e:	fdc40513          	addi	a0,s0,-36
    1a82:	00004097          	auipc	ra,0x4
    1a86:	dca080e7          	jalr	-566(ra) # 584c <wait>
    if(xstatus != 0) {
    1a8a:	fdc42783          	lw	a5,-36(s0)
    1a8e:	ebbd                	bnez	a5,1b04 <forkfork+0xae>
    wait(&xstatus);
    1a90:	fdc40513          	addi	a0,s0,-36
    1a94:	00004097          	auipc	ra,0x4
    1a98:	db8080e7          	jalr	-584(ra) # 584c <wait>
    if(xstatus != 0) {
    1a9c:	fdc42783          	lw	a5,-36(s0)
    1aa0:	e3b5                	bnez	a5,1b04 <forkfork+0xae>
}
    1aa2:	70a2                	ld	ra,40(sp)
    1aa4:	7402                	ld	s0,32(sp)
    1aa6:	64e2                	ld	s1,24(sp)
    1aa8:	6145                	addi	sp,sp,48
    1aaa:	8082                	ret
      printf("%s: fork failed", s);
    1aac:	85a6                	mv	a1,s1
    1aae:	00005517          	auipc	a0,0x5
    1ab2:	d0250513          	addi	a0,a0,-766 # 67b0 <malloc+0xb3a>
    1ab6:	00004097          	auipc	ra,0x4
    1aba:	108080e7          	jalr	264(ra) # 5bbe <printf>
      exit(1);
    1abe:	4505                	li	a0,1
    1ac0:	00004097          	auipc	ra,0x4
    1ac4:	d84080e7          	jalr	-636(ra) # 5844 <exit>
{
    1ac8:	0c800493          	li	s1,200
        int pid1 = fork();
    1acc:	00004097          	auipc	ra,0x4
    1ad0:	d70080e7          	jalr	-656(ra) # 583c <fork>
        if(pid1 < 0){
    1ad4:	00054f63          	bltz	a0,1af2 <forkfork+0x9c>
        if(pid1 == 0){
    1ad8:	c115                	beqz	a0,1afc <forkfork+0xa6>
        wait(0);
    1ada:	4501                	li	a0,0
    1adc:	00004097          	auipc	ra,0x4
    1ae0:	d70080e7          	jalr	-656(ra) # 584c <wait>
      for(int j = 0; j < 200; j++){
    1ae4:	34fd                	addiw	s1,s1,-1
    1ae6:	f0fd                	bnez	s1,1acc <forkfork+0x76>
      exit(0);
    1ae8:	4501                	li	a0,0
    1aea:	00004097          	auipc	ra,0x4
    1aee:	d5a080e7          	jalr	-678(ra) # 5844 <exit>
          exit(1);
    1af2:	4505                	li	a0,1
    1af4:	00004097          	auipc	ra,0x4
    1af8:	d50080e7          	jalr	-688(ra) # 5844 <exit>
          exit(0);
    1afc:	00004097          	auipc	ra,0x4
    1b00:	d48080e7          	jalr	-696(ra) # 5844 <exit>
      printf("%s: fork in child failed", s);
    1b04:	85a6                	mv	a1,s1
    1b06:	00005517          	auipc	a0,0x5
    1b0a:	cba50513          	addi	a0,a0,-838 # 67c0 <malloc+0xb4a>
    1b0e:	00004097          	auipc	ra,0x4
    1b12:	0b0080e7          	jalr	176(ra) # 5bbe <printf>
      exit(1);
    1b16:	4505                	li	a0,1
    1b18:	00004097          	auipc	ra,0x4
    1b1c:	d2c080e7          	jalr	-724(ra) # 5844 <exit>

0000000000001b20 <reparent2>:
{
    1b20:	1101                	addi	sp,sp,-32
    1b22:	ec06                	sd	ra,24(sp)
    1b24:	e822                	sd	s0,16(sp)
    1b26:	e426                	sd	s1,8(sp)
    1b28:	1000                	addi	s0,sp,32
    1b2a:	32000493          	li	s1,800
    int pid1 = fork();
    1b2e:	00004097          	auipc	ra,0x4
    1b32:	d0e080e7          	jalr	-754(ra) # 583c <fork>
    if(pid1 < 0){
    1b36:	00054f63          	bltz	a0,1b54 <reparent2+0x34>
    if(pid1 == 0){
    1b3a:	c915                	beqz	a0,1b6e <reparent2+0x4e>
    wait(0);
    1b3c:	4501                	li	a0,0
    1b3e:	00004097          	auipc	ra,0x4
    1b42:	d0e080e7          	jalr	-754(ra) # 584c <wait>
  for(int i = 0; i < 800; i++){
    1b46:	34fd                	addiw	s1,s1,-1
    1b48:	f0fd                	bnez	s1,1b2e <reparent2+0xe>
  exit(0);
    1b4a:	4501                	li	a0,0
    1b4c:	00004097          	auipc	ra,0x4
    1b50:	cf8080e7          	jalr	-776(ra) # 5844 <exit>
      printf("fork failed\n");
    1b54:	00005517          	auipc	a0,0x5
    1b58:	ebc50513          	addi	a0,a0,-324 # 6a10 <malloc+0xd9a>
    1b5c:	00004097          	auipc	ra,0x4
    1b60:	062080e7          	jalr	98(ra) # 5bbe <printf>
      exit(1);
    1b64:	4505                	li	a0,1
    1b66:	00004097          	auipc	ra,0x4
    1b6a:	cde080e7          	jalr	-802(ra) # 5844 <exit>
      fork();
    1b6e:	00004097          	auipc	ra,0x4
    1b72:	cce080e7          	jalr	-818(ra) # 583c <fork>
      fork();
    1b76:	00004097          	auipc	ra,0x4
    1b7a:	cc6080e7          	jalr	-826(ra) # 583c <fork>
      exit(0);
    1b7e:	4501                	li	a0,0
    1b80:	00004097          	auipc	ra,0x4
    1b84:	cc4080e7          	jalr	-828(ra) # 5844 <exit>

0000000000001b88 <createdelete>:
{
    1b88:	7175                	addi	sp,sp,-144
    1b8a:	e506                	sd	ra,136(sp)
    1b8c:	e122                	sd	s0,128(sp)
    1b8e:	fca6                	sd	s1,120(sp)
    1b90:	f8ca                	sd	s2,112(sp)
    1b92:	f4ce                	sd	s3,104(sp)
    1b94:	f0d2                	sd	s4,96(sp)
    1b96:	ecd6                	sd	s5,88(sp)
    1b98:	e8da                	sd	s6,80(sp)
    1b9a:	e4de                	sd	s7,72(sp)
    1b9c:	e0e2                	sd	s8,64(sp)
    1b9e:	fc66                	sd	s9,56(sp)
    1ba0:	0900                	addi	s0,sp,144
    1ba2:	8caa                	mv	s9,a0
  for(pi = 0; pi < NCHILD; pi++){
    1ba4:	4901                	li	s2,0
    1ba6:	4991                	li	s3,4
    pid = fork();
    1ba8:	00004097          	auipc	ra,0x4
    1bac:	c94080e7          	jalr	-876(ra) # 583c <fork>
    1bb0:	84aa                	mv	s1,a0
    if(pid < 0){
    1bb2:	02054f63          	bltz	a0,1bf0 <createdelete+0x68>
    if(pid == 0){
    1bb6:	c939                	beqz	a0,1c0c <createdelete+0x84>
  for(pi = 0; pi < NCHILD; pi++){
    1bb8:	2905                	addiw	s2,s2,1
    1bba:	ff3917e3          	bne	s2,s3,1ba8 <createdelete+0x20>
    1bbe:	4491                	li	s1,4
    wait(&xstatus);
    1bc0:	f7c40513          	addi	a0,s0,-132
    1bc4:	00004097          	auipc	ra,0x4
    1bc8:	c88080e7          	jalr	-888(ra) # 584c <wait>
    if(xstatus != 0)
    1bcc:	f7c42903          	lw	s2,-132(s0)
    1bd0:	0e091263          	bnez	s2,1cb4 <createdelete+0x12c>
  for(pi = 0; pi < NCHILD; pi++){
    1bd4:	34fd                	addiw	s1,s1,-1
    1bd6:	f4ed                	bnez	s1,1bc0 <createdelete+0x38>
  name[0] = name[1] = name[2] = 0;
    1bd8:	f8040123          	sb	zero,-126(s0)
    1bdc:	03000993          	li	s3,48
    1be0:	5a7d                	li	s4,-1
    1be2:	07000c13          	li	s8,112
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1be6:	4b21                	li	s6,8
      if((i == 0 || i >= N/2) && fd < 0){
    1be8:	4ba5                	li	s7,9
    for(pi = 0; pi < NCHILD; pi++){
    1bea:	07400a93          	li	s5,116
    1bee:	a29d                	j	1d54 <createdelete+0x1cc>
      printf("fork failed\n", s);
    1bf0:	85e6                	mv	a1,s9
    1bf2:	00005517          	auipc	a0,0x5
    1bf6:	e1e50513          	addi	a0,a0,-482 # 6a10 <malloc+0xd9a>
    1bfa:	00004097          	auipc	ra,0x4
    1bfe:	fc4080e7          	jalr	-60(ra) # 5bbe <printf>
      exit(1);
    1c02:	4505                	li	a0,1
    1c04:	00004097          	auipc	ra,0x4
    1c08:	c40080e7          	jalr	-960(ra) # 5844 <exit>
      name[0] = 'p' + pi;
    1c0c:	0709091b          	addiw	s2,s2,112
    1c10:	f9240023          	sb	s2,-128(s0)
      name[2] = '\0';
    1c14:	f8040123          	sb	zero,-126(s0)
      for(i = 0; i < N; i++){
    1c18:	4951                	li	s2,20
    1c1a:	a015                	j	1c3e <createdelete+0xb6>
          printf("%s: create failed\n", s);
    1c1c:	85e6                	mv	a1,s9
    1c1e:	00005517          	auipc	a0,0x5
    1c22:	a6a50513          	addi	a0,a0,-1430 # 6688 <malloc+0xa12>
    1c26:	00004097          	auipc	ra,0x4
    1c2a:	f98080e7          	jalr	-104(ra) # 5bbe <printf>
          exit(1);
    1c2e:	4505                	li	a0,1
    1c30:	00004097          	auipc	ra,0x4
    1c34:	c14080e7          	jalr	-1004(ra) # 5844 <exit>
      for(i = 0; i < N; i++){
    1c38:	2485                	addiw	s1,s1,1
    1c3a:	07248863          	beq	s1,s2,1caa <createdelete+0x122>
        name[1] = '0' + i;
    1c3e:	0304879b          	addiw	a5,s1,48
    1c42:	f8f400a3          	sb	a5,-127(s0)
        fd = open(name, O_CREATE | O_RDWR);
    1c46:	20200593          	li	a1,514
    1c4a:	f8040513          	addi	a0,s0,-128
    1c4e:	00004097          	auipc	ra,0x4
    1c52:	c36080e7          	jalr	-970(ra) # 5884 <open>
        if(fd < 0){
    1c56:	fc0543e3          	bltz	a0,1c1c <createdelete+0x94>
        close(fd);
    1c5a:	00004097          	auipc	ra,0x4
    1c5e:	c12080e7          	jalr	-1006(ra) # 586c <close>
        if(i > 0 && (i % 2 ) == 0){
    1c62:	fc905be3          	blez	s1,1c38 <createdelete+0xb0>
    1c66:	0014f793          	andi	a5,s1,1
    1c6a:	f7f9                	bnez	a5,1c38 <createdelete+0xb0>
          name[1] = '0' + (i / 2);
    1c6c:	01f4d79b          	srliw	a5,s1,0x1f
    1c70:	9fa5                	addw	a5,a5,s1
    1c72:	4017d79b          	sraiw	a5,a5,0x1
    1c76:	0307879b          	addiw	a5,a5,48
    1c7a:	f8f400a3          	sb	a5,-127(s0)
          if(unlink(name) < 0){
    1c7e:	f8040513          	addi	a0,s0,-128
    1c82:	00004097          	auipc	ra,0x4
    1c86:	c12080e7          	jalr	-1006(ra) # 5894 <unlink>
    1c8a:	fa0557e3          	bgez	a0,1c38 <createdelete+0xb0>
            printf("%s: unlink failed\n", s);
    1c8e:	85e6                	mv	a1,s9
    1c90:	00005517          	auipc	a0,0x5
    1c94:	b5050513          	addi	a0,a0,-1200 # 67e0 <malloc+0xb6a>
    1c98:	00004097          	auipc	ra,0x4
    1c9c:	f26080e7          	jalr	-218(ra) # 5bbe <printf>
            exit(1);
    1ca0:	4505                	li	a0,1
    1ca2:	00004097          	auipc	ra,0x4
    1ca6:	ba2080e7          	jalr	-1118(ra) # 5844 <exit>
      exit(0);
    1caa:	4501                	li	a0,0
    1cac:	00004097          	auipc	ra,0x4
    1cb0:	b98080e7          	jalr	-1128(ra) # 5844 <exit>
      exit(1);
    1cb4:	4505                	li	a0,1
    1cb6:	00004097          	auipc	ra,0x4
    1cba:	b8e080e7          	jalr	-1138(ra) # 5844 <exit>
        printf("%s: oops createdelete %s didn't exist\n", s, name);
    1cbe:	f8040613          	addi	a2,s0,-128
    1cc2:	85e6                	mv	a1,s9
    1cc4:	00005517          	auipc	a0,0x5
    1cc8:	b3450513          	addi	a0,a0,-1228 # 67f8 <malloc+0xb82>
    1ccc:	00004097          	auipc	ra,0x4
    1cd0:	ef2080e7          	jalr	-270(ra) # 5bbe <printf>
        exit(1);
    1cd4:	4505                	li	a0,1
    1cd6:	00004097          	auipc	ra,0x4
    1cda:	b6e080e7          	jalr	-1170(ra) # 5844 <exit>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1cde:	054b7163          	bgeu	s6,s4,1d20 <createdelete+0x198>
      if(fd >= 0)
    1ce2:	02055a63          	bgez	a0,1d16 <createdelete+0x18e>
    for(pi = 0; pi < NCHILD; pi++){
    1ce6:	2485                	addiw	s1,s1,1
    1ce8:	0ff4f493          	zext.b	s1,s1
    1cec:	05548c63          	beq	s1,s5,1d44 <createdelete+0x1bc>
      name[0] = 'p' + pi;
    1cf0:	f8940023          	sb	s1,-128(s0)
      name[1] = '0' + i;
    1cf4:	f93400a3          	sb	s3,-127(s0)
      fd = open(name, 0);
    1cf8:	4581                	li	a1,0
    1cfa:	f8040513          	addi	a0,s0,-128
    1cfe:	00004097          	auipc	ra,0x4
    1d02:	b86080e7          	jalr	-1146(ra) # 5884 <open>
      if((i == 0 || i >= N/2) && fd < 0){
    1d06:	00090463          	beqz	s2,1d0e <createdelete+0x186>
    1d0a:	fd2bdae3          	bge	s7,s2,1cde <createdelete+0x156>
    1d0e:	fa0548e3          	bltz	a0,1cbe <createdelete+0x136>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d12:	014b7963          	bgeu	s6,s4,1d24 <createdelete+0x19c>
        close(fd);
    1d16:	00004097          	auipc	ra,0x4
    1d1a:	b56080e7          	jalr	-1194(ra) # 586c <close>
    1d1e:	b7e1                	j	1ce6 <createdelete+0x15e>
      } else if((i >= 1 && i < N/2) && fd >= 0){
    1d20:	fc0543e3          	bltz	a0,1ce6 <createdelete+0x15e>
        printf("%s: oops createdelete %s did exist\n", s, name);
    1d24:	f8040613          	addi	a2,s0,-128
    1d28:	85e6                	mv	a1,s9
    1d2a:	00005517          	auipc	a0,0x5
    1d2e:	af650513          	addi	a0,a0,-1290 # 6820 <malloc+0xbaa>
    1d32:	00004097          	auipc	ra,0x4
    1d36:	e8c080e7          	jalr	-372(ra) # 5bbe <printf>
        exit(1);
    1d3a:	4505                	li	a0,1
    1d3c:	00004097          	auipc	ra,0x4
    1d40:	b08080e7          	jalr	-1272(ra) # 5844 <exit>
  for(i = 0; i < N; i++){
    1d44:	2905                	addiw	s2,s2,1
    1d46:	2a05                	addiw	s4,s4,1
    1d48:	2985                	addiw	s3,s3,1
    1d4a:	0ff9f993          	zext.b	s3,s3
    1d4e:	47d1                	li	a5,20
    1d50:	02f90a63          	beq	s2,a5,1d84 <createdelete+0x1fc>
    for(pi = 0; pi < NCHILD; pi++){
    1d54:	84e2                	mv	s1,s8
    1d56:	bf69                	j	1cf0 <createdelete+0x168>
  for(i = 0; i < N; i++){
    1d58:	2905                	addiw	s2,s2,1
    1d5a:	0ff97913          	zext.b	s2,s2
    1d5e:	2985                	addiw	s3,s3,1
    1d60:	0ff9f993          	zext.b	s3,s3
    1d64:	03490863          	beq	s2,s4,1d94 <createdelete+0x20c>
  name[0] = name[1] = name[2] = 0;
    1d68:	84d6                	mv	s1,s5
      name[0] = 'p' + i;
    1d6a:	f9240023          	sb	s2,-128(s0)
      name[1] = '0' + i;
    1d6e:	f93400a3          	sb	s3,-127(s0)
      unlink(name);
    1d72:	f8040513          	addi	a0,s0,-128
    1d76:	00004097          	auipc	ra,0x4
    1d7a:	b1e080e7          	jalr	-1250(ra) # 5894 <unlink>
    for(pi = 0; pi < NCHILD; pi++){
    1d7e:	34fd                	addiw	s1,s1,-1
    1d80:	f4ed                	bnez	s1,1d6a <createdelete+0x1e2>
    1d82:	bfd9                	j	1d58 <createdelete+0x1d0>
    1d84:	03000993          	li	s3,48
    1d88:	07000913          	li	s2,112
  name[0] = name[1] = name[2] = 0;
    1d8c:	4a91                	li	s5,4
  for(i = 0; i < N; i++){
    1d8e:	08400a13          	li	s4,132
    1d92:	bfd9                	j	1d68 <createdelete+0x1e0>
}
    1d94:	60aa                	ld	ra,136(sp)
    1d96:	640a                	ld	s0,128(sp)
    1d98:	74e6                	ld	s1,120(sp)
    1d9a:	7946                	ld	s2,112(sp)
    1d9c:	79a6                	ld	s3,104(sp)
    1d9e:	7a06                	ld	s4,96(sp)
    1da0:	6ae6                	ld	s5,88(sp)
    1da2:	6b46                	ld	s6,80(sp)
    1da4:	6ba6                	ld	s7,72(sp)
    1da6:	6c06                	ld	s8,64(sp)
    1da8:	7ce2                	ld	s9,56(sp)
    1daa:	6149                	addi	sp,sp,144
    1dac:	8082                	ret

0000000000001dae <linkunlink>:
{
    1dae:	711d                	addi	sp,sp,-96
    1db0:	ec86                	sd	ra,88(sp)
    1db2:	e8a2                	sd	s0,80(sp)
    1db4:	e4a6                	sd	s1,72(sp)
    1db6:	e0ca                	sd	s2,64(sp)
    1db8:	fc4e                	sd	s3,56(sp)
    1dba:	f852                	sd	s4,48(sp)
    1dbc:	f456                	sd	s5,40(sp)
    1dbe:	f05a                	sd	s6,32(sp)
    1dc0:	ec5e                	sd	s7,24(sp)
    1dc2:	e862                	sd	s8,16(sp)
    1dc4:	e466                	sd	s9,8(sp)
    1dc6:	1080                	addi	s0,sp,96
    1dc8:	84aa                	mv	s1,a0
  unlink("x");
    1dca:	00004517          	auipc	a0,0x4
    1dce:	03e50513          	addi	a0,a0,62 # 5e08 <malloc+0x192>
    1dd2:	00004097          	auipc	ra,0x4
    1dd6:	ac2080e7          	jalr	-1342(ra) # 5894 <unlink>
  pid = fork();
    1dda:	00004097          	auipc	ra,0x4
    1dde:	a62080e7          	jalr	-1438(ra) # 583c <fork>
  if(pid < 0){
    1de2:	02054b63          	bltz	a0,1e18 <linkunlink+0x6a>
    1de6:	8c2a                	mv	s8,a0
  unsigned int x = (pid ? 1 : 97);
    1de8:	4c85                	li	s9,1
    1dea:	e119                	bnez	a0,1df0 <linkunlink+0x42>
    1dec:	06100c93          	li	s9,97
    1df0:	06400493          	li	s1,100
    x = x * 1103515245 + 12345;
    1df4:	41c659b7          	lui	s3,0x41c65
    1df8:	e6d9899b          	addiw	s3,s3,-403 # 41c64e6d <__BSS_END__+0x41c56085>
    1dfc:	690d                	lui	s2,0x3
    1dfe:	0399091b          	addiw	s2,s2,57 # 3039 <iputtest+0xc3>
    if((x % 3) == 0){
    1e02:	4a0d                	li	s4,3
    } else if((x % 3) == 1){
    1e04:	4b05                	li	s6,1
      unlink("x");
    1e06:	00004a97          	auipc	s5,0x4
    1e0a:	002a8a93          	addi	s5,s5,2 # 5e08 <malloc+0x192>
      link("cat", "x");
    1e0e:	00005b97          	auipc	s7,0x5
    1e12:	a3ab8b93          	addi	s7,s7,-1478 # 6848 <malloc+0xbd2>
    1e16:	a825                	j	1e4e <linkunlink+0xa0>
    printf("%s: fork failed\n", s);
    1e18:	85a6                	mv	a1,s1
    1e1a:	00004517          	auipc	a0,0x4
    1e1e:	7d650513          	addi	a0,a0,2006 # 65f0 <malloc+0x97a>
    1e22:	00004097          	auipc	ra,0x4
    1e26:	d9c080e7          	jalr	-612(ra) # 5bbe <printf>
    exit(1);
    1e2a:	4505                	li	a0,1
    1e2c:	00004097          	auipc	ra,0x4
    1e30:	a18080e7          	jalr	-1512(ra) # 5844 <exit>
      close(open("x", O_RDWR | O_CREATE));
    1e34:	20200593          	li	a1,514
    1e38:	8556                	mv	a0,s5
    1e3a:	00004097          	auipc	ra,0x4
    1e3e:	a4a080e7          	jalr	-1462(ra) # 5884 <open>
    1e42:	00004097          	auipc	ra,0x4
    1e46:	a2a080e7          	jalr	-1494(ra) # 586c <close>
  for(i = 0; i < 100; i++){
    1e4a:	34fd                	addiw	s1,s1,-1
    1e4c:	c88d                	beqz	s1,1e7e <linkunlink+0xd0>
    x = x * 1103515245 + 12345;
    1e4e:	033c87bb          	mulw	a5,s9,s3
    1e52:	012787bb          	addw	a5,a5,s2
    1e56:	00078c9b          	sext.w	s9,a5
    if((x % 3) == 0){
    1e5a:	0347f7bb          	remuw	a5,a5,s4
    1e5e:	dbf9                	beqz	a5,1e34 <linkunlink+0x86>
    } else if((x % 3) == 1){
    1e60:	01678863          	beq	a5,s6,1e70 <linkunlink+0xc2>
      unlink("x");
    1e64:	8556                	mv	a0,s5
    1e66:	00004097          	auipc	ra,0x4
    1e6a:	a2e080e7          	jalr	-1490(ra) # 5894 <unlink>
    1e6e:	bff1                	j	1e4a <linkunlink+0x9c>
      link("cat", "x");
    1e70:	85d6                	mv	a1,s5
    1e72:	855e                	mv	a0,s7
    1e74:	00004097          	auipc	ra,0x4
    1e78:	a30080e7          	jalr	-1488(ra) # 58a4 <link>
    1e7c:	b7f9                	j	1e4a <linkunlink+0x9c>
  if(pid)
    1e7e:	020c0463          	beqz	s8,1ea6 <linkunlink+0xf8>
    wait(0);
    1e82:	4501                	li	a0,0
    1e84:	00004097          	auipc	ra,0x4
    1e88:	9c8080e7          	jalr	-1592(ra) # 584c <wait>
}
    1e8c:	60e6                	ld	ra,88(sp)
    1e8e:	6446                	ld	s0,80(sp)
    1e90:	64a6                	ld	s1,72(sp)
    1e92:	6906                	ld	s2,64(sp)
    1e94:	79e2                	ld	s3,56(sp)
    1e96:	7a42                	ld	s4,48(sp)
    1e98:	7aa2                	ld	s5,40(sp)
    1e9a:	7b02                	ld	s6,32(sp)
    1e9c:	6be2                	ld	s7,24(sp)
    1e9e:	6c42                	ld	s8,16(sp)
    1ea0:	6ca2                	ld	s9,8(sp)
    1ea2:	6125                	addi	sp,sp,96
    1ea4:	8082                	ret
    exit(0);
    1ea6:	4501                	li	a0,0
    1ea8:	00004097          	auipc	ra,0x4
    1eac:	99c080e7          	jalr	-1636(ra) # 5844 <exit>

0000000000001eb0 <manywrites>:
{
    1eb0:	711d                	addi	sp,sp,-96
    1eb2:	ec86                	sd	ra,88(sp)
    1eb4:	e8a2                	sd	s0,80(sp)
    1eb6:	e4a6                	sd	s1,72(sp)
    1eb8:	e0ca                	sd	s2,64(sp)
    1eba:	fc4e                	sd	s3,56(sp)
    1ebc:	f852                	sd	s4,48(sp)
    1ebe:	f456                	sd	s5,40(sp)
    1ec0:	f05a                	sd	s6,32(sp)
    1ec2:	ec5e                	sd	s7,24(sp)
    1ec4:	1080                	addi	s0,sp,96
    1ec6:	8aaa                	mv	s5,a0
  for(int ci = 0; ci < nchildren; ci++){
    1ec8:	4981                	li	s3,0
    1eca:	4911                	li	s2,4
    int pid = fork();
    1ecc:	00004097          	auipc	ra,0x4
    1ed0:	970080e7          	jalr	-1680(ra) # 583c <fork>
    1ed4:	84aa                	mv	s1,a0
    if(pid < 0){
    1ed6:	02054963          	bltz	a0,1f08 <manywrites+0x58>
    if(pid == 0){
    1eda:	c521                	beqz	a0,1f22 <manywrites+0x72>
  for(int ci = 0; ci < nchildren; ci++){
    1edc:	2985                	addiw	s3,s3,1
    1ede:	ff2997e3          	bne	s3,s2,1ecc <manywrites+0x1c>
    1ee2:	4491                	li	s1,4
    int st = 0;
    1ee4:	fa042423          	sw	zero,-88(s0)
    wait(&st);
    1ee8:	fa840513          	addi	a0,s0,-88
    1eec:	00004097          	auipc	ra,0x4
    1ef0:	960080e7          	jalr	-1696(ra) # 584c <wait>
    if(st != 0)
    1ef4:	fa842503          	lw	a0,-88(s0)
    1ef8:	ed6d                	bnez	a0,1ff2 <manywrites+0x142>
  for(int ci = 0; ci < nchildren; ci++){
    1efa:	34fd                	addiw	s1,s1,-1
    1efc:	f4e5                	bnez	s1,1ee4 <manywrites+0x34>
  exit(0);
    1efe:	4501                	li	a0,0
    1f00:	00004097          	auipc	ra,0x4
    1f04:	944080e7          	jalr	-1724(ra) # 5844 <exit>
      printf("fork failed\n");
    1f08:	00005517          	auipc	a0,0x5
    1f0c:	b0850513          	addi	a0,a0,-1272 # 6a10 <malloc+0xd9a>
    1f10:	00004097          	auipc	ra,0x4
    1f14:	cae080e7          	jalr	-850(ra) # 5bbe <printf>
      exit(1);
    1f18:	4505                	li	a0,1
    1f1a:	00004097          	auipc	ra,0x4
    1f1e:	92a080e7          	jalr	-1750(ra) # 5844 <exit>
      name[0] = 'b';
    1f22:	06200793          	li	a5,98
    1f26:	faf40423          	sb	a5,-88(s0)
      name[1] = 'a' + ci;
    1f2a:	0619879b          	addiw	a5,s3,97
    1f2e:	faf404a3          	sb	a5,-87(s0)
      name[2] = '\0';
    1f32:	fa040523          	sb	zero,-86(s0)
      unlink(name);
    1f36:	fa840513          	addi	a0,s0,-88
    1f3a:	00004097          	auipc	ra,0x4
    1f3e:	95a080e7          	jalr	-1702(ra) # 5894 <unlink>
    1f42:	4bf9                	li	s7,30
          int cc = write(fd, buf, sz);
    1f44:	0000ab17          	auipc	s6,0xa
    1f48:	e94b0b13          	addi	s6,s6,-364 # bdd8 <buf>
        for(int i = 0; i < ci+1; i++){
    1f4c:	8a26                	mv	s4,s1
    1f4e:	0209ce63          	bltz	s3,1f8a <manywrites+0xda>
          int fd = open(name, O_CREATE | O_RDWR);
    1f52:	20200593          	li	a1,514
    1f56:	fa840513          	addi	a0,s0,-88
    1f5a:	00004097          	auipc	ra,0x4
    1f5e:	92a080e7          	jalr	-1750(ra) # 5884 <open>
    1f62:	892a                	mv	s2,a0
          if(fd < 0){
    1f64:	04054763          	bltz	a0,1fb2 <manywrites+0x102>
          int cc = write(fd, buf, sz);
    1f68:	660d                	lui	a2,0x3
    1f6a:	85da                	mv	a1,s6
    1f6c:	00004097          	auipc	ra,0x4
    1f70:	8f8080e7          	jalr	-1800(ra) # 5864 <write>
          if(cc != sz){
    1f74:	678d                	lui	a5,0x3
    1f76:	04f51e63          	bne	a0,a5,1fd2 <manywrites+0x122>
          close(fd);
    1f7a:	854a                	mv	a0,s2
    1f7c:	00004097          	auipc	ra,0x4
    1f80:	8f0080e7          	jalr	-1808(ra) # 586c <close>
        for(int i = 0; i < ci+1; i++){
    1f84:	2a05                	addiw	s4,s4,1
    1f86:	fd49d6e3          	bge	s3,s4,1f52 <manywrites+0xa2>
        unlink(name);
    1f8a:	fa840513          	addi	a0,s0,-88
    1f8e:	00004097          	auipc	ra,0x4
    1f92:	906080e7          	jalr	-1786(ra) # 5894 <unlink>
      for(int iters = 0; iters < howmany; iters++){
    1f96:	3bfd                	addiw	s7,s7,-1
    1f98:	fa0b9ae3          	bnez	s7,1f4c <manywrites+0x9c>
      unlink(name);
    1f9c:	fa840513          	addi	a0,s0,-88
    1fa0:	00004097          	auipc	ra,0x4
    1fa4:	8f4080e7          	jalr	-1804(ra) # 5894 <unlink>
      exit(0);
    1fa8:	4501                	li	a0,0
    1faa:	00004097          	auipc	ra,0x4
    1fae:	89a080e7          	jalr	-1894(ra) # 5844 <exit>
            printf("%s: cannot create %s\n", s, name);
    1fb2:	fa840613          	addi	a2,s0,-88
    1fb6:	85d6                	mv	a1,s5
    1fb8:	00005517          	auipc	a0,0x5
    1fbc:	89850513          	addi	a0,a0,-1896 # 6850 <malloc+0xbda>
    1fc0:	00004097          	auipc	ra,0x4
    1fc4:	bfe080e7          	jalr	-1026(ra) # 5bbe <printf>
            exit(1);
    1fc8:	4505                	li	a0,1
    1fca:	00004097          	auipc	ra,0x4
    1fce:	87a080e7          	jalr	-1926(ra) # 5844 <exit>
            printf("%s: write(%d) ret %d\n", s, sz, cc);
    1fd2:	86aa                	mv	a3,a0
    1fd4:	660d                	lui	a2,0x3
    1fd6:	85d6                	mv	a1,s5
    1fd8:	00004517          	auipc	a0,0x4
    1fdc:	e9050513          	addi	a0,a0,-368 # 5e68 <malloc+0x1f2>
    1fe0:	00004097          	auipc	ra,0x4
    1fe4:	bde080e7          	jalr	-1058(ra) # 5bbe <printf>
            exit(1);
    1fe8:	4505                	li	a0,1
    1fea:	00004097          	auipc	ra,0x4
    1fee:	85a080e7          	jalr	-1958(ra) # 5844 <exit>
      exit(st);
    1ff2:	00004097          	auipc	ra,0x4
    1ff6:	852080e7          	jalr	-1966(ra) # 5844 <exit>

0000000000001ffa <forktest>:
{
    1ffa:	7179                	addi	sp,sp,-48
    1ffc:	f406                	sd	ra,40(sp)
    1ffe:	f022                	sd	s0,32(sp)
    2000:	ec26                	sd	s1,24(sp)
    2002:	e84a                	sd	s2,16(sp)
    2004:	e44e                	sd	s3,8(sp)
    2006:	1800                	addi	s0,sp,48
    2008:	89aa                	mv	s3,a0
  for(n=0; n<N; n++){
    200a:	4481                	li	s1,0
    200c:	3e800913          	li	s2,1000
    pid = fork();
    2010:	00004097          	auipc	ra,0x4
    2014:	82c080e7          	jalr	-2004(ra) # 583c <fork>
    if(pid < 0)
    2018:	02054863          	bltz	a0,2048 <forktest+0x4e>
    if(pid == 0)
    201c:	c115                	beqz	a0,2040 <forktest+0x46>
  for(n=0; n<N; n++){
    201e:	2485                	addiw	s1,s1,1
    2020:	ff2498e3          	bne	s1,s2,2010 <forktest+0x16>
    printf("%s: fork claimed to work 1000 times!\n", s);
    2024:	85ce                	mv	a1,s3
    2026:	00005517          	auipc	a0,0x5
    202a:	85a50513          	addi	a0,a0,-1958 # 6880 <malloc+0xc0a>
    202e:	00004097          	auipc	ra,0x4
    2032:	b90080e7          	jalr	-1136(ra) # 5bbe <printf>
    exit(1);
    2036:	4505                	li	a0,1
    2038:	00004097          	auipc	ra,0x4
    203c:	80c080e7          	jalr	-2036(ra) # 5844 <exit>
      exit(0);
    2040:	00004097          	auipc	ra,0x4
    2044:	804080e7          	jalr	-2044(ra) # 5844 <exit>
  if (n == 0) {
    2048:	cc9d                	beqz	s1,2086 <forktest+0x8c>
  if(n == N){
    204a:	3e800793          	li	a5,1000
    204e:	fcf48be3          	beq	s1,a5,2024 <forktest+0x2a>
  for(; n > 0; n--){
    2052:	00905b63          	blez	s1,2068 <forktest+0x6e>
    if(wait(0) < 0){
    2056:	4501                	li	a0,0
    2058:	00003097          	auipc	ra,0x3
    205c:	7f4080e7          	jalr	2036(ra) # 584c <wait>
    2060:	04054163          	bltz	a0,20a2 <forktest+0xa8>
  for(; n > 0; n--){
    2064:	34fd                	addiw	s1,s1,-1
    2066:	f8e5                	bnez	s1,2056 <forktest+0x5c>
  if(wait(0) != -1){
    2068:	4501                	li	a0,0
    206a:	00003097          	auipc	ra,0x3
    206e:	7e2080e7          	jalr	2018(ra) # 584c <wait>
    2072:	57fd                	li	a5,-1
    2074:	04f51563          	bne	a0,a5,20be <forktest+0xc4>
}
    2078:	70a2                	ld	ra,40(sp)
    207a:	7402                	ld	s0,32(sp)
    207c:	64e2                	ld	s1,24(sp)
    207e:	6942                	ld	s2,16(sp)
    2080:	69a2                	ld	s3,8(sp)
    2082:	6145                	addi	sp,sp,48
    2084:	8082                	ret
    printf("%s: no fork at all!\n", s);
    2086:	85ce                	mv	a1,s3
    2088:	00004517          	auipc	a0,0x4
    208c:	7e050513          	addi	a0,a0,2016 # 6868 <malloc+0xbf2>
    2090:	00004097          	auipc	ra,0x4
    2094:	b2e080e7          	jalr	-1234(ra) # 5bbe <printf>
    exit(1);
    2098:	4505                	li	a0,1
    209a:	00003097          	auipc	ra,0x3
    209e:	7aa080e7          	jalr	1962(ra) # 5844 <exit>
      printf("%s: wait stopped early\n", s);
    20a2:	85ce                	mv	a1,s3
    20a4:	00005517          	auipc	a0,0x5
    20a8:	80450513          	addi	a0,a0,-2044 # 68a8 <malloc+0xc32>
    20ac:	00004097          	auipc	ra,0x4
    20b0:	b12080e7          	jalr	-1262(ra) # 5bbe <printf>
      exit(1);
    20b4:	4505                	li	a0,1
    20b6:	00003097          	auipc	ra,0x3
    20ba:	78e080e7          	jalr	1934(ra) # 5844 <exit>
    printf("%s: wait got too many\n", s);
    20be:	85ce                	mv	a1,s3
    20c0:	00005517          	auipc	a0,0x5
    20c4:	80050513          	addi	a0,a0,-2048 # 68c0 <malloc+0xc4a>
    20c8:	00004097          	auipc	ra,0x4
    20cc:	af6080e7          	jalr	-1290(ra) # 5bbe <printf>
    exit(1);
    20d0:	4505                	li	a0,1
    20d2:	00003097          	auipc	ra,0x3
    20d6:	772080e7          	jalr	1906(ra) # 5844 <exit>

00000000000020da <kernmem>:
{
    20da:	715d                	addi	sp,sp,-80
    20dc:	e486                	sd	ra,72(sp)
    20de:	e0a2                	sd	s0,64(sp)
    20e0:	fc26                	sd	s1,56(sp)
    20e2:	f84a                	sd	s2,48(sp)
    20e4:	f44e                	sd	s3,40(sp)
    20e6:	f052                	sd	s4,32(sp)
    20e8:	ec56                	sd	s5,24(sp)
    20ea:	0880                	addi	s0,sp,80
    20ec:	8a2a                	mv	s4,a0
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20ee:	4485                	li	s1,1
    20f0:	04fe                	slli	s1,s1,0x1f
    if(xstatus != -1)  // did kernel kill child?
    20f2:	5afd                	li	s5,-1
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    20f4:	69b1                	lui	s3,0xc
    20f6:	35098993          	addi	s3,s3,848 # c350 <buf+0x578>
    20fa:	1003d937          	lui	s2,0x1003d
    20fe:	090e                	slli	s2,s2,0x3
    2100:	48090913          	addi	s2,s2,1152 # 1003d480 <__BSS_END__+0x1002e698>
    pid = fork();
    2104:	00003097          	auipc	ra,0x3
    2108:	738080e7          	jalr	1848(ra) # 583c <fork>
    if(pid < 0){
    210c:	02054963          	bltz	a0,213e <kernmem+0x64>
    if(pid == 0){
    2110:	c529                	beqz	a0,215a <kernmem+0x80>
    wait(&xstatus);
    2112:	fbc40513          	addi	a0,s0,-68
    2116:	00003097          	auipc	ra,0x3
    211a:	736080e7          	jalr	1846(ra) # 584c <wait>
    if(xstatus != -1)  // did kernel kill child?
    211e:	fbc42783          	lw	a5,-68(s0)
    2122:	05579d63          	bne	a5,s5,217c <kernmem+0xa2>
  for(a = (char*)(KERNBASE); a < (char*) (KERNBASE+2000000); a += 50000){
    2126:	94ce                	add	s1,s1,s3
    2128:	fd249ee3          	bne	s1,s2,2104 <kernmem+0x2a>
}
    212c:	60a6                	ld	ra,72(sp)
    212e:	6406                	ld	s0,64(sp)
    2130:	74e2                	ld	s1,56(sp)
    2132:	7942                	ld	s2,48(sp)
    2134:	79a2                	ld	s3,40(sp)
    2136:	7a02                	ld	s4,32(sp)
    2138:	6ae2                	ld	s5,24(sp)
    213a:	6161                	addi	sp,sp,80
    213c:	8082                	ret
      printf("%s: fork failed\n", s);
    213e:	85d2                	mv	a1,s4
    2140:	00004517          	auipc	a0,0x4
    2144:	4b050513          	addi	a0,a0,1200 # 65f0 <malloc+0x97a>
    2148:	00004097          	auipc	ra,0x4
    214c:	a76080e7          	jalr	-1418(ra) # 5bbe <printf>
      exit(1);
    2150:	4505                	li	a0,1
    2152:	00003097          	auipc	ra,0x3
    2156:	6f2080e7          	jalr	1778(ra) # 5844 <exit>
      printf("%s: oops could read %x = %x\n", s, a, *a);
    215a:	0004c683          	lbu	a3,0(s1)
    215e:	8626                	mv	a2,s1
    2160:	85d2                	mv	a1,s4
    2162:	00004517          	auipc	a0,0x4
    2166:	77650513          	addi	a0,a0,1910 # 68d8 <malloc+0xc62>
    216a:	00004097          	auipc	ra,0x4
    216e:	a54080e7          	jalr	-1452(ra) # 5bbe <printf>
      exit(1);
    2172:	4505                	li	a0,1
    2174:	00003097          	auipc	ra,0x3
    2178:	6d0080e7          	jalr	1744(ra) # 5844 <exit>
      exit(1);
    217c:	4505                	li	a0,1
    217e:	00003097          	auipc	ra,0x3
    2182:	6c6080e7          	jalr	1734(ra) # 5844 <exit>

0000000000002186 <MAXVAplus>:
{
    2186:	7179                	addi	sp,sp,-48
    2188:	f406                	sd	ra,40(sp)
    218a:	f022                	sd	s0,32(sp)
    218c:	ec26                	sd	s1,24(sp)
    218e:	e84a                	sd	s2,16(sp)
    2190:	1800                	addi	s0,sp,48
  volatile uint64 a = MAXVA;
    2192:	4785                	li	a5,1
    2194:	179a                	slli	a5,a5,0x26
    2196:	fcf43c23          	sd	a5,-40(s0)
  for( ; a != 0; a <<= 1){
    219a:	fd843783          	ld	a5,-40(s0)
    219e:	cf85                	beqz	a5,21d6 <MAXVAplus+0x50>
    21a0:	892a                	mv	s2,a0
    if(xstatus != -1)  // did kernel kill child?
    21a2:	54fd                	li	s1,-1
    pid = fork();
    21a4:	00003097          	auipc	ra,0x3
    21a8:	698080e7          	jalr	1688(ra) # 583c <fork>
    if(pid < 0){
    21ac:	02054b63          	bltz	a0,21e2 <MAXVAplus+0x5c>
    if(pid == 0){
    21b0:	c539                	beqz	a0,21fe <MAXVAplus+0x78>
    wait(&xstatus);
    21b2:	fd440513          	addi	a0,s0,-44
    21b6:	00003097          	auipc	ra,0x3
    21ba:	696080e7          	jalr	1686(ra) # 584c <wait>
    if(xstatus != -1)  // did kernel kill child?
    21be:	fd442783          	lw	a5,-44(s0)
    21c2:	06979463          	bne	a5,s1,222a <MAXVAplus+0xa4>
  for( ; a != 0; a <<= 1){
    21c6:	fd843783          	ld	a5,-40(s0)
    21ca:	0786                	slli	a5,a5,0x1
    21cc:	fcf43c23          	sd	a5,-40(s0)
    21d0:	fd843783          	ld	a5,-40(s0)
    21d4:	fbe1                	bnez	a5,21a4 <MAXVAplus+0x1e>
}
    21d6:	70a2                	ld	ra,40(sp)
    21d8:	7402                	ld	s0,32(sp)
    21da:	64e2                	ld	s1,24(sp)
    21dc:	6942                	ld	s2,16(sp)
    21de:	6145                	addi	sp,sp,48
    21e0:	8082                	ret
      printf("%s: fork failed\n", s);
    21e2:	85ca                	mv	a1,s2
    21e4:	00004517          	auipc	a0,0x4
    21e8:	40c50513          	addi	a0,a0,1036 # 65f0 <malloc+0x97a>
    21ec:	00004097          	auipc	ra,0x4
    21f0:	9d2080e7          	jalr	-1582(ra) # 5bbe <printf>
      exit(1);
    21f4:	4505                	li	a0,1
    21f6:	00003097          	auipc	ra,0x3
    21fa:	64e080e7          	jalr	1614(ra) # 5844 <exit>
      *(char*)a = 99;
    21fe:	fd843783          	ld	a5,-40(s0)
    2202:	06300713          	li	a4,99
    2206:	00e78023          	sb	a4,0(a5) # 3000 <iputtest+0x8a>
      printf("%s: oops wrote %x\n", s, a);
    220a:	fd843603          	ld	a2,-40(s0)
    220e:	85ca                	mv	a1,s2
    2210:	00004517          	auipc	a0,0x4
    2214:	6e850513          	addi	a0,a0,1768 # 68f8 <malloc+0xc82>
    2218:	00004097          	auipc	ra,0x4
    221c:	9a6080e7          	jalr	-1626(ra) # 5bbe <printf>
      exit(1);
    2220:	4505                	li	a0,1
    2222:	00003097          	auipc	ra,0x3
    2226:	622080e7          	jalr	1570(ra) # 5844 <exit>
      exit(1);
    222a:	4505                	li	a0,1
    222c:	00003097          	auipc	ra,0x3
    2230:	618080e7          	jalr	1560(ra) # 5844 <exit>

0000000000002234 <bigargtest>:
{
    2234:	7179                	addi	sp,sp,-48
    2236:	f406                	sd	ra,40(sp)
    2238:	f022                	sd	s0,32(sp)
    223a:	ec26                	sd	s1,24(sp)
    223c:	1800                	addi	s0,sp,48
    223e:	84aa                	mv	s1,a0
  unlink("bigarg-ok");
    2240:	00004517          	auipc	a0,0x4
    2244:	6d050513          	addi	a0,a0,1744 # 6910 <malloc+0xc9a>
    2248:	00003097          	auipc	ra,0x3
    224c:	64c080e7          	jalr	1612(ra) # 5894 <unlink>
  pid = fork();
    2250:	00003097          	auipc	ra,0x3
    2254:	5ec080e7          	jalr	1516(ra) # 583c <fork>
  if(pid == 0){
    2258:	c121                	beqz	a0,2298 <bigargtest+0x64>
  } else if(pid < 0){
    225a:	0a054063          	bltz	a0,22fa <bigargtest+0xc6>
  wait(&xstatus);
    225e:	fdc40513          	addi	a0,s0,-36
    2262:	00003097          	auipc	ra,0x3
    2266:	5ea080e7          	jalr	1514(ra) # 584c <wait>
  if(xstatus != 0)
    226a:	fdc42503          	lw	a0,-36(s0)
    226e:	e545                	bnez	a0,2316 <bigargtest+0xe2>
  fd = open("bigarg-ok", 0);
    2270:	4581                	li	a1,0
    2272:	00004517          	auipc	a0,0x4
    2276:	69e50513          	addi	a0,a0,1694 # 6910 <malloc+0xc9a>
    227a:	00003097          	auipc	ra,0x3
    227e:	60a080e7          	jalr	1546(ra) # 5884 <open>
  if(fd < 0){
    2282:	08054e63          	bltz	a0,231e <bigargtest+0xea>
  close(fd);
    2286:	00003097          	auipc	ra,0x3
    228a:	5e6080e7          	jalr	1510(ra) # 586c <close>
}
    228e:	70a2                	ld	ra,40(sp)
    2290:	7402                	ld	s0,32(sp)
    2292:	64e2                	ld	s1,24(sp)
    2294:	6145                	addi	sp,sp,48
    2296:	8082                	ret
    2298:	00006797          	auipc	a5,0x6
    229c:	32878793          	addi	a5,a5,808 # 85c0 <args.1>
    22a0:	00006697          	auipc	a3,0x6
    22a4:	41868693          	addi	a3,a3,1048 # 86b8 <args.1+0xf8>
      args[i] = "bigargs test: failed\n                                                                                                                                                                                                       ";
    22a8:	00004717          	auipc	a4,0x4
    22ac:	67870713          	addi	a4,a4,1656 # 6920 <malloc+0xcaa>
    22b0:	e398                	sd	a4,0(a5)
    for(i = 0; i < MAXARG-1; i++)
    22b2:	07a1                	addi	a5,a5,8
    22b4:	fed79ee3          	bne	a5,a3,22b0 <bigargtest+0x7c>
    args[MAXARG-1] = 0;
    22b8:	00006597          	auipc	a1,0x6
    22bc:	30858593          	addi	a1,a1,776 # 85c0 <args.1>
    22c0:	0e05bc23          	sd	zero,248(a1)
    exec("echo", args);
    22c4:	00004517          	auipc	a0,0x4
    22c8:	ad450513          	addi	a0,a0,-1324 # 5d98 <malloc+0x122>
    22cc:	00003097          	auipc	ra,0x3
    22d0:	5b0080e7          	jalr	1456(ra) # 587c <exec>
    fd = open("bigarg-ok", O_CREATE);
    22d4:	20000593          	li	a1,512
    22d8:	00004517          	auipc	a0,0x4
    22dc:	63850513          	addi	a0,a0,1592 # 6910 <malloc+0xc9a>
    22e0:	00003097          	auipc	ra,0x3
    22e4:	5a4080e7          	jalr	1444(ra) # 5884 <open>
    close(fd);
    22e8:	00003097          	auipc	ra,0x3
    22ec:	584080e7          	jalr	1412(ra) # 586c <close>
    exit(0);
    22f0:	4501                	li	a0,0
    22f2:	00003097          	auipc	ra,0x3
    22f6:	552080e7          	jalr	1362(ra) # 5844 <exit>
    printf("%s: bigargtest: fork failed\n", s);
    22fa:	85a6                	mv	a1,s1
    22fc:	00004517          	auipc	a0,0x4
    2300:	70450513          	addi	a0,a0,1796 # 6a00 <malloc+0xd8a>
    2304:	00004097          	auipc	ra,0x4
    2308:	8ba080e7          	jalr	-1862(ra) # 5bbe <printf>
    exit(1);
    230c:	4505                	li	a0,1
    230e:	00003097          	auipc	ra,0x3
    2312:	536080e7          	jalr	1334(ra) # 5844 <exit>
    exit(xstatus);
    2316:	00003097          	auipc	ra,0x3
    231a:	52e080e7          	jalr	1326(ra) # 5844 <exit>
    printf("%s: bigarg test failed!\n", s);
    231e:	85a6                	mv	a1,s1
    2320:	00004517          	auipc	a0,0x4
    2324:	70050513          	addi	a0,a0,1792 # 6a20 <malloc+0xdaa>
    2328:	00004097          	auipc	ra,0x4
    232c:	896080e7          	jalr	-1898(ra) # 5bbe <printf>
    exit(1);
    2330:	4505                	li	a0,1
    2332:	00003097          	auipc	ra,0x3
    2336:	512080e7          	jalr	1298(ra) # 5844 <exit>

000000000000233a <stacktest>:
{
    233a:	7179                	addi	sp,sp,-48
    233c:	f406                	sd	ra,40(sp)
    233e:	f022                	sd	s0,32(sp)
    2340:	ec26                	sd	s1,24(sp)
    2342:	1800                	addi	s0,sp,48
    2344:	84aa                	mv	s1,a0
  pid = fork();
    2346:	00003097          	auipc	ra,0x3
    234a:	4f6080e7          	jalr	1270(ra) # 583c <fork>
  if(pid == 0) {
    234e:	c115                	beqz	a0,2372 <stacktest+0x38>
  } else if(pid < 0){
    2350:	04054463          	bltz	a0,2398 <stacktest+0x5e>
  wait(&xstatus);
    2354:	fdc40513          	addi	a0,s0,-36
    2358:	00003097          	auipc	ra,0x3
    235c:	4f4080e7          	jalr	1268(ra) # 584c <wait>
  if(xstatus == -1)  // kernel killed child?
    2360:	fdc42503          	lw	a0,-36(s0)
    2364:	57fd                	li	a5,-1
    2366:	04f50763          	beq	a0,a5,23b4 <stacktest+0x7a>
    exit(xstatus);
    236a:	00003097          	auipc	ra,0x3
    236e:	4da080e7          	jalr	1242(ra) # 5844 <exit>

static inline uint64
r_sp()
{
  uint64 x;
  asm volatile("mv %0, sp" : "=r" (x) );
    2372:	870a                	mv	a4,sp
    printf("%s: stacktest: read below stack %p\n", s, *sp);
    2374:	77fd                	lui	a5,0xfffff
    2376:	97ba                	add	a5,a5,a4
    2378:	0007c603          	lbu	a2,0(a5) # fffffffffffff000 <__BSS_END__+0xffffffffffff0218>
    237c:	85a6                	mv	a1,s1
    237e:	00004517          	auipc	a0,0x4
    2382:	6c250513          	addi	a0,a0,1730 # 6a40 <malloc+0xdca>
    2386:	00004097          	auipc	ra,0x4
    238a:	838080e7          	jalr	-1992(ra) # 5bbe <printf>
    exit(1);
    238e:	4505                	li	a0,1
    2390:	00003097          	auipc	ra,0x3
    2394:	4b4080e7          	jalr	1204(ra) # 5844 <exit>
    printf("%s: fork failed\n", s);
    2398:	85a6                	mv	a1,s1
    239a:	00004517          	auipc	a0,0x4
    239e:	25650513          	addi	a0,a0,598 # 65f0 <malloc+0x97a>
    23a2:	00004097          	auipc	ra,0x4
    23a6:	81c080e7          	jalr	-2020(ra) # 5bbe <printf>
    exit(1);
    23aa:	4505                	li	a0,1
    23ac:	00003097          	auipc	ra,0x3
    23b0:	498080e7          	jalr	1176(ra) # 5844 <exit>
    exit(0);
    23b4:	4501                	li	a0,0
    23b6:	00003097          	auipc	ra,0x3
    23ba:	48e080e7          	jalr	1166(ra) # 5844 <exit>

00000000000023be <copyinstr3>:
{
    23be:	7179                	addi	sp,sp,-48
    23c0:	f406                	sd	ra,40(sp)
    23c2:	f022                	sd	s0,32(sp)
    23c4:	ec26                	sd	s1,24(sp)
    23c6:	1800                	addi	s0,sp,48
  sbrk(8192);
    23c8:	6509                	lui	a0,0x2
    23ca:	00003097          	auipc	ra,0x3
    23ce:	502080e7          	jalr	1282(ra) # 58cc <sbrk>
  uint64 top = (uint64) sbrk(0);
    23d2:	4501                	li	a0,0
    23d4:	00003097          	auipc	ra,0x3
    23d8:	4f8080e7          	jalr	1272(ra) # 58cc <sbrk>
  if((top % PGSIZE) != 0){
    23dc:	03451793          	slli	a5,a0,0x34
    23e0:	e3c9                	bnez	a5,2462 <copyinstr3+0xa4>
  top = (uint64) sbrk(0);
    23e2:	4501                	li	a0,0
    23e4:	00003097          	auipc	ra,0x3
    23e8:	4e8080e7          	jalr	1256(ra) # 58cc <sbrk>
  if(top % PGSIZE){
    23ec:	03451793          	slli	a5,a0,0x34
    23f0:	e3d9                	bnez	a5,2476 <copyinstr3+0xb8>
  char *b = (char *) (top - 1);
    23f2:	fff50493          	addi	s1,a0,-1 # 1fff <forktest+0x5>
  *b = 'x';
    23f6:	07800793          	li	a5,120
    23fa:	fef50fa3          	sb	a5,-1(a0)
  int ret = unlink(b);
    23fe:	8526                	mv	a0,s1
    2400:	00003097          	auipc	ra,0x3
    2404:	494080e7          	jalr	1172(ra) # 5894 <unlink>
  if(ret != -1){
    2408:	57fd                	li	a5,-1
    240a:	08f51363          	bne	a0,a5,2490 <copyinstr3+0xd2>
  int fd = open(b, O_CREATE | O_WRONLY);
    240e:	20100593          	li	a1,513
    2412:	8526                	mv	a0,s1
    2414:	00003097          	auipc	ra,0x3
    2418:	470080e7          	jalr	1136(ra) # 5884 <open>
  if(fd != -1){
    241c:	57fd                	li	a5,-1
    241e:	08f51863          	bne	a0,a5,24ae <copyinstr3+0xf0>
  ret = link(b, b);
    2422:	85a6                	mv	a1,s1
    2424:	8526                	mv	a0,s1
    2426:	00003097          	auipc	ra,0x3
    242a:	47e080e7          	jalr	1150(ra) # 58a4 <link>
  if(ret != -1){
    242e:	57fd                	li	a5,-1
    2430:	08f51e63          	bne	a0,a5,24cc <copyinstr3+0x10e>
  char *args[] = { "xx", 0 };
    2434:	00005797          	auipc	a5,0x5
    2438:	2b478793          	addi	a5,a5,692 # 76e8 <malloc+0x1a72>
    243c:	fcf43823          	sd	a5,-48(s0)
    2440:	fc043c23          	sd	zero,-40(s0)
  ret = exec(b, args);
    2444:	fd040593          	addi	a1,s0,-48
    2448:	8526                	mv	a0,s1
    244a:	00003097          	auipc	ra,0x3
    244e:	432080e7          	jalr	1074(ra) # 587c <exec>
  if(ret != -1){
    2452:	57fd                	li	a5,-1
    2454:	08f51c63          	bne	a0,a5,24ec <copyinstr3+0x12e>
}
    2458:	70a2                	ld	ra,40(sp)
    245a:	7402                	ld	s0,32(sp)
    245c:	64e2                	ld	s1,24(sp)
    245e:	6145                	addi	sp,sp,48
    2460:	8082                	ret
    sbrk(PGSIZE - (top % PGSIZE));
    2462:	0347d513          	srli	a0,a5,0x34
    2466:	6785                	lui	a5,0x1
    2468:	40a7853b          	subw	a0,a5,a0
    246c:	00003097          	auipc	ra,0x3
    2470:	460080e7          	jalr	1120(ra) # 58cc <sbrk>
    2474:	b7bd                	j	23e2 <copyinstr3+0x24>
    printf("oops\n");
    2476:	00004517          	auipc	a0,0x4
    247a:	5f250513          	addi	a0,a0,1522 # 6a68 <malloc+0xdf2>
    247e:	00003097          	auipc	ra,0x3
    2482:	740080e7          	jalr	1856(ra) # 5bbe <printf>
    exit(1);
    2486:	4505                	li	a0,1
    2488:	00003097          	auipc	ra,0x3
    248c:	3bc080e7          	jalr	956(ra) # 5844 <exit>
    printf("unlink(%s) returned %d, not -1\n", b, ret);
    2490:	862a                	mv	a2,a0
    2492:	85a6                	mv	a1,s1
    2494:	00004517          	auipc	a0,0x4
    2498:	07c50513          	addi	a0,a0,124 # 6510 <malloc+0x89a>
    249c:	00003097          	auipc	ra,0x3
    24a0:	722080e7          	jalr	1826(ra) # 5bbe <printf>
    exit(1);
    24a4:	4505                	li	a0,1
    24a6:	00003097          	auipc	ra,0x3
    24aa:	39e080e7          	jalr	926(ra) # 5844 <exit>
    printf("open(%s) returned %d, not -1\n", b, fd);
    24ae:	862a                	mv	a2,a0
    24b0:	85a6                	mv	a1,s1
    24b2:	00004517          	auipc	a0,0x4
    24b6:	07e50513          	addi	a0,a0,126 # 6530 <malloc+0x8ba>
    24ba:	00003097          	auipc	ra,0x3
    24be:	704080e7          	jalr	1796(ra) # 5bbe <printf>
    exit(1);
    24c2:	4505                	li	a0,1
    24c4:	00003097          	auipc	ra,0x3
    24c8:	380080e7          	jalr	896(ra) # 5844 <exit>
    printf("link(%s, %s) returned %d, not -1\n", b, b, ret);
    24cc:	86aa                	mv	a3,a0
    24ce:	8626                	mv	a2,s1
    24d0:	85a6                	mv	a1,s1
    24d2:	00004517          	auipc	a0,0x4
    24d6:	07e50513          	addi	a0,a0,126 # 6550 <malloc+0x8da>
    24da:	00003097          	auipc	ra,0x3
    24de:	6e4080e7          	jalr	1764(ra) # 5bbe <printf>
    exit(1);
    24e2:	4505                	li	a0,1
    24e4:	00003097          	auipc	ra,0x3
    24e8:	360080e7          	jalr	864(ra) # 5844 <exit>
    printf("exec(%s) returned %d, not -1\n", b, fd);
    24ec:	567d                	li	a2,-1
    24ee:	85a6                	mv	a1,s1
    24f0:	00004517          	auipc	a0,0x4
    24f4:	08850513          	addi	a0,a0,136 # 6578 <malloc+0x902>
    24f8:	00003097          	auipc	ra,0x3
    24fc:	6c6080e7          	jalr	1734(ra) # 5bbe <printf>
    exit(1);
    2500:	4505                	li	a0,1
    2502:	00003097          	auipc	ra,0x3
    2506:	342080e7          	jalr	834(ra) # 5844 <exit>

000000000000250a <rwsbrk>:
{
    250a:	1101                	addi	sp,sp,-32
    250c:	ec06                	sd	ra,24(sp)
    250e:	e822                	sd	s0,16(sp)
    2510:	e426                	sd	s1,8(sp)
    2512:	e04a                	sd	s2,0(sp)
    2514:	1000                	addi	s0,sp,32
  uint64 a = (uint64) sbrk(8192);
    2516:	6509                	lui	a0,0x2
    2518:	00003097          	auipc	ra,0x3
    251c:	3b4080e7          	jalr	948(ra) # 58cc <sbrk>
  if(a == 0xffffffffffffffffLL) {
    2520:	57fd                	li	a5,-1
    2522:	06f50263          	beq	a0,a5,2586 <rwsbrk+0x7c>
    2526:	84aa                	mv	s1,a0
  if ((uint64) sbrk(-8192) ==  0xffffffffffffffffLL) {
    2528:	7579                	lui	a0,0xffffe
    252a:	00003097          	auipc	ra,0x3
    252e:	3a2080e7          	jalr	930(ra) # 58cc <sbrk>
    2532:	57fd                	li	a5,-1
    2534:	06f50663          	beq	a0,a5,25a0 <rwsbrk+0x96>
  fd = open("rwsbrk", O_CREATE|O_WRONLY);
    2538:	20100593          	li	a1,513
    253c:	00004517          	auipc	a0,0x4
    2540:	56c50513          	addi	a0,a0,1388 # 6aa8 <malloc+0xe32>
    2544:	00003097          	auipc	ra,0x3
    2548:	340080e7          	jalr	832(ra) # 5884 <open>
    254c:	892a                	mv	s2,a0
  if(fd < 0){
    254e:	06054663          	bltz	a0,25ba <rwsbrk+0xb0>
  n = write(fd, (void*)(a+4096), 1024);
    2552:	6785                	lui	a5,0x1
    2554:	94be                	add	s1,s1,a5
    2556:	40000613          	li	a2,1024
    255a:	85a6                	mv	a1,s1
    255c:	00003097          	auipc	ra,0x3
    2560:	308080e7          	jalr	776(ra) # 5864 <write>
    2564:	862a                	mv	a2,a0
  if(n >= 0){
    2566:	06054763          	bltz	a0,25d4 <rwsbrk+0xca>
    printf("write(fd, %p, 1024) returned %d, not -1\n", a+4096, n);
    256a:	85a6                	mv	a1,s1
    256c:	00004517          	auipc	a0,0x4
    2570:	55c50513          	addi	a0,a0,1372 # 6ac8 <malloc+0xe52>
    2574:	00003097          	auipc	ra,0x3
    2578:	64a080e7          	jalr	1610(ra) # 5bbe <printf>
    exit(1);
    257c:	4505                	li	a0,1
    257e:	00003097          	auipc	ra,0x3
    2582:	2c6080e7          	jalr	710(ra) # 5844 <exit>
    printf("sbrk(rwsbrk) failed\n");
    2586:	00004517          	auipc	a0,0x4
    258a:	4ea50513          	addi	a0,a0,1258 # 6a70 <malloc+0xdfa>
    258e:	00003097          	auipc	ra,0x3
    2592:	630080e7          	jalr	1584(ra) # 5bbe <printf>
    exit(1);
    2596:	4505                	li	a0,1
    2598:	00003097          	auipc	ra,0x3
    259c:	2ac080e7          	jalr	684(ra) # 5844 <exit>
    printf("sbrk(rwsbrk) shrink failed\n");
    25a0:	00004517          	auipc	a0,0x4
    25a4:	4e850513          	addi	a0,a0,1256 # 6a88 <malloc+0xe12>
    25a8:	00003097          	auipc	ra,0x3
    25ac:	616080e7          	jalr	1558(ra) # 5bbe <printf>
    exit(1);
    25b0:	4505                	li	a0,1
    25b2:	00003097          	auipc	ra,0x3
    25b6:	292080e7          	jalr	658(ra) # 5844 <exit>
    printf("open(rwsbrk) failed\n");
    25ba:	00004517          	auipc	a0,0x4
    25be:	4f650513          	addi	a0,a0,1270 # 6ab0 <malloc+0xe3a>
    25c2:	00003097          	auipc	ra,0x3
    25c6:	5fc080e7          	jalr	1532(ra) # 5bbe <printf>
    exit(1);
    25ca:	4505                	li	a0,1
    25cc:	00003097          	auipc	ra,0x3
    25d0:	278080e7          	jalr	632(ra) # 5844 <exit>
  close(fd);
    25d4:	854a                	mv	a0,s2
    25d6:	00003097          	auipc	ra,0x3
    25da:	296080e7          	jalr	662(ra) # 586c <close>
  unlink("rwsbrk");
    25de:	00004517          	auipc	a0,0x4
    25e2:	4ca50513          	addi	a0,a0,1226 # 6aa8 <malloc+0xe32>
    25e6:	00003097          	auipc	ra,0x3
    25ea:	2ae080e7          	jalr	686(ra) # 5894 <unlink>
  fd = open("README", O_RDONLY);
    25ee:	4581                	li	a1,0
    25f0:	00004517          	auipc	a0,0x4
    25f4:	95050513          	addi	a0,a0,-1712 # 5f40 <malloc+0x2ca>
    25f8:	00003097          	auipc	ra,0x3
    25fc:	28c080e7          	jalr	652(ra) # 5884 <open>
    2600:	892a                	mv	s2,a0
  if(fd < 0){
    2602:	02054963          	bltz	a0,2634 <rwsbrk+0x12a>
  n = read(fd, (void*)(a+4096), 10);
    2606:	4629                	li	a2,10
    2608:	85a6                	mv	a1,s1
    260a:	00003097          	auipc	ra,0x3
    260e:	252080e7          	jalr	594(ra) # 585c <read>
    2612:	862a                	mv	a2,a0
  if(n >= 0){
    2614:	02054d63          	bltz	a0,264e <rwsbrk+0x144>
    printf("read(fd, %p, 10) returned %d, not -1\n", a+4096, n);
    2618:	85a6                	mv	a1,s1
    261a:	00004517          	auipc	a0,0x4
    261e:	4de50513          	addi	a0,a0,1246 # 6af8 <malloc+0xe82>
    2622:	00003097          	auipc	ra,0x3
    2626:	59c080e7          	jalr	1436(ra) # 5bbe <printf>
    exit(1);
    262a:	4505                	li	a0,1
    262c:	00003097          	auipc	ra,0x3
    2630:	218080e7          	jalr	536(ra) # 5844 <exit>
    printf("open(rwsbrk) failed\n");
    2634:	00004517          	auipc	a0,0x4
    2638:	47c50513          	addi	a0,a0,1148 # 6ab0 <malloc+0xe3a>
    263c:	00003097          	auipc	ra,0x3
    2640:	582080e7          	jalr	1410(ra) # 5bbe <printf>
    exit(1);
    2644:	4505                	li	a0,1
    2646:	00003097          	auipc	ra,0x3
    264a:	1fe080e7          	jalr	510(ra) # 5844 <exit>
  close(fd);
    264e:	854a                	mv	a0,s2
    2650:	00003097          	auipc	ra,0x3
    2654:	21c080e7          	jalr	540(ra) # 586c <close>
  exit(0);
    2658:	4501                	li	a0,0
    265a:	00003097          	auipc	ra,0x3
    265e:	1ea080e7          	jalr	490(ra) # 5844 <exit>

0000000000002662 <sbrkbasic>:
{
    2662:	7139                	addi	sp,sp,-64
    2664:	fc06                	sd	ra,56(sp)
    2666:	f822                	sd	s0,48(sp)
    2668:	f426                	sd	s1,40(sp)
    266a:	f04a                	sd	s2,32(sp)
    266c:	ec4e                	sd	s3,24(sp)
    266e:	e852                	sd	s4,16(sp)
    2670:	0080                	addi	s0,sp,64
    2672:	8a2a                	mv	s4,a0
  pid = fork();
    2674:	00003097          	auipc	ra,0x3
    2678:	1c8080e7          	jalr	456(ra) # 583c <fork>
  if(pid < 0){
    267c:	02054c63          	bltz	a0,26b4 <sbrkbasic+0x52>
  if(pid == 0){
    2680:	ed21                	bnez	a0,26d8 <sbrkbasic+0x76>
    a = sbrk(TOOMUCH);
    2682:	40000537          	lui	a0,0x40000
    2686:	00003097          	auipc	ra,0x3
    268a:	246080e7          	jalr	582(ra) # 58cc <sbrk>
    if(a == (char*)0xffffffffffffffffL){
    268e:	57fd                	li	a5,-1
    2690:	02f50f63          	beq	a0,a5,26ce <sbrkbasic+0x6c>
    for(b = a; b < a+TOOMUCH; b += 4096){
    2694:	400007b7          	lui	a5,0x40000
    2698:	97aa                	add	a5,a5,a0
      *b = 99;
    269a:	06300693          	li	a3,99
    for(b = a; b < a+TOOMUCH; b += 4096){
    269e:	6705                	lui	a4,0x1
      *b = 99;
    26a0:	00d50023          	sb	a3,0(a0) # 40000000 <__BSS_END__+0x3fff1218>
    for(b = a; b < a+TOOMUCH; b += 4096){
    26a4:	953a                	add	a0,a0,a4
    26a6:	fef51de3          	bne	a0,a5,26a0 <sbrkbasic+0x3e>
    exit(1);
    26aa:	4505                	li	a0,1
    26ac:	00003097          	auipc	ra,0x3
    26b0:	198080e7          	jalr	408(ra) # 5844 <exit>
    printf("fork failed in sbrkbasic\n");
    26b4:	00004517          	auipc	a0,0x4
    26b8:	46c50513          	addi	a0,a0,1132 # 6b20 <malloc+0xeaa>
    26bc:	00003097          	auipc	ra,0x3
    26c0:	502080e7          	jalr	1282(ra) # 5bbe <printf>
    exit(1);
    26c4:	4505                	li	a0,1
    26c6:	00003097          	auipc	ra,0x3
    26ca:	17e080e7          	jalr	382(ra) # 5844 <exit>
      exit(0);
    26ce:	4501                	li	a0,0
    26d0:	00003097          	auipc	ra,0x3
    26d4:	174080e7          	jalr	372(ra) # 5844 <exit>
  wait(&xstatus);
    26d8:	fcc40513          	addi	a0,s0,-52
    26dc:	00003097          	auipc	ra,0x3
    26e0:	170080e7          	jalr	368(ra) # 584c <wait>
  if(xstatus == 1){
    26e4:	fcc42703          	lw	a4,-52(s0)
    26e8:	4785                	li	a5,1
    26ea:	00f70d63          	beq	a4,a5,2704 <sbrkbasic+0xa2>
  a = sbrk(0);
    26ee:	4501                	li	a0,0
    26f0:	00003097          	auipc	ra,0x3
    26f4:	1dc080e7          	jalr	476(ra) # 58cc <sbrk>
    26f8:	84aa                	mv	s1,a0
  for(i = 0; i < 5000; i++){
    26fa:	4901                	li	s2,0
    26fc:	6985                	lui	s3,0x1
    26fe:	38898993          	addi	s3,s3,904 # 1388 <copyinstr2+0x1d6>
    2702:	a005                	j	2722 <sbrkbasic+0xc0>
    printf("%s: too much memory allocated!\n", s);
    2704:	85d2                	mv	a1,s4
    2706:	00004517          	auipc	a0,0x4
    270a:	43a50513          	addi	a0,a0,1082 # 6b40 <malloc+0xeca>
    270e:	00003097          	auipc	ra,0x3
    2712:	4b0080e7          	jalr	1200(ra) # 5bbe <printf>
    exit(1);
    2716:	4505                	li	a0,1
    2718:	00003097          	auipc	ra,0x3
    271c:	12c080e7          	jalr	300(ra) # 5844 <exit>
    a = b + 1;
    2720:	84be                	mv	s1,a5
    b = sbrk(1);
    2722:	4505                	li	a0,1
    2724:	00003097          	auipc	ra,0x3
    2728:	1a8080e7          	jalr	424(ra) # 58cc <sbrk>
    if(b != a){
    272c:	04951c63          	bne	a0,s1,2784 <sbrkbasic+0x122>
    *b = 1;
    2730:	4785                	li	a5,1
    2732:	00f48023          	sb	a5,0(s1)
    a = b + 1;
    2736:	00148793          	addi	a5,s1,1
  for(i = 0; i < 5000; i++){
    273a:	2905                	addiw	s2,s2,1
    273c:	ff3912e3          	bne	s2,s3,2720 <sbrkbasic+0xbe>
  pid = fork();
    2740:	00003097          	auipc	ra,0x3
    2744:	0fc080e7          	jalr	252(ra) # 583c <fork>
    2748:	892a                	mv	s2,a0
  if(pid < 0){
    274a:	04054e63          	bltz	a0,27a6 <sbrkbasic+0x144>
  c = sbrk(1);
    274e:	4505                	li	a0,1
    2750:	00003097          	auipc	ra,0x3
    2754:	17c080e7          	jalr	380(ra) # 58cc <sbrk>
  c = sbrk(1);
    2758:	4505                	li	a0,1
    275a:	00003097          	auipc	ra,0x3
    275e:	172080e7          	jalr	370(ra) # 58cc <sbrk>
  if(c != a + 1){
    2762:	0489                	addi	s1,s1,2
    2764:	04a48f63          	beq	s1,a0,27c2 <sbrkbasic+0x160>
    printf("%s: sbrk test failed post-fork\n", s);
    2768:	85d2                	mv	a1,s4
    276a:	00004517          	auipc	a0,0x4
    276e:	43650513          	addi	a0,a0,1078 # 6ba0 <malloc+0xf2a>
    2772:	00003097          	auipc	ra,0x3
    2776:	44c080e7          	jalr	1100(ra) # 5bbe <printf>
    exit(1);
    277a:	4505                	li	a0,1
    277c:	00003097          	auipc	ra,0x3
    2780:	0c8080e7          	jalr	200(ra) # 5844 <exit>
      printf("%s: sbrk test failed %d %x %x\n", s, i, a, b);
    2784:	872a                	mv	a4,a0
    2786:	86a6                	mv	a3,s1
    2788:	864a                	mv	a2,s2
    278a:	85d2                	mv	a1,s4
    278c:	00004517          	auipc	a0,0x4
    2790:	3d450513          	addi	a0,a0,980 # 6b60 <malloc+0xeea>
    2794:	00003097          	auipc	ra,0x3
    2798:	42a080e7          	jalr	1066(ra) # 5bbe <printf>
      exit(1);
    279c:	4505                	li	a0,1
    279e:	00003097          	auipc	ra,0x3
    27a2:	0a6080e7          	jalr	166(ra) # 5844 <exit>
    printf("%s: sbrk test fork failed\n", s);
    27a6:	85d2                	mv	a1,s4
    27a8:	00004517          	auipc	a0,0x4
    27ac:	3d850513          	addi	a0,a0,984 # 6b80 <malloc+0xf0a>
    27b0:	00003097          	auipc	ra,0x3
    27b4:	40e080e7          	jalr	1038(ra) # 5bbe <printf>
    exit(1);
    27b8:	4505                	li	a0,1
    27ba:	00003097          	auipc	ra,0x3
    27be:	08a080e7          	jalr	138(ra) # 5844 <exit>
  if(pid == 0)
    27c2:	00091763          	bnez	s2,27d0 <sbrkbasic+0x16e>
    exit(0);
    27c6:	4501                	li	a0,0
    27c8:	00003097          	auipc	ra,0x3
    27cc:	07c080e7          	jalr	124(ra) # 5844 <exit>
  wait(&xstatus);
    27d0:	fcc40513          	addi	a0,s0,-52
    27d4:	00003097          	auipc	ra,0x3
    27d8:	078080e7          	jalr	120(ra) # 584c <wait>
  exit(xstatus);
    27dc:	fcc42503          	lw	a0,-52(s0)
    27e0:	00003097          	auipc	ra,0x3
    27e4:	064080e7          	jalr	100(ra) # 5844 <exit>

00000000000027e8 <sbrkmuch>:
{
    27e8:	7179                	addi	sp,sp,-48
    27ea:	f406                	sd	ra,40(sp)
    27ec:	f022                	sd	s0,32(sp)
    27ee:	ec26                	sd	s1,24(sp)
    27f0:	e84a                	sd	s2,16(sp)
    27f2:	e44e                	sd	s3,8(sp)
    27f4:	e052                	sd	s4,0(sp)
    27f6:	1800                	addi	s0,sp,48
    27f8:	89aa                	mv	s3,a0
  oldbrk = sbrk(0);
    27fa:	4501                	li	a0,0
    27fc:	00003097          	auipc	ra,0x3
    2800:	0d0080e7          	jalr	208(ra) # 58cc <sbrk>
    2804:	892a                	mv	s2,a0
  a = sbrk(0);
    2806:	4501                	li	a0,0
    2808:	00003097          	auipc	ra,0x3
    280c:	0c4080e7          	jalr	196(ra) # 58cc <sbrk>
    2810:	84aa                	mv	s1,a0
  p = sbrk(amt);
    2812:	06400537          	lui	a0,0x6400
    2816:	9d05                	subw	a0,a0,s1
    2818:	00003097          	auipc	ra,0x3
    281c:	0b4080e7          	jalr	180(ra) # 58cc <sbrk>
  if (p != a) {
    2820:	0ca49863          	bne	s1,a0,28f0 <sbrkmuch+0x108>
  char *eee = sbrk(0);
    2824:	4501                	li	a0,0
    2826:	00003097          	auipc	ra,0x3
    282a:	0a6080e7          	jalr	166(ra) # 58cc <sbrk>
    282e:	87aa                	mv	a5,a0
  for(char *pp = a; pp < eee; pp += 4096)
    2830:	00a4f963          	bgeu	s1,a0,2842 <sbrkmuch+0x5a>
    *pp = 1;
    2834:	4685                	li	a3,1
  for(char *pp = a; pp < eee; pp += 4096)
    2836:	6705                	lui	a4,0x1
    *pp = 1;
    2838:	00d48023          	sb	a3,0(s1)
  for(char *pp = a; pp < eee; pp += 4096)
    283c:	94ba                	add	s1,s1,a4
    283e:	fef4ede3          	bltu	s1,a5,2838 <sbrkmuch+0x50>
  *lastaddr = 99;
    2842:	064007b7          	lui	a5,0x6400
    2846:	06300713          	li	a4,99
    284a:	fee78fa3          	sb	a4,-1(a5) # 63fffff <__BSS_END__+0x63f1217>
  a = sbrk(0);
    284e:	4501                	li	a0,0
    2850:	00003097          	auipc	ra,0x3
    2854:	07c080e7          	jalr	124(ra) # 58cc <sbrk>
    2858:	84aa                	mv	s1,a0
  c = sbrk(-PGSIZE);
    285a:	757d                	lui	a0,0xfffff
    285c:	00003097          	auipc	ra,0x3
    2860:	070080e7          	jalr	112(ra) # 58cc <sbrk>
  if(c == (char*)0xffffffffffffffffL){
    2864:	57fd                	li	a5,-1
    2866:	0af50363          	beq	a0,a5,290c <sbrkmuch+0x124>
  c = sbrk(0);
    286a:	4501                	li	a0,0
    286c:	00003097          	auipc	ra,0x3
    2870:	060080e7          	jalr	96(ra) # 58cc <sbrk>
  if(c != a - PGSIZE){
    2874:	77fd                	lui	a5,0xfffff
    2876:	97a6                	add	a5,a5,s1
    2878:	0af51863          	bne	a0,a5,2928 <sbrkmuch+0x140>
  a = sbrk(0);
    287c:	4501                	li	a0,0
    287e:	00003097          	auipc	ra,0x3
    2882:	04e080e7          	jalr	78(ra) # 58cc <sbrk>
    2886:	84aa                	mv	s1,a0
  c = sbrk(PGSIZE);
    2888:	6505                	lui	a0,0x1
    288a:	00003097          	auipc	ra,0x3
    288e:	042080e7          	jalr	66(ra) # 58cc <sbrk>
    2892:	8a2a                	mv	s4,a0
  if(c != a || sbrk(0) != a + PGSIZE){
    2894:	0aa49a63          	bne	s1,a0,2948 <sbrkmuch+0x160>
    2898:	4501                	li	a0,0
    289a:	00003097          	auipc	ra,0x3
    289e:	032080e7          	jalr	50(ra) # 58cc <sbrk>
    28a2:	6785                	lui	a5,0x1
    28a4:	97a6                	add	a5,a5,s1
    28a6:	0af51163          	bne	a0,a5,2948 <sbrkmuch+0x160>
  if(*lastaddr == 99){
    28aa:	064007b7          	lui	a5,0x6400
    28ae:	fff7c703          	lbu	a4,-1(a5) # 63fffff <__BSS_END__+0x63f1217>
    28b2:	06300793          	li	a5,99
    28b6:	0af70963          	beq	a4,a5,2968 <sbrkmuch+0x180>
  a = sbrk(0);
    28ba:	4501                	li	a0,0
    28bc:	00003097          	auipc	ra,0x3
    28c0:	010080e7          	jalr	16(ra) # 58cc <sbrk>
    28c4:	84aa                	mv	s1,a0
  c = sbrk(-(sbrk(0) - oldbrk));
    28c6:	4501                	li	a0,0
    28c8:	00003097          	auipc	ra,0x3
    28cc:	004080e7          	jalr	4(ra) # 58cc <sbrk>
    28d0:	40a9053b          	subw	a0,s2,a0
    28d4:	00003097          	auipc	ra,0x3
    28d8:	ff8080e7          	jalr	-8(ra) # 58cc <sbrk>
  if(c != a){
    28dc:	0aa49463          	bne	s1,a0,2984 <sbrkmuch+0x19c>
}
    28e0:	70a2                	ld	ra,40(sp)
    28e2:	7402                	ld	s0,32(sp)
    28e4:	64e2                	ld	s1,24(sp)
    28e6:	6942                	ld	s2,16(sp)
    28e8:	69a2                	ld	s3,8(sp)
    28ea:	6a02                	ld	s4,0(sp)
    28ec:	6145                	addi	sp,sp,48
    28ee:	8082                	ret
    printf("%s: sbrk test failed to grow big address space; enough phys mem?\n", s);
    28f0:	85ce                	mv	a1,s3
    28f2:	00004517          	auipc	a0,0x4
    28f6:	2ce50513          	addi	a0,a0,718 # 6bc0 <malloc+0xf4a>
    28fa:	00003097          	auipc	ra,0x3
    28fe:	2c4080e7          	jalr	708(ra) # 5bbe <printf>
    exit(1);
    2902:	4505                	li	a0,1
    2904:	00003097          	auipc	ra,0x3
    2908:	f40080e7          	jalr	-192(ra) # 5844 <exit>
    printf("%s: sbrk could not deallocate\n", s);
    290c:	85ce                	mv	a1,s3
    290e:	00004517          	auipc	a0,0x4
    2912:	2fa50513          	addi	a0,a0,762 # 6c08 <malloc+0xf92>
    2916:	00003097          	auipc	ra,0x3
    291a:	2a8080e7          	jalr	680(ra) # 5bbe <printf>
    exit(1);
    291e:	4505                	li	a0,1
    2920:	00003097          	auipc	ra,0x3
    2924:	f24080e7          	jalr	-220(ra) # 5844 <exit>
    printf("%s: sbrk deallocation produced wrong address, a %x c %x\n", s, a, c);
    2928:	86aa                	mv	a3,a0
    292a:	8626                	mv	a2,s1
    292c:	85ce                	mv	a1,s3
    292e:	00004517          	auipc	a0,0x4
    2932:	2fa50513          	addi	a0,a0,762 # 6c28 <malloc+0xfb2>
    2936:	00003097          	auipc	ra,0x3
    293a:	288080e7          	jalr	648(ra) # 5bbe <printf>
    exit(1);
    293e:	4505                	li	a0,1
    2940:	00003097          	auipc	ra,0x3
    2944:	f04080e7          	jalr	-252(ra) # 5844 <exit>
    printf("%s: sbrk re-allocation failed, a %x c %x\n", s, a, c);
    2948:	86d2                	mv	a3,s4
    294a:	8626                	mv	a2,s1
    294c:	85ce                	mv	a1,s3
    294e:	00004517          	auipc	a0,0x4
    2952:	31a50513          	addi	a0,a0,794 # 6c68 <malloc+0xff2>
    2956:	00003097          	auipc	ra,0x3
    295a:	268080e7          	jalr	616(ra) # 5bbe <printf>
    exit(1);
    295e:	4505                	li	a0,1
    2960:	00003097          	auipc	ra,0x3
    2964:	ee4080e7          	jalr	-284(ra) # 5844 <exit>
    printf("%s: sbrk de-allocation didn't really deallocate\n", s);
    2968:	85ce                	mv	a1,s3
    296a:	00004517          	auipc	a0,0x4
    296e:	32e50513          	addi	a0,a0,814 # 6c98 <malloc+0x1022>
    2972:	00003097          	auipc	ra,0x3
    2976:	24c080e7          	jalr	588(ra) # 5bbe <printf>
    exit(1);
    297a:	4505                	li	a0,1
    297c:	00003097          	auipc	ra,0x3
    2980:	ec8080e7          	jalr	-312(ra) # 5844 <exit>
    printf("%s: sbrk downsize failed, a %x c %x\n", s, a, c);
    2984:	86aa                	mv	a3,a0
    2986:	8626                	mv	a2,s1
    2988:	85ce                	mv	a1,s3
    298a:	00004517          	auipc	a0,0x4
    298e:	34650513          	addi	a0,a0,838 # 6cd0 <malloc+0x105a>
    2992:	00003097          	auipc	ra,0x3
    2996:	22c080e7          	jalr	556(ra) # 5bbe <printf>
    exit(1);
    299a:	4505                	li	a0,1
    299c:	00003097          	auipc	ra,0x3
    29a0:	ea8080e7          	jalr	-344(ra) # 5844 <exit>

00000000000029a4 <sbrkarg>:
{
    29a4:	7179                	addi	sp,sp,-48
    29a6:	f406                	sd	ra,40(sp)
    29a8:	f022                	sd	s0,32(sp)
    29aa:	ec26                	sd	s1,24(sp)
    29ac:	e84a                	sd	s2,16(sp)
    29ae:	e44e                	sd	s3,8(sp)
    29b0:	1800                	addi	s0,sp,48
    29b2:	89aa                	mv	s3,a0
  a = sbrk(PGSIZE);
    29b4:	6505                	lui	a0,0x1
    29b6:	00003097          	auipc	ra,0x3
    29ba:	f16080e7          	jalr	-234(ra) # 58cc <sbrk>
    29be:	892a                	mv	s2,a0
  fd = open("sbrk", O_CREATE|O_WRONLY);
    29c0:	20100593          	li	a1,513
    29c4:	00004517          	auipc	a0,0x4
    29c8:	33450513          	addi	a0,a0,820 # 6cf8 <malloc+0x1082>
    29cc:	00003097          	auipc	ra,0x3
    29d0:	eb8080e7          	jalr	-328(ra) # 5884 <open>
    29d4:	84aa                	mv	s1,a0
  unlink("sbrk");
    29d6:	00004517          	auipc	a0,0x4
    29da:	32250513          	addi	a0,a0,802 # 6cf8 <malloc+0x1082>
    29de:	00003097          	auipc	ra,0x3
    29e2:	eb6080e7          	jalr	-330(ra) # 5894 <unlink>
  if(fd < 0)  {
    29e6:	0404c163          	bltz	s1,2a28 <sbrkarg+0x84>
  if ((n = write(fd, a, PGSIZE)) < 0) {
    29ea:	6605                	lui	a2,0x1
    29ec:	85ca                	mv	a1,s2
    29ee:	8526                	mv	a0,s1
    29f0:	00003097          	auipc	ra,0x3
    29f4:	e74080e7          	jalr	-396(ra) # 5864 <write>
    29f8:	04054663          	bltz	a0,2a44 <sbrkarg+0xa0>
  close(fd);
    29fc:	8526                	mv	a0,s1
    29fe:	00003097          	auipc	ra,0x3
    2a02:	e6e080e7          	jalr	-402(ra) # 586c <close>
  a = sbrk(PGSIZE);
    2a06:	6505                	lui	a0,0x1
    2a08:	00003097          	auipc	ra,0x3
    2a0c:	ec4080e7          	jalr	-316(ra) # 58cc <sbrk>
  if(pipe((int *) a) != 0){
    2a10:	00003097          	auipc	ra,0x3
    2a14:	e44080e7          	jalr	-444(ra) # 5854 <pipe>
    2a18:	e521                	bnez	a0,2a60 <sbrkarg+0xbc>
}
    2a1a:	70a2                	ld	ra,40(sp)
    2a1c:	7402                	ld	s0,32(sp)
    2a1e:	64e2                	ld	s1,24(sp)
    2a20:	6942                	ld	s2,16(sp)
    2a22:	69a2                	ld	s3,8(sp)
    2a24:	6145                	addi	sp,sp,48
    2a26:	8082                	ret
    printf("%s: open sbrk failed\n", s);
    2a28:	85ce                	mv	a1,s3
    2a2a:	00004517          	auipc	a0,0x4
    2a2e:	2d650513          	addi	a0,a0,726 # 6d00 <malloc+0x108a>
    2a32:	00003097          	auipc	ra,0x3
    2a36:	18c080e7          	jalr	396(ra) # 5bbe <printf>
    exit(1);
    2a3a:	4505                	li	a0,1
    2a3c:	00003097          	auipc	ra,0x3
    2a40:	e08080e7          	jalr	-504(ra) # 5844 <exit>
    printf("%s: write sbrk failed\n", s);
    2a44:	85ce                	mv	a1,s3
    2a46:	00004517          	auipc	a0,0x4
    2a4a:	2d250513          	addi	a0,a0,722 # 6d18 <malloc+0x10a2>
    2a4e:	00003097          	auipc	ra,0x3
    2a52:	170080e7          	jalr	368(ra) # 5bbe <printf>
    exit(1);
    2a56:	4505                	li	a0,1
    2a58:	00003097          	auipc	ra,0x3
    2a5c:	dec080e7          	jalr	-532(ra) # 5844 <exit>
    printf("%s: pipe() failed\n", s);
    2a60:	85ce                	mv	a1,s3
    2a62:	00004517          	auipc	a0,0x4
    2a66:	c9650513          	addi	a0,a0,-874 # 66f8 <malloc+0xa82>
    2a6a:	00003097          	auipc	ra,0x3
    2a6e:	154080e7          	jalr	340(ra) # 5bbe <printf>
    exit(1);
    2a72:	4505                	li	a0,1
    2a74:	00003097          	auipc	ra,0x3
    2a78:	dd0080e7          	jalr	-560(ra) # 5844 <exit>

0000000000002a7c <argptest>:
{
    2a7c:	1101                	addi	sp,sp,-32
    2a7e:	ec06                	sd	ra,24(sp)
    2a80:	e822                	sd	s0,16(sp)
    2a82:	e426                	sd	s1,8(sp)
    2a84:	e04a                	sd	s2,0(sp)
    2a86:	1000                	addi	s0,sp,32
    2a88:	892a                	mv	s2,a0
  fd = open("init", O_RDONLY);
    2a8a:	4581                	li	a1,0
    2a8c:	00004517          	auipc	a0,0x4
    2a90:	2a450513          	addi	a0,a0,676 # 6d30 <malloc+0x10ba>
    2a94:	00003097          	auipc	ra,0x3
    2a98:	df0080e7          	jalr	-528(ra) # 5884 <open>
  if (fd < 0) {
    2a9c:	02054b63          	bltz	a0,2ad2 <argptest+0x56>
    2aa0:	84aa                	mv	s1,a0
  read(fd, sbrk(0) - 1, -1);
    2aa2:	4501                	li	a0,0
    2aa4:	00003097          	auipc	ra,0x3
    2aa8:	e28080e7          	jalr	-472(ra) # 58cc <sbrk>
    2aac:	567d                	li	a2,-1
    2aae:	fff50593          	addi	a1,a0,-1
    2ab2:	8526                	mv	a0,s1
    2ab4:	00003097          	auipc	ra,0x3
    2ab8:	da8080e7          	jalr	-600(ra) # 585c <read>
  close(fd);
    2abc:	8526                	mv	a0,s1
    2abe:	00003097          	auipc	ra,0x3
    2ac2:	dae080e7          	jalr	-594(ra) # 586c <close>
}
    2ac6:	60e2                	ld	ra,24(sp)
    2ac8:	6442                	ld	s0,16(sp)
    2aca:	64a2                	ld	s1,8(sp)
    2acc:	6902                	ld	s2,0(sp)
    2ace:	6105                	addi	sp,sp,32
    2ad0:	8082                	ret
    printf("%s: open failed\n", s);
    2ad2:	85ca                	mv	a1,s2
    2ad4:	00004517          	auipc	a0,0x4
    2ad8:	b3450513          	addi	a0,a0,-1228 # 6608 <malloc+0x992>
    2adc:	00003097          	auipc	ra,0x3
    2ae0:	0e2080e7          	jalr	226(ra) # 5bbe <printf>
    exit(1);
    2ae4:	4505                	li	a0,1
    2ae6:	00003097          	auipc	ra,0x3
    2aea:	d5e080e7          	jalr	-674(ra) # 5844 <exit>

0000000000002aee <sbrkbugs>:
{
    2aee:	1141                	addi	sp,sp,-16
    2af0:	e406                	sd	ra,8(sp)
    2af2:	e022                	sd	s0,0(sp)
    2af4:	0800                	addi	s0,sp,16
  int pid = fork();
    2af6:	00003097          	auipc	ra,0x3
    2afa:	d46080e7          	jalr	-698(ra) # 583c <fork>
  if(pid < 0){
    2afe:	02054263          	bltz	a0,2b22 <sbrkbugs+0x34>
  if(pid == 0){
    2b02:	ed0d                	bnez	a0,2b3c <sbrkbugs+0x4e>
    int sz = (uint64) sbrk(0);
    2b04:	00003097          	auipc	ra,0x3
    2b08:	dc8080e7          	jalr	-568(ra) # 58cc <sbrk>
    sbrk(-sz);
    2b0c:	40a0053b          	negw	a0,a0
    2b10:	00003097          	auipc	ra,0x3
    2b14:	dbc080e7          	jalr	-580(ra) # 58cc <sbrk>
    exit(0);
    2b18:	4501                	li	a0,0
    2b1a:	00003097          	auipc	ra,0x3
    2b1e:	d2a080e7          	jalr	-726(ra) # 5844 <exit>
    printf("fork failed\n");
    2b22:	00004517          	auipc	a0,0x4
    2b26:	eee50513          	addi	a0,a0,-274 # 6a10 <malloc+0xd9a>
    2b2a:	00003097          	auipc	ra,0x3
    2b2e:	094080e7          	jalr	148(ra) # 5bbe <printf>
    exit(1);
    2b32:	4505                	li	a0,1
    2b34:	00003097          	auipc	ra,0x3
    2b38:	d10080e7          	jalr	-752(ra) # 5844 <exit>
  wait(0);
    2b3c:	4501                	li	a0,0
    2b3e:	00003097          	auipc	ra,0x3
    2b42:	d0e080e7          	jalr	-754(ra) # 584c <wait>
  pid = fork();
    2b46:	00003097          	auipc	ra,0x3
    2b4a:	cf6080e7          	jalr	-778(ra) # 583c <fork>
  if(pid < 0){
    2b4e:	02054563          	bltz	a0,2b78 <sbrkbugs+0x8a>
  if(pid == 0){
    2b52:	e121                	bnez	a0,2b92 <sbrkbugs+0xa4>
    int sz = (uint64) sbrk(0);
    2b54:	00003097          	auipc	ra,0x3
    2b58:	d78080e7          	jalr	-648(ra) # 58cc <sbrk>
    sbrk(-(sz - 3500));
    2b5c:	6785                	lui	a5,0x1
    2b5e:	dac7879b          	addiw	a5,a5,-596 # dac <linktest+0x96>
    2b62:	40a7853b          	subw	a0,a5,a0
    2b66:	00003097          	auipc	ra,0x3
    2b6a:	d66080e7          	jalr	-666(ra) # 58cc <sbrk>
    exit(0);
    2b6e:	4501                	li	a0,0
    2b70:	00003097          	auipc	ra,0x3
    2b74:	cd4080e7          	jalr	-812(ra) # 5844 <exit>
    printf("fork failed\n");
    2b78:	00004517          	auipc	a0,0x4
    2b7c:	e9850513          	addi	a0,a0,-360 # 6a10 <malloc+0xd9a>
    2b80:	00003097          	auipc	ra,0x3
    2b84:	03e080e7          	jalr	62(ra) # 5bbe <printf>
    exit(1);
    2b88:	4505                	li	a0,1
    2b8a:	00003097          	auipc	ra,0x3
    2b8e:	cba080e7          	jalr	-838(ra) # 5844 <exit>
  wait(0);
    2b92:	4501                	li	a0,0
    2b94:	00003097          	auipc	ra,0x3
    2b98:	cb8080e7          	jalr	-840(ra) # 584c <wait>
  pid = fork();
    2b9c:	00003097          	auipc	ra,0x3
    2ba0:	ca0080e7          	jalr	-864(ra) # 583c <fork>
  if(pid < 0){
    2ba4:	02054a63          	bltz	a0,2bd8 <sbrkbugs+0xea>
  if(pid == 0){
    2ba8:	e529                	bnez	a0,2bf2 <sbrkbugs+0x104>
    sbrk((10*4096 + 2048) - (uint64)sbrk(0));
    2baa:	00003097          	auipc	ra,0x3
    2bae:	d22080e7          	jalr	-734(ra) # 58cc <sbrk>
    2bb2:	67ad                	lui	a5,0xb
    2bb4:	8007879b          	addiw	a5,a5,-2048 # a800 <uninit+0x1138>
    2bb8:	40a7853b          	subw	a0,a5,a0
    2bbc:	00003097          	auipc	ra,0x3
    2bc0:	d10080e7          	jalr	-752(ra) # 58cc <sbrk>
    sbrk(-10);
    2bc4:	5559                	li	a0,-10
    2bc6:	00003097          	auipc	ra,0x3
    2bca:	d06080e7          	jalr	-762(ra) # 58cc <sbrk>
    exit(0);
    2bce:	4501                	li	a0,0
    2bd0:	00003097          	auipc	ra,0x3
    2bd4:	c74080e7          	jalr	-908(ra) # 5844 <exit>
    printf("fork failed\n");
    2bd8:	00004517          	auipc	a0,0x4
    2bdc:	e3850513          	addi	a0,a0,-456 # 6a10 <malloc+0xd9a>
    2be0:	00003097          	auipc	ra,0x3
    2be4:	fde080e7          	jalr	-34(ra) # 5bbe <printf>
    exit(1);
    2be8:	4505                	li	a0,1
    2bea:	00003097          	auipc	ra,0x3
    2bee:	c5a080e7          	jalr	-934(ra) # 5844 <exit>
  wait(0);
    2bf2:	4501                	li	a0,0
    2bf4:	00003097          	auipc	ra,0x3
    2bf8:	c58080e7          	jalr	-936(ra) # 584c <wait>
  exit(0);
    2bfc:	4501                	li	a0,0
    2bfe:	00003097          	auipc	ra,0x3
    2c02:	c46080e7          	jalr	-954(ra) # 5844 <exit>

0000000000002c06 <sbrklast>:
{
    2c06:	7179                	addi	sp,sp,-48
    2c08:	f406                	sd	ra,40(sp)
    2c0a:	f022                	sd	s0,32(sp)
    2c0c:	ec26                	sd	s1,24(sp)
    2c0e:	e84a                	sd	s2,16(sp)
    2c10:	e44e                	sd	s3,8(sp)
    2c12:	e052                	sd	s4,0(sp)
    2c14:	1800                	addi	s0,sp,48
  uint64 top = (uint64) sbrk(0);
    2c16:	4501                	li	a0,0
    2c18:	00003097          	auipc	ra,0x3
    2c1c:	cb4080e7          	jalr	-844(ra) # 58cc <sbrk>
  if((top % 4096) != 0)
    2c20:	03451793          	slli	a5,a0,0x34
    2c24:	ebd9                	bnez	a5,2cba <sbrklast+0xb4>
  sbrk(4096);
    2c26:	6505                	lui	a0,0x1
    2c28:	00003097          	auipc	ra,0x3
    2c2c:	ca4080e7          	jalr	-860(ra) # 58cc <sbrk>
  sbrk(10);
    2c30:	4529                	li	a0,10
    2c32:	00003097          	auipc	ra,0x3
    2c36:	c9a080e7          	jalr	-870(ra) # 58cc <sbrk>
  sbrk(-20);
    2c3a:	5531                	li	a0,-20
    2c3c:	00003097          	auipc	ra,0x3
    2c40:	c90080e7          	jalr	-880(ra) # 58cc <sbrk>
  top = (uint64) sbrk(0);
    2c44:	4501                	li	a0,0
    2c46:	00003097          	auipc	ra,0x3
    2c4a:	c86080e7          	jalr	-890(ra) # 58cc <sbrk>
    2c4e:	84aa                	mv	s1,a0
  char *p = (char *) (top - 64);
    2c50:	fc050913          	addi	s2,a0,-64 # fc0 <bigdir+0x5e>
  p[0] = 'x';
    2c54:	07800a13          	li	s4,120
    2c58:	fd450023          	sb	s4,-64(a0)
  p[1] = '\0';
    2c5c:	fc0500a3          	sb	zero,-63(a0)
  int fd = open(p, O_RDWR|O_CREATE);
    2c60:	20200593          	li	a1,514
    2c64:	854a                	mv	a0,s2
    2c66:	00003097          	auipc	ra,0x3
    2c6a:	c1e080e7          	jalr	-994(ra) # 5884 <open>
    2c6e:	89aa                	mv	s3,a0
  write(fd, p, 1);
    2c70:	4605                	li	a2,1
    2c72:	85ca                	mv	a1,s2
    2c74:	00003097          	auipc	ra,0x3
    2c78:	bf0080e7          	jalr	-1040(ra) # 5864 <write>
  close(fd);
    2c7c:	854e                	mv	a0,s3
    2c7e:	00003097          	auipc	ra,0x3
    2c82:	bee080e7          	jalr	-1042(ra) # 586c <close>
  fd = open(p, O_RDWR);
    2c86:	4589                	li	a1,2
    2c88:	854a                	mv	a0,s2
    2c8a:	00003097          	auipc	ra,0x3
    2c8e:	bfa080e7          	jalr	-1030(ra) # 5884 <open>
  p[0] = '\0';
    2c92:	fc048023          	sb	zero,-64(s1)
  read(fd, p, 1);
    2c96:	4605                	li	a2,1
    2c98:	85ca                	mv	a1,s2
    2c9a:	00003097          	auipc	ra,0x3
    2c9e:	bc2080e7          	jalr	-1086(ra) # 585c <read>
  if(p[0] != 'x')
    2ca2:	fc04c783          	lbu	a5,-64(s1)
    2ca6:	03479463          	bne	a5,s4,2cce <sbrklast+0xc8>
}
    2caa:	70a2                	ld	ra,40(sp)
    2cac:	7402                	ld	s0,32(sp)
    2cae:	64e2                	ld	s1,24(sp)
    2cb0:	6942                	ld	s2,16(sp)
    2cb2:	69a2                	ld	s3,8(sp)
    2cb4:	6a02                	ld	s4,0(sp)
    2cb6:	6145                	addi	sp,sp,48
    2cb8:	8082                	ret
    sbrk(4096 - (top % 4096));
    2cba:	0347d513          	srli	a0,a5,0x34
    2cbe:	6785                	lui	a5,0x1
    2cc0:	40a7853b          	subw	a0,a5,a0
    2cc4:	00003097          	auipc	ra,0x3
    2cc8:	c08080e7          	jalr	-1016(ra) # 58cc <sbrk>
    2ccc:	bfa9                	j	2c26 <sbrklast+0x20>
    exit(1);
    2cce:	4505                	li	a0,1
    2cd0:	00003097          	auipc	ra,0x3
    2cd4:	b74080e7          	jalr	-1164(ra) # 5844 <exit>

0000000000002cd8 <sbrk8000>:
{
    2cd8:	1141                	addi	sp,sp,-16
    2cda:	e406                	sd	ra,8(sp)
    2cdc:	e022                	sd	s0,0(sp)
    2cde:	0800                	addi	s0,sp,16
  sbrk(0x80000004);
    2ce0:	80000537          	lui	a0,0x80000
    2ce4:	0511                	addi	a0,a0,4 # ffffffff80000004 <__BSS_END__+0xffffffff7fff121c>
    2ce6:	00003097          	auipc	ra,0x3
    2cea:	be6080e7          	jalr	-1050(ra) # 58cc <sbrk>
  volatile char *top = sbrk(0);
    2cee:	4501                	li	a0,0
    2cf0:	00003097          	auipc	ra,0x3
    2cf4:	bdc080e7          	jalr	-1060(ra) # 58cc <sbrk>
  *(top-1) = *(top-1) + 1;
    2cf8:	fff54783          	lbu	a5,-1(a0)
    2cfc:	2785                	addiw	a5,a5,1 # 1001 <bigdir+0x9f>
    2cfe:	0ff7f793          	zext.b	a5,a5
    2d02:	fef50fa3          	sb	a5,-1(a0)
}
    2d06:	60a2                	ld	ra,8(sp)
    2d08:	6402                	ld	s0,0(sp)
    2d0a:	0141                	addi	sp,sp,16
    2d0c:	8082                	ret

0000000000002d0e <execout>:
// test the exec() code that cleans up if it runs out
// of memory. it's really a test that such a condition
// doesn't cause a panic.
void
execout(char *s)
{
    2d0e:	715d                	addi	sp,sp,-80
    2d10:	e486                	sd	ra,72(sp)
    2d12:	e0a2                	sd	s0,64(sp)
    2d14:	fc26                	sd	s1,56(sp)
    2d16:	f84a                	sd	s2,48(sp)
    2d18:	f44e                	sd	s3,40(sp)
    2d1a:	f052                	sd	s4,32(sp)
    2d1c:	0880                	addi	s0,sp,80
  for(int avail = 0; avail < 15; avail++){
    2d1e:	4901                	li	s2,0
    2d20:	49bd                	li	s3,15
    int pid = fork();
    2d22:	00003097          	auipc	ra,0x3
    2d26:	b1a080e7          	jalr	-1254(ra) # 583c <fork>
    2d2a:	84aa                	mv	s1,a0
    if(pid < 0){
    2d2c:	02054063          	bltz	a0,2d4c <execout+0x3e>
      printf("fork failed\n");
      exit(1);
    } else if(pid == 0){
    2d30:	c91d                	beqz	a0,2d66 <execout+0x58>
      close(1);
      char *args[] = { "echo", "x", 0 };
      exec("echo", args);
      exit(0);
    } else {
      wait((int*)0);
    2d32:	4501                	li	a0,0
    2d34:	00003097          	auipc	ra,0x3
    2d38:	b18080e7          	jalr	-1256(ra) # 584c <wait>
  for(int avail = 0; avail < 15; avail++){
    2d3c:	2905                	addiw	s2,s2,1
    2d3e:	ff3912e3          	bne	s2,s3,2d22 <execout+0x14>
    }
  }

  exit(0);
    2d42:	4501                	li	a0,0
    2d44:	00003097          	auipc	ra,0x3
    2d48:	b00080e7          	jalr	-1280(ra) # 5844 <exit>
      printf("fork failed\n");
    2d4c:	00004517          	auipc	a0,0x4
    2d50:	cc450513          	addi	a0,a0,-828 # 6a10 <malloc+0xd9a>
    2d54:	00003097          	auipc	ra,0x3
    2d58:	e6a080e7          	jalr	-406(ra) # 5bbe <printf>
      exit(1);
    2d5c:	4505                	li	a0,1
    2d5e:	00003097          	auipc	ra,0x3
    2d62:	ae6080e7          	jalr	-1306(ra) # 5844 <exit>
        if(a == 0xffffffffffffffffLL)
    2d66:	59fd                	li	s3,-1
        *(char*)(a + 4096 - 1) = 1;
    2d68:	4a05                	li	s4,1
        uint64 a = (uint64) sbrk(4096);
    2d6a:	6505                	lui	a0,0x1
    2d6c:	00003097          	auipc	ra,0x3
    2d70:	b60080e7          	jalr	-1184(ra) # 58cc <sbrk>
        if(a == 0xffffffffffffffffLL)
    2d74:	01350763          	beq	a0,s3,2d82 <execout+0x74>
        *(char*)(a + 4096 - 1) = 1;
    2d78:	6785                	lui	a5,0x1
    2d7a:	97aa                	add	a5,a5,a0
    2d7c:	ff478fa3          	sb	s4,-1(a5) # fff <bigdir+0x9d>
      while(1){
    2d80:	b7ed                	j	2d6a <execout+0x5c>
      for(int i = 0; i < avail; i++)
    2d82:	01205a63          	blez	s2,2d96 <execout+0x88>
        sbrk(-4096);
    2d86:	757d                	lui	a0,0xfffff
    2d88:	00003097          	auipc	ra,0x3
    2d8c:	b44080e7          	jalr	-1212(ra) # 58cc <sbrk>
      for(int i = 0; i < avail; i++)
    2d90:	2485                	addiw	s1,s1,1
    2d92:	ff249ae3          	bne	s1,s2,2d86 <execout+0x78>
      close(1);
    2d96:	4505                	li	a0,1
    2d98:	00003097          	auipc	ra,0x3
    2d9c:	ad4080e7          	jalr	-1324(ra) # 586c <close>
      char *args[] = { "echo", "x", 0 };
    2da0:	00003517          	auipc	a0,0x3
    2da4:	ff850513          	addi	a0,a0,-8 # 5d98 <malloc+0x122>
    2da8:	faa43c23          	sd	a0,-72(s0)
    2dac:	00003797          	auipc	a5,0x3
    2db0:	05c78793          	addi	a5,a5,92 # 5e08 <malloc+0x192>
    2db4:	fcf43023          	sd	a5,-64(s0)
    2db8:	fc043423          	sd	zero,-56(s0)
      exec("echo", args);
    2dbc:	fb840593          	addi	a1,s0,-72
    2dc0:	00003097          	auipc	ra,0x3
    2dc4:	abc080e7          	jalr	-1348(ra) # 587c <exec>
      exit(0);
    2dc8:	4501                	li	a0,0
    2dca:	00003097          	auipc	ra,0x3
    2dce:	a7a080e7          	jalr	-1414(ra) # 5844 <exit>

0000000000002dd2 <fourteen>:
{
    2dd2:	1101                	addi	sp,sp,-32
    2dd4:	ec06                	sd	ra,24(sp)
    2dd6:	e822                	sd	s0,16(sp)
    2dd8:	e426                	sd	s1,8(sp)
    2dda:	1000                	addi	s0,sp,32
    2ddc:	84aa                	mv	s1,a0
  if(mkdir("12345678901234") != 0){
    2dde:	00004517          	auipc	a0,0x4
    2de2:	12a50513          	addi	a0,a0,298 # 6f08 <malloc+0x1292>
    2de6:	00003097          	auipc	ra,0x3
    2dea:	ac6080e7          	jalr	-1338(ra) # 58ac <mkdir>
    2dee:	e165                	bnez	a0,2ece <fourteen+0xfc>
  if(mkdir("12345678901234/123456789012345") != 0){
    2df0:	00004517          	auipc	a0,0x4
    2df4:	f7050513          	addi	a0,a0,-144 # 6d60 <malloc+0x10ea>
    2df8:	00003097          	auipc	ra,0x3
    2dfc:	ab4080e7          	jalr	-1356(ra) # 58ac <mkdir>
    2e00:	e56d                	bnez	a0,2eea <fourteen+0x118>
  fd = open("123456789012345/123456789012345/123456789012345", O_CREATE);
    2e02:	20000593          	li	a1,512
    2e06:	00004517          	auipc	a0,0x4
    2e0a:	fb250513          	addi	a0,a0,-78 # 6db8 <malloc+0x1142>
    2e0e:	00003097          	auipc	ra,0x3
    2e12:	a76080e7          	jalr	-1418(ra) # 5884 <open>
  if(fd < 0){
    2e16:	0e054863          	bltz	a0,2f06 <fourteen+0x134>
  close(fd);
    2e1a:	00003097          	auipc	ra,0x3
    2e1e:	a52080e7          	jalr	-1454(ra) # 586c <close>
  fd = open("12345678901234/12345678901234/12345678901234", 0);
    2e22:	4581                	li	a1,0
    2e24:	00004517          	auipc	a0,0x4
    2e28:	00c50513          	addi	a0,a0,12 # 6e30 <malloc+0x11ba>
    2e2c:	00003097          	auipc	ra,0x3
    2e30:	a58080e7          	jalr	-1448(ra) # 5884 <open>
  if(fd < 0){
    2e34:	0e054763          	bltz	a0,2f22 <fourteen+0x150>
  close(fd);
    2e38:	00003097          	auipc	ra,0x3
    2e3c:	a34080e7          	jalr	-1484(ra) # 586c <close>
  if(mkdir("12345678901234/12345678901234") == 0){
    2e40:	00004517          	auipc	a0,0x4
    2e44:	06050513          	addi	a0,a0,96 # 6ea0 <malloc+0x122a>
    2e48:	00003097          	auipc	ra,0x3
    2e4c:	a64080e7          	jalr	-1436(ra) # 58ac <mkdir>
    2e50:	c57d                	beqz	a0,2f3e <fourteen+0x16c>
  if(mkdir("123456789012345/12345678901234") == 0){
    2e52:	00004517          	auipc	a0,0x4
    2e56:	0a650513          	addi	a0,a0,166 # 6ef8 <malloc+0x1282>
    2e5a:	00003097          	auipc	ra,0x3
    2e5e:	a52080e7          	jalr	-1454(ra) # 58ac <mkdir>
    2e62:	cd65                	beqz	a0,2f5a <fourteen+0x188>
  unlink("123456789012345/12345678901234");
    2e64:	00004517          	auipc	a0,0x4
    2e68:	09450513          	addi	a0,a0,148 # 6ef8 <malloc+0x1282>
    2e6c:	00003097          	auipc	ra,0x3
    2e70:	a28080e7          	jalr	-1496(ra) # 5894 <unlink>
  unlink("12345678901234/12345678901234");
    2e74:	00004517          	auipc	a0,0x4
    2e78:	02c50513          	addi	a0,a0,44 # 6ea0 <malloc+0x122a>
    2e7c:	00003097          	auipc	ra,0x3
    2e80:	a18080e7          	jalr	-1512(ra) # 5894 <unlink>
  unlink("12345678901234/12345678901234/12345678901234");
    2e84:	00004517          	auipc	a0,0x4
    2e88:	fac50513          	addi	a0,a0,-84 # 6e30 <malloc+0x11ba>
    2e8c:	00003097          	auipc	ra,0x3
    2e90:	a08080e7          	jalr	-1528(ra) # 5894 <unlink>
  unlink("123456789012345/123456789012345/123456789012345");
    2e94:	00004517          	auipc	a0,0x4
    2e98:	f2450513          	addi	a0,a0,-220 # 6db8 <malloc+0x1142>
    2e9c:	00003097          	auipc	ra,0x3
    2ea0:	9f8080e7          	jalr	-1544(ra) # 5894 <unlink>
  unlink("12345678901234/123456789012345");
    2ea4:	00004517          	auipc	a0,0x4
    2ea8:	ebc50513          	addi	a0,a0,-324 # 6d60 <malloc+0x10ea>
    2eac:	00003097          	auipc	ra,0x3
    2eb0:	9e8080e7          	jalr	-1560(ra) # 5894 <unlink>
  unlink("12345678901234");
    2eb4:	00004517          	auipc	a0,0x4
    2eb8:	05450513          	addi	a0,a0,84 # 6f08 <malloc+0x1292>
    2ebc:	00003097          	auipc	ra,0x3
    2ec0:	9d8080e7          	jalr	-1576(ra) # 5894 <unlink>
}
    2ec4:	60e2                	ld	ra,24(sp)
    2ec6:	6442                	ld	s0,16(sp)
    2ec8:	64a2                	ld	s1,8(sp)
    2eca:	6105                	addi	sp,sp,32
    2ecc:	8082                	ret
    printf("%s: mkdir 12345678901234 failed\n", s);
    2ece:	85a6                	mv	a1,s1
    2ed0:	00004517          	auipc	a0,0x4
    2ed4:	e6850513          	addi	a0,a0,-408 # 6d38 <malloc+0x10c2>
    2ed8:	00003097          	auipc	ra,0x3
    2edc:	ce6080e7          	jalr	-794(ra) # 5bbe <printf>
    exit(1);
    2ee0:	4505                	li	a0,1
    2ee2:	00003097          	auipc	ra,0x3
    2ee6:	962080e7          	jalr	-1694(ra) # 5844 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 failed\n", s);
    2eea:	85a6                	mv	a1,s1
    2eec:	00004517          	auipc	a0,0x4
    2ef0:	e9450513          	addi	a0,a0,-364 # 6d80 <malloc+0x110a>
    2ef4:	00003097          	auipc	ra,0x3
    2ef8:	cca080e7          	jalr	-822(ra) # 5bbe <printf>
    exit(1);
    2efc:	4505                	li	a0,1
    2efe:	00003097          	auipc	ra,0x3
    2f02:	946080e7          	jalr	-1722(ra) # 5844 <exit>
    printf("%s: create 123456789012345/123456789012345/123456789012345 failed\n", s);
    2f06:	85a6                	mv	a1,s1
    2f08:	00004517          	auipc	a0,0x4
    2f0c:	ee050513          	addi	a0,a0,-288 # 6de8 <malloc+0x1172>
    2f10:	00003097          	auipc	ra,0x3
    2f14:	cae080e7          	jalr	-850(ra) # 5bbe <printf>
    exit(1);
    2f18:	4505                	li	a0,1
    2f1a:	00003097          	auipc	ra,0x3
    2f1e:	92a080e7          	jalr	-1750(ra) # 5844 <exit>
    printf("%s: open 12345678901234/12345678901234/12345678901234 failed\n", s);
    2f22:	85a6                	mv	a1,s1
    2f24:	00004517          	auipc	a0,0x4
    2f28:	f3c50513          	addi	a0,a0,-196 # 6e60 <malloc+0x11ea>
    2f2c:	00003097          	auipc	ra,0x3
    2f30:	c92080e7          	jalr	-878(ra) # 5bbe <printf>
    exit(1);
    2f34:	4505                	li	a0,1
    2f36:	00003097          	auipc	ra,0x3
    2f3a:	90e080e7          	jalr	-1778(ra) # 5844 <exit>
    printf("%s: mkdir 12345678901234/12345678901234 succeeded!\n", s);
    2f3e:	85a6                	mv	a1,s1
    2f40:	00004517          	auipc	a0,0x4
    2f44:	f8050513          	addi	a0,a0,-128 # 6ec0 <malloc+0x124a>
    2f48:	00003097          	auipc	ra,0x3
    2f4c:	c76080e7          	jalr	-906(ra) # 5bbe <printf>
    exit(1);
    2f50:	4505                	li	a0,1
    2f52:	00003097          	auipc	ra,0x3
    2f56:	8f2080e7          	jalr	-1806(ra) # 5844 <exit>
    printf("%s: mkdir 12345678901234/123456789012345 succeeded!\n", s);
    2f5a:	85a6                	mv	a1,s1
    2f5c:	00004517          	auipc	a0,0x4
    2f60:	fbc50513          	addi	a0,a0,-68 # 6f18 <malloc+0x12a2>
    2f64:	00003097          	auipc	ra,0x3
    2f68:	c5a080e7          	jalr	-934(ra) # 5bbe <printf>
    exit(1);
    2f6c:	4505                	li	a0,1
    2f6e:	00003097          	auipc	ra,0x3
    2f72:	8d6080e7          	jalr	-1834(ra) # 5844 <exit>

0000000000002f76 <iputtest>:
{
    2f76:	1101                	addi	sp,sp,-32
    2f78:	ec06                	sd	ra,24(sp)
    2f7a:	e822                	sd	s0,16(sp)
    2f7c:	e426                	sd	s1,8(sp)
    2f7e:	1000                	addi	s0,sp,32
    2f80:	84aa                	mv	s1,a0
  if(mkdir("iputdir") < 0){
    2f82:	00004517          	auipc	a0,0x4
    2f86:	fce50513          	addi	a0,a0,-50 # 6f50 <malloc+0x12da>
    2f8a:	00003097          	auipc	ra,0x3
    2f8e:	922080e7          	jalr	-1758(ra) # 58ac <mkdir>
    2f92:	04054563          	bltz	a0,2fdc <iputtest+0x66>
  if(chdir("iputdir") < 0){
    2f96:	00004517          	auipc	a0,0x4
    2f9a:	fba50513          	addi	a0,a0,-70 # 6f50 <malloc+0x12da>
    2f9e:	00003097          	auipc	ra,0x3
    2fa2:	916080e7          	jalr	-1770(ra) # 58b4 <chdir>
    2fa6:	04054963          	bltz	a0,2ff8 <iputtest+0x82>
  if(unlink("../iputdir") < 0){
    2faa:	00004517          	auipc	a0,0x4
    2fae:	fe650513          	addi	a0,a0,-26 # 6f90 <malloc+0x131a>
    2fb2:	00003097          	auipc	ra,0x3
    2fb6:	8e2080e7          	jalr	-1822(ra) # 5894 <unlink>
    2fba:	04054d63          	bltz	a0,3014 <iputtest+0x9e>
  if(chdir("/") < 0){
    2fbe:	00004517          	auipc	a0,0x4
    2fc2:	00250513          	addi	a0,a0,2 # 6fc0 <malloc+0x134a>
    2fc6:	00003097          	auipc	ra,0x3
    2fca:	8ee080e7          	jalr	-1810(ra) # 58b4 <chdir>
    2fce:	06054163          	bltz	a0,3030 <iputtest+0xba>
}
    2fd2:	60e2                	ld	ra,24(sp)
    2fd4:	6442                	ld	s0,16(sp)
    2fd6:	64a2                	ld	s1,8(sp)
    2fd8:	6105                	addi	sp,sp,32
    2fda:	8082                	ret
    printf("%s: mkdir failed\n", s);
    2fdc:	85a6                	mv	a1,s1
    2fde:	00004517          	auipc	a0,0x4
    2fe2:	f7a50513          	addi	a0,a0,-134 # 6f58 <malloc+0x12e2>
    2fe6:	00003097          	auipc	ra,0x3
    2fea:	bd8080e7          	jalr	-1064(ra) # 5bbe <printf>
    exit(1);
    2fee:	4505                	li	a0,1
    2ff0:	00003097          	auipc	ra,0x3
    2ff4:	854080e7          	jalr	-1964(ra) # 5844 <exit>
    printf("%s: chdir iputdir failed\n", s);
    2ff8:	85a6                	mv	a1,s1
    2ffa:	00004517          	auipc	a0,0x4
    2ffe:	f7650513          	addi	a0,a0,-138 # 6f70 <malloc+0x12fa>
    3002:	00003097          	auipc	ra,0x3
    3006:	bbc080e7          	jalr	-1092(ra) # 5bbe <printf>
    exit(1);
    300a:	4505                	li	a0,1
    300c:	00003097          	auipc	ra,0x3
    3010:	838080e7          	jalr	-1992(ra) # 5844 <exit>
    printf("%s: unlink ../iputdir failed\n", s);
    3014:	85a6                	mv	a1,s1
    3016:	00004517          	auipc	a0,0x4
    301a:	f8a50513          	addi	a0,a0,-118 # 6fa0 <malloc+0x132a>
    301e:	00003097          	auipc	ra,0x3
    3022:	ba0080e7          	jalr	-1120(ra) # 5bbe <printf>
    exit(1);
    3026:	4505                	li	a0,1
    3028:	00003097          	auipc	ra,0x3
    302c:	81c080e7          	jalr	-2020(ra) # 5844 <exit>
    printf("%s: chdir / failed\n", s);
    3030:	85a6                	mv	a1,s1
    3032:	00004517          	auipc	a0,0x4
    3036:	f9650513          	addi	a0,a0,-106 # 6fc8 <malloc+0x1352>
    303a:	00003097          	auipc	ra,0x3
    303e:	b84080e7          	jalr	-1148(ra) # 5bbe <printf>
    exit(1);
    3042:	4505                	li	a0,1
    3044:	00003097          	auipc	ra,0x3
    3048:	800080e7          	jalr	-2048(ra) # 5844 <exit>

000000000000304c <exitiputtest>:
{
    304c:	7179                	addi	sp,sp,-48
    304e:	f406                	sd	ra,40(sp)
    3050:	f022                	sd	s0,32(sp)
    3052:	ec26                	sd	s1,24(sp)
    3054:	1800                	addi	s0,sp,48
    3056:	84aa                	mv	s1,a0
  pid = fork();
    3058:	00002097          	auipc	ra,0x2
    305c:	7e4080e7          	jalr	2020(ra) # 583c <fork>
  if(pid < 0){
    3060:	04054663          	bltz	a0,30ac <exitiputtest+0x60>
  if(pid == 0){
    3064:	ed45                	bnez	a0,311c <exitiputtest+0xd0>
    if(mkdir("iputdir") < 0){
    3066:	00004517          	auipc	a0,0x4
    306a:	eea50513          	addi	a0,a0,-278 # 6f50 <malloc+0x12da>
    306e:	00003097          	auipc	ra,0x3
    3072:	83e080e7          	jalr	-1986(ra) # 58ac <mkdir>
    3076:	04054963          	bltz	a0,30c8 <exitiputtest+0x7c>
    if(chdir("iputdir") < 0){
    307a:	00004517          	auipc	a0,0x4
    307e:	ed650513          	addi	a0,a0,-298 # 6f50 <malloc+0x12da>
    3082:	00003097          	auipc	ra,0x3
    3086:	832080e7          	jalr	-1998(ra) # 58b4 <chdir>
    308a:	04054d63          	bltz	a0,30e4 <exitiputtest+0x98>
    if(unlink("../iputdir") < 0){
    308e:	00004517          	auipc	a0,0x4
    3092:	f0250513          	addi	a0,a0,-254 # 6f90 <malloc+0x131a>
    3096:	00002097          	auipc	ra,0x2
    309a:	7fe080e7          	jalr	2046(ra) # 5894 <unlink>
    309e:	06054163          	bltz	a0,3100 <exitiputtest+0xb4>
    exit(0);
    30a2:	4501                	li	a0,0
    30a4:	00002097          	auipc	ra,0x2
    30a8:	7a0080e7          	jalr	1952(ra) # 5844 <exit>
    printf("%s: fork failed\n", s);
    30ac:	85a6                	mv	a1,s1
    30ae:	00003517          	auipc	a0,0x3
    30b2:	54250513          	addi	a0,a0,1346 # 65f0 <malloc+0x97a>
    30b6:	00003097          	auipc	ra,0x3
    30ba:	b08080e7          	jalr	-1272(ra) # 5bbe <printf>
    exit(1);
    30be:	4505                	li	a0,1
    30c0:	00002097          	auipc	ra,0x2
    30c4:	784080e7          	jalr	1924(ra) # 5844 <exit>
      printf("%s: mkdir failed\n", s);
    30c8:	85a6                	mv	a1,s1
    30ca:	00004517          	auipc	a0,0x4
    30ce:	e8e50513          	addi	a0,a0,-370 # 6f58 <malloc+0x12e2>
    30d2:	00003097          	auipc	ra,0x3
    30d6:	aec080e7          	jalr	-1300(ra) # 5bbe <printf>
      exit(1);
    30da:	4505                	li	a0,1
    30dc:	00002097          	auipc	ra,0x2
    30e0:	768080e7          	jalr	1896(ra) # 5844 <exit>
      printf("%s: child chdir failed\n", s);
    30e4:	85a6                	mv	a1,s1
    30e6:	00004517          	auipc	a0,0x4
    30ea:	efa50513          	addi	a0,a0,-262 # 6fe0 <malloc+0x136a>
    30ee:	00003097          	auipc	ra,0x3
    30f2:	ad0080e7          	jalr	-1328(ra) # 5bbe <printf>
      exit(1);
    30f6:	4505                	li	a0,1
    30f8:	00002097          	auipc	ra,0x2
    30fc:	74c080e7          	jalr	1868(ra) # 5844 <exit>
      printf("%s: unlink ../iputdir failed\n", s);
    3100:	85a6                	mv	a1,s1
    3102:	00004517          	auipc	a0,0x4
    3106:	e9e50513          	addi	a0,a0,-354 # 6fa0 <malloc+0x132a>
    310a:	00003097          	auipc	ra,0x3
    310e:	ab4080e7          	jalr	-1356(ra) # 5bbe <printf>
      exit(1);
    3112:	4505                	li	a0,1
    3114:	00002097          	auipc	ra,0x2
    3118:	730080e7          	jalr	1840(ra) # 5844 <exit>
  wait(&xstatus);
    311c:	fdc40513          	addi	a0,s0,-36
    3120:	00002097          	auipc	ra,0x2
    3124:	72c080e7          	jalr	1836(ra) # 584c <wait>
  exit(xstatus);
    3128:	fdc42503          	lw	a0,-36(s0)
    312c:	00002097          	auipc	ra,0x2
    3130:	718080e7          	jalr	1816(ra) # 5844 <exit>

0000000000003134 <dirtest>:
{
    3134:	1101                	addi	sp,sp,-32
    3136:	ec06                	sd	ra,24(sp)
    3138:	e822                	sd	s0,16(sp)
    313a:	e426                	sd	s1,8(sp)
    313c:	1000                	addi	s0,sp,32
    313e:	84aa                	mv	s1,a0
  if(mkdir("dir0") < 0){
    3140:	00004517          	auipc	a0,0x4
    3144:	eb850513          	addi	a0,a0,-328 # 6ff8 <malloc+0x1382>
    3148:	00002097          	auipc	ra,0x2
    314c:	764080e7          	jalr	1892(ra) # 58ac <mkdir>
    3150:	04054563          	bltz	a0,319a <dirtest+0x66>
  if(chdir("dir0") < 0){
    3154:	00004517          	auipc	a0,0x4
    3158:	ea450513          	addi	a0,a0,-348 # 6ff8 <malloc+0x1382>
    315c:	00002097          	auipc	ra,0x2
    3160:	758080e7          	jalr	1880(ra) # 58b4 <chdir>
    3164:	04054963          	bltz	a0,31b6 <dirtest+0x82>
  if(chdir("..") < 0){
    3168:	00004517          	auipc	a0,0x4
    316c:	eb050513          	addi	a0,a0,-336 # 7018 <malloc+0x13a2>
    3170:	00002097          	auipc	ra,0x2
    3174:	744080e7          	jalr	1860(ra) # 58b4 <chdir>
    3178:	04054d63          	bltz	a0,31d2 <dirtest+0x9e>
  if(unlink("dir0") < 0){
    317c:	00004517          	auipc	a0,0x4
    3180:	e7c50513          	addi	a0,a0,-388 # 6ff8 <malloc+0x1382>
    3184:	00002097          	auipc	ra,0x2
    3188:	710080e7          	jalr	1808(ra) # 5894 <unlink>
    318c:	06054163          	bltz	a0,31ee <dirtest+0xba>
}
    3190:	60e2                	ld	ra,24(sp)
    3192:	6442                	ld	s0,16(sp)
    3194:	64a2                	ld	s1,8(sp)
    3196:	6105                	addi	sp,sp,32
    3198:	8082                	ret
    printf("%s: mkdir failed\n", s);
    319a:	85a6                	mv	a1,s1
    319c:	00004517          	auipc	a0,0x4
    31a0:	dbc50513          	addi	a0,a0,-580 # 6f58 <malloc+0x12e2>
    31a4:	00003097          	auipc	ra,0x3
    31a8:	a1a080e7          	jalr	-1510(ra) # 5bbe <printf>
    exit(1);
    31ac:	4505                	li	a0,1
    31ae:	00002097          	auipc	ra,0x2
    31b2:	696080e7          	jalr	1686(ra) # 5844 <exit>
    printf("%s: chdir dir0 failed\n", s);
    31b6:	85a6                	mv	a1,s1
    31b8:	00004517          	auipc	a0,0x4
    31bc:	e4850513          	addi	a0,a0,-440 # 7000 <malloc+0x138a>
    31c0:	00003097          	auipc	ra,0x3
    31c4:	9fe080e7          	jalr	-1538(ra) # 5bbe <printf>
    exit(1);
    31c8:	4505                	li	a0,1
    31ca:	00002097          	auipc	ra,0x2
    31ce:	67a080e7          	jalr	1658(ra) # 5844 <exit>
    printf("%s: chdir .. failed\n", s);
    31d2:	85a6                	mv	a1,s1
    31d4:	00004517          	auipc	a0,0x4
    31d8:	e4c50513          	addi	a0,a0,-436 # 7020 <malloc+0x13aa>
    31dc:	00003097          	auipc	ra,0x3
    31e0:	9e2080e7          	jalr	-1566(ra) # 5bbe <printf>
    exit(1);
    31e4:	4505                	li	a0,1
    31e6:	00002097          	auipc	ra,0x2
    31ea:	65e080e7          	jalr	1630(ra) # 5844 <exit>
    printf("%s: unlink dir0 failed\n", s);
    31ee:	85a6                	mv	a1,s1
    31f0:	00004517          	auipc	a0,0x4
    31f4:	e4850513          	addi	a0,a0,-440 # 7038 <malloc+0x13c2>
    31f8:	00003097          	auipc	ra,0x3
    31fc:	9c6080e7          	jalr	-1594(ra) # 5bbe <printf>
    exit(1);
    3200:	4505                	li	a0,1
    3202:	00002097          	auipc	ra,0x2
    3206:	642080e7          	jalr	1602(ra) # 5844 <exit>

000000000000320a <subdir>:
{
    320a:	1101                	addi	sp,sp,-32
    320c:	ec06                	sd	ra,24(sp)
    320e:	e822                	sd	s0,16(sp)
    3210:	e426                	sd	s1,8(sp)
    3212:	e04a                	sd	s2,0(sp)
    3214:	1000                	addi	s0,sp,32
    3216:	892a                	mv	s2,a0
  unlink("ff");
    3218:	00004517          	auipc	a0,0x4
    321c:	f6850513          	addi	a0,a0,-152 # 7180 <malloc+0x150a>
    3220:	00002097          	auipc	ra,0x2
    3224:	674080e7          	jalr	1652(ra) # 5894 <unlink>
  if(mkdir("dd") != 0){
    3228:	00004517          	auipc	a0,0x4
    322c:	e2850513          	addi	a0,a0,-472 # 7050 <malloc+0x13da>
    3230:	00002097          	auipc	ra,0x2
    3234:	67c080e7          	jalr	1660(ra) # 58ac <mkdir>
    3238:	38051663          	bnez	a0,35c4 <subdir+0x3ba>
  fd = open("dd/ff", O_CREATE | O_RDWR);
    323c:	20200593          	li	a1,514
    3240:	00004517          	auipc	a0,0x4
    3244:	e3050513          	addi	a0,a0,-464 # 7070 <malloc+0x13fa>
    3248:	00002097          	auipc	ra,0x2
    324c:	63c080e7          	jalr	1596(ra) # 5884 <open>
    3250:	84aa                	mv	s1,a0
  if(fd < 0){
    3252:	38054763          	bltz	a0,35e0 <subdir+0x3d6>
  write(fd, "ff", 2);
    3256:	4609                	li	a2,2
    3258:	00004597          	auipc	a1,0x4
    325c:	f2858593          	addi	a1,a1,-216 # 7180 <malloc+0x150a>
    3260:	00002097          	auipc	ra,0x2
    3264:	604080e7          	jalr	1540(ra) # 5864 <write>
  close(fd);
    3268:	8526                	mv	a0,s1
    326a:	00002097          	auipc	ra,0x2
    326e:	602080e7          	jalr	1538(ra) # 586c <close>
  if(unlink("dd") >= 0){
    3272:	00004517          	auipc	a0,0x4
    3276:	dde50513          	addi	a0,a0,-546 # 7050 <malloc+0x13da>
    327a:	00002097          	auipc	ra,0x2
    327e:	61a080e7          	jalr	1562(ra) # 5894 <unlink>
    3282:	36055d63          	bgez	a0,35fc <subdir+0x3f2>
  if(mkdir("/dd/dd") != 0){
    3286:	00004517          	auipc	a0,0x4
    328a:	e4250513          	addi	a0,a0,-446 # 70c8 <malloc+0x1452>
    328e:	00002097          	auipc	ra,0x2
    3292:	61e080e7          	jalr	1566(ra) # 58ac <mkdir>
    3296:	38051163          	bnez	a0,3618 <subdir+0x40e>
  fd = open("dd/dd/ff", O_CREATE | O_RDWR);
    329a:	20200593          	li	a1,514
    329e:	00004517          	auipc	a0,0x4
    32a2:	e5250513          	addi	a0,a0,-430 # 70f0 <malloc+0x147a>
    32a6:	00002097          	auipc	ra,0x2
    32aa:	5de080e7          	jalr	1502(ra) # 5884 <open>
    32ae:	84aa                	mv	s1,a0
  if(fd < 0){
    32b0:	38054263          	bltz	a0,3634 <subdir+0x42a>
  write(fd, "FF", 2);
    32b4:	4609                	li	a2,2
    32b6:	00004597          	auipc	a1,0x4
    32ba:	e6a58593          	addi	a1,a1,-406 # 7120 <malloc+0x14aa>
    32be:	00002097          	auipc	ra,0x2
    32c2:	5a6080e7          	jalr	1446(ra) # 5864 <write>
  close(fd);
    32c6:	8526                	mv	a0,s1
    32c8:	00002097          	auipc	ra,0x2
    32cc:	5a4080e7          	jalr	1444(ra) # 586c <close>
  fd = open("dd/dd/../ff", 0);
    32d0:	4581                	li	a1,0
    32d2:	00004517          	auipc	a0,0x4
    32d6:	e5650513          	addi	a0,a0,-426 # 7128 <malloc+0x14b2>
    32da:	00002097          	auipc	ra,0x2
    32de:	5aa080e7          	jalr	1450(ra) # 5884 <open>
    32e2:	84aa                	mv	s1,a0
  if(fd < 0){
    32e4:	36054663          	bltz	a0,3650 <subdir+0x446>
  cc = read(fd, buf, sizeof(buf));
    32e8:	660d                	lui	a2,0x3
    32ea:	00009597          	auipc	a1,0x9
    32ee:	aee58593          	addi	a1,a1,-1298 # bdd8 <buf>
    32f2:	00002097          	auipc	ra,0x2
    32f6:	56a080e7          	jalr	1386(ra) # 585c <read>
  if(cc != 2 || buf[0] != 'f'){
    32fa:	4789                	li	a5,2
    32fc:	36f51863          	bne	a0,a5,366c <subdir+0x462>
    3300:	00009717          	auipc	a4,0x9
    3304:	ad874703          	lbu	a4,-1320(a4) # bdd8 <buf>
    3308:	06600793          	li	a5,102
    330c:	36f71063          	bne	a4,a5,366c <subdir+0x462>
  close(fd);
    3310:	8526                	mv	a0,s1
    3312:	00002097          	auipc	ra,0x2
    3316:	55a080e7          	jalr	1370(ra) # 586c <close>
  if(link("dd/dd/ff", "dd/dd/ffff") != 0){
    331a:	00004597          	auipc	a1,0x4
    331e:	e5e58593          	addi	a1,a1,-418 # 7178 <malloc+0x1502>
    3322:	00004517          	auipc	a0,0x4
    3326:	dce50513          	addi	a0,a0,-562 # 70f0 <malloc+0x147a>
    332a:	00002097          	auipc	ra,0x2
    332e:	57a080e7          	jalr	1402(ra) # 58a4 <link>
    3332:	34051b63          	bnez	a0,3688 <subdir+0x47e>
  if(unlink("dd/dd/ff") != 0){
    3336:	00004517          	auipc	a0,0x4
    333a:	dba50513          	addi	a0,a0,-582 # 70f0 <malloc+0x147a>
    333e:	00002097          	auipc	ra,0x2
    3342:	556080e7          	jalr	1366(ra) # 5894 <unlink>
    3346:	34051f63          	bnez	a0,36a4 <subdir+0x49a>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    334a:	4581                	li	a1,0
    334c:	00004517          	auipc	a0,0x4
    3350:	da450513          	addi	a0,a0,-604 # 70f0 <malloc+0x147a>
    3354:	00002097          	auipc	ra,0x2
    3358:	530080e7          	jalr	1328(ra) # 5884 <open>
    335c:	36055263          	bgez	a0,36c0 <subdir+0x4b6>
  if(chdir("dd") != 0){
    3360:	00004517          	auipc	a0,0x4
    3364:	cf050513          	addi	a0,a0,-784 # 7050 <malloc+0x13da>
    3368:	00002097          	auipc	ra,0x2
    336c:	54c080e7          	jalr	1356(ra) # 58b4 <chdir>
    3370:	36051663          	bnez	a0,36dc <subdir+0x4d2>
  if(chdir("dd/../../dd") != 0){
    3374:	00004517          	auipc	a0,0x4
    3378:	e9c50513          	addi	a0,a0,-356 # 7210 <malloc+0x159a>
    337c:	00002097          	auipc	ra,0x2
    3380:	538080e7          	jalr	1336(ra) # 58b4 <chdir>
    3384:	36051a63          	bnez	a0,36f8 <subdir+0x4ee>
  if(chdir("dd/../../../dd") != 0){
    3388:	00004517          	auipc	a0,0x4
    338c:	eb850513          	addi	a0,a0,-328 # 7240 <malloc+0x15ca>
    3390:	00002097          	auipc	ra,0x2
    3394:	524080e7          	jalr	1316(ra) # 58b4 <chdir>
    3398:	36051e63          	bnez	a0,3714 <subdir+0x50a>
  if(chdir("./..") != 0){
    339c:	00004517          	auipc	a0,0x4
    33a0:	ed450513          	addi	a0,a0,-300 # 7270 <malloc+0x15fa>
    33a4:	00002097          	auipc	ra,0x2
    33a8:	510080e7          	jalr	1296(ra) # 58b4 <chdir>
    33ac:	38051263          	bnez	a0,3730 <subdir+0x526>
  fd = open("dd/dd/ffff", 0);
    33b0:	4581                	li	a1,0
    33b2:	00004517          	auipc	a0,0x4
    33b6:	dc650513          	addi	a0,a0,-570 # 7178 <malloc+0x1502>
    33ba:	00002097          	auipc	ra,0x2
    33be:	4ca080e7          	jalr	1226(ra) # 5884 <open>
    33c2:	84aa                	mv	s1,a0
  if(fd < 0){
    33c4:	38054463          	bltz	a0,374c <subdir+0x542>
  if(read(fd, buf, sizeof(buf)) != 2){
    33c8:	660d                	lui	a2,0x3
    33ca:	00009597          	auipc	a1,0x9
    33ce:	a0e58593          	addi	a1,a1,-1522 # bdd8 <buf>
    33d2:	00002097          	auipc	ra,0x2
    33d6:	48a080e7          	jalr	1162(ra) # 585c <read>
    33da:	4789                	li	a5,2
    33dc:	38f51663          	bne	a0,a5,3768 <subdir+0x55e>
  close(fd);
    33e0:	8526                	mv	a0,s1
    33e2:	00002097          	auipc	ra,0x2
    33e6:	48a080e7          	jalr	1162(ra) # 586c <close>
  if(open("dd/dd/ff", O_RDONLY) >= 0){
    33ea:	4581                	li	a1,0
    33ec:	00004517          	auipc	a0,0x4
    33f0:	d0450513          	addi	a0,a0,-764 # 70f0 <malloc+0x147a>
    33f4:	00002097          	auipc	ra,0x2
    33f8:	490080e7          	jalr	1168(ra) # 5884 <open>
    33fc:	38055463          	bgez	a0,3784 <subdir+0x57a>
  if(open("dd/ff/ff", O_CREATE|O_RDWR) >= 0){
    3400:	20200593          	li	a1,514
    3404:	00004517          	auipc	a0,0x4
    3408:	efc50513          	addi	a0,a0,-260 # 7300 <malloc+0x168a>
    340c:	00002097          	auipc	ra,0x2
    3410:	478080e7          	jalr	1144(ra) # 5884 <open>
    3414:	38055663          	bgez	a0,37a0 <subdir+0x596>
  if(open("dd/xx/ff", O_CREATE|O_RDWR) >= 0){
    3418:	20200593          	li	a1,514
    341c:	00004517          	auipc	a0,0x4
    3420:	f1450513          	addi	a0,a0,-236 # 7330 <malloc+0x16ba>
    3424:	00002097          	auipc	ra,0x2
    3428:	460080e7          	jalr	1120(ra) # 5884 <open>
    342c:	38055863          	bgez	a0,37bc <subdir+0x5b2>
  if(open("dd", O_CREATE) >= 0){
    3430:	20000593          	li	a1,512
    3434:	00004517          	auipc	a0,0x4
    3438:	c1c50513          	addi	a0,a0,-996 # 7050 <malloc+0x13da>
    343c:	00002097          	auipc	ra,0x2
    3440:	448080e7          	jalr	1096(ra) # 5884 <open>
    3444:	38055a63          	bgez	a0,37d8 <subdir+0x5ce>
  if(open("dd", O_RDWR) >= 0){
    3448:	4589                	li	a1,2
    344a:	00004517          	auipc	a0,0x4
    344e:	c0650513          	addi	a0,a0,-1018 # 7050 <malloc+0x13da>
    3452:	00002097          	auipc	ra,0x2
    3456:	432080e7          	jalr	1074(ra) # 5884 <open>
    345a:	38055d63          	bgez	a0,37f4 <subdir+0x5ea>
  if(open("dd", O_WRONLY) >= 0){
    345e:	4585                	li	a1,1
    3460:	00004517          	auipc	a0,0x4
    3464:	bf050513          	addi	a0,a0,-1040 # 7050 <malloc+0x13da>
    3468:	00002097          	auipc	ra,0x2
    346c:	41c080e7          	jalr	1052(ra) # 5884 <open>
    3470:	3a055063          	bgez	a0,3810 <subdir+0x606>
  if(link("dd/ff/ff", "dd/dd/xx") == 0){
    3474:	00004597          	auipc	a1,0x4
    3478:	f4c58593          	addi	a1,a1,-180 # 73c0 <malloc+0x174a>
    347c:	00004517          	auipc	a0,0x4
    3480:	e8450513          	addi	a0,a0,-380 # 7300 <malloc+0x168a>
    3484:	00002097          	auipc	ra,0x2
    3488:	420080e7          	jalr	1056(ra) # 58a4 <link>
    348c:	3a050063          	beqz	a0,382c <subdir+0x622>
  if(link("dd/xx/ff", "dd/dd/xx") == 0){
    3490:	00004597          	auipc	a1,0x4
    3494:	f3058593          	addi	a1,a1,-208 # 73c0 <malloc+0x174a>
    3498:	00004517          	auipc	a0,0x4
    349c:	e9850513          	addi	a0,a0,-360 # 7330 <malloc+0x16ba>
    34a0:	00002097          	auipc	ra,0x2
    34a4:	404080e7          	jalr	1028(ra) # 58a4 <link>
    34a8:	3a050063          	beqz	a0,3848 <subdir+0x63e>
  if(link("dd/ff", "dd/dd/ffff") == 0){
    34ac:	00004597          	auipc	a1,0x4
    34b0:	ccc58593          	addi	a1,a1,-820 # 7178 <malloc+0x1502>
    34b4:	00004517          	auipc	a0,0x4
    34b8:	bbc50513          	addi	a0,a0,-1092 # 7070 <malloc+0x13fa>
    34bc:	00002097          	auipc	ra,0x2
    34c0:	3e8080e7          	jalr	1000(ra) # 58a4 <link>
    34c4:	3a050063          	beqz	a0,3864 <subdir+0x65a>
  if(mkdir("dd/ff/ff") == 0){
    34c8:	00004517          	auipc	a0,0x4
    34cc:	e3850513          	addi	a0,a0,-456 # 7300 <malloc+0x168a>
    34d0:	00002097          	auipc	ra,0x2
    34d4:	3dc080e7          	jalr	988(ra) # 58ac <mkdir>
    34d8:	3a050463          	beqz	a0,3880 <subdir+0x676>
  if(mkdir("dd/xx/ff") == 0){
    34dc:	00004517          	auipc	a0,0x4
    34e0:	e5450513          	addi	a0,a0,-428 # 7330 <malloc+0x16ba>
    34e4:	00002097          	auipc	ra,0x2
    34e8:	3c8080e7          	jalr	968(ra) # 58ac <mkdir>
    34ec:	3a050863          	beqz	a0,389c <subdir+0x692>
  if(mkdir("dd/dd/ffff") == 0){
    34f0:	00004517          	auipc	a0,0x4
    34f4:	c8850513          	addi	a0,a0,-888 # 7178 <malloc+0x1502>
    34f8:	00002097          	auipc	ra,0x2
    34fc:	3b4080e7          	jalr	948(ra) # 58ac <mkdir>
    3500:	3a050c63          	beqz	a0,38b8 <subdir+0x6ae>
  if(unlink("dd/xx/ff") == 0){
    3504:	00004517          	auipc	a0,0x4
    3508:	e2c50513          	addi	a0,a0,-468 # 7330 <malloc+0x16ba>
    350c:	00002097          	auipc	ra,0x2
    3510:	388080e7          	jalr	904(ra) # 5894 <unlink>
    3514:	3c050063          	beqz	a0,38d4 <subdir+0x6ca>
  if(unlink("dd/ff/ff") == 0){
    3518:	00004517          	auipc	a0,0x4
    351c:	de850513          	addi	a0,a0,-536 # 7300 <malloc+0x168a>
    3520:	00002097          	auipc	ra,0x2
    3524:	374080e7          	jalr	884(ra) # 5894 <unlink>
    3528:	3c050463          	beqz	a0,38f0 <subdir+0x6e6>
  if(chdir("dd/ff") == 0){
    352c:	00004517          	auipc	a0,0x4
    3530:	b4450513          	addi	a0,a0,-1212 # 7070 <malloc+0x13fa>
    3534:	00002097          	auipc	ra,0x2
    3538:	380080e7          	jalr	896(ra) # 58b4 <chdir>
    353c:	3c050863          	beqz	a0,390c <subdir+0x702>
  if(chdir("dd/xx") == 0){
    3540:	00004517          	auipc	a0,0x4
    3544:	fd050513          	addi	a0,a0,-48 # 7510 <malloc+0x189a>
    3548:	00002097          	auipc	ra,0x2
    354c:	36c080e7          	jalr	876(ra) # 58b4 <chdir>
    3550:	3c050c63          	beqz	a0,3928 <subdir+0x71e>
  if(unlink("dd/dd/ffff") != 0){
    3554:	00004517          	auipc	a0,0x4
    3558:	c2450513          	addi	a0,a0,-988 # 7178 <malloc+0x1502>
    355c:	00002097          	auipc	ra,0x2
    3560:	338080e7          	jalr	824(ra) # 5894 <unlink>
    3564:	3e051063          	bnez	a0,3944 <subdir+0x73a>
  if(unlink("dd/ff") != 0){
    3568:	00004517          	auipc	a0,0x4
    356c:	b0850513          	addi	a0,a0,-1272 # 7070 <malloc+0x13fa>
    3570:	00002097          	auipc	ra,0x2
    3574:	324080e7          	jalr	804(ra) # 5894 <unlink>
    3578:	3e051463          	bnez	a0,3960 <subdir+0x756>
  if(unlink("dd") == 0){
    357c:	00004517          	auipc	a0,0x4
    3580:	ad450513          	addi	a0,a0,-1324 # 7050 <malloc+0x13da>
    3584:	00002097          	auipc	ra,0x2
    3588:	310080e7          	jalr	784(ra) # 5894 <unlink>
    358c:	3e050863          	beqz	a0,397c <subdir+0x772>
  if(unlink("dd/dd") < 0){
    3590:	00004517          	auipc	a0,0x4
    3594:	ff050513          	addi	a0,a0,-16 # 7580 <malloc+0x190a>
    3598:	00002097          	auipc	ra,0x2
    359c:	2fc080e7          	jalr	764(ra) # 5894 <unlink>
    35a0:	3e054c63          	bltz	a0,3998 <subdir+0x78e>
  if(unlink("dd") < 0){
    35a4:	00004517          	auipc	a0,0x4
    35a8:	aac50513          	addi	a0,a0,-1364 # 7050 <malloc+0x13da>
    35ac:	00002097          	auipc	ra,0x2
    35b0:	2e8080e7          	jalr	744(ra) # 5894 <unlink>
    35b4:	40054063          	bltz	a0,39b4 <subdir+0x7aa>
}
    35b8:	60e2                	ld	ra,24(sp)
    35ba:	6442                	ld	s0,16(sp)
    35bc:	64a2                	ld	s1,8(sp)
    35be:	6902                	ld	s2,0(sp)
    35c0:	6105                	addi	sp,sp,32
    35c2:	8082                	ret
    printf("%s: mkdir dd failed\n", s);
    35c4:	85ca                	mv	a1,s2
    35c6:	00004517          	auipc	a0,0x4
    35ca:	a9250513          	addi	a0,a0,-1390 # 7058 <malloc+0x13e2>
    35ce:	00002097          	auipc	ra,0x2
    35d2:	5f0080e7          	jalr	1520(ra) # 5bbe <printf>
    exit(1);
    35d6:	4505                	li	a0,1
    35d8:	00002097          	auipc	ra,0x2
    35dc:	26c080e7          	jalr	620(ra) # 5844 <exit>
    printf("%s: create dd/ff failed\n", s);
    35e0:	85ca                	mv	a1,s2
    35e2:	00004517          	auipc	a0,0x4
    35e6:	a9650513          	addi	a0,a0,-1386 # 7078 <malloc+0x1402>
    35ea:	00002097          	auipc	ra,0x2
    35ee:	5d4080e7          	jalr	1492(ra) # 5bbe <printf>
    exit(1);
    35f2:	4505                	li	a0,1
    35f4:	00002097          	auipc	ra,0x2
    35f8:	250080e7          	jalr	592(ra) # 5844 <exit>
    printf("%s: unlink dd (non-empty dir) succeeded!\n", s);
    35fc:	85ca                	mv	a1,s2
    35fe:	00004517          	auipc	a0,0x4
    3602:	a9a50513          	addi	a0,a0,-1382 # 7098 <malloc+0x1422>
    3606:	00002097          	auipc	ra,0x2
    360a:	5b8080e7          	jalr	1464(ra) # 5bbe <printf>
    exit(1);
    360e:	4505                	li	a0,1
    3610:	00002097          	auipc	ra,0x2
    3614:	234080e7          	jalr	564(ra) # 5844 <exit>
    printf("subdir mkdir dd/dd failed\n", s);
    3618:	85ca                	mv	a1,s2
    361a:	00004517          	auipc	a0,0x4
    361e:	ab650513          	addi	a0,a0,-1354 # 70d0 <malloc+0x145a>
    3622:	00002097          	auipc	ra,0x2
    3626:	59c080e7          	jalr	1436(ra) # 5bbe <printf>
    exit(1);
    362a:	4505                	li	a0,1
    362c:	00002097          	auipc	ra,0x2
    3630:	218080e7          	jalr	536(ra) # 5844 <exit>
    printf("%s: create dd/dd/ff failed\n", s);
    3634:	85ca                	mv	a1,s2
    3636:	00004517          	auipc	a0,0x4
    363a:	aca50513          	addi	a0,a0,-1334 # 7100 <malloc+0x148a>
    363e:	00002097          	auipc	ra,0x2
    3642:	580080e7          	jalr	1408(ra) # 5bbe <printf>
    exit(1);
    3646:	4505                	li	a0,1
    3648:	00002097          	auipc	ra,0x2
    364c:	1fc080e7          	jalr	508(ra) # 5844 <exit>
    printf("%s: open dd/dd/../ff failed\n", s);
    3650:	85ca                	mv	a1,s2
    3652:	00004517          	auipc	a0,0x4
    3656:	ae650513          	addi	a0,a0,-1306 # 7138 <malloc+0x14c2>
    365a:	00002097          	auipc	ra,0x2
    365e:	564080e7          	jalr	1380(ra) # 5bbe <printf>
    exit(1);
    3662:	4505                	li	a0,1
    3664:	00002097          	auipc	ra,0x2
    3668:	1e0080e7          	jalr	480(ra) # 5844 <exit>
    printf("%s: dd/dd/../ff wrong content\n", s);
    366c:	85ca                	mv	a1,s2
    366e:	00004517          	auipc	a0,0x4
    3672:	aea50513          	addi	a0,a0,-1302 # 7158 <malloc+0x14e2>
    3676:	00002097          	auipc	ra,0x2
    367a:	548080e7          	jalr	1352(ra) # 5bbe <printf>
    exit(1);
    367e:	4505                	li	a0,1
    3680:	00002097          	auipc	ra,0x2
    3684:	1c4080e7          	jalr	452(ra) # 5844 <exit>
    printf("link dd/dd/ff dd/dd/ffff failed\n", s);
    3688:	85ca                	mv	a1,s2
    368a:	00004517          	auipc	a0,0x4
    368e:	afe50513          	addi	a0,a0,-1282 # 7188 <malloc+0x1512>
    3692:	00002097          	auipc	ra,0x2
    3696:	52c080e7          	jalr	1324(ra) # 5bbe <printf>
    exit(1);
    369a:	4505                	li	a0,1
    369c:	00002097          	auipc	ra,0x2
    36a0:	1a8080e7          	jalr	424(ra) # 5844 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    36a4:	85ca                	mv	a1,s2
    36a6:	00004517          	auipc	a0,0x4
    36aa:	b0a50513          	addi	a0,a0,-1270 # 71b0 <malloc+0x153a>
    36ae:	00002097          	auipc	ra,0x2
    36b2:	510080e7          	jalr	1296(ra) # 5bbe <printf>
    exit(1);
    36b6:	4505                	li	a0,1
    36b8:	00002097          	auipc	ra,0x2
    36bc:	18c080e7          	jalr	396(ra) # 5844 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded\n", s);
    36c0:	85ca                	mv	a1,s2
    36c2:	00004517          	auipc	a0,0x4
    36c6:	b0e50513          	addi	a0,a0,-1266 # 71d0 <malloc+0x155a>
    36ca:	00002097          	auipc	ra,0x2
    36ce:	4f4080e7          	jalr	1268(ra) # 5bbe <printf>
    exit(1);
    36d2:	4505                	li	a0,1
    36d4:	00002097          	auipc	ra,0x2
    36d8:	170080e7          	jalr	368(ra) # 5844 <exit>
    printf("%s: chdir dd failed\n", s);
    36dc:	85ca                	mv	a1,s2
    36de:	00004517          	auipc	a0,0x4
    36e2:	b1a50513          	addi	a0,a0,-1254 # 71f8 <malloc+0x1582>
    36e6:	00002097          	auipc	ra,0x2
    36ea:	4d8080e7          	jalr	1240(ra) # 5bbe <printf>
    exit(1);
    36ee:	4505                	li	a0,1
    36f0:	00002097          	auipc	ra,0x2
    36f4:	154080e7          	jalr	340(ra) # 5844 <exit>
    printf("%s: chdir dd/../../dd failed\n", s);
    36f8:	85ca                	mv	a1,s2
    36fa:	00004517          	auipc	a0,0x4
    36fe:	b2650513          	addi	a0,a0,-1242 # 7220 <malloc+0x15aa>
    3702:	00002097          	auipc	ra,0x2
    3706:	4bc080e7          	jalr	1212(ra) # 5bbe <printf>
    exit(1);
    370a:	4505                	li	a0,1
    370c:	00002097          	auipc	ra,0x2
    3710:	138080e7          	jalr	312(ra) # 5844 <exit>
    printf("chdir dd/../../dd failed\n", s);
    3714:	85ca                	mv	a1,s2
    3716:	00004517          	auipc	a0,0x4
    371a:	b3a50513          	addi	a0,a0,-1222 # 7250 <malloc+0x15da>
    371e:	00002097          	auipc	ra,0x2
    3722:	4a0080e7          	jalr	1184(ra) # 5bbe <printf>
    exit(1);
    3726:	4505                	li	a0,1
    3728:	00002097          	auipc	ra,0x2
    372c:	11c080e7          	jalr	284(ra) # 5844 <exit>
    printf("%s: chdir ./.. failed\n", s);
    3730:	85ca                	mv	a1,s2
    3732:	00004517          	auipc	a0,0x4
    3736:	b4650513          	addi	a0,a0,-1210 # 7278 <malloc+0x1602>
    373a:	00002097          	auipc	ra,0x2
    373e:	484080e7          	jalr	1156(ra) # 5bbe <printf>
    exit(1);
    3742:	4505                	li	a0,1
    3744:	00002097          	auipc	ra,0x2
    3748:	100080e7          	jalr	256(ra) # 5844 <exit>
    printf("%s: open dd/dd/ffff failed\n", s);
    374c:	85ca                	mv	a1,s2
    374e:	00004517          	auipc	a0,0x4
    3752:	b4250513          	addi	a0,a0,-1214 # 7290 <malloc+0x161a>
    3756:	00002097          	auipc	ra,0x2
    375a:	468080e7          	jalr	1128(ra) # 5bbe <printf>
    exit(1);
    375e:	4505                	li	a0,1
    3760:	00002097          	auipc	ra,0x2
    3764:	0e4080e7          	jalr	228(ra) # 5844 <exit>
    printf("%s: read dd/dd/ffff wrong len\n", s);
    3768:	85ca                	mv	a1,s2
    376a:	00004517          	auipc	a0,0x4
    376e:	b4650513          	addi	a0,a0,-1210 # 72b0 <malloc+0x163a>
    3772:	00002097          	auipc	ra,0x2
    3776:	44c080e7          	jalr	1100(ra) # 5bbe <printf>
    exit(1);
    377a:	4505                	li	a0,1
    377c:	00002097          	auipc	ra,0x2
    3780:	0c8080e7          	jalr	200(ra) # 5844 <exit>
    printf("%s: open (unlinked) dd/dd/ff succeeded!\n", s);
    3784:	85ca                	mv	a1,s2
    3786:	00004517          	auipc	a0,0x4
    378a:	b4a50513          	addi	a0,a0,-1206 # 72d0 <malloc+0x165a>
    378e:	00002097          	auipc	ra,0x2
    3792:	430080e7          	jalr	1072(ra) # 5bbe <printf>
    exit(1);
    3796:	4505                	li	a0,1
    3798:	00002097          	auipc	ra,0x2
    379c:	0ac080e7          	jalr	172(ra) # 5844 <exit>
    printf("%s: create dd/ff/ff succeeded!\n", s);
    37a0:	85ca                	mv	a1,s2
    37a2:	00004517          	auipc	a0,0x4
    37a6:	b6e50513          	addi	a0,a0,-1170 # 7310 <malloc+0x169a>
    37aa:	00002097          	auipc	ra,0x2
    37ae:	414080e7          	jalr	1044(ra) # 5bbe <printf>
    exit(1);
    37b2:	4505                	li	a0,1
    37b4:	00002097          	auipc	ra,0x2
    37b8:	090080e7          	jalr	144(ra) # 5844 <exit>
    printf("%s: create dd/xx/ff succeeded!\n", s);
    37bc:	85ca                	mv	a1,s2
    37be:	00004517          	auipc	a0,0x4
    37c2:	b8250513          	addi	a0,a0,-1150 # 7340 <malloc+0x16ca>
    37c6:	00002097          	auipc	ra,0x2
    37ca:	3f8080e7          	jalr	1016(ra) # 5bbe <printf>
    exit(1);
    37ce:	4505                	li	a0,1
    37d0:	00002097          	auipc	ra,0x2
    37d4:	074080e7          	jalr	116(ra) # 5844 <exit>
    printf("%s: create dd succeeded!\n", s);
    37d8:	85ca                	mv	a1,s2
    37da:	00004517          	auipc	a0,0x4
    37de:	b8650513          	addi	a0,a0,-1146 # 7360 <malloc+0x16ea>
    37e2:	00002097          	auipc	ra,0x2
    37e6:	3dc080e7          	jalr	988(ra) # 5bbe <printf>
    exit(1);
    37ea:	4505                	li	a0,1
    37ec:	00002097          	auipc	ra,0x2
    37f0:	058080e7          	jalr	88(ra) # 5844 <exit>
    printf("%s: open dd rdwr succeeded!\n", s);
    37f4:	85ca                	mv	a1,s2
    37f6:	00004517          	auipc	a0,0x4
    37fa:	b8a50513          	addi	a0,a0,-1142 # 7380 <malloc+0x170a>
    37fe:	00002097          	auipc	ra,0x2
    3802:	3c0080e7          	jalr	960(ra) # 5bbe <printf>
    exit(1);
    3806:	4505                	li	a0,1
    3808:	00002097          	auipc	ra,0x2
    380c:	03c080e7          	jalr	60(ra) # 5844 <exit>
    printf("%s: open dd wronly succeeded!\n", s);
    3810:	85ca                	mv	a1,s2
    3812:	00004517          	auipc	a0,0x4
    3816:	b8e50513          	addi	a0,a0,-1138 # 73a0 <malloc+0x172a>
    381a:	00002097          	auipc	ra,0x2
    381e:	3a4080e7          	jalr	932(ra) # 5bbe <printf>
    exit(1);
    3822:	4505                	li	a0,1
    3824:	00002097          	auipc	ra,0x2
    3828:	020080e7          	jalr	32(ra) # 5844 <exit>
    printf("%s: link dd/ff/ff dd/dd/xx succeeded!\n", s);
    382c:	85ca                	mv	a1,s2
    382e:	00004517          	auipc	a0,0x4
    3832:	ba250513          	addi	a0,a0,-1118 # 73d0 <malloc+0x175a>
    3836:	00002097          	auipc	ra,0x2
    383a:	388080e7          	jalr	904(ra) # 5bbe <printf>
    exit(1);
    383e:	4505                	li	a0,1
    3840:	00002097          	auipc	ra,0x2
    3844:	004080e7          	jalr	4(ra) # 5844 <exit>
    printf("%s: link dd/xx/ff dd/dd/xx succeeded!\n", s);
    3848:	85ca                	mv	a1,s2
    384a:	00004517          	auipc	a0,0x4
    384e:	bae50513          	addi	a0,a0,-1106 # 73f8 <malloc+0x1782>
    3852:	00002097          	auipc	ra,0x2
    3856:	36c080e7          	jalr	876(ra) # 5bbe <printf>
    exit(1);
    385a:	4505                	li	a0,1
    385c:	00002097          	auipc	ra,0x2
    3860:	fe8080e7          	jalr	-24(ra) # 5844 <exit>
    printf("%s: link dd/ff dd/dd/ffff succeeded!\n", s);
    3864:	85ca                	mv	a1,s2
    3866:	00004517          	auipc	a0,0x4
    386a:	bba50513          	addi	a0,a0,-1094 # 7420 <malloc+0x17aa>
    386e:	00002097          	auipc	ra,0x2
    3872:	350080e7          	jalr	848(ra) # 5bbe <printf>
    exit(1);
    3876:	4505                	li	a0,1
    3878:	00002097          	auipc	ra,0x2
    387c:	fcc080e7          	jalr	-52(ra) # 5844 <exit>
    printf("%s: mkdir dd/ff/ff succeeded!\n", s);
    3880:	85ca                	mv	a1,s2
    3882:	00004517          	auipc	a0,0x4
    3886:	bc650513          	addi	a0,a0,-1082 # 7448 <malloc+0x17d2>
    388a:	00002097          	auipc	ra,0x2
    388e:	334080e7          	jalr	820(ra) # 5bbe <printf>
    exit(1);
    3892:	4505                	li	a0,1
    3894:	00002097          	auipc	ra,0x2
    3898:	fb0080e7          	jalr	-80(ra) # 5844 <exit>
    printf("%s: mkdir dd/xx/ff succeeded!\n", s);
    389c:	85ca                	mv	a1,s2
    389e:	00004517          	auipc	a0,0x4
    38a2:	bca50513          	addi	a0,a0,-1078 # 7468 <malloc+0x17f2>
    38a6:	00002097          	auipc	ra,0x2
    38aa:	318080e7          	jalr	792(ra) # 5bbe <printf>
    exit(1);
    38ae:	4505                	li	a0,1
    38b0:	00002097          	auipc	ra,0x2
    38b4:	f94080e7          	jalr	-108(ra) # 5844 <exit>
    printf("%s: mkdir dd/dd/ffff succeeded!\n", s);
    38b8:	85ca                	mv	a1,s2
    38ba:	00004517          	auipc	a0,0x4
    38be:	bce50513          	addi	a0,a0,-1074 # 7488 <malloc+0x1812>
    38c2:	00002097          	auipc	ra,0x2
    38c6:	2fc080e7          	jalr	764(ra) # 5bbe <printf>
    exit(1);
    38ca:	4505                	li	a0,1
    38cc:	00002097          	auipc	ra,0x2
    38d0:	f78080e7          	jalr	-136(ra) # 5844 <exit>
    printf("%s: unlink dd/xx/ff succeeded!\n", s);
    38d4:	85ca                	mv	a1,s2
    38d6:	00004517          	auipc	a0,0x4
    38da:	bda50513          	addi	a0,a0,-1062 # 74b0 <malloc+0x183a>
    38de:	00002097          	auipc	ra,0x2
    38e2:	2e0080e7          	jalr	736(ra) # 5bbe <printf>
    exit(1);
    38e6:	4505                	li	a0,1
    38e8:	00002097          	auipc	ra,0x2
    38ec:	f5c080e7          	jalr	-164(ra) # 5844 <exit>
    printf("%s: unlink dd/ff/ff succeeded!\n", s);
    38f0:	85ca                	mv	a1,s2
    38f2:	00004517          	auipc	a0,0x4
    38f6:	bde50513          	addi	a0,a0,-1058 # 74d0 <malloc+0x185a>
    38fa:	00002097          	auipc	ra,0x2
    38fe:	2c4080e7          	jalr	708(ra) # 5bbe <printf>
    exit(1);
    3902:	4505                	li	a0,1
    3904:	00002097          	auipc	ra,0x2
    3908:	f40080e7          	jalr	-192(ra) # 5844 <exit>
    printf("%s: chdir dd/ff succeeded!\n", s);
    390c:	85ca                	mv	a1,s2
    390e:	00004517          	auipc	a0,0x4
    3912:	be250513          	addi	a0,a0,-1054 # 74f0 <malloc+0x187a>
    3916:	00002097          	auipc	ra,0x2
    391a:	2a8080e7          	jalr	680(ra) # 5bbe <printf>
    exit(1);
    391e:	4505                	li	a0,1
    3920:	00002097          	auipc	ra,0x2
    3924:	f24080e7          	jalr	-220(ra) # 5844 <exit>
    printf("%s: chdir dd/xx succeeded!\n", s);
    3928:	85ca                	mv	a1,s2
    392a:	00004517          	auipc	a0,0x4
    392e:	bee50513          	addi	a0,a0,-1042 # 7518 <malloc+0x18a2>
    3932:	00002097          	auipc	ra,0x2
    3936:	28c080e7          	jalr	652(ra) # 5bbe <printf>
    exit(1);
    393a:	4505                	li	a0,1
    393c:	00002097          	auipc	ra,0x2
    3940:	f08080e7          	jalr	-248(ra) # 5844 <exit>
    printf("%s: unlink dd/dd/ff failed\n", s);
    3944:	85ca                	mv	a1,s2
    3946:	00004517          	auipc	a0,0x4
    394a:	86a50513          	addi	a0,a0,-1942 # 71b0 <malloc+0x153a>
    394e:	00002097          	auipc	ra,0x2
    3952:	270080e7          	jalr	624(ra) # 5bbe <printf>
    exit(1);
    3956:	4505                	li	a0,1
    3958:	00002097          	auipc	ra,0x2
    395c:	eec080e7          	jalr	-276(ra) # 5844 <exit>
    printf("%s: unlink dd/ff failed\n", s);
    3960:	85ca                	mv	a1,s2
    3962:	00004517          	auipc	a0,0x4
    3966:	bd650513          	addi	a0,a0,-1066 # 7538 <malloc+0x18c2>
    396a:	00002097          	auipc	ra,0x2
    396e:	254080e7          	jalr	596(ra) # 5bbe <printf>
    exit(1);
    3972:	4505                	li	a0,1
    3974:	00002097          	auipc	ra,0x2
    3978:	ed0080e7          	jalr	-304(ra) # 5844 <exit>
    printf("%s: unlink non-empty dd succeeded!\n", s);
    397c:	85ca                	mv	a1,s2
    397e:	00004517          	auipc	a0,0x4
    3982:	bda50513          	addi	a0,a0,-1062 # 7558 <malloc+0x18e2>
    3986:	00002097          	auipc	ra,0x2
    398a:	238080e7          	jalr	568(ra) # 5bbe <printf>
    exit(1);
    398e:	4505                	li	a0,1
    3990:	00002097          	auipc	ra,0x2
    3994:	eb4080e7          	jalr	-332(ra) # 5844 <exit>
    printf("%s: unlink dd/dd failed\n", s);
    3998:	85ca                	mv	a1,s2
    399a:	00004517          	auipc	a0,0x4
    399e:	bee50513          	addi	a0,a0,-1042 # 7588 <malloc+0x1912>
    39a2:	00002097          	auipc	ra,0x2
    39a6:	21c080e7          	jalr	540(ra) # 5bbe <printf>
    exit(1);
    39aa:	4505                	li	a0,1
    39ac:	00002097          	auipc	ra,0x2
    39b0:	e98080e7          	jalr	-360(ra) # 5844 <exit>
    printf("%s: unlink dd failed\n", s);
    39b4:	85ca                	mv	a1,s2
    39b6:	00004517          	auipc	a0,0x4
    39ba:	bf250513          	addi	a0,a0,-1038 # 75a8 <malloc+0x1932>
    39be:	00002097          	auipc	ra,0x2
    39c2:	200080e7          	jalr	512(ra) # 5bbe <printf>
    exit(1);
    39c6:	4505                	li	a0,1
    39c8:	00002097          	auipc	ra,0x2
    39cc:	e7c080e7          	jalr	-388(ra) # 5844 <exit>

00000000000039d0 <rmdot>:
{
    39d0:	1101                	addi	sp,sp,-32
    39d2:	ec06                	sd	ra,24(sp)
    39d4:	e822                	sd	s0,16(sp)
    39d6:	e426                	sd	s1,8(sp)
    39d8:	1000                	addi	s0,sp,32
    39da:	84aa                	mv	s1,a0
  if(mkdir("dots") != 0){
    39dc:	00004517          	auipc	a0,0x4
    39e0:	be450513          	addi	a0,a0,-1052 # 75c0 <malloc+0x194a>
    39e4:	00002097          	auipc	ra,0x2
    39e8:	ec8080e7          	jalr	-312(ra) # 58ac <mkdir>
    39ec:	e549                	bnez	a0,3a76 <rmdot+0xa6>
  if(chdir("dots") != 0){
    39ee:	00004517          	auipc	a0,0x4
    39f2:	bd250513          	addi	a0,a0,-1070 # 75c0 <malloc+0x194a>
    39f6:	00002097          	auipc	ra,0x2
    39fa:	ebe080e7          	jalr	-322(ra) # 58b4 <chdir>
    39fe:	e951                	bnez	a0,3a92 <rmdot+0xc2>
  if(unlink(".") == 0){
    3a00:	00003517          	auipc	a0,0x3
    3a04:	a5050513          	addi	a0,a0,-1456 # 6450 <malloc+0x7da>
    3a08:	00002097          	auipc	ra,0x2
    3a0c:	e8c080e7          	jalr	-372(ra) # 5894 <unlink>
    3a10:	cd59                	beqz	a0,3aae <rmdot+0xde>
  if(unlink("..") == 0){
    3a12:	00003517          	auipc	a0,0x3
    3a16:	60650513          	addi	a0,a0,1542 # 7018 <malloc+0x13a2>
    3a1a:	00002097          	auipc	ra,0x2
    3a1e:	e7a080e7          	jalr	-390(ra) # 5894 <unlink>
    3a22:	c545                	beqz	a0,3aca <rmdot+0xfa>
  if(chdir("/") != 0){
    3a24:	00003517          	auipc	a0,0x3
    3a28:	59c50513          	addi	a0,a0,1436 # 6fc0 <malloc+0x134a>
    3a2c:	00002097          	auipc	ra,0x2
    3a30:	e88080e7          	jalr	-376(ra) # 58b4 <chdir>
    3a34:	e94d                	bnez	a0,3ae6 <rmdot+0x116>
  if(unlink("dots/.") == 0){
    3a36:	00004517          	auipc	a0,0x4
    3a3a:	bf250513          	addi	a0,a0,-1038 # 7628 <malloc+0x19b2>
    3a3e:	00002097          	auipc	ra,0x2
    3a42:	e56080e7          	jalr	-426(ra) # 5894 <unlink>
    3a46:	cd55                	beqz	a0,3b02 <rmdot+0x132>
  if(unlink("dots/..") == 0){
    3a48:	00004517          	auipc	a0,0x4
    3a4c:	c0850513          	addi	a0,a0,-1016 # 7650 <malloc+0x19da>
    3a50:	00002097          	auipc	ra,0x2
    3a54:	e44080e7          	jalr	-444(ra) # 5894 <unlink>
    3a58:	c179                	beqz	a0,3b1e <rmdot+0x14e>
  if(unlink("dots") != 0){
    3a5a:	00004517          	auipc	a0,0x4
    3a5e:	b6650513          	addi	a0,a0,-1178 # 75c0 <malloc+0x194a>
    3a62:	00002097          	auipc	ra,0x2
    3a66:	e32080e7          	jalr	-462(ra) # 5894 <unlink>
    3a6a:	e961                	bnez	a0,3b3a <rmdot+0x16a>
}
    3a6c:	60e2                	ld	ra,24(sp)
    3a6e:	6442                	ld	s0,16(sp)
    3a70:	64a2                	ld	s1,8(sp)
    3a72:	6105                	addi	sp,sp,32
    3a74:	8082                	ret
    printf("%s: mkdir dots failed\n", s);
    3a76:	85a6                	mv	a1,s1
    3a78:	00004517          	auipc	a0,0x4
    3a7c:	b5050513          	addi	a0,a0,-1200 # 75c8 <malloc+0x1952>
    3a80:	00002097          	auipc	ra,0x2
    3a84:	13e080e7          	jalr	318(ra) # 5bbe <printf>
    exit(1);
    3a88:	4505                	li	a0,1
    3a8a:	00002097          	auipc	ra,0x2
    3a8e:	dba080e7          	jalr	-582(ra) # 5844 <exit>
    printf("%s: chdir dots failed\n", s);
    3a92:	85a6                	mv	a1,s1
    3a94:	00004517          	auipc	a0,0x4
    3a98:	b4c50513          	addi	a0,a0,-1204 # 75e0 <malloc+0x196a>
    3a9c:	00002097          	auipc	ra,0x2
    3aa0:	122080e7          	jalr	290(ra) # 5bbe <printf>
    exit(1);
    3aa4:	4505                	li	a0,1
    3aa6:	00002097          	auipc	ra,0x2
    3aaa:	d9e080e7          	jalr	-610(ra) # 5844 <exit>
    printf("%s: rm . worked!\n", s);
    3aae:	85a6                	mv	a1,s1
    3ab0:	00004517          	auipc	a0,0x4
    3ab4:	b4850513          	addi	a0,a0,-1208 # 75f8 <malloc+0x1982>
    3ab8:	00002097          	auipc	ra,0x2
    3abc:	106080e7          	jalr	262(ra) # 5bbe <printf>
    exit(1);
    3ac0:	4505                	li	a0,1
    3ac2:	00002097          	auipc	ra,0x2
    3ac6:	d82080e7          	jalr	-638(ra) # 5844 <exit>
    printf("%s: rm .. worked!\n", s);
    3aca:	85a6                	mv	a1,s1
    3acc:	00004517          	auipc	a0,0x4
    3ad0:	b4450513          	addi	a0,a0,-1212 # 7610 <malloc+0x199a>
    3ad4:	00002097          	auipc	ra,0x2
    3ad8:	0ea080e7          	jalr	234(ra) # 5bbe <printf>
    exit(1);
    3adc:	4505                	li	a0,1
    3ade:	00002097          	auipc	ra,0x2
    3ae2:	d66080e7          	jalr	-666(ra) # 5844 <exit>
    printf("%s: chdir / failed\n", s);
    3ae6:	85a6                	mv	a1,s1
    3ae8:	00003517          	auipc	a0,0x3
    3aec:	4e050513          	addi	a0,a0,1248 # 6fc8 <malloc+0x1352>
    3af0:	00002097          	auipc	ra,0x2
    3af4:	0ce080e7          	jalr	206(ra) # 5bbe <printf>
    exit(1);
    3af8:	4505                	li	a0,1
    3afa:	00002097          	auipc	ra,0x2
    3afe:	d4a080e7          	jalr	-694(ra) # 5844 <exit>
    printf("%s: unlink dots/. worked!\n", s);
    3b02:	85a6                	mv	a1,s1
    3b04:	00004517          	auipc	a0,0x4
    3b08:	b2c50513          	addi	a0,a0,-1236 # 7630 <malloc+0x19ba>
    3b0c:	00002097          	auipc	ra,0x2
    3b10:	0b2080e7          	jalr	178(ra) # 5bbe <printf>
    exit(1);
    3b14:	4505                	li	a0,1
    3b16:	00002097          	auipc	ra,0x2
    3b1a:	d2e080e7          	jalr	-722(ra) # 5844 <exit>
    printf("%s: unlink dots/.. worked!\n", s);
    3b1e:	85a6                	mv	a1,s1
    3b20:	00004517          	auipc	a0,0x4
    3b24:	b3850513          	addi	a0,a0,-1224 # 7658 <malloc+0x19e2>
    3b28:	00002097          	auipc	ra,0x2
    3b2c:	096080e7          	jalr	150(ra) # 5bbe <printf>
    exit(1);
    3b30:	4505                	li	a0,1
    3b32:	00002097          	auipc	ra,0x2
    3b36:	d12080e7          	jalr	-750(ra) # 5844 <exit>
    printf("%s: unlink dots failed!\n", s);
    3b3a:	85a6                	mv	a1,s1
    3b3c:	00004517          	auipc	a0,0x4
    3b40:	b3c50513          	addi	a0,a0,-1220 # 7678 <malloc+0x1a02>
    3b44:	00002097          	auipc	ra,0x2
    3b48:	07a080e7          	jalr	122(ra) # 5bbe <printf>
    exit(1);
    3b4c:	4505                	li	a0,1
    3b4e:	00002097          	auipc	ra,0x2
    3b52:	cf6080e7          	jalr	-778(ra) # 5844 <exit>

0000000000003b56 <dirfile>:
{
    3b56:	1101                	addi	sp,sp,-32
    3b58:	ec06                	sd	ra,24(sp)
    3b5a:	e822                	sd	s0,16(sp)
    3b5c:	e426                	sd	s1,8(sp)
    3b5e:	e04a                	sd	s2,0(sp)
    3b60:	1000                	addi	s0,sp,32
    3b62:	892a                	mv	s2,a0
  fd = open("dirfile", O_CREATE);
    3b64:	20000593          	li	a1,512
    3b68:	00004517          	auipc	a0,0x4
    3b6c:	b3050513          	addi	a0,a0,-1232 # 7698 <malloc+0x1a22>
    3b70:	00002097          	auipc	ra,0x2
    3b74:	d14080e7          	jalr	-748(ra) # 5884 <open>
  if(fd < 0){
    3b78:	0e054d63          	bltz	a0,3c72 <dirfile+0x11c>
  close(fd);
    3b7c:	00002097          	auipc	ra,0x2
    3b80:	cf0080e7          	jalr	-784(ra) # 586c <close>
  if(chdir("dirfile") == 0){
    3b84:	00004517          	auipc	a0,0x4
    3b88:	b1450513          	addi	a0,a0,-1260 # 7698 <malloc+0x1a22>
    3b8c:	00002097          	auipc	ra,0x2
    3b90:	d28080e7          	jalr	-728(ra) # 58b4 <chdir>
    3b94:	cd6d                	beqz	a0,3c8e <dirfile+0x138>
  fd = open("dirfile/xx", 0);
    3b96:	4581                	li	a1,0
    3b98:	00004517          	auipc	a0,0x4
    3b9c:	b4850513          	addi	a0,a0,-1208 # 76e0 <malloc+0x1a6a>
    3ba0:	00002097          	auipc	ra,0x2
    3ba4:	ce4080e7          	jalr	-796(ra) # 5884 <open>
  if(fd >= 0){
    3ba8:	10055163          	bgez	a0,3caa <dirfile+0x154>
  fd = open("dirfile/xx", O_CREATE);
    3bac:	20000593          	li	a1,512
    3bb0:	00004517          	auipc	a0,0x4
    3bb4:	b3050513          	addi	a0,a0,-1232 # 76e0 <malloc+0x1a6a>
    3bb8:	00002097          	auipc	ra,0x2
    3bbc:	ccc080e7          	jalr	-820(ra) # 5884 <open>
  if(fd >= 0){
    3bc0:	10055363          	bgez	a0,3cc6 <dirfile+0x170>
  if(mkdir("dirfile/xx") == 0){
    3bc4:	00004517          	auipc	a0,0x4
    3bc8:	b1c50513          	addi	a0,a0,-1252 # 76e0 <malloc+0x1a6a>
    3bcc:	00002097          	auipc	ra,0x2
    3bd0:	ce0080e7          	jalr	-800(ra) # 58ac <mkdir>
    3bd4:	10050763          	beqz	a0,3ce2 <dirfile+0x18c>
  if(unlink("dirfile/xx") == 0){
    3bd8:	00004517          	auipc	a0,0x4
    3bdc:	b0850513          	addi	a0,a0,-1272 # 76e0 <malloc+0x1a6a>
    3be0:	00002097          	auipc	ra,0x2
    3be4:	cb4080e7          	jalr	-844(ra) # 5894 <unlink>
    3be8:	10050b63          	beqz	a0,3cfe <dirfile+0x1a8>
  if(link("README", "dirfile/xx") == 0){
    3bec:	00004597          	auipc	a1,0x4
    3bf0:	af458593          	addi	a1,a1,-1292 # 76e0 <malloc+0x1a6a>
    3bf4:	00002517          	auipc	a0,0x2
    3bf8:	34c50513          	addi	a0,a0,844 # 5f40 <malloc+0x2ca>
    3bfc:	00002097          	auipc	ra,0x2
    3c00:	ca8080e7          	jalr	-856(ra) # 58a4 <link>
    3c04:	10050b63          	beqz	a0,3d1a <dirfile+0x1c4>
  if(unlink("dirfile") != 0){
    3c08:	00004517          	auipc	a0,0x4
    3c0c:	a9050513          	addi	a0,a0,-1392 # 7698 <malloc+0x1a22>
    3c10:	00002097          	auipc	ra,0x2
    3c14:	c84080e7          	jalr	-892(ra) # 5894 <unlink>
    3c18:	10051f63          	bnez	a0,3d36 <dirfile+0x1e0>
  fd = open(".", O_RDWR);
    3c1c:	4589                	li	a1,2
    3c1e:	00003517          	auipc	a0,0x3
    3c22:	83250513          	addi	a0,a0,-1998 # 6450 <malloc+0x7da>
    3c26:	00002097          	auipc	ra,0x2
    3c2a:	c5e080e7          	jalr	-930(ra) # 5884 <open>
  if(fd >= 0){
    3c2e:	12055263          	bgez	a0,3d52 <dirfile+0x1fc>
  fd = open(".", 0);
    3c32:	4581                	li	a1,0
    3c34:	00003517          	auipc	a0,0x3
    3c38:	81c50513          	addi	a0,a0,-2020 # 6450 <malloc+0x7da>
    3c3c:	00002097          	auipc	ra,0x2
    3c40:	c48080e7          	jalr	-952(ra) # 5884 <open>
    3c44:	84aa                	mv	s1,a0
  if(write(fd, "x", 1) > 0){
    3c46:	4605                	li	a2,1
    3c48:	00002597          	auipc	a1,0x2
    3c4c:	1c058593          	addi	a1,a1,448 # 5e08 <malloc+0x192>
    3c50:	00002097          	auipc	ra,0x2
    3c54:	c14080e7          	jalr	-1004(ra) # 5864 <write>
    3c58:	10a04b63          	bgtz	a0,3d6e <dirfile+0x218>
  close(fd);
    3c5c:	8526                	mv	a0,s1
    3c5e:	00002097          	auipc	ra,0x2
    3c62:	c0e080e7          	jalr	-1010(ra) # 586c <close>
}
    3c66:	60e2                	ld	ra,24(sp)
    3c68:	6442                	ld	s0,16(sp)
    3c6a:	64a2                	ld	s1,8(sp)
    3c6c:	6902                	ld	s2,0(sp)
    3c6e:	6105                	addi	sp,sp,32
    3c70:	8082                	ret
    printf("%s: create dirfile failed\n", s);
    3c72:	85ca                	mv	a1,s2
    3c74:	00004517          	auipc	a0,0x4
    3c78:	a2c50513          	addi	a0,a0,-1492 # 76a0 <malloc+0x1a2a>
    3c7c:	00002097          	auipc	ra,0x2
    3c80:	f42080e7          	jalr	-190(ra) # 5bbe <printf>
    exit(1);
    3c84:	4505                	li	a0,1
    3c86:	00002097          	auipc	ra,0x2
    3c8a:	bbe080e7          	jalr	-1090(ra) # 5844 <exit>
    printf("%s: chdir dirfile succeeded!\n", s);
    3c8e:	85ca                	mv	a1,s2
    3c90:	00004517          	auipc	a0,0x4
    3c94:	a3050513          	addi	a0,a0,-1488 # 76c0 <malloc+0x1a4a>
    3c98:	00002097          	auipc	ra,0x2
    3c9c:	f26080e7          	jalr	-218(ra) # 5bbe <printf>
    exit(1);
    3ca0:	4505                	li	a0,1
    3ca2:	00002097          	auipc	ra,0x2
    3ca6:	ba2080e7          	jalr	-1118(ra) # 5844 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3caa:	85ca                	mv	a1,s2
    3cac:	00004517          	auipc	a0,0x4
    3cb0:	a4450513          	addi	a0,a0,-1468 # 76f0 <malloc+0x1a7a>
    3cb4:	00002097          	auipc	ra,0x2
    3cb8:	f0a080e7          	jalr	-246(ra) # 5bbe <printf>
    exit(1);
    3cbc:	4505                	li	a0,1
    3cbe:	00002097          	auipc	ra,0x2
    3cc2:	b86080e7          	jalr	-1146(ra) # 5844 <exit>
    printf("%s: create dirfile/xx succeeded!\n", s);
    3cc6:	85ca                	mv	a1,s2
    3cc8:	00004517          	auipc	a0,0x4
    3ccc:	a2850513          	addi	a0,a0,-1496 # 76f0 <malloc+0x1a7a>
    3cd0:	00002097          	auipc	ra,0x2
    3cd4:	eee080e7          	jalr	-274(ra) # 5bbe <printf>
    exit(1);
    3cd8:	4505                	li	a0,1
    3cda:	00002097          	auipc	ra,0x2
    3cde:	b6a080e7          	jalr	-1174(ra) # 5844 <exit>
    printf("%s: mkdir dirfile/xx succeeded!\n", s);
    3ce2:	85ca                	mv	a1,s2
    3ce4:	00004517          	auipc	a0,0x4
    3ce8:	a3450513          	addi	a0,a0,-1484 # 7718 <malloc+0x1aa2>
    3cec:	00002097          	auipc	ra,0x2
    3cf0:	ed2080e7          	jalr	-302(ra) # 5bbe <printf>
    exit(1);
    3cf4:	4505                	li	a0,1
    3cf6:	00002097          	auipc	ra,0x2
    3cfa:	b4e080e7          	jalr	-1202(ra) # 5844 <exit>
    printf("%s: unlink dirfile/xx succeeded!\n", s);
    3cfe:	85ca                	mv	a1,s2
    3d00:	00004517          	auipc	a0,0x4
    3d04:	a4050513          	addi	a0,a0,-1472 # 7740 <malloc+0x1aca>
    3d08:	00002097          	auipc	ra,0x2
    3d0c:	eb6080e7          	jalr	-330(ra) # 5bbe <printf>
    exit(1);
    3d10:	4505                	li	a0,1
    3d12:	00002097          	auipc	ra,0x2
    3d16:	b32080e7          	jalr	-1230(ra) # 5844 <exit>
    printf("%s: link to dirfile/xx succeeded!\n", s);
    3d1a:	85ca                	mv	a1,s2
    3d1c:	00004517          	auipc	a0,0x4
    3d20:	a4c50513          	addi	a0,a0,-1460 # 7768 <malloc+0x1af2>
    3d24:	00002097          	auipc	ra,0x2
    3d28:	e9a080e7          	jalr	-358(ra) # 5bbe <printf>
    exit(1);
    3d2c:	4505                	li	a0,1
    3d2e:	00002097          	auipc	ra,0x2
    3d32:	b16080e7          	jalr	-1258(ra) # 5844 <exit>
    printf("%s: unlink dirfile failed!\n", s);
    3d36:	85ca                	mv	a1,s2
    3d38:	00004517          	auipc	a0,0x4
    3d3c:	a5850513          	addi	a0,a0,-1448 # 7790 <malloc+0x1b1a>
    3d40:	00002097          	auipc	ra,0x2
    3d44:	e7e080e7          	jalr	-386(ra) # 5bbe <printf>
    exit(1);
    3d48:	4505                	li	a0,1
    3d4a:	00002097          	auipc	ra,0x2
    3d4e:	afa080e7          	jalr	-1286(ra) # 5844 <exit>
    printf("%s: open . for writing succeeded!\n", s);
    3d52:	85ca                	mv	a1,s2
    3d54:	00004517          	auipc	a0,0x4
    3d58:	a5c50513          	addi	a0,a0,-1444 # 77b0 <malloc+0x1b3a>
    3d5c:	00002097          	auipc	ra,0x2
    3d60:	e62080e7          	jalr	-414(ra) # 5bbe <printf>
    exit(1);
    3d64:	4505                	li	a0,1
    3d66:	00002097          	auipc	ra,0x2
    3d6a:	ade080e7          	jalr	-1314(ra) # 5844 <exit>
    printf("%s: write . succeeded!\n", s);
    3d6e:	85ca                	mv	a1,s2
    3d70:	00004517          	auipc	a0,0x4
    3d74:	a6850513          	addi	a0,a0,-1432 # 77d8 <malloc+0x1b62>
    3d78:	00002097          	auipc	ra,0x2
    3d7c:	e46080e7          	jalr	-442(ra) # 5bbe <printf>
    exit(1);
    3d80:	4505                	li	a0,1
    3d82:	00002097          	auipc	ra,0x2
    3d86:	ac2080e7          	jalr	-1342(ra) # 5844 <exit>

0000000000003d8a <iref>:
{
    3d8a:	7139                	addi	sp,sp,-64
    3d8c:	fc06                	sd	ra,56(sp)
    3d8e:	f822                	sd	s0,48(sp)
    3d90:	f426                	sd	s1,40(sp)
    3d92:	f04a                	sd	s2,32(sp)
    3d94:	ec4e                	sd	s3,24(sp)
    3d96:	e852                	sd	s4,16(sp)
    3d98:	e456                	sd	s5,8(sp)
    3d9a:	e05a                	sd	s6,0(sp)
    3d9c:	0080                	addi	s0,sp,64
    3d9e:	8b2a                	mv	s6,a0
    3da0:	03300913          	li	s2,51
    if(mkdir("irefd") != 0){
    3da4:	00004a17          	auipc	s4,0x4
    3da8:	a4ca0a13          	addi	s4,s4,-1460 # 77f0 <malloc+0x1b7a>
    mkdir("");
    3dac:	00003497          	auipc	s1,0x3
    3db0:	54c48493          	addi	s1,s1,1356 # 72f8 <malloc+0x1682>
    link("README", "");
    3db4:	00002a97          	auipc	s5,0x2
    3db8:	18ca8a93          	addi	s5,s5,396 # 5f40 <malloc+0x2ca>
    fd = open("xx", O_CREATE);
    3dbc:	00004997          	auipc	s3,0x4
    3dc0:	92c98993          	addi	s3,s3,-1748 # 76e8 <malloc+0x1a72>
    3dc4:	a891                	j	3e18 <iref+0x8e>
      printf("%s: mkdir irefd failed\n", s);
    3dc6:	85da                	mv	a1,s6
    3dc8:	00004517          	auipc	a0,0x4
    3dcc:	a3050513          	addi	a0,a0,-1488 # 77f8 <malloc+0x1b82>
    3dd0:	00002097          	auipc	ra,0x2
    3dd4:	dee080e7          	jalr	-530(ra) # 5bbe <printf>
      exit(1);
    3dd8:	4505                	li	a0,1
    3dda:	00002097          	auipc	ra,0x2
    3dde:	a6a080e7          	jalr	-1430(ra) # 5844 <exit>
      printf("%s: chdir irefd failed\n", s);
    3de2:	85da                	mv	a1,s6
    3de4:	00004517          	auipc	a0,0x4
    3de8:	a2c50513          	addi	a0,a0,-1492 # 7810 <malloc+0x1b9a>
    3dec:	00002097          	auipc	ra,0x2
    3df0:	dd2080e7          	jalr	-558(ra) # 5bbe <printf>
      exit(1);
    3df4:	4505                	li	a0,1
    3df6:	00002097          	auipc	ra,0x2
    3dfa:	a4e080e7          	jalr	-1458(ra) # 5844 <exit>
      close(fd);
    3dfe:	00002097          	auipc	ra,0x2
    3e02:	a6e080e7          	jalr	-1426(ra) # 586c <close>
    3e06:	a889                	j	3e58 <iref+0xce>
    unlink("xx");
    3e08:	854e                	mv	a0,s3
    3e0a:	00002097          	auipc	ra,0x2
    3e0e:	a8a080e7          	jalr	-1398(ra) # 5894 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e12:	397d                	addiw	s2,s2,-1
    3e14:	06090063          	beqz	s2,3e74 <iref+0xea>
    if(mkdir("irefd") != 0){
    3e18:	8552                	mv	a0,s4
    3e1a:	00002097          	auipc	ra,0x2
    3e1e:	a92080e7          	jalr	-1390(ra) # 58ac <mkdir>
    3e22:	f155                	bnez	a0,3dc6 <iref+0x3c>
    if(chdir("irefd") != 0){
    3e24:	8552                	mv	a0,s4
    3e26:	00002097          	auipc	ra,0x2
    3e2a:	a8e080e7          	jalr	-1394(ra) # 58b4 <chdir>
    3e2e:	f955                	bnez	a0,3de2 <iref+0x58>
    mkdir("");
    3e30:	8526                	mv	a0,s1
    3e32:	00002097          	auipc	ra,0x2
    3e36:	a7a080e7          	jalr	-1414(ra) # 58ac <mkdir>
    link("README", "");
    3e3a:	85a6                	mv	a1,s1
    3e3c:	8556                	mv	a0,s5
    3e3e:	00002097          	auipc	ra,0x2
    3e42:	a66080e7          	jalr	-1434(ra) # 58a4 <link>
    fd = open("", O_CREATE);
    3e46:	20000593          	li	a1,512
    3e4a:	8526                	mv	a0,s1
    3e4c:	00002097          	auipc	ra,0x2
    3e50:	a38080e7          	jalr	-1480(ra) # 5884 <open>
    if(fd >= 0)
    3e54:	fa0555e3          	bgez	a0,3dfe <iref+0x74>
    fd = open("xx", O_CREATE);
    3e58:	20000593          	li	a1,512
    3e5c:	854e                	mv	a0,s3
    3e5e:	00002097          	auipc	ra,0x2
    3e62:	a26080e7          	jalr	-1498(ra) # 5884 <open>
    if(fd >= 0)
    3e66:	fa0541e3          	bltz	a0,3e08 <iref+0x7e>
      close(fd);
    3e6a:	00002097          	auipc	ra,0x2
    3e6e:	a02080e7          	jalr	-1534(ra) # 586c <close>
    3e72:	bf59                	j	3e08 <iref+0x7e>
    3e74:	03300493          	li	s1,51
    chdir("..");
    3e78:	00003997          	auipc	s3,0x3
    3e7c:	1a098993          	addi	s3,s3,416 # 7018 <malloc+0x13a2>
    unlink("irefd");
    3e80:	00004917          	auipc	s2,0x4
    3e84:	97090913          	addi	s2,s2,-1680 # 77f0 <malloc+0x1b7a>
    chdir("..");
    3e88:	854e                	mv	a0,s3
    3e8a:	00002097          	auipc	ra,0x2
    3e8e:	a2a080e7          	jalr	-1494(ra) # 58b4 <chdir>
    unlink("irefd");
    3e92:	854a                	mv	a0,s2
    3e94:	00002097          	auipc	ra,0x2
    3e98:	a00080e7          	jalr	-1536(ra) # 5894 <unlink>
  for(i = 0; i < NINODE + 1; i++){
    3e9c:	34fd                	addiw	s1,s1,-1
    3e9e:	f4ed                	bnez	s1,3e88 <iref+0xfe>
  chdir("/");
    3ea0:	00003517          	auipc	a0,0x3
    3ea4:	12050513          	addi	a0,a0,288 # 6fc0 <malloc+0x134a>
    3ea8:	00002097          	auipc	ra,0x2
    3eac:	a0c080e7          	jalr	-1524(ra) # 58b4 <chdir>
}
    3eb0:	70e2                	ld	ra,56(sp)
    3eb2:	7442                	ld	s0,48(sp)
    3eb4:	74a2                	ld	s1,40(sp)
    3eb6:	7902                	ld	s2,32(sp)
    3eb8:	69e2                	ld	s3,24(sp)
    3eba:	6a42                	ld	s4,16(sp)
    3ebc:	6aa2                	ld	s5,8(sp)
    3ebe:	6b02                	ld	s6,0(sp)
    3ec0:	6121                	addi	sp,sp,64
    3ec2:	8082                	ret

0000000000003ec4 <openiputtest>:
{
    3ec4:	7179                	addi	sp,sp,-48
    3ec6:	f406                	sd	ra,40(sp)
    3ec8:	f022                	sd	s0,32(sp)
    3eca:	ec26                	sd	s1,24(sp)
    3ecc:	1800                	addi	s0,sp,48
    3ece:	84aa                	mv	s1,a0
  if(mkdir("oidir") < 0){
    3ed0:	00004517          	auipc	a0,0x4
    3ed4:	95850513          	addi	a0,a0,-1704 # 7828 <malloc+0x1bb2>
    3ed8:	00002097          	auipc	ra,0x2
    3edc:	9d4080e7          	jalr	-1580(ra) # 58ac <mkdir>
    3ee0:	04054263          	bltz	a0,3f24 <openiputtest+0x60>
  pid = fork();
    3ee4:	00002097          	auipc	ra,0x2
    3ee8:	958080e7          	jalr	-1704(ra) # 583c <fork>
  if(pid < 0){
    3eec:	04054a63          	bltz	a0,3f40 <openiputtest+0x7c>
  if(pid == 0){
    3ef0:	e93d                	bnez	a0,3f66 <openiputtest+0xa2>
    int fd = open("oidir", O_RDWR);
    3ef2:	4589                	li	a1,2
    3ef4:	00004517          	auipc	a0,0x4
    3ef8:	93450513          	addi	a0,a0,-1740 # 7828 <malloc+0x1bb2>
    3efc:	00002097          	auipc	ra,0x2
    3f00:	988080e7          	jalr	-1656(ra) # 5884 <open>
    if(fd >= 0){
    3f04:	04054c63          	bltz	a0,3f5c <openiputtest+0x98>
      printf("%s: open directory for write succeeded\n", s);
    3f08:	85a6                	mv	a1,s1
    3f0a:	00004517          	auipc	a0,0x4
    3f0e:	93e50513          	addi	a0,a0,-1730 # 7848 <malloc+0x1bd2>
    3f12:	00002097          	auipc	ra,0x2
    3f16:	cac080e7          	jalr	-852(ra) # 5bbe <printf>
      exit(1);
    3f1a:	4505                	li	a0,1
    3f1c:	00002097          	auipc	ra,0x2
    3f20:	928080e7          	jalr	-1752(ra) # 5844 <exit>
    printf("%s: mkdir oidir failed\n", s);
    3f24:	85a6                	mv	a1,s1
    3f26:	00004517          	auipc	a0,0x4
    3f2a:	90a50513          	addi	a0,a0,-1782 # 7830 <malloc+0x1bba>
    3f2e:	00002097          	auipc	ra,0x2
    3f32:	c90080e7          	jalr	-880(ra) # 5bbe <printf>
    exit(1);
    3f36:	4505                	li	a0,1
    3f38:	00002097          	auipc	ra,0x2
    3f3c:	90c080e7          	jalr	-1780(ra) # 5844 <exit>
    printf("%s: fork failed\n", s);
    3f40:	85a6                	mv	a1,s1
    3f42:	00002517          	auipc	a0,0x2
    3f46:	6ae50513          	addi	a0,a0,1710 # 65f0 <malloc+0x97a>
    3f4a:	00002097          	auipc	ra,0x2
    3f4e:	c74080e7          	jalr	-908(ra) # 5bbe <printf>
    exit(1);
    3f52:	4505                	li	a0,1
    3f54:	00002097          	auipc	ra,0x2
    3f58:	8f0080e7          	jalr	-1808(ra) # 5844 <exit>
    exit(0);
    3f5c:	4501                	li	a0,0
    3f5e:	00002097          	auipc	ra,0x2
    3f62:	8e6080e7          	jalr	-1818(ra) # 5844 <exit>
  sleep(1);
    3f66:	4505                	li	a0,1
    3f68:	00002097          	auipc	ra,0x2
    3f6c:	96c080e7          	jalr	-1684(ra) # 58d4 <sleep>
  if(unlink("oidir") != 0){
    3f70:	00004517          	auipc	a0,0x4
    3f74:	8b850513          	addi	a0,a0,-1864 # 7828 <malloc+0x1bb2>
    3f78:	00002097          	auipc	ra,0x2
    3f7c:	91c080e7          	jalr	-1764(ra) # 5894 <unlink>
    3f80:	cd19                	beqz	a0,3f9e <openiputtest+0xda>
    printf("%s: unlink failed\n", s);
    3f82:	85a6                	mv	a1,s1
    3f84:	00003517          	auipc	a0,0x3
    3f88:	85c50513          	addi	a0,a0,-1956 # 67e0 <malloc+0xb6a>
    3f8c:	00002097          	auipc	ra,0x2
    3f90:	c32080e7          	jalr	-974(ra) # 5bbe <printf>
    exit(1);
    3f94:	4505                	li	a0,1
    3f96:	00002097          	auipc	ra,0x2
    3f9a:	8ae080e7          	jalr	-1874(ra) # 5844 <exit>
  wait(&xstatus);
    3f9e:	fdc40513          	addi	a0,s0,-36
    3fa2:	00002097          	auipc	ra,0x2
    3fa6:	8aa080e7          	jalr	-1878(ra) # 584c <wait>
  exit(xstatus);
    3faa:	fdc42503          	lw	a0,-36(s0)
    3fae:	00002097          	auipc	ra,0x2
    3fb2:	896080e7          	jalr	-1898(ra) # 5844 <exit>

0000000000003fb6 <forkforkfork>:
{
    3fb6:	1101                	addi	sp,sp,-32
    3fb8:	ec06                	sd	ra,24(sp)
    3fba:	e822                	sd	s0,16(sp)
    3fbc:	e426                	sd	s1,8(sp)
    3fbe:	1000                	addi	s0,sp,32
    3fc0:	84aa                	mv	s1,a0
  unlink("stopforking");
    3fc2:	00004517          	auipc	a0,0x4
    3fc6:	8ae50513          	addi	a0,a0,-1874 # 7870 <malloc+0x1bfa>
    3fca:	00002097          	auipc	ra,0x2
    3fce:	8ca080e7          	jalr	-1846(ra) # 5894 <unlink>
  int pid = fork();
    3fd2:	00002097          	auipc	ra,0x2
    3fd6:	86a080e7          	jalr	-1942(ra) # 583c <fork>
  if(pid < 0){
    3fda:	04054563          	bltz	a0,4024 <forkforkfork+0x6e>
  if(pid == 0){
    3fde:	c12d                	beqz	a0,4040 <forkforkfork+0x8a>
  sleep(20); // two seconds
    3fe0:	4551                	li	a0,20
    3fe2:	00002097          	auipc	ra,0x2
    3fe6:	8f2080e7          	jalr	-1806(ra) # 58d4 <sleep>
  close(open("stopforking", O_CREATE|O_RDWR));
    3fea:	20200593          	li	a1,514
    3fee:	00004517          	auipc	a0,0x4
    3ff2:	88250513          	addi	a0,a0,-1918 # 7870 <malloc+0x1bfa>
    3ff6:	00002097          	auipc	ra,0x2
    3ffa:	88e080e7          	jalr	-1906(ra) # 5884 <open>
    3ffe:	00002097          	auipc	ra,0x2
    4002:	86e080e7          	jalr	-1938(ra) # 586c <close>
  wait(0);
    4006:	4501                	li	a0,0
    4008:	00002097          	auipc	ra,0x2
    400c:	844080e7          	jalr	-1980(ra) # 584c <wait>
  sleep(10); // one second
    4010:	4529                	li	a0,10
    4012:	00002097          	auipc	ra,0x2
    4016:	8c2080e7          	jalr	-1854(ra) # 58d4 <sleep>
}
    401a:	60e2                	ld	ra,24(sp)
    401c:	6442                	ld	s0,16(sp)
    401e:	64a2                	ld	s1,8(sp)
    4020:	6105                	addi	sp,sp,32
    4022:	8082                	ret
    printf("%s: fork failed", s);
    4024:	85a6                	mv	a1,s1
    4026:	00002517          	auipc	a0,0x2
    402a:	78a50513          	addi	a0,a0,1930 # 67b0 <malloc+0xb3a>
    402e:	00002097          	auipc	ra,0x2
    4032:	b90080e7          	jalr	-1136(ra) # 5bbe <printf>
    exit(1);
    4036:	4505                	li	a0,1
    4038:	00002097          	auipc	ra,0x2
    403c:	80c080e7          	jalr	-2036(ra) # 5844 <exit>
      int fd = open("stopforking", 0);
    4040:	00004497          	auipc	s1,0x4
    4044:	83048493          	addi	s1,s1,-2000 # 7870 <malloc+0x1bfa>
    4048:	4581                	li	a1,0
    404a:	8526                	mv	a0,s1
    404c:	00002097          	auipc	ra,0x2
    4050:	838080e7          	jalr	-1992(ra) # 5884 <open>
      if(fd >= 0){
    4054:	02055463          	bgez	a0,407c <forkforkfork+0xc6>
      if(fork() < 0){
    4058:	00001097          	auipc	ra,0x1
    405c:	7e4080e7          	jalr	2020(ra) # 583c <fork>
    4060:	fe0554e3          	bgez	a0,4048 <forkforkfork+0x92>
        close(open("stopforking", O_CREATE|O_RDWR));
    4064:	20200593          	li	a1,514
    4068:	8526                	mv	a0,s1
    406a:	00002097          	auipc	ra,0x2
    406e:	81a080e7          	jalr	-2022(ra) # 5884 <open>
    4072:	00001097          	auipc	ra,0x1
    4076:	7fa080e7          	jalr	2042(ra) # 586c <close>
    407a:	b7f9                	j	4048 <forkforkfork+0x92>
        exit(0);
    407c:	4501                	li	a0,0
    407e:	00001097          	auipc	ra,0x1
    4082:	7c6080e7          	jalr	1990(ra) # 5844 <exit>

0000000000004086 <killstatus>:
{
    4086:	7139                	addi	sp,sp,-64
    4088:	fc06                	sd	ra,56(sp)
    408a:	f822                	sd	s0,48(sp)
    408c:	f426                	sd	s1,40(sp)
    408e:	f04a                	sd	s2,32(sp)
    4090:	ec4e                	sd	s3,24(sp)
    4092:	e852                	sd	s4,16(sp)
    4094:	0080                	addi	s0,sp,64
    4096:	8a2a                	mv	s4,a0
    4098:	06400913          	li	s2,100
    if(xst != -1) {
    409c:	59fd                	li	s3,-1
    int pid1 = fork();
    409e:	00001097          	auipc	ra,0x1
    40a2:	79e080e7          	jalr	1950(ra) # 583c <fork>
    40a6:	84aa                	mv	s1,a0
    if(pid1 < 0){
    40a8:	02054f63          	bltz	a0,40e6 <killstatus+0x60>
    if(pid1 == 0){
    40ac:	c939                	beqz	a0,4102 <killstatus+0x7c>
    sleep(1);
    40ae:	4505                	li	a0,1
    40b0:	00002097          	auipc	ra,0x2
    40b4:	824080e7          	jalr	-2012(ra) # 58d4 <sleep>
    kill(pid1);
    40b8:	8526                	mv	a0,s1
    40ba:	00001097          	auipc	ra,0x1
    40be:	7ba080e7          	jalr	1978(ra) # 5874 <kill>
    wait(&xst);
    40c2:	fcc40513          	addi	a0,s0,-52
    40c6:	00001097          	auipc	ra,0x1
    40ca:	786080e7          	jalr	1926(ra) # 584c <wait>
    if(xst != -1) {
    40ce:	fcc42783          	lw	a5,-52(s0)
    40d2:	03379d63          	bne	a5,s3,410c <killstatus+0x86>
  for(int i = 0; i < 100; i++){
    40d6:	397d                	addiw	s2,s2,-1
    40d8:	fc0913e3          	bnez	s2,409e <killstatus+0x18>
  exit(0);
    40dc:	4501                	li	a0,0
    40de:	00001097          	auipc	ra,0x1
    40e2:	766080e7          	jalr	1894(ra) # 5844 <exit>
      printf("%s: fork failed\n", s);
    40e6:	85d2                	mv	a1,s4
    40e8:	00002517          	auipc	a0,0x2
    40ec:	50850513          	addi	a0,a0,1288 # 65f0 <malloc+0x97a>
    40f0:	00002097          	auipc	ra,0x2
    40f4:	ace080e7          	jalr	-1330(ra) # 5bbe <printf>
      exit(1);
    40f8:	4505                	li	a0,1
    40fa:	00001097          	auipc	ra,0x1
    40fe:	74a080e7          	jalr	1866(ra) # 5844 <exit>
        getpid();
    4102:	00001097          	auipc	ra,0x1
    4106:	7c2080e7          	jalr	1986(ra) # 58c4 <getpid>
      while(1) {
    410a:	bfe5                	j	4102 <killstatus+0x7c>
       printf("%s: status should be -1\n", s);
    410c:	85d2                	mv	a1,s4
    410e:	00003517          	auipc	a0,0x3
    4112:	77250513          	addi	a0,a0,1906 # 7880 <malloc+0x1c0a>
    4116:	00002097          	auipc	ra,0x2
    411a:	aa8080e7          	jalr	-1368(ra) # 5bbe <printf>
       exit(1);
    411e:	4505                	li	a0,1
    4120:	00001097          	auipc	ra,0x1
    4124:	724080e7          	jalr	1828(ra) # 5844 <exit>

0000000000004128 <preempt>:
{
    4128:	7139                	addi	sp,sp,-64
    412a:	fc06                	sd	ra,56(sp)
    412c:	f822                	sd	s0,48(sp)
    412e:	f426                	sd	s1,40(sp)
    4130:	f04a                	sd	s2,32(sp)
    4132:	ec4e                	sd	s3,24(sp)
    4134:	e852                	sd	s4,16(sp)
    4136:	0080                	addi	s0,sp,64
    4138:	892a                	mv	s2,a0
  pid1 = fork();
    413a:	00001097          	auipc	ra,0x1
    413e:	702080e7          	jalr	1794(ra) # 583c <fork>
  if(pid1 < 0) {
    4142:	00054563          	bltz	a0,414c <preempt+0x24>
    4146:	84aa                	mv	s1,a0
  if(pid1 == 0)
    4148:	e105                	bnez	a0,4168 <preempt+0x40>
    for(;;)
    414a:	a001                	j	414a <preempt+0x22>
    printf("%s: fork failed", s);
    414c:	85ca                	mv	a1,s2
    414e:	00002517          	auipc	a0,0x2
    4152:	66250513          	addi	a0,a0,1634 # 67b0 <malloc+0xb3a>
    4156:	00002097          	auipc	ra,0x2
    415a:	a68080e7          	jalr	-1432(ra) # 5bbe <printf>
    exit(1);
    415e:	4505                	li	a0,1
    4160:	00001097          	auipc	ra,0x1
    4164:	6e4080e7          	jalr	1764(ra) # 5844 <exit>
  pid2 = fork();
    4168:	00001097          	auipc	ra,0x1
    416c:	6d4080e7          	jalr	1748(ra) # 583c <fork>
    4170:	89aa                	mv	s3,a0
  if(pid2 < 0) {
    4172:	00054463          	bltz	a0,417a <preempt+0x52>
  if(pid2 == 0)
    4176:	e105                	bnez	a0,4196 <preempt+0x6e>
    for(;;)
    4178:	a001                	j	4178 <preempt+0x50>
    printf("%s: fork failed\n", s);
    417a:	85ca                	mv	a1,s2
    417c:	00002517          	auipc	a0,0x2
    4180:	47450513          	addi	a0,a0,1140 # 65f0 <malloc+0x97a>
    4184:	00002097          	auipc	ra,0x2
    4188:	a3a080e7          	jalr	-1478(ra) # 5bbe <printf>
    exit(1);
    418c:	4505                	li	a0,1
    418e:	00001097          	auipc	ra,0x1
    4192:	6b6080e7          	jalr	1718(ra) # 5844 <exit>
  pipe(pfds);
    4196:	fc840513          	addi	a0,s0,-56
    419a:	00001097          	auipc	ra,0x1
    419e:	6ba080e7          	jalr	1722(ra) # 5854 <pipe>
  pid3 = fork();
    41a2:	00001097          	auipc	ra,0x1
    41a6:	69a080e7          	jalr	1690(ra) # 583c <fork>
    41aa:	8a2a                	mv	s4,a0
  if(pid3 < 0) {
    41ac:	02054e63          	bltz	a0,41e8 <preempt+0xc0>
  if(pid3 == 0){
    41b0:	e525                	bnez	a0,4218 <preempt+0xf0>
    close(pfds[0]);
    41b2:	fc842503          	lw	a0,-56(s0)
    41b6:	00001097          	auipc	ra,0x1
    41ba:	6b6080e7          	jalr	1718(ra) # 586c <close>
    if(write(pfds[1], "x", 1) != 1)
    41be:	4605                	li	a2,1
    41c0:	00002597          	auipc	a1,0x2
    41c4:	c4858593          	addi	a1,a1,-952 # 5e08 <malloc+0x192>
    41c8:	fcc42503          	lw	a0,-52(s0)
    41cc:	00001097          	auipc	ra,0x1
    41d0:	698080e7          	jalr	1688(ra) # 5864 <write>
    41d4:	4785                	li	a5,1
    41d6:	02f51763          	bne	a0,a5,4204 <preempt+0xdc>
    close(pfds[1]);
    41da:	fcc42503          	lw	a0,-52(s0)
    41de:	00001097          	auipc	ra,0x1
    41e2:	68e080e7          	jalr	1678(ra) # 586c <close>
    for(;;)
    41e6:	a001                	j	41e6 <preempt+0xbe>
     printf("%s: fork failed\n", s);
    41e8:	85ca                	mv	a1,s2
    41ea:	00002517          	auipc	a0,0x2
    41ee:	40650513          	addi	a0,a0,1030 # 65f0 <malloc+0x97a>
    41f2:	00002097          	auipc	ra,0x2
    41f6:	9cc080e7          	jalr	-1588(ra) # 5bbe <printf>
     exit(1);
    41fa:	4505                	li	a0,1
    41fc:	00001097          	auipc	ra,0x1
    4200:	648080e7          	jalr	1608(ra) # 5844 <exit>
      printf("%s: preempt write error", s);
    4204:	85ca                	mv	a1,s2
    4206:	00003517          	auipc	a0,0x3
    420a:	69a50513          	addi	a0,a0,1690 # 78a0 <malloc+0x1c2a>
    420e:	00002097          	auipc	ra,0x2
    4212:	9b0080e7          	jalr	-1616(ra) # 5bbe <printf>
    4216:	b7d1                	j	41da <preempt+0xb2>
  close(pfds[1]);
    4218:	fcc42503          	lw	a0,-52(s0)
    421c:	00001097          	auipc	ra,0x1
    4220:	650080e7          	jalr	1616(ra) # 586c <close>
  if(read(pfds[0], buf, sizeof(buf)) != 1){
    4224:	660d                	lui	a2,0x3
    4226:	00008597          	auipc	a1,0x8
    422a:	bb258593          	addi	a1,a1,-1102 # bdd8 <buf>
    422e:	fc842503          	lw	a0,-56(s0)
    4232:	00001097          	auipc	ra,0x1
    4236:	62a080e7          	jalr	1578(ra) # 585c <read>
    423a:	4785                	li	a5,1
    423c:	02f50363          	beq	a0,a5,4262 <preempt+0x13a>
    printf("%s: preempt read error", s);
    4240:	85ca                	mv	a1,s2
    4242:	00003517          	auipc	a0,0x3
    4246:	67650513          	addi	a0,a0,1654 # 78b8 <malloc+0x1c42>
    424a:	00002097          	auipc	ra,0x2
    424e:	974080e7          	jalr	-1676(ra) # 5bbe <printf>
}
    4252:	70e2                	ld	ra,56(sp)
    4254:	7442                	ld	s0,48(sp)
    4256:	74a2                	ld	s1,40(sp)
    4258:	7902                	ld	s2,32(sp)
    425a:	69e2                	ld	s3,24(sp)
    425c:	6a42                	ld	s4,16(sp)
    425e:	6121                	addi	sp,sp,64
    4260:	8082                	ret
  close(pfds[0]);
    4262:	fc842503          	lw	a0,-56(s0)
    4266:	00001097          	auipc	ra,0x1
    426a:	606080e7          	jalr	1542(ra) # 586c <close>
  printf("kill... ");
    426e:	00003517          	auipc	a0,0x3
    4272:	66250513          	addi	a0,a0,1634 # 78d0 <malloc+0x1c5a>
    4276:	00002097          	auipc	ra,0x2
    427a:	948080e7          	jalr	-1720(ra) # 5bbe <printf>
  kill(pid1);
    427e:	8526                	mv	a0,s1
    4280:	00001097          	auipc	ra,0x1
    4284:	5f4080e7          	jalr	1524(ra) # 5874 <kill>
  kill(pid2);
    4288:	854e                	mv	a0,s3
    428a:	00001097          	auipc	ra,0x1
    428e:	5ea080e7          	jalr	1514(ra) # 5874 <kill>
  kill(pid3);
    4292:	8552                	mv	a0,s4
    4294:	00001097          	auipc	ra,0x1
    4298:	5e0080e7          	jalr	1504(ra) # 5874 <kill>
  printf("wait... ");
    429c:	00003517          	auipc	a0,0x3
    42a0:	64450513          	addi	a0,a0,1604 # 78e0 <malloc+0x1c6a>
    42a4:	00002097          	auipc	ra,0x2
    42a8:	91a080e7          	jalr	-1766(ra) # 5bbe <printf>
  wait(0);
    42ac:	4501                	li	a0,0
    42ae:	00001097          	auipc	ra,0x1
    42b2:	59e080e7          	jalr	1438(ra) # 584c <wait>
  wait(0);
    42b6:	4501                	li	a0,0
    42b8:	00001097          	auipc	ra,0x1
    42bc:	594080e7          	jalr	1428(ra) # 584c <wait>
  wait(0);
    42c0:	4501                	li	a0,0
    42c2:	00001097          	auipc	ra,0x1
    42c6:	58a080e7          	jalr	1418(ra) # 584c <wait>
    42ca:	b761                	j	4252 <preempt+0x12a>

00000000000042cc <reparent>:
{
    42cc:	7179                	addi	sp,sp,-48
    42ce:	f406                	sd	ra,40(sp)
    42d0:	f022                	sd	s0,32(sp)
    42d2:	ec26                	sd	s1,24(sp)
    42d4:	e84a                	sd	s2,16(sp)
    42d6:	e44e                	sd	s3,8(sp)
    42d8:	e052                	sd	s4,0(sp)
    42da:	1800                	addi	s0,sp,48
    42dc:	89aa                	mv	s3,a0
  int master_pid = getpid();
    42de:	00001097          	auipc	ra,0x1
    42e2:	5e6080e7          	jalr	1510(ra) # 58c4 <getpid>
    42e6:	8a2a                	mv	s4,a0
    42e8:	0c800913          	li	s2,200
    int pid = fork();
    42ec:	00001097          	auipc	ra,0x1
    42f0:	550080e7          	jalr	1360(ra) # 583c <fork>
    42f4:	84aa                	mv	s1,a0
    if(pid < 0){
    42f6:	02054263          	bltz	a0,431a <reparent+0x4e>
    if(pid){
    42fa:	cd21                	beqz	a0,4352 <reparent+0x86>
      if(wait(0) != pid){
    42fc:	4501                	li	a0,0
    42fe:	00001097          	auipc	ra,0x1
    4302:	54e080e7          	jalr	1358(ra) # 584c <wait>
    4306:	02951863          	bne	a0,s1,4336 <reparent+0x6a>
  for(int i = 0; i < 200; i++){
    430a:	397d                	addiw	s2,s2,-1
    430c:	fe0910e3          	bnez	s2,42ec <reparent+0x20>
  exit(0);
    4310:	4501                	li	a0,0
    4312:	00001097          	auipc	ra,0x1
    4316:	532080e7          	jalr	1330(ra) # 5844 <exit>
      printf("%s: fork failed\n", s);
    431a:	85ce                	mv	a1,s3
    431c:	00002517          	auipc	a0,0x2
    4320:	2d450513          	addi	a0,a0,724 # 65f0 <malloc+0x97a>
    4324:	00002097          	auipc	ra,0x2
    4328:	89a080e7          	jalr	-1894(ra) # 5bbe <printf>
      exit(1);
    432c:	4505                	li	a0,1
    432e:	00001097          	auipc	ra,0x1
    4332:	516080e7          	jalr	1302(ra) # 5844 <exit>
        printf("%s: wait wrong pid\n", s);
    4336:	85ce                	mv	a1,s3
    4338:	00002517          	auipc	a0,0x2
    433c:	44050513          	addi	a0,a0,1088 # 6778 <malloc+0xb02>
    4340:	00002097          	auipc	ra,0x2
    4344:	87e080e7          	jalr	-1922(ra) # 5bbe <printf>
        exit(1);
    4348:	4505                	li	a0,1
    434a:	00001097          	auipc	ra,0x1
    434e:	4fa080e7          	jalr	1274(ra) # 5844 <exit>
      int pid2 = fork();
    4352:	00001097          	auipc	ra,0x1
    4356:	4ea080e7          	jalr	1258(ra) # 583c <fork>
      if(pid2 < 0){
    435a:	00054763          	bltz	a0,4368 <reparent+0x9c>
      exit(0);
    435e:	4501                	li	a0,0
    4360:	00001097          	auipc	ra,0x1
    4364:	4e4080e7          	jalr	1252(ra) # 5844 <exit>
        kill(master_pid);
    4368:	8552                	mv	a0,s4
    436a:	00001097          	auipc	ra,0x1
    436e:	50a080e7          	jalr	1290(ra) # 5874 <kill>
        exit(1);
    4372:	4505                	li	a0,1
    4374:	00001097          	auipc	ra,0x1
    4378:	4d0080e7          	jalr	1232(ra) # 5844 <exit>

000000000000437c <sbrkfail>:
{
    437c:	7119                	addi	sp,sp,-128
    437e:	fc86                	sd	ra,120(sp)
    4380:	f8a2                	sd	s0,112(sp)
    4382:	f4a6                	sd	s1,104(sp)
    4384:	f0ca                	sd	s2,96(sp)
    4386:	ecce                	sd	s3,88(sp)
    4388:	e8d2                	sd	s4,80(sp)
    438a:	e4d6                	sd	s5,72(sp)
    438c:	0100                	addi	s0,sp,128
    438e:	8aaa                	mv	s5,a0
  if(pipe(fds) != 0){
    4390:	fb040513          	addi	a0,s0,-80
    4394:	00001097          	auipc	ra,0x1
    4398:	4c0080e7          	jalr	1216(ra) # 5854 <pipe>
    439c:	e901                	bnez	a0,43ac <sbrkfail+0x30>
    439e:	f8040493          	addi	s1,s0,-128
    43a2:	fa840993          	addi	s3,s0,-88
    43a6:	8926                	mv	s2,s1
    if(pids[i] != -1)
    43a8:	5a7d                	li	s4,-1
    43aa:	a085                	j	440a <sbrkfail+0x8e>
    printf("%s: pipe() failed\n", s);
    43ac:	85d6                	mv	a1,s5
    43ae:	00002517          	auipc	a0,0x2
    43b2:	34a50513          	addi	a0,a0,842 # 66f8 <malloc+0xa82>
    43b6:	00002097          	auipc	ra,0x2
    43ba:	808080e7          	jalr	-2040(ra) # 5bbe <printf>
    exit(1);
    43be:	4505                	li	a0,1
    43c0:	00001097          	auipc	ra,0x1
    43c4:	484080e7          	jalr	1156(ra) # 5844 <exit>
      sbrk(BIG - (uint64)sbrk(0));
    43c8:	00001097          	auipc	ra,0x1
    43cc:	504080e7          	jalr	1284(ra) # 58cc <sbrk>
    43d0:	064007b7          	lui	a5,0x6400
    43d4:	40a7853b          	subw	a0,a5,a0
    43d8:	00001097          	auipc	ra,0x1
    43dc:	4f4080e7          	jalr	1268(ra) # 58cc <sbrk>
      write(fds[1], "x", 1);
    43e0:	4605                	li	a2,1
    43e2:	00002597          	auipc	a1,0x2
    43e6:	a2658593          	addi	a1,a1,-1498 # 5e08 <malloc+0x192>
    43ea:	fb442503          	lw	a0,-76(s0)
    43ee:	00001097          	auipc	ra,0x1
    43f2:	476080e7          	jalr	1142(ra) # 5864 <write>
      for(;;) sleep(1000);
    43f6:	3e800513          	li	a0,1000
    43fa:	00001097          	auipc	ra,0x1
    43fe:	4da080e7          	jalr	1242(ra) # 58d4 <sleep>
    4402:	bfd5                	j	43f6 <sbrkfail+0x7a>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4404:	0911                	addi	s2,s2,4
    4406:	03390563          	beq	s2,s3,4430 <sbrkfail+0xb4>
    if((pids[i] = fork()) == 0){
    440a:	00001097          	auipc	ra,0x1
    440e:	432080e7          	jalr	1074(ra) # 583c <fork>
    4412:	00a92023          	sw	a0,0(s2)
    4416:	d94d                	beqz	a0,43c8 <sbrkfail+0x4c>
    if(pids[i] != -1)
    4418:	ff4506e3          	beq	a0,s4,4404 <sbrkfail+0x88>
      read(fds[0], &scratch, 1);
    441c:	4605                	li	a2,1
    441e:	faf40593          	addi	a1,s0,-81
    4422:	fb042503          	lw	a0,-80(s0)
    4426:	00001097          	auipc	ra,0x1
    442a:	436080e7          	jalr	1078(ra) # 585c <read>
    442e:	bfd9                	j	4404 <sbrkfail+0x88>
  c = sbrk(PGSIZE);
    4430:	6505                	lui	a0,0x1
    4432:	00001097          	auipc	ra,0x1
    4436:	49a080e7          	jalr	1178(ra) # 58cc <sbrk>
    443a:	8a2a                	mv	s4,a0
    if(pids[i] == -1)
    443c:	597d                	li	s2,-1
    443e:	a021                	j	4446 <sbrkfail+0xca>
  for(i = 0; i < sizeof(pids)/sizeof(pids[0]); i++){
    4440:	0491                	addi	s1,s1,4
    4442:	01348f63          	beq	s1,s3,4460 <sbrkfail+0xe4>
    if(pids[i] == -1)
    4446:	4088                	lw	a0,0(s1)
    4448:	ff250ce3          	beq	a0,s2,4440 <sbrkfail+0xc4>
    kill(pids[i]);
    444c:	00001097          	auipc	ra,0x1
    4450:	428080e7          	jalr	1064(ra) # 5874 <kill>
    wait(0);
    4454:	4501                	li	a0,0
    4456:	00001097          	auipc	ra,0x1
    445a:	3f6080e7          	jalr	1014(ra) # 584c <wait>
    445e:	b7cd                	j	4440 <sbrkfail+0xc4>
  if(c == (char*)0xffffffffffffffffL){
    4460:	57fd                	li	a5,-1
    4462:	04fa0163          	beq	s4,a5,44a4 <sbrkfail+0x128>
  pid = fork();
    4466:	00001097          	auipc	ra,0x1
    446a:	3d6080e7          	jalr	982(ra) # 583c <fork>
    446e:	84aa                	mv	s1,a0
  if(pid < 0){
    4470:	04054863          	bltz	a0,44c0 <sbrkfail+0x144>
  if(pid == 0){
    4474:	c525                	beqz	a0,44dc <sbrkfail+0x160>
  wait(&xstatus);
    4476:	fbc40513          	addi	a0,s0,-68
    447a:	00001097          	auipc	ra,0x1
    447e:	3d2080e7          	jalr	978(ra) # 584c <wait>
  if(xstatus != -1 && xstatus != 2)
    4482:	fbc42783          	lw	a5,-68(s0)
    4486:	577d                	li	a4,-1
    4488:	00e78563          	beq	a5,a4,4492 <sbrkfail+0x116>
    448c:	4709                	li	a4,2
    448e:	08e79d63          	bne	a5,a4,4528 <sbrkfail+0x1ac>
}
    4492:	70e6                	ld	ra,120(sp)
    4494:	7446                	ld	s0,112(sp)
    4496:	74a6                	ld	s1,104(sp)
    4498:	7906                	ld	s2,96(sp)
    449a:	69e6                	ld	s3,88(sp)
    449c:	6a46                	ld	s4,80(sp)
    449e:	6aa6                	ld	s5,72(sp)
    44a0:	6109                	addi	sp,sp,128
    44a2:	8082                	ret
    printf("%s: failed sbrk leaked memory\n", s);
    44a4:	85d6                	mv	a1,s5
    44a6:	00003517          	auipc	a0,0x3
    44aa:	44a50513          	addi	a0,a0,1098 # 78f0 <malloc+0x1c7a>
    44ae:	00001097          	auipc	ra,0x1
    44b2:	710080e7          	jalr	1808(ra) # 5bbe <printf>
    exit(1);
    44b6:	4505                	li	a0,1
    44b8:	00001097          	auipc	ra,0x1
    44bc:	38c080e7          	jalr	908(ra) # 5844 <exit>
    printf("%s: fork failed\n", s);
    44c0:	85d6                	mv	a1,s5
    44c2:	00002517          	auipc	a0,0x2
    44c6:	12e50513          	addi	a0,a0,302 # 65f0 <malloc+0x97a>
    44ca:	00001097          	auipc	ra,0x1
    44ce:	6f4080e7          	jalr	1780(ra) # 5bbe <printf>
    exit(1);
    44d2:	4505                	li	a0,1
    44d4:	00001097          	auipc	ra,0x1
    44d8:	370080e7          	jalr	880(ra) # 5844 <exit>
    a = sbrk(0);
    44dc:	4501                	li	a0,0
    44de:	00001097          	auipc	ra,0x1
    44e2:	3ee080e7          	jalr	1006(ra) # 58cc <sbrk>
    44e6:	892a                	mv	s2,a0
    sbrk(10*BIG);
    44e8:	3e800537          	lui	a0,0x3e800
    44ec:	00001097          	auipc	ra,0x1
    44f0:	3e0080e7          	jalr	992(ra) # 58cc <sbrk>
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    44f4:	87ca                	mv	a5,s2
    44f6:	3e800737          	lui	a4,0x3e800
    44fa:	993a                	add	s2,s2,a4
    44fc:	6705                	lui	a4,0x1
      n += *(a+i);
    44fe:	0007c683          	lbu	a3,0(a5) # 6400000 <__BSS_END__+0x63f1218>
    4502:	9cb5                	addw	s1,s1,a3
    for (i = 0; i < 10*BIG; i += PGSIZE) {
    4504:	97ba                	add	a5,a5,a4
    4506:	ff279ce3          	bne	a5,s2,44fe <sbrkfail+0x182>
    printf("%s: allocate a lot of memory succeeded %d\n", s, n);
    450a:	8626                	mv	a2,s1
    450c:	85d6                	mv	a1,s5
    450e:	00003517          	auipc	a0,0x3
    4512:	40250513          	addi	a0,a0,1026 # 7910 <malloc+0x1c9a>
    4516:	00001097          	auipc	ra,0x1
    451a:	6a8080e7          	jalr	1704(ra) # 5bbe <printf>
    exit(1);
    451e:	4505                	li	a0,1
    4520:	00001097          	auipc	ra,0x1
    4524:	324080e7          	jalr	804(ra) # 5844 <exit>
    exit(1);
    4528:	4505                	li	a0,1
    452a:	00001097          	auipc	ra,0x1
    452e:	31a080e7          	jalr	794(ra) # 5844 <exit>

0000000000004532 <mem>:
{
    4532:	7139                	addi	sp,sp,-64
    4534:	fc06                	sd	ra,56(sp)
    4536:	f822                	sd	s0,48(sp)
    4538:	f426                	sd	s1,40(sp)
    453a:	f04a                	sd	s2,32(sp)
    453c:	ec4e                	sd	s3,24(sp)
    453e:	0080                	addi	s0,sp,64
    4540:	89aa                	mv	s3,a0
  if((pid = fork()) == 0){
    4542:	00001097          	auipc	ra,0x1
    4546:	2fa080e7          	jalr	762(ra) # 583c <fork>
    m1 = 0;
    454a:	4481                	li	s1,0
    while((m2 = malloc(10001)) != 0){
    454c:	6909                	lui	s2,0x2
    454e:	71190913          	addi	s2,s2,1809 # 2711 <sbrkbasic+0xaf>
  if((pid = fork()) == 0){
    4552:	c115                	beqz	a0,4576 <mem+0x44>
    wait(&xstatus);
    4554:	fcc40513          	addi	a0,s0,-52
    4558:	00001097          	auipc	ra,0x1
    455c:	2f4080e7          	jalr	756(ra) # 584c <wait>
    if(xstatus == -1){
    4560:	fcc42503          	lw	a0,-52(s0)
    4564:	57fd                	li	a5,-1
    4566:	06f50363          	beq	a0,a5,45cc <mem+0x9a>
    exit(xstatus);
    456a:	00001097          	auipc	ra,0x1
    456e:	2da080e7          	jalr	730(ra) # 5844 <exit>
      *(char**)m2 = m1;
    4572:	e104                	sd	s1,0(a0)
      m1 = m2;
    4574:	84aa                	mv	s1,a0
    while((m2 = malloc(10001)) != 0){
    4576:	854a                	mv	a0,s2
    4578:	00001097          	auipc	ra,0x1
    457c:	6fe080e7          	jalr	1790(ra) # 5c76 <malloc>
    4580:	f96d                	bnez	a0,4572 <mem+0x40>
    while(m1){
    4582:	c881                	beqz	s1,4592 <mem+0x60>
      m2 = *(char**)m1;
    4584:	8526                	mv	a0,s1
    4586:	6084                	ld	s1,0(s1)
      free(m1);
    4588:	00001097          	auipc	ra,0x1
    458c:	66c080e7          	jalr	1644(ra) # 5bf4 <free>
    while(m1){
    4590:	f8f5                	bnez	s1,4584 <mem+0x52>
    m1 = malloc(1024*20);
    4592:	6515                	lui	a0,0x5
    4594:	00001097          	auipc	ra,0x1
    4598:	6e2080e7          	jalr	1762(ra) # 5c76 <malloc>
    if(m1 == 0){
    459c:	c911                	beqz	a0,45b0 <mem+0x7e>
    free(m1);
    459e:	00001097          	auipc	ra,0x1
    45a2:	656080e7          	jalr	1622(ra) # 5bf4 <free>
    exit(0);
    45a6:	4501                	li	a0,0
    45a8:	00001097          	auipc	ra,0x1
    45ac:	29c080e7          	jalr	668(ra) # 5844 <exit>
      printf("couldn't allocate mem?!!\n", s);
    45b0:	85ce                	mv	a1,s3
    45b2:	00003517          	auipc	a0,0x3
    45b6:	38e50513          	addi	a0,a0,910 # 7940 <malloc+0x1cca>
    45ba:	00001097          	auipc	ra,0x1
    45be:	604080e7          	jalr	1540(ra) # 5bbe <printf>
      exit(1);
    45c2:	4505                	li	a0,1
    45c4:	00001097          	auipc	ra,0x1
    45c8:	280080e7          	jalr	640(ra) # 5844 <exit>
      exit(0);
    45cc:	4501                	li	a0,0
    45ce:	00001097          	auipc	ra,0x1
    45d2:	276080e7          	jalr	630(ra) # 5844 <exit>

00000000000045d6 <sharedfd>:
{
    45d6:	7159                	addi	sp,sp,-112
    45d8:	f486                	sd	ra,104(sp)
    45da:	f0a2                	sd	s0,96(sp)
    45dc:	eca6                	sd	s1,88(sp)
    45de:	e8ca                	sd	s2,80(sp)
    45e0:	e4ce                	sd	s3,72(sp)
    45e2:	e0d2                	sd	s4,64(sp)
    45e4:	fc56                	sd	s5,56(sp)
    45e6:	f85a                	sd	s6,48(sp)
    45e8:	f45e                	sd	s7,40(sp)
    45ea:	1880                	addi	s0,sp,112
    45ec:	8a2a                	mv	s4,a0
  unlink("sharedfd");
    45ee:	00003517          	auipc	a0,0x3
    45f2:	37250513          	addi	a0,a0,882 # 7960 <malloc+0x1cea>
    45f6:	00001097          	auipc	ra,0x1
    45fa:	29e080e7          	jalr	670(ra) # 5894 <unlink>
  fd = open("sharedfd", O_CREATE|O_RDWR);
    45fe:	20200593          	li	a1,514
    4602:	00003517          	auipc	a0,0x3
    4606:	35e50513          	addi	a0,a0,862 # 7960 <malloc+0x1cea>
    460a:	00001097          	auipc	ra,0x1
    460e:	27a080e7          	jalr	634(ra) # 5884 <open>
  if(fd < 0){
    4612:	04054a63          	bltz	a0,4666 <sharedfd+0x90>
    4616:	892a                	mv	s2,a0
  pid = fork();
    4618:	00001097          	auipc	ra,0x1
    461c:	224080e7          	jalr	548(ra) # 583c <fork>
    4620:	89aa                	mv	s3,a0
  memset(buf, pid==0?'c':'p', sizeof(buf));
    4622:	06300593          	li	a1,99
    4626:	c119                	beqz	a0,462c <sharedfd+0x56>
    4628:	07000593          	li	a1,112
    462c:	4629                	li	a2,10
    462e:	fa040513          	addi	a0,s0,-96
    4632:	00001097          	auipc	ra,0x1
    4636:	018080e7          	jalr	24(ra) # 564a <memset>
    463a:	3e800493          	li	s1,1000
    if(write(fd, buf, sizeof(buf)) != sizeof(buf)){
    463e:	4629                	li	a2,10
    4640:	fa040593          	addi	a1,s0,-96
    4644:	854a                	mv	a0,s2
    4646:	00001097          	auipc	ra,0x1
    464a:	21e080e7          	jalr	542(ra) # 5864 <write>
    464e:	47a9                	li	a5,10
    4650:	02f51963          	bne	a0,a5,4682 <sharedfd+0xac>
  for(i = 0; i < N; i++){
    4654:	34fd                	addiw	s1,s1,-1
    4656:	f4e5                	bnez	s1,463e <sharedfd+0x68>
  if(pid == 0) {
    4658:	04099363          	bnez	s3,469e <sharedfd+0xc8>
    exit(0);
    465c:	4501                	li	a0,0
    465e:	00001097          	auipc	ra,0x1
    4662:	1e6080e7          	jalr	486(ra) # 5844 <exit>
    printf("%s: cannot open sharedfd for writing", s);
    4666:	85d2                	mv	a1,s4
    4668:	00003517          	auipc	a0,0x3
    466c:	30850513          	addi	a0,a0,776 # 7970 <malloc+0x1cfa>
    4670:	00001097          	auipc	ra,0x1
    4674:	54e080e7          	jalr	1358(ra) # 5bbe <printf>
    exit(1);
    4678:	4505                	li	a0,1
    467a:	00001097          	auipc	ra,0x1
    467e:	1ca080e7          	jalr	458(ra) # 5844 <exit>
      printf("%s: write sharedfd failed\n", s);
    4682:	85d2                	mv	a1,s4
    4684:	00003517          	auipc	a0,0x3
    4688:	31450513          	addi	a0,a0,788 # 7998 <malloc+0x1d22>
    468c:	00001097          	auipc	ra,0x1
    4690:	532080e7          	jalr	1330(ra) # 5bbe <printf>
      exit(1);
    4694:	4505                	li	a0,1
    4696:	00001097          	auipc	ra,0x1
    469a:	1ae080e7          	jalr	430(ra) # 5844 <exit>
    wait(&xstatus);
    469e:	f9c40513          	addi	a0,s0,-100
    46a2:	00001097          	auipc	ra,0x1
    46a6:	1aa080e7          	jalr	426(ra) # 584c <wait>
    if(xstatus != 0)
    46aa:	f9c42983          	lw	s3,-100(s0)
    46ae:	00098763          	beqz	s3,46bc <sharedfd+0xe6>
      exit(xstatus);
    46b2:	854e                	mv	a0,s3
    46b4:	00001097          	auipc	ra,0x1
    46b8:	190080e7          	jalr	400(ra) # 5844 <exit>
  close(fd);
    46bc:	854a                	mv	a0,s2
    46be:	00001097          	auipc	ra,0x1
    46c2:	1ae080e7          	jalr	430(ra) # 586c <close>
  fd = open("sharedfd", 0);
    46c6:	4581                	li	a1,0
    46c8:	00003517          	auipc	a0,0x3
    46cc:	29850513          	addi	a0,a0,664 # 7960 <malloc+0x1cea>
    46d0:	00001097          	auipc	ra,0x1
    46d4:	1b4080e7          	jalr	436(ra) # 5884 <open>
    46d8:	8baa                	mv	s7,a0
  nc = np = 0;
    46da:	8ace                	mv	s5,s3
  if(fd < 0){
    46dc:	02054563          	bltz	a0,4706 <sharedfd+0x130>
    46e0:	faa40913          	addi	s2,s0,-86
      if(buf[i] == 'c')
    46e4:	06300493          	li	s1,99
      if(buf[i] == 'p')
    46e8:	07000b13          	li	s6,112
  while((n = read(fd, buf, sizeof(buf))) > 0){
    46ec:	4629                	li	a2,10
    46ee:	fa040593          	addi	a1,s0,-96
    46f2:	855e                	mv	a0,s7
    46f4:	00001097          	auipc	ra,0x1
    46f8:	168080e7          	jalr	360(ra) # 585c <read>
    46fc:	02a05f63          	blez	a0,473a <sharedfd+0x164>
    4700:	fa040793          	addi	a5,s0,-96
    4704:	a01d                	j	472a <sharedfd+0x154>
    printf("%s: cannot open sharedfd for reading\n", s);
    4706:	85d2                	mv	a1,s4
    4708:	00003517          	auipc	a0,0x3
    470c:	2b050513          	addi	a0,a0,688 # 79b8 <malloc+0x1d42>
    4710:	00001097          	auipc	ra,0x1
    4714:	4ae080e7          	jalr	1198(ra) # 5bbe <printf>
    exit(1);
    4718:	4505                	li	a0,1
    471a:	00001097          	auipc	ra,0x1
    471e:	12a080e7          	jalr	298(ra) # 5844 <exit>
        nc++;
    4722:	2985                	addiw	s3,s3,1
    for(i = 0; i < sizeof(buf); i++){
    4724:	0785                	addi	a5,a5,1
    4726:	fd2783e3          	beq	a5,s2,46ec <sharedfd+0x116>
      if(buf[i] == 'c')
    472a:	0007c703          	lbu	a4,0(a5)
    472e:	fe970ae3          	beq	a4,s1,4722 <sharedfd+0x14c>
      if(buf[i] == 'p')
    4732:	ff6719e3          	bne	a4,s6,4724 <sharedfd+0x14e>
        np++;
    4736:	2a85                	addiw	s5,s5,1
    4738:	b7f5                	j	4724 <sharedfd+0x14e>
  close(fd);
    473a:	855e                	mv	a0,s7
    473c:	00001097          	auipc	ra,0x1
    4740:	130080e7          	jalr	304(ra) # 586c <close>
  unlink("sharedfd");
    4744:	00003517          	auipc	a0,0x3
    4748:	21c50513          	addi	a0,a0,540 # 7960 <malloc+0x1cea>
    474c:	00001097          	auipc	ra,0x1
    4750:	148080e7          	jalr	328(ra) # 5894 <unlink>
  if(nc == N*SZ && np == N*SZ){
    4754:	6789                	lui	a5,0x2
    4756:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0xae>
    475a:	00f99763          	bne	s3,a5,4768 <sharedfd+0x192>
    475e:	6789                	lui	a5,0x2
    4760:	71078793          	addi	a5,a5,1808 # 2710 <sbrkbasic+0xae>
    4764:	02fa8063          	beq	s5,a5,4784 <sharedfd+0x1ae>
    printf("%s: nc/np test fails\n", s);
    4768:	85d2                	mv	a1,s4
    476a:	00003517          	auipc	a0,0x3
    476e:	27650513          	addi	a0,a0,630 # 79e0 <malloc+0x1d6a>
    4772:	00001097          	auipc	ra,0x1
    4776:	44c080e7          	jalr	1100(ra) # 5bbe <printf>
    exit(1);
    477a:	4505                	li	a0,1
    477c:	00001097          	auipc	ra,0x1
    4780:	0c8080e7          	jalr	200(ra) # 5844 <exit>
    exit(0);
    4784:	4501                	li	a0,0
    4786:	00001097          	auipc	ra,0x1
    478a:	0be080e7          	jalr	190(ra) # 5844 <exit>

000000000000478e <fourfiles>:
{
    478e:	7171                	addi	sp,sp,-176
    4790:	f506                	sd	ra,168(sp)
    4792:	f122                	sd	s0,160(sp)
    4794:	ed26                	sd	s1,152(sp)
    4796:	e94a                	sd	s2,144(sp)
    4798:	e54e                	sd	s3,136(sp)
    479a:	e152                	sd	s4,128(sp)
    479c:	fcd6                	sd	s5,120(sp)
    479e:	f8da                	sd	s6,112(sp)
    47a0:	f4de                	sd	s7,104(sp)
    47a2:	f0e2                	sd	s8,96(sp)
    47a4:	ece6                	sd	s9,88(sp)
    47a6:	e8ea                	sd	s10,80(sp)
    47a8:	e4ee                	sd	s11,72(sp)
    47aa:	1900                	addi	s0,sp,176
    47ac:	f4a43c23          	sd	a0,-168(s0)
  char *names[] = { "f0", "f1", "f2", "f3" };
    47b0:	00003797          	auipc	a5,0x3
    47b4:	24878793          	addi	a5,a5,584 # 79f8 <malloc+0x1d82>
    47b8:	f6f43823          	sd	a5,-144(s0)
    47bc:	00003797          	auipc	a5,0x3
    47c0:	24478793          	addi	a5,a5,580 # 7a00 <malloc+0x1d8a>
    47c4:	f6f43c23          	sd	a5,-136(s0)
    47c8:	00003797          	auipc	a5,0x3
    47cc:	24078793          	addi	a5,a5,576 # 7a08 <malloc+0x1d92>
    47d0:	f8f43023          	sd	a5,-128(s0)
    47d4:	00003797          	auipc	a5,0x3
    47d8:	23c78793          	addi	a5,a5,572 # 7a10 <malloc+0x1d9a>
    47dc:	f8f43423          	sd	a5,-120(s0)
  for(pi = 0; pi < NCHILD; pi++){
    47e0:	f7040c13          	addi	s8,s0,-144
  char *names[] = { "f0", "f1", "f2", "f3" };
    47e4:	8962                	mv	s2,s8
  for(pi = 0; pi < NCHILD; pi++){
    47e6:	4481                	li	s1,0
    47e8:	4a11                	li	s4,4
    fname = names[pi];
    47ea:	00093983          	ld	s3,0(s2)
    unlink(fname);
    47ee:	854e                	mv	a0,s3
    47f0:	00001097          	auipc	ra,0x1
    47f4:	0a4080e7          	jalr	164(ra) # 5894 <unlink>
    pid = fork();
    47f8:	00001097          	auipc	ra,0x1
    47fc:	044080e7          	jalr	68(ra) # 583c <fork>
    if(pid < 0){
    4800:	04054463          	bltz	a0,4848 <fourfiles+0xba>
    if(pid == 0){
    4804:	c12d                	beqz	a0,4866 <fourfiles+0xd8>
  for(pi = 0; pi < NCHILD; pi++){
    4806:	2485                	addiw	s1,s1,1
    4808:	0921                	addi	s2,s2,8
    480a:	ff4490e3          	bne	s1,s4,47ea <fourfiles+0x5c>
    480e:	4491                	li	s1,4
    wait(&xstatus);
    4810:	f6c40513          	addi	a0,s0,-148
    4814:	00001097          	auipc	ra,0x1
    4818:	038080e7          	jalr	56(ra) # 584c <wait>
    if(xstatus != 0)
    481c:	f6c42b03          	lw	s6,-148(s0)
    4820:	0c0b1e63          	bnez	s6,48fc <fourfiles+0x16e>
  for(pi = 0; pi < NCHILD; pi++){
    4824:	34fd                	addiw	s1,s1,-1
    4826:	f4ed                	bnez	s1,4810 <fourfiles+0x82>
    4828:	03000b93          	li	s7,48
    while((n = read(fd, buf, sizeof(buf))) > 0){
    482c:	00007a17          	auipc	s4,0x7
    4830:	5aca0a13          	addi	s4,s4,1452 # bdd8 <buf>
    4834:	00007a97          	auipc	s5,0x7
    4838:	5a5a8a93          	addi	s5,s5,1445 # bdd9 <buf+0x1>
    if(total != N*SZ){
    483c:	6d85                	lui	s11,0x1
    483e:	770d8d93          	addi	s11,s11,1904 # 1770 <pipe1+0x32>
  for(i = 0; i < NCHILD; i++){
    4842:	03400d13          	li	s10,52
    4846:	aa1d                	j	497c <fourfiles+0x1ee>
      printf("fork failed\n", s);
    4848:	f5843583          	ld	a1,-168(s0)
    484c:	00002517          	auipc	a0,0x2
    4850:	1c450513          	addi	a0,a0,452 # 6a10 <malloc+0xd9a>
    4854:	00001097          	auipc	ra,0x1
    4858:	36a080e7          	jalr	874(ra) # 5bbe <printf>
      exit(1);
    485c:	4505                	li	a0,1
    485e:	00001097          	auipc	ra,0x1
    4862:	fe6080e7          	jalr	-26(ra) # 5844 <exit>
      fd = open(fname, O_CREATE | O_RDWR);
    4866:	20200593          	li	a1,514
    486a:	854e                	mv	a0,s3
    486c:	00001097          	auipc	ra,0x1
    4870:	018080e7          	jalr	24(ra) # 5884 <open>
    4874:	892a                	mv	s2,a0
      if(fd < 0){
    4876:	04054763          	bltz	a0,48c4 <fourfiles+0x136>
      memset(buf, '0'+pi, SZ);
    487a:	1f400613          	li	a2,500
    487e:	0304859b          	addiw	a1,s1,48
    4882:	00007517          	auipc	a0,0x7
    4886:	55650513          	addi	a0,a0,1366 # bdd8 <buf>
    488a:	00001097          	auipc	ra,0x1
    488e:	dc0080e7          	jalr	-576(ra) # 564a <memset>
    4892:	44b1                	li	s1,12
        if((n = write(fd, buf, SZ)) != SZ){
    4894:	00007997          	auipc	s3,0x7
    4898:	54498993          	addi	s3,s3,1348 # bdd8 <buf>
    489c:	1f400613          	li	a2,500
    48a0:	85ce                	mv	a1,s3
    48a2:	854a                	mv	a0,s2
    48a4:	00001097          	auipc	ra,0x1
    48a8:	fc0080e7          	jalr	-64(ra) # 5864 <write>
    48ac:	85aa                	mv	a1,a0
    48ae:	1f400793          	li	a5,500
    48b2:	02f51863          	bne	a0,a5,48e2 <fourfiles+0x154>
      for(i = 0; i < N; i++){
    48b6:	34fd                	addiw	s1,s1,-1
    48b8:	f0f5                	bnez	s1,489c <fourfiles+0x10e>
      exit(0);
    48ba:	4501                	li	a0,0
    48bc:	00001097          	auipc	ra,0x1
    48c0:	f88080e7          	jalr	-120(ra) # 5844 <exit>
        printf("create failed\n", s);
    48c4:	f5843583          	ld	a1,-168(s0)
    48c8:	00003517          	auipc	a0,0x3
    48cc:	15050513          	addi	a0,a0,336 # 7a18 <malloc+0x1da2>
    48d0:	00001097          	auipc	ra,0x1
    48d4:	2ee080e7          	jalr	750(ra) # 5bbe <printf>
        exit(1);
    48d8:	4505                	li	a0,1
    48da:	00001097          	auipc	ra,0x1
    48de:	f6a080e7          	jalr	-150(ra) # 5844 <exit>
          printf("write failed %d\n", n);
    48e2:	00003517          	auipc	a0,0x3
    48e6:	14650513          	addi	a0,a0,326 # 7a28 <malloc+0x1db2>
    48ea:	00001097          	auipc	ra,0x1
    48ee:	2d4080e7          	jalr	724(ra) # 5bbe <printf>
          exit(1);
    48f2:	4505                	li	a0,1
    48f4:	00001097          	auipc	ra,0x1
    48f8:	f50080e7          	jalr	-176(ra) # 5844 <exit>
      exit(xstatus);
    48fc:	855a                	mv	a0,s6
    48fe:	00001097          	auipc	ra,0x1
    4902:	f46080e7          	jalr	-186(ra) # 5844 <exit>
          printf("wrong char\n", s);
    4906:	f5843583          	ld	a1,-168(s0)
    490a:	00003517          	auipc	a0,0x3
    490e:	13650513          	addi	a0,a0,310 # 7a40 <malloc+0x1dca>
    4912:	00001097          	auipc	ra,0x1
    4916:	2ac080e7          	jalr	684(ra) # 5bbe <printf>
          exit(1);
    491a:	4505                	li	a0,1
    491c:	00001097          	auipc	ra,0x1
    4920:	f28080e7          	jalr	-216(ra) # 5844 <exit>
      total += n;
    4924:	00a9093b          	addw	s2,s2,a0
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4928:	660d                	lui	a2,0x3
    492a:	85d2                	mv	a1,s4
    492c:	854e                	mv	a0,s3
    492e:	00001097          	auipc	ra,0x1
    4932:	f2e080e7          	jalr	-210(ra) # 585c <read>
    4936:	02a05363          	blez	a0,495c <fourfiles+0x1ce>
    493a:	00007797          	auipc	a5,0x7
    493e:	49e78793          	addi	a5,a5,1182 # bdd8 <buf>
    4942:	fff5069b          	addiw	a3,a0,-1
    4946:	1682                	slli	a3,a3,0x20
    4948:	9281                	srli	a3,a3,0x20
    494a:	96d6                	add	a3,a3,s5
        if(buf[j] != '0'+i){
    494c:	0007c703          	lbu	a4,0(a5)
    4950:	fa971be3          	bne	a4,s1,4906 <fourfiles+0x178>
      for(j = 0; j < n; j++){
    4954:	0785                	addi	a5,a5,1
    4956:	fed79be3          	bne	a5,a3,494c <fourfiles+0x1be>
    495a:	b7e9                	j	4924 <fourfiles+0x196>
    close(fd);
    495c:	854e                	mv	a0,s3
    495e:	00001097          	auipc	ra,0x1
    4962:	f0e080e7          	jalr	-242(ra) # 586c <close>
    if(total != N*SZ){
    4966:	03b91863          	bne	s2,s11,4996 <fourfiles+0x208>
    unlink(fname);
    496a:	8566                	mv	a0,s9
    496c:	00001097          	auipc	ra,0x1
    4970:	f28080e7          	jalr	-216(ra) # 5894 <unlink>
  for(i = 0; i < NCHILD; i++){
    4974:	0c21                	addi	s8,s8,8
    4976:	2b85                	addiw	s7,s7,1
    4978:	03ab8d63          	beq	s7,s10,49b2 <fourfiles+0x224>
    fname = names[i];
    497c:	000c3c83          	ld	s9,0(s8)
    fd = open(fname, 0);
    4980:	4581                	li	a1,0
    4982:	8566                	mv	a0,s9
    4984:	00001097          	auipc	ra,0x1
    4988:	f00080e7          	jalr	-256(ra) # 5884 <open>
    498c:	89aa                	mv	s3,a0
    total = 0;
    498e:	895a                	mv	s2,s6
        if(buf[j] != '0'+i){
    4990:	000b849b          	sext.w	s1,s7
    while((n = read(fd, buf, sizeof(buf))) > 0){
    4994:	bf51                	j	4928 <fourfiles+0x19a>
      printf("wrong length %d\n", total);
    4996:	85ca                	mv	a1,s2
    4998:	00003517          	auipc	a0,0x3
    499c:	0b850513          	addi	a0,a0,184 # 7a50 <malloc+0x1dda>
    49a0:	00001097          	auipc	ra,0x1
    49a4:	21e080e7          	jalr	542(ra) # 5bbe <printf>
      exit(1);
    49a8:	4505                	li	a0,1
    49aa:	00001097          	auipc	ra,0x1
    49ae:	e9a080e7          	jalr	-358(ra) # 5844 <exit>
}
    49b2:	70aa                	ld	ra,168(sp)
    49b4:	740a                	ld	s0,160(sp)
    49b6:	64ea                	ld	s1,152(sp)
    49b8:	694a                	ld	s2,144(sp)
    49ba:	69aa                	ld	s3,136(sp)
    49bc:	6a0a                	ld	s4,128(sp)
    49be:	7ae6                	ld	s5,120(sp)
    49c0:	7b46                	ld	s6,112(sp)
    49c2:	7ba6                	ld	s7,104(sp)
    49c4:	7c06                	ld	s8,96(sp)
    49c6:	6ce6                	ld	s9,88(sp)
    49c8:	6d46                	ld	s10,80(sp)
    49ca:	6da6                	ld	s11,72(sp)
    49cc:	614d                	addi	sp,sp,176
    49ce:	8082                	ret

00000000000049d0 <concreate>:
{
    49d0:	7135                	addi	sp,sp,-160
    49d2:	ed06                	sd	ra,152(sp)
    49d4:	e922                	sd	s0,144(sp)
    49d6:	e526                	sd	s1,136(sp)
    49d8:	e14a                	sd	s2,128(sp)
    49da:	fcce                	sd	s3,120(sp)
    49dc:	f8d2                	sd	s4,112(sp)
    49de:	f4d6                	sd	s5,104(sp)
    49e0:	f0da                	sd	s6,96(sp)
    49e2:	ecde                	sd	s7,88(sp)
    49e4:	1100                	addi	s0,sp,160
    49e6:	89aa                	mv	s3,a0
  file[0] = 'C';
    49e8:	04300793          	li	a5,67
    49ec:	faf40423          	sb	a5,-88(s0)
  file[2] = '\0';
    49f0:	fa040523          	sb	zero,-86(s0)
  for(i = 0; i < N; i++){
    49f4:	4901                	li	s2,0
    if(pid && (i % 3) == 1){
    49f6:	4b0d                	li	s6,3
    49f8:	4a85                	li	s5,1
      link("C0", file);
    49fa:	00003b97          	auipc	s7,0x3
    49fe:	06eb8b93          	addi	s7,s7,110 # 7a68 <malloc+0x1df2>
  for(i = 0; i < N; i++){
    4a02:	02800a13          	li	s4,40
    4a06:	acc9                	j	4cd8 <concreate+0x308>
      link("C0", file);
    4a08:	fa840593          	addi	a1,s0,-88
    4a0c:	855e                	mv	a0,s7
    4a0e:	00001097          	auipc	ra,0x1
    4a12:	e96080e7          	jalr	-362(ra) # 58a4 <link>
    if(pid == 0) {
    4a16:	a465                	j	4cbe <concreate+0x2ee>
    } else if(pid == 0 && (i % 5) == 1){
    4a18:	4795                	li	a5,5
    4a1a:	02f9693b          	remw	s2,s2,a5
    4a1e:	4785                	li	a5,1
    4a20:	02f90b63          	beq	s2,a5,4a56 <concreate+0x86>
      fd = open(file, O_CREATE | O_RDWR);
    4a24:	20200593          	li	a1,514
    4a28:	fa840513          	addi	a0,s0,-88
    4a2c:	00001097          	auipc	ra,0x1
    4a30:	e58080e7          	jalr	-424(ra) # 5884 <open>
      if(fd < 0){
    4a34:	26055c63          	bgez	a0,4cac <concreate+0x2dc>
        printf("concreate create %s failed\n", file);
    4a38:	fa840593          	addi	a1,s0,-88
    4a3c:	00003517          	auipc	a0,0x3
    4a40:	03450513          	addi	a0,a0,52 # 7a70 <malloc+0x1dfa>
    4a44:	00001097          	auipc	ra,0x1
    4a48:	17a080e7          	jalr	378(ra) # 5bbe <printf>
        exit(1);
    4a4c:	4505                	li	a0,1
    4a4e:	00001097          	auipc	ra,0x1
    4a52:	df6080e7          	jalr	-522(ra) # 5844 <exit>
      link("C0", file);
    4a56:	fa840593          	addi	a1,s0,-88
    4a5a:	00003517          	auipc	a0,0x3
    4a5e:	00e50513          	addi	a0,a0,14 # 7a68 <malloc+0x1df2>
    4a62:	00001097          	auipc	ra,0x1
    4a66:	e42080e7          	jalr	-446(ra) # 58a4 <link>
      exit(0);
    4a6a:	4501                	li	a0,0
    4a6c:	00001097          	auipc	ra,0x1
    4a70:	dd8080e7          	jalr	-552(ra) # 5844 <exit>
        exit(1);
    4a74:	4505                	li	a0,1
    4a76:	00001097          	auipc	ra,0x1
    4a7a:	dce080e7          	jalr	-562(ra) # 5844 <exit>
  memset(fa, 0, sizeof(fa));
    4a7e:	02800613          	li	a2,40
    4a82:	4581                	li	a1,0
    4a84:	f8040513          	addi	a0,s0,-128
    4a88:	00001097          	auipc	ra,0x1
    4a8c:	bc2080e7          	jalr	-1086(ra) # 564a <memset>
  fd = open(".", 0);
    4a90:	4581                	li	a1,0
    4a92:	00002517          	auipc	a0,0x2
    4a96:	9be50513          	addi	a0,a0,-1602 # 6450 <malloc+0x7da>
    4a9a:	00001097          	auipc	ra,0x1
    4a9e:	dea080e7          	jalr	-534(ra) # 5884 <open>
    4aa2:	892a                	mv	s2,a0
  n = 0;
    4aa4:	8aa6                	mv	s5,s1
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4aa6:	04300a13          	li	s4,67
      if(i < 0 || i >= sizeof(fa)){
    4aaa:	02700b13          	li	s6,39
      fa[i] = 1;
    4aae:	4b85                	li	s7,1
  while(read(fd, &de, sizeof(de)) > 0){
    4ab0:	4641                	li	a2,16
    4ab2:	f7040593          	addi	a1,s0,-144
    4ab6:	854a                	mv	a0,s2
    4ab8:	00001097          	auipc	ra,0x1
    4abc:	da4080e7          	jalr	-604(ra) # 585c <read>
    4ac0:	08a05263          	blez	a0,4b44 <concreate+0x174>
    if(de.inum == 0)
    4ac4:	f7045783          	lhu	a5,-144(s0)
    4ac8:	d7e5                	beqz	a5,4ab0 <concreate+0xe0>
    if(de.name[0] == 'C' && de.name[2] == '\0'){
    4aca:	f7244783          	lbu	a5,-142(s0)
    4ace:	ff4791e3          	bne	a5,s4,4ab0 <concreate+0xe0>
    4ad2:	f7444783          	lbu	a5,-140(s0)
    4ad6:	ffe9                	bnez	a5,4ab0 <concreate+0xe0>
      i = de.name[1] - '0';
    4ad8:	f7344783          	lbu	a5,-141(s0)
    4adc:	fd07879b          	addiw	a5,a5,-48
    4ae0:	0007871b          	sext.w	a4,a5
      if(i < 0 || i >= sizeof(fa)){
    4ae4:	02eb6063          	bltu	s6,a4,4b04 <concreate+0x134>
      if(fa[i]){
    4ae8:	fb070793          	addi	a5,a4,-80 # fb0 <bigdir+0x4e>
    4aec:	97a2                	add	a5,a5,s0
    4aee:	fd07c783          	lbu	a5,-48(a5)
    4af2:	eb8d                	bnez	a5,4b24 <concreate+0x154>
      fa[i] = 1;
    4af4:	fb070793          	addi	a5,a4,-80
    4af8:	00878733          	add	a4,a5,s0
    4afc:	fd770823          	sb	s7,-48(a4)
      n++;
    4b00:	2a85                	addiw	s5,s5,1
    4b02:	b77d                	j	4ab0 <concreate+0xe0>
        printf("%s: concreate weird file %s\n", s, de.name);
    4b04:	f7240613          	addi	a2,s0,-142
    4b08:	85ce                	mv	a1,s3
    4b0a:	00003517          	auipc	a0,0x3
    4b0e:	f8650513          	addi	a0,a0,-122 # 7a90 <malloc+0x1e1a>
    4b12:	00001097          	auipc	ra,0x1
    4b16:	0ac080e7          	jalr	172(ra) # 5bbe <printf>
        exit(1);
    4b1a:	4505                	li	a0,1
    4b1c:	00001097          	auipc	ra,0x1
    4b20:	d28080e7          	jalr	-728(ra) # 5844 <exit>
        printf("%s: concreate duplicate file %s\n", s, de.name);
    4b24:	f7240613          	addi	a2,s0,-142
    4b28:	85ce                	mv	a1,s3
    4b2a:	00003517          	auipc	a0,0x3
    4b2e:	f8650513          	addi	a0,a0,-122 # 7ab0 <malloc+0x1e3a>
    4b32:	00001097          	auipc	ra,0x1
    4b36:	08c080e7          	jalr	140(ra) # 5bbe <printf>
        exit(1);
    4b3a:	4505                	li	a0,1
    4b3c:	00001097          	auipc	ra,0x1
    4b40:	d08080e7          	jalr	-760(ra) # 5844 <exit>
  close(fd);
    4b44:	854a                	mv	a0,s2
    4b46:	00001097          	auipc	ra,0x1
    4b4a:	d26080e7          	jalr	-730(ra) # 586c <close>
  if(n != N){
    4b4e:	02800793          	li	a5,40
    4b52:	00fa9763          	bne	s5,a5,4b60 <concreate+0x190>
    if(((i % 3) == 0 && pid == 0) ||
    4b56:	4a8d                	li	s5,3
    4b58:	4b05                	li	s6,1
  for(i = 0; i < N; i++){
    4b5a:	02800a13          	li	s4,40
    4b5e:	a8c9                	j	4c30 <concreate+0x260>
    printf("%s: concreate not enough files in directory listing\n", s);
    4b60:	85ce                	mv	a1,s3
    4b62:	00003517          	auipc	a0,0x3
    4b66:	f7650513          	addi	a0,a0,-138 # 7ad8 <malloc+0x1e62>
    4b6a:	00001097          	auipc	ra,0x1
    4b6e:	054080e7          	jalr	84(ra) # 5bbe <printf>
    exit(1);
    4b72:	4505                	li	a0,1
    4b74:	00001097          	auipc	ra,0x1
    4b78:	cd0080e7          	jalr	-816(ra) # 5844 <exit>
      printf("%s: fork failed\n", s);
    4b7c:	85ce                	mv	a1,s3
    4b7e:	00002517          	auipc	a0,0x2
    4b82:	a7250513          	addi	a0,a0,-1422 # 65f0 <malloc+0x97a>
    4b86:	00001097          	auipc	ra,0x1
    4b8a:	038080e7          	jalr	56(ra) # 5bbe <printf>
      exit(1);
    4b8e:	4505                	li	a0,1
    4b90:	00001097          	auipc	ra,0x1
    4b94:	cb4080e7          	jalr	-844(ra) # 5844 <exit>
      close(open(file, 0));
    4b98:	4581                	li	a1,0
    4b9a:	fa840513          	addi	a0,s0,-88
    4b9e:	00001097          	auipc	ra,0x1
    4ba2:	ce6080e7          	jalr	-794(ra) # 5884 <open>
    4ba6:	00001097          	auipc	ra,0x1
    4baa:	cc6080e7          	jalr	-826(ra) # 586c <close>
      close(open(file, 0));
    4bae:	4581                	li	a1,0
    4bb0:	fa840513          	addi	a0,s0,-88
    4bb4:	00001097          	auipc	ra,0x1
    4bb8:	cd0080e7          	jalr	-816(ra) # 5884 <open>
    4bbc:	00001097          	auipc	ra,0x1
    4bc0:	cb0080e7          	jalr	-848(ra) # 586c <close>
      close(open(file, 0));
    4bc4:	4581                	li	a1,0
    4bc6:	fa840513          	addi	a0,s0,-88
    4bca:	00001097          	auipc	ra,0x1
    4bce:	cba080e7          	jalr	-838(ra) # 5884 <open>
    4bd2:	00001097          	auipc	ra,0x1
    4bd6:	c9a080e7          	jalr	-870(ra) # 586c <close>
      close(open(file, 0));
    4bda:	4581                	li	a1,0
    4bdc:	fa840513          	addi	a0,s0,-88
    4be0:	00001097          	auipc	ra,0x1
    4be4:	ca4080e7          	jalr	-860(ra) # 5884 <open>
    4be8:	00001097          	auipc	ra,0x1
    4bec:	c84080e7          	jalr	-892(ra) # 586c <close>
      close(open(file, 0));
    4bf0:	4581                	li	a1,0
    4bf2:	fa840513          	addi	a0,s0,-88
    4bf6:	00001097          	auipc	ra,0x1
    4bfa:	c8e080e7          	jalr	-882(ra) # 5884 <open>
    4bfe:	00001097          	auipc	ra,0x1
    4c02:	c6e080e7          	jalr	-914(ra) # 586c <close>
      close(open(file, 0));
    4c06:	4581                	li	a1,0
    4c08:	fa840513          	addi	a0,s0,-88
    4c0c:	00001097          	auipc	ra,0x1
    4c10:	c78080e7          	jalr	-904(ra) # 5884 <open>
    4c14:	00001097          	auipc	ra,0x1
    4c18:	c58080e7          	jalr	-936(ra) # 586c <close>
    if(pid == 0)
    4c1c:	08090363          	beqz	s2,4ca2 <concreate+0x2d2>
      wait(0);
    4c20:	4501                	li	a0,0
    4c22:	00001097          	auipc	ra,0x1
    4c26:	c2a080e7          	jalr	-982(ra) # 584c <wait>
  for(i = 0; i < N; i++){
    4c2a:	2485                	addiw	s1,s1,1
    4c2c:	0f448563          	beq	s1,s4,4d16 <concreate+0x346>
    file[1] = '0' + i;
    4c30:	0304879b          	addiw	a5,s1,48
    4c34:	faf404a3          	sb	a5,-87(s0)
    pid = fork();
    4c38:	00001097          	auipc	ra,0x1
    4c3c:	c04080e7          	jalr	-1020(ra) # 583c <fork>
    4c40:	892a                	mv	s2,a0
    if(pid < 0){
    4c42:	f2054de3          	bltz	a0,4b7c <concreate+0x1ac>
    if(((i % 3) == 0 && pid == 0) ||
    4c46:	0354e73b          	remw	a4,s1,s5
    4c4a:	00a767b3          	or	a5,a4,a0
    4c4e:	2781                	sext.w	a5,a5
    4c50:	d7a1                	beqz	a5,4b98 <concreate+0x1c8>
    4c52:	01671363          	bne	a4,s6,4c58 <concreate+0x288>
       ((i % 3) == 1 && pid != 0)){
    4c56:	f129                	bnez	a0,4b98 <concreate+0x1c8>
      unlink(file);
    4c58:	fa840513          	addi	a0,s0,-88
    4c5c:	00001097          	auipc	ra,0x1
    4c60:	c38080e7          	jalr	-968(ra) # 5894 <unlink>
      unlink(file);
    4c64:	fa840513          	addi	a0,s0,-88
    4c68:	00001097          	auipc	ra,0x1
    4c6c:	c2c080e7          	jalr	-980(ra) # 5894 <unlink>
      unlink(file);
    4c70:	fa840513          	addi	a0,s0,-88
    4c74:	00001097          	auipc	ra,0x1
    4c78:	c20080e7          	jalr	-992(ra) # 5894 <unlink>
      unlink(file);
    4c7c:	fa840513          	addi	a0,s0,-88
    4c80:	00001097          	auipc	ra,0x1
    4c84:	c14080e7          	jalr	-1004(ra) # 5894 <unlink>
      unlink(file);
    4c88:	fa840513          	addi	a0,s0,-88
    4c8c:	00001097          	auipc	ra,0x1
    4c90:	c08080e7          	jalr	-1016(ra) # 5894 <unlink>
      unlink(file);
    4c94:	fa840513          	addi	a0,s0,-88
    4c98:	00001097          	auipc	ra,0x1
    4c9c:	bfc080e7          	jalr	-1028(ra) # 5894 <unlink>
    4ca0:	bfb5                	j	4c1c <concreate+0x24c>
      exit(0);
    4ca2:	4501                	li	a0,0
    4ca4:	00001097          	auipc	ra,0x1
    4ca8:	ba0080e7          	jalr	-1120(ra) # 5844 <exit>
      close(fd);
    4cac:	00001097          	auipc	ra,0x1
    4cb0:	bc0080e7          	jalr	-1088(ra) # 586c <close>
    if(pid == 0) {
    4cb4:	bb5d                	j	4a6a <concreate+0x9a>
      close(fd);
    4cb6:	00001097          	auipc	ra,0x1
    4cba:	bb6080e7          	jalr	-1098(ra) # 586c <close>
      wait(&xstatus);
    4cbe:	f6c40513          	addi	a0,s0,-148
    4cc2:	00001097          	auipc	ra,0x1
    4cc6:	b8a080e7          	jalr	-1142(ra) # 584c <wait>
      if(xstatus != 0)
    4cca:	f6c42483          	lw	s1,-148(s0)
    4cce:	da0493e3          	bnez	s1,4a74 <concreate+0xa4>
  for(i = 0; i < N; i++){
    4cd2:	2905                	addiw	s2,s2,1
    4cd4:	db4905e3          	beq	s2,s4,4a7e <concreate+0xae>
    file[1] = '0' + i;
    4cd8:	0309079b          	addiw	a5,s2,48
    4cdc:	faf404a3          	sb	a5,-87(s0)
    unlink(file);
    4ce0:	fa840513          	addi	a0,s0,-88
    4ce4:	00001097          	auipc	ra,0x1
    4ce8:	bb0080e7          	jalr	-1104(ra) # 5894 <unlink>
    pid = fork();
    4cec:	00001097          	auipc	ra,0x1
    4cf0:	b50080e7          	jalr	-1200(ra) # 583c <fork>
    if(pid && (i % 3) == 1){
    4cf4:	d20502e3          	beqz	a0,4a18 <concreate+0x48>
    4cf8:	036967bb          	remw	a5,s2,s6
    4cfc:	d15786e3          	beq	a5,s5,4a08 <concreate+0x38>
      fd = open(file, O_CREATE | O_RDWR);
    4d00:	20200593          	li	a1,514
    4d04:	fa840513          	addi	a0,s0,-88
    4d08:	00001097          	auipc	ra,0x1
    4d0c:	b7c080e7          	jalr	-1156(ra) # 5884 <open>
      if(fd < 0){
    4d10:	fa0553e3          	bgez	a0,4cb6 <concreate+0x2e6>
    4d14:	b315                	j	4a38 <concreate+0x68>
}
    4d16:	60ea                	ld	ra,152(sp)
    4d18:	644a                	ld	s0,144(sp)
    4d1a:	64aa                	ld	s1,136(sp)
    4d1c:	690a                	ld	s2,128(sp)
    4d1e:	79e6                	ld	s3,120(sp)
    4d20:	7a46                	ld	s4,112(sp)
    4d22:	7aa6                	ld	s5,104(sp)
    4d24:	7b06                	ld	s6,96(sp)
    4d26:	6be6                	ld	s7,88(sp)
    4d28:	610d                	addi	sp,sp,160
    4d2a:	8082                	ret

0000000000004d2c <bigfile>:
{
    4d2c:	7139                	addi	sp,sp,-64
    4d2e:	fc06                	sd	ra,56(sp)
    4d30:	f822                	sd	s0,48(sp)
    4d32:	f426                	sd	s1,40(sp)
    4d34:	f04a                	sd	s2,32(sp)
    4d36:	ec4e                	sd	s3,24(sp)
    4d38:	e852                	sd	s4,16(sp)
    4d3a:	e456                	sd	s5,8(sp)
    4d3c:	0080                	addi	s0,sp,64
    4d3e:	8aaa                	mv	s5,a0
  unlink("bigfile.dat");
    4d40:	00003517          	auipc	a0,0x3
    4d44:	dd050513          	addi	a0,a0,-560 # 7b10 <malloc+0x1e9a>
    4d48:	00001097          	auipc	ra,0x1
    4d4c:	b4c080e7          	jalr	-1204(ra) # 5894 <unlink>
  fd = open("bigfile.dat", O_CREATE | O_RDWR);
    4d50:	20200593          	li	a1,514
    4d54:	00003517          	auipc	a0,0x3
    4d58:	dbc50513          	addi	a0,a0,-580 # 7b10 <malloc+0x1e9a>
    4d5c:	00001097          	auipc	ra,0x1
    4d60:	b28080e7          	jalr	-1240(ra) # 5884 <open>
    4d64:	89aa                	mv	s3,a0
  for(i = 0; i < N; i++){
    4d66:	4481                	li	s1,0
    memset(buf, i, SZ);
    4d68:	00007917          	auipc	s2,0x7
    4d6c:	07090913          	addi	s2,s2,112 # bdd8 <buf>
  for(i = 0; i < N; i++){
    4d70:	4a51                	li	s4,20
  if(fd < 0){
    4d72:	0a054063          	bltz	a0,4e12 <bigfile+0xe6>
    memset(buf, i, SZ);
    4d76:	25800613          	li	a2,600
    4d7a:	85a6                	mv	a1,s1
    4d7c:	854a                	mv	a0,s2
    4d7e:	00001097          	auipc	ra,0x1
    4d82:	8cc080e7          	jalr	-1844(ra) # 564a <memset>
    if(write(fd, buf, SZ) != SZ){
    4d86:	25800613          	li	a2,600
    4d8a:	85ca                	mv	a1,s2
    4d8c:	854e                	mv	a0,s3
    4d8e:	00001097          	auipc	ra,0x1
    4d92:	ad6080e7          	jalr	-1322(ra) # 5864 <write>
    4d96:	25800793          	li	a5,600
    4d9a:	08f51a63          	bne	a0,a5,4e2e <bigfile+0x102>
  for(i = 0; i < N; i++){
    4d9e:	2485                	addiw	s1,s1,1
    4da0:	fd449be3          	bne	s1,s4,4d76 <bigfile+0x4a>
  close(fd);
    4da4:	854e                	mv	a0,s3
    4da6:	00001097          	auipc	ra,0x1
    4daa:	ac6080e7          	jalr	-1338(ra) # 586c <close>
  fd = open("bigfile.dat", 0);
    4dae:	4581                	li	a1,0
    4db0:	00003517          	auipc	a0,0x3
    4db4:	d6050513          	addi	a0,a0,-672 # 7b10 <malloc+0x1e9a>
    4db8:	00001097          	auipc	ra,0x1
    4dbc:	acc080e7          	jalr	-1332(ra) # 5884 <open>
    4dc0:	8a2a                	mv	s4,a0
  total = 0;
    4dc2:	4981                	li	s3,0
  for(i = 0; ; i++){
    4dc4:	4481                	li	s1,0
    cc = read(fd, buf, SZ/2);
    4dc6:	00007917          	auipc	s2,0x7
    4dca:	01290913          	addi	s2,s2,18 # bdd8 <buf>
  if(fd < 0){
    4dce:	06054e63          	bltz	a0,4e4a <bigfile+0x11e>
    cc = read(fd, buf, SZ/2);
    4dd2:	12c00613          	li	a2,300
    4dd6:	85ca                	mv	a1,s2
    4dd8:	8552                	mv	a0,s4
    4dda:	00001097          	auipc	ra,0x1
    4dde:	a82080e7          	jalr	-1406(ra) # 585c <read>
    if(cc < 0){
    4de2:	08054263          	bltz	a0,4e66 <bigfile+0x13a>
    if(cc == 0)
    4de6:	c971                	beqz	a0,4eba <bigfile+0x18e>
    if(cc != SZ/2){
    4de8:	12c00793          	li	a5,300
    4dec:	08f51b63          	bne	a0,a5,4e82 <bigfile+0x156>
    if(buf[0] != i/2 || buf[SZ/2-1] != i/2){
    4df0:	01f4d79b          	srliw	a5,s1,0x1f
    4df4:	9fa5                	addw	a5,a5,s1
    4df6:	4017d79b          	sraiw	a5,a5,0x1
    4dfa:	00094703          	lbu	a4,0(s2)
    4dfe:	0af71063          	bne	a4,a5,4e9e <bigfile+0x172>
    4e02:	12b94703          	lbu	a4,299(s2)
    4e06:	08f71c63          	bne	a4,a5,4e9e <bigfile+0x172>
    total += cc;
    4e0a:	12c9899b          	addiw	s3,s3,300
  for(i = 0; ; i++){
    4e0e:	2485                	addiw	s1,s1,1
    cc = read(fd, buf, SZ/2);
    4e10:	b7c9                	j	4dd2 <bigfile+0xa6>
    printf("%s: cannot create bigfile", s);
    4e12:	85d6                	mv	a1,s5
    4e14:	00003517          	auipc	a0,0x3
    4e18:	d0c50513          	addi	a0,a0,-756 # 7b20 <malloc+0x1eaa>
    4e1c:	00001097          	auipc	ra,0x1
    4e20:	da2080e7          	jalr	-606(ra) # 5bbe <printf>
    exit(1);
    4e24:	4505                	li	a0,1
    4e26:	00001097          	auipc	ra,0x1
    4e2a:	a1e080e7          	jalr	-1506(ra) # 5844 <exit>
      printf("%s: write bigfile failed\n", s);
    4e2e:	85d6                	mv	a1,s5
    4e30:	00003517          	auipc	a0,0x3
    4e34:	d1050513          	addi	a0,a0,-752 # 7b40 <malloc+0x1eca>
    4e38:	00001097          	auipc	ra,0x1
    4e3c:	d86080e7          	jalr	-634(ra) # 5bbe <printf>
      exit(1);
    4e40:	4505                	li	a0,1
    4e42:	00001097          	auipc	ra,0x1
    4e46:	a02080e7          	jalr	-1534(ra) # 5844 <exit>
    printf("%s: cannot open bigfile\n", s);
    4e4a:	85d6                	mv	a1,s5
    4e4c:	00003517          	auipc	a0,0x3
    4e50:	d1450513          	addi	a0,a0,-748 # 7b60 <malloc+0x1eea>
    4e54:	00001097          	auipc	ra,0x1
    4e58:	d6a080e7          	jalr	-662(ra) # 5bbe <printf>
    exit(1);
    4e5c:	4505                	li	a0,1
    4e5e:	00001097          	auipc	ra,0x1
    4e62:	9e6080e7          	jalr	-1562(ra) # 5844 <exit>
      printf("%s: read bigfile failed\n", s);
    4e66:	85d6                	mv	a1,s5
    4e68:	00003517          	auipc	a0,0x3
    4e6c:	d1850513          	addi	a0,a0,-744 # 7b80 <malloc+0x1f0a>
    4e70:	00001097          	auipc	ra,0x1
    4e74:	d4e080e7          	jalr	-690(ra) # 5bbe <printf>
      exit(1);
    4e78:	4505                	li	a0,1
    4e7a:	00001097          	auipc	ra,0x1
    4e7e:	9ca080e7          	jalr	-1590(ra) # 5844 <exit>
      printf("%s: short read bigfile\n", s);
    4e82:	85d6                	mv	a1,s5
    4e84:	00003517          	auipc	a0,0x3
    4e88:	d1c50513          	addi	a0,a0,-740 # 7ba0 <malloc+0x1f2a>
    4e8c:	00001097          	auipc	ra,0x1
    4e90:	d32080e7          	jalr	-718(ra) # 5bbe <printf>
      exit(1);
    4e94:	4505                	li	a0,1
    4e96:	00001097          	auipc	ra,0x1
    4e9a:	9ae080e7          	jalr	-1618(ra) # 5844 <exit>
      printf("%s: read bigfile wrong data\n", s);
    4e9e:	85d6                	mv	a1,s5
    4ea0:	00003517          	auipc	a0,0x3
    4ea4:	d1850513          	addi	a0,a0,-744 # 7bb8 <malloc+0x1f42>
    4ea8:	00001097          	auipc	ra,0x1
    4eac:	d16080e7          	jalr	-746(ra) # 5bbe <printf>
      exit(1);
    4eb0:	4505                	li	a0,1
    4eb2:	00001097          	auipc	ra,0x1
    4eb6:	992080e7          	jalr	-1646(ra) # 5844 <exit>
  close(fd);
    4eba:	8552                	mv	a0,s4
    4ebc:	00001097          	auipc	ra,0x1
    4ec0:	9b0080e7          	jalr	-1616(ra) # 586c <close>
  if(total != N*SZ){
    4ec4:	678d                	lui	a5,0x3
    4ec6:	ee078793          	addi	a5,a5,-288 # 2ee0 <fourteen+0x10e>
    4eca:	02f99363          	bne	s3,a5,4ef0 <bigfile+0x1c4>
  unlink("bigfile.dat");
    4ece:	00003517          	auipc	a0,0x3
    4ed2:	c4250513          	addi	a0,a0,-958 # 7b10 <malloc+0x1e9a>
    4ed6:	00001097          	auipc	ra,0x1
    4eda:	9be080e7          	jalr	-1602(ra) # 5894 <unlink>
}
    4ede:	70e2                	ld	ra,56(sp)
    4ee0:	7442                	ld	s0,48(sp)
    4ee2:	74a2                	ld	s1,40(sp)
    4ee4:	7902                	ld	s2,32(sp)
    4ee6:	69e2                	ld	s3,24(sp)
    4ee8:	6a42                	ld	s4,16(sp)
    4eea:	6aa2                	ld	s5,8(sp)
    4eec:	6121                	addi	sp,sp,64
    4eee:	8082                	ret
    printf("%s: read bigfile wrong total\n", s);
    4ef0:	85d6                	mv	a1,s5
    4ef2:	00003517          	auipc	a0,0x3
    4ef6:	ce650513          	addi	a0,a0,-794 # 7bd8 <malloc+0x1f62>
    4efa:	00001097          	auipc	ra,0x1
    4efe:	cc4080e7          	jalr	-828(ra) # 5bbe <printf>
    exit(1);
    4f02:	4505                	li	a0,1
    4f04:	00001097          	auipc	ra,0x1
    4f08:	940080e7          	jalr	-1728(ra) # 5844 <exit>

0000000000004f0c <fsfull>:
{
    4f0c:	7171                	addi	sp,sp,-176
    4f0e:	f506                	sd	ra,168(sp)
    4f10:	f122                	sd	s0,160(sp)
    4f12:	ed26                	sd	s1,152(sp)
    4f14:	e94a                	sd	s2,144(sp)
    4f16:	e54e                	sd	s3,136(sp)
    4f18:	e152                	sd	s4,128(sp)
    4f1a:	fcd6                	sd	s5,120(sp)
    4f1c:	f8da                	sd	s6,112(sp)
    4f1e:	f4de                	sd	s7,104(sp)
    4f20:	f0e2                	sd	s8,96(sp)
    4f22:	ece6                	sd	s9,88(sp)
    4f24:	e8ea                	sd	s10,80(sp)
    4f26:	e4ee                	sd	s11,72(sp)
    4f28:	1900                	addi	s0,sp,176
  printf("fsfull test\n");
    4f2a:	00003517          	auipc	a0,0x3
    4f2e:	cce50513          	addi	a0,a0,-818 # 7bf8 <malloc+0x1f82>
    4f32:	00001097          	auipc	ra,0x1
    4f36:	c8c080e7          	jalr	-884(ra) # 5bbe <printf>
  for(nfiles = 0; ; nfiles++){
    4f3a:	4481                	li	s1,0
    name[0] = 'f';
    4f3c:	06600d13          	li	s10,102
    name[1] = '0' + nfiles / 1000;
    4f40:	3e800c13          	li	s8,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4f44:	06400b93          	li	s7,100
    name[3] = '0' + (nfiles % 100) / 10;
    4f48:	4b29                	li	s6,10
    printf("writing %s\n", name);
    4f4a:	00003c97          	auipc	s9,0x3
    4f4e:	cbec8c93          	addi	s9,s9,-834 # 7c08 <malloc+0x1f92>
    int total = 0;
    4f52:	4d81                	li	s11,0
      int cc = write(fd, buf, BSIZE);
    4f54:	00007a17          	auipc	s4,0x7
    4f58:	e84a0a13          	addi	s4,s4,-380 # bdd8 <buf>
    name[0] = 'f';
    4f5c:	f5a40823          	sb	s10,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4f60:	0384c7bb          	divw	a5,s1,s8
    4f64:	0307879b          	addiw	a5,a5,48
    4f68:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4f6c:	0384e7bb          	remw	a5,s1,s8
    4f70:	0377c7bb          	divw	a5,a5,s7
    4f74:	0307879b          	addiw	a5,a5,48
    4f78:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    4f7c:	0374e7bb          	remw	a5,s1,s7
    4f80:	0367c7bb          	divw	a5,a5,s6
    4f84:	0307879b          	addiw	a5,a5,48
    4f88:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    4f8c:	0364e7bb          	remw	a5,s1,s6
    4f90:	0307879b          	addiw	a5,a5,48
    4f94:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    4f98:	f4040aa3          	sb	zero,-171(s0)
    printf("writing %s\n", name);
    4f9c:	f5040593          	addi	a1,s0,-176
    4fa0:	8566                	mv	a0,s9
    4fa2:	00001097          	auipc	ra,0x1
    4fa6:	c1c080e7          	jalr	-996(ra) # 5bbe <printf>
    int fd = open(name, O_CREATE|O_RDWR);
    4faa:	20200593          	li	a1,514
    4fae:	f5040513          	addi	a0,s0,-176
    4fb2:	00001097          	auipc	ra,0x1
    4fb6:	8d2080e7          	jalr	-1838(ra) # 5884 <open>
    4fba:	892a                	mv	s2,a0
    if(fd < 0){
    4fbc:	0a055663          	bgez	a0,5068 <fsfull+0x15c>
      printf("open %s failed\n", name);
    4fc0:	f5040593          	addi	a1,s0,-176
    4fc4:	00003517          	auipc	a0,0x3
    4fc8:	c5450513          	addi	a0,a0,-940 # 7c18 <malloc+0x1fa2>
    4fcc:	00001097          	auipc	ra,0x1
    4fd0:	bf2080e7          	jalr	-1038(ra) # 5bbe <printf>
  while(nfiles >= 0){
    4fd4:	0604c363          	bltz	s1,503a <fsfull+0x12e>
    name[0] = 'f';
    4fd8:	06600b13          	li	s6,102
    name[1] = '0' + nfiles / 1000;
    4fdc:	3e800a13          	li	s4,1000
    name[2] = '0' + (nfiles % 1000) / 100;
    4fe0:	06400993          	li	s3,100
    name[3] = '0' + (nfiles % 100) / 10;
    4fe4:	4929                	li	s2,10
  while(nfiles >= 0){
    4fe6:	5afd                	li	s5,-1
    name[0] = 'f';
    4fe8:	f5640823          	sb	s6,-176(s0)
    name[1] = '0' + nfiles / 1000;
    4fec:	0344c7bb          	divw	a5,s1,s4
    4ff0:	0307879b          	addiw	a5,a5,48
    4ff4:	f4f408a3          	sb	a5,-175(s0)
    name[2] = '0' + (nfiles % 1000) / 100;
    4ff8:	0344e7bb          	remw	a5,s1,s4
    4ffc:	0337c7bb          	divw	a5,a5,s3
    5000:	0307879b          	addiw	a5,a5,48
    5004:	f4f40923          	sb	a5,-174(s0)
    name[3] = '0' + (nfiles % 100) / 10;
    5008:	0334e7bb          	remw	a5,s1,s3
    500c:	0327c7bb          	divw	a5,a5,s2
    5010:	0307879b          	addiw	a5,a5,48
    5014:	f4f409a3          	sb	a5,-173(s0)
    name[4] = '0' + (nfiles % 10);
    5018:	0324e7bb          	remw	a5,s1,s2
    501c:	0307879b          	addiw	a5,a5,48
    5020:	f4f40a23          	sb	a5,-172(s0)
    name[5] = '\0';
    5024:	f4040aa3          	sb	zero,-171(s0)
    unlink(name);
    5028:	f5040513          	addi	a0,s0,-176
    502c:	00001097          	auipc	ra,0x1
    5030:	868080e7          	jalr	-1944(ra) # 5894 <unlink>
    nfiles--;
    5034:	34fd                	addiw	s1,s1,-1
  while(nfiles >= 0){
    5036:	fb5499e3          	bne	s1,s5,4fe8 <fsfull+0xdc>
  printf("fsfull test finished\n");
    503a:	00003517          	auipc	a0,0x3
    503e:	bfe50513          	addi	a0,a0,-1026 # 7c38 <malloc+0x1fc2>
    5042:	00001097          	auipc	ra,0x1
    5046:	b7c080e7          	jalr	-1156(ra) # 5bbe <printf>
}
    504a:	70aa                	ld	ra,168(sp)
    504c:	740a                	ld	s0,160(sp)
    504e:	64ea                	ld	s1,152(sp)
    5050:	694a                	ld	s2,144(sp)
    5052:	69aa                	ld	s3,136(sp)
    5054:	6a0a                	ld	s4,128(sp)
    5056:	7ae6                	ld	s5,120(sp)
    5058:	7b46                	ld	s6,112(sp)
    505a:	7ba6                	ld	s7,104(sp)
    505c:	7c06                	ld	s8,96(sp)
    505e:	6ce6                	ld	s9,88(sp)
    5060:	6d46                	ld	s10,80(sp)
    5062:	6da6                	ld	s11,72(sp)
    5064:	614d                	addi	sp,sp,176
    5066:	8082                	ret
    int total = 0;
    5068:	89ee                	mv	s3,s11
      if(cc < BSIZE)
    506a:	3ff00a93          	li	s5,1023
      int cc = write(fd, buf, BSIZE);
    506e:	40000613          	li	a2,1024
    5072:	85d2                	mv	a1,s4
    5074:	854a                	mv	a0,s2
    5076:	00000097          	auipc	ra,0x0
    507a:	7ee080e7          	jalr	2030(ra) # 5864 <write>
      if(cc < BSIZE)
    507e:	00aad563          	bge	s5,a0,5088 <fsfull+0x17c>
      total += cc;
    5082:	00a989bb          	addw	s3,s3,a0
    while(1){
    5086:	b7e5                	j	506e <fsfull+0x162>
    printf("wrote %d bytes\n", total);
    5088:	85ce                	mv	a1,s3
    508a:	00003517          	auipc	a0,0x3
    508e:	b9e50513          	addi	a0,a0,-1122 # 7c28 <malloc+0x1fb2>
    5092:	00001097          	auipc	ra,0x1
    5096:	b2c080e7          	jalr	-1236(ra) # 5bbe <printf>
    close(fd);
    509a:	854a                	mv	a0,s2
    509c:	00000097          	auipc	ra,0x0
    50a0:	7d0080e7          	jalr	2000(ra) # 586c <close>
    if(total == 0)
    50a4:	f20988e3          	beqz	s3,4fd4 <fsfull+0xc8>
  for(nfiles = 0; ; nfiles++){
    50a8:	2485                	addiw	s1,s1,1
    50aa:	bd4d                	j	4f5c <fsfull+0x50>

00000000000050ac <badwrite>:
{
    50ac:	7179                	addi	sp,sp,-48
    50ae:	f406                	sd	ra,40(sp)
    50b0:	f022                	sd	s0,32(sp)
    50b2:	ec26                	sd	s1,24(sp)
    50b4:	e84a                	sd	s2,16(sp)
    50b6:	e44e                	sd	s3,8(sp)
    50b8:	e052                	sd	s4,0(sp)
    50ba:	1800                	addi	s0,sp,48
  unlink("junk");
    50bc:	00003517          	auipc	a0,0x3
    50c0:	b9450513          	addi	a0,a0,-1132 # 7c50 <malloc+0x1fda>
    50c4:	00000097          	auipc	ra,0x0
    50c8:	7d0080e7          	jalr	2000(ra) # 5894 <unlink>
    50cc:	25800913          	li	s2,600
    int fd = open("junk", O_CREATE|O_WRONLY);
    50d0:	00003997          	auipc	s3,0x3
    50d4:	b8098993          	addi	s3,s3,-1152 # 7c50 <malloc+0x1fda>
    write(fd, (char*)0xffffffffffL, 1);
    50d8:	5a7d                	li	s4,-1
    50da:	018a5a13          	srli	s4,s4,0x18
    int fd = open("junk", O_CREATE|O_WRONLY);
    50de:	20100593          	li	a1,513
    50e2:	854e                	mv	a0,s3
    50e4:	00000097          	auipc	ra,0x0
    50e8:	7a0080e7          	jalr	1952(ra) # 5884 <open>
    50ec:	84aa                	mv	s1,a0
    if(fd < 0){
    50ee:	06054b63          	bltz	a0,5164 <badwrite+0xb8>
    write(fd, (char*)0xffffffffffL, 1);
    50f2:	4605                	li	a2,1
    50f4:	85d2                	mv	a1,s4
    50f6:	00000097          	auipc	ra,0x0
    50fa:	76e080e7          	jalr	1902(ra) # 5864 <write>
    close(fd);
    50fe:	8526                	mv	a0,s1
    5100:	00000097          	auipc	ra,0x0
    5104:	76c080e7          	jalr	1900(ra) # 586c <close>
    unlink("junk");
    5108:	854e                	mv	a0,s3
    510a:	00000097          	auipc	ra,0x0
    510e:	78a080e7          	jalr	1930(ra) # 5894 <unlink>
  for(int i = 0; i < assumed_free; i++){
    5112:	397d                	addiw	s2,s2,-1
    5114:	fc0915e3          	bnez	s2,50de <badwrite+0x32>
  int fd = open("junk", O_CREATE|O_WRONLY);
    5118:	20100593          	li	a1,513
    511c:	00003517          	auipc	a0,0x3
    5120:	b3450513          	addi	a0,a0,-1228 # 7c50 <malloc+0x1fda>
    5124:	00000097          	auipc	ra,0x0
    5128:	760080e7          	jalr	1888(ra) # 5884 <open>
    512c:	84aa                	mv	s1,a0
  if(fd < 0){
    512e:	04054863          	bltz	a0,517e <badwrite+0xd2>
  if(write(fd, "x", 1) != 1){
    5132:	4605                	li	a2,1
    5134:	00001597          	auipc	a1,0x1
    5138:	cd458593          	addi	a1,a1,-812 # 5e08 <malloc+0x192>
    513c:	00000097          	auipc	ra,0x0
    5140:	728080e7          	jalr	1832(ra) # 5864 <write>
    5144:	4785                	li	a5,1
    5146:	04f50963          	beq	a0,a5,5198 <badwrite+0xec>
    printf("write failed\n");
    514a:	00003517          	auipc	a0,0x3
    514e:	b2650513          	addi	a0,a0,-1242 # 7c70 <malloc+0x1ffa>
    5152:	00001097          	auipc	ra,0x1
    5156:	a6c080e7          	jalr	-1428(ra) # 5bbe <printf>
    exit(1);
    515a:	4505                	li	a0,1
    515c:	00000097          	auipc	ra,0x0
    5160:	6e8080e7          	jalr	1768(ra) # 5844 <exit>
      printf("open junk failed\n");
    5164:	00003517          	auipc	a0,0x3
    5168:	af450513          	addi	a0,a0,-1292 # 7c58 <malloc+0x1fe2>
    516c:	00001097          	auipc	ra,0x1
    5170:	a52080e7          	jalr	-1454(ra) # 5bbe <printf>
      exit(1);
    5174:	4505                	li	a0,1
    5176:	00000097          	auipc	ra,0x0
    517a:	6ce080e7          	jalr	1742(ra) # 5844 <exit>
    printf("open junk failed\n");
    517e:	00003517          	auipc	a0,0x3
    5182:	ada50513          	addi	a0,a0,-1318 # 7c58 <malloc+0x1fe2>
    5186:	00001097          	auipc	ra,0x1
    518a:	a38080e7          	jalr	-1480(ra) # 5bbe <printf>
    exit(1);
    518e:	4505                	li	a0,1
    5190:	00000097          	auipc	ra,0x0
    5194:	6b4080e7          	jalr	1716(ra) # 5844 <exit>
  close(fd);
    5198:	8526                	mv	a0,s1
    519a:	00000097          	auipc	ra,0x0
    519e:	6d2080e7          	jalr	1746(ra) # 586c <close>
  unlink("junk");
    51a2:	00003517          	auipc	a0,0x3
    51a6:	aae50513          	addi	a0,a0,-1362 # 7c50 <malloc+0x1fda>
    51aa:	00000097          	auipc	ra,0x0
    51ae:	6ea080e7          	jalr	1770(ra) # 5894 <unlink>
  exit(0);
    51b2:	4501                	li	a0,0
    51b4:	00000097          	auipc	ra,0x0
    51b8:	690080e7          	jalr	1680(ra) # 5844 <exit>

00000000000051bc <countfree>:
// because out of memory with lazy allocation results in the process
// taking a fault and being killed, fork and report back.
//
int
countfree()
{
    51bc:	7139                	addi	sp,sp,-64
    51be:	fc06                	sd	ra,56(sp)
    51c0:	f822                	sd	s0,48(sp)
    51c2:	f426                	sd	s1,40(sp)
    51c4:	f04a                	sd	s2,32(sp)
    51c6:	ec4e                	sd	s3,24(sp)
    51c8:	0080                	addi	s0,sp,64
  int fds[2];

  if(pipe(fds) < 0){
    51ca:	fc840513          	addi	a0,s0,-56
    51ce:	00000097          	auipc	ra,0x0
    51d2:	686080e7          	jalr	1670(ra) # 5854 <pipe>
    51d6:	06054763          	bltz	a0,5244 <countfree+0x88>
    printf("pipe() failed in countfree()\n");
    exit(1);
  }
  
  int pid = fork();
    51da:	00000097          	auipc	ra,0x0
    51de:	662080e7          	jalr	1634(ra) # 583c <fork>

  if(pid < 0){
    51e2:	06054e63          	bltz	a0,525e <countfree+0xa2>
    printf("fork failed in countfree()\n");
    exit(1);
  }

  if(pid == 0){
    51e6:	ed51                	bnez	a0,5282 <countfree+0xc6>
    close(fds[0]);
    51e8:	fc842503          	lw	a0,-56(s0)
    51ec:	00000097          	auipc	ra,0x0
    51f0:	680080e7          	jalr	1664(ra) # 586c <close>
    
    while(1){
      uint64 a = (uint64) sbrk(4096);
      if(a == 0xffffffffffffffff){
    51f4:	597d                	li	s2,-1
        break;
      }

      // modify the memory to make sure it's really allocated.
      *(char *)(a + 4096 - 1) = 1;
    51f6:	4485                	li	s1,1

      // report back one more page.
      if(write(fds[1], "x", 1) != 1){
    51f8:	00001997          	auipc	s3,0x1
    51fc:	c1098993          	addi	s3,s3,-1008 # 5e08 <malloc+0x192>
      uint64 a = (uint64) sbrk(4096);
    5200:	6505                	lui	a0,0x1
    5202:	00000097          	auipc	ra,0x0
    5206:	6ca080e7          	jalr	1738(ra) # 58cc <sbrk>
      if(a == 0xffffffffffffffff){
    520a:	07250763          	beq	a0,s2,5278 <countfree+0xbc>
      *(char *)(a + 4096 - 1) = 1;
    520e:	6785                	lui	a5,0x1
    5210:	97aa                	add	a5,a5,a0
    5212:	fe978fa3          	sb	s1,-1(a5) # fff <bigdir+0x9d>
      if(write(fds[1], "x", 1) != 1){
    5216:	8626                	mv	a2,s1
    5218:	85ce                	mv	a1,s3
    521a:	fcc42503          	lw	a0,-52(s0)
    521e:	00000097          	auipc	ra,0x0
    5222:	646080e7          	jalr	1606(ra) # 5864 <write>
    5226:	fc950de3          	beq	a0,s1,5200 <countfree+0x44>
        printf("write() failed in countfree()\n");
    522a:	00003517          	auipc	a0,0x3
    522e:	a9650513          	addi	a0,a0,-1386 # 7cc0 <malloc+0x204a>
    5232:	00001097          	auipc	ra,0x1
    5236:	98c080e7          	jalr	-1652(ra) # 5bbe <printf>
        exit(1);
    523a:	4505                	li	a0,1
    523c:	00000097          	auipc	ra,0x0
    5240:	608080e7          	jalr	1544(ra) # 5844 <exit>
    printf("pipe() failed in countfree()\n");
    5244:	00003517          	auipc	a0,0x3
    5248:	a3c50513          	addi	a0,a0,-1476 # 7c80 <malloc+0x200a>
    524c:	00001097          	auipc	ra,0x1
    5250:	972080e7          	jalr	-1678(ra) # 5bbe <printf>
    exit(1);
    5254:	4505                	li	a0,1
    5256:	00000097          	auipc	ra,0x0
    525a:	5ee080e7          	jalr	1518(ra) # 5844 <exit>
    printf("fork failed in countfree()\n");
    525e:	00003517          	auipc	a0,0x3
    5262:	a4250513          	addi	a0,a0,-1470 # 7ca0 <malloc+0x202a>
    5266:	00001097          	auipc	ra,0x1
    526a:	958080e7          	jalr	-1704(ra) # 5bbe <printf>
    exit(1);
    526e:	4505                	li	a0,1
    5270:	00000097          	auipc	ra,0x0
    5274:	5d4080e7          	jalr	1492(ra) # 5844 <exit>
      }
    }

    exit(0);
    5278:	4501                	li	a0,0
    527a:	00000097          	auipc	ra,0x0
    527e:	5ca080e7          	jalr	1482(ra) # 5844 <exit>
  }

  close(fds[1]);
    5282:	fcc42503          	lw	a0,-52(s0)
    5286:	00000097          	auipc	ra,0x0
    528a:	5e6080e7          	jalr	1510(ra) # 586c <close>

  int n = 0;
    528e:	4481                	li	s1,0
  while(1){
    char c;
    int cc = read(fds[0], &c, 1);
    5290:	4605                	li	a2,1
    5292:	fc740593          	addi	a1,s0,-57
    5296:	fc842503          	lw	a0,-56(s0)
    529a:	00000097          	auipc	ra,0x0
    529e:	5c2080e7          	jalr	1474(ra) # 585c <read>
    if(cc < 0){
    52a2:	00054563          	bltz	a0,52ac <countfree+0xf0>
      printf("read() failed in countfree()\n");
      exit(1);
    }
    if(cc == 0)
    52a6:	c105                	beqz	a0,52c6 <countfree+0x10a>
      break;
    n += 1;
    52a8:	2485                	addiw	s1,s1,1
  while(1){
    52aa:	b7dd                	j	5290 <countfree+0xd4>
      printf("read() failed in countfree()\n");
    52ac:	00003517          	auipc	a0,0x3
    52b0:	a3450513          	addi	a0,a0,-1484 # 7ce0 <malloc+0x206a>
    52b4:	00001097          	auipc	ra,0x1
    52b8:	90a080e7          	jalr	-1782(ra) # 5bbe <printf>
      exit(1);
    52bc:	4505                	li	a0,1
    52be:	00000097          	auipc	ra,0x0
    52c2:	586080e7          	jalr	1414(ra) # 5844 <exit>
  }

  close(fds[0]);
    52c6:	fc842503          	lw	a0,-56(s0)
    52ca:	00000097          	auipc	ra,0x0
    52ce:	5a2080e7          	jalr	1442(ra) # 586c <close>
  wait((int*)0);
    52d2:	4501                	li	a0,0
    52d4:	00000097          	auipc	ra,0x0
    52d8:	578080e7          	jalr	1400(ra) # 584c <wait>
  
  return n;
}
    52dc:	8526                	mv	a0,s1
    52de:	70e2                	ld	ra,56(sp)
    52e0:	7442                	ld	s0,48(sp)
    52e2:	74a2                	ld	s1,40(sp)
    52e4:	7902                	ld	s2,32(sp)
    52e6:	69e2                	ld	s3,24(sp)
    52e8:	6121                	addi	sp,sp,64
    52ea:	8082                	ret

00000000000052ec <run>:

// run each test in its own process. run returns 1 if child's exit()
// indicates success.
int
run(void f(char *), char *s) {
    52ec:	7179                	addi	sp,sp,-48
    52ee:	f406                	sd	ra,40(sp)
    52f0:	f022                	sd	s0,32(sp)
    52f2:	ec26                	sd	s1,24(sp)
    52f4:	e84a                	sd	s2,16(sp)
    52f6:	1800                	addi	s0,sp,48
    52f8:	84aa                	mv	s1,a0
    52fa:	892e                	mv	s2,a1
  int pid;
  int xstatus;

  printf("test %s: ", s);
    52fc:	00003517          	auipc	a0,0x3
    5300:	a0450513          	addi	a0,a0,-1532 # 7d00 <malloc+0x208a>
    5304:	00001097          	auipc	ra,0x1
    5308:	8ba080e7          	jalr	-1862(ra) # 5bbe <printf>
  if((pid = fork()) < 0) {
    530c:	00000097          	auipc	ra,0x0
    5310:	530080e7          	jalr	1328(ra) # 583c <fork>
    5314:	02054e63          	bltz	a0,5350 <run+0x64>
    printf("runtest: fork error\n");
    exit(1);
  }
  if(pid == 0) {
    5318:	c929                	beqz	a0,536a <run+0x7e>
    f(s);
    exit(0);
  } else {
    wait(&xstatus);
    531a:	fdc40513          	addi	a0,s0,-36
    531e:	00000097          	auipc	ra,0x0
    5322:	52e080e7          	jalr	1326(ra) # 584c <wait>
    if(xstatus != 0) 
    5326:	fdc42783          	lw	a5,-36(s0)
    532a:	c7b9                	beqz	a5,5378 <run+0x8c>
      printf("FAILED\n");
    532c:	00003517          	auipc	a0,0x3
    5330:	9fc50513          	addi	a0,a0,-1540 # 7d28 <malloc+0x20b2>
    5334:	00001097          	auipc	ra,0x1
    5338:	88a080e7          	jalr	-1910(ra) # 5bbe <printf>
    else
      printf("OK\n");
    return xstatus == 0;
    533c:	fdc42503          	lw	a0,-36(s0)
  }
}
    5340:	00153513          	seqz	a0,a0
    5344:	70a2                	ld	ra,40(sp)
    5346:	7402                	ld	s0,32(sp)
    5348:	64e2                	ld	s1,24(sp)
    534a:	6942                	ld	s2,16(sp)
    534c:	6145                	addi	sp,sp,48
    534e:	8082                	ret
    printf("runtest: fork error\n");
    5350:	00003517          	auipc	a0,0x3
    5354:	9c050513          	addi	a0,a0,-1600 # 7d10 <malloc+0x209a>
    5358:	00001097          	auipc	ra,0x1
    535c:	866080e7          	jalr	-1946(ra) # 5bbe <printf>
    exit(1);
    5360:	4505                	li	a0,1
    5362:	00000097          	auipc	ra,0x0
    5366:	4e2080e7          	jalr	1250(ra) # 5844 <exit>
    f(s);
    536a:	854a                	mv	a0,s2
    536c:	9482                	jalr	s1
    exit(0);
    536e:	4501                	li	a0,0
    5370:	00000097          	auipc	ra,0x0
    5374:	4d4080e7          	jalr	1236(ra) # 5844 <exit>
      printf("OK\n");
    5378:	00003517          	auipc	a0,0x3
    537c:	9b850513          	addi	a0,a0,-1608 # 7d30 <malloc+0x20ba>
    5380:	00001097          	auipc	ra,0x1
    5384:	83e080e7          	jalr	-1986(ra) # 5bbe <printf>
    5388:	bf55                	j	533c <run+0x50>

000000000000538a <main>:

int
main(int argc, char *argv[])
{
    538a:	bd010113          	addi	sp,sp,-1072
    538e:	42113423          	sd	ra,1064(sp)
    5392:	42813023          	sd	s0,1056(sp)
    5396:	40913c23          	sd	s1,1048(sp)
    539a:	41213823          	sd	s2,1040(sp)
    539e:	41313423          	sd	s3,1032(sp)
    53a2:	41413023          	sd	s4,1024(sp)
    53a6:	3f513c23          	sd	s5,1016(sp)
    53aa:	3f613823          	sd	s6,1008(sp)
    53ae:	43010413          	addi	s0,sp,1072
    53b2:	89aa                	mv	s3,a0
  int continuous = 0;
  char *justone = 0;

  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    53b4:	4789                	li	a5,2
    53b6:	08f50f63          	beq	a0,a5,5454 <main+0xca>
    continuous = 1;
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    continuous = 2;
  } else if(argc == 2 && argv[1][0] != '-'){
    justone = argv[1];
  } else if(argc > 1){
    53ba:	4785                	li	a5,1
  char *justone = 0;
    53bc:	4901                	li	s2,0
  } else if(argc > 1){
    53be:	0ca7c963          	blt	a5,a0,5490 <main+0x106>
  }
  
  struct test {
    void (*f)(char *);
    char *s;
  } tests[] = {
    53c2:	00003797          	auipc	a5,0x3
    53c6:	d8678793          	addi	a5,a5,-634 # 8148 <malloc+0x24d2>
    53ca:	bd040713          	addi	a4,s0,-1072
    53ce:	00003317          	auipc	t1,0x3
    53d2:	16a30313          	addi	t1,t1,362 # 8538 <malloc+0x28c2>
    53d6:	0007b883          	ld	a7,0(a5)
    53da:	0087b803          	ld	a6,8(a5)
    53de:	6b88                	ld	a0,16(a5)
    53e0:	6f8c                	ld	a1,24(a5)
    53e2:	7390                	ld	a2,32(a5)
    53e4:	7794                	ld	a3,40(a5)
    53e6:	01173023          	sd	a7,0(a4)
    53ea:	01073423          	sd	a6,8(a4)
    53ee:	eb08                	sd	a0,16(a4)
    53f0:	ef0c                	sd	a1,24(a4)
    53f2:	f310                	sd	a2,32(a4)
    53f4:	f714                	sd	a3,40(a4)
    53f6:	03078793          	addi	a5,a5,48
    53fa:	03070713          	addi	a4,a4,48
    53fe:	fc679ce3          	bne	a5,t1,53d6 <main+0x4c>
          exit(1);
      }
    }
  }

  printf("usertests starting\n");
    5402:	00003517          	auipc	a0,0x3
    5406:	9e650513          	addi	a0,a0,-1562 # 7de8 <malloc+0x2172>
    540a:	00000097          	auipc	ra,0x0
    540e:	7b4080e7          	jalr	1972(ra) # 5bbe <printf>
  int free0 = countfree();
    5412:	00000097          	auipc	ra,0x0
    5416:	daa080e7          	jalr	-598(ra) # 51bc <countfree>
    541a:	8a2a                	mv	s4,a0
  int free1 = 0;
  int fail = 0;
  for (struct test *t = tests; t->s != 0; t++) {
    541c:	bd843503          	ld	a0,-1064(s0)
    5420:	bd040493          	addi	s1,s0,-1072
  int fail = 0;
    5424:	4981                	li	s3,0
    if((justone == 0) || strcmp(t->s, justone) == 0) {
      if(!run(t->f, t->s))
        fail = 1;
    5426:	4a85                	li	s5,1
  for (struct test *t = tests; t->s != 0; t++) {
    5428:	e55d                	bnez	a0,54d6 <main+0x14c>
  }

  if(fail){
    printf("SOME TESTS FAILED\n");
    exit(1);
  } else if((free1 = countfree()) < free0){
    542a:	00000097          	auipc	ra,0x0
    542e:	d92080e7          	jalr	-622(ra) # 51bc <countfree>
    5432:	85aa                	mv	a1,a0
    5434:	0f455163          	bge	a0,s4,5516 <main+0x18c>
    printf("FAILED -- lost some free pages %d (out of %d)\n", free1, free0);
    5438:	8652                	mv	a2,s4
    543a:	00003517          	auipc	a0,0x3
    543e:	96650513          	addi	a0,a0,-1690 # 7da0 <malloc+0x212a>
    5442:	00000097          	auipc	ra,0x0
    5446:	77c080e7          	jalr	1916(ra) # 5bbe <printf>
    exit(1);
    544a:	4505                	li	a0,1
    544c:	00000097          	auipc	ra,0x0
    5450:	3f8080e7          	jalr	1016(ra) # 5844 <exit>
    5454:	84ae                	mv	s1,a1
  if(argc == 2 && strcmp(argv[1], "-c") == 0){
    5456:	00003597          	auipc	a1,0x3
    545a:	8e258593          	addi	a1,a1,-1822 # 7d38 <malloc+0x20c2>
    545e:	6488                	ld	a0,8(s1)
    5460:	00000097          	auipc	ra,0x0
    5464:	194080e7          	jalr	404(ra) # 55f4 <strcmp>
    5468:	10050563          	beqz	a0,5572 <main+0x1e8>
  } else if(argc == 2 && strcmp(argv[1], "-C") == 0){
    546c:	00003597          	auipc	a1,0x3
    5470:	9b458593          	addi	a1,a1,-1612 # 7e20 <malloc+0x21aa>
    5474:	6488                	ld	a0,8(s1)
    5476:	00000097          	auipc	ra,0x0
    547a:	17e080e7          	jalr	382(ra) # 55f4 <strcmp>
    547e:	c97d                	beqz	a0,5574 <main+0x1ea>
  } else if(argc == 2 && argv[1][0] != '-'){
    5480:	0084b903          	ld	s2,8(s1)
    5484:	00094703          	lbu	a4,0(s2)
    5488:	02d00793          	li	a5,45
    548c:	f2f71be3          	bne	a4,a5,53c2 <main+0x38>
    printf("Usage: usertests [-c] [testname]\n");
    5490:	00003517          	auipc	a0,0x3
    5494:	8b050513          	addi	a0,a0,-1872 # 7d40 <malloc+0x20ca>
    5498:	00000097          	auipc	ra,0x0
    549c:	726080e7          	jalr	1830(ra) # 5bbe <printf>
    exit(1);
    54a0:	4505                	li	a0,1
    54a2:	00000097          	auipc	ra,0x0
    54a6:	3a2080e7          	jalr	930(ra) # 5844 <exit>
          exit(1);
    54aa:	4505                	li	a0,1
    54ac:	00000097          	auipc	ra,0x0
    54b0:	398080e7          	jalr	920(ra) # 5844 <exit>
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    54b4:	40a905bb          	subw	a1,s2,a0
    54b8:	855a                	mv	a0,s6
    54ba:	00000097          	auipc	ra,0x0
    54be:	704080e7          	jalr	1796(ra) # 5bbe <printf>
        if(continuous != 2)
    54c2:	09498463          	beq	s3,s4,554a <main+0x1c0>
          exit(1);
    54c6:	4505                	li	a0,1
    54c8:	00000097          	auipc	ra,0x0
    54cc:	37c080e7          	jalr	892(ra) # 5844 <exit>
  for (struct test *t = tests; t->s != 0; t++) {
    54d0:	04c1                	addi	s1,s1,16
    54d2:	6488                	ld	a0,8(s1)
    54d4:	c115                	beqz	a0,54f8 <main+0x16e>
    if((justone == 0) || strcmp(t->s, justone) == 0) {
    54d6:	00090863          	beqz	s2,54e6 <main+0x15c>
    54da:	85ca                	mv	a1,s2
    54dc:	00000097          	auipc	ra,0x0
    54e0:	118080e7          	jalr	280(ra) # 55f4 <strcmp>
    54e4:	f575                	bnez	a0,54d0 <main+0x146>
      if(!run(t->f, t->s))
    54e6:	648c                	ld	a1,8(s1)
    54e8:	6088                	ld	a0,0(s1)
    54ea:	00000097          	auipc	ra,0x0
    54ee:	e02080e7          	jalr	-510(ra) # 52ec <run>
    54f2:	fd79                	bnez	a0,54d0 <main+0x146>
        fail = 1;
    54f4:	89d6                	mv	s3,s5
    54f6:	bfe9                	j	54d0 <main+0x146>
  if(fail){
    54f8:	f20989e3          	beqz	s3,542a <main+0xa0>
    printf("SOME TESTS FAILED\n");
    54fc:	00003517          	auipc	a0,0x3
    5500:	88c50513          	addi	a0,a0,-1908 # 7d88 <malloc+0x2112>
    5504:	00000097          	auipc	ra,0x0
    5508:	6ba080e7          	jalr	1722(ra) # 5bbe <printf>
    exit(1);
    550c:	4505                	li	a0,1
    550e:	00000097          	auipc	ra,0x0
    5512:	336080e7          	jalr	822(ra) # 5844 <exit>
  } else {
    printf("ALL TESTS PASSED\n");
    5516:	00003517          	auipc	a0,0x3
    551a:	8ba50513          	addi	a0,a0,-1862 # 7dd0 <malloc+0x215a>
    551e:	00000097          	auipc	ra,0x0
    5522:	6a0080e7          	jalr	1696(ra) # 5bbe <printf>
    exit(0);
    5526:	4501                	li	a0,0
    5528:	00000097          	auipc	ra,0x0
    552c:	31c080e7          	jalr	796(ra) # 5844 <exit>
        printf("SOME TESTS FAILED\n");
    5530:	8556                	mv	a0,s5
    5532:	00000097          	auipc	ra,0x0
    5536:	68c080e7          	jalr	1676(ra) # 5bbe <printf>
        if(continuous != 2)
    553a:	f74998e3          	bne	s3,s4,54aa <main+0x120>
      int free1 = countfree();
    553e:	00000097          	auipc	ra,0x0
    5542:	c7e080e7          	jalr	-898(ra) # 51bc <countfree>
      if(free1 < free0){
    5546:	f72547e3          	blt	a0,s2,54b4 <main+0x12a>
      int free0 = countfree();
    554a:	00000097          	auipc	ra,0x0
    554e:	c72080e7          	jalr	-910(ra) # 51bc <countfree>
    5552:	892a                	mv	s2,a0
      for (struct test *t = tests; t->s != 0; t++) {
    5554:	bd843583          	ld	a1,-1064(s0)
    5558:	d1fd                	beqz	a1,553e <main+0x1b4>
    555a:	bd040493          	addi	s1,s0,-1072
        if(!run(t->f, t->s)){
    555e:	6088                	ld	a0,0(s1)
    5560:	00000097          	auipc	ra,0x0
    5564:	d8c080e7          	jalr	-628(ra) # 52ec <run>
    5568:	d561                	beqz	a0,5530 <main+0x1a6>
      for (struct test *t = tests; t->s != 0; t++) {
    556a:	04c1                	addi	s1,s1,16
    556c:	648c                	ld	a1,8(s1)
    556e:	f9e5                	bnez	a1,555e <main+0x1d4>
    5570:	b7f9                	j	553e <main+0x1b4>
    continuous = 1;
    5572:	4985                	li	s3,1
  } tests[] = {
    5574:	00003797          	auipc	a5,0x3
    5578:	bd478793          	addi	a5,a5,-1068 # 8148 <malloc+0x24d2>
    557c:	bd040713          	addi	a4,s0,-1072
    5580:	00003317          	auipc	t1,0x3
    5584:	fb830313          	addi	t1,t1,-72 # 8538 <malloc+0x28c2>
    5588:	0007b883          	ld	a7,0(a5)
    558c:	0087b803          	ld	a6,8(a5)
    5590:	6b88                	ld	a0,16(a5)
    5592:	6f8c                	ld	a1,24(a5)
    5594:	7390                	ld	a2,32(a5)
    5596:	7794                	ld	a3,40(a5)
    5598:	01173023          	sd	a7,0(a4)
    559c:	01073423          	sd	a6,8(a4)
    55a0:	eb08                	sd	a0,16(a4)
    55a2:	ef0c                	sd	a1,24(a4)
    55a4:	f310                	sd	a2,32(a4)
    55a6:	f714                	sd	a3,40(a4)
    55a8:	03078793          	addi	a5,a5,48
    55ac:	03070713          	addi	a4,a4,48
    55b0:	fc679ce3          	bne	a5,t1,5588 <main+0x1fe>
    printf("continuous usertests starting\n");
    55b4:	00003517          	auipc	a0,0x3
    55b8:	84c50513          	addi	a0,a0,-1972 # 7e00 <malloc+0x218a>
    55bc:	00000097          	auipc	ra,0x0
    55c0:	602080e7          	jalr	1538(ra) # 5bbe <printf>
        printf("SOME TESTS FAILED\n");
    55c4:	00002a97          	auipc	s5,0x2
    55c8:	7c4a8a93          	addi	s5,s5,1988 # 7d88 <malloc+0x2112>
        if(continuous != 2)
    55cc:	4a09                	li	s4,2
        printf("FAILED -- lost %d free pages\n", free0 - free1);
    55ce:	00002b17          	auipc	s6,0x2
    55d2:	79ab0b13          	addi	s6,s6,1946 # 7d68 <malloc+0x20f2>
    55d6:	bf95                	j	554a <main+0x1c0>

00000000000055d8 <strcpy>:
#include "kernel/fcntl.h"
#include "user/user.h"

char*
strcpy(char *s, const char *t)
{
    55d8:	1141                	addi	sp,sp,-16
    55da:	e422                	sd	s0,8(sp)
    55dc:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
    55de:	87aa                	mv	a5,a0
    55e0:	0585                	addi	a1,a1,1
    55e2:	0785                	addi	a5,a5,1
    55e4:	fff5c703          	lbu	a4,-1(a1)
    55e8:	fee78fa3          	sb	a4,-1(a5)
    55ec:	fb75                	bnez	a4,55e0 <strcpy+0x8>
    ;
  return os;
}
    55ee:	6422                	ld	s0,8(sp)
    55f0:	0141                	addi	sp,sp,16
    55f2:	8082                	ret

00000000000055f4 <strcmp>:

int
strcmp(const char *p, const char *q)
{
    55f4:	1141                	addi	sp,sp,-16
    55f6:	e422                	sd	s0,8(sp)
    55f8:	0800                	addi	s0,sp,16
  while(*p && *p == *q)
    55fa:	00054783          	lbu	a5,0(a0)
    55fe:	cb91                	beqz	a5,5612 <strcmp+0x1e>
    5600:	0005c703          	lbu	a4,0(a1)
    5604:	00f71763          	bne	a4,a5,5612 <strcmp+0x1e>
    p++, q++;
    5608:	0505                	addi	a0,a0,1
    560a:	0585                	addi	a1,a1,1
  while(*p && *p == *q)
    560c:	00054783          	lbu	a5,0(a0)
    5610:	fbe5                	bnez	a5,5600 <strcmp+0xc>
  return (uchar)*p - (uchar)*q;
    5612:	0005c503          	lbu	a0,0(a1)
}
    5616:	40a7853b          	subw	a0,a5,a0
    561a:	6422                	ld	s0,8(sp)
    561c:	0141                	addi	sp,sp,16
    561e:	8082                	ret

0000000000005620 <strlen>:

uint
strlen(const char *s)
{
    5620:	1141                	addi	sp,sp,-16
    5622:	e422                	sd	s0,8(sp)
    5624:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    5626:	00054783          	lbu	a5,0(a0)
    562a:	cf91                	beqz	a5,5646 <strlen+0x26>
    562c:	0505                	addi	a0,a0,1
    562e:	87aa                	mv	a5,a0
    5630:	4685                	li	a3,1
    5632:	9e89                	subw	a3,a3,a0
    5634:	00f6853b          	addw	a0,a3,a5
    5638:	0785                	addi	a5,a5,1
    563a:	fff7c703          	lbu	a4,-1(a5)
    563e:	fb7d                	bnez	a4,5634 <strlen+0x14>
    ;
  return n;
}
    5640:	6422                	ld	s0,8(sp)
    5642:	0141                	addi	sp,sp,16
    5644:	8082                	ret
  for(n = 0; s[n]; n++)
    5646:	4501                	li	a0,0
    5648:	bfe5                	j	5640 <strlen+0x20>

000000000000564a <memset>:

void*
memset(void *dst, int c, uint n)
{
    564a:	1141                	addi	sp,sp,-16
    564c:	e422                	sd	s0,8(sp)
    564e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    5650:	ca19                	beqz	a2,5666 <memset+0x1c>
    5652:	87aa                	mv	a5,a0
    5654:	1602                	slli	a2,a2,0x20
    5656:	9201                	srli	a2,a2,0x20
    5658:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    565c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    5660:	0785                	addi	a5,a5,1
    5662:	fee79de3          	bne	a5,a4,565c <memset+0x12>
  }
  return dst;
}
    5666:	6422                	ld	s0,8(sp)
    5668:	0141                	addi	sp,sp,16
    566a:	8082                	ret

000000000000566c <strchr>:

char*
strchr(const char *s, char c)
{
    566c:	1141                	addi	sp,sp,-16
    566e:	e422                	sd	s0,8(sp)
    5670:	0800                	addi	s0,sp,16
  for(; *s; s++)
    5672:	00054783          	lbu	a5,0(a0)
    5676:	cb99                	beqz	a5,568c <strchr+0x20>
    if(*s == c)
    5678:	00f58763          	beq	a1,a5,5686 <strchr+0x1a>
  for(; *s; s++)
    567c:	0505                	addi	a0,a0,1
    567e:	00054783          	lbu	a5,0(a0)
    5682:	fbfd                	bnez	a5,5678 <strchr+0xc>
      return (char*)s;
  return 0;
    5684:	4501                	li	a0,0
}
    5686:	6422                	ld	s0,8(sp)
    5688:	0141                	addi	sp,sp,16
    568a:	8082                	ret
  return 0;
    568c:	4501                	li	a0,0
    568e:	bfe5                	j	5686 <strchr+0x1a>

0000000000005690 <gets>:

char*
gets(char *buf, int max)
{
    5690:	711d                	addi	sp,sp,-96
    5692:	ec86                	sd	ra,88(sp)
    5694:	e8a2                	sd	s0,80(sp)
    5696:	e4a6                	sd	s1,72(sp)
    5698:	e0ca                	sd	s2,64(sp)
    569a:	fc4e                	sd	s3,56(sp)
    569c:	f852                	sd	s4,48(sp)
    569e:	f456                	sd	s5,40(sp)
    56a0:	f05a                	sd	s6,32(sp)
    56a2:	ec5e                	sd	s7,24(sp)
    56a4:	1080                	addi	s0,sp,96
    56a6:	8baa                	mv	s7,a0
    56a8:	8a2e                	mv	s4,a1
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
    56aa:	892a                	mv	s2,a0
    56ac:	4481                	li	s1,0
    cc = read(0, &c, 1);
    if(cc < 1)
      break;
    buf[i++] = c;
    if(c == '\n' || c == '\r')
    56ae:	4aa9                	li	s5,10
    56b0:	4b35                	li	s6,13
  for(i=0; i+1 < max; ){
    56b2:	89a6                	mv	s3,s1
    56b4:	2485                	addiw	s1,s1,1
    56b6:	0344d863          	bge	s1,s4,56e6 <gets+0x56>
    cc = read(0, &c, 1);
    56ba:	4605                	li	a2,1
    56bc:	faf40593          	addi	a1,s0,-81
    56c0:	4501                	li	a0,0
    56c2:	00000097          	auipc	ra,0x0
    56c6:	19a080e7          	jalr	410(ra) # 585c <read>
    if(cc < 1)
    56ca:	00a05e63          	blez	a0,56e6 <gets+0x56>
    buf[i++] = c;
    56ce:	faf44783          	lbu	a5,-81(s0)
    56d2:	00f90023          	sb	a5,0(s2)
    if(c == '\n' || c == '\r')
    56d6:	01578763          	beq	a5,s5,56e4 <gets+0x54>
    56da:	0905                	addi	s2,s2,1
    56dc:	fd679be3          	bne	a5,s6,56b2 <gets+0x22>
  for(i=0; i+1 < max; ){
    56e0:	89a6                	mv	s3,s1
    56e2:	a011                	j	56e6 <gets+0x56>
    56e4:	89a6                	mv	s3,s1
      break;
  }
  buf[i] = '\0';
    56e6:	99de                	add	s3,s3,s7
    56e8:	00098023          	sb	zero,0(s3)
  return buf;
}
    56ec:	855e                	mv	a0,s7
    56ee:	60e6                	ld	ra,88(sp)
    56f0:	6446                	ld	s0,80(sp)
    56f2:	64a6                	ld	s1,72(sp)
    56f4:	6906                	ld	s2,64(sp)
    56f6:	79e2                	ld	s3,56(sp)
    56f8:	7a42                	ld	s4,48(sp)
    56fa:	7aa2                	ld	s5,40(sp)
    56fc:	7b02                	ld	s6,32(sp)
    56fe:	6be2                	ld	s7,24(sp)
    5700:	6125                	addi	sp,sp,96
    5702:	8082                	ret

0000000000005704 <stat>:

int
stat(const char *n, struct stat *st)
{
    5704:	1101                	addi	sp,sp,-32
    5706:	ec06                	sd	ra,24(sp)
    5708:	e822                	sd	s0,16(sp)
    570a:	e426                	sd	s1,8(sp)
    570c:	e04a                	sd	s2,0(sp)
    570e:	1000                	addi	s0,sp,32
    5710:	892e                	mv	s2,a1
  int fd;
  int r;

  fd = open(n, O_RDONLY);
    5712:	4581                	li	a1,0
    5714:	00000097          	auipc	ra,0x0
    5718:	170080e7          	jalr	368(ra) # 5884 <open>
  if(fd < 0)
    571c:	02054563          	bltz	a0,5746 <stat+0x42>
    5720:	84aa                	mv	s1,a0
    return -1;
  r = fstat(fd, st);
    5722:	85ca                	mv	a1,s2
    5724:	00000097          	auipc	ra,0x0
    5728:	178080e7          	jalr	376(ra) # 589c <fstat>
    572c:	892a                	mv	s2,a0
  close(fd);
    572e:	8526                	mv	a0,s1
    5730:	00000097          	auipc	ra,0x0
    5734:	13c080e7          	jalr	316(ra) # 586c <close>
  return r;
}
    5738:	854a                	mv	a0,s2
    573a:	60e2                	ld	ra,24(sp)
    573c:	6442                	ld	s0,16(sp)
    573e:	64a2                	ld	s1,8(sp)
    5740:	6902                	ld	s2,0(sp)
    5742:	6105                	addi	sp,sp,32
    5744:	8082                	ret
    return -1;
    5746:	597d                	li	s2,-1
    5748:	bfc5                	j	5738 <stat+0x34>

000000000000574a <atoi>:

int
atoi(const char *s)
{
    574a:	1141                	addi	sp,sp,-16
    574c:	e422                	sd	s0,8(sp)
    574e:	0800                	addi	s0,sp,16
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
    5750:	00054683          	lbu	a3,0(a0)
    5754:	fd06879b          	addiw	a5,a3,-48
    5758:	0ff7f793          	zext.b	a5,a5
    575c:	4625                	li	a2,9
    575e:	02f66863          	bltu	a2,a5,578e <atoi+0x44>
    5762:	872a                	mv	a4,a0
  n = 0;
    5764:	4501                	li	a0,0
    n = n*10 + *s++ - '0';
    5766:	0705                	addi	a4,a4,1
    5768:	0025179b          	slliw	a5,a0,0x2
    576c:	9fa9                	addw	a5,a5,a0
    576e:	0017979b          	slliw	a5,a5,0x1
    5772:	9fb5                	addw	a5,a5,a3
    5774:	fd07851b          	addiw	a0,a5,-48
  while('0' <= *s && *s <= '9')
    5778:	00074683          	lbu	a3,0(a4)
    577c:	fd06879b          	addiw	a5,a3,-48
    5780:	0ff7f793          	zext.b	a5,a5
    5784:	fef671e3          	bgeu	a2,a5,5766 <atoi+0x1c>
  return n;
}
    5788:	6422                	ld	s0,8(sp)
    578a:	0141                	addi	sp,sp,16
    578c:	8082                	ret
  n = 0;
    578e:	4501                	li	a0,0
    5790:	bfe5                	j	5788 <atoi+0x3e>

0000000000005792 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
    5792:	1141                	addi	sp,sp,-16
    5794:	e422                	sd	s0,8(sp)
    5796:	0800                	addi	s0,sp,16
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  if (src > dst) {
    5798:	02b57463          	bgeu	a0,a1,57c0 <memmove+0x2e>
    while(n-- > 0)
    579c:	00c05f63          	blez	a2,57ba <memmove+0x28>
    57a0:	1602                	slli	a2,a2,0x20
    57a2:	9201                	srli	a2,a2,0x20
    57a4:	00c507b3          	add	a5,a0,a2
  dst = vdst;
    57a8:	872a                	mv	a4,a0
      *dst++ = *src++;
    57aa:	0585                	addi	a1,a1,1
    57ac:	0705                	addi	a4,a4,1
    57ae:	fff5c683          	lbu	a3,-1(a1)
    57b2:	fed70fa3          	sb	a3,-1(a4)
    while(n-- > 0)
    57b6:	fee79ae3          	bne	a5,a4,57aa <memmove+0x18>
    src += n;
    while(n-- > 0)
      *--dst = *--src;
  }
  return vdst;
}
    57ba:	6422                	ld	s0,8(sp)
    57bc:	0141                	addi	sp,sp,16
    57be:	8082                	ret
    dst += n;
    57c0:	00c50733          	add	a4,a0,a2
    src += n;
    57c4:	95b2                	add	a1,a1,a2
    while(n-- > 0)
    57c6:	fec05ae3          	blez	a2,57ba <memmove+0x28>
    57ca:	fff6079b          	addiw	a5,a2,-1 # 2fff <iputtest+0x89>
    57ce:	1782                	slli	a5,a5,0x20
    57d0:	9381                	srli	a5,a5,0x20
    57d2:	fff7c793          	not	a5,a5
    57d6:	97ba                	add	a5,a5,a4
      *--dst = *--src;
    57d8:	15fd                	addi	a1,a1,-1
    57da:	177d                	addi	a4,a4,-1
    57dc:	0005c683          	lbu	a3,0(a1)
    57e0:	00d70023          	sb	a3,0(a4)
    while(n-- > 0)
    57e4:	fee79ae3          	bne	a5,a4,57d8 <memmove+0x46>
    57e8:	bfc9                	j	57ba <memmove+0x28>

00000000000057ea <memcmp>:

int
memcmp(const void *s1, const void *s2, uint n)
{
    57ea:	1141                	addi	sp,sp,-16
    57ec:	e422                	sd	s0,8(sp)
    57ee:	0800                	addi	s0,sp,16
  const char *p1 = s1, *p2 = s2;
  while (n-- > 0) {
    57f0:	ca05                	beqz	a2,5820 <memcmp+0x36>
    57f2:	fff6069b          	addiw	a3,a2,-1
    57f6:	1682                	slli	a3,a3,0x20
    57f8:	9281                	srli	a3,a3,0x20
    57fa:	0685                	addi	a3,a3,1
    57fc:	96aa                	add	a3,a3,a0
    if (*p1 != *p2) {
    57fe:	00054783          	lbu	a5,0(a0)
    5802:	0005c703          	lbu	a4,0(a1)
    5806:	00e79863          	bne	a5,a4,5816 <memcmp+0x2c>
      return *p1 - *p2;
    }
    p1++;
    580a:	0505                	addi	a0,a0,1
    p2++;
    580c:	0585                	addi	a1,a1,1
  while (n-- > 0) {
    580e:	fed518e3          	bne	a0,a3,57fe <memcmp+0x14>
  }
  return 0;
    5812:	4501                	li	a0,0
    5814:	a019                	j	581a <memcmp+0x30>
      return *p1 - *p2;
    5816:	40e7853b          	subw	a0,a5,a4
}
    581a:	6422                	ld	s0,8(sp)
    581c:	0141                	addi	sp,sp,16
    581e:	8082                	ret
  return 0;
    5820:	4501                	li	a0,0
    5822:	bfe5                	j	581a <memcmp+0x30>

0000000000005824 <memcpy>:

void *
memcpy(void *dst, const void *src, uint n)
{
    5824:	1141                	addi	sp,sp,-16
    5826:	e406                	sd	ra,8(sp)
    5828:	e022                	sd	s0,0(sp)
    582a:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    582c:	00000097          	auipc	ra,0x0
    5830:	f66080e7          	jalr	-154(ra) # 5792 <memmove>
}
    5834:	60a2                	ld	ra,8(sp)
    5836:	6402                	ld	s0,0(sp)
    5838:	0141                	addi	sp,sp,16
    583a:	8082                	ret

000000000000583c <fork>:
# generated by usys.pl - do not edit
#include "kernel/syscall.h"
.global fork
fork:
 li a7, SYS_fork
    583c:	4885                	li	a7,1
 ecall
    583e:	00000073          	ecall
 ret
    5842:	8082                	ret

0000000000005844 <exit>:
.global exit
exit:
 li a7, SYS_exit
    5844:	4889                	li	a7,2
 ecall
    5846:	00000073          	ecall
 ret
    584a:	8082                	ret

000000000000584c <wait>:
.global wait
wait:
 li a7, SYS_wait
    584c:	488d                	li	a7,3
 ecall
    584e:	00000073          	ecall
 ret
    5852:	8082                	ret

0000000000005854 <pipe>:
.global pipe
pipe:
 li a7, SYS_pipe
    5854:	4891                	li	a7,4
 ecall
    5856:	00000073          	ecall
 ret
    585a:	8082                	ret

000000000000585c <read>:
.global read
read:
 li a7, SYS_read
    585c:	4895                	li	a7,5
 ecall
    585e:	00000073          	ecall
 ret
    5862:	8082                	ret

0000000000005864 <write>:
.global write
write:
 li a7, SYS_write
    5864:	48c1                	li	a7,16
 ecall
    5866:	00000073          	ecall
 ret
    586a:	8082                	ret

000000000000586c <close>:
.global close
close:
 li a7, SYS_close
    586c:	48d5                	li	a7,21
 ecall
    586e:	00000073          	ecall
 ret
    5872:	8082                	ret

0000000000005874 <kill>:
.global kill
kill:
 li a7, SYS_kill
    5874:	4899                	li	a7,6
 ecall
    5876:	00000073          	ecall
 ret
    587a:	8082                	ret

000000000000587c <exec>:
.global exec
exec:
 li a7, SYS_exec
    587c:	489d                	li	a7,7
 ecall
    587e:	00000073          	ecall
 ret
    5882:	8082                	ret

0000000000005884 <open>:
.global open
open:
 li a7, SYS_open
    5884:	48bd                	li	a7,15
 ecall
    5886:	00000073          	ecall
 ret
    588a:	8082                	ret

000000000000588c <mknod>:
.global mknod
mknod:
 li a7, SYS_mknod
    588c:	48c5                	li	a7,17
 ecall
    588e:	00000073          	ecall
 ret
    5892:	8082                	ret

0000000000005894 <unlink>:
.global unlink
unlink:
 li a7, SYS_unlink
    5894:	48c9                	li	a7,18
 ecall
    5896:	00000073          	ecall
 ret
    589a:	8082                	ret

000000000000589c <fstat>:
.global fstat
fstat:
 li a7, SYS_fstat
    589c:	48a1                	li	a7,8
 ecall
    589e:	00000073          	ecall
 ret
    58a2:	8082                	ret

00000000000058a4 <link>:
.global link
link:
 li a7, SYS_link
    58a4:	48cd                	li	a7,19
 ecall
    58a6:	00000073          	ecall
 ret
    58aa:	8082                	ret

00000000000058ac <mkdir>:
.global mkdir
mkdir:
 li a7, SYS_mkdir
    58ac:	48d1                	li	a7,20
 ecall
    58ae:	00000073          	ecall
 ret
    58b2:	8082                	ret

00000000000058b4 <chdir>:
.global chdir
chdir:
 li a7, SYS_chdir
    58b4:	48a5                	li	a7,9
 ecall
    58b6:	00000073          	ecall
 ret
    58ba:	8082                	ret

00000000000058bc <dup>:
.global dup
dup:
 li a7, SYS_dup
    58bc:	48a9                	li	a7,10
 ecall
    58be:	00000073          	ecall
 ret
    58c2:	8082                	ret

00000000000058c4 <getpid>:
.global getpid
getpid:
 li a7, SYS_getpid
    58c4:	48ad                	li	a7,11
 ecall
    58c6:	00000073          	ecall
 ret
    58ca:	8082                	ret

00000000000058cc <sbrk>:
.global sbrk
sbrk:
 li a7, SYS_sbrk
    58cc:	48b1                	li	a7,12
 ecall
    58ce:	00000073          	ecall
 ret
    58d2:	8082                	ret

00000000000058d4 <sleep>:
.global sleep
sleep:
 li a7, SYS_sleep
    58d4:	48b5                	li	a7,13
 ecall
    58d6:	00000073          	ecall
 ret
    58da:	8082                	ret

00000000000058dc <uptime>:
.global uptime
uptime:
 li a7, SYS_uptime
    58dc:	48b9                	li	a7,14
 ecall
    58de:	00000073          	ecall
 ret
    58e2:	8082                	ret

00000000000058e4 <putc>:

static char digits[] = "0123456789ABCDEF";

static void
putc(int fd, char c)
{
    58e4:	1101                	addi	sp,sp,-32
    58e6:	ec06                	sd	ra,24(sp)
    58e8:	e822                	sd	s0,16(sp)
    58ea:	1000                	addi	s0,sp,32
    58ec:	feb407a3          	sb	a1,-17(s0)
  write(fd, &c, 1);
    58f0:	4605                	li	a2,1
    58f2:	fef40593          	addi	a1,s0,-17
    58f6:	00000097          	auipc	ra,0x0
    58fa:	f6e080e7          	jalr	-146(ra) # 5864 <write>
}
    58fe:	60e2                	ld	ra,24(sp)
    5900:	6442                	ld	s0,16(sp)
    5902:	6105                	addi	sp,sp,32
    5904:	8082                	ret

0000000000005906 <printint>:

static void
printint(int fd, int xx, int base, int sgn)
{
    5906:	7139                	addi	sp,sp,-64
    5908:	fc06                	sd	ra,56(sp)
    590a:	f822                	sd	s0,48(sp)
    590c:	f426                	sd	s1,40(sp)
    590e:	f04a                	sd	s2,32(sp)
    5910:	ec4e                	sd	s3,24(sp)
    5912:	0080                	addi	s0,sp,64
    5914:	84aa                	mv	s1,a0
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    5916:	c299                	beqz	a3,591c <printint+0x16>
    5918:	0805c963          	bltz	a1,59aa <printint+0xa4>
    neg = 1;
    x = -xx;
  } else {
    x = xx;
    591c:	2581                	sext.w	a1,a1
  neg = 0;
    591e:	4881                	li	a7,0
    5920:	fc040693          	addi	a3,s0,-64
  }

  i = 0;
    5924:	4701                	li	a4,0
  do{
    buf[i++] = digits[x % base];
    5926:	2601                	sext.w	a2,a2
    5928:	00003517          	auipc	a0,0x3
    592c:	c7050513          	addi	a0,a0,-912 # 8598 <digits>
    5930:	883a                	mv	a6,a4
    5932:	2705                	addiw	a4,a4,1
    5934:	02c5f7bb          	remuw	a5,a1,a2
    5938:	1782                	slli	a5,a5,0x20
    593a:	9381                	srli	a5,a5,0x20
    593c:	97aa                	add	a5,a5,a0
    593e:	0007c783          	lbu	a5,0(a5)
    5942:	00f68023          	sb	a5,0(a3)
  }while((x /= base) != 0);
    5946:	0005879b          	sext.w	a5,a1
    594a:	02c5d5bb          	divuw	a1,a1,a2
    594e:	0685                	addi	a3,a3,1
    5950:	fec7f0e3          	bgeu	a5,a2,5930 <printint+0x2a>
  if(neg)
    5954:	00088c63          	beqz	a7,596c <printint+0x66>
    buf[i++] = '-';
    5958:	fd070793          	addi	a5,a4,-48
    595c:	00878733          	add	a4,a5,s0
    5960:	02d00793          	li	a5,45
    5964:	fef70823          	sb	a5,-16(a4)
    5968:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    596c:	02e05863          	blez	a4,599c <printint+0x96>
    5970:	fc040793          	addi	a5,s0,-64
    5974:	00e78933          	add	s2,a5,a4
    5978:	fff78993          	addi	s3,a5,-1
    597c:	99ba                	add	s3,s3,a4
    597e:	377d                	addiw	a4,a4,-1
    5980:	1702                	slli	a4,a4,0x20
    5982:	9301                	srli	a4,a4,0x20
    5984:	40e989b3          	sub	s3,s3,a4
    putc(fd, buf[i]);
    5988:	fff94583          	lbu	a1,-1(s2)
    598c:	8526                	mv	a0,s1
    598e:	00000097          	auipc	ra,0x0
    5992:	f56080e7          	jalr	-170(ra) # 58e4 <putc>
  while(--i >= 0)
    5996:	197d                	addi	s2,s2,-1
    5998:	ff3918e3          	bne	s2,s3,5988 <printint+0x82>
}
    599c:	70e2                	ld	ra,56(sp)
    599e:	7442                	ld	s0,48(sp)
    59a0:	74a2                	ld	s1,40(sp)
    59a2:	7902                	ld	s2,32(sp)
    59a4:	69e2                	ld	s3,24(sp)
    59a6:	6121                	addi	sp,sp,64
    59a8:	8082                	ret
    x = -xx;
    59aa:	40b005bb          	negw	a1,a1
    neg = 1;
    59ae:	4885                	li	a7,1
    x = -xx;
    59b0:	bf85                	j	5920 <printint+0x1a>

00000000000059b2 <vprintf>:
}

// Print to the given fd. Only understands %d, %x, %p, %s.
void
vprintf(int fd, const char *fmt, va_list ap)
{
    59b2:	7119                	addi	sp,sp,-128
    59b4:	fc86                	sd	ra,120(sp)
    59b6:	f8a2                	sd	s0,112(sp)
    59b8:	f4a6                	sd	s1,104(sp)
    59ba:	f0ca                	sd	s2,96(sp)
    59bc:	ecce                	sd	s3,88(sp)
    59be:	e8d2                	sd	s4,80(sp)
    59c0:	e4d6                	sd	s5,72(sp)
    59c2:	e0da                	sd	s6,64(sp)
    59c4:	fc5e                	sd	s7,56(sp)
    59c6:	f862                	sd	s8,48(sp)
    59c8:	f466                	sd	s9,40(sp)
    59ca:	f06a                	sd	s10,32(sp)
    59cc:	ec6e                	sd	s11,24(sp)
    59ce:	0100                	addi	s0,sp,128
  char *s;
  int c, i, state;

  state = 0;
  for(i = 0; fmt[i]; i++){
    59d0:	0005c903          	lbu	s2,0(a1)
    59d4:	18090f63          	beqz	s2,5b72 <vprintf+0x1c0>
    59d8:	8aaa                	mv	s5,a0
    59da:	8b32                	mv	s6,a2
    59dc:	00158493          	addi	s1,a1,1
  state = 0;
    59e0:	4981                	li	s3,0
      if(c == '%'){
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    59e2:	02500a13          	li	s4,37
    59e6:	4c55                	li	s8,21
    59e8:	00003c97          	auipc	s9,0x3
    59ec:	b58c8c93          	addi	s9,s9,-1192 # 8540 <malloc+0x28ca>
        printptr(fd, va_arg(ap, uint64));
      } else if(c == 's'){
        s = va_arg(ap, char*);
        if(s == 0)
          s = "(null)";
        while(*s != 0){
    59f0:	02800d93          	li	s11,40
  putc(fd, 'x');
    59f4:	4d41                	li	s10,16
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    59f6:	00003b97          	auipc	s7,0x3
    59fa:	ba2b8b93          	addi	s7,s7,-1118 # 8598 <digits>
    59fe:	a839                	j	5a1c <vprintf+0x6a>
        putc(fd, c);
    5a00:	85ca                	mv	a1,s2
    5a02:	8556                	mv	a0,s5
    5a04:	00000097          	auipc	ra,0x0
    5a08:	ee0080e7          	jalr	-288(ra) # 58e4 <putc>
    5a0c:	a019                	j	5a12 <vprintf+0x60>
    } else if(state == '%'){
    5a0e:	01498d63          	beq	s3,s4,5a28 <vprintf+0x76>
  for(i = 0; fmt[i]; i++){
    5a12:	0485                	addi	s1,s1,1
    5a14:	fff4c903          	lbu	s2,-1(s1)
    5a18:	14090d63          	beqz	s2,5b72 <vprintf+0x1c0>
    if(state == 0){
    5a1c:	fe0999e3          	bnez	s3,5a0e <vprintf+0x5c>
      if(c == '%'){
    5a20:	ff4910e3          	bne	s2,s4,5a00 <vprintf+0x4e>
        state = '%';
    5a24:	89d2                	mv	s3,s4
    5a26:	b7f5                	j	5a12 <vprintf+0x60>
      if(c == 'd'){
    5a28:	11490c63          	beq	s2,s4,5b40 <vprintf+0x18e>
    5a2c:	f9d9079b          	addiw	a5,s2,-99
    5a30:	0ff7f793          	zext.b	a5,a5
    5a34:	10fc6e63          	bltu	s8,a5,5b50 <vprintf+0x19e>
    5a38:	f9d9079b          	addiw	a5,s2,-99
    5a3c:	0ff7f713          	zext.b	a4,a5
    5a40:	10ec6863          	bltu	s8,a4,5b50 <vprintf+0x19e>
    5a44:	00271793          	slli	a5,a4,0x2
    5a48:	97e6                	add	a5,a5,s9
    5a4a:	439c                	lw	a5,0(a5)
    5a4c:	97e6                	add	a5,a5,s9
    5a4e:	8782                	jr	a5
        printint(fd, va_arg(ap, int), 10, 1);
    5a50:	008b0913          	addi	s2,s6,8
    5a54:	4685                	li	a3,1
    5a56:	4629                	li	a2,10
    5a58:	000b2583          	lw	a1,0(s6)
    5a5c:	8556                	mv	a0,s5
    5a5e:	00000097          	auipc	ra,0x0
    5a62:	ea8080e7          	jalr	-344(ra) # 5906 <printint>
    5a66:	8b4a                	mv	s6,s2
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    5a68:	4981                	li	s3,0
    5a6a:	b765                	j	5a12 <vprintf+0x60>
        printint(fd, va_arg(ap, uint64), 10, 0);
    5a6c:	008b0913          	addi	s2,s6,8
    5a70:	4681                	li	a3,0
    5a72:	4629                	li	a2,10
    5a74:	000b2583          	lw	a1,0(s6)
    5a78:	8556                	mv	a0,s5
    5a7a:	00000097          	auipc	ra,0x0
    5a7e:	e8c080e7          	jalr	-372(ra) # 5906 <printint>
    5a82:	8b4a                	mv	s6,s2
      state = 0;
    5a84:	4981                	li	s3,0
    5a86:	b771                	j	5a12 <vprintf+0x60>
        printint(fd, va_arg(ap, int), 16, 0);
    5a88:	008b0913          	addi	s2,s6,8
    5a8c:	4681                	li	a3,0
    5a8e:	866a                	mv	a2,s10
    5a90:	000b2583          	lw	a1,0(s6)
    5a94:	8556                	mv	a0,s5
    5a96:	00000097          	auipc	ra,0x0
    5a9a:	e70080e7          	jalr	-400(ra) # 5906 <printint>
    5a9e:	8b4a                	mv	s6,s2
      state = 0;
    5aa0:	4981                	li	s3,0
    5aa2:	bf85                	j	5a12 <vprintf+0x60>
        printptr(fd, va_arg(ap, uint64));
    5aa4:	008b0793          	addi	a5,s6,8
    5aa8:	f8f43423          	sd	a5,-120(s0)
    5aac:	000b3983          	ld	s3,0(s6)
  putc(fd, '0');
    5ab0:	03000593          	li	a1,48
    5ab4:	8556                	mv	a0,s5
    5ab6:	00000097          	auipc	ra,0x0
    5aba:	e2e080e7          	jalr	-466(ra) # 58e4 <putc>
  putc(fd, 'x');
    5abe:	07800593          	li	a1,120
    5ac2:	8556                	mv	a0,s5
    5ac4:	00000097          	auipc	ra,0x0
    5ac8:	e20080e7          	jalr	-480(ra) # 58e4 <putc>
    5acc:	896a                	mv	s2,s10
    putc(fd, digits[x >> (sizeof(uint64) * 8 - 4)]);
    5ace:	03c9d793          	srli	a5,s3,0x3c
    5ad2:	97de                	add	a5,a5,s7
    5ad4:	0007c583          	lbu	a1,0(a5)
    5ad8:	8556                	mv	a0,s5
    5ada:	00000097          	auipc	ra,0x0
    5ade:	e0a080e7          	jalr	-502(ra) # 58e4 <putc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    5ae2:	0992                	slli	s3,s3,0x4
    5ae4:	397d                	addiw	s2,s2,-1
    5ae6:	fe0914e3          	bnez	s2,5ace <vprintf+0x11c>
        printptr(fd, va_arg(ap, uint64));
    5aea:	f8843b03          	ld	s6,-120(s0)
      state = 0;
    5aee:	4981                	li	s3,0
    5af0:	b70d                	j	5a12 <vprintf+0x60>
        s = va_arg(ap, char*);
    5af2:	008b0913          	addi	s2,s6,8
    5af6:	000b3983          	ld	s3,0(s6)
        if(s == 0)
    5afa:	02098163          	beqz	s3,5b1c <vprintf+0x16a>
        while(*s != 0){
    5afe:	0009c583          	lbu	a1,0(s3)
    5b02:	c5ad                	beqz	a1,5b6c <vprintf+0x1ba>
          putc(fd, *s);
    5b04:	8556                	mv	a0,s5
    5b06:	00000097          	auipc	ra,0x0
    5b0a:	dde080e7          	jalr	-546(ra) # 58e4 <putc>
          s++;
    5b0e:	0985                	addi	s3,s3,1
        while(*s != 0){
    5b10:	0009c583          	lbu	a1,0(s3)
    5b14:	f9e5                	bnez	a1,5b04 <vprintf+0x152>
        s = va_arg(ap, char*);
    5b16:	8b4a                	mv	s6,s2
      state = 0;
    5b18:	4981                	li	s3,0
    5b1a:	bde5                	j	5a12 <vprintf+0x60>
          s = "(null)";
    5b1c:	00003997          	auipc	s3,0x3
    5b20:	a1c98993          	addi	s3,s3,-1508 # 8538 <malloc+0x28c2>
        while(*s != 0){
    5b24:	85ee                	mv	a1,s11
    5b26:	bff9                	j	5b04 <vprintf+0x152>
        putc(fd, va_arg(ap, uint));
    5b28:	008b0913          	addi	s2,s6,8
    5b2c:	000b4583          	lbu	a1,0(s6)
    5b30:	8556                	mv	a0,s5
    5b32:	00000097          	auipc	ra,0x0
    5b36:	db2080e7          	jalr	-590(ra) # 58e4 <putc>
    5b3a:	8b4a                	mv	s6,s2
      state = 0;
    5b3c:	4981                	li	s3,0
    5b3e:	bdd1                	j	5a12 <vprintf+0x60>
        putc(fd, c);
    5b40:	85d2                	mv	a1,s4
    5b42:	8556                	mv	a0,s5
    5b44:	00000097          	auipc	ra,0x0
    5b48:	da0080e7          	jalr	-608(ra) # 58e4 <putc>
      state = 0;
    5b4c:	4981                	li	s3,0
    5b4e:	b5d1                	j	5a12 <vprintf+0x60>
        putc(fd, '%');
    5b50:	85d2                	mv	a1,s4
    5b52:	8556                	mv	a0,s5
    5b54:	00000097          	auipc	ra,0x0
    5b58:	d90080e7          	jalr	-624(ra) # 58e4 <putc>
        putc(fd, c);
    5b5c:	85ca                	mv	a1,s2
    5b5e:	8556                	mv	a0,s5
    5b60:	00000097          	auipc	ra,0x0
    5b64:	d84080e7          	jalr	-636(ra) # 58e4 <putc>
      state = 0;
    5b68:	4981                	li	s3,0
    5b6a:	b565                	j	5a12 <vprintf+0x60>
        s = va_arg(ap, char*);
    5b6c:	8b4a                	mv	s6,s2
      state = 0;
    5b6e:	4981                	li	s3,0
    5b70:	b54d                	j	5a12 <vprintf+0x60>
    }
  }
}
    5b72:	70e6                	ld	ra,120(sp)
    5b74:	7446                	ld	s0,112(sp)
    5b76:	74a6                	ld	s1,104(sp)
    5b78:	7906                	ld	s2,96(sp)
    5b7a:	69e6                	ld	s3,88(sp)
    5b7c:	6a46                	ld	s4,80(sp)
    5b7e:	6aa6                	ld	s5,72(sp)
    5b80:	6b06                	ld	s6,64(sp)
    5b82:	7be2                	ld	s7,56(sp)
    5b84:	7c42                	ld	s8,48(sp)
    5b86:	7ca2                	ld	s9,40(sp)
    5b88:	7d02                	ld	s10,32(sp)
    5b8a:	6de2                	ld	s11,24(sp)
    5b8c:	6109                	addi	sp,sp,128
    5b8e:	8082                	ret

0000000000005b90 <fprintf>:

void
fprintf(int fd, const char *fmt, ...)
{
    5b90:	715d                	addi	sp,sp,-80
    5b92:	ec06                	sd	ra,24(sp)
    5b94:	e822                	sd	s0,16(sp)
    5b96:	1000                	addi	s0,sp,32
    5b98:	e010                	sd	a2,0(s0)
    5b9a:	e414                	sd	a3,8(s0)
    5b9c:	e818                	sd	a4,16(s0)
    5b9e:	ec1c                	sd	a5,24(s0)
    5ba0:	03043023          	sd	a6,32(s0)
    5ba4:	03143423          	sd	a7,40(s0)
  va_list ap;

  va_start(ap, fmt);
    5ba8:	fe843423          	sd	s0,-24(s0)
  vprintf(fd, fmt, ap);
    5bac:	8622                	mv	a2,s0
    5bae:	00000097          	auipc	ra,0x0
    5bb2:	e04080e7          	jalr	-508(ra) # 59b2 <vprintf>
}
    5bb6:	60e2                	ld	ra,24(sp)
    5bb8:	6442                	ld	s0,16(sp)
    5bba:	6161                	addi	sp,sp,80
    5bbc:	8082                	ret

0000000000005bbe <printf>:

void
printf(const char *fmt, ...)
{
    5bbe:	711d                	addi	sp,sp,-96
    5bc0:	ec06                	sd	ra,24(sp)
    5bc2:	e822                	sd	s0,16(sp)
    5bc4:	1000                	addi	s0,sp,32
    5bc6:	e40c                	sd	a1,8(s0)
    5bc8:	e810                	sd	a2,16(s0)
    5bca:	ec14                	sd	a3,24(s0)
    5bcc:	f018                	sd	a4,32(s0)
    5bce:	f41c                	sd	a5,40(s0)
    5bd0:	03043823          	sd	a6,48(s0)
    5bd4:	03143c23          	sd	a7,56(s0)
  va_list ap;

  va_start(ap, fmt);
    5bd8:	00840613          	addi	a2,s0,8
    5bdc:	fec43423          	sd	a2,-24(s0)
  vprintf(1, fmt, ap);
    5be0:	85aa                	mv	a1,a0
    5be2:	4505                	li	a0,1
    5be4:	00000097          	auipc	ra,0x0
    5be8:	dce080e7          	jalr	-562(ra) # 59b2 <vprintf>
}
    5bec:	60e2                	ld	ra,24(sp)
    5bee:	6442                	ld	s0,16(sp)
    5bf0:	6125                	addi	sp,sp,96
    5bf2:	8082                	ret

0000000000005bf4 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    5bf4:	1141                	addi	sp,sp,-16
    5bf6:	e422                	sd	s0,8(sp)
    5bf8:	0800                	addi	s0,sp,16
  Header *bp, *p;

  bp = (Header*)ap - 1;
    5bfa:	ff050693          	addi	a3,a0,-16
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5bfe:	00003797          	auipc	a5,0x3
    5c02:	9ba7b783          	ld	a5,-1606(a5) # 85b8 <freep>
    5c06:	a02d                	j	5c30 <free+0x3c>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
      break;
  if(bp + bp->s.size == p->s.ptr){
    bp->s.size += p->s.ptr->s.size;
    5c08:	4618                	lw	a4,8(a2)
    5c0a:	9f2d                	addw	a4,a4,a1
    5c0c:	fee52c23          	sw	a4,-8(a0)
    bp->s.ptr = p->s.ptr->s.ptr;
    5c10:	6398                	ld	a4,0(a5)
    5c12:	6310                	ld	a2,0(a4)
    5c14:	a83d                	j	5c52 <free+0x5e>
  } else
    bp->s.ptr = p->s.ptr;
  if(p + p->s.size == bp){
    p->s.size += bp->s.size;
    5c16:	ff852703          	lw	a4,-8(a0)
    5c1a:	9f31                	addw	a4,a4,a2
    5c1c:	c798                	sw	a4,8(a5)
    p->s.ptr = bp->s.ptr;
    5c1e:	ff053683          	ld	a3,-16(a0)
    5c22:	a091                	j	5c66 <free+0x72>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c24:	6398                	ld	a4,0(a5)
    5c26:	00e7e463          	bltu	a5,a4,5c2e <free+0x3a>
    5c2a:	00e6ea63          	bltu	a3,a4,5c3e <free+0x4a>
{
    5c2e:	87ba                	mv	a5,a4
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    5c30:	fed7fae3          	bgeu	a5,a3,5c24 <free+0x30>
    5c34:	6398                	ld	a4,0(a5)
    5c36:	00e6e463          	bltu	a3,a4,5c3e <free+0x4a>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    5c3a:	fee7eae3          	bltu	a5,a4,5c2e <free+0x3a>
  if(bp + bp->s.size == p->s.ptr){
    5c3e:	ff852583          	lw	a1,-8(a0)
    5c42:	6390                	ld	a2,0(a5)
    5c44:	02059813          	slli	a6,a1,0x20
    5c48:	01c85713          	srli	a4,a6,0x1c
    5c4c:	9736                	add	a4,a4,a3
    5c4e:	fae60de3          	beq	a2,a4,5c08 <free+0x14>
    bp->s.ptr = p->s.ptr->s.ptr;
    5c52:	fec53823          	sd	a2,-16(a0)
  if(p + p->s.size == bp){
    5c56:	4790                	lw	a2,8(a5)
    5c58:	02061593          	slli	a1,a2,0x20
    5c5c:	01c5d713          	srli	a4,a1,0x1c
    5c60:	973e                	add	a4,a4,a5
    5c62:	fae68ae3          	beq	a3,a4,5c16 <free+0x22>
    p->s.ptr = bp->s.ptr;
    5c66:	e394                	sd	a3,0(a5)
  } else
    p->s.ptr = bp;
  freep = p;
    5c68:	00003717          	auipc	a4,0x3
    5c6c:	94f73823          	sd	a5,-1712(a4) # 85b8 <freep>
}
    5c70:	6422                	ld	s0,8(sp)
    5c72:	0141                	addi	sp,sp,16
    5c74:	8082                	ret

0000000000005c76 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    5c76:	7139                	addi	sp,sp,-64
    5c78:	fc06                	sd	ra,56(sp)
    5c7a:	f822                	sd	s0,48(sp)
    5c7c:	f426                	sd	s1,40(sp)
    5c7e:	f04a                	sd	s2,32(sp)
    5c80:	ec4e                	sd	s3,24(sp)
    5c82:	e852                	sd	s4,16(sp)
    5c84:	e456                	sd	s5,8(sp)
    5c86:	e05a                	sd	s6,0(sp)
    5c88:	0080                	addi	s0,sp,64
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    5c8a:	02051493          	slli	s1,a0,0x20
    5c8e:	9081                	srli	s1,s1,0x20
    5c90:	04bd                	addi	s1,s1,15
    5c92:	8091                	srli	s1,s1,0x4
    5c94:	0014899b          	addiw	s3,s1,1
    5c98:	0485                	addi	s1,s1,1
  if((prevp = freep) == 0){
    5c9a:	00003517          	auipc	a0,0x3
    5c9e:	91e53503          	ld	a0,-1762(a0) # 85b8 <freep>
    5ca2:	c515                	beqz	a0,5cce <malloc+0x58>
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5ca4:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5ca6:	4798                	lw	a4,8(a5)
    5ca8:	02977f63          	bgeu	a4,s1,5ce6 <malloc+0x70>
    5cac:	8a4e                	mv	s4,s3
    5cae:	0009871b          	sext.w	a4,s3
    5cb2:	6685                	lui	a3,0x1
    5cb4:	00d77363          	bgeu	a4,a3,5cba <malloc+0x44>
    5cb8:	6a05                	lui	s4,0x1
    5cba:	000a0b1b          	sext.w	s6,s4
  p = sbrk(nu * sizeof(Header));
    5cbe:	004a1a1b          	slliw	s4,s4,0x4
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    5cc2:	00003917          	auipc	s2,0x3
    5cc6:	8f690913          	addi	s2,s2,-1802 # 85b8 <freep>
  if(p == (char*)-1)
    5cca:	5afd                	li	s5,-1
    5ccc:	a895                	j	5d40 <malloc+0xca>
    base.s.ptr = freep = prevp = &base;
    5cce:	00009797          	auipc	a5,0x9
    5cd2:	10a78793          	addi	a5,a5,266 # edd8 <base>
    5cd6:	00003717          	auipc	a4,0x3
    5cda:	8ef73123          	sd	a5,-1822(a4) # 85b8 <freep>
    5cde:	e39c                	sd	a5,0(a5)
    base.s.size = 0;
    5ce0:	0007a423          	sw	zero,8(a5)
    if(p->s.size >= nunits){
    5ce4:	b7e1                	j	5cac <malloc+0x36>
      if(p->s.size == nunits)
    5ce6:	02e48c63          	beq	s1,a4,5d1e <malloc+0xa8>
        p->s.size -= nunits;
    5cea:	4137073b          	subw	a4,a4,s3
    5cee:	c798                	sw	a4,8(a5)
        p += p->s.size;
    5cf0:	02071693          	slli	a3,a4,0x20
    5cf4:	01c6d713          	srli	a4,a3,0x1c
    5cf8:	97ba                	add	a5,a5,a4
        p->s.size = nunits;
    5cfa:	0137a423          	sw	s3,8(a5)
      freep = prevp;
    5cfe:	00003717          	auipc	a4,0x3
    5d02:	8aa73d23          	sd	a0,-1862(a4) # 85b8 <freep>
      return (void*)(p + 1);
    5d06:	01078513          	addi	a0,a5,16
      if((p = morecore(nunits)) == 0)
        return 0;
  }
}
    5d0a:	70e2                	ld	ra,56(sp)
    5d0c:	7442                	ld	s0,48(sp)
    5d0e:	74a2                	ld	s1,40(sp)
    5d10:	7902                	ld	s2,32(sp)
    5d12:	69e2                	ld	s3,24(sp)
    5d14:	6a42                	ld	s4,16(sp)
    5d16:	6aa2                	ld	s5,8(sp)
    5d18:	6b02                	ld	s6,0(sp)
    5d1a:	6121                	addi	sp,sp,64
    5d1c:	8082                	ret
        prevp->s.ptr = p->s.ptr;
    5d1e:	6398                	ld	a4,0(a5)
    5d20:	e118                	sd	a4,0(a0)
    5d22:	bff1                	j	5cfe <malloc+0x88>
  hp->s.size = nu;
    5d24:	01652423          	sw	s6,8(a0)
  free((void*)(hp + 1));
    5d28:	0541                	addi	a0,a0,16
    5d2a:	00000097          	auipc	ra,0x0
    5d2e:	eca080e7          	jalr	-310(ra) # 5bf4 <free>
  return freep;
    5d32:	00093503          	ld	a0,0(s2)
      if((p = morecore(nunits)) == 0)
    5d36:	d971                	beqz	a0,5d0a <malloc+0x94>
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    5d38:	611c                	ld	a5,0(a0)
    if(p->s.size >= nunits){
    5d3a:	4798                	lw	a4,8(a5)
    5d3c:	fa9775e3          	bgeu	a4,s1,5ce6 <malloc+0x70>
    if(p == freep)
    5d40:	00093703          	ld	a4,0(s2)
    5d44:	853e                	mv	a0,a5
    5d46:	fef719e3          	bne	a4,a5,5d38 <malloc+0xc2>
  p = sbrk(nu * sizeof(Header));
    5d4a:	8552                	mv	a0,s4
    5d4c:	00000097          	auipc	ra,0x0
    5d50:	b80080e7          	jalr	-1152(ra) # 58cc <sbrk>
  if(p == (char*)-1)
    5d54:	fd5518e3          	bne	a0,s5,5d24 <malloc+0xae>
        return 0;
    5d58:	4501                	li	a0,0
    5d5a:	bf45                	j	5d0a <malloc+0x94>
