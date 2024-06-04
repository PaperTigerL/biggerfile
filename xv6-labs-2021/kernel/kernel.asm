
kernel/kernel:     file format elf64-littleriscv


Disassembly of section .text:

0000000080000000 <_entry>:
    80000000:	00009117          	auipc	sp,0x9
    80000004:	9d013103          	ld	sp,-1584(sp) # 800089d0 <_GLOBAL_OFFSET_TABLE_+0x8>
    80000008:	6505                	lui	a0,0x1
    8000000a:	f14025f3          	csrr	a1,mhartid
    8000000e:	0585                	addi	a1,a1,1
    80000010:	02b50533          	mul	a0,a0,a1
    80000014:	912a                	add	sp,sp,a0
    80000016:	7ac050ef          	jal	ra,800057c2 <start>

000000008000001a <spin>:
    8000001a:	a001                	j	8000001a <spin>

000000008000001c <kfree>:
// which normally should have been returned by a
// call to kalloc().  (The exception is when
// initializing the allocator; see kinit above.)
void
kfree(void *pa)
{
    8000001c:	1101                	addi	sp,sp,-32
    8000001e:	ec06                	sd	ra,24(sp)
    80000020:	e822                	sd	s0,16(sp)
    80000022:	e426                	sd	s1,8(sp)
    80000024:	e04a                	sd	s2,0(sp)
    80000026:	1000                	addi	s0,sp,32
  struct run *r;

  if(((uint64)pa % PGSIZE) != 0 || (char*)pa < end || (uint64)pa >= PHYSTOP)
    80000028:	03451793          	slli	a5,a0,0x34
    8000002c:	ebb9                	bnez	a5,80000082 <kfree+0x66>
    8000002e:	84aa                	mv	s1,a0
    80000030:	0002d797          	auipc	a5,0x2d
    80000034:	21078793          	addi	a5,a5,528 # 8002d240 <end>
    80000038:	04f56563          	bltu	a0,a5,80000082 <kfree+0x66>
    8000003c:	47c5                	li	a5,17
    8000003e:	07ee                	slli	a5,a5,0x1b
    80000040:	04f57163          	bgeu	a0,a5,80000082 <kfree+0x66>
    panic("kfree");

  // Fill with junk to catch dangling refs.
  memset(pa, 1, PGSIZE);
    80000044:	6605                	lui	a2,0x1
    80000046:	4585                	li	a1,1
    80000048:	00000097          	auipc	ra,0x0
    8000004c:	132080e7          	jalr	306(ra) # 8000017a <memset>

  r = (struct run*)pa;

  acquire(&kmem.lock);
    80000050:	00009917          	auipc	s2,0x9
    80000054:	fe090913          	addi	s2,s2,-32 # 80009030 <kmem>
    80000058:	854a                	mv	a0,s2
    8000005a:	00006097          	auipc	ra,0x6
    8000005e:	14e080e7          	jalr	334(ra) # 800061a8 <acquire>
  r->next = kmem.freelist;
    80000062:	01893783          	ld	a5,24(s2)
    80000066:	e09c                	sd	a5,0(s1)
  kmem.freelist = r;
    80000068:	00993c23          	sd	s1,24(s2)
  release(&kmem.lock);
    8000006c:	854a                	mv	a0,s2
    8000006e:	00006097          	auipc	ra,0x6
    80000072:	1ee080e7          	jalr	494(ra) # 8000625c <release>
}
    80000076:	60e2                	ld	ra,24(sp)
    80000078:	6442                	ld	s0,16(sp)
    8000007a:	64a2                	ld	s1,8(sp)
    8000007c:	6902                	ld	s2,0(sp)
    8000007e:	6105                	addi	sp,sp,32
    80000080:	8082                	ret
    panic("kfree");
    80000082:	00008517          	auipc	a0,0x8
    80000086:	f8e50513          	addi	a0,a0,-114 # 80008010 <etext+0x10>
    8000008a:	00006097          	auipc	ra,0x6
    8000008e:	be6080e7          	jalr	-1050(ra) # 80005c70 <panic>

0000000080000092 <freerange>:
{
    80000092:	7179                	addi	sp,sp,-48
    80000094:	f406                	sd	ra,40(sp)
    80000096:	f022                	sd	s0,32(sp)
    80000098:	ec26                	sd	s1,24(sp)
    8000009a:	e84a                	sd	s2,16(sp)
    8000009c:	e44e                	sd	s3,8(sp)
    8000009e:	e052                	sd	s4,0(sp)
    800000a0:	1800                	addi	s0,sp,48
  p = (char*)PGROUNDUP((uint64)pa_start);
    800000a2:	6785                	lui	a5,0x1
    800000a4:	fff78713          	addi	a4,a5,-1 # fff <_entry-0x7ffff001>
    800000a8:	00e504b3          	add	s1,a0,a4
    800000ac:	777d                	lui	a4,0xfffff
    800000ae:	8cf9                	and	s1,s1,a4
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000b0:	94be                	add	s1,s1,a5
    800000b2:	0095ee63          	bltu	a1,s1,800000ce <freerange+0x3c>
    800000b6:	892e                	mv	s2,a1
    kfree(p);
    800000b8:	7a7d                	lui	s4,0xfffff
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000ba:	6985                	lui	s3,0x1
    kfree(p);
    800000bc:	01448533          	add	a0,s1,s4
    800000c0:	00000097          	auipc	ra,0x0
    800000c4:	f5c080e7          	jalr	-164(ra) # 8000001c <kfree>
  for(; p + PGSIZE <= (char*)pa_end; p += PGSIZE)
    800000c8:	94ce                	add	s1,s1,s3
    800000ca:	fe9979e3          	bgeu	s2,s1,800000bc <freerange+0x2a>
}
    800000ce:	70a2                	ld	ra,40(sp)
    800000d0:	7402                	ld	s0,32(sp)
    800000d2:	64e2                	ld	s1,24(sp)
    800000d4:	6942                	ld	s2,16(sp)
    800000d6:	69a2                	ld	s3,8(sp)
    800000d8:	6a02                	ld	s4,0(sp)
    800000da:	6145                	addi	sp,sp,48
    800000dc:	8082                	ret

00000000800000de <kinit>:
{
    800000de:	1141                	addi	sp,sp,-16
    800000e0:	e406                	sd	ra,8(sp)
    800000e2:	e022                	sd	s0,0(sp)
    800000e4:	0800                	addi	s0,sp,16
  initlock(&kmem.lock, "kmem");
    800000e6:	00008597          	auipc	a1,0x8
    800000ea:	f3258593          	addi	a1,a1,-206 # 80008018 <etext+0x18>
    800000ee:	00009517          	auipc	a0,0x9
    800000f2:	f4250513          	addi	a0,a0,-190 # 80009030 <kmem>
    800000f6:	00006097          	auipc	ra,0x6
    800000fa:	022080e7          	jalr	34(ra) # 80006118 <initlock>
  freerange(end, (void*)PHYSTOP);
    800000fe:	45c5                	li	a1,17
    80000100:	05ee                	slli	a1,a1,0x1b
    80000102:	0002d517          	auipc	a0,0x2d
    80000106:	13e50513          	addi	a0,a0,318 # 8002d240 <end>
    8000010a:	00000097          	auipc	ra,0x0
    8000010e:	f88080e7          	jalr	-120(ra) # 80000092 <freerange>
}
    80000112:	60a2                	ld	ra,8(sp)
    80000114:	6402                	ld	s0,0(sp)
    80000116:	0141                	addi	sp,sp,16
    80000118:	8082                	ret

000000008000011a <kalloc>:
// Allocate one 4096-byte page of physical memory.
// Returns a pointer that the kernel can use.
// Returns 0 if the memory cannot be allocated.
void *
kalloc(void)
{
    8000011a:	1101                	addi	sp,sp,-32
    8000011c:	ec06                	sd	ra,24(sp)
    8000011e:	e822                	sd	s0,16(sp)
    80000120:	e426                	sd	s1,8(sp)
    80000122:	1000                	addi	s0,sp,32
  struct run *r;

  acquire(&kmem.lock);
    80000124:	00009497          	auipc	s1,0x9
    80000128:	f0c48493          	addi	s1,s1,-244 # 80009030 <kmem>
    8000012c:	8526                	mv	a0,s1
    8000012e:	00006097          	auipc	ra,0x6
    80000132:	07a080e7          	jalr	122(ra) # 800061a8 <acquire>
  r = kmem.freelist;
    80000136:	6c84                	ld	s1,24(s1)
  if(r)
    80000138:	c885                	beqz	s1,80000168 <kalloc+0x4e>
    kmem.freelist = r->next;
    8000013a:	609c                	ld	a5,0(s1)
    8000013c:	00009517          	auipc	a0,0x9
    80000140:	ef450513          	addi	a0,a0,-268 # 80009030 <kmem>
    80000144:	ed1c                	sd	a5,24(a0)
  release(&kmem.lock);
    80000146:	00006097          	auipc	ra,0x6
    8000014a:	116080e7          	jalr	278(ra) # 8000625c <release>

  if(r)
    memset((char*)r, 5, PGSIZE); // fill with junk
    8000014e:	6605                	lui	a2,0x1
    80000150:	4595                	li	a1,5
    80000152:	8526                	mv	a0,s1
    80000154:	00000097          	auipc	ra,0x0
    80000158:	026080e7          	jalr	38(ra) # 8000017a <memset>
  return (void*)r;
}
    8000015c:	8526                	mv	a0,s1
    8000015e:	60e2                	ld	ra,24(sp)
    80000160:	6442                	ld	s0,16(sp)
    80000162:	64a2                	ld	s1,8(sp)
    80000164:	6105                	addi	sp,sp,32
    80000166:	8082                	ret
  release(&kmem.lock);
    80000168:	00009517          	auipc	a0,0x9
    8000016c:	ec850513          	addi	a0,a0,-312 # 80009030 <kmem>
    80000170:	00006097          	auipc	ra,0x6
    80000174:	0ec080e7          	jalr	236(ra) # 8000625c <release>
  if(r)
    80000178:	b7d5                	j	8000015c <kalloc+0x42>

000000008000017a <memset>:
#include "types.h"
#include "fs.h"
void*
memset(void *dst, int c, uint n)
{
    8000017a:	1141                	addi	sp,sp,-16
    8000017c:	e422                	sd	s0,8(sp)
    8000017e:	0800                	addi	s0,sp,16
  char *cdst = (char *) dst;
  int i;
  for(i = 0; i < n; i++){
    80000180:	ca19                	beqz	a2,80000196 <memset+0x1c>
    80000182:	87aa                	mv	a5,a0
    80000184:	1602                	slli	a2,a2,0x20
    80000186:	9201                	srli	a2,a2,0x20
    80000188:	00a60733          	add	a4,a2,a0
    cdst[i] = c;
    8000018c:	00b78023          	sb	a1,0(a5)
  for(i = 0; i < n; i++){
    80000190:	0785                	addi	a5,a5,1
    80000192:	fee79de3          	bne	a5,a4,8000018c <memset+0x12>
  }
  return dst;
}
    80000196:	6422                	ld	s0,8(sp)
    80000198:	0141                	addi	sp,sp,16
    8000019a:	8082                	ret

000000008000019c <memcmp>:

int
memcmp(const void *v1, const void *v2, uint n)
{
    8000019c:	1141                	addi	sp,sp,-16
    8000019e:	e422                	sd	s0,8(sp)
    800001a0:	0800                	addi	s0,sp,16
  const uchar *s1, *s2;

  s1 = v1;
  s2 = v2;
  while(n-- > 0){
    800001a2:	ca05                	beqz	a2,800001d2 <memcmp+0x36>
    800001a4:	fff6069b          	addiw	a3,a2,-1 # fff <_entry-0x7ffff001>
    800001a8:	1682                	slli	a3,a3,0x20
    800001aa:	9281                	srli	a3,a3,0x20
    800001ac:	0685                	addi	a3,a3,1
    800001ae:	96aa                	add	a3,a3,a0
    if(*s1 != *s2)
    800001b0:	00054783          	lbu	a5,0(a0)
    800001b4:	0005c703          	lbu	a4,0(a1)
    800001b8:	00e79863          	bne	a5,a4,800001c8 <memcmp+0x2c>
      return *s1 - *s2;
    s1++, s2++;
    800001bc:	0505                	addi	a0,a0,1
    800001be:	0585                	addi	a1,a1,1
  while(n-- > 0){
    800001c0:	fed518e3          	bne	a0,a3,800001b0 <memcmp+0x14>
  }

  return 0;
    800001c4:	4501                	li	a0,0
    800001c6:	a019                	j	800001cc <memcmp+0x30>
      return *s1 - *s2;
    800001c8:	40e7853b          	subw	a0,a5,a4
}
    800001cc:	6422                	ld	s0,8(sp)
    800001ce:	0141                	addi	sp,sp,16
    800001d0:	8082                	ret
  return 0;
    800001d2:	4501                	li	a0,0
    800001d4:	bfe5                	j	800001cc <memcmp+0x30>

00000000800001d6 <memmove>:

void*
memmove(void *dst, const void *src, uint n)
{
    800001d6:	1141                	addi	sp,sp,-16
    800001d8:	e422                	sd	s0,8(sp)
    800001da:	0800                	addi	s0,sp,16
  const char *s = (const char *)src;
  char *d = (char *)dst;
  if (n == 0) {
    800001dc:	c205                	beqz	a2,800001fc <memmove+0x26>
    return dst;
  }
  if (s < d && (const char *)s + n > d) {
    800001de:	02a5e263          	bltu	a1,a0,80000202 <memmove+0x2c>
    d += n;
    while (n-- > 0) {
      *--d = *--s;
    }
  } else {
    while (n-- > 0) {
    800001e2:	1602                	slli	a2,a2,0x20
    800001e4:	9201                	srli	a2,a2,0x20
    800001e6:	00c587b3          	add	a5,a1,a2
{
    800001ea:	872a                	mv	a4,a0
      *d++ = *s++;
    800001ec:	0585                	addi	a1,a1,1
    800001ee:	0705                	addi	a4,a4,1 # fffffffffffff001 <end+0xffffffff7ffd1dc1>
    800001f0:	fff5c683          	lbu	a3,-1(a1)
    800001f4:	fed70fa3          	sb	a3,-1(a4)
    while (n-- > 0) {
    800001f8:	fef59ae3          	bne	a1,a5,800001ec <memmove+0x16>
    }
  }

  return dst;
}
    800001fc:	6422                	ld	s0,8(sp)
    800001fe:	0141                	addi	sp,sp,16
    80000200:	8082                	ret
  if (s < d && (const char *)s + n > d) {
    80000202:	02061693          	slli	a3,a2,0x20
    80000206:	9281                	srli	a3,a3,0x20
    80000208:	00d58733          	add	a4,a1,a3
    8000020c:	fce57be3          	bgeu	a0,a4,800001e2 <memmove+0xc>
    d += n;
    80000210:	96aa                	add	a3,a3,a0
    while (n-- > 0) {
    80000212:	fff6079b          	addiw	a5,a2,-1
    80000216:	1782                	slli	a5,a5,0x20
    80000218:	9381                	srli	a5,a5,0x20
    8000021a:	fff7c793          	not	a5,a5
    8000021e:	97ba                	add	a5,a5,a4
      *--d = *--s;
    80000220:	177d                	addi	a4,a4,-1
    80000222:	16fd                	addi	a3,a3,-1
    80000224:	00074603          	lbu	a2,0(a4)
    80000228:	00c68023          	sb	a2,0(a3)
    while (n-- > 0) {
    8000022c:	fee79ae3          	bne	a5,a4,80000220 <memmove+0x4a>
    80000230:	b7f1                	j	800001fc <memmove+0x26>

0000000080000232 <memcpy>:
// memcpy exists to placate GCC.  Use memmove.
void*
memcpy(void *dst, const void *src, uint n)
{
    80000232:	1141                	addi	sp,sp,-16
    80000234:	e406                	sd	ra,8(sp)
    80000236:	e022                	sd	s0,0(sp)
    80000238:	0800                	addi	s0,sp,16
  return memmove(dst, src, n);
    8000023a:	00000097          	auipc	ra,0x0
    8000023e:	f9c080e7          	jalr	-100(ra) # 800001d6 <memmove>
}
    80000242:	60a2                	ld	ra,8(sp)
    80000244:	6402                	ld	s0,0(sp)
    80000246:	0141                	addi	sp,sp,16
    80000248:	8082                	ret

000000008000024a <strncmp>:

int
strncmp(const char *p, const char *q, uint n)
{
    8000024a:	1141                	addi	sp,sp,-16
    8000024c:	e422                	sd	s0,8(sp)
    8000024e:	0800                	addi	s0,sp,16
  while(n > 0 && *p && *p == *q)
    80000250:	ce11                	beqz	a2,8000026c <strncmp+0x22>
    80000252:	00054783          	lbu	a5,0(a0)
    80000256:	cf89                	beqz	a5,80000270 <strncmp+0x26>
    80000258:	0005c703          	lbu	a4,0(a1)
    8000025c:	00f71a63          	bne	a4,a5,80000270 <strncmp+0x26>
    n--, p++, q++;
    80000260:	367d                	addiw	a2,a2,-1
    80000262:	0505                	addi	a0,a0,1
    80000264:	0585                	addi	a1,a1,1
  while(n > 0 && *p && *p == *q)
    80000266:	f675                	bnez	a2,80000252 <strncmp+0x8>
  if(n == 0)
    return 0;
    80000268:	4501                	li	a0,0
    8000026a:	a809                	j	8000027c <strncmp+0x32>
    8000026c:	4501                	li	a0,0
    8000026e:	a039                	j	8000027c <strncmp+0x32>
  if(n == 0)
    80000270:	ca09                	beqz	a2,80000282 <strncmp+0x38>
  return (uchar)*p - (uchar)*q;
    80000272:	00054503          	lbu	a0,0(a0)
    80000276:	0005c783          	lbu	a5,0(a1)
    8000027a:	9d1d                	subw	a0,a0,a5
}
    8000027c:	6422                	ld	s0,8(sp)
    8000027e:	0141                	addi	sp,sp,16
    80000280:	8082                	ret
    return 0;
    80000282:	4501                	li	a0,0
    80000284:	bfe5                	j	8000027c <strncmp+0x32>

0000000080000286 <strncpy>:

char*
strncpy(char *s, const char *t, int n)
{
    80000286:	1141                	addi	sp,sp,-16
    80000288:	e422                	sd	s0,8(sp)
    8000028a:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  while(n-- > 0 && (*s++ = *t++) != 0)
    8000028c:	872a                	mv	a4,a0
    8000028e:	8832                	mv	a6,a2
    80000290:	367d                	addiw	a2,a2,-1
    80000292:	01005963          	blez	a6,800002a4 <strncpy+0x1e>
    80000296:	0705                	addi	a4,a4,1
    80000298:	0005c783          	lbu	a5,0(a1)
    8000029c:	fef70fa3          	sb	a5,-1(a4)
    800002a0:	0585                	addi	a1,a1,1
    800002a2:	f7f5                	bnez	a5,8000028e <strncpy+0x8>
    ;
  while(n-- > 0)
    800002a4:	86ba                	mv	a3,a4
    800002a6:	00c05c63          	blez	a2,800002be <strncpy+0x38>
    *s++ = 0;
    800002aa:	0685                	addi	a3,a3,1
    800002ac:	fe068fa3          	sb	zero,-1(a3)
  while(n-- > 0)
    800002b0:	40d707bb          	subw	a5,a4,a3
    800002b4:	37fd                	addiw	a5,a5,-1
    800002b6:	010787bb          	addw	a5,a5,a6
    800002ba:	fef048e3          	bgtz	a5,800002aa <strncpy+0x24>
  return os;
}
    800002be:	6422                	ld	s0,8(sp)
    800002c0:	0141                	addi	sp,sp,16
    800002c2:	8082                	ret

00000000800002c4 <safestrcpy>:

// Like strncpy but guaranteed to NUL-terminate.
char*
safestrcpy(char *s, const char *t, int n)
{
    800002c4:	1141                	addi	sp,sp,-16
    800002c6:	e422                	sd	s0,8(sp)
    800002c8:	0800                	addi	s0,sp,16
  char *os;

  os = s;
  if(n <= 0)
    800002ca:	02c05363          	blez	a2,800002f0 <safestrcpy+0x2c>
    800002ce:	fff6069b          	addiw	a3,a2,-1
    800002d2:	1682                	slli	a3,a3,0x20
    800002d4:	9281                	srli	a3,a3,0x20
    800002d6:	96ae                	add	a3,a3,a1
    800002d8:	87aa                	mv	a5,a0
    return os;
  while(--n > 0 && (*s++ = *t++) != 0)
    800002da:	00d58963          	beq	a1,a3,800002ec <safestrcpy+0x28>
    800002de:	0585                	addi	a1,a1,1
    800002e0:	0785                	addi	a5,a5,1
    800002e2:	fff5c703          	lbu	a4,-1(a1)
    800002e6:	fee78fa3          	sb	a4,-1(a5)
    800002ea:	fb65                	bnez	a4,800002da <safestrcpy+0x16>
    ;
  *s = 0;
    800002ec:	00078023          	sb	zero,0(a5)
  return os;
}
    800002f0:	6422                	ld	s0,8(sp)
    800002f2:	0141                	addi	sp,sp,16
    800002f4:	8082                	ret

00000000800002f6 <strlen>:

int
strlen(const char *s)
{
    800002f6:	1141                	addi	sp,sp,-16
    800002f8:	e422                	sd	s0,8(sp)
    800002fa:	0800                	addi	s0,sp,16
  int n;

  for(n = 0; s[n]; n++)
    800002fc:	00054783          	lbu	a5,0(a0)
    80000300:	cf91                	beqz	a5,8000031c <strlen+0x26>
    80000302:	0505                	addi	a0,a0,1
    80000304:	87aa                	mv	a5,a0
    80000306:	4685                	li	a3,1
    80000308:	9e89                	subw	a3,a3,a0
    8000030a:	00f6853b          	addw	a0,a3,a5
    8000030e:	0785                	addi	a5,a5,1
    80000310:	fff7c703          	lbu	a4,-1(a5)
    80000314:	fb7d                	bnez	a4,8000030a <strlen+0x14>
    ;
  return n;
}
    80000316:	6422                	ld	s0,8(sp)
    80000318:	0141                	addi	sp,sp,16
    8000031a:	8082                	ret
  for(n = 0; s[n]; n++)
    8000031c:	4501                	li	a0,0
    8000031e:	bfe5                	j	80000316 <strlen+0x20>

0000000080000320 <main>:
volatile static int started = 0;

// start() jumps here in supervisor mode on all CPUs.
void
main()
{
    80000320:	1141                	addi	sp,sp,-16
    80000322:	e406                	sd	ra,8(sp)
    80000324:	e022                	sd	s0,0(sp)
    80000326:	0800                	addi	s0,sp,16
  if(cpuid() == 0){
    80000328:	00001097          	auipc	ra,0x1
    8000032c:	af0080e7          	jalr	-1296(ra) # 80000e18 <cpuid>
    virtio_disk_init(); // emulated hard disk
    userinit();      // first user process
    __sync_synchronize();
    started = 1;
  } else {
    while(started == 0)
    80000330:	00009717          	auipc	a4,0x9
    80000334:	cd070713          	addi	a4,a4,-816 # 80009000 <started>
  if(cpuid() == 0){
    80000338:	c139                	beqz	a0,8000037e <main+0x5e>
    while(started == 0)
    8000033a:	431c                	lw	a5,0(a4)
    8000033c:	2781                	sext.w	a5,a5
    8000033e:	dff5                	beqz	a5,8000033a <main+0x1a>
      ;
    __sync_synchronize();
    80000340:	0ff0000f          	fence
    printf("hart %d starting\n", cpuid());
    80000344:	00001097          	auipc	ra,0x1
    80000348:	ad4080e7          	jalr	-1324(ra) # 80000e18 <cpuid>
    8000034c:	85aa                	mv	a1,a0
    8000034e:	00008517          	auipc	a0,0x8
    80000352:	cea50513          	addi	a0,a0,-790 # 80008038 <etext+0x38>
    80000356:	00006097          	auipc	ra,0x6
    8000035a:	964080e7          	jalr	-1692(ra) # 80005cba <printf>
    kvminithart();    // turn on paging
    8000035e:	00000097          	auipc	ra,0x0
    80000362:	0d8080e7          	jalr	216(ra) # 80000436 <kvminithart>
    trapinithart();   // install kernel trap vector
    80000366:	00001097          	auipc	ra,0x1
    8000036a:	734080e7          	jalr	1844(ra) # 80001a9a <trapinithart>
    plicinithart();   // ask PLIC for device interrupts
    8000036e:	00005097          	auipc	ra,0x5
    80000372:	e32080e7          	jalr	-462(ra) # 800051a0 <plicinithart>
  }

  scheduler();        
    80000376:	00001097          	auipc	ra,0x1
    8000037a:	fe0080e7          	jalr	-32(ra) # 80001356 <scheduler>
    consoleinit();
    8000037e:	00006097          	auipc	ra,0x6
    80000382:	802080e7          	jalr	-2046(ra) # 80005b80 <consoleinit>
    printfinit();
    80000386:	00006097          	auipc	ra,0x6
    8000038a:	b14080e7          	jalr	-1260(ra) # 80005e9a <printfinit>
    printf("\n");
    8000038e:	00008517          	auipc	a0,0x8
    80000392:	40a50513          	addi	a0,a0,1034 # 80008798 <syscalls+0x3d0>
    80000396:	00006097          	auipc	ra,0x6
    8000039a:	924080e7          	jalr	-1756(ra) # 80005cba <printf>
    printf("xv6 kernel is booting\n");
    8000039e:	00008517          	auipc	a0,0x8
    800003a2:	c8250513          	addi	a0,a0,-894 # 80008020 <etext+0x20>
    800003a6:	00006097          	auipc	ra,0x6
    800003aa:	914080e7          	jalr	-1772(ra) # 80005cba <printf>
    printf("\n");
    800003ae:	00008517          	auipc	a0,0x8
    800003b2:	3ea50513          	addi	a0,a0,1002 # 80008798 <syscalls+0x3d0>
    800003b6:	00006097          	auipc	ra,0x6
    800003ba:	904080e7          	jalr	-1788(ra) # 80005cba <printf>
    kinit();         // physical page allocator
    800003be:	00000097          	auipc	ra,0x0
    800003c2:	d20080e7          	jalr	-736(ra) # 800000de <kinit>
    kvminit();       // create kernel page table
    800003c6:	00000097          	auipc	ra,0x0
    800003ca:	322080e7          	jalr	802(ra) # 800006e8 <kvminit>
    kvminithart();   // turn on paging
    800003ce:	00000097          	auipc	ra,0x0
    800003d2:	068080e7          	jalr	104(ra) # 80000436 <kvminithart>
    procinit();      // process table
    800003d6:	00001097          	auipc	ra,0x1
    800003da:	992080e7          	jalr	-1646(ra) # 80000d68 <procinit>
    trapinit();      // trap vectors
    800003de:	00001097          	auipc	ra,0x1
    800003e2:	694080e7          	jalr	1684(ra) # 80001a72 <trapinit>
    trapinithart();  // install kernel trap vector
    800003e6:	00001097          	auipc	ra,0x1
    800003ea:	6b4080e7          	jalr	1716(ra) # 80001a9a <trapinithart>
    plicinit();      // set up interrupt controller
    800003ee:	00005097          	auipc	ra,0x5
    800003f2:	d9c080e7          	jalr	-612(ra) # 8000518a <plicinit>
    plicinithart();  // ask PLIC for device interrupts
    800003f6:	00005097          	auipc	ra,0x5
    800003fa:	daa080e7          	jalr	-598(ra) # 800051a0 <plicinithart>
    binit();         // buffer cache
    800003fe:	00002097          	auipc	ra,0x2
    80000402:	dde080e7          	jalr	-546(ra) # 800021dc <binit>
    iinit();         // inode table
    80000406:	00002097          	auipc	ra,0x2
    8000040a:	536080e7          	jalr	1334(ra) # 8000293c <iinit>
    fileinit();      // file table
    8000040e:	00003097          	auipc	ra,0x3
    80000412:	56c080e7          	jalr	1388(ra) # 8000397a <fileinit>
    virtio_disk_init(); // emulated hard disk
    80000416:	00005097          	auipc	ra,0x5
    8000041a:	eaa080e7          	jalr	-342(ra) # 800052c0 <virtio_disk_init>
    userinit();      // first user process
    8000041e:	00001097          	auipc	ra,0x1
    80000422:	cfe080e7          	jalr	-770(ra) # 8000111c <userinit>
    __sync_synchronize();
    80000426:	0ff0000f          	fence
    started = 1;
    8000042a:	4785                	li	a5,1
    8000042c:	00009717          	auipc	a4,0x9
    80000430:	bcf72a23          	sw	a5,-1068(a4) # 80009000 <started>
    80000434:	b789                	j	80000376 <main+0x56>

0000000080000436 <kvminithart>:

// Switch h/w page table register to the kernel's page table,
// and enable paging.
void
kvminithart()
{
    80000436:	1141                	addi	sp,sp,-16
    80000438:	e422                	sd	s0,8(sp)
    8000043a:	0800                	addi	s0,sp,16
  w_satp(MAKE_SATP(kernel_pagetable));
    8000043c:	00009797          	auipc	a5,0x9
    80000440:	bcc7b783          	ld	a5,-1076(a5) # 80009008 <kernel_pagetable>
    80000444:	83b1                	srli	a5,a5,0xc
    80000446:	577d                	li	a4,-1
    80000448:	177e                	slli	a4,a4,0x3f
    8000044a:	8fd9                	or	a5,a5,a4
// supervisor address translation and protection;
// holds the address of the page table.
static inline void 
w_satp(uint64 x)
{
  asm volatile("csrw satp, %0" : : "r" (x));
    8000044c:	18079073          	csrw	satp,a5
// flush the TLB.
static inline void
sfence_vma()
{
  // the zero, zero means flush all TLB entries.
  asm volatile("sfence.vma zero, zero");
    80000450:	12000073          	sfence.vma
  sfence_vma();
}
    80000454:	6422                	ld	s0,8(sp)
    80000456:	0141                	addi	sp,sp,16
    80000458:	8082                	ret

000000008000045a <walk>:
//   21..29 -- 9 bits of level-1 index.
//   12..20 -- 9 bits of level-0 index.
//    0..11 -- 12 bits of byte offset within the page.
pte_t *
walk(pagetable_t pagetable, uint64 va, int alloc)
{
    8000045a:	7139                	addi	sp,sp,-64
    8000045c:	fc06                	sd	ra,56(sp)
    8000045e:	f822                	sd	s0,48(sp)
    80000460:	f426                	sd	s1,40(sp)
    80000462:	f04a                	sd	s2,32(sp)
    80000464:	ec4e                	sd	s3,24(sp)
    80000466:	e852                	sd	s4,16(sp)
    80000468:	e456                	sd	s5,8(sp)
    8000046a:	e05a                	sd	s6,0(sp)
    8000046c:	0080                	addi	s0,sp,64
    8000046e:	84aa                	mv	s1,a0
    80000470:	89ae                	mv	s3,a1
    80000472:	8ab2                	mv	s5,a2
  if(va >= MAXVA)
    80000474:	57fd                	li	a5,-1
    80000476:	83e9                	srli	a5,a5,0x1a
    80000478:	4a79                	li	s4,30
    panic("walk");

  for(int level = 2; level > 0; level--) {
    8000047a:	4b31                	li	s6,12
  if(va >= MAXVA)
    8000047c:	04b7f263          	bgeu	a5,a1,800004c0 <walk+0x66>
    panic("walk");
    80000480:	00008517          	auipc	a0,0x8
    80000484:	bd050513          	addi	a0,a0,-1072 # 80008050 <etext+0x50>
    80000488:	00005097          	auipc	ra,0x5
    8000048c:	7e8080e7          	jalr	2024(ra) # 80005c70 <panic>
    pte_t *pte = &pagetable[PX(level, va)];
    if(*pte & PTE_V) {
      pagetable = (pagetable_t)PTE2PA(*pte);
    } else {
      if(!alloc || (pagetable = (pde_t*)kalloc()) == 0)
    80000490:	060a8663          	beqz	s5,800004fc <walk+0xa2>
    80000494:	00000097          	auipc	ra,0x0
    80000498:	c86080e7          	jalr	-890(ra) # 8000011a <kalloc>
    8000049c:	84aa                	mv	s1,a0
    8000049e:	c529                	beqz	a0,800004e8 <walk+0x8e>
        return 0;
      memset(pagetable, 0, PGSIZE);
    800004a0:	6605                	lui	a2,0x1
    800004a2:	4581                	li	a1,0
    800004a4:	00000097          	auipc	ra,0x0
    800004a8:	cd6080e7          	jalr	-810(ra) # 8000017a <memset>
      *pte = PA2PTE(pagetable) | PTE_V;
    800004ac:	00c4d793          	srli	a5,s1,0xc
    800004b0:	07aa                	slli	a5,a5,0xa
    800004b2:	0017e793          	ori	a5,a5,1
    800004b6:	00f93023          	sd	a5,0(s2)
  for(int level = 2; level > 0; level--) {
    800004ba:	3a5d                	addiw	s4,s4,-9 # ffffffffffffeff7 <end+0xffffffff7ffd1db7>
    800004bc:	036a0063          	beq	s4,s6,800004dc <walk+0x82>
    pte_t *pte = &pagetable[PX(level, va)];
    800004c0:	0149d933          	srl	s2,s3,s4
    800004c4:	1ff97913          	andi	s2,s2,511
    800004c8:	090e                	slli	s2,s2,0x3
    800004ca:	9926                	add	s2,s2,s1
    if(*pte & PTE_V) {
    800004cc:	00093483          	ld	s1,0(s2)
    800004d0:	0014f793          	andi	a5,s1,1
    800004d4:	dfd5                	beqz	a5,80000490 <walk+0x36>
      pagetable = (pagetable_t)PTE2PA(*pte);
    800004d6:	80a9                	srli	s1,s1,0xa
    800004d8:	04b2                	slli	s1,s1,0xc
    800004da:	b7c5                	j	800004ba <walk+0x60>
    }
  }
  return &pagetable[PX(0, va)];
    800004dc:	00c9d513          	srli	a0,s3,0xc
    800004e0:	1ff57513          	andi	a0,a0,511
    800004e4:	050e                	slli	a0,a0,0x3
    800004e6:	9526                	add	a0,a0,s1
}
    800004e8:	70e2                	ld	ra,56(sp)
    800004ea:	7442                	ld	s0,48(sp)
    800004ec:	74a2                	ld	s1,40(sp)
    800004ee:	7902                	ld	s2,32(sp)
    800004f0:	69e2                	ld	s3,24(sp)
    800004f2:	6a42                	ld	s4,16(sp)
    800004f4:	6aa2                	ld	s5,8(sp)
    800004f6:	6b02                	ld	s6,0(sp)
    800004f8:	6121                	addi	sp,sp,64
    800004fa:	8082                	ret
        return 0;
    800004fc:	4501                	li	a0,0
    800004fe:	b7ed                	j	800004e8 <walk+0x8e>

0000000080000500 <walkaddr>:
walkaddr(pagetable_t pagetable, uint64 va)
{
  pte_t *pte;
  uint64 pa;

  if(va >= MAXVA)
    80000500:	57fd                	li	a5,-1
    80000502:	83e9                	srli	a5,a5,0x1a
    80000504:	00b7f463          	bgeu	a5,a1,8000050c <walkaddr+0xc>
    return 0;
    80000508:	4501                	li	a0,0
    return 0;
  if((*pte & PTE_U) == 0)
    return 0;
  pa = PTE2PA(*pte);
  return pa;
}
    8000050a:	8082                	ret
{
    8000050c:	1141                	addi	sp,sp,-16
    8000050e:	e406                	sd	ra,8(sp)
    80000510:	e022                	sd	s0,0(sp)
    80000512:	0800                	addi	s0,sp,16
  pte = walk(pagetable, va, 0);
    80000514:	4601                	li	a2,0
    80000516:	00000097          	auipc	ra,0x0
    8000051a:	f44080e7          	jalr	-188(ra) # 8000045a <walk>
  if(pte == 0)
    8000051e:	c105                	beqz	a0,8000053e <walkaddr+0x3e>
  if((*pte & PTE_V) == 0)
    80000520:	611c                	ld	a5,0(a0)
  if((*pte & PTE_U) == 0)
    80000522:	0117f693          	andi	a3,a5,17
    80000526:	4745                	li	a4,17
    return 0;
    80000528:	4501                	li	a0,0
  if((*pte & PTE_U) == 0)
    8000052a:	00e68663          	beq	a3,a4,80000536 <walkaddr+0x36>
}
    8000052e:	60a2                	ld	ra,8(sp)
    80000530:	6402                	ld	s0,0(sp)
    80000532:	0141                	addi	sp,sp,16
    80000534:	8082                	ret
  pa = PTE2PA(*pte);
    80000536:	83a9                	srli	a5,a5,0xa
    80000538:	00c79513          	slli	a0,a5,0xc
  return pa;
    8000053c:	bfcd                	j	8000052e <walkaddr+0x2e>
    return 0;
    8000053e:	4501                	li	a0,0
    80000540:	b7fd                	j	8000052e <walkaddr+0x2e>

0000000080000542 <mappages>:
// physical addresses starting at pa. va and size might not
// be page-aligned. Returns 0 on success, -1 if walk() couldn't
// allocate a needed page-table page.
int
mappages(pagetable_t pagetable, uint64 va, uint64 size, uint64 pa, int perm)
{
    80000542:	715d                	addi	sp,sp,-80
    80000544:	e486                	sd	ra,72(sp)
    80000546:	e0a2                	sd	s0,64(sp)
    80000548:	fc26                	sd	s1,56(sp)
    8000054a:	f84a                	sd	s2,48(sp)
    8000054c:	f44e                	sd	s3,40(sp)
    8000054e:	f052                	sd	s4,32(sp)
    80000550:	ec56                	sd	s5,24(sp)
    80000552:	e85a                	sd	s6,16(sp)
    80000554:	e45e                	sd	s7,8(sp)
    80000556:	0880                	addi	s0,sp,80
  uint64 a, last;
  pte_t *pte;

  if(size == 0)
    80000558:	c639                	beqz	a2,800005a6 <mappages+0x64>
    8000055a:	8aaa                	mv	s5,a0
    8000055c:	8b3a                	mv	s6,a4
    panic("mappages: size");
  
  a = PGROUNDDOWN(va);
    8000055e:	777d                	lui	a4,0xfffff
    80000560:	00e5f7b3          	and	a5,a1,a4
  last = PGROUNDDOWN(va + size - 1);
    80000564:	fff58993          	addi	s3,a1,-1
    80000568:	99b2                	add	s3,s3,a2
    8000056a:	00e9f9b3          	and	s3,s3,a4
  a = PGROUNDDOWN(va);
    8000056e:	893e                	mv	s2,a5
    80000570:	40f68a33          	sub	s4,a3,a5
    if(*pte & PTE_V)
      panic("mappages: remap");
    *pte = PA2PTE(pa) | perm | PTE_V;
    if(a == last)
      break;
    a += PGSIZE;
    80000574:	6b85                	lui	s7,0x1
    80000576:	012a04b3          	add	s1,s4,s2
    if((pte = walk(pagetable, a, 1)) == 0)
    8000057a:	4605                	li	a2,1
    8000057c:	85ca                	mv	a1,s2
    8000057e:	8556                	mv	a0,s5
    80000580:	00000097          	auipc	ra,0x0
    80000584:	eda080e7          	jalr	-294(ra) # 8000045a <walk>
    80000588:	cd1d                	beqz	a0,800005c6 <mappages+0x84>
    if(*pte & PTE_V)
    8000058a:	611c                	ld	a5,0(a0)
    8000058c:	8b85                	andi	a5,a5,1
    8000058e:	e785                	bnez	a5,800005b6 <mappages+0x74>
    *pte = PA2PTE(pa) | perm | PTE_V;
    80000590:	80b1                	srli	s1,s1,0xc
    80000592:	04aa                	slli	s1,s1,0xa
    80000594:	0164e4b3          	or	s1,s1,s6
    80000598:	0014e493          	ori	s1,s1,1
    8000059c:	e104                	sd	s1,0(a0)
    if(a == last)
    8000059e:	05390063          	beq	s2,s3,800005de <mappages+0x9c>
    a += PGSIZE;
    800005a2:	995e                	add	s2,s2,s7
    if((pte = walk(pagetable, a, 1)) == 0)
    800005a4:	bfc9                	j	80000576 <mappages+0x34>
    panic("mappages: size");
    800005a6:	00008517          	auipc	a0,0x8
    800005aa:	ab250513          	addi	a0,a0,-1358 # 80008058 <etext+0x58>
    800005ae:	00005097          	auipc	ra,0x5
    800005b2:	6c2080e7          	jalr	1730(ra) # 80005c70 <panic>
      panic("mappages: remap");
    800005b6:	00008517          	auipc	a0,0x8
    800005ba:	ab250513          	addi	a0,a0,-1358 # 80008068 <etext+0x68>
    800005be:	00005097          	auipc	ra,0x5
    800005c2:	6b2080e7          	jalr	1714(ra) # 80005c70 <panic>
      return -1;
    800005c6:	557d                	li	a0,-1
    pa += PGSIZE;
  }
  return 0;
}
    800005c8:	60a6                	ld	ra,72(sp)
    800005ca:	6406                	ld	s0,64(sp)
    800005cc:	74e2                	ld	s1,56(sp)
    800005ce:	7942                	ld	s2,48(sp)
    800005d0:	79a2                	ld	s3,40(sp)
    800005d2:	7a02                	ld	s4,32(sp)
    800005d4:	6ae2                	ld	s5,24(sp)
    800005d6:	6b42                	ld	s6,16(sp)
    800005d8:	6ba2                	ld	s7,8(sp)
    800005da:	6161                	addi	sp,sp,80
    800005dc:	8082                	ret
  return 0;
    800005de:	4501                	li	a0,0
    800005e0:	b7e5                	j	800005c8 <mappages+0x86>

00000000800005e2 <kvmmap>:
{
    800005e2:	1141                	addi	sp,sp,-16
    800005e4:	e406                	sd	ra,8(sp)
    800005e6:	e022                	sd	s0,0(sp)
    800005e8:	0800                	addi	s0,sp,16
    800005ea:	87b6                	mv	a5,a3
  if(mappages(kpgtbl, va, sz, pa, perm) != 0)
    800005ec:	86b2                	mv	a3,a2
    800005ee:	863e                	mv	a2,a5
    800005f0:	00000097          	auipc	ra,0x0
    800005f4:	f52080e7          	jalr	-174(ra) # 80000542 <mappages>
    800005f8:	e509                	bnez	a0,80000602 <kvmmap+0x20>
}
    800005fa:	60a2                	ld	ra,8(sp)
    800005fc:	6402                	ld	s0,0(sp)
    800005fe:	0141                	addi	sp,sp,16
    80000600:	8082                	ret
    panic("kvmmap");
    80000602:	00008517          	auipc	a0,0x8
    80000606:	a7650513          	addi	a0,a0,-1418 # 80008078 <etext+0x78>
    8000060a:	00005097          	auipc	ra,0x5
    8000060e:	666080e7          	jalr	1638(ra) # 80005c70 <panic>

0000000080000612 <kvmmake>:
{
    80000612:	1101                	addi	sp,sp,-32
    80000614:	ec06                	sd	ra,24(sp)
    80000616:	e822                	sd	s0,16(sp)
    80000618:	e426                	sd	s1,8(sp)
    8000061a:	e04a                	sd	s2,0(sp)
    8000061c:	1000                	addi	s0,sp,32
  kpgtbl = (pagetable_t) kalloc();
    8000061e:	00000097          	auipc	ra,0x0
    80000622:	afc080e7          	jalr	-1284(ra) # 8000011a <kalloc>
    80000626:	84aa                	mv	s1,a0
  memset(kpgtbl, 0, PGSIZE);
    80000628:	6605                	lui	a2,0x1
    8000062a:	4581                	li	a1,0
    8000062c:	00000097          	auipc	ra,0x0
    80000630:	b4e080e7          	jalr	-1202(ra) # 8000017a <memset>
  kvmmap(kpgtbl, UART0, UART0, PGSIZE, PTE_R | PTE_W);
    80000634:	4719                	li	a4,6
    80000636:	6685                	lui	a3,0x1
    80000638:	10000637          	lui	a2,0x10000
    8000063c:	100005b7          	lui	a1,0x10000
    80000640:	8526                	mv	a0,s1
    80000642:	00000097          	auipc	ra,0x0
    80000646:	fa0080e7          	jalr	-96(ra) # 800005e2 <kvmmap>
  kvmmap(kpgtbl, VIRTIO0, VIRTIO0, PGSIZE, PTE_R | PTE_W);
    8000064a:	4719                	li	a4,6
    8000064c:	6685                	lui	a3,0x1
    8000064e:	10001637          	lui	a2,0x10001
    80000652:	100015b7          	lui	a1,0x10001
    80000656:	8526                	mv	a0,s1
    80000658:	00000097          	auipc	ra,0x0
    8000065c:	f8a080e7          	jalr	-118(ra) # 800005e2 <kvmmap>
  kvmmap(kpgtbl, PLIC, PLIC, 0x400000, PTE_R | PTE_W);
    80000660:	4719                	li	a4,6
    80000662:	004006b7          	lui	a3,0x400
    80000666:	0c000637          	lui	a2,0xc000
    8000066a:	0c0005b7          	lui	a1,0xc000
    8000066e:	8526                	mv	a0,s1
    80000670:	00000097          	auipc	ra,0x0
    80000674:	f72080e7          	jalr	-142(ra) # 800005e2 <kvmmap>
  kvmmap(kpgtbl, KERNBASE, KERNBASE, (uint64)etext-KERNBASE, PTE_R | PTE_X);
    80000678:	00008917          	auipc	s2,0x8
    8000067c:	98890913          	addi	s2,s2,-1656 # 80008000 <etext>
    80000680:	4729                	li	a4,10
    80000682:	80008697          	auipc	a3,0x80008
    80000686:	97e68693          	addi	a3,a3,-1666 # 8000 <_entry-0x7fff8000>
    8000068a:	4605                	li	a2,1
    8000068c:	067e                	slli	a2,a2,0x1f
    8000068e:	85b2                	mv	a1,a2
    80000690:	8526                	mv	a0,s1
    80000692:	00000097          	auipc	ra,0x0
    80000696:	f50080e7          	jalr	-176(ra) # 800005e2 <kvmmap>
  kvmmap(kpgtbl, (uint64)etext, (uint64)etext, PHYSTOP-(uint64)etext, PTE_R | PTE_W);
    8000069a:	4719                	li	a4,6
    8000069c:	46c5                	li	a3,17
    8000069e:	06ee                	slli	a3,a3,0x1b
    800006a0:	412686b3          	sub	a3,a3,s2
    800006a4:	864a                	mv	a2,s2
    800006a6:	85ca                	mv	a1,s2
    800006a8:	8526                	mv	a0,s1
    800006aa:	00000097          	auipc	ra,0x0
    800006ae:	f38080e7          	jalr	-200(ra) # 800005e2 <kvmmap>
  kvmmap(kpgtbl, TRAMPOLINE, (uint64)trampoline, PGSIZE, PTE_R | PTE_X);
    800006b2:	4729                	li	a4,10
    800006b4:	6685                	lui	a3,0x1
    800006b6:	00007617          	auipc	a2,0x7
    800006ba:	94a60613          	addi	a2,a2,-1718 # 80007000 <_trampoline>
    800006be:	040005b7          	lui	a1,0x4000
    800006c2:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    800006c4:	05b2                	slli	a1,a1,0xc
    800006c6:	8526                	mv	a0,s1
    800006c8:	00000097          	auipc	ra,0x0
    800006cc:	f1a080e7          	jalr	-230(ra) # 800005e2 <kvmmap>
  proc_mapstacks(kpgtbl);
    800006d0:	8526                	mv	a0,s1
    800006d2:	00000097          	auipc	ra,0x0
    800006d6:	600080e7          	jalr	1536(ra) # 80000cd2 <proc_mapstacks>
}
    800006da:	8526                	mv	a0,s1
    800006dc:	60e2                	ld	ra,24(sp)
    800006de:	6442                	ld	s0,16(sp)
    800006e0:	64a2                	ld	s1,8(sp)
    800006e2:	6902                	ld	s2,0(sp)
    800006e4:	6105                	addi	sp,sp,32
    800006e6:	8082                	ret

00000000800006e8 <kvminit>:
{
    800006e8:	1141                	addi	sp,sp,-16
    800006ea:	e406                	sd	ra,8(sp)
    800006ec:	e022                	sd	s0,0(sp)
    800006ee:	0800                	addi	s0,sp,16
  kernel_pagetable = kvmmake();
    800006f0:	00000097          	auipc	ra,0x0
    800006f4:	f22080e7          	jalr	-222(ra) # 80000612 <kvmmake>
    800006f8:	00009797          	auipc	a5,0x9
    800006fc:	90a7b823          	sd	a0,-1776(a5) # 80009008 <kernel_pagetable>
}
    80000700:	60a2                	ld	ra,8(sp)
    80000702:	6402                	ld	s0,0(sp)
    80000704:	0141                	addi	sp,sp,16
    80000706:	8082                	ret

0000000080000708 <uvmunmap>:
// Remove npages of mappings starting from va. va must be
// page-aligned. The mappings must exist.
// Optionally free the physical memory.
void
uvmunmap(pagetable_t pagetable, uint64 va, uint64 npages, int do_free)
{
    80000708:	715d                	addi	sp,sp,-80
    8000070a:	e486                	sd	ra,72(sp)
    8000070c:	e0a2                	sd	s0,64(sp)
    8000070e:	fc26                	sd	s1,56(sp)
    80000710:	f84a                	sd	s2,48(sp)
    80000712:	f44e                	sd	s3,40(sp)
    80000714:	f052                	sd	s4,32(sp)
    80000716:	ec56                	sd	s5,24(sp)
    80000718:	e85a                	sd	s6,16(sp)
    8000071a:	e45e                	sd	s7,8(sp)
    8000071c:	0880                	addi	s0,sp,80
  uint64 a;
  pte_t *pte;

  if((va % PGSIZE) != 0)
    8000071e:	03459793          	slli	a5,a1,0x34
    80000722:	e795                	bnez	a5,8000074e <uvmunmap+0x46>
    80000724:	8a2a                	mv	s4,a0
    80000726:	892e                	mv	s2,a1
    80000728:	8ab6                	mv	s5,a3
    panic("uvmunmap: not aligned");

  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    8000072a:	0632                	slli	a2,a2,0xc
    8000072c:	00b609b3          	add	s3,a2,a1
    if((pte = walk(pagetable, a, 0)) == 0)
      panic("uvmunmap: walk");
    if((*pte & PTE_V) == 0)
      panic("uvmunmap: not mapped");
    if(PTE_FLAGS(*pte) == PTE_V)
    80000730:	4b85                	li	s7,1
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000732:	6b05                	lui	s6,0x1
    80000734:	0735e263          	bltu	a1,s3,80000798 <uvmunmap+0x90>
      uint64 pa = PTE2PA(*pte);
      kfree((void*)pa);
    }
    *pte = 0;
  }
}
    80000738:	60a6                	ld	ra,72(sp)
    8000073a:	6406                	ld	s0,64(sp)
    8000073c:	74e2                	ld	s1,56(sp)
    8000073e:	7942                	ld	s2,48(sp)
    80000740:	79a2                	ld	s3,40(sp)
    80000742:	7a02                	ld	s4,32(sp)
    80000744:	6ae2                	ld	s5,24(sp)
    80000746:	6b42                	ld	s6,16(sp)
    80000748:	6ba2                	ld	s7,8(sp)
    8000074a:	6161                	addi	sp,sp,80
    8000074c:	8082                	ret
    panic("uvmunmap: not aligned");
    8000074e:	00008517          	auipc	a0,0x8
    80000752:	93250513          	addi	a0,a0,-1742 # 80008080 <etext+0x80>
    80000756:	00005097          	auipc	ra,0x5
    8000075a:	51a080e7          	jalr	1306(ra) # 80005c70 <panic>
      panic("uvmunmap: walk");
    8000075e:	00008517          	auipc	a0,0x8
    80000762:	93a50513          	addi	a0,a0,-1734 # 80008098 <etext+0x98>
    80000766:	00005097          	auipc	ra,0x5
    8000076a:	50a080e7          	jalr	1290(ra) # 80005c70 <panic>
      panic("uvmunmap: not mapped");
    8000076e:	00008517          	auipc	a0,0x8
    80000772:	93a50513          	addi	a0,a0,-1734 # 800080a8 <etext+0xa8>
    80000776:	00005097          	auipc	ra,0x5
    8000077a:	4fa080e7          	jalr	1274(ra) # 80005c70 <panic>
      panic("uvmunmap: not a leaf");
    8000077e:	00008517          	auipc	a0,0x8
    80000782:	94250513          	addi	a0,a0,-1726 # 800080c0 <etext+0xc0>
    80000786:	00005097          	auipc	ra,0x5
    8000078a:	4ea080e7          	jalr	1258(ra) # 80005c70 <panic>
    *pte = 0;
    8000078e:	0004b023          	sd	zero,0(s1)
  for(a = va; a < va + npages*PGSIZE; a += PGSIZE){
    80000792:	995a                	add	s2,s2,s6
    80000794:	fb3972e3          	bgeu	s2,s3,80000738 <uvmunmap+0x30>
    if((pte = walk(pagetable, a, 0)) == 0)
    80000798:	4601                	li	a2,0
    8000079a:	85ca                	mv	a1,s2
    8000079c:	8552                	mv	a0,s4
    8000079e:	00000097          	auipc	ra,0x0
    800007a2:	cbc080e7          	jalr	-836(ra) # 8000045a <walk>
    800007a6:	84aa                	mv	s1,a0
    800007a8:	d95d                	beqz	a0,8000075e <uvmunmap+0x56>
    if((*pte & PTE_V) == 0)
    800007aa:	6108                	ld	a0,0(a0)
    800007ac:	00157793          	andi	a5,a0,1
    800007b0:	dfdd                	beqz	a5,8000076e <uvmunmap+0x66>
    if(PTE_FLAGS(*pte) == PTE_V)
    800007b2:	3ff57793          	andi	a5,a0,1023
    800007b6:	fd7784e3          	beq	a5,s7,8000077e <uvmunmap+0x76>
    if(do_free){
    800007ba:	fc0a8ae3          	beqz	s5,8000078e <uvmunmap+0x86>
      uint64 pa = PTE2PA(*pte);
    800007be:	8129                	srli	a0,a0,0xa
      kfree((void*)pa);
    800007c0:	0532                	slli	a0,a0,0xc
    800007c2:	00000097          	auipc	ra,0x0
    800007c6:	85a080e7          	jalr	-1958(ra) # 8000001c <kfree>
    800007ca:	b7d1                	j	8000078e <uvmunmap+0x86>

00000000800007cc <uvmcreate>:

// create an empty user page table.
// returns 0 if out of memory.
pagetable_t
uvmcreate()
{
    800007cc:	1101                	addi	sp,sp,-32
    800007ce:	ec06                	sd	ra,24(sp)
    800007d0:	e822                	sd	s0,16(sp)
    800007d2:	e426                	sd	s1,8(sp)
    800007d4:	1000                	addi	s0,sp,32
  pagetable_t pagetable;
  pagetable = (pagetable_t) kalloc();
    800007d6:	00000097          	auipc	ra,0x0
    800007da:	944080e7          	jalr	-1724(ra) # 8000011a <kalloc>
    800007de:	84aa                	mv	s1,a0
  if(pagetable == 0)
    800007e0:	c519                	beqz	a0,800007ee <uvmcreate+0x22>
    return 0;
  memset(pagetable, 0, PGSIZE);
    800007e2:	6605                	lui	a2,0x1
    800007e4:	4581                	li	a1,0
    800007e6:	00000097          	auipc	ra,0x0
    800007ea:	994080e7          	jalr	-1644(ra) # 8000017a <memset>
  return pagetable;
}
    800007ee:	8526                	mv	a0,s1
    800007f0:	60e2                	ld	ra,24(sp)
    800007f2:	6442                	ld	s0,16(sp)
    800007f4:	64a2                	ld	s1,8(sp)
    800007f6:	6105                	addi	sp,sp,32
    800007f8:	8082                	ret

00000000800007fa <uvminit>:
// Load the user initcode into address 0 of pagetable,
// for the very first process.
// sz must be less than a page.
void
uvminit(pagetable_t pagetable, uchar *src, uint sz)
{
    800007fa:	7179                	addi	sp,sp,-48
    800007fc:	f406                	sd	ra,40(sp)
    800007fe:	f022                	sd	s0,32(sp)
    80000800:	ec26                	sd	s1,24(sp)
    80000802:	e84a                	sd	s2,16(sp)
    80000804:	e44e                	sd	s3,8(sp)
    80000806:	e052                	sd	s4,0(sp)
    80000808:	1800                	addi	s0,sp,48
  char *mem;

  if(sz >= PGSIZE)
    8000080a:	6785                	lui	a5,0x1
    8000080c:	04f67863          	bgeu	a2,a5,8000085c <uvminit+0x62>
    80000810:	8a2a                	mv	s4,a0
    80000812:	89ae                	mv	s3,a1
    80000814:	84b2                	mv	s1,a2
    panic("inituvm: more than a page");
  mem = kalloc();
    80000816:	00000097          	auipc	ra,0x0
    8000081a:	904080e7          	jalr	-1788(ra) # 8000011a <kalloc>
    8000081e:	892a                	mv	s2,a0
  memset(mem, 0, PGSIZE);
    80000820:	6605                	lui	a2,0x1
    80000822:	4581                	li	a1,0
    80000824:	00000097          	auipc	ra,0x0
    80000828:	956080e7          	jalr	-1706(ra) # 8000017a <memset>
  mappages(pagetable, 0, PGSIZE, (uint64)mem, PTE_W|PTE_R|PTE_X|PTE_U);
    8000082c:	4779                	li	a4,30
    8000082e:	86ca                	mv	a3,s2
    80000830:	6605                	lui	a2,0x1
    80000832:	4581                	li	a1,0
    80000834:	8552                	mv	a0,s4
    80000836:	00000097          	auipc	ra,0x0
    8000083a:	d0c080e7          	jalr	-756(ra) # 80000542 <mappages>
  memmove(mem, src, sz);
    8000083e:	8626                	mv	a2,s1
    80000840:	85ce                	mv	a1,s3
    80000842:	854a                	mv	a0,s2
    80000844:	00000097          	auipc	ra,0x0
    80000848:	992080e7          	jalr	-1646(ra) # 800001d6 <memmove>
}
    8000084c:	70a2                	ld	ra,40(sp)
    8000084e:	7402                	ld	s0,32(sp)
    80000850:	64e2                	ld	s1,24(sp)
    80000852:	6942                	ld	s2,16(sp)
    80000854:	69a2                	ld	s3,8(sp)
    80000856:	6a02                	ld	s4,0(sp)
    80000858:	6145                	addi	sp,sp,48
    8000085a:	8082                	ret
    panic("inituvm: more than a page");
    8000085c:	00008517          	auipc	a0,0x8
    80000860:	87c50513          	addi	a0,a0,-1924 # 800080d8 <etext+0xd8>
    80000864:	00005097          	auipc	ra,0x5
    80000868:	40c080e7          	jalr	1036(ra) # 80005c70 <panic>

000000008000086c <uvmdealloc>:
// newsz.  oldsz and newsz need not be page-aligned, nor does newsz
// need to be less than oldsz.  oldsz can be larger than the actual
// process size.  Returns the new process size.
uint64
uvmdealloc(pagetable_t pagetable, uint64 oldsz, uint64 newsz)
{
    8000086c:	1101                	addi	sp,sp,-32
    8000086e:	ec06                	sd	ra,24(sp)
    80000870:	e822                	sd	s0,16(sp)
    80000872:	e426                	sd	s1,8(sp)
    80000874:	1000                	addi	s0,sp,32
  if(newsz >= oldsz)
    return oldsz;
    80000876:	84ae                	mv	s1,a1
  if(newsz >= oldsz)
    80000878:	00b67d63          	bgeu	a2,a1,80000892 <uvmdealloc+0x26>
    8000087c:	84b2                	mv	s1,a2

  if(PGROUNDUP(newsz) < PGROUNDUP(oldsz)){
    8000087e:	6785                	lui	a5,0x1
    80000880:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    80000882:	00f60733          	add	a4,a2,a5
    80000886:	76fd                	lui	a3,0xfffff
    80000888:	8f75                	and	a4,a4,a3
    8000088a:	97ae                	add	a5,a5,a1
    8000088c:	8ff5                	and	a5,a5,a3
    8000088e:	00f76863          	bltu	a4,a5,8000089e <uvmdealloc+0x32>
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
  }

  return newsz;
}
    80000892:	8526                	mv	a0,s1
    80000894:	60e2                	ld	ra,24(sp)
    80000896:	6442                	ld	s0,16(sp)
    80000898:	64a2                	ld	s1,8(sp)
    8000089a:	6105                	addi	sp,sp,32
    8000089c:	8082                	ret
    int npages = (PGROUNDUP(oldsz) - PGROUNDUP(newsz)) / PGSIZE;
    8000089e:	8f99                	sub	a5,a5,a4
    800008a0:	83b1                	srli	a5,a5,0xc
    uvmunmap(pagetable, PGROUNDUP(newsz), npages, 1);
    800008a2:	4685                	li	a3,1
    800008a4:	0007861b          	sext.w	a2,a5
    800008a8:	85ba                	mv	a1,a4
    800008aa:	00000097          	auipc	ra,0x0
    800008ae:	e5e080e7          	jalr	-418(ra) # 80000708 <uvmunmap>
    800008b2:	b7c5                	j	80000892 <uvmdealloc+0x26>

00000000800008b4 <uvmalloc>:
  if(newsz < oldsz)
    800008b4:	0ab66163          	bltu	a2,a1,80000956 <uvmalloc+0xa2>
{
    800008b8:	7139                	addi	sp,sp,-64
    800008ba:	fc06                	sd	ra,56(sp)
    800008bc:	f822                	sd	s0,48(sp)
    800008be:	f426                	sd	s1,40(sp)
    800008c0:	f04a                	sd	s2,32(sp)
    800008c2:	ec4e                	sd	s3,24(sp)
    800008c4:	e852                	sd	s4,16(sp)
    800008c6:	e456                	sd	s5,8(sp)
    800008c8:	0080                	addi	s0,sp,64
    800008ca:	8aaa                	mv	s5,a0
    800008cc:	8a32                	mv	s4,a2
  oldsz = PGROUNDUP(oldsz);
    800008ce:	6785                	lui	a5,0x1
    800008d0:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800008d2:	95be                	add	a1,a1,a5
    800008d4:	77fd                	lui	a5,0xfffff
    800008d6:	00f5f9b3          	and	s3,a1,a5
  for(a = oldsz; a < newsz; a += PGSIZE){
    800008da:	08c9f063          	bgeu	s3,a2,8000095a <uvmalloc+0xa6>
    800008de:	894e                	mv	s2,s3
    mem = kalloc();
    800008e0:	00000097          	auipc	ra,0x0
    800008e4:	83a080e7          	jalr	-1990(ra) # 8000011a <kalloc>
    800008e8:	84aa                	mv	s1,a0
    if(mem == 0){
    800008ea:	c51d                	beqz	a0,80000918 <uvmalloc+0x64>
    memset(mem, 0, PGSIZE);
    800008ec:	6605                	lui	a2,0x1
    800008ee:	4581                	li	a1,0
    800008f0:	00000097          	auipc	ra,0x0
    800008f4:	88a080e7          	jalr	-1910(ra) # 8000017a <memset>
    if(mappages(pagetable, a, PGSIZE, (uint64)mem, PTE_W|PTE_X|PTE_R|PTE_U) != 0){
    800008f8:	4779                	li	a4,30
    800008fa:	86a6                	mv	a3,s1
    800008fc:	6605                	lui	a2,0x1
    800008fe:	85ca                	mv	a1,s2
    80000900:	8556                	mv	a0,s5
    80000902:	00000097          	auipc	ra,0x0
    80000906:	c40080e7          	jalr	-960(ra) # 80000542 <mappages>
    8000090a:	e905                	bnez	a0,8000093a <uvmalloc+0x86>
  for(a = oldsz; a < newsz; a += PGSIZE){
    8000090c:	6785                	lui	a5,0x1
    8000090e:	993e                	add	s2,s2,a5
    80000910:	fd4968e3          	bltu	s2,s4,800008e0 <uvmalloc+0x2c>
  return newsz;
    80000914:	8552                	mv	a0,s4
    80000916:	a809                	j	80000928 <uvmalloc+0x74>
      uvmdealloc(pagetable, a, oldsz);
    80000918:	864e                	mv	a2,s3
    8000091a:	85ca                	mv	a1,s2
    8000091c:	8556                	mv	a0,s5
    8000091e:	00000097          	auipc	ra,0x0
    80000922:	f4e080e7          	jalr	-178(ra) # 8000086c <uvmdealloc>
      return 0;
    80000926:	4501                	li	a0,0
}
    80000928:	70e2                	ld	ra,56(sp)
    8000092a:	7442                	ld	s0,48(sp)
    8000092c:	74a2                	ld	s1,40(sp)
    8000092e:	7902                	ld	s2,32(sp)
    80000930:	69e2                	ld	s3,24(sp)
    80000932:	6a42                	ld	s4,16(sp)
    80000934:	6aa2                	ld	s5,8(sp)
    80000936:	6121                	addi	sp,sp,64
    80000938:	8082                	ret
      kfree(mem);
    8000093a:	8526                	mv	a0,s1
    8000093c:	fffff097          	auipc	ra,0xfffff
    80000940:	6e0080e7          	jalr	1760(ra) # 8000001c <kfree>
      uvmdealloc(pagetable, a, oldsz);
    80000944:	864e                	mv	a2,s3
    80000946:	85ca                	mv	a1,s2
    80000948:	8556                	mv	a0,s5
    8000094a:	00000097          	auipc	ra,0x0
    8000094e:	f22080e7          	jalr	-222(ra) # 8000086c <uvmdealloc>
      return 0;
    80000952:	4501                	li	a0,0
    80000954:	bfd1                	j	80000928 <uvmalloc+0x74>
    return oldsz;
    80000956:	852e                	mv	a0,a1
}
    80000958:	8082                	ret
  return newsz;
    8000095a:	8532                	mv	a0,a2
    8000095c:	b7f1                	j	80000928 <uvmalloc+0x74>

000000008000095e <freewalk>:

// Recursively free page-table pages.
// All leaf mappings must already have been removed.
void
freewalk(pagetable_t pagetable)
{
    8000095e:	7179                	addi	sp,sp,-48
    80000960:	f406                	sd	ra,40(sp)
    80000962:	f022                	sd	s0,32(sp)
    80000964:	ec26                	sd	s1,24(sp)
    80000966:	e84a                	sd	s2,16(sp)
    80000968:	e44e                	sd	s3,8(sp)
    8000096a:	e052                	sd	s4,0(sp)
    8000096c:	1800                	addi	s0,sp,48
    8000096e:	8a2a                	mv	s4,a0
  // there are 2^9 = 512 PTEs in a page table.
  for(int i = 0; i < 512; i++){
    80000970:	84aa                	mv	s1,a0
    80000972:	6905                	lui	s2,0x1
    80000974:	992a                	add	s2,s2,a0
    pte_t pte = pagetable[i];
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000976:	4985                	li	s3,1
    80000978:	a829                	j	80000992 <freewalk+0x34>
      // this PTE points to a lower-level page table.
      uint64 child = PTE2PA(pte);
    8000097a:	83a9                	srli	a5,a5,0xa
      freewalk((pagetable_t)child);
    8000097c:	00c79513          	slli	a0,a5,0xc
    80000980:	00000097          	auipc	ra,0x0
    80000984:	fde080e7          	jalr	-34(ra) # 8000095e <freewalk>
      pagetable[i] = 0;
    80000988:	0004b023          	sd	zero,0(s1)
  for(int i = 0; i < 512; i++){
    8000098c:	04a1                	addi	s1,s1,8
    8000098e:	03248163          	beq	s1,s2,800009b0 <freewalk+0x52>
    pte_t pte = pagetable[i];
    80000992:	609c                	ld	a5,0(s1)
    if((pte & PTE_V) && (pte & (PTE_R|PTE_W|PTE_X)) == 0){
    80000994:	00f7f713          	andi	a4,a5,15
    80000998:	ff3701e3          	beq	a4,s3,8000097a <freewalk+0x1c>
    } else if(pte & PTE_V){
    8000099c:	8b85                	andi	a5,a5,1
    8000099e:	d7fd                	beqz	a5,8000098c <freewalk+0x2e>
      panic("freewalk: leaf");
    800009a0:	00007517          	auipc	a0,0x7
    800009a4:	75850513          	addi	a0,a0,1880 # 800080f8 <etext+0xf8>
    800009a8:	00005097          	auipc	ra,0x5
    800009ac:	2c8080e7          	jalr	712(ra) # 80005c70 <panic>
    }
  }
  kfree((void*)pagetable);
    800009b0:	8552                	mv	a0,s4
    800009b2:	fffff097          	auipc	ra,0xfffff
    800009b6:	66a080e7          	jalr	1642(ra) # 8000001c <kfree>
}
    800009ba:	70a2                	ld	ra,40(sp)
    800009bc:	7402                	ld	s0,32(sp)
    800009be:	64e2                	ld	s1,24(sp)
    800009c0:	6942                	ld	s2,16(sp)
    800009c2:	69a2                	ld	s3,8(sp)
    800009c4:	6a02                	ld	s4,0(sp)
    800009c6:	6145                	addi	sp,sp,48
    800009c8:	8082                	ret

00000000800009ca <uvmfree>:

// Free user memory pages,
// then free page-table pages.
void
uvmfree(pagetable_t pagetable, uint64 sz)
{
    800009ca:	1101                	addi	sp,sp,-32
    800009cc:	ec06                	sd	ra,24(sp)
    800009ce:	e822                	sd	s0,16(sp)
    800009d0:	e426                	sd	s1,8(sp)
    800009d2:	1000                	addi	s0,sp,32
    800009d4:	84aa                	mv	s1,a0
  if(sz > 0)
    800009d6:	e999                	bnez	a1,800009ec <uvmfree+0x22>
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
  freewalk(pagetable);
    800009d8:	8526                	mv	a0,s1
    800009da:	00000097          	auipc	ra,0x0
    800009de:	f84080e7          	jalr	-124(ra) # 8000095e <freewalk>
}
    800009e2:	60e2                	ld	ra,24(sp)
    800009e4:	6442                	ld	s0,16(sp)
    800009e6:	64a2                	ld	s1,8(sp)
    800009e8:	6105                	addi	sp,sp,32
    800009ea:	8082                	ret
    uvmunmap(pagetable, 0, PGROUNDUP(sz)/PGSIZE, 1);
    800009ec:	6785                	lui	a5,0x1
    800009ee:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    800009f0:	95be                	add	a1,a1,a5
    800009f2:	4685                	li	a3,1
    800009f4:	00c5d613          	srli	a2,a1,0xc
    800009f8:	4581                	li	a1,0
    800009fa:	00000097          	auipc	ra,0x0
    800009fe:	d0e080e7          	jalr	-754(ra) # 80000708 <uvmunmap>
    80000a02:	bfd9                	j	800009d8 <uvmfree+0xe>

0000000080000a04 <uvmcopy>:
  pte_t *pte;
  uint64 pa, i;
  uint flags;
  char *mem;

  for(i = 0; i < sz; i += PGSIZE){
    80000a04:	c679                	beqz	a2,80000ad2 <uvmcopy+0xce>
{
    80000a06:	715d                	addi	sp,sp,-80
    80000a08:	e486                	sd	ra,72(sp)
    80000a0a:	e0a2                	sd	s0,64(sp)
    80000a0c:	fc26                	sd	s1,56(sp)
    80000a0e:	f84a                	sd	s2,48(sp)
    80000a10:	f44e                	sd	s3,40(sp)
    80000a12:	f052                	sd	s4,32(sp)
    80000a14:	ec56                	sd	s5,24(sp)
    80000a16:	e85a                	sd	s6,16(sp)
    80000a18:	e45e                	sd	s7,8(sp)
    80000a1a:	0880                	addi	s0,sp,80
    80000a1c:	8b2a                	mv	s6,a0
    80000a1e:	8aae                	mv	s5,a1
    80000a20:	8a32                	mv	s4,a2
  for(i = 0; i < sz; i += PGSIZE){
    80000a22:	4981                	li	s3,0
    if((pte = walk(old, i, 0)) == 0)
    80000a24:	4601                	li	a2,0
    80000a26:	85ce                	mv	a1,s3
    80000a28:	855a                	mv	a0,s6
    80000a2a:	00000097          	auipc	ra,0x0
    80000a2e:	a30080e7          	jalr	-1488(ra) # 8000045a <walk>
    80000a32:	c531                	beqz	a0,80000a7e <uvmcopy+0x7a>
      panic("uvmcopy: pte should exist");
    if((*pte & PTE_V) == 0)
    80000a34:	6118                	ld	a4,0(a0)
    80000a36:	00177793          	andi	a5,a4,1
    80000a3a:	cbb1                	beqz	a5,80000a8e <uvmcopy+0x8a>
      panic("uvmcopy: page not present");
    pa = PTE2PA(*pte);
    80000a3c:	00a75593          	srli	a1,a4,0xa
    80000a40:	00c59b93          	slli	s7,a1,0xc
    flags = PTE_FLAGS(*pte);
    80000a44:	3ff77493          	andi	s1,a4,1023
    if((mem = kalloc()) == 0)
    80000a48:	fffff097          	auipc	ra,0xfffff
    80000a4c:	6d2080e7          	jalr	1746(ra) # 8000011a <kalloc>
    80000a50:	892a                	mv	s2,a0
    80000a52:	c939                	beqz	a0,80000aa8 <uvmcopy+0xa4>
      goto err;
    memmove(mem, (char*)pa, PGSIZE);
    80000a54:	6605                	lui	a2,0x1
    80000a56:	85de                	mv	a1,s7
    80000a58:	fffff097          	auipc	ra,0xfffff
    80000a5c:	77e080e7          	jalr	1918(ra) # 800001d6 <memmove>
    if(mappages(new, i, PGSIZE, (uint64)mem, flags) != 0){
    80000a60:	8726                	mv	a4,s1
    80000a62:	86ca                	mv	a3,s2
    80000a64:	6605                	lui	a2,0x1
    80000a66:	85ce                	mv	a1,s3
    80000a68:	8556                	mv	a0,s5
    80000a6a:	00000097          	auipc	ra,0x0
    80000a6e:	ad8080e7          	jalr	-1320(ra) # 80000542 <mappages>
    80000a72:	e515                	bnez	a0,80000a9e <uvmcopy+0x9a>
  for(i = 0; i < sz; i += PGSIZE){
    80000a74:	6785                	lui	a5,0x1
    80000a76:	99be                	add	s3,s3,a5
    80000a78:	fb49e6e3          	bltu	s3,s4,80000a24 <uvmcopy+0x20>
    80000a7c:	a081                	j	80000abc <uvmcopy+0xb8>
      panic("uvmcopy: pte should exist");
    80000a7e:	00007517          	auipc	a0,0x7
    80000a82:	68a50513          	addi	a0,a0,1674 # 80008108 <etext+0x108>
    80000a86:	00005097          	auipc	ra,0x5
    80000a8a:	1ea080e7          	jalr	490(ra) # 80005c70 <panic>
      panic("uvmcopy: page not present");
    80000a8e:	00007517          	auipc	a0,0x7
    80000a92:	69a50513          	addi	a0,a0,1690 # 80008128 <etext+0x128>
    80000a96:	00005097          	auipc	ra,0x5
    80000a9a:	1da080e7          	jalr	474(ra) # 80005c70 <panic>
      kfree(mem);
    80000a9e:	854a                	mv	a0,s2
    80000aa0:	fffff097          	auipc	ra,0xfffff
    80000aa4:	57c080e7          	jalr	1404(ra) # 8000001c <kfree>
    }
  }
  return 0;

 err:
  uvmunmap(new, 0, i / PGSIZE, 1);
    80000aa8:	4685                	li	a3,1
    80000aaa:	00c9d613          	srli	a2,s3,0xc
    80000aae:	4581                	li	a1,0
    80000ab0:	8556                	mv	a0,s5
    80000ab2:	00000097          	auipc	ra,0x0
    80000ab6:	c56080e7          	jalr	-938(ra) # 80000708 <uvmunmap>
  return -1;
    80000aba:	557d                	li	a0,-1
}
    80000abc:	60a6                	ld	ra,72(sp)
    80000abe:	6406                	ld	s0,64(sp)
    80000ac0:	74e2                	ld	s1,56(sp)
    80000ac2:	7942                	ld	s2,48(sp)
    80000ac4:	79a2                	ld	s3,40(sp)
    80000ac6:	7a02                	ld	s4,32(sp)
    80000ac8:	6ae2                	ld	s5,24(sp)
    80000aca:	6b42                	ld	s6,16(sp)
    80000acc:	6ba2                	ld	s7,8(sp)
    80000ace:	6161                	addi	sp,sp,80
    80000ad0:	8082                	ret
  return 0;
    80000ad2:	4501                	li	a0,0
}
    80000ad4:	8082                	ret

0000000080000ad6 <uvmclear>:

// mark a PTE invalid for user access.
// used by exec for the user stack guard page.
void
uvmclear(pagetable_t pagetable, uint64 va)
{
    80000ad6:	1141                	addi	sp,sp,-16
    80000ad8:	e406                	sd	ra,8(sp)
    80000ada:	e022                	sd	s0,0(sp)
    80000adc:	0800                	addi	s0,sp,16
  pte_t *pte;
  
  pte = walk(pagetable, va, 0);
    80000ade:	4601                	li	a2,0
    80000ae0:	00000097          	auipc	ra,0x0
    80000ae4:	97a080e7          	jalr	-1670(ra) # 8000045a <walk>
  if(pte == 0)
    80000ae8:	c901                	beqz	a0,80000af8 <uvmclear+0x22>
    panic("uvmclear");
  *pte &= ~PTE_U;
    80000aea:	611c                	ld	a5,0(a0)
    80000aec:	9bbd                	andi	a5,a5,-17
    80000aee:	e11c                	sd	a5,0(a0)
}
    80000af0:	60a2                	ld	ra,8(sp)
    80000af2:	6402                	ld	s0,0(sp)
    80000af4:	0141                	addi	sp,sp,16
    80000af6:	8082                	ret
    panic("uvmclear");
    80000af8:	00007517          	auipc	a0,0x7
    80000afc:	65050513          	addi	a0,a0,1616 # 80008148 <etext+0x148>
    80000b00:	00005097          	auipc	ra,0x5
    80000b04:	170080e7          	jalr	368(ra) # 80005c70 <panic>

0000000080000b08 <copyout>:
int
copyout(pagetable_t pagetable, uint64 dstva, char *src, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b08:	c6bd                	beqz	a3,80000b76 <copyout+0x6e>
{
    80000b0a:	715d                	addi	sp,sp,-80
    80000b0c:	e486                	sd	ra,72(sp)
    80000b0e:	e0a2                	sd	s0,64(sp)
    80000b10:	fc26                	sd	s1,56(sp)
    80000b12:	f84a                	sd	s2,48(sp)
    80000b14:	f44e                	sd	s3,40(sp)
    80000b16:	f052                	sd	s4,32(sp)
    80000b18:	ec56                	sd	s5,24(sp)
    80000b1a:	e85a                	sd	s6,16(sp)
    80000b1c:	e45e                	sd	s7,8(sp)
    80000b1e:	e062                	sd	s8,0(sp)
    80000b20:	0880                	addi	s0,sp,80
    80000b22:	8b2a                	mv	s6,a0
    80000b24:	8c2e                	mv	s8,a1
    80000b26:	8a32                	mv	s4,a2
    80000b28:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(dstva);
    80000b2a:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (dstva - va0);
    80000b2c:	6a85                	lui	s5,0x1
    80000b2e:	a015                	j	80000b52 <copyout+0x4a>
    if(n > len)
      n = len;
    memmove((void *)(pa0 + (dstva - va0)), src, n);
    80000b30:	9562                	add	a0,a0,s8
    80000b32:	0004861b          	sext.w	a2,s1
    80000b36:	85d2                	mv	a1,s4
    80000b38:	41250533          	sub	a0,a0,s2
    80000b3c:	fffff097          	auipc	ra,0xfffff
    80000b40:	69a080e7          	jalr	1690(ra) # 800001d6 <memmove>

    len -= n;
    80000b44:	409989b3          	sub	s3,s3,s1
    src += n;
    80000b48:	9a26                	add	s4,s4,s1
    dstva = va0 + PGSIZE;
    80000b4a:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000b4e:	02098263          	beqz	s3,80000b72 <copyout+0x6a>
    va0 = PGROUNDDOWN(dstva);
    80000b52:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000b56:	85ca                	mv	a1,s2
    80000b58:	855a                	mv	a0,s6
    80000b5a:	00000097          	auipc	ra,0x0
    80000b5e:	9a6080e7          	jalr	-1626(ra) # 80000500 <walkaddr>
    if(pa0 == 0)
    80000b62:	cd01                	beqz	a0,80000b7a <copyout+0x72>
    n = PGSIZE - (dstva - va0);
    80000b64:	418904b3          	sub	s1,s2,s8
    80000b68:	94d6                	add	s1,s1,s5
    80000b6a:	fc99f3e3          	bgeu	s3,s1,80000b30 <copyout+0x28>
    80000b6e:	84ce                	mv	s1,s3
    80000b70:	b7c1                	j	80000b30 <copyout+0x28>
  }
  return 0;
    80000b72:	4501                	li	a0,0
    80000b74:	a021                	j	80000b7c <copyout+0x74>
    80000b76:	4501                	li	a0,0
}
    80000b78:	8082                	ret
      return -1;
    80000b7a:	557d                	li	a0,-1
}
    80000b7c:	60a6                	ld	ra,72(sp)
    80000b7e:	6406                	ld	s0,64(sp)
    80000b80:	74e2                	ld	s1,56(sp)
    80000b82:	7942                	ld	s2,48(sp)
    80000b84:	79a2                	ld	s3,40(sp)
    80000b86:	7a02                	ld	s4,32(sp)
    80000b88:	6ae2                	ld	s5,24(sp)
    80000b8a:	6b42                	ld	s6,16(sp)
    80000b8c:	6ba2                	ld	s7,8(sp)
    80000b8e:	6c02                	ld	s8,0(sp)
    80000b90:	6161                	addi	sp,sp,80
    80000b92:	8082                	ret

0000000080000b94 <copyin>:
int
copyin(pagetable_t pagetable, char *dst, uint64 srcva, uint64 len)
{
  uint64 n, va0, pa0;

  while(len > 0){
    80000b94:	caa5                	beqz	a3,80000c04 <copyin+0x70>
{
    80000b96:	715d                	addi	sp,sp,-80
    80000b98:	e486                	sd	ra,72(sp)
    80000b9a:	e0a2                	sd	s0,64(sp)
    80000b9c:	fc26                	sd	s1,56(sp)
    80000b9e:	f84a                	sd	s2,48(sp)
    80000ba0:	f44e                	sd	s3,40(sp)
    80000ba2:	f052                	sd	s4,32(sp)
    80000ba4:	ec56                	sd	s5,24(sp)
    80000ba6:	e85a                	sd	s6,16(sp)
    80000ba8:	e45e                	sd	s7,8(sp)
    80000baa:	e062                	sd	s8,0(sp)
    80000bac:	0880                	addi	s0,sp,80
    80000bae:	8b2a                	mv	s6,a0
    80000bb0:	8a2e                	mv	s4,a1
    80000bb2:	8c32                	mv	s8,a2
    80000bb4:	89b6                	mv	s3,a3
    va0 = PGROUNDDOWN(srcva);
    80000bb6:	7bfd                	lui	s7,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000bb8:	6a85                	lui	s5,0x1
    80000bba:	a01d                	j	80000be0 <copyin+0x4c>
    if(n > len)
      n = len;
    memmove(dst, (void *)(pa0 + (srcva - va0)), n);
    80000bbc:	018505b3          	add	a1,a0,s8
    80000bc0:	0004861b          	sext.w	a2,s1
    80000bc4:	412585b3          	sub	a1,a1,s2
    80000bc8:	8552                	mv	a0,s4
    80000bca:	fffff097          	auipc	ra,0xfffff
    80000bce:	60c080e7          	jalr	1548(ra) # 800001d6 <memmove>

    len -= n;
    80000bd2:	409989b3          	sub	s3,s3,s1
    dst += n;
    80000bd6:	9a26                	add	s4,s4,s1
    srcva = va0 + PGSIZE;
    80000bd8:	01590c33          	add	s8,s2,s5
  while(len > 0){
    80000bdc:	02098263          	beqz	s3,80000c00 <copyin+0x6c>
    va0 = PGROUNDDOWN(srcva);
    80000be0:	017c7933          	and	s2,s8,s7
    pa0 = walkaddr(pagetable, va0);
    80000be4:	85ca                	mv	a1,s2
    80000be6:	855a                	mv	a0,s6
    80000be8:	00000097          	auipc	ra,0x0
    80000bec:	918080e7          	jalr	-1768(ra) # 80000500 <walkaddr>
    if(pa0 == 0)
    80000bf0:	cd01                	beqz	a0,80000c08 <copyin+0x74>
    n = PGSIZE - (srcva - va0);
    80000bf2:	418904b3          	sub	s1,s2,s8
    80000bf6:	94d6                	add	s1,s1,s5
    80000bf8:	fc99f2e3          	bgeu	s3,s1,80000bbc <copyin+0x28>
    80000bfc:	84ce                	mv	s1,s3
    80000bfe:	bf7d                	j	80000bbc <copyin+0x28>
  }
  return 0;
    80000c00:	4501                	li	a0,0
    80000c02:	a021                	j	80000c0a <copyin+0x76>
    80000c04:	4501                	li	a0,0
}
    80000c06:	8082                	ret
      return -1;
    80000c08:	557d                	li	a0,-1
}
    80000c0a:	60a6                	ld	ra,72(sp)
    80000c0c:	6406                	ld	s0,64(sp)
    80000c0e:	74e2                	ld	s1,56(sp)
    80000c10:	7942                	ld	s2,48(sp)
    80000c12:	79a2                	ld	s3,40(sp)
    80000c14:	7a02                	ld	s4,32(sp)
    80000c16:	6ae2                	ld	s5,24(sp)
    80000c18:	6b42                	ld	s6,16(sp)
    80000c1a:	6ba2                	ld	s7,8(sp)
    80000c1c:	6c02                	ld	s8,0(sp)
    80000c1e:	6161                	addi	sp,sp,80
    80000c20:	8082                	ret

0000000080000c22 <copyinstr>:
copyinstr(pagetable_t pagetable, char *dst, uint64 srcva, uint64 max)
{
  uint64 n, va0, pa0;
  int got_null = 0;

  while(got_null == 0 && max > 0){
    80000c22:	c2dd                	beqz	a3,80000cc8 <copyinstr+0xa6>
{
    80000c24:	715d                	addi	sp,sp,-80
    80000c26:	e486                	sd	ra,72(sp)
    80000c28:	e0a2                	sd	s0,64(sp)
    80000c2a:	fc26                	sd	s1,56(sp)
    80000c2c:	f84a                	sd	s2,48(sp)
    80000c2e:	f44e                	sd	s3,40(sp)
    80000c30:	f052                	sd	s4,32(sp)
    80000c32:	ec56                	sd	s5,24(sp)
    80000c34:	e85a                	sd	s6,16(sp)
    80000c36:	e45e                	sd	s7,8(sp)
    80000c38:	0880                	addi	s0,sp,80
    80000c3a:	8a2a                	mv	s4,a0
    80000c3c:	8b2e                	mv	s6,a1
    80000c3e:	8bb2                	mv	s7,a2
    80000c40:	84b6                	mv	s1,a3
    va0 = PGROUNDDOWN(srcva);
    80000c42:	7afd                	lui	s5,0xfffff
    pa0 = walkaddr(pagetable, va0);
    if(pa0 == 0)
      return -1;
    n = PGSIZE - (srcva - va0);
    80000c44:	6985                	lui	s3,0x1
    80000c46:	a02d                	j	80000c70 <copyinstr+0x4e>
      n = max;

    char *p = (char *) (pa0 + (srcva - va0));
    while(n > 0){
      if(*p == '\0'){
        *dst = '\0';
    80000c48:	00078023          	sb	zero,0(a5) # 1000 <_entry-0x7ffff000>
    80000c4c:	4785                	li	a5,1
      dst++;
    }

    srcva = va0 + PGSIZE;
  }
  if(got_null){
    80000c4e:	37fd                	addiw	a5,a5,-1
    80000c50:	0007851b          	sext.w	a0,a5
    return 0;
  } else {
    return -1;
  }
}
    80000c54:	60a6                	ld	ra,72(sp)
    80000c56:	6406                	ld	s0,64(sp)
    80000c58:	74e2                	ld	s1,56(sp)
    80000c5a:	7942                	ld	s2,48(sp)
    80000c5c:	79a2                	ld	s3,40(sp)
    80000c5e:	7a02                	ld	s4,32(sp)
    80000c60:	6ae2                	ld	s5,24(sp)
    80000c62:	6b42                	ld	s6,16(sp)
    80000c64:	6ba2                	ld	s7,8(sp)
    80000c66:	6161                	addi	sp,sp,80
    80000c68:	8082                	ret
    srcva = va0 + PGSIZE;
    80000c6a:	01390bb3          	add	s7,s2,s3
  while(got_null == 0 && max > 0){
    80000c6e:	c8a9                	beqz	s1,80000cc0 <copyinstr+0x9e>
    va0 = PGROUNDDOWN(srcva);
    80000c70:	015bf933          	and	s2,s7,s5
    pa0 = walkaddr(pagetable, va0);
    80000c74:	85ca                	mv	a1,s2
    80000c76:	8552                	mv	a0,s4
    80000c78:	00000097          	auipc	ra,0x0
    80000c7c:	888080e7          	jalr	-1912(ra) # 80000500 <walkaddr>
    if(pa0 == 0)
    80000c80:	c131                	beqz	a0,80000cc4 <copyinstr+0xa2>
    n = PGSIZE - (srcva - va0);
    80000c82:	417906b3          	sub	a3,s2,s7
    80000c86:	96ce                	add	a3,a3,s3
    80000c88:	00d4f363          	bgeu	s1,a3,80000c8e <copyinstr+0x6c>
    80000c8c:	86a6                	mv	a3,s1
    char *p = (char *) (pa0 + (srcva - va0));
    80000c8e:	955e                	add	a0,a0,s7
    80000c90:	41250533          	sub	a0,a0,s2
    while(n > 0){
    80000c94:	daf9                	beqz	a3,80000c6a <copyinstr+0x48>
    80000c96:	87da                	mv	a5,s6
      if(*p == '\0'){
    80000c98:	41650633          	sub	a2,a0,s6
    80000c9c:	fff48593          	addi	a1,s1,-1
    80000ca0:	95da                	add	a1,a1,s6
    while(n > 0){
    80000ca2:	96da                	add	a3,a3,s6
      if(*p == '\0'){
    80000ca4:	00f60733          	add	a4,a2,a5
    80000ca8:	00074703          	lbu	a4,0(a4) # fffffffffffff000 <end+0xffffffff7ffd1dc0>
    80000cac:	df51                	beqz	a4,80000c48 <copyinstr+0x26>
        *dst = *p;
    80000cae:	00e78023          	sb	a4,0(a5)
      --max;
    80000cb2:	40f584b3          	sub	s1,a1,a5
      dst++;
    80000cb6:	0785                	addi	a5,a5,1
    while(n > 0){
    80000cb8:	fed796e3          	bne	a5,a3,80000ca4 <copyinstr+0x82>
      dst++;
    80000cbc:	8b3e                	mv	s6,a5
    80000cbe:	b775                	j	80000c6a <copyinstr+0x48>
    80000cc0:	4781                	li	a5,0
    80000cc2:	b771                	j	80000c4e <copyinstr+0x2c>
      return -1;
    80000cc4:	557d                	li	a0,-1
    80000cc6:	b779                	j	80000c54 <copyinstr+0x32>
  int got_null = 0;
    80000cc8:	4781                	li	a5,0
  if(got_null){
    80000cca:	37fd                	addiw	a5,a5,-1
    80000ccc:	0007851b          	sext.w	a0,a5
}
    80000cd0:	8082                	ret

0000000080000cd2 <proc_mapstacks>:

// Allocate a page for each process's kernel stack.
// Map it high in memory, followed by an invalid
// guard page.
void
proc_mapstacks(pagetable_t kpgtbl) {
    80000cd2:	7139                	addi	sp,sp,-64
    80000cd4:	fc06                	sd	ra,56(sp)
    80000cd6:	f822                	sd	s0,48(sp)
    80000cd8:	f426                	sd	s1,40(sp)
    80000cda:	f04a                	sd	s2,32(sp)
    80000cdc:	ec4e                	sd	s3,24(sp)
    80000cde:	e852                	sd	s4,16(sp)
    80000ce0:	e456                	sd	s5,8(sp)
    80000ce2:	e05a                	sd	s6,0(sp)
    80000ce4:	0080                	addi	s0,sp,64
    80000ce6:	89aa                	mv	s3,a0
  struct proc *p;
  
  for(p = proc; p < &proc[NPROC]; p++) {
    80000ce8:	00008497          	auipc	s1,0x8
    80000cec:	79848493          	addi	s1,s1,1944 # 80009480 <proc>
    char *pa = kalloc();
    if(pa == 0)
      panic("kalloc");
    uint64 va = KSTACK((int) (p - proc));
    80000cf0:	8b26                	mv	s6,s1
    80000cf2:	00007a97          	auipc	s5,0x7
    80000cf6:	30ea8a93          	addi	s5,s5,782 # 80008000 <etext>
    80000cfa:	04000937          	lui	s2,0x4000
    80000cfe:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000d00:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d02:	00009a17          	auipc	s4,0x9
    80000d06:	58ea0a13          	addi	s4,s4,1422 # 8000a290 <tickslock>
    char *pa = kalloc();
    80000d0a:	fffff097          	auipc	ra,0xfffff
    80000d0e:	410080e7          	jalr	1040(ra) # 8000011a <kalloc>
    80000d12:	862a                	mv	a2,a0
    if(pa == 0)
    80000d14:	c131                	beqz	a0,80000d58 <proc_mapstacks+0x86>
    uint64 va = KSTACK((int) (p - proc));
    80000d16:	416485b3          	sub	a1,s1,s6
    80000d1a:	858d                	srai	a1,a1,0x3
    80000d1c:	000ab783          	ld	a5,0(s5)
    80000d20:	02f585b3          	mul	a1,a1,a5
    80000d24:	2585                	addiw	a1,a1,1
    80000d26:	00d5959b          	slliw	a1,a1,0xd
    kvmmap(kpgtbl, va, (uint64)pa, PGSIZE, PTE_R | PTE_W);
    80000d2a:	4719                	li	a4,6
    80000d2c:	6685                	lui	a3,0x1
    80000d2e:	40b905b3          	sub	a1,s2,a1
    80000d32:	854e                	mv	a0,s3
    80000d34:	00000097          	auipc	ra,0x0
    80000d38:	8ae080e7          	jalr	-1874(ra) # 800005e2 <kvmmap>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000d3c:	16848493          	addi	s1,s1,360
    80000d40:	fd4495e3          	bne	s1,s4,80000d0a <proc_mapstacks+0x38>
  }
}
    80000d44:	70e2                	ld	ra,56(sp)
    80000d46:	7442                	ld	s0,48(sp)
    80000d48:	74a2                	ld	s1,40(sp)
    80000d4a:	7902                	ld	s2,32(sp)
    80000d4c:	69e2                	ld	s3,24(sp)
    80000d4e:	6a42                	ld	s4,16(sp)
    80000d50:	6aa2                	ld	s5,8(sp)
    80000d52:	6b02                	ld	s6,0(sp)
    80000d54:	6121                	addi	sp,sp,64
    80000d56:	8082                	ret
      panic("kalloc");
    80000d58:	00007517          	auipc	a0,0x7
    80000d5c:	40050513          	addi	a0,a0,1024 # 80008158 <etext+0x158>
    80000d60:	00005097          	auipc	ra,0x5
    80000d64:	f10080e7          	jalr	-240(ra) # 80005c70 <panic>

0000000080000d68 <procinit>:

// initialize the proc table at boot time.
void
procinit(void)
{
    80000d68:	7139                	addi	sp,sp,-64
    80000d6a:	fc06                	sd	ra,56(sp)
    80000d6c:	f822                	sd	s0,48(sp)
    80000d6e:	f426                	sd	s1,40(sp)
    80000d70:	f04a                	sd	s2,32(sp)
    80000d72:	ec4e                	sd	s3,24(sp)
    80000d74:	e852                	sd	s4,16(sp)
    80000d76:	e456                	sd	s5,8(sp)
    80000d78:	e05a                	sd	s6,0(sp)
    80000d7a:	0080                	addi	s0,sp,64
  struct proc *p;
  
  initlock(&pid_lock, "nextpid");
    80000d7c:	00007597          	auipc	a1,0x7
    80000d80:	3e458593          	addi	a1,a1,996 # 80008160 <etext+0x160>
    80000d84:	00008517          	auipc	a0,0x8
    80000d88:	2cc50513          	addi	a0,a0,716 # 80009050 <pid_lock>
    80000d8c:	00005097          	auipc	ra,0x5
    80000d90:	38c080e7          	jalr	908(ra) # 80006118 <initlock>
  initlock(&wait_lock, "wait_lock");
    80000d94:	00007597          	auipc	a1,0x7
    80000d98:	3d458593          	addi	a1,a1,980 # 80008168 <etext+0x168>
    80000d9c:	00008517          	auipc	a0,0x8
    80000da0:	2cc50513          	addi	a0,a0,716 # 80009068 <wait_lock>
    80000da4:	00005097          	auipc	ra,0x5
    80000da8:	374080e7          	jalr	884(ra) # 80006118 <initlock>
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dac:	00008497          	auipc	s1,0x8
    80000db0:	6d448493          	addi	s1,s1,1748 # 80009480 <proc>
      initlock(&p->lock, "proc");
    80000db4:	00007b17          	auipc	s6,0x7
    80000db8:	3c4b0b13          	addi	s6,s6,964 # 80008178 <etext+0x178>
      p->kstack = KSTACK((int) (p - proc));
    80000dbc:	8aa6                	mv	s5,s1
    80000dbe:	00007a17          	auipc	s4,0x7
    80000dc2:	242a0a13          	addi	s4,s4,578 # 80008000 <etext>
    80000dc6:	04000937          	lui	s2,0x4000
    80000dca:	197d                	addi	s2,s2,-1 # 3ffffff <_entry-0x7c000001>
    80000dcc:	0932                	slli	s2,s2,0xc
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dce:	00009997          	auipc	s3,0x9
    80000dd2:	4c298993          	addi	s3,s3,1218 # 8000a290 <tickslock>
      initlock(&p->lock, "proc");
    80000dd6:	85da                	mv	a1,s6
    80000dd8:	8526                	mv	a0,s1
    80000dda:	00005097          	auipc	ra,0x5
    80000dde:	33e080e7          	jalr	830(ra) # 80006118 <initlock>
      p->kstack = KSTACK((int) (p - proc));
    80000de2:	415487b3          	sub	a5,s1,s5
    80000de6:	878d                	srai	a5,a5,0x3
    80000de8:	000a3703          	ld	a4,0(s4)
    80000dec:	02e787b3          	mul	a5,a5,a4
    80000df0:	2785                	addiw	a5,a5,1
    80000df2:	00d7979b          	slliw	a5,a5,0xd
    80000df6:	40f907b3          	sub	a5,s2,a5
    80000dfa:	e0bc                	sd	a5,64(s1)
  for(p = proc; p < &proc[NPROC]; p++) {
    80000dfc:	16848493          	addi	s1,s1,360
    80000e00:	fd349be3          	bne	s1,s3,80000dd6 <procinit+0x6e>
  }
}
    80000e04:	70e2                	ld	ra,56(sp)
    80000e06:	7442                	ld	s0,48(sp)
    80000e08:	74a2                	ld	s1,40(sp)
    80000e0a:	7902                	ld	s2,32(sp)
    80000e0c:	69e2                	ld	s3,24(sp)
    80000e0e:	6a42                	ld	s4,16(sp)
    80000e10:	6aa2                	ld	s5,8(sp)
    80000e12:	6b02                	ld	s6,0(sp)
    80000e14:	6121                	addi	sp,sp,64
    80000e16:	8082                	ret

0000000080000e18 <cpuid>:
// Must be called with interrupts disabled,
// to prevent race with process being moved
// to a different CPU.
int
cpuid()
{
    80000e18:	1141                	addi	sp,sp,-16
    80000e1a:	e422                	sd	s0,8(sp)
    80000e1c:	0800                	addi	s0,sp,16
  asm volatile("mv %0, tp" : "=r" (x) );
    80000e1e:	8512                	mv	a0,tp
  int id = r_tp();
  return id;
}
    80000e20:	2501                	sext.w	a0,a0
    80000e22:	6422                	ld	s0,8(sp)
    80000e24:	0141                	addi	sp,sp,16
    80000e26:	8082                	ret

0000000080000e28 <mycpu>:

// Return this CPU's cpu struct.
// Interrupts must be disabled.
struct cpu*
mycpu(void) {
    80000e28:	1141                	addi	sp,sp,-16
    80000e2a:	e422                	sd	s0,8(sp)
    80000e2c:	0800                	addi	s0,sp,16
    80000e2e:	8792                	mv	a5,tp
  int id = cpuid();
  struct cpu *c = &cpus[id];
    80000e30:	2781                	sext.w	a5,a5
    80000e32:	079e                	slli	a5,a5,0x7
  return c;
}
    80000e34:	00008517          	auipc	a0,0x8
    80000e38:	24c50513          	addi	a0,a0,588 # 80009080 <cpus>
    80000e3c:	953e                	add	a0,a0,a5
    80000e3e:	6422                	ld	s0,8(sp)
    80000e40:	0141                	addi	sp,sp,16
    80000e42:	8082                	ret

0000000080000e44 <myproc>:

// Return the current struct proc *, or zero if none.
struct proc*
myproc(void) {
    80000e44:	1101                	addi	sp,sp,-32
    80000e46:	ec06                	sd	ra,24(sp)
    80000e48:	e822                	sd	s0,16(sp)
    80000e4a:	e426                	sd	s1,8(sp)
    80000e4c:	1000                	addi	s0,sp,32
  push_off();
    80000e4e:	00005097          	auipc	ra,0x5
    80000e52:	30e080e7          	jalr	782(ra) # 8000615c <push_off>
    80000e56:	8792                	mv	a5,tp
  struct cpu *c = mycpu();
  struct proc *p = c->proc;
    80000e58:	2781                	sext.w	a5,a5
    80000e5a:	079e                	slli	a5,a5,0x7
    80000e5c:	00008717          	auipc	a4,0x8
    80000e60:	1f470713          	addi	a4,a4,500 # 80009050 <pid_lock>
    80000e64:	97ba                	add	a5,a5,a4
    80000e66:	7b84                	ld	s1,48(a5)
  pop_off();
    80000e68:	00005097          	auipc	ra,0x5
    80000e6c:	394080e7          	jalr	916(ra) # 800061fc <pop_off>
  return p;
}
    80000e70:	8526                	mv	a0,s1
    80000e72:	60e2                	ld	ra,24(sp)
    80000e74:	6442                	ld	s0,16(sp)
    80000e76:	64a2                	ld	s1,8(sp)
    80000e78:	6105                	addi	sp,sp,32
    80000e7a:	8082                	ret

0000000080000e7c <forkret>:

// A fork child's very first scheduling by scheduler()
// will swtch to forkret.
void
forkret(void)
{
    80000e7c:	1141                	addi	sp,sp,-16
    80000e7e:	e406                	sd	ra,8(sp)
    80000e80:	e022                	sd	s0,0(sp)
    80000e82:	0800                	addi	s0,sp,16
  static int first = 1;

  // Still holding p->lock from scheduler.
  release(&myproc()->lock);
    80000e84:	00000097          	auipc	ra,0x0
    80000e88:	fc0080e7          	jalr	-64(ra) # 80000e44 <myproc>
    80000e8c:	00005097          	auipc	ra,0x5
    80000e90:	3d0080e7          	jalr	976(ra) # 8000625c <release>

  if (first) {
    80000e94:	00008797          	auipc	a5,0x8
    80000e98:	aec7a783          	lw	a5,-1300(a5) # 80008980 <first.1>
    80000e9c:	eb89                	bnez	a5,80000eae <forkret+0x32>
    // be run from main().
    first = 0;
    fsinit(ROOTDEV);
  }

  usertrapret();
    80000e9e:	00001097          	auipc	ra,0x1
    80000ea2:	c14080e7          	jalr	-1004(ra) # 80001ab2 <usertrapret>
}
    80000ea6:	60a2                	ld	ra,8(sp)
    80000ea8:	6402                	ld	s0,0(sp)
    80000eaa:	0141                	addi	sp,sp,16
    80000eac:	8082                	ret
    first = 0;
    80000eae:	00008797          	auipc	a5,0x8
    80000eb2:	ac07a923          	sw	zero,-1326(a5) # 80008980 <first.1>
    fsinit(ROOTDEV);
    80000eb6:	4505                	li	a0,1
    80000eb8:	00002097          	auipc	ra,0x2
    80000ebc:	a04080e7          	jalr	-1532(ra) # 800028bc <fsinit>
    80000ec0:	bff9                	j	80000e9e <forkret+0x22>

0000000080000ec2 <allocpid>:
allocpid() {
    80000ec2:	1101                	addi	sp,sp,-32
    80000ec4:	ec06                	sd	ra,24(sp)
    80000ec6:	e822                	sd	s0,16(sp)
    80000ec8:	e426                	sd	s1,8(sp)
    80000eca:	e04a                	sd	s2,0(sp)
    80000ecc:	1000                	addi	s0,sp,32
  acquire(&pid_lock);
    80000ece:	00008917          	auipc	s2,0x8
    80000ed2:	18290913          	addi	s2,s2,386 # 80009050 <pid_lock>
    80000ed6:	854a                	mv	a0,s2
    80000ed8:	00005097          	auipc	ra,0x5
    80000edc:	2d0080e7          	jalr	720(ra) # 800061a8 <acquire>
  pid = nextpid;
    80000ee0:	00008797          	auipc	a5,0x8
    80000ee4:	aa478793          	addi	a5,a5,-1372 # 80008984 <nextpid>
    80000ee8:	4384                	lw	s1,0(a5)
  nextpid = nextpid + 1;
    80000eea:	0014871b          	addiw	a4,s1,1
    80000eee:	c398                	sw	a4,0(a5)
  release(&pid_lock);
    80000ef0:	854a                	mv	a0,s2
    80000ef2:	00005097          	auipc	ra,0x5
    80000ef6:	36a080e7          	jalr	874(ra) # 8000625c <release>
}
    80000efa:	8526                	mv	a0,s1
    80000efc:	60e2                	ld	ra,24(sp)
    80000efe:	6442                	ld	s0,16(sp)
    80000f00:	64a2                	ld	s1,8(sp)
    80000f02:	6902                	ld	s2,0(sp)
    80000f04:	6105                	addi	sp,sp,32
    80000f06:	8082                	ret

0000000080000f08 <proc_pagetable>:
{
    80000f08:	1101                	addi	sp,sp,-32
    80000f0a:	ec06                	sd	ra,24(sp)
    80000f0c:	e822                	sd	s0,16(sp)
    80000f0e:	e426                	sd	s1,8(sp)
    80000f10:	e04a                	sd	s2,0(sp)
    80000f12:	1000                	addi	s0,sp,32
    80000f14:	892a                	mv	s2,a0
  pagetable = uvmcreate();
    80000f16:	00000097          	auipc	ra,0x0
    80000f1a:	8b6080e7          	jalr	-1866(ra) # 800007cc <uvmcreate>
    80000f1e:	84aa                	mv	s1,a0
  if(pagetable == 0)
    80000f20:	c121                	beqz	a0,80000f60 <proc_pagetable+0x58>
  if(mappages(pagetable, TRAMPOLINE, PGSIZE,
    80000f22:	4729                	li	a4,10
    80000f24:	00006697          	auipc	a3,0x6
    80000f28:	0dc68693          	addi	a3,a3,220 # 80007000 <_trampoline>
    80000f2c:	6605                	lui	a2,0x1
    80000f2e:	040005b7          	lui	a1,0x4000
    80000f32:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f34:	05b2                	slli	a1,a1,0xc
    80000f36:	fffff097          	auipc	ra,0xfffff
    80000f3a:	60c080e7          	jalr	1548(ra) # 80000542 <mappages>
    80000f3e:	02054863          	bltz	a0,80000f6e <proc_pagetable+0x66>
  if(mappages(pagetable, TRAPFRAME, PGSIZE,
    80000f42:	4719                	li	a4,6
    80000f44:	05893683          	ld	a3,88(s2)
    80000f48:	6605                	lui	a2,0x1
    80000f4a:	020005b7          	lui	a1,0x2000
    80000f4e:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000f50:	05b6                	slli	a1,a1,0xd
    80000f52:	8526                	mv	a0,s1
    80000f54:	fffff097          	auipc	ra,0xfffff
    80000f58:	5ee080e7          	jalr	1518(ra) # 80000542 <mappages>
    80000f5c:	02054163          	bltz	a0,80000f7e <proc_pagetable+0x76>
}
    80000f60:	8526                	mv	a0,s1
    80000f62:	60e2                	ld	ra,24(sp)
    80000f64:	6442                	ld	s0,16(sp)
    80000f66:	64a2                	ld	s1,8(sp)
    80000f68:	6902                	ld	s2,0(sp)
    80000f6a:	6105                	addi	sp,sp,32
    80000f6c:	8082                	ret
    uvmfree(pagetable, 0);
    80000f6e:	4581                	li	a1,0
    80000f70:	8526                	mv	a0,s1
    80000f72:	00000097          	auipc	ra,0x0
    80000f76:	a58080e7          	jalr	-1448(ra) # 800009ca <uvmfree>
    return 0;
    80000f7a:	4481                	li	s1,0
    80000f7c:	b7d5                	j	80000f60 <proc_pagetable+0x58>
    uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000f7e:	4681                	li	a3,0
    80000f80:	4605                	li	a2,1
    80000f82:	040005b7          	lui	a1,0x4000
    80000f86:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000f88:	05b2                	slli	a1,a1,0xc
    80000f8a:	8526                	mv	a0,s1
    80000f8c:	fffff097          	auipc	ra,0xfffff
    80000f90:	77c080e7          	jalr	1916(ra) # 80000708 <uvmunmap>
    uvmfree(pagetable, 0);
    80000f94:	4581                	li	a1,0
    80000f96:	8526                	mv	a0,s1
    80000f98:	00000097          	auipc	ra,0x0
    80000f9c:	a32080e7          	jalr	-1486(ra) # 800009ca <uvmfree>
    return 0;
    80000fa0:	4481                	li	s1,0
    80000fa2:	bf7d                	j	80000f60 <proc_pagetable+0x58>

0000000080000fa4 <proc_freepagetable>:
{
    80000fa4:	1101                	addi	sp,sp,-32
    80000fa6:	ec06                	sd	ra,24(sp)
    80000fa8:	e822                	sd	s0,16(sp)
    80000faa:	e426                	sd	s1,8(sp)
    80000fac:	e04a                	sd	s2,0(sp)
    80000fae:	1000                	addi	s0,sp,32
    80000fb0:	84aa                	mv	s1,a0
    80000fb2:	892e                	mv	s2,a1
  uvmunmap(pagetable, TRAMPOLINE, 1, 0);
    80000fb4:	4681                	li	a3,0
    80000fb6:	4605                	li	a2,1
    80000fb8:	040005b7          	lui	a1,0x4000
    80000fbc:	15fd                	addi	a1,a1,-1 # 3ffffff <_entry-0x7c000001>
    80000fbe:	05b2                	slli	a1,a1,0xc
    80000fc0:	fffff097          	auipc	ra,0xfffff
    80000fc4:	748080e7          	jalr	1864(ra) # 80000708 <uvmunmap>
  uvmunmap(pagetable, TRAPFRAME, 1, 0);
    80000fc8:	4681                	li	a3,0
    80000fca:	4605                	li	a2,1
    80000fcc:	020005b7          	lui	a1,0x2000
    80000fd0:	15fd                	addi	a1,a1,-1 # 1ffffff <_entry-0x7e000001>
    80000fd2:	05b6                	slli	a1,a1,0xd
    80000fd4:	8526                	mv	a0,s1
    80000fd6:	fffff097          	auipc	ra,0xfffff
    80000fda:	732080e7          	jalr	1842(ra) # 80000708 <uvmunmap>
  uvmfree(pagetable, sz);
    80000fde:	85ca                	mv	a1,s2
    80000fe0:	8526                	mv	a0,s1
    80000fe2:	00000097          	auipc	ra,0x0
    80000fe6:	9e8080e7          	jalr	-1560(ra) # 800009ca <uvmfree>
}
    80000fea:	60e2                	ld	ra,24(sp)
    80000fec:	6442                	ld	s0,16(sp)
    80000fee:	64a2                	ld	s1,8(sp)
    80000ff0:	6902                	ld	s2,0(sp)
    80000ff2:	6105                	addi	sp,sp,32
    80000ff4:	8082                	ret

0000000080000ff6 <freeproc>:
{
    80000ff6:	1101                	addi	sp,sp,-32
    80000ff8:	ec06                	sd	ra,24(sp)
    80000ffa:	e822                	sd	s0,16(sp)
    80000ffc:	e426                	sd	s1,8(sp)
    80000ffe:	1000                	addi	s0,sp,32
    80001000:	84aa                	mv	s1,a0
  if(p->trapframe)
    80001002:	6d28                	ld	a0,88(a0)
    80001004:	c509                	beqz	a0,8000100e <freeproc+0x18>
    kfree((void*)p->trapframe);
    80001006:	fffff097          	auipc	ra,0xfffff
    8000100a:	016080e7          	jalr	22(ra) # 8000001c <kfree>
  p->trapframe = 0;
    8000100e:	0404bc23          	sd	zero,88(s1)
  if(p->pagetable)
    80001012:	68a8                	ld	a0,80(s1)
    80001014:	c511                	beqz	a0,80001020 <freeproc+0x2a>
    proc_freepagetable(p->pagetable, p->sz);
    80001016:	64ac                	ld	a1,72(s1)
    80001018:	00000097          	auipc	ra,0x0
    8000101c:	f8c080e7          	jalr	-116(ra) # 80000fa4 <proc_freepagetable>
  p->pagetable = 0;
    80001020:	0404b823          	sd	zero,80(s1)
  p->sz = 0;
    80001024:	0404b423          	sd	zero,72(s1)
  p->pid = 0;
    80001028:	0204a823          	sw	zero,48(s1)
  p->parent = 0;
    8000102c:	0204bc23          	sd	zero,56(s1)
  p->name[0] = 0;
    80001030:	14048c23          	sb	zero,344(s1)
  p->chan = 0;
    80001034:	0204b023          	sd	zero,32(s1)
  p->killed = 0;
    80001038:	0204a423          	sw	zero,40(s1)
  p->xstate = 0;
    8000103c:	0204a623          	sw	zero,44(s1)
  p->state = UNUSED;
    80001040:	0004ac23          	sw	zero,24(s1)
}
    80001044:	60e2                	ld	ra,24(sp)
    80001046:	6442                	ld	s0,16(sp)
    80001048:	64a2                	ld	s1,8(sp)
    8000104a:	6105                	addi	sp,sp,32
    8000104c:	8082                	ret

000000008000104e <allocproc>:
{
    8000104e:	1101                	addi	sp,sp,-32
    80001050:	ec06                	sd	ra,24(sp)
    80001052:	e822                	sd	s0,16(sp)
    80001054:	e426                	sd	s1,8(sp)
    80001056:	e04a                	sd	s2,0(sp)
    80001058:	1000                	addi	s0,sp,32
  for(p = proc; p < &proc[NPROC]; p++) {
    8000105a:	00008497          	auipc	s1,0x8
    8000105e:	42648493          	addi	s1,s1,1062 # 80009480 <proc>
    80001062:	00009917          	auipc	s2,0x9
    80001066:	22e90913          	addi	s2,s2,558 # 8000a290 <tickslock>
    acquire(&p->lock);
    8000106a:	8526                	mv	a0,s1
    8000106c:	00005097          	auipc	ra,0x5
    80001070:	13c080e7          	jalr	316(ra) # 800061a8 <acquire>
    if(p->state == UNUSED) {
    80001074:	4c9c                	lw	a5,24(s1)
    80001076:	c395                	beqz	a5,8000109a <allocproc+0x4c>
      release(&p->lock);
    80001078:	8526                	mv	a0,s1
    8000107a:	00005097          	auipc	ra,0x5
    8000107e:	1e2080e7          	jalr	482(ra) # 8000625c <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    80001082:	16848493          	addi	s1,s1,360
    80001086:	ff2492e3          	bne	s1,s2,8000106a <allocproc+0x1c>
  return 0;
    8000108a:	4481                	li	s1,0
}
    8000108c:	8526                	mv	a0,s1
    8000108e:	60e2                	ld	ra,24(sp)
    80001090:	6442                	ld	s0,16(sp)
    80001092:	64a2                	ld	s1,8(sp)
    80001094:	6902                	ld	s2,0(sp)
    80001096:	6105                	addi	sp,sp,32
    80001098:	8082                	ret
  p->pid = allocpid();
    8000109a:	00000097          	auipc	ra,0x0
    8000109e:	e28080e7          	jalr	-472(ra) # 80000ec2 <allocpid>
    800010a2:	d888                	sw	a0,48(s1)
  p->state = USED;
    800010a4:	4785                	li	a5,1
    800010a6:	cc9c                	sw	a5,24(s1)
  if((p->trapframe = (struct trapframe *)kalloc()) == 0){
    800010a8:	fffff097          	auipc	ra,0xfffff
    800010ac:	072080e7          	jalr	114(ra) # 8000011a <kalloc>
    800010b0:	892a                	mv	s2,a0
    800010b2:	eca8                	sd	a0,88(s1)
    800010b4:	cd05                	beqz	a0,800010ec <allocproc+0x9e>
  p->pagetable = proc_pagetable(p);
    800010b6:	8526                	mv	a0,s1
    800010b8:	00000097          	auipc	ra,0x0
    800010bc:	e50080e7          	jalr	-432(ra) # 80000f08 <proc_pagetable>
    800010c0:	892a                	mv	s2,a0
    800010c2:	e8a8                	sd	a0,80(s1)
  if(p->pagetable == 0){
    800010c4:	c121                	beqz	a0,80001104 <allocproc+0xb6>
  memset(&p->context, 0, sizeof(p->context));
    800010c6:	07000613          	li	a2,112
    800010ca:	4581                	li	a1,0
    800010cc:	06048513          	addi	a0,s1,96
    800010d0:	fffff097          	auipc	ra,0xfffff
    800010d4:	0aa080e7          	jalr	170(ra) # 8000017a <memset>
  p->context.ra = (uint64)forkret;
    800010d8:	00000797          	auipc	a5,0x0
    800010dc:	da478793          	addi	a5,a5,-604 # 80000e7c <forkret>
    800010e0:	f0bc                	sd	a5,96(s1)
  p->context.sp = p->kstack + PGSIZE;
    800010e2:	60bc                	ld	a5,64(s1)
    800010e4:	6705                	lui	a4,0x1
    800010e6:	97ba                	add	a5,a5,a4
    800010e8:	f4bc                	sd	a5,104(s1)
  return p;
    800010ea:	b74d                	j	8000108c <allocproc+0x3e>
    freeproc(p);
    800010ec:	8526                	mv	a0,s1
    800010ee:	00000097          	auipc	ra,0x0
    800010f2:	f08080e7          	jalr	-248(ra) # 80000ff6 <freeproc>
    release(&p->lock);
    800010f6:	8526                	mv	a0,s1
    800010f8:	00005097          	auipc	ra,0x5
    800010fc:	164080e7          	jalr	356(ra) # 8000625c <release>
    return 0;
    80001100:	84ca                	mv	s1,s2
    80001102:	b769                	j	8000108c <allocproc+0x3e>
    freeproc(p);
    80001104:	8526                	mv	a0,s1
    80001106:	00000097          	auipc	ra,0x0
    8000110a:	ef0080e7          	jalr	-272(ra) # 80000ff6 <freeproc>
    release(&p->lock);
    8000110e:	8526                	mv	a0,s1
    80001110:	00005097          	auipc	ra,0x5
    80001114:	14c080e7          	jalr	332(ra) # 8000625c <release>
    return 0;
    80001118:	84ca                	mv	s1,s2
    8000111a:	bf8d                	j	8000108c <allocproc+0x3e>

000000008000111c <userinit>:
{
    8000111c:	1101                	addi	sp,sp,-32
    8000111e:	ec06                	sd	ra,24(sp)
    80001120:	e822                	sd	s0,16(sp)
    80001122:	e426                	sd	s1,8(sp)
    80001124:	1000                	addi	s0,sp,32
  p = allocproc();
    80001126:	00000097          	auipc	ra,0x0
    8000112a:	f28080e7          	jalr	-216(ra) # 8000104e <allocproc>
    8000112e:	84aa                	mv	s1,a0
  initproc = p;
    80001130:	00008797          	auipc	a5,0x8
    80001134:	eea7b023          	sd	a0,-288(a5) # 80009010 <initproc>
  uvminit(p->pagetable, initcode, sizeof(initcode));
    80001138:	03400613          	li	a2,52
    8000113c:	00008597          	auipc	a1,0x8
    80001140:	85458593          	addi	a1,a1,-1964 # 80008990 <initcode>
    80001144:	6928                	ld	a0,80(a0)
    80001146:	fffff097          	auipc	ra,0xfffff
    8000114a:	6b4080e7          	jalr	1716(ra) # 800007fa <uvminit>
  p->sz = PGSIZE;
    8000114e:	6785                	lui	a5,0x1
    80001150:	e4bc                	sd	a5,72(s1)
  p->trapframe->epc = 0;      // user program counter
    80001152:	6cb8                	ld	a4,88(s1)
    80001154:	00073c23          	sd	zero,24(a4) # 1018 <_entry-0x7fffefe8>
  p->trapframe->sp = PGSIZE;  // user stack pointer
    80001158:	6cb8                	ld	a4,88(s1)
    8000115a:	fb1c                	sd	a5,48(a4)
  safestrcpy(p->name, "initcode", sizeof(p->name));
    8000115c:	4641                	li	a2,16
    8000115e:	00007597          	auipc	a1,0x7
    80001162:	02258593          	addi	a1,a1,34 # 80008180 <etext+0x180>
    80001166:	15848513          	addi	a0,s1,344
    8000116a:	fffff097          	auipc	ra,0xfffff
    8000116e:	15a080e7          	jalr	346(ra) # 800002c4 <safestrcpy>
  p->cwd = namei("/");
    80001172:	00007517          	auipc	a0,0x7
    80001176:	01e50513          	addi	a0,a0,30 # 80008190 <etext+0x190>
    8000117a:	00002097          	auipc	ra,0x2
    8000117e:	1fc080e7          	jalr	508(ra) # 80003376 <namei>
    80001182:	14a4b823          	sd	a0,336(s1)
  p->state = RUNNABLE;
    80001186:	478d                	li	a5,3
    80001188:	cc9c                	sw	a5,24(s1)
  release(&p->lock);
    8000118a:	8526                	mv	a0,s1
    8000118c:	00005097          	auipc	ra,0x5
    80001190:	0d0080e7          	jalr	208(ra) # 8000625c <release>
}
    80001194:	60e2                	ld	ra,24(sp)
    80001196:	6442                	ld	s0,16(sp)
    80001198:	64a2                	ld	s1,8(sp)
    8000119a:	6105                	addi	sp,sp,32
    8000119c:	8082                	ret

000000008000119e <growproc>:
{
    8000119e:	1101                	addi	sp,sp,-32
    800011a0:	ec06                	sd	ra,24(sp)
    800011a2:	e822                	sd	s0,16(sp)
    800011a4:	e426                	sd	s1,8(sp)
    800011a6:	e04a                	sd	s2,0(sp)
    800011a8:	1000                	addi	s0,sp,32
    800011aa:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    800011ac:	00000097          	auipc	ra,0x0
    800011b0:	c98080e7          	jalr	-872(ra) # 80000e44 <myproc>
    800011b4:	892a                	mv	s2,a0
  sz = p->sz;
    800011b6:	652c                	ld	a1,72(a0)
    800011b8:	0005879b          	sext.w	a5,a1
  if(n > 0){
    800011bc:	00904f63          	bgtz	s1,800011da <growproc+0x3c>
  } else if(n < 0){
    800011c0:	0204cd63          	bltz	s1,800011fa <growproc+0x5c>
  p->sz = sz;
    800011c4:	1782                	slli	a5,a5,0x20
    800011c6:	9381                	srli	a5,a5,0x20
    800011c8:	04f93423          	sd	a5,72(s2)
  return 0;
    800011cc:	4501                	li	a0,0
}
    800011ce:	60e2                	ld	ra,24(sp)
    800011d0:	6442                	ld	s0,16(sp)
    800011d2:	64a2                	ld	s1,8(sp)
    800011d4:	6902                	ld	s2,0(sp)
    800011d6:	6105                	addi	sp,sp,32
    800011d8:	8082                	ret
    if((sz = uvmalloc(p->pagetable, sz, sz + n)) == 0) {
    800011da:	00f4863b          	addw	a2,s1,a5
    800011de:	1602                	slli	a2,a2,0x20
    800011e0:	9201                	srli	a2,a2,0x20
    800011e2:	1582                	slli	a1,a1,0x20
    800011e4:	9181                	srli	a1,a1,0x20
    800011e6:	6928                	ld	a0,80(a0)
    800011e8:	fffff097          	auipc	ra,0xfffff
    800011ec:	6cc080e7          	jalr	1740(ra) # 800008b4 <uvmalloc>
    800011f0:	0005079b          	sext.w	a5,a0
    800011f4:	fbe1                	bnez	a5,800011c4 <growproc+0x26>
      return -1;
    800011f6:	557d                	li	a0,-1
    800011f8:	bfd9                	j	800011ce <growproc+0x30>
    sz = uvmdealloc(p->pagetable, sz, sz + n);
    800011fa:	00f4863b          	addw	a2,s1,a5
    800011fe:	1602                	slli	a2,a2,0x20
    80001200:	9201                	srli	a2,a2,0x20
    80001202:	1582                	slli	a1,a1,0x20
    80001204:	9181                	srli	a1,a1,0x20
    80001206:	6928                	ld	a0,80(a0)
    80001208:	fffff097          	auipc	ra,0xfffff
    8000120c:	664080e7          	jalr	1636(ra) # 8000086c <uvmdealloc>
    80001210:	0005079b          	sext.w	a5,a0
    80001214:	bf45                	j	800011c4 <growproc+0x26>

0000000080001216 <fork>:
{
    80001216:	7139                	addi	sp,sp,-64
    80001218:	fc06                	sd	ra,56(sp)
    8000121a:	f822                	sd	s0,48(sp)
    8000121c:	f426                	sd	s1,40(sp)
    8000121e:	f04a                	sd	s2,32(sp)
    80001220:	ec4e                	sd	s3,24(sp)
    80001222:	e852                	sd	s4,16(sp)
    80001224:	e456                	sd	s5,8(sp)
    80001226:	0080                	addi	s0,sp,64
  struct proc *p = myproc();
    80001228:	00000097          	auipc	ra,0x0
    8000122c:	c1c080e7          	jalr	-996(ra) # 80000e44 <myproc>
    80001230:	8aaa                	mv	s5,a0
  if((np = allocproc()) == 0){
    80001232:	00000097          	auipc	ra,0x0
    80001236:	e1c080e7          	jalr	-484(ra) # 8000104e <allocproc>
    8000123a:	10050c63          	beqz	a0,80001352 <fork+0x13c>
    8000123e:	8a2a                	mv	s4,a0
  if(uvmcopy(p->pagetable, np->pagetable, p->sz) < 0){
    80001240:	048ab603          	ld	a2,72(s5)
    80001244:	692c                	ld	a1,80(a0)
    80001246:	050ab503          	ld	a0,80(s5)
    8000124a:	fffff097          	auipc	ra,0xfffff
    8000124e:	7ba080e7          	jalr	1978(ra) # 80000a04 <uvmcopy>
    80001252:	04054863          	bltz	a0,800012a2 <fork+0x8c>
  np->sz = p->sz;
    80001256:	048ab783          	ld	a5,72(s5)
    8000125a:	04fa3423          	sd	a5,72(s4)
  *(np->trapframe) = *(p->trapframe);
    8000125e:	058ab683          	ld	a3,88(s5)
    80001262:	87b6                	mv	a5,a3
    80001264:	058a3703          	ld	a4,88(s4)
    80001268:	12068693          	addi	a3,a3,288
    8000126c:	0007b803          	ld	a6,0(a5) # 1000 <_entry-0x7ffff000>
    80001270:	6788                	ld	a0,8(a5)
    80001272:	6b8c                	ld	a1,16(a5)
    80001274:	6f90                	ld	a2,24(a5)
    80001276:	01073023          	sd	a6,0(a4)
    8000127a:	e708                	sd	a0,8(a4)
    8000127c:	eb0c                	sd	a1,16(a4)
    8000127e:	ef10                	sd	a2,24(a4)
    80001280:	02078793          	addi	a5,a5,32
    80001284:	02070713          	addi	a4,a4,32
    80001288:	fed792e3          	bne	a5,a3,8000126c <fork+0x56>
  np->trapframe->a0 = 0;
    8000128c:	058a3783          	ld	a5,88(s4)
    80001290:	0607b823          	sd	zero,112(a5)
  for(i = 0; i < NOFILE; i++)
    80001294:	0d0a8493          	addi	s1,s5,208
    80001298:	0d0a0913          	addi	s2,s4,208
    8000129c:	150a8993          	addi	s3,s5,336
    800012a0:	a00d                	j	800012c2 <fork+0xac>
    freeproc(np);
    800012a2:	8552                	mv	a0,s4
    800012a4:	00000097          	auipc	ra,0x0
    800012a8:	d52080e7          	jalr	-686(ra) # 80000ff6 <freeproc>
    release(&np->lock);
    800012ac:	8552                	mv	a0,s4
    800012ae:	00005097          	auipc	ra,0x5
    800012b2:	fae080e7          	jalr	-82(ra) # 8000625c <release>
    return -1;
    800012b6:	597d                	li	s2,-1
    800012b8:	a059                	j	8000133e <fork+0x128>
  for(i = 0; i < NOFILE; i++)
    800012ba:	04a1                	addi	s1,s1,8
    800012bc:	0921                	addi	s2,s2,8
    800012be:	01348b63          	beq	s1,s3,800012d4 <fork+0xbe>
    if(p->ofile[i])
    800012c2:	6088                	ld	a0,0(s1)
    800012c4:	d97d                	beqz	a0,800012ba <fork+0xa4>
      np->ofile[i] = filedup(p->ofile[i]);
    800012c6:	00002097          	auipc	ra,0x2
    800012ca:	746080e7          	jalr	1862(ra) # 80003a0c <filedup>
    800012ce:	00a93023          	sd	a0,0(s2)
    800012d2:	b7e5                	j	800012ba <fork+0xa4>
  np->cwd = idup(p->cwd);
    800012d4:	150ab503          	ld	a0,336(s5)
    800012d8:	00002097          	auipc	ra,0x2
    800012dc:	820080e7          	jalr	-2016(ra) # 80002af8 <idup>
    800012e0:	14aa3823          	sd	a0,336(s4)
  safestrcpy(np->name, p->name, sizeof(p->name));
    800012e4:	4641                	li	a2,16
    800012e6:	158a8593          	addi	a1,s5,344
    800012ea:	158a0513          	addi	a0,s4,344
    800012ee:	fffff097          	auipc	ra,0xfffff
    800012f2:	fd6080e7          	jalr	-42(ra) # 800002c4 <safestrcpy>
  pid = np->pid;
    800012f6:	030a2903          	lw	s2,48(s4)
  release(&np->lock);
    800012fa:	8552                	mv	a0,s4
    800012fc:	00005097          	auipc	ra,0x5
    80001300:	f60080e7          	jalr	-160(ra) # 8000625c <release>
  acquire(&wait_lock);
    80001304:	00008497          	auipc	s1,0x8
    80001308:	d6448493          	addi	s1,s1,-668 # 80009068 <wait_lock>
    8000130c:	8526                	mv	a0,s1
    8000130e:	00005097          	auipc	ra,0x5
    80001312:	e9a080e7          	jalr	-358(ra) # 800061a8 <acquire>
  np->parent = p;
    80001316:	035a3c23          	sd	s5,56(s4)
  release(&wait_lock);
    8000131a:	8526                	mv	a0,s1
    8000131c:	00005097          	auipc	ra,0x5
    80001320:	f40080e7          	jalr	-192(ra) # 8000625c <release>
  acquire(&np->lock);
    80001324:	8552                	mv	a0,s4
    80001326:	00005097          	auipc	ra,0x5
    8000132a:	e82080e7          	jalr	-382(ra) # 800061a8 <acquire>
  np->state = RUNNABLE;
    8000132e:	478d                	li	a5,3
    80001330:	00fa2c23          	sw	a5,24(s4)
  release(&np->lock);
    80001334:	8552                	mv	a0,s4
    80001336:	00005097          	auipc	ra,0x5
    8000133a:	f26080e7          	jalr	-218(ra) # 8000625c <release>
}
    8000133e:	854a                	mv	a0,s2
    80001340:	70e2                	ld	ra,56(sp)
    80001342:	7442                	ld	s0,48(sp)
    80001344:	74a2                	ld	s1,40(sp)
    80001346:	7902                	ld	s2,32(sp)
    80001348:	69e2                	ld	s3,24(sp)
    8000134a:	6a42                	ld	s4,16(sp)
    8000134c:	6aa2                	ld	s5,8(sp)
    8000134e:	6121                	addi	sp,sp,64
    80001350:	8082                	ret
    return -1;
    80001352:	597d                	li	s2,-1
    80001354:	b7ed                	j	8000133e <fork+0x128>

0000000080001356 <scheduler>:
{
    80001356:	7139                	addi	sp,sp,-64
    80001358:	fc06                	sd	ra,56(sp)
    8000135a:	f822                	sd	s0,48(sp)
    8000135c:	f426                	sd	s1,40(sp)
    8000135e:	f04a                	sd	s2,32(sp)
    80001360:	ec4e                	sd	s3,24(sp)
    80001362:	e852                	sd	s4,16(sp)
    80001364:	e456                	sd	s5,8(sp)
    80001366:	e05a                	sd	s6,0(sp)
    80001368:	0080                	addi	s0,sp,64
    8000136a:	8792                	mv	a5,tp
  int id = r_tp();
    8000136c:	2781                	sext.w	a5,a5
  c->proc = 0;
    8000136e:	00779a93          	slli	s5,a5,0x7
    80001372:	00008717          	auipc	a4,0x8
    80001376:	cde70713          	addi	a4,a4,-802 # 80009050 <pid_lock>
    8000137a:	9756                	add	a4,a4,s5
    8000137c:	02073823          	sd	zero,48(a4)
        swtch(&c->context, &p->context);
    80001380:	00008717          	auipc	a4,0x8
    80001384:	d0870713          	addi	a4,a4,-760 # 80009088 <cpus+0x8>
    80001388:	9aba                	add	s5,s5,a4
      if(p->state == RUNNABLE) {
    8000138a:	498d                	li	s3,3
        p->state = RUNNING;
    8000138c:	4b11                	li	s6,4
        c->proc = p;
    8000138e:	079e                	slli	a5,a5,0x7
    80001390:	00008a17          	auipc	s4,0x8
    80001394:	cc0a0a13          	addi	s4,s4,-832 # 80009050 <pid_lock>
    80001398:	9a3e                	add	s4,s4,a5
    for(p = proc; p < &proc[NPROC]; p++) {
    8000139a:	00009917          	auipc	s2,0x9
    8000139e:	ef690913          	addi	s2,s2,-266 # 8000a290 <tickslock>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    800013a2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    800013a6:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    800013aa:	10079073          	csrw	sstatus,a5
    800013ae:	00008497          	auipc	s1,0x8
    800013b2:	0d248493          	addi	s1,s1,210 # 80009480 <proc>
    800013b6:	a811                	j	800013ca <scheduler+0x74>
      release(&p->lock);
    800013b8:	8526                	mv	a0,s1
    800013ba:	00005097          	auipc	ra,0x5
    800013be:	ea2080e7          	jalr	-350(ra) # 8000625c <release>
    for(p = proc; p < &proc[NPROC]; p++) {
    800013c2:	16848493          	addi	s1,s1,360
    800013c6:	fd248ee3          	beq	s1,s2,800013a2 <scheduler+0x4c>
      acquire(&p->lock);
    800013ca:	8526                	mv	a0,s1
    800013cc:	00005097          	auipc	ra,0x5
    800013d0:	ddc080e7          	jalr	-548(ra) # 800061a8 <acquire>
      if(p->state == RUNNABLE) {
    800013d4:	4c9c                	lw	a5,24(s1)
    800013d6:	ff3791e3          	bne	a5,s3,800013b8 <scheduler+0x62>
        p->state = RUNNING;
    800013da:	0164ac23          	sw	s6,24(s1)
        c->proc = p;
    800013de:	029a3823          	sd	s1,48(s4)
        swtch(&c->context, &p->context);
    800013e2:	06048593          	addi	a1,s1,96
    800013e6:	8556                	mv	a0,s5
    800013e8:	00000097          	auipc	ra,0x0
    800013ec:	620080e7          	jalr	1568(ra) # 80001a08 <swtch>
        c->proc = 0;
    800013f0:	020a3823          	sd	zero,48(s4)
    800013f4:	b7d1                	j	800013b8 <scheduler+0x62>

00000000800013f6 <sched>:
{
    800013f6:	7179                	addi	sp,sp,-48
    800013f8:	f406                	sd	ra,40(sp)
    800013fa:	f022                	sd	s0,32(sp)
    800013fc:	ec26                	sd	s1,24(sp)
    800013fe:	e84a                	sd	s2,16(sp)
    80001400:	e44e                	sd	s3,8(sp)
    80001402:	1800                	addi	s0,sp,48
  struct proc *p = myproc();
    80001404:	00000097          	auipc	ra,0x0
    80001408:	a40080e7          	jalr	-1472(ra) # 80000e44 <myproc>
    8000140c:	84aa                	mv	s1,a0
  if(!holding(&p->lock))
    8000140e:	00005097          	auipc	ra,0x5
    80001412:	d20080e7          	jalr	-736(ra) # 8000612e <holding>
    80001416:	c93d                	beqz	a0,8000148c <sched+0x96>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001418:	8792                	mv	a5,tp
  if(mycpu()->noff != 1)
    8000141a:	2781                	sext.w	a5,a5
    8000141c:	079e                	slli	a5,a5,0x7
    8000141e:	00008717          	auipc	a4,0x8
    80001422:	c3270713          	addi	a4,a4,-974 # 80009050 <pid_lock>
    80001426:	97ba                	add	a5,a5,a4
    80001428:	0a87a703          	lw	a4,168(a5)
    8000142c:	4785                	li	a5,1
    8000142e:	06f71763          	bne	a4,a5,8000149c <sched+0xa6>
  if(p->state == RUNNING)
    80001432:	4c98                	lw	a4,24(s1)
    80001434:	4791                	li	a5,4
    80001436:	06f70b63          	beq	a4,a5,800014ac <sched+0xb6>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000143a:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    8000143e:	8b89                	andi	a5,a5,2
  if(intr_get())
    80001440:	efb5                	bnez	a5,800014bc <sched+0xc6>
  asm volatile("mv %0, tp" : "=r" (x) );
    80001442:	8792                	mv	a5,tp
  intena = mycpu()->intena;
    80001444:	00008917          	auipc	s2,0x8
    80001448:	c0c90913          	addi	s2,s2,-1012 # 80009050 <pid_lock>
    8000144c:	2781                	sext.w	a5,a5
    8000144e:	079e                	slli	a5,a5,0x7
    80001450:	97ca                	add	a5,a5,s2
    80001452:	0ac7a983          	lw	s3,172(a5)
    80001456:	8792                	mv	a5,tp
  swtch(&p->context, &mycpu()->context);
    80001458:	2781                	sext.w	a5,a5
    8000145a:	079e                	slli	a5,a5,0x7
    8000145c:	00008597          	auipc	a1,0x8
    80001460:	c2c58593          	addi	a1,a1,-980 # 80009088 <cpus+0x8>
    80001464:	95be                	add	a1,a1,a5
    80001466:	06048513          	addi	a0,s1,96
    8000146a:	00000097          	auipc	ra,0x0
    8000146e:	59e080e7          	jalr	1438(ra) # 80001a08 <swtch>
    80001472:	8792                	mv	a5,tp
  mycpu()->intena = intena;
    80001474:	2781                	sext.w	a5,a5
    80001476:	079e                	slli	a5,a5,0x7
    80001478:	993e                	add	s2,s2,a5
    8000147a:	0b392623          	sw	s3,172(s2)
}
    8000147e:	70a2                	ld	ra,40(sp)
    80001480:	7402                	ld	s0,32(sp)
    80001482:	64e2                	ld	s1,24(sp)
    80001484:	6942                	ld	s2,16(sp)
    80001486:	69a2                	ld	s3,8(sp)
    80001488:	6145                	addi	sp,sp,48
    8000148a:	8082                	ret
    panic("sched p->lock");
    8000148c:	00007517          	auipc	a0,0x7
    80001490:	d0c50513          	addi	a0,a0,-756 # 80008198 <etext+0x198>
    80001494:	00004097          	auipc	ra,0x4
    80001498:	7dc080e7          	jalr	2012(ra) # 80005c70 <panic>
    panic("sched locks");
    8000149c:	00007517          	auipc	a0,0x7
    800014a0:	d0c50513          	addi	a0,a0,-756 # 800081a8 <etext+0x1a8>
    800014a4:	00004097          	auipc	ra,0x4
    800014a8:	7cc080e7          	jalr	1996(ra) # 80005c70 <panic>
    panic("sched running");
    800014ac:	00007517          	auipc	a0,0x7
    800014b0:	d0c50513          	addi	a0,a0,-756 # 800081b8 <etext+0x1b8>
    800014b4:	00004097          	auipc	ra,0x4
    800014b8:	7bc080e7          	jalr	1980(ra) # 80005c70 <panic>
    panic("sched interruptible");
    800014bc:	00007517          	auipc	a0,0x7
    800014c0:	d0c50513          	addi	a0,a0,-756 # 800081c8 <etext+0x1c8>
    800014c4:	00004097          	auipc	ra,0x4
    800014c8:	7ac080e7          	jalr	1964(ra) # 80005c70 <panic>

00000000800014cc <yield>:
{
    800014cc:	1101                	addi	sp,sp,-32
    800014ce:	ec06                	sd	ra,24(sp)
    800014d0:	e822                	sd	s0,16(sp)
    800014d2:	e426                	sd	s1,8(sp)
    800014d4:	1000                	addi	s0,sp,32
  struct proc *p = myproc();
    800014d6:	00000097          	auipc	ra,0x0
    800014da:	96e080e7          	jalr	-1682(ra) # 80000e44 <myproc>
    800014de:	84aa                	mv	s1,a0
  acquire(&p->lock);
    800014e0:	00005097          	auipc	ra,0x5
    800014e4:	cc8080e7          	jalr	-824(ra) # 800061a8 <acquire>
  p->state = RUNNABLE;
    800014e8:	478d                	li	a5,3
    800014ea:	cc9c                	sw	a5,24(s1)
  sched();
    800014ec:	00000097          	auipc	ra,0x0
    800014f0:	f0a080e7          	jalr	-246(ra) # 800013f6 <sched>
  release(&p->lock);
    800014f4:	8526                	mv	a0,s1
    800014f6:	00005097          	auipc	ra,0x5
    800014fa:	d66080e7          	jalr	-666(ra) # 8000625c <release>
}
    800014fe:	60e2                	ld	ra,24(sp)
    80001500:	6442                	ld	s0,16(sp)
    80001502:	64a2                	ld	s1,8(sp)
    80001504:	6105                	addi	sp,sp,32
    80001506:	8082                	ret

0000000080001508 <sleep>:

// Atomically release lock and sleep on chan.
// Reacquires lock when awakened.
void
sleep(void *chan, struct spinlock *lk)
{
    80001508:	7179                	addi	sp,sp,-48
    8000150a:	f406                	sd	ra,40(sp)
    8000150c:	f022                	sd	s0,32(sp)
    8000150e:	ec26                	sd	s1,24(sp)
    80001510:	e84a                	sd	s2,16(sp)
    80001512:	e44e                	sd	s3,8(sp)
    80001514:	1800                	addi	s0,sp,48
    80001516:	89aa                	mv	s3,a0
    80001518:	892e                	mv	s2,a1
  struct proc *p = myproc();
    8000151a:	00000097          	auipc	ra,0x0
    8000151e:	92a080e7          	jalr	-1750(ra) # 80000e44 <myproc>
    80001522:	84aa                	mv	s1,a0
  // Once we hold p->lock, we can be
  // guaranteed that we won't miss any wakeup
  // (wakeup locks p->lock),
  // so it's okay to release lk.

  acquire(&p->lock);  //DOC: sleeplock1
    80001524:	00005097          	auipc	ra,0x5
    80001528:	c84080e7          	jalr	-892(ra) # 800061a8 <acquire>
  release(lk);
    8000152c:	854a                	mv	a0,s2
    8000152e:	00005097          	auipc	ra,0x5
    80001532:	d2e080e7          	jalr	-722(ra) # 8000625c <release>

  // Go to sleep.
  p->chan = chan;
    80001536:	0334b023          	sd	s3,32(s1)
  p->state = SLEEPING;
    8000153a:	4789                	li	a5,2
    8000153c:	cc9c                	sw	a5,24(s1)

  sched();
    8000153e:	00000097          	auipc	ra,0x0
    80001542:	eb8080e7          	jalr	-328(ra) # 800013f6 <sched>

  // Tidy up.
  p->chan = 0;
    80001546:	0204b023          	sd	zero,32(s1)

  // Reacquire original lock.
  release(&p->lock);
    8000154a:	8526                	mv	a0,s1
    8000154c:	00005097          	auipc	ra,0x5
    80001550:	d10080e7          	jalr	-752(ra) # 8000625c <release>
  acquire(lk);
    80001554:	854a                	mv	a0,s2
    80001556:	00005097          	auipc	ra,0x5
    8000155a:	c52080e7          	jalr	-942(ra) # 800061a8 <acquire>
}
    8000155e:	70a2                	ld	ra,40(sp)
    80001560:	7402                	ld	s0,32(sp)
    80001562:	64e2                	ld	s1,24(sp)
    80001564:	6942                	ld	s2,16(sp)
    80001566:	69a2                	ld	s3,8(sp)
    80001568:	6145                	addi	sp,sp,48
    8000156a:	8082                	ret

000000008000156c <wait>:
{
    8000156c:	715d                	addi	sp,sp,-80
    8000156e:	e486                	sd	ra,72(sp)
    80001570:	e0a2                	sd	s0,64(sp)
    80001572:	fc26                	sd	s1,56(sp)
    80001574:	f84a                	sd	s2,48(sp)
    80001576:	f44e                	sd	s3,40(sp)
    80001578:	f052                	sd	s4,32(sp)
    8000157a:	ec56                	sd	s5,24(sp)
    8000157c:	e85a                	sd	s6,16(sp)
    8000157e:	e45e                	sd	s7,8(sp)
    80001580:	e062                	sd	s8,0(sp)
    80001582:	0880                	addi	s0,sp,80
    80001584:	8aaa                	mv	s5,a0
  struct proc *p = myproc();
    80001586:	00000097          	auipc	ra,0x0
    8000158a:	8be080e7          	jalr	-1858(ra) # 80000e44 <myproc>
    8000158e:	892a                	mv	s2,a0
  acquire(&wait_lock);
    80001590:	00008517          	auipc	a0,0x8
    80001594:	ad850513          	addi	a0,a0,-1320 # 80009068 <wait_lock>
    80001598:	00005097          	auipc	ra,0x5
    8000159c:	c10080e7          	jalr	-1008(ra) # 800061a8 <acquire>
    havekids = 0;
    800015a0:	4b81                	li	s7,0
        if(np->state == ZOMBIE){
    800015a2:	4a15                	li	s4,5
        havekids = 1;
    800015a4:	4b05                	li	s6,1
    for(np = proc; np < &proc[NPROC]; np++){
    800015a6:	00009997          	auipc	s3,0x9
    800015aa:	cea98993          	addi	s3,s3,-790 # 8000a290 <tickslock>
    sleep(p, &wait_lock);  //DOC: wait-sleep
    800015ae:	00008c17          	auipc	s8,0x8
    800015b2:	abac0c13          	addi	s8,s8,-1350 # 80009068 <wait_lock>
    havekids = 0;
    800015b6:	875e                	mv	a4,s7
    for(np = proc; np < &proc[NPROC]; np++){
    800015b8:	00008497          	auipc	s1,0x8
    800015bc:	ec848493          	addi	s1,s1,-312 # 80009480 <proc>
    800015c0:	a0bd                	j	8000162e <wait+0xc2>
          pid = np->pid;
    800015c2:	0304a983          	lw	s3,48(s1)
          if(addr != 0 && copyout(p->pagetable, addr, (char *)&np->xstate,
    800015c6:	000a8e63          	beqz	s5,800015e2 <wait+0x76>
    800015ca:	4691                	li	a3,4
    800015cc:	02c48613          	addi	a2,s1,44
    800015d0:	85d6                	mv	a1,s5
    800015d2:	05093503          	ld	a0,80(s2)
    800015d6:	fffff097          	auipc	ra,0xfffff
    800015da:	532080e7          	jalr	1330(ra) # 80000b08 <copyout>
    800015de:	02054563          	bltz	a0,80001608 <wait+0x9c>
          freeproc(np);
    800015e2:	8526                	mv	a0,s1
    800015e4:	00000097          	auipc	ra,0x0
    800015e8:	a12080e7          	jalr	-1518(ra) # 80000ff6 <freeproc>
          release(&np->lock);
    800015ec:	8526                	mv	a0,s1
    800015ee:	00005097          	auipc	ra,0x5
    800015f2:	c6e080e7          	jalr	-914(ra) # 8000625c <release>
          release(&wait_lock);
    800015f6:	00008517          	auipc	a0,0x8
    800015fa:	a7250513          	addi	a0,a0,-1422 # 80009068 <wait_lock>
    800015fe:	00005097          	auipc	ra,0x5
    80001602:	c5e080e7          	jalr	-930(ra) # 8000625c <release>
          return pid;
    80001606:	a09d                	j	8000166c <wait+0x100>
            release(&np->lock);
    80001608:	8526                	mv	a0,s1
    8000160a:	00005097          	auipc	ra,0x5
    8000160e:	c52080e7          	jalr	-942(ra) # 8000625c <release>
            release(&wait_lock);
    80001612:	00008517          	auipc	a0,0x8
    80001616:	a5650513          	addi	a0,a0,-1450 # 80009068 <wait_lock>
    8000161a:	00005097          	auipc	ra,0x5
    8000161e:	c42080e7          	jalr	-958(ra) # 8000625c <release>
            return -1;
    80001622:	59fd                	li	s3,-1
    80001624:	a0a1                	j	8000166c <wait+0x100>
    for(np = proc; np < &proc[NPROC]; np++){
    80001626:	16848493          	addi	s1,s1,360
    8000162a:	03348463          	beq	s1,s3,80001652 <wait+0xe6>
      if(np->parent == p){
    8000162e:	7c9c                	ld	a5,56(s1)
    80001630:	ff279be3          	bne	a5,s2,80001626 <wait+0xba>
        acquire(&np->lock);
    80001634:	8526                	mv	a0,s1
    80001636:	00005097          	auipc	ra,0x5
    8000163a:	b72080e7          	jalr	-1166(ra) # 800061a8 <acquire>
        if(np->state == ZOMBIE){
    8000163e:	4c9c                	lw	a5,24(s1)
    80001640:	f94781e3          	beq	a5,s4,800015c2 <wait+0x56>
        release(&np->lock);
    80001644:	8526                	mv	a0,s1
    80001646:	00005097          	auipc	ra,0x5
    8000164a:	c16080e7          	jalr	-1002(ra) # 8000625c <release>
        havekids = 1;
    8000164e:	875a                	mv	a4,s6
    80001650:	bfd9                	j	80001626 <wait+0xba>
    if(!havekids || p->killed){
    80001652:	c701                	beqz	a4,8000165a <wait+0xee>
    80001654:	02892783          	lw	a5,40(s2)
    80001658:	c79d                	beqz	a5,80001686 <wait+0x11a>
      release(&wait_lock);
    8000165a:	00008517          	auipc	a0,0x8
    8000165e:	a0e50513          	addi	a0,a0,-1522 # 80009068 <wait_lock>
    80001662:	00005097          	auipc	ra,0x5
    80001666:	bfa080e7          	jalr	-1030(ra) # 8000625c <release>
      return -1;
    8000166a:	59fd                	li	s3,-1
}
    8000166c:	854e                	mv	a0,s3
    8000166e:	60a6                	ld	ra,72(sp)
    80001670:	6406                	ld	s0,64(sp)
    80001672:	74e2                	ld	s1,56(sp)
    80001674:	7942                	ld	s2,48(sp)
    80001676:	79a2                	ld	s3,40(sp)
    80001678:	7a02                	ld	s4,32(sp)
    8000167a:	6ae2                	ld	s5,24(sp)
    8000167c:	6b42                	ld	s6,16(sp)
    8000167e:	6ba2                	ld	s7,8(sp)
    80001680:	6c02                	ld	s8,0(sp)
    80001682:	6161                	addi	sp,sp,80
    80001684:	8082                	ret
    sleep(p, &wait_lock);  //DOC: wait-sleep
    80001686:	85e2                	mv	a1,s8
    80001688:	854a                	mv	a0,s2
    8000168a:	00000097          	auipc	ra,0x0
    8000168e:	e7e080e7          	jalr	-386(ra) # 80001508 <sleep>
    havekids = 0;
    80001692:	b715                	j	800015b6 <wait+0x4a>

0000000080001694 <wakeup>:

// Wake up all processes sleeping on chan.
// Must be called without any p->lock.
void
wakeup(void *chan)
{
    80001694:	7139                	addi	sp,sp,-64
    80001696:	fc06                	sd	ra,56(sp)
    80001698:	f822                	sd	s0,48(sp)
    8000169a:	f426                	sd	s1,40(sp)
    8000169c:	f04a                	sd	s2,32(sp)
    8000169e:	ec4e                	sd	s3,24(sp)
    800016a0:	e852                	sd	s4,16(sp)
    800016a2:	e456                	sd	s5,8(sp)
    800016a4:	0080                	addi	s0,sp,64
    800016a6:	8a2a                	mv	s4,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++) {
    800016a8:	00008497          	auipc	s1,0x8
    800016ac:	dd848493          	addi	s1,s1,-552 # 80009480 <proc>
    if(p != myproc()){
      acquire(&p->lock);
      if(p->state == SLEEPING && p->chan == chan) {
    800016b0:	4989                	li	s3,2
        p->state = RUNNABLE;
    800016b2:	4a8d                	li	s5,3
  for(p = proc; p < &proc[NPROC]; p++) {
    800016b4:	00009917          	auipc	s2,0x9
    800016b8:	bdc90913          	addi	s2,s2,-1060 # 8000a290 <tickslock>
    800016bc:	a811                	j	800016d0 <wakeup+0x3c>
      }
      release(&p->lock);
    800016be:	8526                	mv	a0,s1
    800016c0:	00005097          	auipc	ra,0x5
    800016c4:	b9c080e7          	jalr	-1124(ra) # 8000625c <release>
  for(p = proc; p < &proc[NPROC]; p++) {
    800016c8:	16848493          	addi	s1,s1,360
    800016cc:	03248663          	beq	s1,s2,800016f8 <wakeup+0x64>
    if(p != myproc()){
    800016d0:	fffff097          	auipc	ra,0xfffff
    800016d4:	774080e7          	jalr	1908(ra) # 80000e44 <myproc>
    800016d8:	fea488e3          	beq	s1,a0,800016c8 <wakeup+0x34>
      acquire(&p->lock);
    800016dc:	8526                	mv	a0,s1
    800016de:	00005097          	auipc	ra,0x5
    800016e2:	aca080e7          	jalr	-1334(ra) # 800061a8 <acquire>
      if(p->state == SLEEPING && p->chan == chan) {
    800016e6:	4c9c                	lw	a5,24(s1)
    800016e8:	fd379be3          	bne	a5,s3,800016be <wakeup+0x2a>
    800016ec:	709c                	ld	a5,32(s1)
    800016ee:	fd4798e3          	bne	a5,s4,800016be <wakeup+0x2a>
        p->state = RUNNABLE;
    800016f2:	0154ac23          	sw	s5,24(s1)
    800016f6:	b7e1                	j	800016be <wakeup+0x2a>
    }
  }
}
    800016f8:	70e2                	ld	ra,56(sp)
    800016fa:	7442                	ld	s0,48(sp)
    800016fc:	74a2                	ld	s1,40(sp)
    800016fe:	7902                	ld	s2,32(sp)
    80001700:	69e2                	ld	s3,24(sp)
    80001702:	6a42                	ld	s4,16(sp)
    80001704:	6aa2                	ld	s5,8(sp)
    80001706:	6121                	addi	sp,sp,64
    80001708:	8082                	ret

000000008000170a <reparent>:
{
    8000170a:	7179                	addi	sp,sp,-48
    8000170c:	f406                	sd	ra,40(sp)
    8000170e:	f022                	sd	s0,32(sp)
    80001710:	ec26                	sd	s1,24(sp)
    80001712:	e84a                	sd	s2,16(sp)
    80001714:	e44e                	sd	s3,8(sp)
    80001716:	e052                	sd	s4,0(sp)
    80001718:	1800                	addi	s0,sp,48
    8000171a:	892a                	mv	s2,a0
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000171c:	00008497          	auipc	s1,0x8
    80001720:	d6448493          	addi	s1,s1,-668 # 80009480 <proc>
      pp->parent = initproc;
    80001724:	00008a17          	auipc	s4,0x8
    80001728:	8eca0a13          	addi	s4,s4,-1812 # 80009010 <initproc>
  for(pp = proc; pp < &proc[NPROC]; pp++){
    8000172c:	00009997          	auipc	s3,0x9
    80001730:	b6498993          	addi	s3,s3,-1180 # 8000a290 <tickslock>
    80001734:	a029                	j	8000173e <reparent+0x34>
    80001736:	16848493          	addi	s1,s1,360
    8000173a:	01348d63          	beq	s1,s3,80001754 <reparent+0x4a>
    if(pp->parent == p){
    8000173e:	7c9c                	ld	a5,56(s1)
    80001740:	ff279be3          	bne	a5,s2,80001736 <reparent+0x2c>
      pp->parent = initproc;
    80001744:	000a3503          	ld	a0,0(s4)
    80001748:	fc88                	sd	a0,56(s1)
      wakeup(initproc);
    8000174a:	00000097          	auipc	ra,0x0
    8000174e:	f4a080e7          	jalr	-182(ra) # 80001694 <wakeup>
    80001752:	b7d5                	j	80001736 <reparent+0x2c>
}
    80001754:	70a2                	ld	ra,40(sp)
    80001756:	7402                	ld	s0,32(sp)
    80001758:	64e2                	ld	s1,24(sp)
    8000175a:	6942                	ld	s2,16(sp)
    8000175c:	69a2                	ld	s3,8(sp)
    8000175e:	6a02                	ld	s4,0(sp)
    80001760:	6145                	addi	sp,sp,48
    80001762:	8082                	ret

0000000080001764 <exit>:
{
    80001764:	7179                	addi	sp,sp,-48
    80001766:	f406                	sd	ra,40(sp)
    80001768:	f022                	sd	s0,32(sp)
    8000176a:	ec26                	sd	s1,24(sp)
    8000176c:	e84a                	sd	s2,16(sp)
    8000176e:	e44e                	sd	s3,8(sp)
    80001770:	e052                	sd	s4,0(sp)
    80001772:	1800                	addi	s0,sp,48
    80001774:	8a2a                	mv	s4,a0
  struct proc *p = myproc();
    80001776:	fffff097          	auipc	ra,0xfffff
    8000177a:	6ce080e7          	jalr	1742(ra) # 80000e44 <myproc>
    8000177e:	89aa                	mv	s3,a0
  if(p == initproc)
    80001780:	00008797          	auipc	a5,0x8
    80001784:	8907b783          	ld	a5,-1904(a5) # 80009010 <initproc>
    80001788:	0d050493          	addi	s1,a0,208
    8000178c:	15050913          	addi	s2,a0,336
    80001790:	02a79363          	bne	a5,a0,800017b6 <exit+0x52>
    panic("init exiting");
    80001794:	00007517          	auipc	a0,0x7
    80001798:	a4c50513          	addi	a0,a0,-1460 # 800081e0 <etext+0x1e0>
    8000179c:	00004097          	auipc	ra,0x4
    800017a0:	4d4080e7          	jalr	1236(ra) # 80005c70 <panic>
      fileclose(f);
    800017a4:	00002097          	auipc	ra,0x2
    800017a8:	2ba080e7          	jalr	698(ra) # 80003a5e <fileclose>
      p->ofile[fd] = 0;
    800017ac:	0004b023          	sd	zero,0(s1)
  for(int fd = 0; fd < NOFILE; fd++){
    800017b0:	04a1                	addi	s1,s1,8
    800017b2:	01248563          	beq	s1,s2,800017bc <exit+0x58>
    if(p->ofile[fd]){
    800017b6:	6088                	ld	a0,0(s1)
    800017b8:	f575                	bnez	a0,800017a4 <exit+0x40>
    800017ba:	bfdd                	j	800017b0 <exit+0x4c>
  begin_op();
    800017bc:	00002097          	auipc	ra,0x2
    800017c0:	dda080e7          	jalr	-550(ra) # 80003596 <begin_op>
  iput(p->cwd);
    800017c4:	1509b503          	ld	a0,336(s3)
    800017c8:	00001097          	auipc	ra,0x1
    800017cc:	574080e7          	jalr	1396(ra) # 80002d3c <iput>
  end_op();
    800017d0:	00002097          	auipc	ra,0x2
    800017d4:	e44080e7          	jalr	-444(ra) # 80003614 <end_op>
  p->cwd = 0;
    800017d8:	1409b823          	sd	zero,336(s3)
  acquire(&wait_lock);
    800017dc:	00008497          	auipc	s1,0x8
    800017e0:	88c48493          	addi	s1,s1,-1908 # 80009068 <wait_lock>
    800017e4:	8526                	mv	a0,s1
    800017e6:	00005097          	auipc	ra,0x5
    800017ea:	9c2080e7          	jalr	-1598(ra) # 800061a8 <acquire>
  reparent(p);
    800017ee:	854e                	mv	a0,s3
    800017f0:	00000097          	auipc	ra,0x0
    800017f4:	f1a080e7          	jalr	-230(ra) # 8000170a <reparent>
  wakeup(p->parent);
    800017f8:	0389b503          	ld	a0,56(s3)
    800017fc:	00000097          	auipc	ra,0x0
    80001800:	e98080e7          	jalr	-360(ra) # 80001694 <wakeup>
  acquire(&p->lock);
    80001804:	854e                	mv	a0,s3
    80001806:	00005097          	auipc	ra,0x5
    8000180a:	9a2080e7          	jalr	-1630(ra) # 800061a8 <acquire>
  p->xstate = status;
    8000180e:	0349a623          	sw	s4,44(s3)
  p->state = ZOMBIE;
    80001812:	4795                	li	a5,5
    80001814:	00f9ac23          	sw	a5,24(s3)
  release(&wait_lock);
    80001818:	8526                	mv	a0,s1
    8000181a:	00005097          	auipc	ra,0x5
    8000181e:	a42080e7          	jalr	-1470(ra) # 8000625c <release>
  sched();
    80001822:	00000097          	auipc	ra,0x0
    80001826:	bd4080e7          	jalr	-1068(ra) # 800013f6 <sched>
  panic("zombie exit");
    8000182a:	00007517          	auipc	a0,0x7
    8000182e:	9c650513          	addi	a0,a0,-1594 # 800081f0 <etext+0x1f0>
    80001832:	00004097          	auipc	ra,0x4
    80001836:	43e080e7          	jalr	1086(ra) # 80005c70 <panic>

000000008000183a <kill>:
// Kill the process with the given pid.
// The victim won't exit until it tries to return
// to user space (see usertrap() in trap.c).
int
kill(int pid)
{
    8000183a:	7179                	addi	sp,sp,-48
    8000183c:	f406                	sd	ra,40(sp)
    8000183e:	f022                	sd	s0,32(sp)
    80001840:	ec26                	sd	s1,24(sp)
    80001842:	e84a                	sd	s2,16(sp)
    80001844:	e44e                	sd	s3,8(sp)
    80001846:	1800                	addi	s0,sp,48
    80001848:	892a                	mv	s2,a0
  struct proc *p;

  for(p = proc; p < &proc[NPROC]; p++){
    8000184a:	00008497          	auipc	s1,0x8
    8000184e:	c3648493          	addi	s1,s1,-970 # 80009480 <proc>
    80001852:	00009997          	auipc	s3,0x9
    80001856:	a3e98993          	addi	s3,s3,-1474 # 8000a290 <tickslock>
    acquire(&p->lock);
    8000185a:	8526                	mv	a0,s1
    8000185c:	00005097          	auipc	ra,0x5
    80001860:	94c080e7          	jalr	-1716(ra) # 800061a8 <acquire>
    if(p->pid == pid){
    80001864:	589c                	lw	a5,48(s1)
    80001866:	03278363          	beq	a5,s2,8000188c <kill+0x52>
        p->state = RUNNABLE;
      }
      release(&p->lock);
      return 0;
    }
    release(&p->lock);
    8000186a:	8526                	mv	a0,s1
    8000186c:	00005097          	auipc	ra,0x5
    80001870:	9f0080e7          	jalr	-1552(ra) # 8000625c <release>
  for(p = proc; p < &proc[NPROC]; p++){
    80001874:	16848493          	addi	s1,s1,360
    80001878:	ff3491e3          	bne	s1,s3,8000185a <kill+0x20>
  }
  return -1;
    8000187c:	557d                	li	a0,-1
}
    8000187e:	70a2                	ld	ra,40(sp)
    80001880:	7402                	ld	s0,32(sp)
    80001882:	64e2                	ld	s1,24(sp)
    80001884:	6942                	ld	s2,16(sp)
    80001886:	69a2                	ld	s3,8(sp)
    80001888:	6145                	addi	sp,sp,48
    8000188a:	8082                	ret
      p->killed = 1;
    8000188c:	4785                	li	a5,1
    8000188e:	d49c                	sw	a5,40(s1)
      if(p->state == SLEEPING){
    80001890:	4c98                	lw	a4,24(s1)
    80001892:	4789                	li	a5,2
    80001894:	00f70963          	beq	a4,a5,800018a6 <kill+0x6c>
      release(&p->lock);
    80001898:	8526                	mv	a0,s1
    8000189a:	00005097          	auipc	ra,0x5
    8000189e:	9c2080e7          	jalr	-1598(ra) # 8000625c <release>
      return 0;
    800018a2:	4501                	li	a0,0
    800018a4:	bfe9                	j	8000187e <kill+0x44>
        p->state = RUNNABLE;
    800018a6:	478d                	li	a5,3
    800018a8:	cc9c                	sw	a5,24(s1)
    800018aa:	b7fd                	j	80001898 <kill+0x5e>

00000000800018ac <either_copyout>:
// Copy to either a user address, or kernel address,
// depending on usr_dst.
// Returns 0 on success, -1 on error.
int
either_copyout(int user_dst, uint64 dst, void *src, uint64 len)
{
    800018ac:	7179                	addi	sp,sp,-48
    800018ae:	f406                	sd	ra,40(sp)
    800018b0:	f022                	sd	s0,32(sp)
    800018b2:	ec26                	sd	s1,24(sp)
    800018b4:	e84a                	sd	s2,16(sp)
    800018b6:	e44e                	sd	s3,8(sp)
    800018b8:	e052                	sd	s4,0(sp)
    800018ba:	1800                	addi	s0,sp,48
    800018bc:	84aa                	mv	s1,a0
    800018be:	892e                	mv	s2,a1
    800018c0:	89b2                	mv	s3,a2
    800018c2:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    800018c4:	fffff097          	auipc	ra,0xfffff
    800018c8:	580080e7          	jalr	1408(ra) # 80000e44 <myproc>
  if(user_dst){
    800018cc:	c08d                	beqz	s1,800018ee <either_copyout+0x42>
    return copyout(p->pagetable, dst, src, len);
    800018ce:	86d2                	mv	a3,s4
    800018d0:	864e                	mv	a2,s3
    800018d2:	85ca                	mv	a1,s2
    800018d4:	6928                	ld	a0,80(a0)
    800018d6:	fffff097          	auipc	ra,0xfffff
    800018da:	232080e7          	jalr	562(ra) # 80000b08 <copyout>
  } else {
    memmove((char *)dst, src, len);
    return 0;
  }
}
    800018de:	70a2                	ld	ra,40(sp)
    800018e0:	7402                	ld	s0,32(sp)
    800018e2:	64e2                	ld	s1,24(sp)
    800018e4:	6942                	ld	s2,16(sp)
    800018e6:	69a2                	ld	s3,8(sp)
    800018e8:	6a02                	ld	s4,0(sp)
    800018ea:	6145                	addi	sp,sp,48
    800018ec:	8082                	ret
    memmove((char *)dst, src, len);
    800018ee:	000a061b          	sext.w	a2,s4
    800018f2:	85ce                	mv	a1,s3
    800018f4:	854a                	mv	a0,s2
    800018f6:	fffff097          	auipc	ra,0xfffff
    800018fa:	8e0080e7          	jalr	-1824(ra) # 800001d6 <memmove>
    return 0;
    800018fe:	8526                	mv	a0,s1
    80001900:	bff9                	j	800018de <either_copyout+0x32>

0000000080001902 <either_copyin>:
// Copy from either a user address, or kernel address,
// depending on usr_src.
// Returns 0 on success, -1 on error.
int
either_copyin(void *dst, int user_src, uint64 src, uint64 len)
{
    80001902:	7179                	addi	sp,sp,-48
    80001904:	f406                	sd	ra,40(sp)
    80001906:	f022                	sd	s0,32(sp)
    80001908:	ec26                	sd	s1,24(sp)
    8000190a:	e84a                	sd	s2,16(sp)
    8000190c:	e44e                	sd	s3,8(sp)
    8000190e:	e052                	sd	s4,0(sp)
    80001910:	1800                	addi	s0,sp,48
    80001912:	892a                	mv	s2,a0
    80001914:	84ae                	mv	s1,a1
    80001916:	89b2                	mv	s3,a2
    80001918:	8a36                	mv	s4,a3
  struct proc *p = myproc();
    8000191a:	fffff097          	auipc	ra,0xfffff
    8000191e:	52a080e7          	jalr	1322(ra) # 80000e44 <myproc>
  if(user_src){
    80001922:	c08d                	beqz	s1,80001944 <either_copyin+0x42>
    return copyin(p->pagetable, dst, src, len);
    80001924:	86d2                	mv	a3,s4
    80001926:	864e                	mv	a2,s3
    80001928:	85ca                	mv	a1,s2
    8000192a:	6928                	ld	a0,80(a0)
    8000192c:	fffff097          	auipc	ra,0xfffff
    80001930:	268080e7          	jalr	616(ra) # 80000b94 <copyin>
  } else {
    memmove(dst, (char*)src, len);
    return 0;
  }
}
    80001934:	70a2                	ld	ra,40(sp)
    80001936:	7402                	ld	s0,32(sp)
    80001938:	64e2                	ld	s1,24(sp)
    8000193a:	6942                	ld	s2,16(sp)
    8000193c:	69a2                	ld	s3,8(sp)
    8000193e:	6a02                	ld	s4,0(sp)
    80001940:	6145                	addi	sp,sp,48
    80001942:	8082                	ret
    memmove(dst, (char*)src, len);
    80001944:	000a061b          	sext.w	a2,s4
    80001948:	85ce                	mv	a1,s3
    8000194a:	854a                	mv	a0,s2
    8000194c:	fffff097          	auipc	ra,0xfffff
    80001950:	88a080e7          	jalr	-1910(ra) # 800001d6 <memmove>
    return 0;
    80001954:	8526                	mv	a0,s1
    80001956:	bff9                	j	80001934 <either_copyin+0x32>

0000000080001958 <procdump>:
// Print a process listing to console.  For debugging.
// Runs when user types ^P on console.
// No lock to avoid wedging a stuck machine further.
void
procdump(void)
{
    80001958:	715d                	addi	sp,sp,-80
    8000195a:	e486                	sd	ra,72(sp)
    8000195c:	e0a2                	sd	s0,64(sp)
    8000195e:	fc26                	sd	s1,56(sp)
    80001960:	f84a                	sd	s2,48(sp)
    80001962:	f44e                	sd	s3,40(sp)
    80001964:	f052                	sd	s4,32(sp)
    80001966:	ec56                	sd	s5,24(sp)
    80001968:	e85a                	sd	s6,16(sp)
    8000196a:	e45e                	sd	s7,8(sp)
    8000196c:	0880                	addi	s0,sp,80
  [ZOMBIE]    "zombie"
  };
  struct proc *p;
  char *state;

  printf("\n");
    8000196e:	00007517          	auipc	a0,0x7
    80001972:	e2a50513          	addi	a0,a0,-470 # 80008798 <syscalls+0x3d0>
    80001976:	00004097          	auipc	ra,0x4
    8000197a:	344080e7          	jalr	836(ra) # 80005cba <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    8000197e:	00008497          	auipc	s1,0x8
    80001982:	c5a48493          	addi	s1,s1,-934 # 800095d8 <proc+0x158>
    80001986:	00009917          	auipc	s2,0x9
    8000198a:	a6290913          	addi	s2,s2,-1438 # 8000a3e8 <bcache+0x140>
    if(p->state == UNUSED)
      continue;
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    8000198e:	4b15                	li	s6,5
      state = states[p->state];
    else
      state = "???";
    80001990:	00007997          	auipc	s3,0x7
    80001994:	87098993          	addi	s3,s3,-1936 # 80008200 <etext+0x200>
    printf("%d %s %s", p->pid, state, p->name);
    80001998:	00007a97          	auipc	s5,0x7
    8000199c:	870a8a93          	addi	s5,s5,-1936 # 80008208 <etext+0x208>
    printf("\n");
    800019a0:	00007a17          	auipc	s4,0x7
    800019a4:	df8a0a13          	addi	s4,s4,-520 # 80008798 <syscalls+0x3d0>
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019a8:	00007b97          	auipc	s7,0x7
    800019ac:	898b8b93          	addi	s7,s7,-1896 # 80008240 <states.0>
    800019b0:	a00d                	j	800019d2 <procdump+0x7a>
    printf("%d %s %s", p->pid, state, p->name);
    800019b2:	ed86a583          	lw	a1,-296(a3)
    800019b6:	8556                	mv	a0,s5
    800019b8:	00004097          	auipc	ra,0x4
    800019bc:	302080e7          	jalr	770(ra) # 80005cba <printf>
    printf("\n");
    800019c0:	8552                	mv	a0,s4
    800019c2:	00004097          	auipc	ra,0x4
    800019c6:	2f8080e7          	jalr	760(ra) # 80005cba <printf>
  for(p = proc; p < &proc[NPROC]; p++){
    800019ca:	16848493          	addi	s1,s1,360
    800019ce:	03248263          	beq	s1,s2,800019f2 <procdump+0x9a>
    if(p->state == UNUSED)
    800019d2:	86a6                	mv	a3,s1
    800019d4:	ec04a783          	lw	a5,-320(s1)
    800019d8:	dbed                	beqz	a5,800019ca <procdump+0x72>
      state = "???";
    800019da:	864e                	mv	a2,s3
    if(p->state >= 0 && p->state < NELEM(states) && states[p->state])
    800019dc:	fcfb6be3          	bltu	s6,a5,800019b2 <procdump+0x5a>
    800019e0:	02079713          	slli	a4,a5,0x20
    800019e4:	01d75793          	srli	a5,a4,0x1d
    800019e8:	97de                	add	a5,a5,s7
    800019ea:	6390                	ld	a2,0(a5)
    800019ec:	f279                	bnez	a2,800019b2 <procdump+0x5a>
      state = "???";
    800019ee:	864e                	mv	a2,s3
    800019f0:	b7c9                	j	800019b2 <procdump+0x5a>
  }
}
    800019f2:	60a6                	ld	ra,72(sp)
    800019f4:	6406                	ld	s0,64(sp)
    800019f6:	74e2                	ld	s1,56(sp)
    800019f8:	7942                	ld	s2,48(sp)
    800019fa:	79a2                	ld	s3,40(sp)
    800019fc:	7a02                	ld	s4,32(sp)
    800019fe:	6ae2                	ld	s5,24(sp)
    80001a00:	6b42                	ld	s6,16(sp)
    80001a02:	6ba2                	ld	s7,8(sp)
    80001a04:	6161                	addi	sp,sp,80
    80001a06:	8082                	ret

0000000080001a08 <swtch>:
    80001a08:	00153023          	sd	ra,0(a0)
    80001a0c:	00253423          	sd	sp,8(a0)
    80001a10:	e900                	sd	s0,16(a0)
    80001a12:	ed04                	sd	s1,24(a0)
    80001a14:	03253023          	sd	s2,32(a0)
    80001a18:	03353423          	sd	s3,40(a0)
    80001a1c:	03453823          	sd	s4,48(a0)
    80001a20:	03553c23          	sd	s5,56(a0)
    80001a24:	05653023          	sd	s6,64(a0)
    80001a28:	05753423          	sd	s7,72(a0)
    80001a2c:	05853823          	sd	s8,80(a0)
    80001a30:	05953c23          	sd	s9,88(a0)
    80001a34:	07a53023          	sd	s10,96(a0)
    80001a38:	07b53423          	sd	s11,104(a0)
    80001a3c:	0005b083          	ld	ra,0(a1)
    80001a40:	0085b103          	ld	sp,8(a1)
    80001a44:	6980                	ld	s0,16(a1)
    80001a46:	6d84                	ld	s1,24(a1)
    80001a48:	0205b903          	ld	s2,32(a1)
    80001a4c:	0285b983          	ld	s3,40(a1)
    80001a50:	0305ba03          	ld	s4,48(a1)
    80001a54:	0385ba83          	ld	s5,56(a1)
    80001a58:	0405bb03          	ld	s6,64(a1)
    80001a5c:	0485bb83          	ld	s7,72(a1)
    80001a60:	0505bc03          	ld	s8,80(a1)
    80001a64:	0585bc83          	ld	s9,88(a1)
    80001a68:	0605bd03          	ld	s10,96(a1)
    80001a6c:	0685bd83          	ld	s11,104(a1)
    80001a70:	8082                	ret

0000000080001a72 <trapinit>:

extern int devintr();

void
trapinit(void)
{
    80001a72:	1141                	addi	sp,sp,-16
    80001a74:	e406                	sd	ra,8(sp)
    80001a76:	e022                	sd	s0,0(sp)
    80001a78:	0800                	addi	s0,sp,16
  initlock(&tickslock, "time");
    80001a7a:	00006597          	auipc	a1,0x6
    80001a7e:	7f658593          	addi	a1,a1,2038 # 80008270 <states.0+0x30>
    80001a82:	00009517          	auipc	a0,0x9
    80001a86:	80e50513          	addi	a0,a0,-2034 # 8000a290 <tickslock>
    80001a8a:	00004097          	auipc	ra,0x4
    80001a8e:	68e080e7          	jalr	1678(ra) # 80006118 <initlock>
}
    80001a92:	60a2                	ld	ra,8(sp)
    80001a94:	6402                	ld	s0,0(sp)
    80001a96:	0141                	addi	sp,sp,16
    80001a98:	8082                	ret

0000000080001a9a <trapinithart>:

// set up to take exceptions and traps while in the kernel.
void
trapinithart(void)
{
    80001a9a:	1141                	addi	sp,sp,-16
    80001a9c:	e422                	sd	s0,8(sp)
    80001a9e:	0800                	addi	s0,sp,16
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001aa0:	00003797          	auipc	a5,0x3
    80001aa4:	63078793          	addi	a5,a5,1584 # 800050d0 <kernelvec>
    80001aa8:	10579073          	csrw	stvec,a5
  w_stvec((uint64)kernelvec);
}
    80001aac:	6422                	ld	s0,8(sp)
    80001aae:	0141                	addi	sp,sp,16
    80001ab0:	8082                	ret

0000000080001ab2 <usertrapret>:
//
// return to user space
//
void
usertrapret(void)
{
    80001ab2:	1141                	addi	sp,sp,-16
    80001ab4:	e406                	sd	ra,8(sp)
    80001ab6:	e022                	sd	s0,0(sp)
    80001ab8:	0800                	addi	s0,sp,16
  struct proc *p = myproc();
    80001aba:	fffff097          	auipc	ra,0xfffff
    80001abe:	38a080e7          	jalr	906(ra) # 80000e44 <myproc>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001ac2:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    80001ac6:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001ac8:	10079073          	csrw	sstatus,a5
  // kerneltrap() to usertrap(), so turn off interrupts until
  // we're back in user space, where usertrap() is correct.
  intr_off();

  // send syscalls, interrupts, and exceptions to trampoline.S
  w_stvec(TRAMPOLINE + (uservec - trampoline));
    80001acc:	00005697          	auipc	a3,0x5
    80001ad0:	53468693          	addi	a3,a3,1332 # 80007000 <_trampoline>
    80001ad4:	00005717          	auipc	a4,0x5
    80001ad8:	52c70713          	addi	a4,a4,1324 # 80007000 <_trampoline>
    80001adc:	8f15                	sub	a4,a4,a3
    80001ade:	040007b7          	lui	a5,0x4000
    80001ae2:	17fd                	addi	a5,a5,-1 # 3ffffff <_entry-0x7c000001>
    80001ae4:	07b2                	slli	a5,a5,0xc
    80001ae6:	973e                	add	a4,a4,a5
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001ae8:	10571073          	csrw	stvec,a4

  // set up trapframe values that uservec will need when
  // the process next re-enters the kernel.
  p->trapframe->kernel_satp = r_satp();         // kernel page table
    80001aec:	6d38                	ld	a4,88(a0)
  asm volatile("csrr %0, satp" : "=r" (x) );
    80001aee:	18002673          	csrr	a2,satp
    80001af2:	e310                	sd	a2,0(a4)
  p->trapframe->kernel_sp = p->kstack + PGSIZE; // process's kernel stack
    80001af4:	6d30                	ld	a2,88(a0)
    80001af6:	6138                	ld	a4,64(a0)
    80001af8:	6585                	lui	a1,0x1
    80001afa:	972e                	add	a4,a4,a1
    80001afc:	e618                	sd	a4,8(a2)
  p->trapframe->kernel_trap = (uint64)usertrap;
    80001afe:	6d38                	ld	a4,88(a0)
    80001b00:	00000617          	auipc	a2,0x0
    80001b04:	13860613          	addi	a2,a2,312 # 80001c38 <usertrap>
    80001b08:	eb10                	sd	a2,16(a4)
  p->trapframe->kernel_hartid = r_tp();         // hartid for cpuid()
    80001b0a:	6d38                	ld	a4,88(a0)
  asm volatile("mv %0, tp" : "=r" (x) );
    80001b0c:	8612                	mv	a2,tp
    80001b0e:	f310                	sd	a2,32(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001b10:	10002773          	csrr	a4,sstatus
  // set up the registers that trampoline.S's sret will use
  // to get to user space.
  
  // set S Previous Privilege mode to User.
  unsigned long x = r_sstatus();
  x &= ~SSTATUS_SPP; // clear SPP to 0 for user mode
    80001b14:	eff77713          	andi	a4,a4,-257
  x |= SSTATUS_SPIE; // enable interrupts in user mode
    80001b18:	02076713          	ori	a4,a4,32
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001b1c:	10071073          	csrw	sstatus,a4
  w_sstatus(x);

  // set S Exception Program Counter to the saved user pc.
  w_sepc(p->trapframe->epc);
    80001b20:	6d38                	ld	a4,88(a0)
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001b22:	6f18                	ld	a4,24(a4)
    80001b24:	14171073          	csrw	sepc,a4

  // tell trampoline.S the user page table to switch to.
  uint64 satp = MAKE_SATP(p->pagetable);
    80001b28:	692c                	ld	a1,80(a0)
    80001b2a:	81b1                	srli	a1,a1,0xc

  // jump to trampoline.S at the top of memory, which 
  // switches to the user page table, restores user registers,
  // and switches to user mode with sret.
  uint64 fn = TRAMPOLINE + (userret - trampoline);
    80001b2c:	00005717          	auipc	a4,0x5
    80001b30:	56470713          	addi	a4,a4,1380 # 80007090 <userret>
    80001b34:	8f15                	sub	a4,a4,a3
    80001b36:	97ba                	add	a5,a5,a4
  ((void (*)(uint64,uint64))fn)(TRAPFRAME, satp);
    80001b38:	577d                	li	a4,-1
    80001b3a:	177e                	slli	a4,a4,0x3f
    80001b3c:	8dd9                	or	a1,a1,a4
    80001b3e:	02000537          	lui	a0,0x2000
    80001b42:	157d                	addi	a0,a0,-1 # 1ffffff <_entry-0x7e000001>
    80001b44:	0536                	slli	a0,a0,0xd
    80001b46:	9782                	jalr	a5
}
    80001b48:	60a2                	ld	ra,8(sp)
    80001b4a:	6402                	ld	s0,0(sp)
    80001b4c:	0141                	addi	sp,sp,16
    80001b4e:	8082                	ret

0000000080001b50 <clockintr>:
  w_sstatus(sstatus);
}

void
clockintr()
{
    80001b50:	1101                	addi	sp,sp,-32
    80001b52:	ec06                	sd	ra,24(sp)
    80001b54:	e822                	sd	s0,16(sp)
    80001b56:	e426                	sd	s1,8(sp)
    80001b58:	1000                	addi	s0,sp,32
  acquire(&tickslock);
    80001b5a:	00008497          	auipc	s1,0x8
    80001b5e:	73648493          	addi	s1,s1,1846 # 8000a290 <tickslock>
    80001b62:	8526                	mv	a0,s1
    80001b64:	00004097          	auipc	ra,0x4
    80001b68:	644080e7          	jalr	1604(ra) # 800061a8 <acquire>
  ticks++;
    80001b6c:	00007517          	auipc	a0,0x7
    80001b70:	4ac50513          	addi	a0,a0,1196 # 80009018 <ticks>
    80001b74:	411c                	lw	a5,0(a0)
    80001b76:	2785                	addiw	a5,a5,1
    80001b78:	c11c                	sw	a5,0(a0)
  wakeup(&ticks);
    80001b7a:	00000097          	auipc	ra,0x0
    80001b7e:	b1a080e7          	jalr	-1254(ra) # 80001694 <wakeup>
  release(&tickslock);
    80001b82:	8526                	mv	a0,s1
    80001b84:	00004097          	auipc	ra,0x4
    80001b88:	6d8080e7          	jalr	1752(ra) # 8000625c <release>
}
    80001b8c:	60e2                	ld	ra,24(sp)
    80001b8e:	6442                	ld	s0,16(sp)
    80001b90:	64a2                	ld	s1,8(sp)
    80001b92:	6105                	addi	sp,sp,32
    80001b94:	8082                	ret

0000000080001b96 <devintr>:
// returns 2 if timer interrupt,
// 1 if other device,
// 0 if not recognized.
int
devintr()
{
    80001b96:	1101                	addi	sp,sp,-32
    80001b98:	ec06                	sd	ra,24(sp)
    80001b9a:	e822                	sd	s0,16(sp)
    80001b9c:	e426                	sd	s1,8(sp)
    80001b9e:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001ba0:	14202773          	csrr	a4,scause
  uint64 scause = r_scause();

  if((scause & 0x8000000000000000L) &&
    80001ba4:	00074d63          	bltz	a4,80001bbe <devintr+0x28>
    // now allowed to interrupt again.
    if(irq)
      plic_complete(irq);

    return 1;
  } else if(scause == 0x8000000000000001L){
    80001ba8:	57fd                	li	a5,-1
    80001baa:	17fe                	slli	a5,a5,0x3f
    80001bac:	0785                	addi	a5,a5,1
    // the SSIP bit in sip.
    w_sip(r_sip() & ~2);

    return 2;
  } else {
    return 0;
    80001bae:	4501                	li	a0,0
  } else if(scause == 0x8000000000000001L){
    80001bb0:	06f70363          	beq	a4,a5,80001c16 <devintr+0x80>
  }
}
    80001bb4:	60e2                	ld	ra,24(sp)
    80001bb6:	6442                	ld	s0,16(sp)
    80001bb8:	64a2                	ld	s1,8(sp)
    80001bba:	6105                	addi	sp,sp,32
    80001bbc:	8082                	ret
     (scause & 0xff) == 9){
    80001bbe:	0ff77793          	zext.b	a5,a4
  if((scause & 0x8000000000000000L) &&
    80001bc2:	46a5                	li	a3,9
    80001bc4:	fed792e3          	bne	a5,a3,80001ba8 <devintr+0x12>
    int irq = plic_claim();
    80001bc8:	00003097          	auipc	ra,0x3
    80001bcc:	610080e7          	jalr	1552(ra) # 800051d8 <plic_claim>
    80001bd0:	84aa                	mv	s1,a0
    if(irq == UART0_IRQ){
    80001bd2:	47a9                	li	a5,10
    80001bd4:	02f50763          	beq	a0,a5,80001c02 <devintr+0x6c>
    } else if(irq == VIRTIO0_IRQ){
    80001bd8:	4785                	li	a5,1
    80001bda:	02f50963          	beq	a0,a5,80001c0c <devintr+0x76>
    return 1;
    80001bde:	4505                	li	a0,1
    } else if(irq){
    80001be0:	d8f1                	beqz	s1,80001bb4 <devintr+0x1e>
      printf("unexpected interrupt irq=%d\n", irq);
    80001be2:	85a6                	mv	a1,s1
    80001be4:	00006517          	auipc	a0,0x6
    80001be8:	69450513          	addi	a0,a0,1684 # 80008278 <states.0+0x38>
    80001bec:	00004097          	auipc	ra,0x4
    80001bf0:	0ce080e7          	jalr	206(ra) # 80005cba <printf>
      plic_complete(irq);
    80001bf4:	8526                	mv	a0,s1
    80001bf6:	00003097          	auipc	ra,0x3
    80001bfa:	606080e7          	jalr	1542(ra) # 800051fc <plic_complete>
    return 1;
    80001bfe:	4505                	li	a0,1
    80001c00:	bf55                	j	80001bb4 <devintr+0x1e>
      uartintr();
    80001c02:	00004097          	auipc	ra,0x4
    80001c06:	4c6080e7          	jalr	1222(ra) # 800060c8 <uartintr>
    80001c0a:	b7ed                	j	80001bf4 <devintr+0x5e>
      virtio_disk_intr();
    80001c0c:	00004097          	auipc	ra,0x4
    80001c10:	a7c080e7          	jalr	-1412(ra) # 80005688 <virtio_disk_intr>
    80001c14:	b7c5                	j	80001bf4 <devintr+0x5e>
    if(cpuid() == 0){
    80001c16:	fffff097          	auipc	ra,0xfffff
    80001c1a:	202080e7          	jalr	514(ra) # 80000e18 <cpuid>
    80001c1e:	c901                	beqz	a0,80001c2e <devintr+0x98>
  asm volatile("csrr %0, sip" : "=r" (x) );
    80001c20:	144027f3          	csrr	a5,sip
    w_sip(r_sip() & ~2);
    80001c24:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sip, %0" : : "r" (x));
    80001c26:	14479073          	csrw	sip,a5
    return 2;
    80001c2a:	4509                	li	a0,2
    80001c2c:	b761                	j	80001bb4 <devintr+0x1e>
      clockintr();
    80001c2e:	00000097          	auipc	ra,0x0
    80001c32:	f22080e7          	jalr	-222(ra) # 80001b50 <clockintr>
    80001c36:	b7ed                	j	80001c20 <devintr+0x8a>

0000000080001c38 <usertrap>:
{
    80001c38:	1101                	addi	sp,sp,-32
    80001c3a:	ec06                	sd	ra,24(sp)
    80001c3c:	e822                	sd	s0,16(sp)
    80001c3e:	e426                	sd	s1,8(sp)
    80001c40:	e04a                	sd	s2,0(sp)
    80001c42:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c44:	100027f3          	csrr	a5,sstatus
  if((r_sstatus() & SSTATUS_SPP) != 0)
    80001c48:	1007f793          	andi	a5,a5,256
    80001c4c:	e3ad                	bnez	a5,80001cae <usertrap+0x76>
  asm volatile("csrw stvec, %0" : : "r" (x));
    80001c4e:	00003797          	auipc	a5,0x3
    80001c52:	48278793          	addi	a5,a5,1154 # 800050d0 <kernelvec>
    80001c56:	10579073          	csrw	stvec,a5
  struct proc *p = myproc();
    80001c5a:	fffff097          	auipc	ra,0xfffff
    80001c5e:	1ea080e7          	jalr	490(ra) # 80000e44 <myproc>
    80001c62:	84aa                	mv	s1,a0
  p->trapframe->epc = r_sepc();
    80001c64:	6d3c                	ld	a5,88(a0)
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001c66:	14102773          	csrr	a4,sepc
    80001c6a:	ef98                	sd	a4,24(a5)
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001c6c:	14202773          	csrr	a4,scause
  if(r_scause() == 8){
    80001c70:	47a1                	li	a5,8
    80001c72:	04f71c63          	bne	a4,a5,80001cca <usertrap+0x92>
    if(p->killed)
    80001c76:	551c                	lw	a5,40(a0)
    80001c78:	e3b9                	bnez	a5,80001cbe <usertrap+0x86>
    p->trapframe->epc += 4;
    80001c7a:	6cb8                	ld	a4,88(s1)
    80001c7c:	6f1c                	ld	a5,24(a4)
    80001c7e:	0791                	addi	a5,a5,4
    80001c80:	ef1c                	sd	a5,24(a4)
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001c82:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    80001c86:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001c8a:	10079073          	csrw	sstatus,a5
    syscall();
    80001c8e:	00000097          	auipc	ra,0x0
    80001c92:	2e0080e7          	jalr	736(ra) # 80001f6e <syscall>
  if(p->killed)
    80001c96:	549c                	lw	a5,40(s1)
    80001c98:	ebc1                	bnez	a5,80001d28 <usertrap+0xf0>
  usertrapret();
    80001c9a:	00000097          	auipc	ra,0x0
    80001c9e:	e18080e7          	jalr	-488(ra) # 80001ab2 <usertrapret>
}
    80001ca2:	60e2                	ld	ra,24(sp)
    80001ca4:	6442                	ld	s0,16(sp)
    80001ca6:	64a2                	ld	s1,8(sp)
    80001ca8:	6902                	ld	s2,0(sp)
    80001caa:	6105                	addi	sp,sp,32
    80001cac:	8082                	ret
    panic("usertrap: not from user mode");
    80001cae:	00006517          	auipc	a0,0x6
    80001cb2:	5ea50513          	addi	a0,a0,1514 # 80008298 <states.0+0x58>
    80001cb6:	00004097          	auipc	ra,0x4
    80001cba:	fba080e7          	jalr	-70(ra) # 80005c70 <panic>
      exit(-1);
    80001cbe:	557d                	li	a0,-1
    80001cc0:	00000097          	auipc	ra,0x0
    80001cc4:	aa4080e7          	jalr	-1372(ra) # 80001764 <exit>
    80001cc8:	bf4d                	j	80001c7a <usertrap+0x42>
  } else if((which_dev = devintr()) != 0){
    80001cca:	00000097          	auipc	ra,0x0
    80001cce:	ecc080e7          	jalr	-308(ra) # 80001b96 <devintr>
    80001cd2:	892a                	mv	s2,a0
    80001cd4:	c501                	beqz	a0,80001cdc <usertrap+0xa4>
  if(p->killed)
    80001cd6:	549c                	lw	a5,40(s1)
    80001cd8:	c3a1                	beqz	a5,80001d18 <usertrap+0xe0>
    80001cda:	a815                	j	80001d0e <usertrap+0xd6>
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001cdc:	142025f3          	csrr	a1,scause
    printf("usertrap(): unexpected scause %p pid=%d\n", r_scause(), p->pid);
    80001ce0:	5890                	lw	a2,48(s1)
    80001ce2:	00006517          	auipc	a0,0x6
    80001ce6:	5d650513          	addi	a0,a0,1494 # 800082b8 <states.0+0x78>
    80001cea:	00004097          	auipc	ra,0x4
    80001cee:	fd0080e7          	jalr	-48(ra) # 80005cba <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001cf2:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001cf6:	14302673          	csrr	a2,stval
    printf("            sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001cfa:	00006517          	auipc	a0,0x6
    80001cfe:	5ee50513          	addi	a0,a0,1518 # 800082e8 <states.0+0xa8>
    80001d02:	00004097          	auipc	ra,0x4
    80001d06:	fb8080e7          	jalr	-72(ra) # 80005cba <printf>
    p->killed = 1;
    80001d0a:	4785                	li	a5,1
    80001d0c:	d49c                	sw	a5,40(s1)
    exit(-1);
    80001d0e:	557d                	li	a0,-1
    80001d10:	00000097          	auipc	ra,0x0
    80001d14:	a54080e7          	jalr	-1452(ra) # 80001764 <exit>
  if(which_dev == 2)
    80001d18:	4789                	li	a5,2
    80001d1a:	f8f910e3          	bne	s2,a5,80001c9a <usertrap+0x62>
    yield();
    80001d1e:	fffff097          	auipc	ra,0xfffff
    80001d22:	7ae080e7          	jalr	1966(ra) # 800014cc <yield>
    80001d26:	bf95                	j	80001c9a <usertrap+0x62>
  int which_dev = 0;
    80001d28:	4901                	li	s2,0
    80001d2a:	b7d5                	j	80001d0e <usertrap+0xd6>

0000000080001d2c <kerneltrap>:
{
    80001d2c:	7179                	addi	sp,sp,-48
    80001d2e:	f406                	sd	ra,40(sp)
    80001d30:	f022                	sd	s0,32(sp)
    80001d32:	ec26                	sd	s1,24(sp)
    80001d34:	e84a                	sd	s2,16(sp)
    80001d36:	e44e                	sd	s3,8(sp)
    80001d38:	1800                	addi	s0,sp,48
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001d3a:	14102973          	csrr	s2,sepc
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d3e:	100024f3          	csrr	s1,sstatus
  asm volatile("csrr %0, scause" : "=r" (x) );
    80001d42:	142029f3          	csrr	s3,scause
  if((sstatus & SSTATUS_SPP) == 0)
    80001d46:	1004f793          	andi	a5,s1,256
    80001d4a:	cb85                	beqz	a5,80001d7a <kerneltrap+0x4e>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80001d4c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80001d50:	8b89                	andi	a5,a5,2
  if(intr_get() != 0)
    80001d52:	ef85                	bnez	a5,80001d8a <kerneltrap+0x5e>
  if((which_dev = devintr()) == 0){
    80001d54:	00000097          	auipc	ra,0x0
    80001d58:	e42080e7          	jalr	-446(ra) # 80001b96 <devintr>
    80001d5c:	cd1d                	beqz	a0,80001d9a <kerneltrap+0x6e>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001d5e:	4789                	li	a5,2
    80001d60:	06f50a63          	beq	a0,a5,80001dd4 <kerneltrap+0xa8>
  asm volatile("csrw sepc, %0" : : "r" (x));
    80001d64:	14191073          	csrw	sepc,s2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80001d68:	10049073          	csrw	sstatus,s1
}
    80001d6c:	70a2                	ld	ra,40(sp)
    80001d6e:	7402                	ld	s0,32(sp)
    80001d70:	64e2                	ld	s1,24(sp)
    80001d72:	6942                	ld	s2,16(sp)
    80001d74:	69a2                	ld	s3,8(sp)
    80001d76:	6145                	addi	sp,sp,48
    80001d78:	8082                	ret
    panic("kerneltrap: not from supervisor mode");
    80001d7a:	00006517          	auipc	a0,0x6
    80001d7e:	58e50513          	addi	a0,a0,1422 # 80008308 <states.0+0xc8>
    80001d82:	00004097          	auipc	ra,0x4
    80001d86:	eee080e7          	jalr	-274(ra) # 80005c70 <panic>
    panic("kerneltrap: interrupts enabled");
    80001d8a:	00006517          	auipc	a0,0x6
    80001d8e:	5a650513          	addi	a0,a0,1446 # 80008330 <states.0+0xf0>
    80001d92:	00004097          	auipc	ra,0x4
    80001d96:	ede080e7          	jalr	-290(ra) # 80005c70 <panic>
    printf("scause %p\n", scause);
    80001d9a:	85ce                	mv	a1,s3
    80001d9c:	00006517          	auipc	a0,0x6
    80001da0:	5b450513          	addi	a0,a0,1460 # 80008350 <states.0+0x110>
    80001da4:	00004097          	auipc	ra,0x4
    80001da8:	f16080e7          	jalr	-234(ra) # 80005cba <printf>
  asm volatile("csrr %0, sepc" : "=r" (x) );
    80001dac:	141025f3          	csrr	a1,sepc
  asm volatile("csrr %0, stval" : "=r" (x) );
    80001db0:	14302673          	csrr	a2,stval
    printf("sepc=%p stval=%p\n", r_sepc(), r_stval());
    80001db4:	00006517          	auipc	a0,0x6
    80001db8:	5ac50513          	addi	a0,a0,1452 # 80008360 <states.0+0x120>
    80001dbc:	00004097          	auipc	ra,0x4
    80001dc0:	efe080e7          	jalr	-258(ra) # 80005cba <printf>
    panic("kerneltrap");
    80001dc4:	00006517          	auipc	a0,0x6
    80001dc8:	5b450513          	addi	a0,a0,1460 # 80008378 <states.0+0x138>
    80001dcc:	00004097          	auipc	ra,0x4
    80001dd0:	ea4080e7          	jalr	-348(ra) # 80005c70 <panic>
  if(which_dev == 2 && myproc() != 0 && myproc()->state == RUNNING)
    80001dd4:	fffff097          	auipc	ra,0xfffff
    80001dd8:	070080e7          	jalr	112(ra) # 80000e44 <myproc>
    80001ddc:	d541                	beqz	a0,80001d64 <kerneltrap+0x38>
    80001dde:	fffff097          	auipc	ra,0xfffff
    80001de2:	066080e7          	jalr	102(ra) # 80000e44 <myproc>
    80001de6:	4d18                	lw	a4,24(a0)
    80001de8:	4791                	li	a5,4
    80001dea:	f6f71de3          	bne	a4,a5,80001d64 <kerneltrap+0x38>
    yield();
    80001dee:	fffff097          	auipc	ra,0xfffff
    80001df2:	6de080e7          	jalr	1758(ra) # 800014cc <yield>
    80001df6:	b7bd                	j	80001d64 <kerneltrap+0x38>

0000000080001df8 <argraw>:
  return strlen(buf);
}

static uint64
argraw(int n)
{
    80001df8:	1101                	addi	sp,sp,-32
    80001dfa:	ec06                	sd	ra,24(sp)
    80001dfc:	e822                	sd	s0,16(sp)
    80001dfe:	e426                	sd	s1,8(sp)
    80001e00:	1000                	addi	s0,sp,32
    80001e02:	84aa                	mv	s1,a0
  struct proc *p = myproc();
    80001e04:	fffff097          	auipc	ra,0xfffff
    80001e08:	040080e7          	jalr	64(ra) # 80000e44 <myproc>
  switch (n) {
    80001e0c:	4795                	li	a5,5
    80001e0e:	0497e163          	bltu	a5,s1,80001e50 <argraw+0x58>
    80001e12:	048a                	slli	s1,s1,0x2
    80001e14:	00006717          	auipc	a4,0x6
    80001e18:	59c70713          	addi	a4,a4,1436 # 800083b0 <states.0+0x170>
    80001e1c:	94ba                	add	s1,s1,a4
    80001e1e:	409c                	lw	a5,0(s1)
    80001e20:	97ba                	add	a5,a5,a4
    80001e22:	8782                	jr	a5
  case 0:
    return p->trapframe->a0;
    80001e24:	6d3c                	ld	a5,88(a0)
    80001e26:	7ba8                	ld	a0,112(a5)
  case 5:
    return p->trapframe->a5;
  }
  panic("argraw");
  return -1;
}
    80001e28:	60e2                	ld	ra,24(sp)
    80001e2a:	6442                	ld	s0,16(sp)
    80001e2c:	64a2                	ld	s1,8(sp)
    80001e2e:	6105                	addi	sp,sp,32
    80001e30:	8082                	ret
    return p->trapframe->a1;
    80001e32:	6d3c                	ld	a5,88(a0)
    80001e34:	7fa8                	ld	a0,120(a5)
    80001e36:	bfcd                	j	80001e28 <argraw+0x30>
    return p->trapframe->a2;
    80001e38:	6d3c                	ld	a5,88(a0)
    80001e3a:	63c8                	ld	a0,128(a5)
    80001e3c:	b7f5                	j	80001e28 <argraw+0x30>
    return p->trapframe->a3;
    80001e3e:	6d3c                	ld	a5,88(a0)
    80001e40:	67c8                	ld	a0,136(a5)
    80001e42:	b7dd                	j	80001e28 <argraw+0x30>
    return p->trapframe->a4;
    80001e44:	6d3c                	ld	a5,88(a0)
    80001e46:	6bc8                	ld	a0,144(a5)
    80001e48:	b7c5                	j	80001e28 <argraw+0x30>
    return p->trapframe->a5;
    80001e4a:	6d3c                	ld	a5,88(a0)
    80001e4c:	6fc8                	ld	a0,152(a5)
    80001e4e:	bfe9                	j	80001e28 <argraw+0x30>
  panic("argraw");
    80001e50:	00006517          	auipc	a0,0x6
    80001e54:	53850513          	addi	a0,a0,1336 # 80008388 <states.0+0x148>
    80001e58:	00004097          	auipc	ra,0x4
    80001e5c:	e18080e7          	jalr	-488(ra) # 80005c70 <panic>

0000000080001e60 <fetchaddr>:
{
    80001e60:	1101                	addi	sp,sp,-32
    80001e62:	ec06                	sd	ra,24(sp)
    80001e64:	e822                	sd	s0,16(sp)
    80001e66:	e426                	sd	s1,8(sp)
    80001e68:	e04a                	sd	s2,0(sp)
    80001e6a:	1000                	addi	s0,sp,32
    80001e6c:	84aa                	mv	s1,a0
    80001e6e:	892e                	mv	s2,a1
  struct proc *p = myproc();
    80001e70:	fffff097          	auipc	ra,0xfffff
    80001e74:	fd4080e7          	jalr	-44(ra) # 80000e44 <myproc>
  if(addr >= p->sz || addr+sizeof(uint64) > p->sz)
    80001e78:	653c                	ld	a5,72(a0)
    80001e7a:	02f4f863          	bgeu	s1,a5,80001eaa <fetchaddr+0x4a>
    80001e7e:	00848713          	addi	a4,s1,8
    80001e82:	02e7e663          	bltu	a5,a4,80001eae <fetchaddr+0x4e>
  if(copyin(p->pagetable, (char *)ip, addr, sizeof(*ip)) != 0)
    80001e86:	46a1                	li	a3,8
    80001e88:	8626                	mv	a2,s1
    80001e8a:	85ca                	mv	a1,s2
    80001e8c:	6928                	ld	a0,80(a0)
    80001e8e:	fffff097          	auipc	ra,0xfffff
    80001e92:	d06080e7          	jalr	-762(ra) # 80000b94 <copyin>
    80001e96:	00a03533          	snez	a0,a0
    80001e9a:	40a00533          	neg	a0,a0
}
    80001e9e:	60e2                	ld	ra,24(sp)
    80001ea0:	6442                	ld	s0,16(sp)
    80001ea2:	64a2                	ld	s1,8(sp)
    80001ea4:	6902                	ld	s2,0(sp)
    80001ea6:	6105                	addi	sp,sp,32
    80001ea8:	8082                	ret
    return -1;
    80001eaa:	557d                	li	a0,-1
    80001eac:	bfcd                	j	80001e9e <fetchaddr+0x3e>
    80001eae:	557d                	li	a0,-1
    80001eb0:	b7fd                	j	80001e9e <fetchaddr+0x3e>

0000000080001eb2 <fetchstr>:
{
    80001eb2:	7179                	addi	sp,sp,-48
    80001eb4:	f406                	sd	ra,40(sp)
    80001eb6:	f022                	sd	s0,32(sp)
    80001eb8:	ec26                	sd	s1,24(sp)
    80001eba:	e84a                	sd	s2,16(sp)
    80001ebc:	e44e                	sd	s3,8(sp)
    80001ebe:	1800                	addi	s0,sp,48
    80001ec0:	892a                	mv	s2,a0
    80001ec2:	84ae                	mv	s1,a1
    80001ec4:	89b2                	mv	s3,a2
  struct proc *p = myproc();
    80001ec6:	fffff097          	auipc	ra,0xfffff
    80001eca:	f7e080e7          	jalr	-130(ra) # 80000e44 <myproc>
  int err = copyinstr(p->pagetable, buf, addr, max);
    80001ece:	86ce                	mv	a3,s3
    80001ed0:	864a                	mv	a2,s2
    80001ed2:	85a6                	mv	a1,s1
    80001ed4:	6928                	ld	a0,80(a0)
    80001ed6:	fffff097          	auipc	ra,0xfffff
    80001eda:	d4c080e7          	jalr	-692(ra) # 80000c22 <copyinstr>
  if(err < 0)
    80001ede:	00054763          	bltz	a0,80001eec <fetchstr+0x3a>
  return strlen(buf);
    80001ee2:	8526                	mv	a0,s1
    80001ee4:	ffffe097          	auipc	ra,0xffffe
    80001ee8:	412080e7          	jalr	1042(ra) # 800002f6 <strlen>
}
    80001eec:	70a2                	ld	ra,40(sp)
    80001eee:	7402                	ld	s0,32(sp)
    80001ef0:	64e2                	ld	s1,24(sp)
    80001ef2:	6942                	ld	s2,16(sp)
    80001ef4:	69a2                	ld	s3,8(sp)
    80001ef6:	6145                	addi	sp,sp,48
    80001ef8:	8082                	ret

0000000080001efa <argint>:

// Fetch the nth 32-bit system call argument.
int
argint(int n, int *ip)
{
    80001efa:	1101                	addi	sp,sp,-32
    80001efc:	ec06                	sd	ra,24(sp)
    80001efe:	e822                	sd	s0,16(sp)
    80001f00:	e426                	sd	s1,8(sp)
    80001f02:	1000                	addi	s0,sp,32
    80001f04:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f06:	00000097          	auipc	ra,0x0
    80001f0a:	ef2080e7          	jalr	-270(ra) # 80001df8 <argraw>
    80001f0e:	c088                	sw	a0,0(s1)
  return 0;
}
    80001f10:	4501                	li	a0,0
    80001f12:	60e2                	ld	ra,24(sp)
    80001f14:	6442                	ld	s0,16(sp)
    80001f16:	64a2                	ld	s1,8(sp)
    80001f18:	6105                	addi	sp,sp,32
    80001f1a:	8082                	ret

0000000080001f1c <argaddr>:
// Retrieve an argument as a pointer.
// Doesn't check for legality, since
// copyin/copyout will do that.
int
argaddr(int n, uint64 *ip)
{
    80001f1c:	1101                	addi	sp,sp,-32
    80001f1e:	ec06                	sd	ra,24(sp)
    80001f20:	e822                	sd	s0,16(sp)
    80001f22:	e426                	sd	s1,8(sp)
    80001f24:	1000                	addi	s0,sp,32
    80001f26:	84ae                	mv	s1,a1
  *ip = argraw(n);
    80001f28:	00000097          	auipc	ra,0x0
    80001f2c:	ed0080e7          	jalr	-304(ra) # 80001df8 <argraw>
    80001f30:	e088                	sd	a0,0(s1)
  return 0;
}
    80001f32:	4501                	li	a0,0
    80001f34:	60e2                	ld	ra,24(sp)
    80001f36:	6442                	ld	s0,16(sp)
    80001f38:	64a2                	ld	s1,8(sp)
    80001f3a:	6105                	addi	sp,sp,32
    80001f3c:	8082                	ret

0000000080001f3e <argstr>:
// Fetch the nth word-sized system call argument as a null-terminated string.
// Copies into buf, at most max.
// Returns string length if OK (including nul), -1 if error.
int
argstr(int n, char *buf, int max)
{
    80001f3e:	1101                	addi	sp,sp,-32
    80001f40:	ec06                	sd	ra,24(sp)
    80001f42:	e822                	sd	s0,16(sp)
    80001f44:	e426                	sd	s1,8(sp)
    80001f46:	e04a                	sd	s2,0(sp)
    80001f48:	1000                	addi	s0,sp,32
    80001f4a:	84ae                	mv	s1,a1
    80001f4c:	8932                	mv	s2,a2
  *ip = argraw(n);
    80001f4e:	00000097          	auipc	ra,0x0
    80001f52:	eaa080e7          	jalr	-342(ra) # 80001df8 <argraw>
  uint64 addr;
  if(argaddr(n, &addr) < 0)
    return -1;
  return fetchstr(addr, buf, max);
    80001f56:	864a                	mv	a2,s2
    80001f58:	85a6                	mv	a1,s1
    80001f5a:	00000097          	auipc	ra,0x0
    80001f5e:	f58080e7          	jalr	-168(ra) # 80001eb2 <fetchstr>
}
    80001f62:	60e2                	ld	ra,24(sp)
    80001f64:	6442                	ld	s0,16(sp)
    80001f66:	64a2                	ld	s1,8(sp)
    80001f68:	6902                	ld	s2,0(sp)
    80001f6a:	6105                	addi	sp,sp,32
    80001f6c:	8082                	ret

0000000080001f6e <syscall>:
[SYS_close]   sys_close,
};

void
syscall(void)
{
    80001f6e:	1101                	addi	sp,sp,-32
    80001f70:	ec06                	sd	ra,24(sp)
    80001f72:	e822                	sd	s0,16(sp)
    80001f74:	e426                	sd	s1,8(sp)
    80001f76:	e04a                	sd	s2,0(sp)
    80001f78:	1000                	addi	s0,sp,32
  int num;
  struct proc *p = myproc();
    80001f7a:	fffff097          	auipc	ra,0xfffff
    80001f7e:	eca080e7          	jalr	-310(ra) # 80000e44 <myproc>
    80001f82:	84aa                	mv	s1,a0

  num = p->trapframe->a7;
    80001f84:	05853903          	ld	s2,88(a0)
    80001f88:	0a893783          	ld	a5,168(s2)
    80001f8c:	0007869b          	sext.w	a3,a5
  if(num > 0 && num < NELEM(syscalls) && syscalls[num]) {
    80001f90:	37fd                	addiw	a5,a5,-1
    80001f92:	4751                	li	a4,20
    80001f94:	00f76f63          	bltu	a4,a5,80001fb2 <syscall+0x44>
    80001f98:	00369713          	slli	a4,a3,0x3
    80001f9c:	00006797          	auipc	a5,0x6
    80001fa0:	42c78793          	addi	a5,a5,1068 # 800083c8 <syscalls>
    80001fa4:	97ba                	add	a5,a5,a4
    80001fa6:	639c                	ld	a5,0(a5)
    80001fa8:	c789                	beqz	a5,80001fb2 <syscall+0x44>
    p->trapframe->a0 = syscalls[num]();
    80001faa:	9782                	jalr	a5
    80001fac:	06a93823          	sd	a0,112(s2)
    80001fb0:	a839                	j	80001fce <syscall+0x60>
  } else {
    printf("%d %s: unknown sys call %d\n",
    80001fb2:	15848613          	addi	a2,s1,344
    80001fb6:	588c                	lw	a1,48(s1)
    80001fb8:	00006517          	auipc	a0,0x6
    80001fbc:	3d850513          	addi	a0,a0,984 # 80008390 <states.0+0x150>
    80001fc0:	00004097          	auipc	ra,0x4
    80001fc4:	cfa080e7          	jalr	-774(ra) # 80005cba <printf>
            p->pid, p->name, num);
    p->trapframe->a0 = -1;
    80001fc8:	6cbc                	ld	a5,88(s1)
    80001fca:	577d                	li	a4,-1
    80001fcc:	fbb8                	sd	a4,112(a5)
  }
}
    80001fce:	60e2                	ld	ra,24(sp)
    80001fd0:	6442                	ld	s0,16(sp)
    80001fd2:	64a2                	ld	s1,8(sp)
    80001fd4:	6902                	ld	s2,0(sp)
    80001fd6:	6105                	addi	sp,sp,32
    80001fd8:	8082                	ret

0000000080001fda <sys_exit>:
#include "spinlock.h"
#include "proc.h"

uint64
sys_exit(void)
{
    80001fda:	1101                	addi	sp,sp,-32
    80001fdc:	ec06                	sd	ra,24(sp)
    80001fde:	e822                	sd	s0,16(sp)
    80001fe0:	1000                	addi	s0,sp,32
  int n;
  if(argint(0, &n) < 0)
    80001fe2:	fec40593          	addi	a1,s0,-20
    80001fe6:	4501                	li	a0,0
    80001fe8:	00000097          	auipc	ra,0x0
    80001fec:	f12080e7          	jalr	-238(ra) # 80001efa <argint>
    return -1;
    80001ff0:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    80001ff2:	00054963          	bltz	a0,80002004 <sys_exit+0x2a>
  exit(n);
    80001ff6:	fec42503          	lw	a0,-20(s0)
    80001ffa:	fffff097          	auipc	ra,0xfffff
    80001ffe:	76a080e7          	jalr	1898(ra) # 80001764 <exit>
  return 0;  // not reached
    80002002:	4781                	li	a5,0
}
    80002004:	853e                	mv	a0,a5
    80002006:	60e2                	ld	ra,24(sp)
    80002008:	6442                	ld	s0,16(sp)
    8000200a:	6105                	addi	sp,sp,32
    8000200c:	8082                	ret

000000008000200e <sys_getpid>:

uint64
sys_getpid(void)
{
    8000200e:	1141                	addi	sp,sp,-16
    80002010:	e406                	sd	ra,8(sp)
    80002012:	e022                	sd	s0,0(sp)
    80002014:	0800                	addi	s0,sp,16
  return myproc()->pid;
    80002016:	fffff097          	auipc	ra,0xfffff
    8000201a:	e2e080e7          	jalr	-466(ra) # 80000e44 <myproc>
}
    8000201e:	5908                	lw	a0,48(a0)
    80002020:	60a2                	ld	ra,8(sp)
    80002022:	6402                	ld	s0,0(sp)
    80002024:	0141                	addi	sp,sp,16
    80002026:	8082                	ret

0000000080002028 <sys_fork>:

uint64
sys_fork(void)
{
    80002028:	1141                	addi	sp,sp,-16
    8000202a:	e406                	sd	ra,8(sp)
    8000202c:	e022                	sd	s0,0(sp)
    8000202e:	0800                	addi	s0,sp,16
  return fork();
    80002030:	fffff097          	auipc	ra,0xfffff
    80002034:	1e6080e7          	jalr	486(ra) # 80001216 <fork>
}
    80002038:	60a2                	ld	ra,8(sp)
    8000203a:	6402                	ld	s0,0(sp)
    8000203c:	0141                	addi	sp,sp,16
    8000203e:	8082                	ret

0000000080002040 <sys_wait>:

uint64
sys_wait(void)
{
    80002040:	1101                	addi	sp,sp,-32
    80002042:	ec06                	sd	ra,24(sp)
    80002044:	e822                	sd	s0,16(sp)
    80002046:	1000                	addi	s0,sp,32
  uint64 p;
  if(argaddr(0, &p) < 0)
    80002048:	fe840593          	addi	a1,s0,-24
    8000204c:	4501                	li	a0,0
    8000204e:	00000097          	auipc	ra,0x0
    80002052:	ece080e7          	jalr	-306(ra) # 80001f1c <argaddr>
    80002056:	87aa                	mv	a5,a0
    return -1;
    80002058:	557d                	li	a0,-1
  if(argaddr(0, &p) < 0)
    8000205a:	0007c863          	bltz	a5,8000206a <sys_wait+0x2a>
  return wait(p);
    8000205e:	fe843503          	ld	a0,-24(s0)
    80002062:	fffff097          	auipc	ra,0xfffff
    80002066:	50a080e7          	jalr	1290(ra) # 8000156c <wait>
}
    8000206a:	60e2                	ld	ra,24(sp)
    8000206c:	6442                	ld	s0,16(sp)
    8000206e:	6105                	addi	sp,sp,32
    80002070:	8082                	ret

0000000080002072 <sys_sbrk>:

uint64
sys_sbrk(void)
{
    80002072:	7179                	addi	sp,sp,-48
    80002074:	f406                	sd	ra,40(sp)
    80002076:	f022                	sd	s0,32(sp)
    80002078:	ec26                	sd	s1,24(sp)
    8000207a:	1800                	addi	s0,sp,48
  int addr;
  int n;

  if(argint(0, &n) < 0)
    8000207c:	fdc40593          	addi	a1,s0,-36
    80002080:	4501                	li	a0,0
    80002082:	00000097          	auipc	ra,0x0
    80002086:	e78080e7          	jalr	-392(ra) # 80001efa <argint>
    8000208a:	87aa                	mv	a5,a0
    return -1;
    8000208c:	557d                	li	a0,-1
  if(argint(0, &n) < 0)
    8000208e:	0207c063          	bltz	a5,800020ae <sys_sbrk+0x3c>
  addr = myproc()->sz;
    80002092:	fffff097          	auipc	ra,0xfffff
    80002096:	db2080e7          	jalr	-590(ra) # 80000e44 <myproc>
    8000209a:	4524                	lw	s1,72(a0)
  if(growproc(n) < 0)
    8000209c:	fdc42503          	lw	a0,-36(s0)
    800020a0:	fffff097          	auipc	ra,0xfffff
    800020a4:	0fe080e7          	jalr	254(ra) # 8000119e <growproc>
    800020a8:	00054863          	bltz	a0,800020b8 <sys_sbrk+0x46>
    return -1;
  return addr;
    800020ac:	8526                	mv	a0,s1
}
    800020ae:	70a2                	ld	ra,40(sp)
    800020b0:	7402                	ld	s0,32(sp)
    800020b2:	64e2                	ld	s1,24(sp)
    800020b4:	6145                	addi	sp,sp,48
    800020b6:	8082                	ret
    return -1;
    800020b8:	557d                	li	a0,-1
    800020ba:	bfd5                	j	800020ae <sys_sbrk+0x3c>

00000000800020bc <sys_sleep>:

uint64
sys_sleep(void)
{
    800020bc:	7139                	addi	sp,sp,-64
    800020be:	fc06                	sd	ra,56(sp)
    800020c0:	f822                	sd	s0,48(sp)
    800020c2:	f426                	sd	s1,40(sp)
    800020c4:	f04a                	sd	s2,32(sp)
    800020c6:	ec4e                	sd	s3,24(sp)
    800020c8:	0080                	addi	s0,sp,64
  int n;
  uint ticks0;

  if(argint(0, &n) < 0)
    800020ca:	fcc40593          	addi	a1,s0,-52
    800020ce:	4501                	li	a0,0
    800020d0:	00000097          	auipc	ra,0x0
    800020d4:	e2a080e7          	jalr	-470(ra) # 80001efa <argint>
    return -1;
    800020d8:	57fd                	li	a5,-1
  if(argint(0, &n) < 0)
    800020da:	06054563          	bltz	a0,80002144 <sys_sleep+0x88>
  acquire(&tickslock);
    800020de:	00008517          	auipc	a0,0x8
    800020e2:	1b250513          	addi	a0,a0,434 # 8000a290 <tickslock>
    800020e6:	00004097          	auipc	ra,0x4
    800020ea:	0c2080e7          	jalr	194(ra) # 800061a8 <acquire>
  ticks0 = ticks;
    800020ee:	00007917          	auipc	s2,0x7
    800020f2:	f2a92903          	lw	s2,-214(s2) # 80009018 <ticks>
  while(ticks - ticks0 < n){
    800020f6:	fcc42783          	lw	a5,-52(s0)
    800020fa:	cf85                	beqz	a5,80002132 <sys_sleep+0x76>
    if(myproc()->killed){
      release(&tickslock);
      return -1;
    }
    sleep(&ticks, &tickslock);
    800020fc:	00008997          	auipc	s3,0x8
    80002100:	19498993          	addi	s3,s3,404 # 8000a290 <tickslock>
    80002104:	00007497          	auipc	s1,0x7
    80002108:	f1448493          	addi	s1,s1,-236 # 80009018 <ticks>
    if(myproc()->killed){
    8000210c:	fffff097          	auipc	ra,0xfffff
    80002110:	d38080e7          	jalr	-712(ra) # 80000e44 <myproc>
    80002114:	551c                	lw	a5,40(a0)
    80002116:	ef9d                	bnez	a5,80002154 <sys_sleep+0x98>
    sleep(&ticks, &tickslock);
    80002118:	85ce                	mv	a1,s3
    8000211a:	8526                	mv	a0,s1
    8000211c:	fffff097          	auipc	ra,0xfffff
    80002120:	3ec080e7          	jalr	1004(ra) # 80001508 <sleep>
  while(ticks - ticks0 < n){
    80002124:	409c                	lw	a5,0(s1)
    80002126:	412787bb          	subw	a5,a5,s2
    8000212a:	fcc42703          	lw	a4,-52(s0)
    8000212e:	fce7efe3          	bltu	a5,a4,8000210c <sys_sleep+0x50>
  }
  release(&tickslock);
    80002132:	00008517          	auipc	a0,0x8
    80002136:	15e50513          	addi	a0,a0,350 # 8000a290 <tickslock>
    8000213a:	00004097          	auipc	ra,0x4
    8000213e:	122080e7          	jalr	290(ra) # 8000625c <release>
  return 0;
    80002142:	4781                	li	a5,0
}
    80002144:	853e                	mv	a0,a5
    80002146:	70e2                	ld	ra,56(sp)
    80002148:	7442                	ld	s0,48(sp)
    8000214a:	74a2                	ld	s1,40(sp)
    8000214c:	7902                	ld	s2,32(sp)
    8000214e:	69e2                	ld	s3,24(sp)
    80002150:	6121                	addi	sp,sp,64
    80002152:	8082                	ret
      release(&tickslock);
    80002154:	00008517          	auipc	a0,0x8
    80002158:	13c50513          	addi	a0,a0,316 # 8000a290 <tickslock>
    8000215c:	00004097          	auipc	ra,0x4
    80002160:	100080e7          	jalr	256(ra) # 8000625c <release>
      return -1;
    80002164:	57fd                	li	a5,-1
    80002166:	bff9                	j	80002144 <sys_sleep+0x88>

0000000080002168 <sys_kill>:

uint64
sys_kill(void)
{
    80002168:	1101                	addi	sp,sp,-32
    8000216a:	ec06                	sd	ra,24(sp)
    8000216c:	e822                	sd	s0,16(sp)
    8000216e:	1000                	addi	s0,sp,32
  int pid;

  if(argint(0, &pid) < 0)
    80002170:	fec40593          	addi	a1,s0,-20
    80002174:	4501                	li	a0,0
    80002176:	00000097          	auipc	ra,0x0
    8000217a:	d84080e7          	jalr	-636(ra) # 80001efa <argint>
    8000217e:	87aa                	mv	a5,a0
    return -1;
    80002180:	557d                	li	a0,-1
  if(argint(0, &pid) < 0)
    80002182:	0007c863          	bltz	a5,80002192 <sys_kill+0x2a>
  return kill(pid);
    80002186:	fec42503          	lw	a0,-20(s0)
    8000218a:	fffff097          	auipc	ra,0xfffff
    8000218e:	6b0080e7          	jalr	1712(ra) # 8000183a <kill>
}
    80002192:	60e2                	ld	ra,24(sp)
    80002194:	6442                	ld	s0,16(sp)
    80002196:	6105                	addi	sp,sp,32
    80002198:	8082                	ret

000000008000219a <sys_uptime>:

// return how many clock tick interrupts have occurred
// since start.
uint64
sys_uptime(void)
{
    8000219a:	1101                	addi	sp,sp,-32
    8000219c:	ec06                	sd	ra,24(sp)
    8000219e:	e822                	sd	s0,16(sp)
    800021a0:	e426                	sd	s1,8(sp)
    800021a2:	1000                	addi	s0,sp,32
  uint xticks;

  acquire(&tickslock);
    800021a4:	00008517          	auipc	a0,0x8
    800021a8:	0ec50513          	addi	a0,a0,236 # 8000a290 <tickslock>
    800021ac:	00004097          	auipc	ra,0x4
    800021b0:	ffc080e7          	jalr	-4(ra) # 800061a8 <acquire>
  xticks = ticks;
    800021b4:	00007497          	auipc	s1,0x7
    800021b8:	e644a483          	lw	s1,-412(s1) # 80009018 <ticks>
  release(&tickslock);
    800021bc:	00008517          	auipc	a0,0x8
    800021c0:	0d450513          	addi	a0,a0,212 # 8000a290 <tickslock>
    800021c4:	00004097          	auipc	ra,0x4
    800021c8:	098080e7          	jalr	152(ra) # 8000625c <release>
  return xticks;
}
    800021cc:	02049513          	slli	a0,s1,0x20
    800021d0:	9101                	srli	a0,a0,0x20
    800021d2:	60e2                	ld	ra,24(sp)
    800021d4:	6442                	ld	s0,16(sp)
    800021d6:	64a2                	ld	s1,8(sp)
    800021d8:	6105                	addi	sp,sp,32
    800021da:	8082                	ret

00000000800021dc <binit>:
  struct buf head;
} bcache;

void
binit(void)
{
    800021dc:	7179                	addi	sp,sp,-48
    800021de:	f406                	sd	ra,40(sp)
    800021e0:	f022                	sd	s0,32(sp)
    800021e2:	ec26                	sd	s1,24(sp)
    800021e4:	e84a                	sd	s2,16(sp)
    800021e6:	e44e                	sd	s3,8(sp)
    800021e8:	e052                	sd	s4,0(sp)
    800021ea:	1800                	addi	s0,sp,48
  struct buf *b;

  initlock(&bcache.lock, "bcache");
    800021ec:	00006597          	auipc	a1,0x6
    800021f0:	28c58593          	addi	a1,a1,652 # 80008478 <syscalls+0xb0>
    800021f4:	00008517          	auipc	a0,0x8
    800021f8:	0b450513          	addi	a0,a0,180 # 8000a2a8 <bcache>
    800021fc:	00004097          	auipc	ra,0x4
    80002200:	f1c080e7          	jalr	-228(ra) # 80006118 <initlock>

  // Create linked list of buffers
  bcache.head.prev = &bcache.head;
    80002204:	00010797          	auipc	a5,0x10
    80002208:	0a478793          	addi	a5,a5,164 # 800122a8 <bcache+0x8000>
    8000220c:	00010717          	auipc	a4,0x10
    80002210:	30470713          	addi	a4,a4,772 # 80012510 <bcache+0x8268>
    80002214:	2ae7b823          	sd	a4,688(a5)
  bcache.head.next = &bcache.head;
    80002218:	2ae7bc23          	sd	a4,696(a5)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    8000221c:	00008497          	auipc	s1,0x8
    80002220:	0a448493          	addi	s1,s1,164 # 8000a2c0 <bcache+0x18>
    b->next = bcache.head.next;
    80002224:	893e                	mv	s2,a5
    b->prev = &bcache.head;
    80002226:	89ba                	mv	s3,a4
    initsleeplock(&b->lock, "buffer");
    80002228:	00006a17          	auipc	s4,0x6
    8000222c:	258a0a13          	addi	s4,s4,600 # 80008480 <syscalls+0xb8>
    b->next = bcache.head.next;
    80002230:	2b893783          	ld	a5,696(s2)
    80002234:	e8bc                	sd	a5,80(s1)
    b->prev = &bcache.head;
    80002236:	0534b423          	sd	s3,72(s1)
    initsleeplock(&b->lock, "buffer");
    8000223a:	85d2                	mv	a1,s4
    8000223c:	01048513          	addi	a0,s1,16
    80002240:	00001097          	auipc	ra,0x1
    80002244:	610080e7          	jalr	1552(ra) # 80003850 <initsleeplock>
    bcache.head.next->prev = b;
    80002248:	2b893783          	ld	a5,696(s2)
    8000224c:	e7a4                	sd	s1,72(a5)
    bcache.head.next = b;
    8000224e:	2a993c23          	sd	s1,696(s2)
  for(b = bcache.buf; b < bcache.buf+NBUF; b++){
    80002252:	45848493          	addi	s1,s1,1112
    80002256:	fd349de3          	bne	s1,s3,80002230 <binit+0x54>
  }
}
    8000225a:	70a2                	ld	ra,40(sp)
    8000225c:	7402                	ld	s0,32(sp)
    8000225e:	64e2                	ld	s1,24(sp)
    80002260:	6942                	ld	s2,16(sp)
    80002262:	69a2                	ld	s3,8(sp)
    80002264:	6a02                	ld	s4,0(sp)
    80002266:	6145                	addi	sp,sp,48
    80002268:	8082                	ret

000000008000226a <bread>:
}

// Return a locked buf with the contents of the indicated block.
struct buf*
bread(uint dev, uint blockno)
{
    8000226a:	7179                	addi	sp,sp,-48
    8000226c:	f406                	sd	ra,40(sp)
    8000226e:	f022                	sd	s0,32(sp)
    80002270:	ec26                	sd	s1,24(sp)
    80002272:	e84a                	sd	s2,16(sp)
    80002274:	e44e                	sd	s3,8(sp)
    80002276:	1800                	addi	s0,sp,48
    80002278:	892a                	mv	s2,a0
    8000227a:	89ae                	mv	s3,a1
  acquire(&bcache.lock);
    8000227c:	00008517          	auipc	a0,0x8
    80002280:	02c50513          	addi	a0,a0,44 # 8000a2a8 <bcache>
    80002284:	00004097          	auipc	ra,0x4
    80002288:	f24080e7          	jalr	-220(ra) # 800061a8 <acquire>
  for(b = bcache.head.next; b != &bcache.head; b = b->next){
    8000228c:	00010497          	auipc	s1,0x10
    80002290:	2d44b483          	ld	s1,724(s1) # 80012560 <bcache+0x82b8>
    80002294:	00010797          	auipc	a5,0x10
    80002298:	27c78793          	addi	a5,a5,636 # 80012510 <bcache+0x8268>
    8000229c:	02f48f63          	beq	s1,a5,800022da <bread+0x70>
    800022a0:	873e                	mv	a4,a5
    800022a2:	a021                	j	800022aa <bread+0x40>
    800022a4:	68a4                	ld	s1,80(s1)
    800022a6:	02e48a63          	beq	s1,a4,800022da <bread+0x70>
    if(b->dev == dev && b->blockno == blockno){
    800022aa:	449c                	lw	a5,8(s1)
    800022ac:	ff279ce3          	bne	a5,s2,800022a4 <bread+0x3a>
    800022b0:	44dc                	lw	a5,12(s1)
    800022b2:	ff3799e3          	bne	a5,s3,800022a4 <bread+0x3a>
      b->refcnt++;
    800022b6:	40bc                	lw	a5,64(s1)
    800022b8:	2785                	addiw	a5,a5,1
    800022ba:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    800022bc:	00008517          	auipc	a0,0x8
    800022c0:	fec50513          	addi	a0,a0,-20 # 8000a2a8 <bcache>
    800022c4:	00004097          	auipc	ra,0x4
    800022c8:	f98080e7          	jalr	-104(ra) # 8000625c <release>
      acquiresleep(&b->lock);
    800022cc:	01048513          	addi	a0,s1,16
    800022d0:	00001097          	auipc	ra,0x1
    800022d4:	5ba080e7          	jalr	1466(ra) # 8000388a <acquiresleep>
      return b;
    800022d8:	a8b9                	j	80002336 <bread+0xcc>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800022da:	00010497          	auipc	s1,0x10
    800022de:	27e4b483          	ld	s1,638(s1) # 80012558 <bcache+0x82b0>
    800022e2:	00010797          	auipc	a5,0x10
    800022e6:	22e78793          	addi	a5,a5,558 # 80012510 <bcache+0x8268>
    800022ea:	00f48863          	beq	s1,a5,800022fa <bread+0x90>
    800022ee:	873e                	mv	a4,a5
    if(b->refcnt == 0) {
    800022f0:	40bc                	lw	a5,64(s1)
    800022f2:	cf81                	beqz	a5,8000230a <bread+0xa0>
  for(b = bcache.head.prev; b != &bcache.head; b = b->prev){
    800022f4:	64a4                	ld	s1,72(s1)
    800022f6:	fee49de3          	bne	s1,a4,800022f0 <bread+0x86>
  panic("bget: no buffers");
    800022fa:	00006517          	auipc	a0,0x6
    800022fe:	18e50513          	addi	a0,a0,398 # 80008488 <syscalls+0xc0>
    80002302:	00004097          	auipc	ra,0x4
    80002306:	96e080e7          	jalr	-1682(ra) # 80005c70 <panic>
      b->dev = dev;
    8000230a:	0124a423          	sw	s2,8(s1)
      b->blockno = blockno;
    8000230e:	0134a623          	sw	s3,12(s1)
      b->valid = 0;
    80002312:	0004a023          	sw	zero,0(s1)
      b->refcnt = 1;
    80002316:	4785                	li	a5,1
    80002318:	c0bc                	sw	a5,64(s1)
      release(&bcache.lock);
    8000231a:	00008517          	auipc	a0,0x8
    8000231e:	f8e50513          	addi	a0,a0,-114 # 8000a2a8 <bcache>
    80002322:	00004097          	auipc	ra,0x4
    80002326:	f3a080e7          	jalr	-198(ra) # 8000625c <release>
      acquiresleep(&b->lock);
    8000232a:	01048513          	addi	a0,s1,16
    8000232e:	00001097          	auipc	ra,0x1
    80002332:	55c080e7          	jalr	1372(ra) # 8000388a <acquiresleep>
  struct buf *b;

  b = bget(dev, blockno);
  if(!b->valid) {
    80002336:	409c                	lw	a5,0(s1)
    80002338:	cb89                	beqz	a5,8000234a <bread+0xe0>
    virtio_disk_rw(b, 0);
    b->valid = 1;
  }
  return b;
}
    8000233a:	8526                	mv	a0,s1
    8000233c:	70a2                	ld	ra,40(sp)
    8000233e:	7402                	ld	s0,32(sp)
    80002340:	64e2                	ld	s1,24(sp)
    80002342:	6942                	ld	s2,16(sp)
    80002344:	69a2                	ld	s3,8(sp)
    80002346:	6145                	addi	sp,sp,48
    80002348:	8082                	ret
    virtio_disk_rw(b, 0);
    8000234a:	4581                	li	a1,0
    8000234c:	8526                	mv	a0,s1
    8000234e:	00003097          	auipc	ra,0x3
    80002352:	0b4080e7          	jalr	180(ra) # 80005402 <virtio_disk_rw>
    b->valid = 1;
    80002356:	4785                	li	a5,1
    80002358:	c09c                	sw	a5,0(s1)
  return b;
    8000235a:	b7c5                	j	8000233a <bread+0xd0>

000000008000235c <bwrite>:

// Write b's contents to disk.  Must be locked.
void
bwrite(struct buf *b)
{
    8000235c:	1101                	addi	sp,sp,-32
    8000235e:	ec06                	sd	ra,24(sp)
    80002360:	e822                	sd	s0,16(sp)
    80002362:	e426                	sd	s1,8(sp)
    80002364:	1000                	addi	s0,sp,32
    80002366:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    80002368:	0541                	addi	a0,a0,16
    8000236a:	00001097          	auipc	ra,0x1
    8000236e:	5ba080e7          	jalr	1466(ra) # 80003924 <holdingsleep>
    80002372:	cd01                	beqz	a0,8000238a <bwrite+0x2e>
    panic("bwrite");
  virtio_disk_rw(b, 1);
    80002374:	4585                	li	a1,1
    80002376:	8526                	mv	a0,s1
    80002378:	00003097          	auipc	ra,0x3
    8000237c:	08a080e7          	jalr	138(ra) # 80005402 <virtio_disk_rw>
}
    80002380:	60e2                	ld	ra,24(sp)
    80002382:	6442                	ld	s0,16(sp)
    80002384:	64a2                	ld	s1,8(sp)
    80002386:	6105                	addi	sp,sp,32
    80002388:	8082                	ret
    panic("bwrite");
    8000238a:	00006517          	auipc	a0,0x6
    8000238e:	11650513          	addi	a0,a0,278 # 800084a0 <syscalls+0xd8>
    80002392:	00004097          	auipc	ra,0x4
    80002396:	8de080e7          	jalr	-1826(ra) # 80005c70 <panic>

000000008000239a <brelse>:

// Release a locked buffer.
// Move to the head of the most-recently-used list.
void
brelse(struct buf *b)
{
    8000239a:	1101                	addi	sp,sp,-32
    8000239c:	ec06                	sd	ra,24(sp)
    8000239e:	e822                	sd	s0,16(sp)
    800023a0:	e426                	sd	s1,8(sp)
    800023a2:	e04a                	sd	s2,0(sp)
    800023a4:	1000                	addi	s0,sp,32
    800023a6:	84aa                	mv	s1,a0
  if(!holdingsleep(&b->lock))
    800023a8:	01050913          	addi	s2,a0,16
    800023ac:	854a                	mv	a0,s2
    800023ae:	00001097          	auipc	ra,0x1
    800023b2:	576080e7          	jalr	1398(ra) # 80003924 <holdingsleep>
    800023b6:	c92d                	beqz	a0,80002428 <brelse+0x8e>
    panic("brelse");

  releasesleep(&b->lock);
    800023b8:	854a                	mv	a0,s2
    800023ba:	00001097          	auipc	ra,0x1
    800023be:	526080e7          	jalr	1318(ra) # 800038e0 <releasesleep>

  acquire(&bcache.lock);
    800023c2:	00008517          	auipc	a0,0x8
    800023c6:	ee650513          	addi	a0,a0,-282 # 8000a2a8 <bcache>
    800023ca:	00004097          	auipc	ra,0x4
    800023ce:	dde080e7          	jalr	-546(ra) # 800061a8 <acquire>
  b->refcnt--;
    800023d2:	40bc                	lw	a5,64(s1)
    800023d4:	37fd                	addiw	a5,a5,-1
    800023d6:	0007871b          	sext.w	a4,a5
    800023da:	c0bc                	sw	a5,64(s1)
  if (b->refcnt == 0) {
    800023dc:	eb05                	bnez	a4,8000240c <brelse+0x72>
    // no one is waiting for it.
    b->next->prev = b->prev;
    800023de:	68bc                	ld	a5,80(s1)
    800023e0:	64b8                	ld	a4,72(s1)
    800023e2:	e7b8                	sd	a4,72(a5)
    b->prev->next = b->next;
    800023e4:	64bc                	ld	a5,72(s1)
    800023e6:	68b8                	ld	a4,80(s1)
    800023e8:	ebb8                	sd	a4,80(a5)
    b->next = bcache.head.next;
    800023ea:	00010797          	auipc	a5,0x10
    800023ee:	ebe78793          	addi	a5,a5,-322 # 800122a8 <bcache+0x8000>
    800023f2:	2b87b703          	ld	a4,696(a5)
    800023f6:	e8b8                	sd	a4,80(s1)
    b->prev = &bcache.head;
    800023f8:	00010717          	auipc	a4,0x10
    800023fc:	11870713          	addi	a4,a4,280 # 80012510 <bcache+0x8268>
    80002400:	e4b8                	sd	a4,72(s1)
    bcache.head.next->prev = b;
    80002402:	2b87b703          	ld	a4,696(a5)
    80002406:	e724                	sd	s1,72(a4)
    bcache.head.next = b;
    80002408:	2a97bc23          	sd	s1,696(a5)
  }
  
  release(&bcache.lock);
    8000240c:	00008517          	auipc	a0,0x8
    80002410:	e9c50513          	addi	a0,a0,-356 # 8000a2a8 <bcache>
    80002414:	00004097          	auipc	ra,0x4
    80002418:	e48080e7          	jalr	-440(ra) # 8000625c <release>
}
    8000241c:	60e2                	ld	ra,24(sp)
    8000241e:	6442                	ld	s0,16(sp)
    80002420:	64a2                	ld	s1,8(sp)
    80002422:	6902                	ld	s2,0(sp)
    80002424:	6105                	addi	sp,sp,32
    80002426:	8082                	ret
    panic("brelse");
    80002428:	00006517          	auipc	a0,0x6
    8000242c:	08050513          	addi	a0,a0,128 # 800084a8 <syscalls+0xe0>
    80002430:	00004097          	auipc	ra,0x4
    80002434:	840080e7          	jalr	-1984(ra) # 80005c70 <panic>

0000000080002438 <bpin>:

void
bpin(struct buf *b) {
    80002438:	1101                	addi	sp,sp,-32
    8000243a:	ec06                	sd	ra,24(sp)
    8000243c:	e822                	sd	s0,16(sp)
    8000243e:	e426                	sd	s1,8(sp)
    80002440:	1000                	addi	s0,sp,32
    80002442:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002444:	00008517          	auipc	a0,0x8
    80002448:	e6450513          	addi	a0,a0,-412 # 8000a2a8 <bcache>
    8000244c:	00004097          	auipc	ra,0x4
    80002450:	d5c080e7          	jalr	-676(ra) # 800061a8 <acquire>
  b->refcnt++;
    80002454:	40bc                	lw	a5,64(s1)
    80002456:	2785                	addiw	a5,a5,1
    80002458:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    8000245a:	00008517          	auipc	a0,0x8
    8000245e:	e4e50513          	addi	a0,a0,-434 # 8000a2a8 <bcache>
    80002462:	00004097          	auipc	ra,0x4
    80002466:	dfa080e7          	jalr	-518(ra) # 8000625c <release>
}
    8000246a:	60e2                	ld	ra,24(sp)
    8000246c:	6442                	ld	s0,16(sp)
    8000246e:	64a2                	ld	s1,8(sp)
    80002470:	6105                	addi	sp,sp,32
    80002472:	8082                	ret

0000000080002474 <bunpin>:

void
bunpin(struct buf *b) {
    80002474:	1101                	addi	sp,sp,-32
    80002476:	ec06                	sd	ra,24(sp)
    80002478:	e822                	sd	s0,16(sp)
    8000247a:	e426                	sd	s1,8(sp)
    8000247c:	1000                	addi	s0,sp,32
    8000247e:	84aa                	mv	s1,a0
  acquire(&bcache.lock);
    80002480:	00008517          	auipc	a0,0x8
    80002484:	e2850513          	addi	a0,a0,-472 # 8000a2a8 <bcache>
    80002488:	00004097          	auipc	ra,0x4
    8000248c:	d20080e7          	jalr	-736(ra) # 800061a8 <acquire>
  b->refcnt--;
    80002490:	40bc                	lw	a5,64(s1)
    80002492:	37fd                	addiw	a5,a5,-1
    80002494:	c0bc                	sw	a5,64(s1)
  release(&bcache.lock);
    80002496:	00008517          	auipc	a0,0x8
    8000249a:	e1250513          	addi	a0,a0,-494 # 8000a2a8 <bcache>
    8000249e:	00004097          	auipc	ra,0x4
    800024a2:	dbe080e7          	jalr	-578(ra) # 8000625c <release>
}
    800024a6:	60e2                	ld	ra,24(sp)
    800024a8:	6442                	ld	s0,16(sp)
    800024aa:	64a2                	ld	s1,8(sp)
    800024ac:	6105                	addi	sp,sp,32
    800024ae:	8082                	ret

00000000800024b0 <bfree>:
}

// Free a disk block.
static void
bfree(int dev, uint b)
{
    800024b0:	1101                	addi	sp,sp,-32
    800024b2:	ec06                	sd	ra,24(sp)
    800024b4:	e822                	sd	s0,16(sp)
    800024b6:	e426                	sd	s1,8(sp)
    800024b8:	e04a                	sd	s2,0(sp)
    800024ba:	1000                	addi	s0,sp,32
    800024bc:	84ae                	mv	s1,a1
  struct buf *bp;
  int bi, m;

  bp = bread(dev, BBLOCK(b, sb));
    800024be:	00d5d59b          	srliw	a1,a1,0xd
    800024c2:	00010797          	auipc	a5,0x10
    800024c6:	4c27a783          	lw	a5,1218(a5) # 80012984 <sb+0x1c>
    800024ca:	9dbd                	addw	a1,a1,a5
    800024cc:	00000097          	auipc	ra,0x0
    800024d0:	d9e080e7          	jalr	-610(ra) # 8000226a <bread>
  bi = b % BPB;
  m = 1 << (bi % 8);
    800024d4:	0074f713          	andi	a4,s1,7
    800024d8:	4785                	li	a5,1
    800024da:	00e797bb          	sllw	a5,a5,a4
  if ((bp->data[bi / 8] & m) == 0)
    800024de:	14ce                	slli	s1,s1,0x33
    800024e0:	90d9                	srli	s1,s1,0x36
    800024e2:	00950733          	add	a4,a0,s1
    800024e6:	05874703          	lbu	a4,88(a4)
    800024ea:	00e7f6b3          	and	a3,a5,a4
    800024ee:	c69d                	beqz	a3,8000251c <bfree+0x6c>
    800024f0:	892a                	mv	s2,a0
    panic("freeing free block");
  bp->data[bi / 8] &= ~m;
    800024f2:	94aa                	add	s1,s1,a0
    800024f4:	fff7c793          	not	a5,a5
    800024f8:	8f7d                	and	a4,a4,a5
    800024fa:	04e48c23          	sb	a4,88(s1)
  log_write(bp);
    800024fe:	00001097          	auipc	ra,0x1
    80002502:	26e080e7          	jalr	622(ra) # 8000376c <log_write>
  brelse(bp);
    80002506:	854a                	mv	a0,s2
    80002508:	00000097          	auipc	ra,0x0
    8000250c:	e92080e7          	jalr	-366(ra) # 8000239a <brelse>
}
    80002510:	60e2                	ld	ra,24(sp)
    80002512:	6442                	ld	s0,16(sp)
    80002514:	64a2                	ld	s1,8(sp)
    80002516:	6902                	ld	s2,0(sp)
    80002518:	6105                	addi	sp,sp,32
    8000251a:	8082                	ret
    panic("freeing free block");
    8000251c:	00006517          	auipc	a0,0x6
    80002520:	f9450513          	addi	a0,a0,-108 # 800084b0 <syscalls+0xe8>
    80002524:	00003097          	auipc	ra,0x3
    80002528:	74c080e7          	jalr	1868(ra) # 80005c70 <panic>

000000008000252c <balloc>:
{
    8000252c:	711d                	addi	sp,sp,-96
    8000252e:	ec86                	sd	ra,88(sp)
    80002530:	e8a2                	sd	s0,80(sp)
    80002532:	e4a6                	sd	s1,72(sp)
    80002534:	e0ca                	sd	s2,64(sp)
    80002536:	fc4e                	sd	s3,56(sp)
    80002538:	f852                	sd	s4,48(sp)
    8000253a:	f456                	sd	s5,40(sp)
    8000253c:	f05a                	sd	s6,32(sp)
    8000253e:	ec5e                	sd	s7,24(sp)
    80002540:	e862                	sd	s8,16(sp)
    80002542:	e466                	sd	s9,8(sp)
    80002544:	1080                	addi	s0,sp,96
  for (b = 0; b < sb.size; b += BPB)
    80002546:	00010797          	auipc	a5,0x10
    8000254a:	4267a783          	lw	a5,1062(a5) # 8001296c <sb+0x4>
    8000254e:	cbc1                	beqz	a5,800025de <balloc+0xb2>
    80002550:	8baa                	mv	s7,a0
    80002552:	4a81                	li	s5,0
    bp = bread(dev, BBLOCK(b, sb));
    80002554:	00010b17          	auipc	s6,0x10
    80002558:	414b0b13          	addi	s6,s6,1044 # 80012968 <sb>
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
    8000255c:	4c01                	li	s8,0
      m = 1 << (bi % 8);
    8000255e:	4985                	li	s3,1
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
    80002560:	6a09                	lui	s4,0x2
  for (b = 0; b < sb.size; b += BPB)
    80002562:	6c89                	lui	s9,0x2
    80002564:	a831                	j	80002580 <balloc+0x54>
    brelse(bp);
    80002566:	854a                	mv	a0,s2
    80002568:	00000097          	auipc	ra,0x0
    8000256c:	e32080e7          	jalr	-462(ra) # 8000239a <brelse>
  for (b = 0; b < sb.size; b += BPB)
    80002570:	015c87bb          	addw	a5,s9,s5
    80002574:	00078a9b          	sext.w	s5,a5
    80002578:	004b2703          	lw	a4,4(s6)
    8000257c:	06eaf163          	bgeu	s5,a4,800025de <balloc+0xb2>
    bp = bread(dev, BBLOCK(b, sb));
    80002580:	41fad79b          	sraiw	a5,s5,0x1f
    80002584:	0137d79b          	srliw	a5,a5,0x13
    80002588:	015787bb          	addw	a5,a5,s5
    8000258c:	40d7d79b          	sraiw	a5,a5,0xd
    80002590:	01cb2583          	lw	a1,28(s6)
    80002594:	9dbd                	addw	a1,a1,a5
    80002596:	855e                	mv	a0,s7
    80002598:	00000097          	auipc	ra,0x0
    8000259c:	cd2080e7          	jalr	-814(ra) # 8000226a <bread>
    800025a0:	892a                	mv	s2,a0
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
    800025a2:	004b2503          	lw	a0,4(s6)
    800025a6:	000a849b          	sext.w	s1,s5
    800025aa:	8762                	mv	a4,s8
    800025ac:	faa4fde3          	bgeu	s1,a0,80002566 <balloc+0x3a>
      m = 1 << (bi % 8);
    800025b0:	00777693          	andi	a3,a4,7
    800025b4:	00d996bb          	sllw	a3,s3,a3
      if ((bp->data[bi / 8] & m) == 0)
    800025b8:	41f7579b          	sraiw	a5,a4,0x1f
    800025bc:	01d7d79b          	srliw	a5,a5,0x1d
    800025c0:	9fb9                	addw	a5,a5,a4
    800025c2:	4037d79b          	sraiw	a5,a5,0x3
    800025c6:	00f90633          	add	a2,s2,a5
    800025ca:	05864603          	lbu	a2,88(a2)
    800025ce:	00c6f5b3          	and	a1,a3,a2
    800025d2:	cd91                	beqz	a1,800025ee <balloc+0xc2>
    for (bi = 0; bi < BPB && b + bi < sb.size; bi++)
    800025d4:	2705                	addiw	a4,a4,1
    800025d6:	2485                	addiw	s1,s1,1
    800025d8:	fd471ae3          	bne	a4,s4,800025ac <balloc+0x80>
    800025dc:	b769                	j	80002566 <balloc+0x3a>
  panic("balloc: out of blocks");
    800025de:	00006517          	auipc	a0,0x6
    800025e2:	eea50513          	addi	a0,a0,-278 # 800084c8 <syscalls+0x100>
    800025e6:	00003097          	auipc	ra,0x3
    800025ea:	68a080e7          	jalr	1674(ra) # 80005c70 <panic>
        bp->data[bi / 8] |= m; // Mark block in use.
    800025ee:	97ca                	add	a5,a5,s2
    800025f0:	8e55                	or	a2,a2,a3
    800025f2:	04c78c23          	sb	a2,88(a5)
        log_write(bp);
    800025f6:	854a                	mv	a0,s2
    800025f8:	00001097          	auipc	ra,0x1
    800025fc:	174080e7          	jalr	372(ra) # 8000376c <log_write>
        brelse(bp);
    80002600:	854a                	mv	a0,s2
    80002602:	00000097          	auipc	ra,0x0
    80002606:	d98080e7          	jalr	-616(ra) # 8000239a <brelse>
  bp = bread(dev, bno);
    8000260a:	85a6                	mv	a1,s1
    8000260c:	855e                	mv	a0,s7
    8000260e:	00000097          	auipc	ra,0x0
    80002612:	c5c080e7          	jalr	-932(ra) # 8000226a <bread>
    80002616:	892a                	mv	s2,a0
  memset(bp->data, 0, BSIZE);
    80002618:	40000613          	li	a2,1024
    8000261c:	4581                	li	a1,0
    8000261e:	05850513          	addi	a0,a0,88
    80002622:	ffffe097          	auipc	ra,0xffffe
    80002626:	b58080e7          	jalr	-1192(ra) # 8000017a <memset>
  log_write(bp);
    8000262a:	854a                	mv	a0,s2
    8000262c:	00001097          	auipc	ra,0x1
    80002630:	140080e7          	jalr	320(ra) # 8000376c <log_write>
  brelse(bp);
    80002634:	854a                	mv	a0,s2
    80002636:	00000097          	auipc	ra,0x0
    8000263a:	d64080e7          	jalr	-668(ra) # 8000239a <brelse>
}
    8000263e:	8526                	mv	a0,s1
    80002640:	60e6                	ld	ra,88(sp)
    80002642:	6446                	ld	s0,80(sp)
    80002644:	64a6                	ld	s1,72(sp)
    80002646:	6906                	ld	s2,64(sp)
    80002648:	79e2                	ld	s3,56(sp)
    8000264a:	7a42                	ld	s4,48(sp)
    8000264c:	7aa2                	ld	s5,40(sp)
    8000264e:	7b02                	ld	s6,32(sp)
    80002650:	6be2                	ld	s7,24(sp)
    80002652:	6c42                	ld	s8,16(sp)
    80002654:	6ca2                	ld	s9,8(sp)
    80002656:	6125                	addi	sp,sp,96
    80002658:	8082                	ret

000000008000265a <bmap>:
// listed in block ip->addrs[NDIRECT].

// Return the disk block address of the nth block in inode ip.
// If there is no such block, bmap allocates one.
static uint
bmap(struct inode *ip, uint bn) {
    8000265a:	7139                	addi	sp,sp,-64
    8000265c:	fc06                	sd	ra,56(sp)
    8000265e:	f822                	sd	s0,48(sp)
    80002660:	f426                	sd	s1,40(sp)
    80002662:	f04a                	sd	s2,32(sp)
    80002664:	ec4e                	sd	s3,24(sp)
    80002666:	e852                	sd	s4,16(sp)
    80002668:	e456                	sd	s5,8(sp)
    8000266a:	0080                	addi	s0,sp,64
    8000266c:	89aa                	mv	s3,a0
  struct buf *bp;
  uint addr, *a;
  uint indirect;

  if (bn < NDIRECT) { // 直接块
    8000266e:	47ad                	li	a5,11
    80002670:	08b7fd63          	bgeu	a5,a1,8000270a <bmap+0xb0>
    if ((addr = ip->addrs[bn]) == 0) {
      ip->addrs[bn] = addr = balloc(ip->dev);
    }
    return addr;
  }
  bn -= NDIRECT;
    80002674:	ff45849b          	addiw	s1,a1,-12
    80002678:	0004871b          	sext.w	a4,s1

  if (bn < NINDIRECT) { // 一级间接块
    8000267c:	0ff00793          	li	a5,255
    80002680:	0ae7f963          	bgeu	a5,a4,80002732 <bmap+0xd8>
      log_write(bp);
    }
    brelse(bp);
    return addr;
  }
  bn -= NINDIRECT;
    80002684:	ef45849b          	addiw	s1,a1,-268
    80002688:	0004871b          	sext.w	a4,s1

  if (bn < NINDIRECT * NINDIRECT) { // 二级间接块
    8000268c:	67c1                	lui	a5,0x10
    8000268e:	16f77163          	bgeu	a4,a5,800027f0 <bmap+0x196>
    if ((addr = ip->addrs[NDIRECT + 1]) == 0) {
    80002692:	08452583          	lw	a1,132(a0)
    80002696:	10058363          	beqz	a1,8000279c <bmap+0x142>
      ip->addrs[NDIRECT + 1] = addr = balloc(ip->dev);
    }
    bp = bread(ip->dev, addr);
    8000269a:	0009a503          	lw	a0,0(s3)
    8000269e:	00000097          	auipc	ra,0x0
    800026a2:	bcc080e7          	jalr	-1076(ra) # 8000226a <bread>
    800026a6:	892a                	mv	s2,a0
    a = (uint *)bp->data;
    800026a8:	05850a13          	addi	s4,a0,88
    indirect = bn / NINDIRECT;
    if ((addr = a[indirect]) == 0) {
    800026ac:	0084d79b          	srliw	a5,s1,0x8
    800026b0:	078a                	slli	a5,a5,0x2
    800026b2:	9a3e                	add	s4,s4,a5
    800026b4:	000a2a83          	lw	s5,0(s4) # 2000 <_entry-0x7fffe000>
    800026b8:	0e0a8c63          	beqz	s5,800027b0 <bmap+0x156>
      a[indirect] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800026bc:	854a                	mv	a0,s2
    800026be:	00000097          	auipc	ra,0x0
    800026c2:	cdc080e7          	jalr	-804(ra) # 8000239a <brelse>
    bp = bread(ip->dev, addr);
    800026c6:	85d6                	mv	a1,s5
    800026c8:	0009a503          	lw	a0,0(s3)
    800026cc:	00000097          	auipc	ra,0x0
    800026d0:	b9e080e7          	jalr	-1122(ra) # 8000226a <bread>
    800026d4:	8a2a                	mv	s4,a0
    a = (uint *)bp->data;
    800026d6:	05850793          	addi	a5,a0,88
    indirect = bn % NINDIRECT;
    if ((addr = a[indirect]) == 0) {
    800026da:	0ff4f593          	zext.b	a1,s1
    800026de:	058a                	slli	a1,a1,0x2
    800026e0:	00b784b3          	add	s1,a5,a1
    800026e4:	0004a903          	lw	s2,0(s1)
    800026e8:	0e090463          	beqz	s2,800027d0 <bmap+0x176>
      a[indirect] = addr = balloc(ip->dev);
      log_write(bp);
    }
    brelse(bp);
    800026ec:	8552                	mv	a0,s4
    800026ee:	00000097          	auipc	ra,0x0
    800026f2:	cac080e7          	jalr	-852(ra) # 8000239a <brelse>
    return addr;
  }

  // 超出错处理错误情况
  panic("bmap: block number out of range");
}
    800026f6:	854a                	mv	a0,s2
    800026f8:	70e2                	ld	ra,56(sp)
    800026fa:	7442                	ld	s0,48(sp)
    800026fc:	74a2                	ld	s1,40(sp)
    800026fe:	7902                	ld	s2,32(sp)
    80002700:	69e2                	ld	s3,24(sp)
    80002702:	6a42                	ld	s4,16(sp)
    80002704:	6aa2                	ld	s5,8(sp)
    80002706:	6121                	addi	sp,sp,64
    80002708:	8082                	ret
    if ((addr = ip->addrs[bn]) == 0) {
    8000270a:	02059793          	slli	a5,a1,0x20
    8000270e:	01e7d593          	srli	a1,a5,0x1e
    80002712:	00b504b3          	add	s1,a0,a1
    80002716:	0504a903          	lw	s2,80(s1)
    8000271a:	fc091ee3          	bnez	s2,800026f6 <bmap+0x9c>
      ip->addrs[bn] = addr = balloc(ip->dev);
    8000271e:	4108                	lw	a0,0(a0)
    80002720:	00000097          	auipc	ra,0x0
    80002724:	e0c080e7          	jalr	-500(ra) # 8000252c <balloc>
    80002728:	0005091b          	sext.w	s2,a0
    8000272c:	0524a823          	sw	s2,80(s1)
    80002730:	b7d9                	j	800026f6 <bmap+0x9c>
    if ((addr = ip->addrs[NDIRECT]) == 0) {
    80002732:	08052583          	lw	a1,128(a0)
    80002736:	c98d                	beqz	a1,80002768 <bmap+0x10e>
    bp = bread(ip->dev, addr);
    80002738:	0009a503          	lw	a0,0(s3)
    8000273c:	00000097          	auipc	ra,0x0
    80002740:	b2e080e7          	jalr	-1234(ra) # 8000226a <bread>
    80002744:	8a2a                	mv	s4,a0
    a = (uint *)bp->data;
    80002746:	05850793          	addi	a5,a0,88
    if ((addr = a[bn]) == 0) {
    8000274a:	02049713          	slli	a4,s1,0x20
    8000274e:	01e75493          	srli	s1,a4,0x1e
    80002752:	94be                	add	s1,s1,a5
    80002754:	0004a903          	lw	s2,0(s1)
    80002758:	02090263          	beqz	s2,8000277c <bmap+0x122>
    brelse(bp);
    8000275c:	8552                	mv	a0,s4
    8000275e:	00000097          	auipc	ra,0x0
    80002762:	c3c080e7          	jalr	-964(ra) # 8000239a <brelse>
    return addr;
    80002766:	bf41                	j	800026f6 <bmap+0x9c>
      ip->addrs[NDIRECT] = addr = balloc(ip->dev);
    80002768:	4108                	lw	a0,0(a0)
    8000276a:	00000097          	auipc	ra,0x0
    8000276e:	dc2080e7          	jalr	-574(ra) # 8000252c <balloc>
    80002772:	0005059b          	sext.w	a1,a0
    80002776:	08b9a023          	sw	a1,128(s3)
    8000277a:	bf7d                	j	80002738 <bmap+0xde>
      a[bn] = addr = balloc(ip->dev);
    8000277c:	0009a503          	lw	a0,0(s3)
    80002780:	00000097          	auipc	ra,0x0
    80002784:	dac080e7          	jalr	-596(ra) # 8000252c <balloc>
    80002788:	0005091b          	sext.w	s2,a0
    8000278c:	0124a023          	sw	s2,0(s1)
      log_write(bp);
    80002790:	8552                	mv	a0,s4
    80002792:	00001097          	auipc	ra,0x1
    80002796:	fda080e7          	jalr	-38(ra) # 8000376c <log_write>
    8000279a:	b7c9                	j	8000275c <bmap+0x102>
      ip->addrs[NDIRECT + 1] = addr = balloc(ip->dev);
    8000279c:	4108                	lw	a0,0(a0)
    8000279e:	00000097          	auipc	ra,0x0
    800027a2:	d8e080e7          	jalr	-626(ra) # 8000252c <balloc>
    800027a6:	0005059b          	sext.w	a1,a0
    800027aa:	08b9a223          	sw	a1,132(s3)
    800027ae:	b5f5                	j	8000269a <bmap+0x40>
      a[indirect] = addr = balloc(ip->dev);
    800027b0:	0009a503          	lw	a0,0(s3)
    800027b4:	00000097          	auipc	ra,0x0
    800027b8:	d78080e7          	jalr	-648(ra) # 8000252c <balloc>
    800027bc:	00050a9b          	sext.w	s5,a0
    800027c0:	015a2023          	sw	s5,0(s4)
      log_write(bp);
    800027c4:	854a                	mv	a0,s2
    800027c6:	00001097          	auipc	ra,0x1
    800027ca:	fa6080e7          	jalr	-90(ra) # 8000376c <log_write>
    800027ce:	b5fd                	j	800026bc <bmap+0x62>
      a[indirect] = addr = balloc(ip->dev);
    800027d0:	0009a503          	lw	a0,0(s3)
    800027d4:	00000097          	auipc	ra,0x0
    800027d8:	d58080e7          	jalr	-680(ra) # 8000252c <balloc>
    800027dc:	0005091b          	sext.w	s2,a0
    800027e0:	0124a023          	sw	s2,0(s1)
      log_write(bp);
    800027e4:	8552                	mv	a0,s4
    800027e6:	00001097          	auipc	ra,0x1
    800027ea:	f86080e7          	jalr	-122(ra) # 8000376c <log_write>
    800027ee:	bdfd                	j	800026ec <bmap+0x92>
  panic("bmap: block number out of range");
    800027f0:	00006517          	auipc	a0,0x6
    800027f4:	cf050513          	addi	a0,a0,-784 # 800084e0 <syscalls+0x118>
    800027f8:	00003097          	auipc	ra,0x3
    800027fc:	478080e7          	jalr	1144(ra) # 80005c70 <panic>

0000000080002800 <iget>:
{
    80002800:	7179                	addi	sp,sp,-48
    80002802:	f406                	sd	ra,40(sp)
    80002804:	f022                	sd	s0,32(sp)
    80002806:	ec26                	sd	s1,24(sp)
    80002808:	e84a                	sd	s2,16(sp)
    8000280a:	e44e                	sd	s3,8(sp)
    8000280c:	e052                	sd	s4,0(sp)
    8000280e:	1800                	addi	s0,sp,48
    80002810:	89aa                	mv	s3,a0
    80002812:	8a2e                	mv	s4,a1
  acquire(&itable.lock);
    80002814:	00010517          	auipc	a0,0x10
    80002818:	17450513          	addi	a0,a0,372 # 80012988 <itable>
    8000281c:	00004097          	auipc	ra,0x4
    80002820:	98c080e7          	jalr	-1652(ra) # 800061a8 <acquire>
  empty = 0;
    80002824:	4901                	li	s2,0
  for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++)
    80002826:	00010497          	auipc	s1,0x10
    8000282a:	17a48493          	addi	s1,s1,378 # 800129a0 <itable+0x18>
    8000282e:	0001e697          	auipc	a3,0x1e
    80002832:	27268693          	addi	a3,a3,626 # 80020aa0 <log>
    80002836:	a039                	j	80002844 <iget+0x44>
    if (empty == 0 && ip->ref == 0) // Remember empty slot.
    80002838:	02090b63          	beqz	s2,8000286e <iget+0x6e>
  for (ip = &itable.inode[0]; ip < &itable.inode[NINODE]; ip++)
    8000283c:	48048493          	addi	s1,s1,1152
    80002840:	02d48a63          	beq	s1,a3,80002874 <iget+0x74>
    if (ip->ref > 0 && ip->dev == dev && ip->inum == inum)
    80002844:	449c                	lw	a5,8(s1)
    80002846:	fef059e3          	blez	a5,80002838 <iget+0x38>
    8000284a:	4098                	lw	a4,0(s1)
    8000284c:	ff3716e3          	bne	a4,s3,80002838 <iget+0x38>
    80002850:	40d8                	lw	a4,4(s1)
    80002852:	ff4713e3          	bne	a4,s4,80002838 <iget+0x38>
      ip->ref++;
    80002856:	2785                	addiw	a5,a5,1 # 10001 <_entry-0x7ffeffff>
    80002858:	c49c                	sw	a5,8(s1)
      release(&itable.lock);
    8000285a:	00010517          	auipc	a0,0x10
    8000285e:	12e50513          	addi	a0,a0,302 # 80012988 <itable>
    80002862:	00004097          	auipc	ra,0x4
    80002866:	9fa080e7          	jalr	-1542(ra) # 8000625c <release>
      return ip;
    8000286a:	8926                	mv	s2,s1
    8000286c:	a03d                	j	8000289a <iget+0x9a>
    if (empty == 0 && ip->ref == 0) // Remember empty slot.
    8000286e:	f7f9                	bnez	a5,8000283c <iget+0x3c>
    80002870:	8926                	mv	s2,s1
    80002872:	b7e9                	j	8000283c <iget+0x3c>
  if (empty == 0)
    80002874:	02090c63          	beqz	s2,800028ac <iget+0xac>
  ip->dev = dev;
    80002878:	01392023          	sw	s3,0(s2)
  ip->inum = inum;
    8000287c:	01492223          	sw	s4,4(s2)
  ip->ref = 1;
    80002880:	4785                	li	a5,1
    80002882:	00f92423          	sw	a5,8(s2)
  ip->valid = 0;
    80002886:	04092023          	sw	zero,64(s2)
  release(&itable.lock);
    8000288a:	00010517          	auipc	a0,0x10
    8000288e:	0fe50513          	addi	a0,a0,254 # 80012988 <itable>
    80002892:	00004097          	auipc	ra,0x4
    80002896:	9ca080e7          	jalr	-1590(ra) # 8000625c <release>
}
    8000289a:	854a                	mv	a0,s2
    8000289c:	70a2                	ld	ra,40(sp)
    8000289e:	7402                	ld	s0,32(sp)
    800028a0:	64e2                	ld	s1,24(sp)
    800028a2:	6942                	ld	s2,16(sp)
    800028a4:	69a2                	ld	s3,8(sp)
    800028a6:	6a02                	ld	s4,0(sp)
    800028a8:	6145                	addi	sp,sp,48
    800028aa:	8082                	ret
    panic("iget: no inodes");
    800028ac:	00006517          	auipc	a0,0x6
    800028b0:	c5450513          	addi	a0,a0,-940 # 80008500 <syscalls+0x138>
    800028b4:	00003097          	auipc	ra,0x3
    800028b8:	3bc080e7          	jalr	956(ra) # 80005c70 <panic>

00000000800028bc <fsinit>:
{
    800028bc:	7179                	addi	sp,sp,-48
    800028be:	f406                	sd	ra,40(sp)
    800028c0:	f022                	sd	s0,32(sp)
    800028c2:	ec26                	sd	s1,24(sp)
    800028c4:	e84a                	sd	s2,16(sp)
    800028c6:	e44e                	sd	s3,8(sp)
    800028c8:	1800                	addi	s0,sp,48
    800028ca:	892a                	mv	s2,a0
  bp = bread(dev, 1);
    800028cc:	4585                	li	a1,1
    800028ce:	00000097          	auipc	ra,0x0
    800028d2:	99c080e7          	jalr	-1636(ra) # 8000226a <bread>
    800028d6:	84aa                	mv	s1,a0
  memmove(sb, bp->data, sizeof(*sb));
    800028d8:	00010997          	auipc	s3,0x10
    800028dc:	09098993          	addi	s3,s3,144 # 80012968 <sb>
    800028e0:	02000613          	li	a2,32
    800028e4:	05850593          	addi	a1,a0,88
    800028e8:	854e                	mv	a0,s3
    800028ea:	ffffe097          	auipc	ra,0xffffe
    800028ee:	8ec080e7          	jalr	-1812(ra) # 800001d6 <memmove>
  brelse(bp);
    800028f2:	8526                	mv	a0,s1
    800028f4:	00000097          	auipc	ra,0x0
    800028f8:	aa6080e7          	jalr	-1370(ra) # 8000239a <brelse>
  if (sb.magic != FSMAGIC)
    800028fc:	0009a703          	lw	a4,0(s3)
    80002900:	102037b7          	lui	a5,0x10203
    80002904:	04078793          	addi	a5,a5,64 # 10203040 <_entry-0x6fdfcfc0>
    80002908:	02f71263          	bne	a4,a5,8000292c <fsinit+0x70>
  initlog(dev, &sb);
    8000290c:	00010597          	auipc	a1,0x10
    80002910:	05c58593          	addi	a1,a1,92 # 80012968 <sb>
    80002914:	854a                	mv	a0,s2
    80002916:	00001097          	auipc	ra,0x1
    8000291a:	bda080e7          	jalr	-1062(ra) # 800034f0 <initlog>
}
    8000291e:	70a2                	ld	ra,40(sp)
    80002920:	7402                	ld	s0,32(sp)
    80002922:	64e2                	ld	s1,24(sp)
    80002924:	6942                	ld	s2,16(sp)
    80002926:	69a2                	ld	s3,8(sp)
    80002928:	6145                	addi	sp,sp,48
    8000292a:	8082                	ret
    panic("invalid file system");
    8000292c:	00006517          	auipc	a0,0x6
    80002930:	be450513          	addi	a0,a0,-1052 # 80008510 <syscalls+0x148>
    80002934:	00003097          	auipc	ra,0x3
    80002938:	33c080e7          	jalr	828(ra) # 80005c70 <panic>

000000008000293c <iinit>:
{
    8000293c:	7179                	addi	sp,sp,-48
    8000293e:	f406                	sd	ra,40(sp)
    80002940:	f022                	sd	s0,32(sp)
    80002942:	ec26                	sd	s1,24(sp)
    80002944:	e84a                	sd	s2,16(sp)
    80002946:	e44e                	sd	s3,8(sp)
    80002948:	1800                	addi	s0,sp,48
  initlock(&itable.lock, "itable");
    8000294a:	00006597          	auipc	a1,0x6
    8000294e:	bde58593          	addi	a1,a1,-1058 # 80008528 <syscalls+0x160>
    80002952:	00010517          	auipc	a0,0x10
    80002956:	03650513          	addi	a0,a0,54 # 80012988 <itable>
    8000295a:	00003097          	auipc	ra,0x3
    8000295e:	7be080e7          	jalr	1982(ra) # 80006118 <initlock>
  for (i = 0; i < NINODE; i++)
    80002962:	00010497          	auipc	s1,0x10
    80002966:	04e48493          	addi	s1,s1,78 # 800129b0 <itable+0x28>
    8000296a:	0001e997          	auipc	s3,0x1e
    8000296e:	14698993          	addi	s3,s3,326 # 80020ab0 <log+0x10>
    initsleeplock(&itable.inode[i].lock, "inode");
    80002972:	00006917          	auipc	s2,0x6
    80002976:	bbe90913          	addi	s2,s2,-1090 # 80008530 <syscalls+0x168>
    8000297a:	85ca                	mv	a1,s2
    8000297c:	8526                	mv	a0,s1
    8000297e:	00001097          	auipc	ra,0x1
    80002982:	ed2080e7          	jalr	-302(ra) # 80003850 <initsleeplock>
  for (i = 0; i < NINODE; i++)
    80002986:	48048493          	addi	s1,s1,1152
    8000298a:	ff3498e3          	bne	s1,s3,8000297a <iinit+0x3e>
}
    8000298e:	70a2                	ld	ra,40(sp)
    80002990:	7402                	ld	s0,32(sp)
    80002992:	64e2                	ld	s1,24(sp)
    80002994:	6942                	ld	s2,16(sp)
    80002996:	69a2                	ld	s3,8(sp)
    80002998:	6145                	addi	sp,sp,48
    8000299a:	8082                	ret

000000008000299c <ialloc>:
{
    8000299c:	715d                	addi	sp,sp,-80
    8000299e:	e486                	sd	ra,72(sp)
    800029a0:	e0a2                	sd	s0,64(sp)
    800029a2:	fc26                	sd	s1,56(sp)
    800029a4:	f84a                	sd	s2,48(sp)
    800029a6:	f44e                	sd	s3,40(sp)
    800029a8:	f052                	sd	s4,32(sp)
    800029aa:	ec56                	sd	s5,24(sp)
    800029ac:	e85a                	sd	s6,16(sp)
    800029ae:	e45e                	sd	s7,8(sp)
    800029b0:	0880                	addi	s0,sp,80
  for (inum = 1; inum < sb.ninodes; inum++)
    800029b2:	00010717          	auipc	a4,0x10
    800029b6:	fc272703          	lw	a4,-62(a4) # 80012974 <sb+0xc>
    800029ba:	4785                	li	a5,1
    800029bc:	04e7fa63          	bgeu	a5,a4,80002a10 <ialloc+0x74>
    800029c0:	8aaa                	mv	s5,a0
    800029c2:	8bae                	mv	s7,a1
    800029c4:	4485                	li	s1,1
    bp = bread(dev, IBLOCK(inum, sb));
    800029c6:	00010a17          	auipc	s4,0x10
    800029ca:	fa2a0a13          	addi	s4,s4,-94 # 80012968 <sb>
    800029ce:	00048b1b          	sext.w	s6,s1
    800029d2:	0044d593          	srli	a1,s1,0x4
    800029d6:	018a2783          	lw	a5,24(s4)
    800029da:	9dbd                	addw	a1,a1,a5
    800029dc:	8556                	mv	a0,s5
    800029de:	00000097          	auipc	ra,0x0
    800029e2:	88c080e7          	jalr	-1908(ra) # 8000226a <bread>
    800029e6:	892a                	mv	s2,a0
    dip = (struct dinode *)bp->data + inum % IPB;
    800029e8:	05850993          	addi	s3,a0,88
    800029ec:	00f4f793          	andi	a5,s1,15
    800029f0:	079a                	slli	a5,a5,0x6
    800029f2:	99be                	add	s3,s3,a5
    if (dip->type == 0)
    800029f4:	00099783          	lh	a5,0(s3)
    800029f8:	c785                	beqz	a5,80002a20 <ialloc+0x84>
    brelse(bp);
    800029fa:	00000097          	auipc	ra,0x0
    800029fe:	9a0080e7          	jalr	-1632(ra) # 8000239a <brelse>
  for (inum = 1; inum < sb.ninodes; inum++)
    80002a02:	0485                	addi	s1,s1,1
    80002a04:	00ca2703          	lw	a4,12(s4)
    80002a08:	0004879b          	sext.w	a5,s1
    80002a0c:	fce7e1e3          	bltu	a5,a4,800029ce <ialloc+0x32>
  panic("ialloc: no inodes");
    80002a10:	00006517          	auipc	a0,0x6
    80002a14:	b2850513          	addi	a0,a0,-1240 # 80008538 <syscalls+0x170>
    80002a18:	00003097          	auipc	ra,0x3
    80002a1c:	258080e7          	jalr	600(ra) # 80005c70 <panic>
      memset(dip, 0, sizeof(*dip));
    80002a20:	04000613          	li	a2,64
    80002a24:	4581                	li	a1,0
    80002a26:	854e                	mv	a0,s3
    80002a28:	ffffd097          	auipc	ra,0xffffd
    80002a2c:	752080e7          	jalr	1874(ra) # 8000017a <memset>
      dip->type = type;
    80002a30:	01799023          	sh	s7,0(s3)
      log_write(bp); // mark it allocated on the disk
    80002a34:	854a                	mv	a0,s2
    80002a36:	00001097          	auipc	ra,0x1
    80002a3a:	d36080e7          	jalr	-714(ra) # 8000376c <log_write>
      brelse(bp);
    80002a3e:	854a                	mv	a0,s2
    80002a40:	00000097          	auipc	ra,0x0
    80002a44:	95a080e7          	jalr	-1702(ra) # 8000239a <brelse>
      return iget(dev, inum);
    80002a48:	85da                	mv	a1,s6
    80002a4a:	8556                	mv	a0,s5
    80002a4c:	00000097          	auipc	ra,0x0
    80002a50:	db4080e7          	jalr	-588(ra) # 80002800 <iget>
}
    80002a54:	60a6                	ld	ra,72(sp)
    80002a56:	6406                	ld	s0,64(sp)
    80002a58:	74e2                	ld	s1,56(sp)
    80002a5a:	7942                	ld	s2,48(sp)
    80002a5c:	79a2                	ld	s3,40(sp)
    80002a5e:	7a02                	ld	s4,32(sp)
    80002a60:	6ae2                	ld	s5,24(sp)
    80002a62:	6b42                	ld	s6,16(sp)
    80002a64:	6ba2                	ld	s7,8(sp)
    80002a66:	6161                	addi	sp,sp,80
    80002a68:	8082                	ret

0000000080002a6a <iupdate>:
{
    80002a6a:	1101                	addi	sp,sp,-32
    80002a6c:	ec06                	sd	ra,24(sp)
    80002a6e:	e822                	sd	s0,16(sp)
    80002a70:	e426                	sd	s1,8(sp)
    80002a72:	e04a                	sd	s2,0(sp)
    80002a74:	1000                	addi	s0,sp,32
    80002a76:	84aa                	mv	s1,a0
  bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002a78:	415c                	lw	a5,4(a0)
    80002a7a:	0047d79b          	srliw	a5,a5,0x4
    80002a7e:	00010597          	auipc	a1,0x10
    80002a82:	f025a583          	lw	a1,-254(a1) # 80012980 <sb+0x18>
    80002a86:	9dbd                	addw	a1,a1,a5
    80002a88:	4108                	lw	a0,0(a0)
    80002a8a:	fffff097          	auipc	ra,0xfffff
    80002a8e:	7e0080e7          	jalr	2016(ra) # 8000226a <bread>
    80002a92:	892a                	mv	s2,a0
  dip = (struct dinode *)bp->data + ip->inum % IPB;
    80002a94:	05850793          	addi	a5,a0,88
    80002a98:	40d8                	lw	a4,4(s1)
    80002a9a:	8b3d                	andi	a4,a4,15
    80002a9c:	071a                	slli	a4,a4,0x6
    80002a9e:	97ba                	add	a5,a5,a4
  dip->type = ip->type;
    80002aa0:	04449703          	lh	a4,68(s1)
    80002aa4:	00e79023          	sh	a4,0(a5)
  dip->major = ip->major;
    80002aa8:	04649703          	lh	a4,70(s1)
    80002aac:	00e79123          	sh	a4,2(a5)
  dip->minor = ip->minor;
    80002ab0:	04849703          	lh	a4,72(s1)
    80002ab4:	00e79223          	sh	a4,4(a5)
  dip->nlink = ip->nlink;
    80002ab8:	04a49703          	lh	a4,74(s1)
    80002abc:	00e79323          	sh	a4,6(a5)
  dip->size = ip->size;
    80002ac0:	44f8                	lw	a4,76(s1)
    80002ac2:	c798                	sw	a4,8(a5)
  memmove(dip->addrs, ip->addrs, sizeof(ip->addrs)); // 注意：这个memmove应该修改
    80002ac4:	02c00613          	li	a2,44
    80002ac8:	05048593          	addi	a1,s1,80
    80002acc:	00c78513          	addi	a0,a5,12
    80002ad0:	ffffd097          	auipc	ra,0xffffd
    80002ad4:	706080e7          	jalr	1798(ra) # 800001d6 <memmove>
  log_write(bp);
    80002ad8:	854a                	mv	a0,s2
    80002ada:	00001097          	auipc	ra,0x1
    80002ade:	c92080e7          	jalr	-878(ra) # 8000376c <log_write>
  brelse(bp);
    80002ae2:	854a                	mv	a0,s2
    80002ae4:	00000097          	auipc	ra,0x0
    80002ae8:	8b6080e7          	jalr	-1866(ra) # 8000239a <brelse>
}
    80002aec:	60e2                	ld	ra,24(sp)
    80002aee:	6442                	ld	s0,16(sp)
    80002af0:	64a2                	ld	s1,8(sp)
    80002af2:	6902                	ld	s2,0(sp)
    80002af4:	6105                	addi	sp,sp,32
    80002af6:	8082                	ret

0000000080002af8 <idup>:
{
    80002af8:	1101                	addi	sp,sp,-32
    80002afa:	ec06                	sd	ra,24(sp)
    80002afc:	e822                	sd	s0,16(sp)
    80002afe:	e426                	sd	s1,8(sp)
    80002b00:	1000                	addi	s0,sp,32
    80002b02:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002b04:	00010517          	auipc	a0,0x10
    80002b08:	e8450513          	addi	a0,a0,-380 # 80012988 <itable>
    80002b0c:	00003097          	auipc	ra,0x3
    80002b10:	69c080e7          	jalr	1692(ra) # 800061a8 <acquire>
  ip->ref++;
    80002b14:	449c                	lw	a5,8(s1)
    80002b16:	2785                	addiw	a5,a5,1
    80002b18:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002b1a:	00010517          	auipc	a0,0x10
    80002b1e:	e6e50513          	addi	a0,a0,-402 # 80012988 <itable>
    80002b22:	00003097          	auipc	ra,0x3
    80002b26:	73a080e7          	jalr	1850(ra) # 8000625c <release>
}
    80002b2a:	8526                	mv	a0,s1
    80002b2c:	60e2                	ld	ra,24(sp)
    80002b2e:	6442                	ld	s0,16(sp)
    80002b30:	64a2                	ld	s1,8(sp)
    80002b32:	6105                	addi	sp,sp,32
    80002b34:	8082                	ret

0000000080002b36 <ilock>:
{
    80002b36:	1101                	addi	sp,sp,-32
    80002b38:	ec06                	sd	ra,24(sp)
    80002b3a:	e822                	sd	s0,16(sp)
    80002b3c:	e426                	sd	s1,8(sp)
    80002b3e:	e04a                	sd	s2,0(sp)
    80002b40:	1000                	addi	s0,sp,32
  if (ip == 0 || ip->ref < 1)
    80002b42:	c115                	beqz	a0,80002b66 <ilock+0x30>
    80002b44:	84aa                	mv	s1,a0
    80002b46:	451c                	lw	a5,8(a0)
    80002b48:	00f05f63          	blez	a5,80002b66 <ilock+0x30>
  acquiresleep(&ip->lock);
    80002b4c:	0541                	addi	a0,a0,16
    80002b4e:	00001097          	auipc	ra,0x1
    80002b52:	d3c080e7          	jalr	-708(ra) # 8000388a <acquiresleep>
  if (ip->valid == 0)
    80002b56:	40bc                	lw	a5,64(s1)
    80002b58:	cf99                	beqz	a5,80002b76 <ilock+0x40>
}
    80002b5a:	60e2                	ld	ra,24(sp)
    80002b5c:	6442                	ld	s0,16(sp)
    80002b5e:	64a2                	ld	s1,8(sp)
    80002b60:	6902                	ld	s2,0(sp)
    80002b62:	6105                	addi	sp,sp,32
    80002b64:	8082                	ret
    panic("ilock");
    80002b66:	00006517          	auipc	a0,0x6
    80002b6a:	9ea50513          	addi	a0,a0,-1558 # 80008550 <syscalls+0x188>
    80002b6e:	00003097          	auipc	ra,0x3
    80002b72:	102080e7          	jalr	258(ra) # 80005c70 <panic>
    bp = bread(ip->dev, IBLOCK(ip->inum, sb));
    80002b76:	40dc                	lw	a5,4(s1)
    80002b78:	0047d79b          	srliw	a5,a5,0x4
    80002b7c:	00010597          	auipc	a1,0x10
    80002b80:	e045a583          	lw	a1,-508(a1) # 80012980 <sb+0x18>
    80002b84:	9dbd                	addw	a1,a1,a5
    80002b86:	4088                	lw	a0,0(s1)
    80002b88:	fffff097          	auipc	ra,0xfffff
    80002b8c:	6e2080e7          	jalr	1762(ra) # 8000226a <bread>
    80002b90:	892a                	mv	s2,a0
    dip = (struct dinode *)bp->data + ip->inum % IPB;
    80002b92:	05850593          	addi	a1,a0,88
    80002b96:	40dc                	lw	a5,4(s1)
    80002b98:	8bbd                	andi	a5,a5,15
    80002b9a:	079a                	slli	a5,a5,0x6
    80002b9c:	95be                	add	a1,a1,a5
    ip->type = dip->type;
    80002b9e:	00059783          	lh	a5,0(a1)
    80002ba2:	04f49223          	sh	a5,68(s1)
    ip->major = dip->major;
    80002ba6:	00259783          	lh	a5,2(a1)
    80002baa:	04f49323          	sh	a5,70(s1)
    ip->minor = dip->minor;
    80002bae:	00459783          	lh	a5,4(a1)
    80002bb2:	04f49423          	sh	a5,72(s1)
    ip->nlink = dip->nlink;
    80002bb6:	00659783          	lh	a5,6(a1)
    80002bba:	04f49523          	sh	a5,74(s1)
    ip->size = dip->size;
    80002bbe:	459c                	lw	a5,8(a1)
    80002bc0:	c4fc                	sw	a5,76(s1)
    memmove(ip->addrs, dip->addrs, sizeof(ip->addrs));
    80002bc2:	02c00613          	li	a2,44
    80002bc6:	05b1                	addi	a1,a1,12
    80002bc8:	05048513          	addi	a0,s1,80
    80002bcc:	ffffd097          	auipc	ra,0xffffd
    80002bd0:	60a080e7          	jalr	1546(ra) # 800001d6 <memmove>
    brelse(bp);
    80002bd4:	854a                	mv	a0,s2
    80002bd6:	fffff097          	auipc	ra,0xfffff
    80002bda:	7c4080e7          	jalr	1988(ra) # 8000239a <brelse>
    ip->valid = 1;
    80002bde:	4785                	li	a5,1
    80002be0:	c0bc                	sw	a5,64(s1)
    if (ip->type == 0)
    80002be2:	04449783          	lh	a5,68(s1)
    80002be6:	fbb5                	bnez	a5,80002b5a <ilock+0x24>
      panic("ilock: no type");
    80002be8:	00006517          	auipc	a0,0x6
    80002bec:	97050513          	addi	a0,a0,-1680 # 80008558 <syscalls+0x190>
    80002bf0:	00003097          	auipc	ra,0x3
    80002bf4:	080080e7          	jalr	128(ra) # 80005c70 <panic>

0000000080002bf8 <iunlock>:
{
    80002bf8:	1101                	addi	sp,sp,-32
    80002bfa:	ec06                	sd	ra,24(sp)
    80002bfc:	e822                	sd	s0,16(sp)
    80002bfe:	e426                	sd	s1,8(sp)
    80002c00:	e04a                	sd	s2,0(sp)
    80002c02:	1000                	addi	s0,sp,32
  if (ip == 0 || !holdingsleep(&ip->lock) || ip->ref < 1)
    80002c04:	c905                	beqz	a0,80002c34 <iunlock+0x3c>
    80002c06:	84aa                	mv	s1,a0
    80002c08:	01050913          	addi	s2,a0,16
    80002c0c:	854a                	mv	a0,s2
    80002c0e:	00001097          	auipc	ra,0x1
    80002c12:	d16080e7          	jalr	-746(ra) # 80003924 <holdingsleep>
    80002c16:	cd19                	beqz	a0,80002c34 <iunlock+0x3c>
    80002c18:	449c                	lw	a5,8(s1)
    80002c1a:	00f05d63          	blez	a5,80002c34 <iunlock+0x3c>
  releasesleep(&ip->lock);
    80002c1e:	854a                	mv	a0,s2
    80002c20:	00001097          	auipc	ra,0x1
    80002c24:	cc0080e7          	jalr	-832(ra) # 800038e0 <releasesleep>
}
    80002c28:	60e2                	ld	ra,24(sp)
    80002c2a:	6442                	ld	s0,16(sp)
    80002c2c:	64a2                	ld	s1,8(sp)
    80002c2e:	6902                	ld	s2,0(sp)
    80002c30:	6105                	addi	sp,sp,32
    80002c32:	8082                	ret
    panic("iunlock");
    80002c34:	00006517          	auipc	a0,0x6
    80002c38:	93450513          	addi	a0,a0,-1740 # 80008568 <syscalls+0x1a0>
    80002c3c:	00003097          	auipc	ra,0x3
    80002c40:	034080e7          	jalr	52(ra) # 80005c70 <panic>

0000000080002c44 <itrunc>:
// Truncate inode (discard contents).
// Caller must hold ip->lock.
void itrunc(struct inode *ip)
{
    80002c44:	715d                	addi	sp,sp,-80
    80002c46:	e486                	sd	ra,72(sp)
    80002c48:	e0a2                	sd	s0,64(sp)
    80002c4a:	fc26                	sd	s1,56(sp)
    80002c4c:	f84a                	sd	s2,48(sp)
    80002c4e:	f44e                	sd	s3,40(sp)
    80002c50:	f052                	sd	s4,32(sp)
    80002c52:	ec56                	sd	s5,24(sp)
    80002c54:	e85a                	sd	s6,16(sp)
    80002c56:	e45e                	sd	s7,8(sp)
    80002c58:	0880                	addi	s0,sp,80
    80002c5a:	89aa                	mv	s3,a0
  int i, j;
  struct buf *bp;
  uint *a;

  for (i = 0; i < NDIRECT - 1; i++)
    80002c5c:	05050a13          	addi	s4,a0,80
    80002c60:	07c50b13          	addi	s6,a0,124
    80002c64:	a83d                	j	80002ca2 <itrunc+0x5e>
  {
    if (ip->addrs[i])
    {
      bp = bread(ip->dev, ip->addrs[i]);
      a = (uint *)bp->data;
      for (j = 0; j < NINDIRECT; j++)
    80002c66:	0491                	addi	s1,s1,4
    80002c68:	01248b63          	beq	s1,s2,80002c7e <itrunc+0x3a>
        if (a[j])
    80002c6c:	408c                	lw	a1,0(s1)
    80002c6e:	dde5                	beqz	a1,80002c66 <itrunc+0x22>
          bfree(ip->dev, a[j]);
    80002c70:	0009a503          	lw	a0,0(s3)
    80002c74:	00000097          	auipc	ra,0x0
    80002c78:	83c080e7          	jalr	-1988(ra) # 800024b0 <bfree>
    80002c7c:	b7ed                	j	80002c66 <itrunc+0x22>
      brelse(bp);
    80002c7e:	855e                	mv	a0,s7
    80002c80:	fffff097          	auipc	ra,0xfffff
    80002c84:	71a080e7          	jalr	1818(ra) # 8000239a <brelse>
      bfree(ip->dev, ip->addrs[i]);
    80002c88:	000aa583          	lw	a1,0(s5)
    80002c8c:	0009a503          	lw	a0,0(s3)
    80002c90:	00000097          	auipc	ra,0x0
    80002c94:	820080e7          	jalr	-2016(ra) # 800024b0 <bfree>
      ip->addrs[i] = 0;
    80002c98:	000aa023          	sw	zero,0(s5)
  for (i = 0; i < NDIRECT - 1; i++)
    80002c9c:	0a11                	addi	s4,s4,4
    80002c9e:	036a0263          	beq	s4,s6,80002cc2 <itrunc+0x7e>
    if (ip->addrs[i])
    80002ca2:	8ad2                	mv	s5,s4
    80002ca4:	000a2583          	lw	a1,0(s4)
    80002ca8:	d9f5                	beqz	a1,80002c9c <itrunc+0x58>
      bp = bread(ip->dev, ip->addrs[i]);
    80002caa:	0009a503          	lw	a0,0(s3)
    80002cae:	fffff097          	auipc	ra,0xfffff
    80002cb2:	5bc080e7          	jalr	1468(ra) # 8000226a <bread>
    80002cb6:	8baa                	mv	s7,a0
      for (j = 0; j < NINDIRECT; j++)
    80002cb8:	05850493          	addi	s1,a0,88
    80002cbc:	45850913          	addi	s2,a0,1112
    80002cc0:	b775                	j	80002c6c <itrunc+0x28>
    }
  }

  if (ip->addrs[NDIRECT - 1])
    80002cc2:	07c9a583          	lw	a1,124(s3)
    80002cc6:	e19d                	bnez	a1,80002cec <itrunc+0xa8>
    brelse(bp);
    bfree(ip->dev, ip->addrs[NDIRECT - 1]);
    ip->addrs[NDIRECT - 1] = 0;
  }

  ip->size = 0;
    80002cc8:	0409a623          	sw	zero,76(s3)
  iupdate(ip);
    80002ccc:	854e                	mv	a0,s3
    80002cce:	00000097          	auipc	ra,0x0
    80002cd2:	d9c080e7          	jalr	-612(ra) # 80002a6a <iupdate>
}
    80002cd6:	60a6                	ld	ra,72(sp)
    80002cd8:	6406                	ld	s0,64(sp)
    80002cda:	74e2                	ld	s1,56(sp)
    80002cdc:	7942                	ld	s2,48(sp)
    80002cde:	79a2                	ld	s3,40(sp)
    80002ce0:	7a02                	ld	s4,32(sp)
    80002ce2:	6ae2                	ld	s5,24(sp)
    80002ce4:	6b42                	ld	s6,16(sp)
    80002ce6:	6ba2                	ld	s7,8(sp)
    80002ce8:	6161                	addi	sp,sp,80
    80002cea:	8082                	ret
    bp = bread(ip->dev, ip->addrs[NDIRECT - 1]);
    80002cec:	0009a503          	lw	a0,0(s3)
    80002cf0:	fffff097          	auipc	ra,0xfffff
    80002cf4:	57a080e7          	jalr	1402(ra) # 8000226a <bread>
    80002cf8:	8a2a                	mv	s4,a0
    for (j = 0; j < NINDIRECT; j++)
    80002cfa:	05850493          	addi	s1,a0,88
    80002cfe:	45850913          	addi	s2,a0,1112
    80002d02:	a021                	j	80002d0a <itrunc+0xc6>
    80002d04:	0491                	addi	s1,s1,4
    80002d06:	01248b63          	beq	s1,s2,80002d1c <itrunc+0xd8>
      if (a[j])
    80002d0a:	408c                	lw	a1,0(s1)
    80002d0c:	dde5                	beqz	a1,80002d04 <itrunc+0xc0>
        bfree(ip->dev, a[j]);
    80002d0e:	0009a503          	lw	a0,0(s3)
    80002d12:	fffff097          	auipc	ra,0xfffff
    80002d16:	79e080e7          	jalr	1950(ra) # 800024b0 <bfree>
    80002d1a:	b7ed                	j	80002d04 <itrunc+0xc0>
    brelse(bp);
    80002d1c:	8552                	mv	a0,s4
    80002d1e:	fffff097          	auipc	ra,0xfffff
    80002d22:	67c080e7          	jalr	1660(ra) # 8000239a <brelse>
    bfree(ip->dev, ip->addrs[NDIRECT - 1]);
    80002d26:	07c9a583          	lw	a1,124(s3)
    80002d2a:	0009a503          	lw	a0,0(s3)
    80002d2e:	fffff097          	auipc	ra,0xfffff
    80002d32:	782080e7          	jalr	1922(ra) # 800024b0 <bfree>
    ip->addrs[NDIRECT - 1] = 0;
    80002d36:	0609ae23          	sw	zero,124(s3)
    80002d3a:	b779                	j	80002cc8 <itrunc+0x84>

0000000080002d3c <iput>:
{
    80002d3c:	1101                	addi	sp,sp,-32
    80002d3e:	ec06                	sd	ra,24(sp)
    80002d40:	e822                	sd	s0,16(sp)
    80002d42:	e426                	sd	s1,8(sp)
    80002d44:	e04a                	sd	s2,0(sp)
    80002d46:	1000                	addi	s0,sp,32
    80002d48:	84aa                	mv	s1,a0
  acquire(&itable.lock);
    80002d4a:	00010517          	auipc	a0,0x10
    80002d4e:	c3e50513          	addi	a0,a0,-962 # 80012988 <itable>
    80002d52:	00003097          	auipc	ra,0x3
    80002d56:	456080e7          	jalr	1110(ra) # 800061a8 <acquire>
  if (ip->ref == 1 && ip->valid && ip->nlink == 0)
    80002d5a:	4498                	lw	a4,8(s1)
    80002d5c:	4785                	li	a5,1
    80002d5e:	02f70363          	beq	a4,a5,80002d84 <iput+0x48>
  ip->ref--;
    80002d62:	449c                	lw	a5,8(s1)
    80002d64:	37fd                	addiw	a5,a5,-1
    80002d66:	c49c                	sw	a5,8(s1)
  release(&itable.lock);
    80002d68:	00010517          	auipc	a0,0x10
    80002d6c:	c2050513          	addi	a0,a0,-992 # 80012988 <itable>
    80002d70:	00003097          	auipc	ra,0x3
    80002d74:	4ec080e7          	jalr	1260(ra) # 8000625c <release>
}
    80002d78:	60e2                	ld	ra,24(sp)
    80002d7a:	6442                	ld	s0,16(sp)
    80002d7c:	64a2                	ld	s1,8(sp)
    80002d7e:	6902                	ld	s2,0(sp)
    80002d80:	6105                	addi	sp,sp,32
    80002d82:	8082                	ret
  if (ip->ref == 1 && ip->valid && ip->nlink == 0)
    80002d84:	40bc                	lw	a5,64(s1)
    80002d86:	dff1                	beqz	a5,80002d62 <iput+0x26>
    80002d88:	04a49783          	lh	a5,74(s1)
    80002d8c:	fbf9                	bnez	a5,80002d62 <iput+0x26>
    acquiresleep(&ip->lock);
    80002d8e:	01048913          	addi	s2,s1,16
    80002d92:	854a                	mv	a0,s2
    80002d94:	00001097          	auipc	ra,0x1
    80002d98:	af6080e7          	jalr	-1290(ra) # 8000388a <acquiresleep>
    release(&itable.lock);
    80002d9c:	00010517          	auipc	a0,0x10
    80002da0:	bec50513          	addi	a0,a0,-1044 # 80012988 <itable>
    80002da4:	00003097          	auipc	ra,0x3
    80002da8:	4b8080e7          	jalr	1208(ra) # 8000625c <release>
    itrunc(ip);
    80002dac:	8526                	mv	a0,s1
    80002dae:	00000097          	auipc	ra,0x0
    80002db2:	e96080e7          	jalr	-362(ra) # 80002c44 <itrunc>
    ip->type = 0;
    80002db6:	04049223          	sh	zero,68(s1)
    iupdate(ip);
    80002dba:	8526                	mv	a0,s1
    80002dbc:	00000097          	auipc	ra,0x0
    80002dc0:	cae080e7          	jalr	-850(ra) # 80002a6a <iupdate>
    ip->valid = 0;
    80002dc4:	0404a023          	sw	zero,64(s1)
    releasesleep(&ip->lock);
    80002dc8:	854a                	mv	a0,s2
    80002dca:	00001097          	auipc	ra,0x1
    80002dce:	b16080e7          	jalr	-1258(ra) # 800038e0 <releasesleep>
    acquire(&itable.lock);
    80002dd2:	00010517          	auipc	a0,0x10
    80002dd6:	bb650513          	addi	a0,a0,-1098 # 80012988 <itable>
    80002dda:	00003097          	auipc	ra,0x3
    80002dde:	3ce080e7          	jalr	974(ra) # 800061a8 <acquire>
    80002de2:	b741                	j	80002d62 <iput+0x26>

0000000080002de4 <iunlockput>:
{
    80002de4:	1101                	addi	sp,sp,-32
    80002de6:	ec06                	sd	ra,24(sp)
    80002de8:	e822                	sd	s0,16(sp)
    80002dea:	e426                	sd	s1,8(sp)
    80002dec:	1000                	addi	s0,sp,32
    80002dee:	84aa                	mv	s1,a0
  iunlock(ip);
    80002df0:	00000097          	auipc	ra,0x0
    80002df4:	e08080e7          	jalr	-504(ra) # 80002bf8 <iunlock>
  iput(ip);
    80002df8:	8526                	mv	a0,s1
    80002dfa:	00000097          	auipc	ra,0x0
    80002dfe:	f42080e7          	jalr	-190(ra) # 80002d3c <iput>
}
    80002e02:	60e2                	ld	ra,24(sp)
    80002e04:	6442                	ld	s0,16(sp)
    80002e06:	64a2                	ld	s1,8(sp)
    80002e08:	6105                	addi	sp,sp,32
    80002e0a:	8082                	ret

0000000080002e0c <stati>:
// Copy stat information from inode.
// Caller must hold ip->lock.
void stati(struct inode *ip, struct stat *st)
{
    80002e0c:	1141                	addi	sp,sp,-16
    80002e0e:	e422                	sd	s0,8(sp)
    80002e10:	0800                	addi	s0,sp,16
  st->dev = ip->dev;
    80002e12:	411c                	lw	a5,0(a0)
    80002e14:	c19c                	sw	a5,0(a1)
  st->ino = ip->inum;
    80002e16:	415c                	lw	a5,4(a0)
    80002e18:	c1dc                	sw	a5,4(a1)
  st->type = ip->type;
    80002e1a:	04451783          	lh	a5,68(a0)
    80002e1e:	00f59423          	sh	a5,8(a1)
  st->nlink = ip->nlink;
    80002e22:	04a51783          	lh	a5,74(a0)
    80002e26:	00f59523          	sh	a5,10(a1)
  st->size = ip->size;
    80002e2a:	04c56783          	lwu	a5,76(a0)
    80002e2e:	e99c                	sd	a5,16(a1)
}
    80002e30:	6422                	ld	s0,8(sp)
    80002e32:	0141                	addi	sp,sp,16
    80002e34:	8082                	ret

0000000080002e36 <readi>:
int readi(struct inode *ip, int user_dst, uint64 dst, uint off, uint n)
{
  uint tot, m;
  struct buf *bp;

  if (off > ip->size || off + n < off)
    80002e36:	457c                	lw	a5,76(a0)
    80002e38:	0ed7e963          	bltu	a5,a3,80002f2a <readi+0xf4>
{
    80002e3c:	7159                	addi	sp,sp,-112
    80002e3e:	f486                	sd	ra,104(sp)
    80002e40:	f0a2                	sd	s0,96(sp)
    80002e42:	eca6                	sd	s1,88(sp)
    80002e44:	e8ca                	sd	s2,80(sp)
    80002e46:	e4ce                	sd	s3,72(sp)
    80002e48:	e0d2                	sd	s4,64(sp)
    80002e4a:	fc56                	sd	s5,56(sp)
    80002e4c:	f85a                	sd	s6,48(sp)
    80002e4e:	f45e                	sd	s7,40(sp)
    80002e50:	f062                	sd	s8,32(sp)
    80002e52:	ec66                	sd	s9,24(sp)
    80002e54:	e86a                	sd	s10,16(sp)
    80002e56:	e46e                	sd	s11,8(sp)
    80002e58:	1880                	addi	s0,sp,112
    80002e5a:	8baa                	mv	s7,a0
    80002e5c:	8c2e                	mv	s8,a1
    80002e5e:	8ab2                	mv	s5,a2
    80002e60:	84b6                	mv	s1,a3
    80002e62:	8b3a                	mv	s6,a4
  if (off > ip->size || off + n < off)
    80002e64:	9f35                	addw	a4,a4,a3
    return 0;
    80002e66:	4501                	li	a0,0
  if (off > ip->size || off + n < off)
    80002e68:	0ad76063          	bltu	a4,a3,80002f08 <readi+0xd2>
  if (off + n > ip->size)
    80002e6c:	00e7f463          	bgeu	a5,a4,80002e74 <readi+0x3e>
    n = ip->size - off;
    80002e70:	40d78b3b          	subw	s6,a5,a3

  for (tot = 0; tot < n; tot += m, off += m, dst += m)
    80002e74:	0a0b0963          	beqz	s6,80002f26 <readi+0xf0>
    80002e78:	4981                	li	s3,0
  {
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
    m = min(n - tot, BSIZE - off % BSIZE);
    80002e7a:	40000d13          	li	s10,1024
    if (either_copyout(user_dst, dst, bp->data + (off % BSIZE), m) == -1)
    80002e7e:	5cfd                	li	s9,-1
    80002e80:	a82d                	j	80002eba <readi+0x84>
    80002e82:	020a1d93          	slli	s11,s4,0x20
    80002e86:	020ddd93          	srli	s11,s11,0x20
    80002e8a:	05890613          	addi	a2,s2,88
    80002e8e:	86ee                	mv	a3,s11
    80002e90:	963a                	add	a2,a2,a4
    80002e92:	85d6                	mv	a1,s5
    80002e94:	8562                	mv	a0,s8
    80002e96:	fffff097          	auipc	ra,0xfffff
    80002e9a:	a16080e7          	jalr	-1514(ra) # 800018ac <either_copyout>
    80002e9e:	05950d63          	beq	a0,s9,80002ef8 <readi+0xc2>
    {
      brelse(bp);
      tot = -1;
      break;
    }
    brelse(bp);
    80002ea2:	854a                	mv	a0,s2
    80002ea4:	fffff097          	auipc	ra,0xfffff
    80002ea8:	4f6080e7          	jalr	1270(ra) # 8000239a <brelse>
  for (tot = 0; tot < n; tot += m, off += m, dst += m)
    80002eac:	013a09bb          	addw	s3,s4,s3
    80002eb0:	009a04bb          	addw	s1,s4,s1
    80002eb4:	9aee                	add	s5,s5,s11
    80002eb6:	0569f763          	bgeu	s3,s6,80002f04 <readi+0xce>
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
    80002eba:	000ba903          	lw	s2,0(s7)
    80002ebe:	00a4d59b          	srliw	a1,s1,0xa
    80002ec2:	855e                	mv	a0,s7
    80002ec4:	fffff097          	auipc	ra,0xfffff
    80002ec8:	796080e7          	jalr	1942(ra) # 8000265a <bmap>
    80002ecc:	0005059b          	sext.w	a1,a0
    80002ed0:	854a                	mv	a0,s2
    80002ed2:	fffff097          	auipc	ra,0xfffff
    80002ed6:	398080e7          	jalr	920(ra) # 8000226a <bread>
    80002eda:	892a                	mv	s2,a0
    m = min(n - tot, BSIZE - off % BSIZE);
    80002edc:	3ff4f713          	andi	a4,s1,1023
    80002ee0:	40ed07bb          	subw	a5,s10,a4
    80002ee4:	413b06bb          	subw	a3,s6,s3
    80002ee8:	8a3e                	mv	s4,a5
    80002eea:	2781                	sext.w	a5,a5
    80002eec:	0006861b          	sext.w	a2,a3
    80002ef0:	f8f679e3          	bgeu	a2,a5,80002e82 <readi+0x4c>
    80002ef4:	8a36                	mv	s4,a3
    80002ef6:	b771                	j	80002e82 <readi+0x4c>
      brelse(bp);
    80002ef8:	854a                	mv	a0,s2
    80002efa:	fffff097          	auipc	ra,0xfffff
    80002efe:	4a0080e7          	jalr	1184(ra) # 8000239a <brelse>
      tot = -1;
    80002f02:	59fd                	li	s3,-1
  }
  return tot;
    80002f04:	0009851b          	sext.w	a0,s3
}
    80002f08:	70a6                	ld	ra,104(sp)
    80002f0a:	7406                	ld	s0,96(sp)
    80002f0c:	64e6                	ld	s1,88(sp)
    80002f0e:	6946                	ld	s2,80(sp)
    80002f10:	69a6                	ld	s3,72(sp)
    80002f12:	6a06                	ld	s4,64(sp)
    80002f14:	7ae2                	ld	s5,56(sp)
    80002f16:	7b42                	ld	s6,48(sp)
    80002f18:	7ba2                	ld	s7,40(sp)
    80002f1a:	7c02                	ld	s8,32(sp)
    80002f1c:	6ce2                	ld	s9,24(sp)
    80002f1e:	6d42                	ld	s10,16(sp)
    80002f20:	6da2                	ld	s11,8(sp)
    80002f22:	6165                	addi	sp,sp,112
    80002f24:	8082                	ret
  for (tot = 0; tot < n; tot += m, off += m, dst += m)
    80002f26:	89da                	mv	s3,s6
    80002f28:	bff1                	j	80002f04 <readi+0xce>
    return 0;
    80002f2a:	4501                	li	a0,0
}
    80002f2c:	8082                	ret

0000000080002f2e <writei>:
// otherwise, src is a kernel address.
// Returns the number of bytes successfully written.
// If the return value is less than the requested n,
// there was an error of some kind.
int writei(struct inode *ip, int user_src, uint64 src, uint off, uint n)
{
    80002f2e:	7159                	addi	sp,sp,-112
    80002f30:	f486                	sd	ra,104(sp)
    80002f32:	f0a2                	sd	s0,96(sp)
    80002f34:	eca6                	sd	s1,88(sp)
    80002f36:	e8ca                	sd	s2,80(sp)
    80002f38:	e4ce                	sd	s3,72(sp)
    80002f3a:	e0d2                	sd	s4,64(sp)
    80002f3c:	fc56                	sd	s5,56(sp)
    80002f3e:	f85a                	sd	s6,48(sp)
    80002f40:	f45e                	sd	s7,40(sp)
    80002f42:	f062                	sd	s8,32(sp)
    80002f44:	ec66                	sd	s9,24(sp)
    80002f46:	e86a                	sd	s10,16(sp)
    80002f48:	e46e                	sd	s11,8(sp)
    80002f4a:	1880                	addi	s0,sp,112
  uint tot, m;
  struct buf *bp;

  if (off > ip->size || off + n < off) {
    80002f4c:	457c                	lw	a5,76(a0)
    80002f4e:	02d7e863          	bltu	a5,a3,80002f7e <writei+0x50>
    80002f52:	8b2a                	mv	s6,a0
    80002f54:	8c2e                	mv	s8,a1
    80002f56:	8ab2                	mv	s5,a2
    80002f58:	8936                	mv	s2,a3
    80002f5a:	8bba                	mv	s7,a4
    80002f5c:	9f35                	addw	a4,a4,a3
    80002f5e:	02d76063          	bltu	a4,a3,80002f7e <writei+0x50>
    printf("writei: Invalid offset or size\n");
    return -1;
  }
  if (off + n > MAXFILE * BSIZE) {
    80002f62:	040437b7          	lui	a5,0x4043
    80002f66:	c0078793          	addi	a5,a5,-1024 # 4042c00 <_entry-0x7bfbd400>
    80002f6a:	02e7e463          	bltu	a5,a4,80002f92 <writei+0x64>
    printf("writei: Exceeded maximum file size at offset %d, requested %d bytes, max is %d bytes\n", off, n, MAXFILE * BSIZE);
    return -1;
  }

  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002f6e:	4a01                	li	s4,0
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
    m = min(n - tot, BSIZE - off % BSIZE);
    80002f70:	40000d13          	li	s10,1024
    if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002f74:	5cfd                	li	s9,-1
  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002f76:	060b9f63          	bnez	s7,80002ff4 <writei+0xc6>
    80002f7a:	8a5e                	mv	s4,s7
    80002f7c:	a8f1                	j	80003058 <writei+0x12a>
    printf("writei: Invalid offset or size\n");
    80002f7e:	00005517          	auipc	a0,0x5
    80002f82:	5f250513          	addi	a0,a0,1522 # 80008570 <syscalls+0x1a8>
    80002f86:	00003097          	auipc	ra,0x3
    80002f8a:	d34080e7          	jalr	-716(ra) # 80005cba <printf>
    return -1;
    80002f8e:	557d                	li	a0,-1
    80002f90:	a8d9                	j	80003066 <writei+0x138>
    printf("writei: Exceeded maximum file size at offset %d, requested %d bytes, max is %d bytes\n", off, n, MAXFILE * BSIZE);
    80002f92:	040436b7          	lui	a3,0x4043
    80002f96:	c0068693          	addi	a3,a3,-1024 # 4042c00 <_entry-0x7bfbd400>
    80002f9a:	865e                	mv	a2,s7
    80002f9c:	85ca                	mv	a1,s2
    80002f9e:	00005517          	auipc	a0,0x5
    80002fa2:	5f250513          	addi	a0,a0,1522 # 80008590 <syscalls+0x1c8>
    80002fa6:	00003097          	auipc	ra,0x3
    80002faa:	d14080e7          	jalr	-748(ra) # 80005cba <printf>
    return -1;
    80002fae:	557d                	li	a0,-1
    80002fb0:	a85d                	j	80003066 <writei+0x138>
    if (either_copyin(bp->data + (off % BSIZE), user_src, src, m) == -1) {
    80002fb2:	02099d93          	slli	s11,s3,0x20
    80002fb6:	020ddd93          	srli	s11,s11,0x20
    80002fba:	05848513          	addi	a0,s1,88
    80002fbe:	86ee                	mv	a3,s11
    80002fc0:	8656                	mv	a2,s5
    80002fc2:	85e2                	mv	a1,s8
    80002fc4:	953a                	add	a0,a0,a4
    80002fc6:	fffff097          	auipc	ra,0xfffff
    80002fca:	93c080e7          	jalr	-1732(ra) # 80001902 <either_copyin>
    80002fce:	07950263          	beq	a0,s9,80003032 <writei+0x104>
      printf("writei: Copyin failed\n");
      brelse(bp);
      break;
    }
    log_write(bp);
    80002fd2:	8526                	mv	a0,s1
    80002fd4:	00000097          	auipc	ra,0x0
    80002fd8:	798080e7          	jalr	1944(ra) # 8000376c <log_write>
    brelse(bp);
    80002fdc:	8526                	mv	a0,s1
    80002fde:	fffff097          	auipc	ra,0xfffff
    80002fe2:	3bc080e7          	jalr	956(ra) # 8000239a <brelse>
  for (tot = 0; tot < n; tot += m, off += m, src += m) {
    80002fe6:	01498a3b          	addw	s4,s3,s4
    80002fea:	0129893b          	addw	s2,s3,s2
    80002fee:	9aee                	add	s5,s5,s11
    80002ff0:	057a7e63          	bgeu	s4,s7,8000304c <writei+0x11e>
    bp = bread(ip->dev, bmap(ip, off / BSIZE));
    80002ff4:	000b2483          	lw	s1,0(s6)
    80002ff8:	00a9559b          	srliw	a1,s2,0xa
    80002ffc:	855a                	mv	a0,s6
    80002ffe:	fffff097          	auipc	ra,0xfffff
    80003002:	65c080e7          	jalr	1628(ra) # 8000265a <bmap>
    80003006:	0005059b          	sext.w	a1,a0
    8000300a:	8526                	mv	a0,s1
    8000300c:	fffff097          	auipc	ra,0xfffff
    80003010:	25e080e7          	jalr	606(ra) # 8000226a <bread>
    80003014:	84aa                	mv	s1,a0
    m = min(n - tot, BSIZE - off % BSIZE);
    80003016:	3ff97713          	andi	a4,s2,1023
    8000301a:	40ed07bb          	subw	a5,s10,a4
    8000301e:	414b86bb          	subw	a3,s7,s4
    80003022:	89be                	mv	s3,a5
    80003024:	2781                	sext.w	a5,a5
    80003026:	0006861b          	sext.w	a2,a3
    8000302a:	f8f674e3          	bgeu	a2,a5,80002fb2 <writei+0x84>
    8000302e:	89b6                	mv	s3,a3
    80003030:	b749                	j	80002fb2 <writei+0x84>
      printf("writei: Copyin failed\n");
    80003032:	00005517          	auipc	a0,0x5
    80003036:	5b650513          	addi	a0,a0,1462 # 800085e8 <syscalls+0x220>
    8000303a:	00003097          	auipc	ra,0x3
    8000303e:	c80080e7          	jalr	-896(ra) # 80005cba <printf>
      brelse(bp);
    80003042:	8526                	mv	a0,s1
    80003044:	fffff097          	auipc	ra,0xfffff
    80003048:	356080e7          	jalr	854(ra) # 8000239a <brelse>
  }

  if (off > ip->size)
    8000304c:	04cb2783          	lw	a5,76(s6)
    80003050:	0127f463          	bgeu	a5,s2,80003058 <writei+0x12a>
    ip->size = off;
    80003054:	052b2623          	sw	s2,76(s6)

  iupdate(ip);
    80003058:	855a                	mv	a0,s6
    8000305a:	00000097          	auipc	ra,0x0
    8000305e:	a10080e7          	jalr	-1520(ra) # 80002a6a <iupdate>

  return tot;
    80003062:	000a051b          	sext.w	a0,s4
}
    80003066:	70a6                	ld	ra,104(sp)
    80003068:	7406                	ld	s0,96(sp)
    8000306a:	64e6                	ld	s1,88(sp)
    8000306c:	6946                	ld	s2,80(sp)
    8000306e:	69a6                	ld	s3,72(sp)
    80003070:	6a06                	ld	s4,64(sp)
    80003072:	7ae2                	ld	s5,56(sp)
    80003074:	7b42                	ld	s6,48(sp)
    80003076:	7ba2                	ld	s7,40(sp)
    80003078:	7c02                	ld	s8,32(sp)
    8000307a:	6ce2                	ld	s9,24(sp)
    8000307c:	6d42                	ld	s10,16(sp)
    8000307e:	6da2                	ld	s11,8(sp)
    80003080:	6165                	addi	sp,sp,112
    80003082:	8082                	ret

0000000080003084 <namecmp>:

// Directories

int namecmp(const char *s, const char *t)
{
    80003084:	1141                	addi	sp,sp,-16
    80003086:	e406                	sd	ra,8(sp)
    80003088:	e022                	sd	s0,0(sp)
    8000308a:	0800                	addi	s0,sp,16
  return strncmp(s, t, DIRSIZ);
    8000308c:	4639                	li	a2,14
    8000308e:	ffffd097          	auipc	ra,0xffffd
    80003092:	1bc080e7          	jalr	444(ra) # 8000024a <strncmp>
}
    80003096:	60a2                	ld	ra,8(sp)
    80003098:	6402                	ld	s0,0(sp)
    8000309a:	0141                	addi	sp,sp,16
    8000309c:	8082                	ret

000000008000309e <dirlookup>:

// Look for a directory entry in a directory.
// If found, set *poff to byte offset of entry.
struct inode *
dirlookup(struct inode *dp, char *name, uint *poff)
{
    8000309e:	7139                	addi	sp,sp,-64
    800030a0:	fc06                	sd	ra,56(sp)
    800030a2:	f822                	sd	s0,48(sp)
    800030a4:	f426                	sd	s1,40(sp)
    800030a6:	f04a                	sd	s2,32(sp)
    800030a8:	ec4e                	sd	s3,24(sp)
    800030aa:	e852                	sd	s4,16(sp)
    800030ac:	0080                	addi	s0,sp,64
  uint off, inum;
  struct dirent de;

  if (dp->type != T_DIR)
    800030ae:	04451703          	lh	a4,68(a0)
    800030b2:	4785                	li	a5,1
    800030b4:	00f71a63          	bne	a4,a5,800030c8 <dirlookup+0x2a>
    800030b8:	892a                	mv	s2,a0
    800030ba:	89ae                	mv	s3,a1
    800030bc:	8a32                	mv	s4,a2
    panic("dirlookup not DIR");

  for (off = 0; off < dp->size; off += sizeof(de))
    800030be:	457c                	lw	a5,76(a0)
    800030c0:	4481                	li	s1,0
      inum = de.inum;
      return iget(dp->dev, inum);
    }
  }

  return 0;
    800030c2:	4501                	li	a0,0
  for (off = 0; off < dp->size; off += sizeof(de))
    800030c4:	e79d                	bnez	a5,800030f2 <dirlookup+0x54>
    800030c6:	a8a5                	j	8000313e <dirlookup+0xa0>
    panic("dirlookup not DIR");
    800030c8:	00005517          	auipc	a0,0x5
    800030cc:	53850513          	addi	a0,a0,1336 # 80008600 <syscalls+0x238>
    800030d0:	00003097          	auipc	ra,0x3
    800030d4:	ba0080e7          	jalr	-1120(ra) # 80005c70 <panic>
      panic("dirlookup read");
    800030d8:	00005517          	auipc	a0,0x5
    800030dc:	54050513          	addi	a0,a0,1344 # 80008618 <syscalls+0x250>
    800030e0:	00003097          	auipc	ra,0x3
    800030e4:	b90080e7          	jalr	-1136(ra) # 80005c70 <panic>
  for (off = 0; off < dp->size; off += sizeof(de))
    800030e8:	24c1                	addiw	s1,s1,16
    800030ea:	04c92783          	lw	a5,76(s2)
    800030ee:	04f4f763          	bgeu	s1,a5,8000313c <dirlookup+0x9e>
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800030f2:	4741                	li	a4,16
    800030f4:	86a6                	mv	a3,s1
    800030f6:	fc040613          	addi	a2,s0,-64
    800030fa:	4581                	li	a1,0
    800030fc:	854a                	mv	a0,s2
    800030fe:	00000097          	auipc	ra,0x0
    80003102:	d38080e7          	jalr	-712(ra) # 80002e36 <readi>
    80003106:	47c1                	li	a5,16
    80003108:	fcf518e3          	bne	a0,a5,800030d8 <dirlookup+0x3a>
    if (de.inum == 0)
    8000310c:	fc045783          	lhu	a5,-64(s0)
    80003110:	dfe1                	beqz	a5,800030e8 <dirlookup+0x4a>
    if (namecmp(name, de.name) == 0)
    80003112:	fc240593          	addi	a1,s0,-62
    80003116:	854e                	mv	a0,s3
    80003118:	00000097          	auipc	ra,0x0
    8000311c:	f6c080e7          	jalr	-148(ra) # 80003084 <namecmp>
    80003120:	f561                	bnez	a0,800030e8 <dirlookup+0x4a>
      if (poff)
    80003122:	000a0463          	beqz	s4,8000312a <dirlookup+0x8c>
        *poff = off;
    80003126:	009a2023          	sw	s1,0(s4)
      return iget(dp->dev, inum);
    8000312a:	fc045583          	lhu	a1,-64(s0)
    8000312e:	00092503          	lw	a0,0(s2)
    80003132:	fffff097          	auipc	ra,0xfffff
    80003136:	6ce080e7          	jalr	1742(ra) # 80002800 <iget>
    8000313a:	a011                	j	8000313e <dirlookup+0xa0>
  return 0;
    8000313c:	4501                	li	a0,0
}
    8000313e:	70e2                	ld	ra,56(sp)
    80003140:	7442                	ld	s0,48(sp)
    80003142:	74a2                	ld	s1,40(sp)
    80003144:	7902                	ld	s2,32(sp)
    80003146:	69e2                	ld	s3,24(sp)
    80003148:	6a42                	ld	s4,16(sp)
    8000314a:	6121                	addi	sp,sp,64
    8000314c:	8082                	ret

000000008000314e <namex>:
// If parent != 0, return the inode for the parent and copy the final
// path element into name, which must have room for DIRSIZ bytes.
// Must be called inside a transaction since it calls iput().
static struct inode *
namex(char *path, int nameiparent, char *name)
{
    8000314e:	711d                	addi	sp,sp,-96
    80003150:	ec86                	sd	ra,88(sp)
    80003152:	e8a2                	sd	s0,80(sp)
    80003154:	e4a6                	sd	s1,72(sp)
    80003156:	e0ca                	sd	s2,64(sp)
    80003158:	fc4e                	sd	s3,56(sp)
    8000315a:	f852                	sd	s4,48(sp)
    8000315c:	f456                	sd	s5,40(sp)
    8000315e:	f05a                	sd	s6,32(sp)
    80003160:	ec5e                	sd	s7,24(sp)
    80003162:	e862                	sd	s8,16(sp)
    80003164:	e466                	sd	s9,8(sp)
    80003166:	e06a                	sd	s10,0(sp)
    80003168:	1080                	addi	s0,sp,96
    8000316a:	84aa                	mv	s1,a0
    8000316c:	8b2e                	mv	s6,a1
    8000316e:	8ab2                	mv	s5,a2
  struct inode *ip, *next;

  if (*path == '/')
    80003170:	00054703          	lbu	a4,0(a0)
    80003174:	02f00793          	li	a5,47
    80003178:	02f70363          	beq	a4,a5,8000319e <namex+0x50>
    ip = iget(ROOTDEV, ROOTINO);
  else
    ip = idup(myproc()->cwd);
    8000317c:	ffffe097          	auipc	ra,0xffffe
    80003180:	cc8080e7          	jalr	-824(ra) # 80000e44 <myproc>
    80003184:	15053503          	ld	a0,336(a0)
    80003188:	00000097          	auipc	ra,0x0
    8000318c:	970080e7          	jalr	-1680(ra) # 80002af8 <idup>
    80003190:	8a2a                	mv	s4,a0
  while (*path == '/')
    80003192:	02f00913          	li	s2,47
  if (len >= DIRSIZ)
    80003196:	4cb5                	li	s9,13
  len = path - s;
    80003198:	4b81                	li	s7,0

  while ((path = skipelem(path, name)) != 0)
  {
    ilock(ip);
    if (ip->type != T_DIR)
    8000319a:	4c05                	li	s8,1
    8000319c:	a87d                	j	8000325a <namex+0x10c>
    ip = iget(ROOTDEV, ROOTINO);
    8000319e:	4585                	li	a1,1
    800031a0:	4505                	li	a0,1
    800031a2:	fffff097          	auipc	ra,0xfffff
    800031a6:	65e080e7          	jalr	1630(ra) # 80002800 <iget>
    800031aa:	8a2a                	mv	s4,a0
    800031ac:	b7dd                	j	80003192 <namex+0x44>
    {
      iunlockput(ip);
    800031ae:	8552                	mv	a0,s4
    800031b0:	00000097          	auipc	ra,0x0
    800031b4:	c34080e7          	jalr	-972(ra) # 80002de4 <iunlockput>
      return 0;
    800031b8:	4a01                	li	s4,0
  {
    iput(ip);
    return 0;
  }
  return ip;
}
    800031ba:	8552                	mv	a0,s4
    800031bc:	60e6                	ld	ra,88(sp)
    800031be:	6446                	ld	s0,80(sp)
    800031c0:	64a6                	ld	s1,72(sp)
    800031c2:	6906                	ld	s2,64(sp)
    800031c4:	79e2                	ld	s3,56(sp)
    800031c6:	7a42                	ld	s4,48(sp)
    800031c8:	7aa2                	ld	s5,40(sp)
    800031ca:	7b02                	ld	s6,32(sp)
    800031cc:	6be2                	ld	s7,24(sp)
    800031ce:	6c42                	ld	s8,16(sp)
    800031d0:	6ca2                	ld	s9,8(sp)
    800031d2:	6d02                	ld	s10,0(sp)
    800031d4:	6125                	addi	sp,sp,96
    800031d6:	8082                	ret
      iunlock(ip);
    800031d8:	8552                	mv	a0,s4
    800031da:	00000097          	auipc	ra,0x0
    800031de:	a1e080e7          	jalr	-1506(ra) # 80002bf8 <iunlock>
      return ip;
    800031e2:	bfe1                	j	800031ba <namex+0x6c>
      iunlockput(ip);
    800031e4:	8552                	mv	a0,s4
    800031e6:	00000097          	auipc	ra,0x0
    800031ea:	bfe080e7          	jalr	-1026(ra) # 80002de4 <iunlockput>
      return 0;
    800031ee:	8a4e                	mv	s4,s3
    800031f0:	b7e9                	j	800031ba <namex+0x6c>
  len = path - s;
    800031f2:	40998633          	sub	a2,s3,s1
    800031f6:	00060d1b          	sext.w	s10,a2
  if (len >= DIRSIZ)
    800031fa:	09acd863          	bge	s9,s10,8000328a <namex+0x13c>
    memmove(name, s, DIRSIZ);
    800031fe:	4639                	li	a2,14
    80003200:	85a6                	mv	a1,s1
    80003202:	8556                	mv	a0,s5
    80003204:	ffffd097          	auipc	ra,0xffffd
    80003208:	fd2080e7          	jalr	-46(ra) # 800001d6 <memmove>
    8000320c:	84ce                	mv	s1,s3
  while (*path == '/')
    8000320e:	0004c783          	lbu	a5,0(s1)
    80003212:	01279763          	bne	a5,s2,80003220 <namex+0xd2>
    path++;
    80003216:	0485                	addi	s1,s1,1
  while (*path == '/')
    80003218:	0004c783          	lbu	a5,0(s1)
    8000321c:	ff278de3          	beq	a5,s2,80003216 <namex+0xc8>
    ilock(ip);
    80003220:	8552                	mv	a0,s4
    80003222:	00000097          	auipc	ra,0x0
    80003226:	914080e7          	jalr	-1772(ra) # 80002b36 <ilock>
    if (ip->type != T_DIR)
    8000322a:	044a1783          	lh	a5,68(s4)
    8000322e:	f98790e3          	bne	a5,s8,800031ae <namex+0x60>
    if (nameiparent && *path == '\0')
    80003232:	000b0563          	beqz	s6,8000323c <namex+0xee>
    80003236:	0004c783          	lbu	a5,0(s1)
    8000323a:	dfd9                	beqz	a5,800031d8 <namex+0x8a>
    if ((next = dirlookup(ip, name, 0)) == 0)
    8000323c:	865e                	mv	a2,s7
    8000323e:	85d6                	mv	a1,s5
    80003240:	8552                	mv	a0,s4
    80003242:	00000097          	auipc	ra,0x0
    80003246:	e5c080e7          	jalr	-420(ra) # 8000309e <dirlookup>
    8000324a:	89aa                	mv	s3,a0
    8000324c:	dd41                	beqz	a0,800031e4 <namex+0x96>
    iunlockput(ip);
    8000324e:	8552                	mv	a0,s4
    80003250:	00000097          	auipc	ra,0x0
    80003254:	b94080e7          	jalr	-1132(ra) # 80002de4 <iunlockput>
    ip = next;
    80003258:	8a4e                	mv	s4,s3
  while (*path == '/')
    8000325a:	0004c783          	lbu	a5,0(s1)
    8000325e:	01279763          	bne	a5,s2,8000326c <namex+0x11e>
    path++;
    80003262:	0485                	addi	s1,s1,1
  while (*path == '/')
    80003264:	0004c783          	lbu	a5,0(s1)
    80003268:	ff278de3          	beq	a5,s2,80003262 <namex+0x114>
  if (*path == 0)
    8000326c:	cb9d                	beqz	a5,800032a2 <namex+0x154>
  while (*path != '/' && *path != 0)
    8000326e:	0004c783          	lbu	a5,0(s1)
    80003272:	89a6                	mv	s3,s1
  len = path - s;
    80003274:	8d5e                	mv	s10,s7
    80003276:	865e                	mv	a2,s7
  while (*path != '/' && *path != 0)
    80003278:	01278963          	beq	a5,s2,8000328a <namex+0x13c>
    8000327c:	dbbd                	beqz	a5,800031f2 <namex+0xa4>
    path++;
    8000327e:	0985                	addi	s3,s3,1
  while (*path != '/' && *path != 0)
    80003280:	0009c783          	lbu	a5,0(s3)
    80003284:	ff279ce3          	bne	a5,s2,8000327c <namex+0x12e>
    80003288:	b7ad                	j	800031f2 <namex+0xa4>
    memmove(name, s, len);
    8000328a:	2601                	sext.w	a2,a2
    8000328c:	85a6                	mv	a1,s1
    8000328e:	8556                	mv	a0,s5
    80003290:	ffffd097          	auipc	ra,0xffffd
    80003294:	f46080e7          	jalr	-186(ra) # 800001d6 <memmove>
    name[len] = 0;
    80003298:	9d56                	add	s10,s10,s5
    8000329a:	000d0023          	sb	zero,0(s10)
    8000329e:	84ce                	mv	s1,s3
    800032a0:	b7bd                	j	8000320e <namex+0xc0>
  if (nameiparent)
    800032a2:	f00b0ce3          	beqz	s6,800031ba <namex+0x6c>
    iput(ip);
    800032a6:	8552                	mv	a0,s4
    800032a8:	00000097          	auipc	ra,0x0
    800032ac:	a94080e7          	jalr	-1388(ra) # 80002d3c <iput>
    return 0;
    800032b0:	4a01                	li	s4,0
    800032b2:	b721                	j	800031ba <namex+0x6c>

00000000800032b4 <dirlink>:
{
    800032b4:	7139                	addi	sp,sp,-64
    800032b6:	fc06                	sd	ra,56(sp)
    800032b8:	f822                	sd	s0,48(sp)
    800032ba:	f426                	sd	s1,40(sp)
    800032bc:	f04a                	sd	s2,32(sp)
    800032be:	ec4e                	sd	s3,24(sp)
    800032c0:	e852                	sd	s4,16(sp)
    800032c2:	0080                	addi	s0,sp,64
    800032c4:	892a                	mv	s2,a0
    800032c6:	8a2e                	mv	s4,a1
    800032c8:	89b2                	mv	s3,a2
  if ((ip = dirlookup(dp, name, 0)) != 0)
    800032ca:	4601                	li	a2,0
    800032cc:	00000097          	auipc	ra,0x0
    800032d0:	dd2080e7          	jalr	-558(ra) # 8000309e <dirlookup>
    800032d4:	e93d                	bnez	a0,8000334a <dirlink+0x96>
  for (off = 0; off < dp->size; off += sizeof(de))
    800032d6:	04c92483          	lw	s1,76(s2)
    800032da:	c49d                	beqz	s1,80003308 <dirlink+0x54>
    800032dc:	4481                	li	s1,0
    if (readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    800032de:	4741                	li	a4,16
    800032e0:	86a6                	mv	a3,s1
    800032e2:	fc040613          	addi	a2,s0,-64
    800032e6:	4581                	li	a1,0
    800032e8:	854a                	mv	a0,s2
    800032ea:	00000097          	auipc	ra,0x0
    800032ee:	b4c080e7          	jalr	-1204(ra) # 80002e36 <readi>
    800032f2:	47c1                	li	a5,16
    800032f4:	06f51163          	bne	a0,a5,80003356 <dirlink+0xa2>
    if (de.inum == 0)
    800032f8:	fc045783          	lhu	a5,-64(s0)
    800032fc:	c791                	beqz	a5,80003308 <dirlink+0x54>
  for (off = 0; off < dp->size; off += sizeof(de))
    800032fe:	24c1                	addiw	s1,s1,16
    80003300:	04c92783          	lw	a5,76(s2)
    80003304:	fcf4ede3          	bltu	s1,a5,800032de <dirlink+0x2a>
  strncpy(de.name, name, DIRSIZ);
    80003308:	4639                	li	a2,14
    8000330a:	85d2                	mv	a1,s4
    8000330c:	fc240513          	addi	a0,s0,-62
    80003310:	ffffd097          	auipc	ra,0xffffd
    80003314:	f76080e7          	jalr	-138(ra) # 80000286 <strncpy>
  de.inum = inum;
    80003318:	fd341023          	sh	s3,-64(s0)
  if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    8000331c:	4741                	li	a4,16
    8000331e:	86a6                	mv	a3,s1
    80003320:	fc040613          	addi	a2,s0,-64
    80003324:	4581                	li	a1,0
    80003326:	854a                	mv	a0,s2
    80003328:	00000097          	auipc	ra,0x0
    8000332c:	c06080e7          	jalr	-1018(ra) # 80002f2e <writei>
    80003330:	872a                	mv	a4,a0
    80003332:	47c1                	li	a5,16
  return 0;
    80003334:	4501                	li	a0,0
  if (writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80003336:	02f71863          	bne	a4,a5,80003366 <dirlink+0xb2>
}
    8000333a:	70e2                	ld	ra,56(sp)
    8000333c:	7442                	ld	s0,48(sp)
    8000333e:	74a2                	ld	s1,40(sp)
    80003340:	7902                	ld	s2,32(sp)
    80003342:	69e2                	ld	s3,24(sp)
    80003344:	6a42                	ld	s4,16(sp)
    80003346:	6121                	addi	sp,sp,64
    80003348:	8082                	ret
    iput(ip);
    8000334a:	00000097          	auipc	ra,0x0
    8000334e:	9f2080e7          	jalr	-1550(ra) # 80002d3c <iput>
    return -1;
    80003352:	557d                	li	a0,-1
    80003354:	b7dd                	j	8000333a <dirlink+0x86>
      panic("dirlink read");
    80003356:	00005517          	auipc	a0,0x5
    8000335a:	2d250513          	addi	a0,a0,722 # 80008628 <syscalls+0x260>
    8000335e:	00003097          	auipc	ra,0x3
    80003362:	912080e7          	jalr	-1774(ra) # 80005c70 <panic>
    panic("dirlink");
    80003366:	00005517          	auipc	a0,0x5
    8000336a:	4aa50513          	addi	a0,a0,1194 # 80008810 <syscalls+0x448>
    8000336e:	00003097          	auipc	ra,0x3
    80003372:	902080e7          	jalr	-1790(ra) # 80005c70 <panic>

0000000080003376 <namei>:

struct inode *
namei(char *path)
{
    80003376:	1101                	addi	sp,sp,-32
    80003378:	ec06                	sd	ra,24(sp)
    8000337a:	e822                	sd	s0,16(sp)
    8000337c:	1000                	addi	s0,sp,32
  char name[DIRSIZ];
  return namex(path, 0, name);
    8000337e:	fe040613          	addi	a2,s0,-32
    80003382:	4581                	li	a1,0
    80003384:	00000097          	auipc	ra,0x0
    80003388:	dca080e7          	jalr	-566(ra) # 8000314e <namex>
}
    8000338c:	60e2                	ld	ra,24(sp)
    8000338e:	6442                	ld	s0,16(sp)
    80003390:	6105                	addi	sp,sp,32
    80003392:	8082                	ret

0000000080003394 <nameiparent>:

struct inode *
nameiparent(char *path, char *name)
{
    80003394:	1141                	addi	sp,sp,-16
    80003396:	e406                	sd	ra,8(sp)
    80003398:	e022                	sd	s0,0(sp)
    8000339a:	0800                	addi	s0,sp,16
    8000339c:	862e                	mv	a2,a1
  return namex(path, 1, name);
    8000339e:	4585                	li	a1,1
    800033a0:	00000097          	auipc	ra,0x0
    800033a4:	dae080e7          	jalr	-594(ra) # 8000314e <namex>
}
    800033a8:	60a2                	ld	ra,8(sp)
    800033aa:	6402                	ld	s0,0(sp)
    800033ac:	0141                	addi	sp,sp,16
    800033ae:	8082                	ret

00000000800033b0 <write_head>:
// Write in-memory log header to disk.
// This is the true point at which the
// current transaction commits.
static void
write_head(void)
{
    800033b0:	1101                	addi	sp,sp,-32
    800033b2:	ec06                	sd	ra,24(sp)
    800033b4:	e822                	sd	s0,16(sp)
    800033b6:	e426                	sd	s1,8(sp)
    800033b8:	e04a                	sd	s2,0(sp)
    800033ba:	1000                	addi	s0,sp,32
  struct buf *buf = bread(log.dev, log.start);
    800033bc:	0001d917          	auipc	s2,0x1d
    800033c0:	6e490913          	addi	s2,s2,1764 # 80020aa0 <log>
    800033c4:	01892583          	lw	a1,24(s2)
    800033c8:	02892503          	lw	a0,40(s2)
    800033cc:	fffff097          	auipc	ra,0xfffff
    800033d0:	e9e080e7          	jalr	-354(ra) # 8000226a <bread>
    800033d4:	84aa                	mv	s1,a0
  struct logheader *hb = (struct logheader *) (buf->data);
  int i;
  hb->n = log.lh.n;
    800033d6:	02c92683          	lw	a3,44(s2)
    800033da:	cd34                	sw	a3,88(a0)
  for (i = 0; i < log.lh.n; i++) {
    800033dc:	02d05863          	blez	a3,8000340c <write_head+0x5c>
    800033e0:	0001d797          	auipc	a5,0x1d
    800033e4:	6f078793          	addi	a5,a5,1776 # 80020ad0 <log+0x30>
    800033e8:	05c50713          	addi	a4,a0,92
    800033ec:	36fd                	addiw	a3,a3,-1
    800033ee:	02069613          	slli	a2,a3,0x20
    800033f2:	01e65693          	srli	a3,a2,0x1e
    800033f6:	0001d617          	auipc	a2,0x1d
    800033fa:	6de60613          	addi	a2,a2,1758 # 80020ad4 <log+0x34>
    800033fe:	96b2                	add	a3,a3,a2
    hb->block[i] = log.lh.block[i];
    80003400:	4390                	lw	a2,0(a5)
    80003402:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    80003404:	0791                	addi	a5,a5,4
    80003406:	0711                	addi	a4,a4,4
    80003408:	fed79ce3          	bne	a5,a3,80003400 <write_head+0x50>
  }
  bwrite(buf);
    8000340c:	8526                	mv	a0,s1
    8000340e:	fffff097          	auipc	ra,0xfffff
    80003412:	f4e080e7          	jalr	-178(ra) # 8000235c <bwrite>
  brelse(buf);
    80003416:	8526                	mv	a0,s1
    80003418:	fffff097          	auipc	ra,0xfffff
    8000341c:	f82080e7          	jalr	-126(ra) # 8000239a <brelse>
}
    80003420:	60e2                	ld	ra,24(sp)
    80003422:	6442                	ld	s0,16(sp)
    80003424:	64a2                	ld	s1,8(sp)
    80003426:	6902                	ld	s2,0(sp)
    80003428:	6105                	addi	sp,sp,32
    8000342a:	8082                	ret

000000008000342c <install_trans>:
  for (tail = 0; tail < log.lh.n; tail++) {
    8000342c:	0001d797          	auipc	a5,0x1d
    80003430:	6a07a783          	lw	a5,1696(a5) # 80020acc <log+0x2c>
    80003434:	0af05d63          	blez	a5,800034ee <install_trans+0xc2>
{
    80003438:	7139                	addi	sp,sp,-64
    8000343a:	fc06                	sd	ra,56(sp)
    8000343c:	f822                	sd	s0,48(sp)
    8000343e:	f426                	sd	s1,40(sp)
    80003440:	f04a                	sd	s2,32(sp)
    80003442:	ec4e                	sd	s3,24(sp)
    80003444:	e852                	sd	s4,16(sp)
    80003446:	e456                	sd	s5,8(sp)
    80003448:	e05a                	sd	s6,0(sp)
    8000344a:	0080                	addi	s0,sp,64
    8000344c:	8b2a                	mv	s6,a0
    8000344e:	0001da97          	auipc	s5,0x1d
    80003452:	682a8a93          	addi	s5,s5,1666 # 80020ad0 <log+0x30>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003456:	4a01                	li	s4,0
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003458:	0001d997          	auipc	s3,0x1d
    8000345c:	64898993          	addi	s3,s3,1608 # 80020aa0 <log>
    80003460:	a00d                	j	80003482 <install_trans+0x56>
    brelse(lbuf);
    80003462:	854a                	mv	a0,s2
    80003464:	fffff097          	auipc	ra,0xfffff
    80003468:	f36080e7          	jalr	-202(ra) # 8000239a <brelse>
    brelse(dbuf);
    8000346c:	8526                	mv	a0,s1
    8000346e:	fffff097          	auipc	ra,0xfffff
    80003472:	f2c080e7          	jalr	-212(ra) # 8000239a <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    80003476:	2a05                	addiw	s4,s4,1
    80003478:	0a91                	addi	s5,s5,4
    8000347a:	02c9a783          	lw	a5,44(s3)
    8000347e:	04fa5e63          	bge	s4,a5,800034da <install_trans+0xae>
    struct buf *lbuf = bread(log.dev, log.start+tail+1); // read log block
    80003482:	0189a583          	lw	a1,24(s3)
    80003486:	014585bb          	addw	a1,a1,s4
    8000348a:	2585                	addiw	a1,a1,1
    8000348c:	0289a503          	lw	a0,40(s3)
    80003490:	fffff097          	auipc	ra,0xfffff
    80003494:	dda080e7          	jalr	-550(ra) # 8000226a <bread>
    80003498:	892a                	mv	s2,a0
    struct buf *dbuf = bread(log.dev, log.lh.block[tail]); // read dst
    8000349a:	000aa583          	lw	a1,0(s5)
    8000349e:	0289a503          	lw	a0,40(s3)
    800034a2:	fffff097          	auipc	ra,0xfffff
    800034a6:	dc8080e7          	jalr	-568(ra) # 8000226a <bread>
    800034aa:	84aa                	mv	s1,a0
    memmove(dbuf->data, lbuf->data, BSIZE);  // copy block to dst
    800034ac:	40000613          	li	a2,1024
    800034b0:	05890593          	addi	a1,s2,88
    800034b4:	05850513          	addi	a0,a0,88
    800034b8:	ffffd097          	auipc	ra,0xffffd
    800034bc:	d1e080e7          	jalr	-738(ra) # 800001d6 <memmove>
    bwrite(dbuf);  // write dst to disk
    800034c0:	8526                	mv	a0,s1
    800034c2:	fffff097          	auipc	ra,0xfffff
    800034c6:	e9a080e7          	jalr	-358(ra) # 8000235c <bwrite>
    if(recovering == 0)
    800034ca:	f80b1ce3          	bnez	s6,80003462 <install_trans+0x36>
      bunpin(dbuf);
    800034ce:	8526                	mv	a0,s1
    800034d0:	fffff097          	auipc	ra,0xfffff
    800034d4:	fa4080e7          	jalr	-92(ra) # 80002474 <bunpin>
    800034d8:	b769                	j	80003462 <install_trans+0x36>
}
    800034da:	70e2                	ld	ra,56(sp)
    800034dc:	7442                	ld	s0,48(sp)
    800034de:	74a2                	ld	s1,40(sp)
    800034e0:	7902                	ld	s2,32(sp)
    800034e2:	69e2                	ld	s3,24(sp)
    800034e4:	6a42                	ld	s4,16(sp)
    800034e6:	6aa2                	ld	s5,8(sp)
    800034e8:	6b02                	ld	s6,0(sp)
    800034ea:	6121                	addi	sp,sp,64
    800034ec:	8082                	ret
    800034ee:	8082                	ret

00000000800034f0 <initlog>:
{
    800034f0:	7179                	addi	sp,sp,-48
    800034f2:	f406                	sd	ra,40(sp)
    800034f4:	f022                	sd	s0,32(sp)
    800034f6:	ec26                	sd	s1,24(sp)
    800034f8:	e84a                	sd	s2,16(sp)
    800034fa:	e44e                	sd	s3,8(sp)
    800034fc:	1800                	addi	s0,sp,48
    800034fe:	892a                	mv	s2,a0
    80003500:	89ae                	mv	s3,a1
  initlock(&log.lock, "log");
    80003502:	0001d497          	auipc	s1,0x1d
    80003506:	59e48493          	addi	s1,s1,1438 # 80020aa0 <log>
    8000350a:	00005597          	auipc	a1,0x5
    8000350e:	12e58593          	addi	a1,a1,302 # 80008638 <syscalls+0x270>
    80003512:	8526                	mv	a0,s1
    80003514:	00003097          	auipc	ra,0x3
    80003518:	c04080e7          	jalr	-1020(ra) # 80006118 <initlock>
  log.start = sb->logstart;
    8000351c:	0149a583          	lw	a1,20(s3)
    80003520:	cc8c                	sw	a1,24(s1)
  log.size = sb->nlog;
    80003522:	0109a783          	lw	a5,16(s3)
    80003526:	ccdc                	sw	a5,28(s1)
  log.dev = dev;
    80003528:	0324a423          	sw	s2,40(s1)
  struct buf *buf = bread(log.dev, log.start);
    8000352c:	854a                	mv	a0,s2
    8000352e:	fffff097          	auipc	ra,0xfffff
    80003532:	d3c080e7          	jalr	-708(ra) # 8000226a <bread>
  log.lh.n = lh->n;
    80003536:	4d34                	lw	a3,88(a0)
    80003538:	d4d4                	sw	a3,44(s1)
  for (i = 0; i < log.lh.n; i++) {
    8000353a:	02d05663          	blez	a3,80003566 <initlog+0x76>
    8000353e:	05c50793          	addi	a5,a0,92
    80003542:	0001d717          	auipc	a4,0x1d
    80003546:	58e70713          	addi	a4,a4,1422 # 80020ad0 <log+0x30>
    8000354a:	36fd                	addiw	a3,a3,-1
    8000354c:	02069613          	slli	a2,a3,0x20
    80003550:	01e65693          	srli	a3,a2,0x1e
    80003554:	06050613          	addi	a2,a0,96
    80003558:	96b2                	add	a3,a3,a2
    log.lh.block[i] = lh->block[i];
    8000355a:	4390                	lw	a2,0(a5)
    8000355c:	c310                	sw	a2,0(a4)
  for (i = 0; i < log.lh.n; i++) {
    8000355e:	0791                	addi	a5,a5,4
    80003560:	0711                	addi	a4,a4,4
    80003562:	fed79ce3          	bne	a5,a3,8000355a <initlog+0x6a>
  brelse(buf);
    80003566:	fffff097          	auipc	ra,0xfffff
    8000356a:	e34080e7          	jalr	-460(ra) # 8000239a <brelse>

static void
recover_from_log(void)
{
  read_head();
  install_trans(1); // if committed, copy from log to disk
    8000356e:	4505                	li	a0,1
    80003570:	00000097          	auipc	ra,0x0
    80003574:	ebc080e7          	jalr	-324(ra) # 8000342c <install_trans>
  log.lh.n = 0;
    80003578:	0001d797          	auipc	a5,0x1d
    8000357c:	5407aa23          	sw	zero,1364(a5) # 80020acc <log+0x2c>
  write_head(); // clear the log
    80003580:	00000097          	auipc	ra,0x0
    80003584:	e30080e7          	jalr	-464(ra) # 800033b0 <write_head>
}
    80003588:	70a2                	ld	ra,40(sp)
    8000358a:	7402                	ld	s0,32(sp)
    8000358c:	64e2                	ld	s1,24(sp)
    8000358e:	6942                	ld	s2,16(sp)
    80003590:	69a2                	ld	s3,8(sp)
    80003592:	6145                	addi	sp,sp,48
    80003594:	8082                	ret

0000000080003596 <begin_op>:
}

// called at the start of each FS system call.
void
begin_op(void)
{
    80003596:	1101                	addi	sp,sp,-32
    80003598:	ec06                	sd	ra,24(sp)
    8000359a:	e822                	sd	s0,16(sp)
    8000359c:	e426                	sd	s1,8(sp)
    8000359e:	e04a                	sd	s2,0(sp)
    800035a0:	1000                	addi	s0,sp,32
  acquire(&log.lock);
    800035a2:	0001d517          	auipc	a0,0x1d
    800035a6:	4fe50513          	addi	a0,a0,1278 # 80020aa0 <log>
    800035aa:	00003097          	auipc	ra,0x3
    800035ae:	bfe080e7          	jalr	-1026(ra) # 800061a8 <acquire>
  while(1){
    if(log.committing){
    800035b2:	0001d497          	auipc	s1,0x1d
    800035b6:	4ee48493          	addi	s1,s1,1262 # 80020aa0 <log>
      sleep(&log, &log.lock);
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800035ba:	4979                	li	s2,30
    800035bc:	a039                	j	800035ca <begin_op+0x34>
      sleep(&log, &log.lock);
    800035be:	85a6                	mv	a1,s1
    800035c0:	8526                	mv	a0,s1
    800035c2:	ffffe097          	auipc	ra,0xffffe
    800035c6:	f46080e7          	jalr	-186(ra) # 80001508 <sleep>
    if(log.committing){
    800035ca:	50dc                	lw	a5,36(s1)
    800035cc:	fbed                	bnez	a5,800035be <begin_op+0x28>
    } else if(log.lh.n + (log.outstanding+1)*MAXOPBLOCKS > LOGSIZE){
    800035ce:	5098                	lw	a4,32(s1)
    800035d0:	2705                	addiw	a4,a4,1
    800035d2:	0007069b          	sext.w	a3,a4
    800035d6:	0027179b          	slliw	a5,a4,0x2
    800035da:	9fb9                	addw	a5,a5,a4
    800035dc:	0017979b          	slliw	a5,a5,0x1
    800035e0:	54d8                	lw	a4,44(s1)
    800035e2:	9fb9                	addw	a5,a5,a4
    800035e4:	00f95963          	bge	s2,a5,800035f6 <begin_op+0x60>
      // this op might exhaust log space; wait for commit.
      sleep(&log, &log.lock);
    800035e8:	85a6                	mv	a1,s1
    800035ea:	8526                	mv	a0,s1
    800035ec:	ffffe097          	auipc	ra,0xffffe
    800035f0:	f1c080e7          	jalr	-228(ra) # 80001508 <sleep>
    800035f4:	bfd9                	j	800035ca <begin_op+0x34>
    } else {
      log.outstanding += 1;
    800035f6:	0001d517          	auipc	a0,0x1d
    800035fa:	4aa50513          	addi	a0,a0,1194 # 80020aa0 <log>
    800035fe:	d114                	sw	a3,32(a0)
      release(&log.lock);
    80003600:	00003097          	auipc	ra,0x3
    80003604:	c5c080e7          	jalr	-932(ra) # 8000625c <release>
      break;
    }
  }
}
    80003608:	60e2                	ld	ra,24(sp)
    8000360a:	6442                	ld	s0,16(sp)
    8000360c:	64a2                	ld	s1,8(sp)
    8000360e:	6902                	ld	s2,0(sp)
    80003610:	6105                	addi	sp,sp,32
    80003612:	8082                	ret

0000000080003614 <end_op>:

// called at the end of each FS system call.
// commits if this was the last outstanding operation.
void
end_op(void)
{
    80003614:	7139                	addi	sp,sp,-64
    80003616:	fc06                	sd	ra,56(sp)
    80003618:	f822                	sd	s0,48(sp)
    8000361a:	f426                	sd	s1,40(sp)
    8000361c:	f04a                	sd	s2,32(sp)
    8000361e:	ec4e                	sd	s3,24(sp)
    80003620:	e852                	sd	s4,16(sp)
    80003622:	e456                	sd	s5,8(sp)
    80003624:	0080                	addi	s0,sp,64
  int do_commit = 0;

  acquire(&log.lock);
    80003626:	0001d497          	auipc	s1,0x1d
    8000362a:	47a48493          	addi	s1,s1,1146 # 80020aa0 <log>
    8000362e:	8526                	mv	a0,s1
    80003630:	00003097          	auipc	ra,0x3
    80003634:	b78080e7          	jalr	-1160(ra) # 800061a8 <acquire>
  log.outstanding -= 1;
    80003638:	509c                	lw	a5,32(s1)
    8000363a:	37fd                	addiw	a5,a5,-1
    8000363c:	0007891b          	sext.w	s2,a5
    80003640:	d09c                	sw	a5,32(s1)
  if(log.committing)
    80003642:	50dc                	lw	a5,36(s1)
    80003644:	e7b9                	bnez	a5,80003692 <end_op+0x7e>
    panic("log.committing");
  if(log.outstanding == 0){
    80003646:	04091e63          	bnez	s2,800036a2 <end_op+0x8e>
    do_commit = 1;
    log.committing = 1;
    8000364a:	0001d497          	auipc	s1,0x1d
    8000364e:	45648493          	addi	s1,s1,1110 # 80020aa0 <log>
    80003652:	4785                	li	a5,1
    80003654:	d0dc                	sw	a5,36(s1)
    // begin_op() may be waiting for log space,
    // and decrementing log.outstanding has decreased
    // the amount of reserved space.
    wakeup(&log);
  }
  release(&log.lock);
    80003656:	8526                	mv	a0,s1
    80003658:	00003097          	auipc	ra,0x3
    8000365c:	c04080e7          	jalr	-1020(ra) # 8000625c <release>
}

static void
commit()
{
  if (log.lh.n > 0) {
    80003660:	54dc                	lw	a5,44(s1)
    80003662:	06f04763          	bgtz	a5,800036d0 <end_op+0xbc>
    acquire(&log.lock);
    80003666:	0001d497          	auipc	s1,0x1d
    8000366a:	43a48493          	addi	s1,s1,1082 # 80020aa0 <log>
    8000366e:	8526                	mv	a0,s1
    80003670:	00003097          	auipc	ra,0x3
    80003674:	b38080e7          	jalr	-1224(ra) # 800061a8 <acquire>
    log.committing = 0;
    80003678:	0204a223          	sw	zero,36(s1)
    wakeup(&log);
    8000367c:	8526                	mv	a0,s1
    8000367e:	ffffe097          	auipc	ra,0xffffe
    80003682:	016080e7          	jalr	22(ra) # 80001694 <wakeup>
    release(&log.lock);
    80003686:	8526                	mv	a0,s1
    80003688:	00003097          	auipc	ra,0x3
    8000368c:	bd4080e7          	jalr	-1068(ra) # 8000625c <release>
}
    80003690:	a03d                	j	800036be <end_op+0xaa>
    panic("log.committing");
    80003692:	00005517          	auipc	a0,0x5
    80003696:	fae50513          	addi	a0,a0,-82 # 80008640 <syscalls+0x278>
    8000369a:	00002097          	auipc	ra,0x2
    8000369e:	5d6080e7          	jalr	1494(ra) # 80005c70 <panic>
    wakeup(&log);
    800036a2:	0001d497          	auipc	s1,0x1d
    800036a6:	3fe48493          	addi	s1,s1,1022 # 80020aa0 <log>
    800036aa:	8526                	mv	a0,s1
    800036ac:	ffffe097          	auipc	ra,0xffffe
    800036b0:	fe8080e7          	jalr	-24(ra) # 80001694 <wakeup>
  release(&log.lock);
    800036b4:	8526                	mv	a0,s1
    800036b6:	00003097          	auipc	ra,0x3
    800036ba:	ba6080e7          	jalr	-1114(ra) # 8000625c <release>
}
    800036be:	70e2                	ld	ra,56(sp)
    800036c0:	7442                	ld	s0,48(sp)
    800036c2:	74a2                	ld	s1,40(sp)
    800036c4:	7902                	ld	s2,32(sp)
    800036c6:	69e2                	ld	s3,24(sp)
    800036c8:	6a42                	ld	s4,16(sp)
    800036ca:	6aa2                	ld	s5,8(sp)
    800036cc:	6121                	addi	sp,sp,64
    800036ce:	8082                	ret
  for (tail = 0; tail < log.lh.n; tail++) {
    800036d0:	0001da97          	auipc	s5,0x1d
    800036d4:	400a8a93          	addi	s5,s5,1024 # 80020ad0 <log+0x30>
    struct buf *to = bread(log.dev, log.start+tail+1); // log block
    800036d8:	0001da17          	auipc	s4,0x1d
    800036dc:	3c8a0a13          	addi	s4,s4,968 # 80020aa0 <log>
    800036e0:	018a2583          	lw	a1,24(s4)
    800036e4:	012585bb          	addw	a1,a1,s2
    800036e8:	2585                	addiw	a1,a1,1
    800036ea:	028a2503          	lw	a0,40(s4)
    800036ee:	fffff097          	auipc	ra,0xfffff
    800036f2:	b7c080e7          	jalr	-1156(ra) # 8000226a <bread>
    800036f6:	84aa                	mv	s1,a0
    struct buf *from = bread(log.dev, log.lh.block[tail]); // cache block
    800036f8:	000aa583          	lw	a1,0(s5)
    800036fc:	028a2503          	lw	a0,40(s4)
    80003700:	fffff097          	auipc	ra,0xfffff
    80003704:	b6a080e7          	jalr	-1174(ra) # 8000226a <bread>
    80003708:	89aa                	mv	s3,a0
    memmove(to->data, from->data, BSIZE);
    8000370a:	40000613          	li	a2,1024
    8000370e:	05850593          	addi	a1,a0,88
    80003712:	05848513          	addi	a0,s1,88
    80003716:	ffffd097          	auipc	ra,0xffffd
    8000371a:	ac0080e7          	jalr	-1344(ra) # 800001d6 <memmove>
    bwrite(to);  // write the log
    8000371e:	8526                	mv	a0,s1
    80003720:	fffff097          	auipc	ra,0xfffff
    80003724:	c3c080e7          	jalr	-964(ra) # 8000235c <bwrite>
    brelse(from);
    80003728:	854e                	mv	a0,s3
    8000372a:	fffff097          	auipc	ra,0xfffff
    8000372e:	c70080e7          	jalr	-912(ra) # 8000239a <brelse>
    brelse(to);
    80003732:	8526                	mv	a0,s1
    80003734:	fffff097          	auipc	ra,0xfffff
    80003738:	c66080e7          	jalr	-922(ra) # 8000239a <brelse>
  for (tail = 0; tail < log.lh.n; tail++) {
    8000373c:	2905                	addiw	s2,s2,1
    8000373e:	0a91                	addi	s5,s5,4
    80003740:	02ca2783          	lw	a5,44(s4)
    80003744:	f8f94ee3          	blt	s2,a5,800036e0 <end_op+0xcc>
    write_log();     // Write modified blocks from cache to log
    write_head();    // Write header to disk -- the real commit
    80003748:	00000097          	auipc	ra,0x0
    8000374c:	c68080e7          	jalr	-920(ra) # 800033b0 <write_head>
    install_trans(0); // Now install writes to home locations
    80003750:	4501                	li	a0,0
    80003752:	00000097          	auipc	ra,0x0
    80003756:	cda080e7          	jalr	-806(ra) # 8000342c <install_trans>
    log.lh.n = 0;
    8000375a:	0001d797          	auipc	a5,0x1d
    8000375e:	3607a923          	sw	zero,882(a5) # 80020acc <log+0x2c>
    write_head();    // Erase the transaction from the log
    80003762:	00000097          	auipc	ra,0x0
    80003766:	c4e080e7          	jalr	-946(ra) # 800033b0 <write_head>
    8000376a:	bdf5                	j	80003666 <end_op+0x52>

000000008000376c <log_write>:
//   modify bp->data[]
//   log_write(bp)
//   brelse(bp)
void
log_write(struct buf *b)
{
    8000376c:	1101                	addi	sp,sp,-32
    8000376e:	ec06                	sd	ra,24(sp)
    80003770:	e822                	sd	s0,16(sp)
    80003772:	e426                	sd	s1,8(sp)
    80003774:	e04a                	sd	s2,0(sp)
    80003776:	1000                	addi	s0,sp,32
    80003778:	84aa                	mv	s1,a0
  int i;

  acquire(&log.lock);
    8000377a:	0001d917          	auipc	s2,0x1d
    8000377e:	32690913          	addi	s2,s2,806 # 80020aa0 <log>
    80003782:	854a                	mv	a0,s2
    80003784:	00003097          	auipc	ra,0x3
    80003788:	a24080e7          	jalr	-1500(ra) # 800061a8 <acquire>
  if (log.lh.n >= LOGSIZE || log.lh.n >= log.size - 1)
    8000378c:	02c92603          	lw	a2,44(s2)
    80003790:	47f5                	li	a5,29
    80003792:	06c7c563          	blt	a5,a2,800037fc <log_write+0x90>
    80003796:	0001d797          	auipc	a5,0x1d
    8000379a:	3267a783          	lw	a5,806(a5) # 80020abc <log+0x1c>
    8000379e:	37fd                	addiw	a5,a5,-1
    800037a0:	04f65e63          	bge	a2,a5,800037fc <log_write+0x90>
    panic("too big a transaction");
  if (log.outstanding < 1)
    800037a4:	0001d797          	auipc	a5,0x1d
    800037a8:	31c7a783          	lw	a5,796(a5) # 80020ac0 <log+0x20>
    800037ac:	06f05063          	blez	a5,8000380c <log_write+0xa0>
    panic("log_write outside of trans");

  for (i = 0; i < log.lh.n; i++) {
    800037b0:	4781                	li	a5,0
    800037b2:	06c05563          	blez	a2,8000381c <log_write+0xb0>
    if (log.lh.block[i] == b->blockno)   // log absorption
    800037b6:	44cc                	lw	a1,12(s1)
    800037b8:	0001d717          	auipc	a4,0x1d
    800037bc:	31870713          	addi	a4,a4,792 # 80020ad0 <log+0x30>
  for (i = 0; i < log.lh.n; i++) {
    800037c0:	4781                	li	a5,0
    if (log.lh.block[i] == b->blockno)   // log absorption
    800037c2:	4314                	lw	a3,0(a4)
    800037c4:	04b68c63          	beq	a3,a1,8000381c <log_write+0xb0>
  for (i = 0; i < log.lh.n; i++) {
    800037c8:	2785                	addiw	a5,a5,1
    800037ca:	0711                	addi	a4,a4,4
    800037cc:	fef61be3          	bne	a2,a5,800037c2 <log_write+0x56>
      break;
  }
  log.lh.block[i] = b->blockno;
    800037d0:	0621                	addi	a2,a2,8
    800037d2:	060a                	slli	a2,a2,0x2
    800037d4:	0001d797          	auipc	a5,0x1d
    800037d8:	2cc78793          	addi	a5,a5,716 # 80020aa0 <log>
    800037dc:	97b2                	add	a5,a5,a2
    800037de:	44d8                	lw	a4,12(s1)
    800037e0:	cb98                	sw	a4,16(a5)
  if (i == log.lh.n) {  // Add new block to log?
    bpin(b);
    800037e2:	8526                	mv	a0,s1
    800037e4:	fffff097          	auipc	ra,0xfffff
    800037e8:	c54080e7          	jalr	-940(ra) # 80002438 <bpin>
    log.lh.n++;
    800037ec:	0001d717          	auipc	a4,0x1d
    800037f0:	2b470713          	addi	a4,a4,692 # 80020aa0 <log>
    800037f4:	575c                	lw	a5,44(a4)
    800037f6:	2785                	addiw	a5,a5,1
    800037f8:	d75c                	sw	a5,44(a4)
    800037fa:	a82d                	j	80003834 <log_write+0xc8>
    panic("too big a transaction");
    800037fc:	00005517          	auipc	a0,0x5
    80003800:	e5450513          	addi	a0,a0,-428 # 80008650 <syscalls+0x288>
    80003804:	00002097          	auipc	ra,0x2
    80003808:	46c080e7          	jalr	1132(ra) # 80005c70 <panic>
    panic("log_write outside of trans");
    8000380c:	00005517          	auipc	a0,0x5
    80003810:	e5c50513          	addi	a0,a0,-420 # 80008668 <syscalls+0x2a0>
    80003814:	00002097          	auipc	ra,0x2
    80003818:	45c080e7          	jalr	1116(ra) # 80005c70 <panic>
  log.lh.block[i] = b->blockno;
    8000381c:	00878693          	addi	a3,a5,8
    80003820:	068a                	slli	a3,a3,0x2
    80003822:	0001d717          	auipc	a4,0x1d
    80003826:	27e70713          	addi	a4,a4,638 # 80020aa0 <log>
    8000382a:	9736                	add	a4,a4,a3
    8000382c:	44d4                	lw	a3,12(s1)
    8000382e:	cb14                	sw	a3,16(a4)
  if (i == log.lh.n) {  // Add new block to log?
    80003830:	faf609e3          	beq	a2,a5,800037e2 <log_write+0x76>
  }
  release(&log.lock);
    80003834:	0001d517          	auipc	a0,0x1d
    80003838:	26c50513          	addi	a0,a0,620 # 80020aa0 <log>
    8000383c:	00003097          	auipc	ra,0x3
    80003840:	a20080e7          	jalr	-1504(ra) # 8000625c <release>
}
    80003844:	60e2                	ld	ra,24(sp)
    80003846:	6442                	ld	s0,16(sp)
    80003848:	64a2                	ld	s1,8(sp)
    8000384a:	6902                	ld	s2,0(sp)
    8000384c:	6105                	addi	sp,sp,32
    8000384e:	8082                	ret

0000000080003850 <initsleeplock>:
#include "proc.h"
#include "sleeplock.h"

void
initsleeplock(struct sleeplock *lk, char *name)
{
    80003850:	1101                	addi	sp,sp,-32
    80003852:	ec06                	sd	ra,24(sp)
    80003854:	e822                	sd	s0,16(sp)
    80003856:	e426                	sd	s1,8(sp)
    80003858:	e04a                	sd	s2,0(sp)
    8000385a:	1000                	addi	s0,sp,32
    8000385c:	84aa                	mv	s1,a0
    8000385e:	892e                	mv	s2,a1
  initlock(&lk->lk, "sleep lock");
    80003860:	00005597          	auipc	a1,0x5
    80003864:	e2858593          	addi	a1,a1,-472 # 80008688 <syscalls+0x2c0>
    80003868:	0521                	addi	a0,a0,8
    8000386a:	00003097          	auipc	ra,0x3
    8000386e:	8ae080e7          	jalr	-1874(ra) # 80006118 <initlock>
  lk->name = name;
    80003872:	0324b023          	sd	s2,32(s1)
  lk->locked = 0;
    80003876:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    8000387a:	0204a423          	sw	zero,40(s1)
}
    8000387e:	60e2                	ld	ra,24(sp)
    80003880:	6442                	ld	s0,16(sp)
    80003882:	64a2                	ld	s1,8(sp)
    80003884:	6902                	ld	s2,0(sp)
    80003886:	6105                	addi	sp,sp,32
    80003888:	8082                	ret

000000008000388a <acquiresleep>:

void
acquiresleep(struct sleeplock *lk)
{
    8000388a:	1101                	addi	sp,sp,-32
    8000388c:	ec06                	sd	ra,24(sp)
    8000388e:	e822                	sd	s0,16(sp)
    80003890:	e426                	sd	s1,8(sp)
    80003892:	e04a                	sd	s2,0(sp)
    80003894:	1000                	addi	s0,sp,32
    80003896:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    80003898:	00850913          	addi	s2,a0,8
    8000389c:	854a                	mv	a0,s2
    8000389e:	00003097          	auipc	ra,0x3
    800038a2:	90a080e7          	jalr	-1782(ra) # 800061a8 <acquire>
  while (lk->locked) {
    800038a6:	409c                	lw	a5,0(s1)
    800038a8:	cb89                	beqz	a5,800038ba <acquiresleep+0x30>
    sleep(lk, &lk->lk);
    800038aa:	85ca                	mv	a1,s2
    800038ac:	8526                	mv	a0,s1
    800038ae:	ffffe097          	auipc	ra,0xffffe
    800038b2:	c5a080e7          	jalr	-934(ra) # 80001508 <sleep>
  while (lk->locked) {
    800038b6:	409c                	lw	a5,0(s1)
    800038b8:	fbed                	bnez	a5,800038aa <acquiresleep+0x20>
  }
  lk->locked = 1;
    800038ba:	4785                	li	a5,1
    800038bc:	c09c                	sw	a5,0(s1)
  lk->pid = myproc()->pid;
    800038be:	ffffd097          	auipc	ra,0xffffd
    800038c2:	586080e7          	jalr	1414(ra) # 80000e44 <myproc>
    800038c6:	591c                	lw	a5,48(a0)
    800038c8:	d49c                	sw	a5,40(s1)
  release(&lk->lk);
    800038ca:	854a                	mv	a0,s2
    800038cc:	00003097          	auipc	ra,0x3
    800038d0:	990080e7          	jalr	-1648(ra) # 8000625c <release>
}
    800038d4:	60e2                	ld	ra,24(sp)
    800038d6:	6442                	ld	s0,16(sp)
    800038d8:	64a2                	ld	s1,8(sp)
    800038da:	6902                	ld	s2,0(sp)
    800038dc:	6105                	addi	sp,sp,32
    800038de:	8082                	ret

00000000800038e0 <releasesleep>:

void
releasesleep(struct sleeplock *lk)
{
    800038e0:	1101                	addi	sp,sp,-32
    800038e2:	ec06                	sd	ra,24(sp)
    800038e4:	e822                	sd	s0,16(sp)
    800038e6:	e426                	sd	s1,8(sp)
    800038e8:	e04a                	sd	s2,0(sp)
    800038ea:	1000                	addi	s0,sp,32
    800038ec:	84aa                	mv	s1,a0
  acquire(&lk->lk);
    800038ee:	00850913          	addi	s2,a0,8
    800038f2:	854a                	mv	a0,s2
    800038f4:	00003097          	auipc	ra,0x3
    800038f8:	8b4080e7          	jalr	-1868(ra) # 800061a8 <acquire>
  lk->locked = 0;
    800038fc:	0004a023          	sw	zero,0(s1)
  lk->pid = 0;
    80003900:	0204a423          	sw	zero,40(s1)
  wakeup(lk);
    80003904:	8526                	mv	a0,s1
    80003906:	ffffe097          	auipc	ra,0xffffe
    8000390a:	d8e080e7          	jalr	-626(ra) # 80001694 <wakeup>
  release(&lk->lk);
    8000390e:	854a                	mv	a0,s2
    80003910:	00003097          	auipc	ra,0x3
    80003914:	94c080e7          	jalr	-1716(ra) # 8000625c <release>
}
    80003918:	60e2                	ld	ra,24(sp)
    8000391a:	6442                	ld	s0,16(sp)
    8000391c:	64a2                	ld	s1,8(sp)
    8000391e:	6902                	ld	s2,0(sp)
    80003920:	6105                	addi	sp,sp,32
    80003922:	8082                	ret

0000000080003924 <holdingsleep>:

int
holdingsleep(struct sleeplock *lk)
{
    80003924:	7179                	addi	sp,sp,-48
    80003926:	f406                	sd	ra,40(sp)
    80003928:	f022                	sd	s0,32(sp)
    8000392a:	ec26                	sd	s1,24(sp)
    8000392c:	e84a                	sd	s2,16(sp)
    8000392e:	e44e                	sd	s3,8(sp)
    80003930:	1800                	addi	s0,sp,48
    80003932:	84aa                	mv	s1,a0
  int r;
  
  acquire(&lk->lk);
    80003934:	00850913          	addi	s2,a0,8
    80003938:	854a                	mv	a0,s2
    8000393a:	00003097          	auipc	ra,0x3
    8000393e:	86e080e7          	jalr	-1938(ra) # 800061a8 <acquire>
  r = lk->locked && (lk->pid == myproc()->pid);
    80003942:	409c                	lw	a5,0(s1)
    80003944:	ef99                	bnez	a5,80003962 <holdingsleep+0x3e>
    80003946:	4481                	li	s1,0
  release(&lk->lk);
    80003948:	854a                	mv	a0,s2
    8000394a:	00003097          	auipc	ra,0x3
    8000394e:	912080e7          	jalr	-1774(ra) # 8000625c <release>
  return r;
}
    80003952:	8526                	mv	a0,s1
    80003954:	70a2                	ld	ra,40(sp)
    80003956:	7402                	ld	s0,32(sp)
    80003958:	64e2                	ld	s1,24(sp)
    8000395a:	6942                	ld	s2,16(sp)
    8000395c:	69a2                	ld	s3,8(sp)
    8000395e:	6145                	addi	sp,sp,48
    80003960:	8082                	ret
  r = lk->locked && (lk->pid == myproc()->pid);
    80003962:	0284a983          	lw	s3,40(s1)
    80003966:	ffffd097          	auipc	ra,0xffffd
    8000396a:	4de080e7          	jalr	1246(ra) # 80000e44 <myproc>
    8000396e:	5904                	lw	s1,48(a0)
    80003970:	413484b3          	sub	s1,s1,s3
    80003974:	0014b493          	seqz	s1,s1
    80003978:	bfc1                	j	80003948 <holdingsleep+0x24>

000000008000397a <fileinit>:
  struct file file[NFILE];
} ftable;

void
fileinit(void)
{
    8000397a:	1141                	addi	sp,sp,-16
    8000397c:	e406                	sd	ra,8(sp)
    8000397e:	e022                	sd	s0,0(sp)
    80003980:	0800                	addi	s0,sp,16
  initlock(&ftable.lock, "ftable");
    80003982:	00005597          	auipc	a1,0x5
    80003986:	d1658593          	addi	a1,a1,-746 # 80008698 <syscalls+0x2d0>
    8000398a:	0001d517          	auipc	a0,0x1d
    8000398e:	25e50513          	addi	a0,a0,606 # 80020be8 <ftable>
    80003992:	00002097          	auipc	ra,0x2
    80003996:	786080e7          	jalr	1926(ra) # 80006118 <initlock>
}
    8000399a:	60a2                	ld	ra,8(sp)
    8000399c:	6402                	ld	s0,0(sp)
    8000399e:	0141                	addi	sp,sp,16
    800039a0:	8082                	ret

00000000800039a2 <filealloc>:

// Allocate a file structure.
struct file*
filealloc(void)
{
    800039a2:	1101                	addi	sp,sp,-32
    800039a4:	ec06                	sd	ra,24(sp)
    800039a6:	e822                	sd	s0,16(sp)
    800039a8:	e426                	sd	s1,8(sp)
    800039aa:	1000                	addi	s0,sp,32
  struct file *f;

  acquire(&ftable.lock);
    800039ac:	0001d517          	auipc	a0,0x1d
    800039b0:	23c50513          	addi	a0,a0,572 # 80020be8 <ftable>
    800039b4:	00002097          	auipc	ra,0x2
    800039b8:	7f4080e7          	jalr	2036(ra) # 800061a8 <acquire>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800039bc:	0001d497          	auipc	s1,0x1d
    800039c0:	24448493          	addi	s1,s1,580 # 80020c00 <ftable+0x18>
    800039c4:	0001e717          	auipc	a4,0x1e
    800039c8:	1dc70713          	addi	a4,a4,476 # 80021ba0 <ftable+0xfb8>
    if(f->ref == 0){
    800039cc:	40dc                	lw	a5,4(s1)
    800039ce:	cf99                	beqz	a5,800039ec <filealloc+0x4a>
  for(f = ftable.file; f < ftable.file + NFILE; f++){
    800039d0:	02848493          	addi	s1,s1,40
    800039d4:	fee49ce3          	bne	s1,a4,800039cc <filealloc+0x2a>
      f->ref = 1;
      release(&ftable.lock);
      return f;
    }
  }
  release(&ftable.lock);
    800039d8:	0001d517          	auipc	a0,0x1d
    800039dc:	21050513          	addi	a0,a0,528 # 80020be8 <ftable>
    800039e0:	00003097          	auipc	ra,0x3
    800039e4:	87c080e7          	jalr	-1924(ra) # 8000625c <release>
  return 0;
    800039e8:	4481                	li	s1,0
    800039ea:	a819                	j	80003a00 <filealloc+0x5e>
      f->ref = 1;
    800039ec:	4785                	li	a5,1
    800039ee:	c0dc                	sw	a5,4(s1)
      release(&ftable.lock);
    800039f0:	0001d517          	auipc	a0,0x1d
    800039f4:	1f850513          	addi	a0,a0,504 # 80020be8 <ftable>
    800039f8:	00003097          	auipc	ra,0x3
    800039fc:	864080e7          	jalr	-1948(ra) # 8000625c <release>
}
    80003a00:	8526                	mv	a0,s1
    80003a02:	60e2                	ld	ra,24(sp)
    80003a04:	6442                	ld	s0,16(sp)
    80003a06:	64a2                	ld	s1,8(sp)
    80003a08:	6105                	addi	sp,sp,32
    80003a0a:	8082                	ret

0000000080003a0c <filedup>:

// Increment ref count for file f.
struct file*
filedup(struct file *f)
{
    80003a0c:	1101                	addi	sp,sp,-32
    80003a0e:	ec06                	sd	ra,24(sp)
    80003a10:	e822                	sd	s0,16(sp)
    80003a12:	e426                	sd	s1,8(sp)
    80003a14:	1000                	addi	s0,sp,32
    80003a16:	84aa                	mv	s1,a0
  acquire(&ftable.lock);
    80003a18:	0001d517          	auipc	a0,0x1d
    80003a1c:	1d050513          	addi	a0,a0,464 # 80020be8 <ftable>
    80003a20:	00002097          	auipc	ra,0x2
    80003a24:	788080e7          	jalr	1928(ra) # 800061a8 <acquire>
  if(f->ref < 1)
    80003a28:	40dc                	lw	a5,4(s1)
    80003a2a:	02f05263          	blez	a5,80003a4e <filedup+0x42>
    panic("filedup");
  f->ref++;
    80003a2e:	2785                	addiw	a5,a5,1
    80003a30:	c0dc                	sw	a5,4(s1)
  release(&ftable.lock);
    80003a32:	0001d517          	auipc	a0,0x1d
    80003a36:	1b650513          	addi	a0,a0,438 # 80020be8 <ftable>
    80003a3a:	00003097          	auipc	ra,0x3
    80003a3e:	822080e7          	jalr	-2014(ra) # 8000625c <release>
  return f;
}
    80003a42:	8526                	mv	a0,s1
    80003a44:	60e2                	ld	ra,24(sp)
    80003a46:	6442                	ld	s0,16(sp)
    80003a48:	64a2                	ld	s1,8(sp)
    80003a4a:	6105                	addi	sp,sp,32
    80003a4c:	8082                	ret
    panic("filedup");
    80003a4e:	00005517          	auipc	a0,0x5
    80003a52:	c5250513          	addi	a0,a0,-942 # 800086a0 <syscalls+0x2d8>
    80003a56:	00002097          	auipc	ra,0x2
    80003a5a:	21a080e7          	jalr	538(ra) # 80005c70 <panic>

0000000080003a5e <fileclose>:

// Close file f.  (Decrement ref count, close when reaches 0.)
void
fileclose(struct file *f)
{
    80003a5e:	7139                	addi	sp,sp,-64
    80003a60:	fc06                	sd	ra,56(sp)
    80003a62:	f822                	sd	s0,48(sp)
    80003a64:	f426                	sd	s1,40(sp)
    80003a66:	f04a                	sd	s2,32(sp)
    80003a68:	ec4e                	sd	s3,24(sp)
    80003a6a:	e852                	sd	s4,16(sp)
    80003a6c:	e456                	sd	s5,8(sp)
    80003a6e:	0080                	addi	s0,sp,64
    80003a70:	84aa                	mv	s1,a0
  struct file ff;

  acquire(&ftable.lock);
    80003a72:	0001d517          	auipc	a0,0x1d
    80003a76:	17650513          	addi	a0,a0,374 # 80020be8 <ftable>
    80003a7a:	00002097          	auipc	ra,0x2
    80003a7e:	72e080e7          	jalr	1838(ra) # 800061a8 <acquire>
  if(f->ref < 1)
    80003a82:	40dc                	lw	a5,4(s1)
    80003a84:	06f05163          	blez	a5,80003ae6 <fileclose+0x88>
    panic("fileclose");
  if(--f->ref > 0){
    80003a88:	37fd                	addiw	a5,a5,-1
    80003a8a:	0007871b          	sext.w	a4,a5
    80003a8e:	c0dc                	sw	a5,4(s1)
    80003a90:	06e04363          	bgtz	a4,80003af6 <fileclose+0x98>
    release(&ftable.lock);
    return;
  }
  ff = *f;
    80003a94:	0004a903          	lw	s2,0(s1)
    80003a98:	0094ca83          	lbu	s5,9(s1)
    80003a9c:	0104ba03          	ld	s4,16(s1)
    80003aa0:	0184b983          	ld	s3,24(s1)
  f->ref = 0;
    80003aa4:	0004a223          	sw	zero,4(s1)
  f->type = FD_NONE;
    80003aa8:	0004a023          	sw	zero,0(s1)
  release(&ftable.lock);
    80003aac:	0001d517          	auipc	a0,0x1d
    80003ab0:	13c50513          	addi	a0,a0,316 # 80020be8 <ftable>
    80003ab4:	00002097          	auipc	ra,0x2
    80003ab8:	7a8080e7          	jalr	1960(ra) # 8000625c <release>

  if(ff.type == FD_PIPE){
    80003abc:	4785                	li	a5,1
    80003abe:	04f90d63          	beq	s2,a5,80003b18 <fileclose+0xba>
    pipeclose(ff.pipe, ff.writable);
  } else if(ff.type == FD_INODE || ff.type == FD_DEVICE){
    80003ac2:	3979                	addiw	s2,s2,-2
    80003ac4:	4785                	li	a5,1
    80003ac6:	0527e063          	bltu	a5,s2,80003b06 <fileclose+0xa8>
    begin_op();
    80003aca:	00000097          	auipc	ra,0x0
    80003ace:	acc080e7          	jalr	-1332(ra) # 80003596 <begin_op>
    iput(ff.ip);
    80003ad2:	854e                	mv	a0,s3
    80003ad4:	fffff097          	auipc	ra,0xfffff
    80003ad8:	268080e7          	jalr	616(ra) # 80002d3c <iput>
    end_op();
    80003adc:	00000097          	auipc	ra,0x0
    80003ae0:	b38080e7          	jalr	-1224(ra) # 80003614 <end_op>
    80003ae4:	a00d                	j	80003b06 <fileclose+0xa8>
    panic("fileclose");
    80003ae6:	00005517          	auipc	a0,0x5
    80003aea:	bc250513          	addi	a0,a0,-1086 # 800086a8 <syscalls+0x2e0>
    80003aee:	00002097          	auipc	ra,0x2
    80003af2:	182080e7          	jalr	386(ra) # 80005c70 <panic>
    release(&ftable.lock);
    80003af6:	0001d517          	auipc	a0,0x1d
    80003afa:	0f250513          	addi	a0,a0,242 # 80020be8 <ftable>
    80003afe:	00002097          	auipc	ra,0x2
    80003b02:	75e080e7          	jalr	1886(ra) # 8000625c <release>
  }
}
    80003b06:	70e2                	ld	ra,56(sp)
    80003b08:	7442                	ld	s0,48(sp)
    80003b0a:	74a2                	ld	s1,40(sp)
    80003b0c:	7902                	ld	s2,32(sp)
    80003b0e:	69e2                	ld	s3,24(sp)
    80003b10:	6a42                	ld	s4,16(sp)
    80003b12:	6aa2                	ld	s5,8(sp)
    80003b14:	6121                	addi	sp,sp,64
    80003b16:	8082                	ret
    pipeclose(ff.pipe, ff.writable);
    80003b18:	85d6                	mv	a1,s5
    80003b1a:	8552                	mv	a0,s4
    80003b1c:	00000097          	auipc	ra,0x0
    80003b20:	38e080e7          	jalr	910(ra) # 80003eaa <pipeclose>
    80003b24:	b7cd                	j	80003b06 <fileclose+0xa8>

0000000080003b26 <filestat>:

// Get metadata about file f.
// addr is a user virtual address, pointing to a struct stat.
int
filestat(struct file *f, uint64 addr)
{
    80003b26:	715d                	addi	sp,sp,-80
    80003b28:	e486                	sd	ra,72(sp)
    80003b2a:	e0a2                	sd	s0,64(sp)
    80003b2c:	fc26                	sd	s1,56(sp)
    80003b2e:	f84a                	sd	s2,48(sp)
    80003b30:	f44e                	sd	s3,40(sp)
    80003b32:	0880                	addi	s0,sp,80
    80003b34:	84aa                	mv	s1,a0
    80003b36:	89ae                	mv	s3,a1
  struct proc *p = myproc();
    80003b38:	ffffd097          	auipc	ra,0xffffd
    80003b3c:	30c080e7          	jalr	780(ra) # 80000e44 <myproc>
  struct stat st;
  
  if(f->type == FD_INODE || f->type == FD_DEVICE){
    80003b40:	409c                	lw	a5,0(s1)
    80003b42:	37f9                	addiw	a5,a5,-2
    80003b44:	4705                	li	a4,1
    80003b46:	04f76763          	bltu	a4,a5,80003b94 <filestat+0x6e>
    80003b4a:	892a                	mv	s2,a0
    ilock(f->ip);
    80003b4c:	6c88                	ld	a0,24(s1)
    80003b4e:	fffff097          	auipc	ra,0xfffff
    80003b52:	fe8080e7          	jalr	-24(ra) # 80002b36 <ilock>
    stati(f->ip, &st);
    80003b56:	fb840593          	addi	a1,s0,-72
    80003b5a:	6c88                	ld	a0,24(s1)
    80003b5c:	fffff097          	auipc	ra,0xfffff
    80003b60:	2b0080e7          	jalr	688(ra) # 80002e0c <stati>
    iunlock(f->ip);
    80003b64:	6c88                	ld	a0,24(s1)
    80003b66:	fffff097          	auipc	ra,0xfffff
    80003b6a:	092080e7          	jalr	146(ra) # 80002bf8 <iunlock>
    if(copyout(p->pagetable, addr, (char *)&st, sizeof(st)) < 0)
    80003b6e:	46e1                	li	a3,24
    80003b70:	fb840613          	addi	a2,s0,-72
    80003b74:	85ce                	mv	a1,s3
    80003b76:	05093503          	ld	a0,80(s2)
    80003b7a:	ffffd097          	auipc	ra,0xffffd
    80003b7e:	f8e080e7          	jalr	-114(ra) # 80000b08 <copyout>
    80003b82:	41f5551b          	sraiw	a0,a0,0x1f
      return -1;
    return 0;
  }
  return -1;
}
    80003b86:	60a6                	ld	ra,72(sp)
    80003b88:	6406                	ld	s0,64(sp)
    80003b8a:	74e2                	ld	s1,56(sp)
    80003b8c:	7942                	ld	s2,48(sp)
    80003b8e:	79a2                	ld	s3,40(sp)
    80003b90:	6161                	addi	sp,sp,80
    80003b92:	8082                	ret
  return -1;
    80003b94:	557d                	li	a0,-1
    80003b96:	bfc5                	j	80003b86 <filestat+0x60>

0000000080003b98 <fileread>:

// Read from file f.
// addr is a user virtual address.
int
fileread(struct file *f, uint64 addr, int n)
{
    80003b98:	7179                	addi	sp,sp,-48
    80003b9a:	f406                	sd	ra,40(sp)
    80003b9c:	f022                	sd	s0,32(sp)
    80003b9e:	ec26                	sd	s1,24(sp)
    80003ba0:	e84a                	sd	s2,16(sp)
    80003ba2:	e44e                	sd	s3,8(sp)
    80003ba4:	1800                	addi	s0,sp,48
  int r = 0;

  if(f->readable == 0)
    80003ba6:	00854783          	lbu	a5,8(a0)
    80003baa:	c3d5                	beqz	a5,80003c4e <fileread+0xb6>
    80003bac:	84aa                	mv	s1,a0
    80003bae:	89ae                	mv	s3,a1
    80003bb0:	8932                	mv	s2,a2
    return -1;

  if(f->type == FD_PIPE){
    80003bb2:	411c                	lw	a5,0(a0)
    80003bb4:	4705                	li	a4,1
    80003bb6:	04e78963          	beq	a5,a4,80003c08 <fileread+0x70>
    r = piperead(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003bba:	470d                	li	a4,3
    80003bbc:	04e78d63          	beq	a5,a4,80003c16 <fileread+0x7e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
      return -1;
    r = devsw[f->major].read(1, addr, n);
  } else if(f->type == FD_INODE){
    80003bc0:	4709                	li	a4,2
    80003bc2:	06e79e63          	bne	a5,a4,80003c3e <fileread+0xa6>
    ilock(f->ip);
    80003bc6:	6d08                	ld	a0,24(a0)
    80003bc8:	fffff097          	auipc	ra,0xfffff
    80003bcc:	f6e080e7          	jalr	-146(ra) # 80002b36 <ilock>
    if((r = readi(f->ip, 1, addr, f->off, n)) > 0)
    80003bd0:	874a                	mv	a4,s2
    80003bd2:	5094                	lw	a3,32(s1)
    80003bd4:	864e                	mv	a2,s3
    80003bd6:	4585                	li	a1,1
    80003bd8:	6c88                	ld	a0,24(s1)
    80003bda:	fffff097          	auipc	ra,0xfffff
    80003bde:	25c080e7          	jalr	604(ra) # 80002e36 <readi>
    80003be2:	892a                	mv	s2,a0
    80003be4:	00a05563          	blez	a0,80003bee <fileread+0x56>
      f->off += r;
    80003be8:	509c                	lw	a5,32(s1)
    80003bea:	9fa9                	addw	a5,a5,a0
    80003bec:	d09c                	sw	a5,32(s1)
    iunlock(f->ip);
    80003bee:	6c88                	ld	a0,24(s1)
    80003bf0:	fffff097          	auipc	ra,0xfffff
    80003bf4:	008080e7          	jalr	8(ra) # 80002bf8 <iunlock>
  } else {
    panic("fileread");
  }

  return r;
}
    80003bf8:	854a                	mv	a0,s2
    80003bfa:	70a2                	ld	ra,40(sp)
    80003bfc:	7402                	ld	s0,32(sp)
    80003bfe:	64e2                	ld	s1,24(sp)
    80003c00:	6942                	ld	s2,16(sp)
    80003c02:	69a2                	ld	s3,8(sp)
    80003c04:	6145                	addi	sp,sp,48
    80003c06:	8082                	ret
    r = piperead(f->pipe, addr, n);
    80003c08:	6908                	ld	a0,16(a0)
    80003c0a:	00000097          	auipc	ra,0x0
    80003c0e:	402080e7          	jalr	1026(ra) # 8000400c <piperead>
    80003c12:	892a                	mv	s2,a0
    80003c14:	b7d5                	j	80003bf8 <fileread+0x60>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].read)
    80003c16:	02451783          	lh	a5,36(a0)
    80003c1a:	03079693          	slli	a3,a5,0x30
    80003c1e:	92c1                	srli	a3,a3,0x30
    80003c20:	4725                	li	a4,9
    80003c22:	02d76863          	bltu	a4,a3,80003c52 <fileread+0xba>
    80003c26:	0792                	slli	a5,a5,0x4
    80003c28:	0001d717          	auipc	a4,0x1d
    80003c2c:	f2070713          	addi	a4,a4,-224 # 80020b48 <devsw>
    80003c30:	97ba                	add	a5,a5,a4
    80003c32:	639c                	ld	a5,0(a5)
    80003c34:	c38d                	beqz	a5,80003c56 <fileread+0xbe>
    r = devsw[f->major].read(1, addr, n);
    80003c36:	4505                	li	a0,1
    80003c38:	9782                	jalr	a5
    80003c3a:	892a                	mv	s2,a0
    80003c3c:	bf75                	j	80003bf8 <fileread+0x60>
    panic("fileread");
    80003c3e:	00005517          	auipc	a0,0x5
    80003c42:	a7a50513          	addi	a0,a0,-1414 # 800086b8 <syscalls+0x2f0>
    80003c46:	00002097          	auipc	ra,0x2
    80003c4a:	02a080e7          	jalr	42(ra) # 80005c70 <panic>
    return -1;
    80003c4e:	597d                	li	s2,-1
    80003c50:	b765                	j	80003bf8 <fileread+0x60>
      return -1;
    80003c52:	597d                	li	s2,-1
    80003c54:	b755                	j	80003bf8 <fileread+0x60>
    80003c56:	597d                	li	s2,-1
    80003c58:	b745                	j	80003bf8 <fileread+0x60>

0000000080003c5a <filewrite>:

// Write to file f.
// addr is a user virtual address.
int
filewrite(struct file *f, uint64 addr, int n)
{
    80003c5a:	715d                	addi	sp,sp,-80
    80003c5c:	e486                	sd	ra,72(sp)
    80003c5e:	e0a2                	sd	s0,64(sp)
    80003c60:	fc26                	sd	s1,56(sp)
    80003c62:	f84a                	sd	s2,48(sp)
    80003c64:	f44e                	sd	s3,40(sp)
    80003c66:	f052                	sd	s4,32(sp)
    80003c68:	ec56                	sd	s5,24(sp)
    80003c6a:	e85a                	sd	s6,16(sp)
    80003c6c:	e45e                	sd	s7,8(sp)
    80003c6e:	e062                	sd	s8,0(sp)
    80003c70:	0880                	addi	s0,sp,80
  int r, ret = 0;
  if(f->writable == 0) {
    80003c72:	00954783          	lbu	a5,9(a0)
    80003c76:	cb85                	beqz	a5,80003ca6 <filewrite+0x4c>
    80003c78:	892a                	mv	s2,a0
    80003c7a:	8b2e                	mv	s6,a1
    80003c7c:	8a32                	mv	s4,a2
    printf("Error: File is not writable\n");
    return -1;
  }

  if(f->type == FD_PIPE){
    80003c7e:	411c                	lw	a5,0(a0)
    80003c80:	4705                	li	a4,1
    80003c82:	02e78c63          	beq	a5,a4,80003cba <filewrite+0x60>
    ret = pipewrite(f->pipe, addr, n);
  } else if(f->type == FD_DEVICE){
    80003c86:	470d                	li	a4,3
    80003c88:	04e78063          	beq	a5,a4,80003cc8 <filewrite+0x6e>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write) {
      printf("Error: Invalid device major number or write function not available\n");
      return -1;
    }
    ret = devsw[f->major].write(1, addr, n);
  } else if(f->type == FD_INODE){
    80003c8c:	4709                	li	a4,2
    80003c8e:	12e79163          	bne	a5,a4,80003db0 <filewrite+0x156>
    int max = ((MAXOPBLOCKS-1-1-2) / 2) * BSIZE;
    int i = 0;
    while(i < n){
    80003c92:	10c05b63          	blez	a2,80003da8 <filewrite+0x14e>
    int i = 0;
    80003c96:	4981                	li	s3,0
    80003c98:	6b85                	lui	s7,0x1
    80003c9a:	c00b8b93          	addi	s7,s7,-1024 # c00 <_entry-0x7ffff400>
    80003c9e:	6c05                	lui	s8,0x1
    80003ca0:	c00c0c1b          	addiw	s8,s8,-1024 # c00 <_entry-0x7ffff400>
    80003ca4:	a0c1                	j	80003d64 <filewrite+0x10a>
    printf("Error: File is not writable\n");
    80003ca6:	00005517          	auipc	a0,0x5
    80003caa:	a2250513          	addi	a0,a0,-1502 # 800086c8 <syscalls+0x300>
    80003cae:	00002097          	auipc	ra,0x2
    80003cb2:	00c080e7          	jalr	12(ra) # 80005cba <printf>
    return -1;
    80003cb6:	5a7d                	li	s4,-1
    80003cb8:	a8d9                	j	80003d8e <filewrite+0x134>
    ret = pipewrite(f->pipe, addr, n);
    80003cba:	6908                	ld	a0,16(a0)
    80003cbc:	00000097          	auipc	ra,0x0
    80003cc0:	25e080e7          	jalr	606(ra) # 80003f1a <pipewrite>
    80003cc4:	8a2a                	mv	s4,a0
    80003cc6:	a0e1                	j	80003d8e <filewrite+0x134>
    if(f->major < 0 || f->major >= NDEV || !devsw[f->major].write) {
    80003cc8:	02451783          	lh	a5,36(a0)
    80003ccc:	03079693          	slli	a3,a5,0x30
    80003cd0:	92c1                	srli	a3,a3,0x30
    80003cd2:	4725                	li	a4,9
    80003cd4:	00d76e63          	bltu	a4,a3,80003cf0 <filewrite+0x96>
    80003cd8:	0792                	slli	a5,a5,0x4
    80003cda:	0001d717          	auipc	a4,0x1d
    80003cde:	e6e70713          	addi	a4,a4,-402 # 80020b48 <devsw>
    80003ce2:	97ba                	add	a5,a5,a4
    80003ce4:	679c                	ld	a5,8(a5)
    80003ce6:	c789                	beqz	a5,80003cf0 <filewrite+0x96>
    ret = devsw[f->major].write(1, addr, n);
    80003ce8:	4505                	li	a0,1
    80003cea:	9782                	jalr	a5
    80003cec:	8a2a                	mv	s4,a0
    80003cee:	a045                	j	80003d8e <filewrite+0x134>
      printf("Error: Invalid device major number or write function not available\n");
    80003cf0:	00005517          	auipc	a0,0x5
    80003cf4:	9f850513          	addi	a0,a0,-1544 # 800086e8 <syscalls+0x320>
    80003cf8:	00002097          	auipc	ra,0x2
    80003cfc:	fc2080e7          	jalr	-62(ra) # 80005cba <printf>
      return -1;
    80003d00:	5a7d                	li	s4,-1
    80003d02:	a071                	j	80003d8e <filewrite+0x134>
    80003d04:	00048a9b          	sext.w	s5,s1
      int n1 = n - i;
      if(n1 > max)
        n1 = max;

      begin_op();
    80003d08:	00000097          	auipc	ra,0x0
    80003d0c:	88e080e7          	jalr	-1906(ra) # 80003596 <begin_op>
      ilock(f->ip);
    80003d10:	01893503          	ld	a0,24(s2)
    80003d14:	fffff097          	auipc	ra,0xfffff
    80003d18:	e22080e7          	jalr	-478(ra) # 80002b36 <ilock>
      if ((r = writei(f->ip, 1, addr + i, f->off, n1)) > 0)
    80003d1c:	8756                	mv	a4,s5
    80003d1e:	02092683          	lw	a3,32(s2)
    80003d22:	01698633          	add	a2,s3,s6
    80003d26:	4585                	li	a1,1
    80003d28:	01893503          	ld	a0,24(s2)
    80003d2c:	fffff097          	auipc	ra,0xfffff
    80003d30:	202080e7          	jalr	514(ra) # 80002f2e <writei>
    80003d34:	84aa                	mv	s1,a0
    80003d36:	00a05763          	blez	a0,80003d44 <filewrite+0xea>
        f->off += r;
    80003d3a:	02092783          	lw	a5,32(s2)
    80003d3e:	9fa9                	addw	a5,a5,a0
    80003d40:	02f92023          	sw	a5,32(s2)
      iunlock(f->ip);
    80003d44:	01893503          	ld	a0,24(s2)
    80003d48:	fffff097          	auipc	ra,0xfffff
    80003d4c:	eb0080e7          	jalr	-336(ra) # 80002bf8 <iunlock>
      end_op();
    80003d50:	00000097          	auipc	ra,0x0
    80003d54:	8c4080e7          	jalr	-1852(ra) # 80003614 <end_op>

      if(r != n1){
    80003d58:	009a9e63          	bne	s5,s1,80003d74 <filewrite+0x11a>
        // error from writei
        printf("Error: Failed to write to inode at block %d, expected %d bytes, wrote %d bytes\n", i, n1, r);
        break;
      }
      i += r;
    80003d5c:	013489bb          	addw	s3,s1,s3
    while(i < n){
    80003d60:	0349d563          	bge	s3,s4,80003d8a <filewrite+0x130>
      int n1 = n - i;
    80003d64:	413a04bb          	subw	s1,s4,s3
    80003d68:	0004879b          	sext.w	a5,s1
    80003d6c:	f8fbdce3          	bge	s7,a5,80003d04 <filewrite+0xaa>
    80003d70:	84e2                	mv	s1,s8
    80003d72:	bf49                	j	80003d04 <filewrite+0xaa>
        printf("Error: Failed to write to inode at block %d, expected %d bytes, wrote %d bytes\n", i, n1, r);
    80003d74:	86a6                	mv	a3,s1
    80003d76:	8656                	mv	a2,s5
    80003d78:	85ce                	mv	a1,s3
    80003d7a:	00005517          	auipc	a0,0x5
    80003d7e:	9b650513          	addi	a0,a0,-1610 # 80008730 <syscalls+0x368>
    80003d82:	00002097          	auipc	ra,0x2
    80003d86:	f38080e7          	jalr	-200(ra) # 80005cba <printf>
    }
    ret = (i == n ? n : -1);
    80003d8a:	033a1163          	bne	s4,s3,80003dac <filewrite+0x152>
    printf("Error: Unknown file type\n");
    panic("filewrite");
  }

  return ret;
    80003d8e:	8552                	mv	a0,s4
    80003d90:	60a6                	ld	ra,72(sp)
    80003d92:	6406                	ld	s0,64(sp)
    80003d94:	74e2                	ld	s1,56(sp)
    80003d96:	7942                	ld	s2,48(sp)
    80003d98:	79a2                	ld	s3,40(sp)
    80003d9a:	7a02                	ld	s4,32(sp)
    80003d9c:	6ae2                	ld	s5,24(sp)
    80003d9e:	6b42                	ld	s6,16(sp)
    80003da0:	6ba2                	ld	s7,8(sp)
    80003da2:	6c02                	ld	s8,0(sp)
    80003da4:	6161                	addi	sp,sp,80
    80003da6:	8082                	ret
    int i = 0;
    80003da8:	4981                	li	s3,0
    80003daa:	b7c5                	j	80003d8a <filewrite+0x130>
    ret = (i == n ? n : -1);
    80003dac:	5a7d                	li	s4,-1
    80003dae:	b7c5                	j	80003d8e <filewrite+0x134>
    printf("Error: Unknown file type\n");
    80003db0:	00005517          	auipc	a0,0x5
    80003db4:	9d050513          	addi	a0,a0,-1584 # 80008780 <syscalls+0x3b8>
    80003db8:	00002097          	auipc	ra,0x2
    80003dbc:	f02080e7          	jalr	-254(ra) # 80005cba <printf>
    panic("filewrite");
    80003dc0:	00005517          	auipc	a0,0x5
    80003dc4:	9e050513          	addi	a0,a0,-1568 # 800087a0 <syscalls+0x3d8>
    80003dc8:	00002097          	auipc	ra,0x2
    80003dcc:	ea8080e7          	jalr	-344(ra) # 80005c70 <panic>

0000000080003dd0 <pipealloc>:
  int writeopen;  // write fd is still open
};

int
pipealloc(struct file **f0, struct file **f1)
{
    80003dd0:	7179                	addi	sp,sp,-48
    80003dd2:	f406                	sd	ra,40(sp)
    80003dd4:	f022                	sd	s0,32(sp)
    80003dd6:	ec26                	sd	s1,24(sp)
    80003dd8:	e84a                	sd	s2,16(sp)
    80003dda:	e44e                	sd	s3,8(sp)
    80003ddc:	e052                	sd	s4,0(sp)
    80003dde:	1800                	addi	s0,sp,48
    80003de0:	84aa                	mv	s1,a0
    80003de2:	8a2e                	mv	s4,a1
  struct pipe *pi;

  pi = 0;
  *f0 = *f1 = 0;
    80003de4:	0005b023          	sd	zero,0(a1)
    80003de8:	00053023          	sd	zero,0(a0)
  if((*f0 = filealloc()) == 0 || (*f1 = filealloc()) == 0)
    80003dec:	00000097          	auipc	ra,0x0
    80003df0:	bb6080e7          	jalr	-1098(ra) # 800039a2 <filealloc>
    80003df4:	e088                	sd	a0,0(s1)
    80003df6:	c551                	beqz	a0,80003e82 <pipealloc+0xb2>
    80003df8:	00000097          	auipc	ra,0x0
    80003dfc:	baa080e7          	jalr	-1110(ra) # 800039a2 <filealloc>
    80003e00:	00aa3023          	sd	a0,0(s4)
    80003e04:	c92d                	beqz	a0,80003e76 <pipealloc+0xa6>
    goto bad;
  if((pi = (struct pipe*)kalloc()) == 0)
    80003e06:	ffffc097          	auipc	ra,0xffffc
    80003e0a:	314080e7          	jalr	788(ra) # 8000011a <kalloc>
    80003e0e:	892a                	mv	s2,a0
    80003e10:	c125                	beqz	a0,80003e70 <pipealloc+0xa0>
    goto bad;
  pi->readopen = 1;
    80003e12:	4985                	li	s3,1
    80003e14:	23352023          	sw	s3,544(a0)
  pi->writeopen = 1;
    80003e18:	23352223          	sw	s3,548(a0)
  pi->nwrite = 0;
    80003e1c:	20052e23          	sw	zero,540(a0)
  pi->nread = 0;
    80003e20:	20052c23          	sw	zero,536(a0)
  initlock(&pi->lock, "pipe");
    80003e24:	00005597          	auipc	a1,0x5
    80003e28:	98c58593          	addi	a1,a1,-1652 # 800087b0 <syscalls+0x3e8>
    80003e2c:	00002097          	auipc	ra,0x2
    80003e30:	2ec080e7          	jalr	748(ra) # 80006118 <initlock>
  (*f0)->type = FD_PIPE;
    80003e34:	609c                	ld	a5,0(s1)
    80003e36:	0137a023          	sw	s3,0(a5)
  (*f0)->readable = 1;
    80003e3a:	609c                	ld	a5,0(s1)
    80003e3c:	01378423          	sb	s3,8(a5)
  (*f0)->writable = 0;
    80003e40:	609c                	ld	a5,0(s1)
    80003e42:	000784a3          	sb	zero,9(a5)
  (*f0)->pipe = pi;
    80003e46:	609c                	ld	a5,0(s1)
    80003e48:	0127b823          	sd	s2,16(a5)
  (*f1)->type = FD_PIPE;
    80003e4c:	000a3783          	ld	a5,0(s4)
    80003e50:	0137a023          	sw	s3,0(a5)
  (*f1)->readable = 0;
    80003e54:	000a3783          	ld	a5,0(s4)
    80003e58:	00078423          	sb	zero,8(a5)
  (*f1)->writable = 1;
    80003e5c:	000a3783          	ld	a5,0(s4)
    80003e60:	013784a3          	sb	s3,9(a5)
  (*f1)->pipe = pi;
    80003e64:	000a3783          	ld	a5,0(s4)
    80003e68:	0127b823          	sd	s2,16(a5)
  return 0;
    80003e6c:	4501                	li	a0,0
    80003e6e:	a025                	j	80003e96 <pipealloc+0xc6>

 bad:
  if(pi)
    kfree((char*)pi);
  if(*f0)
    80003e70:	6088                	ld	a0,0(s1)
    80003e72:	e501                	bnez	a0,80003e7a <pipealloc+0xaa>
    80003e74:	a039                	j	80003e82 <pipealloc+0xb2>
    80003e76:	6088                	ld	a0,0(s1)
    80003e78:	c51d                	beqz	a0,80003ea6 <pipealloc+0xd6>
    fileclose(*f0);
    80003e7a:	00000097          	auipc	ra,0x0
    80003e7e:	be4080e7          	jalr	-1052(ra) # 80003a5e <fileclose>
  if(*f1)
    80003e82:	000a3783          	ld	a5,0(s4)
    fileclose(*f1);
  return -1;
    80003e86:	557d                	li	a0,-1
  if(*f1)
    80003e88:	c799                	beqz	a5,80003e96 <pipealloc+0xc6>
    fileclose(*f1);
    80003e8a:	853e                	mv	a0,a5
    80003e8c:	00000097          	auipc	ra,0x0
    80003e90:	bd2080e7          	jalr	-1070(ra) # 80003a5e <fileclose>
  return -1;
    80003e94:	557d                	li	a0,-1
}
    80003e96:	70a2                	ld	ra,40(sp)
    80003e98:	7402                	ld	s0,32(sp)
    80003e9a:	64e2                	ld	s1,24(sp)
    80003e9c:	6942                	ld	s2,16(sp)
    80003e9e:	69a2                	ld	s3,8(sp)
    80003ea0:	6a02                	ld	s4,0(sp)
    80003ea2:	6145                	addi	sp,sp,48
    80003ea4:	8082                	ret
  return -1;
    80003ea6:	557d                	li	a0,-1
    80003ea8:	b7fd                	j	80003e96 <pipealloc+0xc6>

0000000080003eaa <pipeclose>:

void
pipeclose(struct pipe *pi, int writable)
{
    80003eaa:	1101                	addi	sp,sp,-32
    80003eac:	ec06                	sd	ra,24(sp)
    80003eae:	e822                	sd	s0,16(sp)
    80003eb0:	e426                	sd	s1,8(sp)
    80003eb2:	e04a                	sd	s2,0(sp)
    80003eb4:	1000                	addi	s0,sp,32
    80003eb6:	84aa                	mv	s1,a0
    80003eb8:	892e                	mv	s2,a1
  acquire(&pi->lock);
    80003eba:	00002097          	auipc	ra,0x2
    80003ebe:	2ee080e7          	jalr	750(ra) # 800061a8 <acquire>
  if(writable){
    80003ec2:	02090d63          	beqz	s2,80003efc <pipeclose+0x52>
    pi->writeopen = 0;
    80003ec6:	2204a223          	sw	zero,548(s1)
    wakeup(&pi->nread);
    80003eca:	21848513          	addi	a0,s1,536
    80003ece:	ffffd097          	auipc	ra,0xffffd
    80003ed2:	7c6080e7          	jalr	1990(ra) # 80001694 <wakeup>
  } else {
    pi->readopen = 0;
    wakeup(&pi->nwrite);
  }
  if(pi->readopen == 0 && pi->writeopen == 0){
    80003ed6:	2204b783          	ld	a5,544(s1)
    80003eda:	eb95                	bnez	a5,80003f0e <pipeclose+0x64>
    release(&pi->lock);
    80003edc:	8526                	mv	a0,s1
    80003ede:	00002097          	auipc	ra,0x2
    80003ee2:	37e080e7          	jalr	894(ra) # 8000625c <release>
    kfree((char*)pi);
    80003ee6:	8526                	mv	a0,s1
    80003ee8:	ffffc097          	auipc	ra,0xffffc
    80003eec:	134080e7          	jalr	308(ra) # 8000001c <kfree>
  } else
    release(&pi->lock);
}
    80003ef0:	60e2                	ld	ra,24(sp)
    80003ef2:	6442                	ld	s0,16(sp)
    80003ef4:	64a2                	ld	s1,8(sp)
    80003ef6:	6902                	ld	s2,0(sp)
    80003ef8:	6105                	addi	sp,sp,32
    80003efa:	8082                	ret
    pi->readopen = 0;
    80003efc:	2204a023          	sw	zero,544(s1)
    wakeup(&pi->nwrite);
    80003f00:	21c48513          	addi	a0,s1,540
    80003f04:	ffffd097          	auipc	ra,0xffffd
    80003f08:	790080e7          	jalr	1936(ra) # 80001694 <wakeup>
    80003f0c:	b7e9                	j	80003ed6 <pipeclose+0x2c>
    release(&pi->lock);
    80003f0e:	8526                	mv	a0,s1
    80003f10:	00002097          	auipc	ra,0x2
    80003f14:	34c080e7          	jalr	844(ra) # 8000625c <release>
}
    80003f18:	bfe1                	j	80003ef0 <pipeclose+0x46>

0000000080003f1a <pipewrite>:

int
pipewrite(struct pipe *pi, uint64 addr, int n)
{
    80003f1a:	711d                	addi	sp,sp,-96
    80003f1c:	ec86                	sd	ra,88(sp)
    80003f1e:	e8a2                	sd	s0,80(sp)
    80003f20:	e4a6                	sd	s1,72(sp)
    80003f22:	e0ca                	sd	s2,64(sp)
    80003f24:	fc4e                	sd	s3,56(sp)
    80003f26:	f852                	sd	s4,48(sp)
    80003f28:	f456                	sd	s5,40(sp)
    80003f2a:	f05a                	sd	s6,32(sp)
    80003f2c:	ec5e                	sd	s7,24(sp)
    80003f2e:	e862                	sd	s8,16(sp)
    80003f30:	1080                	addi	s0,sp,96
    80003f32:	84aa                	mv	s1,a0
    80003f34:	8aae                	mv	s5,a1
    80003f36:	8a32                	mv	s4,a2
  int i = 0;
  struct proc *pr = myproc();
    80003f38:	ffffd097          	auipc	ra,0xffffd
    80003f3c:	f0c080e7          	jalr	-244(ra) # 80000e44 <myproc>
    80003f40:	89aa                	mv	s3,a0

  acquire(&pi->lock);
    80003f42:	8526                	mv	a0,s1
    80003f44:	00002097          	auipc	ra,0x2
    80003f48:	264080e7          	jalr	612(ra) # 800061a8 <acquire>
  while(i < n){
    80003f4c:	0b405363          	blez	s4,80003ff2 <pipewrite+0xd8>
  int i = 0;
    80003f50:	4901                	li	s2,0
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
      wakeup(&pi->nread);
      sleep(&pi->nwrite, &pi->lock);
    } else {
      char ch;
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003f52:	5b7d                	li	s6,-1
      wakeup(&pi->nread);
    80003f54:	21848c13          	addi	s8,s1,536
      sleep(&pi->nwrite, &pi->lock);
    80003f58:	21c48b93          	addi	s7,s1,540
    80003f5c:	a089                	j	80003f9e <pipewrite+0x84>
      release(&pi->lock);
    80003f5e:	8526                	mv	a0,s1
    80003f60:	00002097          	auipc	ra,0x2
    80003f64:	2fc080e7          	jalr	764(ra) # 8000625c <release>
      return -1;
    80003f68:	597d                	li	s2,-1
  }
  wakeup(&pi->nread);
  release(&pi->lock);

  return i;
}
    80003f6a:	854a                	mv	a0,s2
    80003f6c:	60e6                	ld	ra,88(sp)
    80003f6e:	6446                	ld	s0,80(sp)
    80003f70:	64a6                	ld	s1,72(sp)
    80003f72:	6906                	ld	s2,64(sp)
    80003f74:	79e2                	ld	s3,56(sp)
    80003f76:	7a42                	ld	s4,48(sp)
    80003f78:	7aa2                	ld	s5,40(sp)
    80003f7a:	7b02                	ld	s6,32(sp)
    80003f7c:	6be2                	ld	s7,24(sp)
    80003f7e:	6c42                	ld	s8,16(sp)
    80003f80:	6125                	addi	sp,sp,96
    80003f82:	8082                	ret
      wakeup(&pi->nread);
    80003f84:	8562                	mv	a0,s8
    80003f86:	ffffd097          	auipc	ra,0xffffd
    80003f8a:	70e080e7          	jalr	1806(ra) # 80001694 <wakeup>
      sleep(&pi->nwrite, &pi->lock);
    80003f8e:	85a6                	mv	a1,s1
    80003f90:	855e                	mv	a0,s7
    80003f92:	ffffd097          	auipc	ra,0xffffd
    80003f96:	576080e7          	jalr	1398(ra) # 80001508 <sleep>
  while(i < n){
    80003f9a:	05495d63          	bge	s2,s4,80003ff4 <pipewrite+0xda>
    if(pi->readopen == 0 || pr->killed){
    80003f9e:	2204a783          	lw	a5,544(s1)
    80003fa2:	dfd5                	beqz	a5,80003f5e <pipewrite+0x44>
    80003fa4:	0289a783          	lw	a5,40(s3)
    80003fa8:	fbdd                	bnez	a5,80003f5e <pipewrite+0x44>
    if(pi->nwrite == pi->nread + PIPESIZE){ //DOC: pipewrite-full
    80003faa:	2184a783          	lw	a5,536(s1)
    80003fae:	21c4a703          	lw	a4,540(s1)
    80003fb2:	2007879b          	addiw	a5,a5,512
    80003fb6:	fcf707e3          	beq	a4,a5,80003f84 <pipewrite+0x6a>
      if(copyin(pr->pagetable, &ch, addr + i, 1) == -1)
    80003fba:	4685                	li	a3,1
    80003fbc:	01590633          	add	a2,s2,s5
    80003fc0:	faf40593          	addi	a1,s0,-81
    80003fc4:	0509b503          	ld	a0,80(s3)
    80003fc8:	ffffd097          	auipc	ra,0xffffd
    80003fcc:	bcc080e7          	jalr	-1076(ra) # 80000b94 <copyin>
    80003fd0:	03650263          	beq	a0,s6,80003ff4 <pipewrite+0xda>
      pi->data[pi->nwrite++ % PIPESIZE] = ch;
    80003fd4:	21c4a783          	lw	a5,540(s1)
    80003fd8:	0017871b          	addiw	a4,a5,1
    80003fdc:	20e4ae23          	sw	a4,540(s1)
    80003fe0:	1ff7f793          	andi	a5,a5,511
    80003fe4:	97a6                	add	a5,a5,s1
    80003fe6:	faf44703          	lbu	a4,-81(s0)
    80003fea:	00e78c23          	sb	a4,24(a5)
      i++;
    80003fee:	2905                	addiw	s2,s2,1
    80003ff0:	b76d                	j	80003f9a <pipewrite+0x80>
  int i = 0;
    80003ff2:	4901                	li	s2,0
  wakeup(&pi->nread);
    80003ff4:	21848513          	addi	a0,s1,536
    80003ff8:	ffffd097          	auipc	ra,0xffffd
    80003ffc:	69c080e7          	jalr	1692(ra) # 80001694 <wakeup>
  release(&pi->lock);
    80004000:	8526                	mv	a0,s1
    80004002:	00002097          	auipc	ra,0x2
    80004006:	25a080e7          	jalr	602(ra) # 8000625c <release>
  return i;
    8000400a:	b785                	j	80003f6a <pipewrite+0x50>

000000008000400c <piperead>:

int
piperead(struct pipe *pi, uint64 addr, int n)
{
    8000400c:	715d                	addi	sp,sp,-80
    8000400e:	e486                	sd	ra,72(sp)
    80004010:	e0a2                	sd	s0,64(sp)
    80004012:	fc26                	sd	s1,56(sp)
    80004014:	f84a                	sd	s2,48(sp)
    80004016:	f44e                	sd	s3,40(sp)
    80004018:	f052                	sd	s4,32(sp)
    8000401a:	ec56                	sd	s5,24(sp)
    8000401c:	e85a                	sd	s6,16(sp)
    8000401e:	0880                	addi	s0,sp,80
    80004020:	84aa                	mv	s1,a0
    80004022:	892e                	mv	s2,a1
    80004024:	8ab2                	mv	s5,a2
  int i;
  struct proc *pr = myproc();
    80004026:	ffffd097          	auipc	ra,0xffffd
    8000402a:	e1e080e7          	jalr	-482(ra) # 80000e44 <myproc>
    8000402e:	8a2a                	mv	s4,a0
  char ch;

  acquire(&pi->lock);
    80004030:	8526                	mv	a0,s1
    80004032:	00002097          	auipc	ra,0x2
    80004036:	176080e7          	jalr	374(ra) # 800061a8 <acquire>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    8000403a:	2184a703          	lw	a4,536(s1)
    8000403e:	21c4a783          	lw	a5,540(s1)
    if(pr->killed){
      release(&pi->lock);
      return -1;
    }
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004042:	21848993          	addi	s3,s1,536
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004046:	02f71463          	bne	a4,a5,8000406e <piperead+0x62>
    8000404a:	2244a783          	lw	a5,548(s1)
    8000404e:	c385                	beqz	a5,8000406e <piperead+0x62>
    if(pr->killed){
    80004050:	028a2783          	lw	a5,40(s4)
    80004054:	ebc9                	bnez	a5,800040e6 <piperead+0xda>
    sleep(&pi->nread, &pi->lock); //DOC: piperead-sleep
    80004056:	85a6                	mv	a1,s1
    80004058:	854e                	mv	a0,s3
    8000405a:	ffffd097          	auipc	ra,0xffffd
    8000405e:	4ae080e7          	jalr	1198(ra) # 80001508 <sleep>
  while(pi->nread == pi->nwrite && pi->writeopen){  //DOC: pipe-empty
    80004062:	2184a703          	lw	a4,536(s1)
    80004066:	21c4a783          	lw	a5,540(s1)
    8000406a:	fef700e3          	beq	a4,a5,8000404a <piperead+0x3e>
  }
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    8000406e:	4981                	li	s3,0
    if(pi->nread == pi->nwrite)
      break;
    ch = pi->data[pi->nread++ % PIPESIZE];
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004070:	5b7d                	li	s6,-1
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    80004072:	05505463          	blez	s5,800040ba <piperead+0xae>
    if(pi->nread == pi->nwrite)
    80004076:	2184a783          	lw	a5,536(s1)
    8000407a:	21c4a703          	lw	a4,540(s1)
    8000407e:	02f70e63          	beq	a4,a5,800040ba <piperead+0xae>
    ch = pi->data[pi->nread++ % PIPESIZE];
    80004082:	0017871b          	addiw	a4,a5,1
    80004086:	20e4ac23          	sw	a4,536(s1)
    8000408a:	1ff7f793          	andi	a5,a5,511
    8000408e:	97a6                	add	a5,a5,s1
    80004090:	0187c783          	lbu	a5,24(a5)
    80004094:	faf40fa3          	sb	a5,-65(s0)
    if(copyout(pr->pagetable, addr + i, &ch, 1) == -1)
    80004098:	4685                	li	a3,1
    8000409a:	fbf40613          	addi	a2,s0,-65
    8000409e:	85ca                	mv	a1,s2
    800040a0:	050a3503          	ld	a0,80(s4)
    800040a4:	ffffd097          	auipc	ra,0xffffd
    800040a8:	a64080e7          	jalr	-1436(ra) # 80000b08 <copyout>
    800040ac:	01650763          	beq	a0,s6,800040ba <piperead+0xae>
  for(i = 0; i < n; i++){  //DOC: piperead-copy
    800040b0:	2985                	addiw	s3,s3,1
    800040b2:	0905                	addi	s2,s2,1
    800040b4:	fd3a91e3          	bne	s5,s3,80004076 <piperead+0x6a>
    800040b8:	89d6                	mv	s3,s5
      break;
  }
  wakeup(&pi->nwrite);  //DOC: piperead-wakeup
    800040ba:	21c48513          	addi	a0,s1,540
    800040be:	ffffd097          	auipc	ra,0xffffd
    800040c2:	5d6080e7          	jalr	1494(ra) # 80001694 <wakeup>
  release(&pi->lock);
    800040c6:	8526                	mv	a0,s1
    800040c8:	00002097          	auipc	ra,0x2
    800040cc:	194080e7          	jalr	404(ra) # 8000625c <release>
  return i;
}
    800040d0:	854e                	mv	a0,s3
    800040d2:	60a6                	ld	ra,72(sp)
    800040d4:	6406                	ld	s0,64(sp)
    800040d6:	74e2                	ld	s1,56(sp)
    800040d8:	7942                	ld	s2,48(sp)
    800040da:	79a2                	ld	s3,40(sp)
    800040dc:	7a02                	ld	s4,32(sp)
    800040de:	6ae2                	ld	s5,24(sp)
    800040e0:	6b42                	ld	s6,16(sp)
    800040e2:	6161                	addi	sp,sp,80
    800040e4:	8082                	ret
      release(&pi->lock);
    800040e6:	8526                	mv	a0,s1
    800040e8:	00002097          	auipc	ra,0x2
    800040ec:	174080e7          	jalr	372(ra) # 8000625c <release>
      return -1;
    800040f0:	59fd                	li	s3,-1
    800040f2:	bff9                	j	800040d0 <piperead+0xc4>

00000000800040f4 <exec>:

static int loadseg(pde_t *pgdir, uint64 addr, struct inode *ip, uint offset, uint sz);

int
exec(char *path, char **argv)
{
    800040f4:	de010113          	addi	sp,sp,-544
    800040f8:	20113c23          	sd	ra,536(sp)
    800040fc:	20813823          	sd	s0,528(sp)
    80004100:	20913423          	sd	s1,520(sp)
    80004104:	21213023          	sd	s2,512(sp)
    80004108:	ffce                	sd	s3,504(sp)
    8000410a:	fbd2                	sd	s4,496(sp)
    8000410c:	f7d6                	sd	s5,488(sp)
    8000410e:	f3da                	sd	s6,480(sp)
    80004110:	efde                	sd	s7,472(sp)
    80004112:	ebe2                	sd	s8,464(sp)
    80004114:	e7e6                	sd	s9,456(sp)
    80004116:	e3ea                	sd	s10,448(sp)
    80004118:	ff6e                	sd	s11,440(sp)
    8000411a:	1400                	addi	s0,sp,544
    8000411c:	892a                	mv	s2,a0
    8000411e:	dea43423          	sd	a0,-536(s0)
    80004122:	deb43823          	sd	a1,-528(s0)
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
  struct elfhdr elf;
  struct inode *ip;
  struct proghdr ph;
  pagetable_t pagetable = 0, oldpagetable;
  struct proc *p = myproc();
    80004126:	ffffd097          	auipc	ra,0xffffd
    8000412a:	d1e080e7          	jalr	-738(ra) # 80000e44 <myproc>
    8000412e:	84aa                	mv	s1,a0

  begin_op();
    80004130:	fffff097          	auipc	ra,0xfffff
    80004134:	466080e7          	jalr	1126(ra) # 80003596 <begin_op>

  if((ip = namei(path)) == 0){
    80004138:	854a                	mv	a0,s2
    8000413a:	fffff097          	auipc	ra,0xfffff
    8000413e:	23c080e7          	jalr	572(ra) # 80003376 <namei>
    80004142:	c93d                	beqz	a0,800041b8 <exec+0xc4>
    80004144:	8aaa                	mv	s5,a0
    end_op();
    return -1;
  }
  ilock(ip);
    80004146:	fffff097          	auipc	ra,0xfffff
    8000414a:	9f0080e7          	jalr	-1552(ra) # 80002b36 <ilock>

  // Check ELF header
  if(readi(ip, 0, (uint64)&elf, 0, sizeof(elf)) != sizeof(elf))
    8000414e:	04000713          	li	a4,64
    80004152:	4681                	li	a3,0
    80004154:	e5040613          	addi	a2,s0,-432
    80004158:	4581                	li	a1,0
    8000415a:	8556                	mv	a0,s5
    8000415c:	fffff097          	auipc	ra,0xfffff
    80004160:	cda080e7          	jalr	-806(ra) # 80002e36 <readi>
    80004164:	04000793          	li	a5,64
    80004168:	00f51a63          	bne	a0,a5,8000417c <exec+0x88>
    goto bad;
  if(elf.magic != ELF_MAGIC)
    8000416c:	e5042703          	lw	a4,-432(s0)
    80004170:	464c47b7          	lui	a5,0x464c4
    80004174:	57f78793          	addi	a5,a5,1407 # 464c457f <_entry-0x39b3ba81>
    80004178:	04f70663          	beq	a4,a5,800041c4 <exec+0xd0>

 bad:
  if(pagetable)
    proc_freepagetable(pagetable, sz);
  if(ip){
    iunlockput(ip);
    8000417c:	8556                	mv	a0,s5
    8000417e:	fffff097          	auipc	ra,0xfffff
    80004182:	c66080e7          	jalr	-922(ra) # 80002de4 <iunlockput>
    end_op();
    80004186:	fffff097          	auipc	ra,0xfffff
    8000418a:	48e080e7          	jalr	1166(ra) # 80003614 <end_op>
  }
  return -1;
    8000418e:	557d                	li	a0,-1
}
    80004190:	21813083          	ld	ra,536(sp)
    80004194:	21013403          	ld	s0,528(sp)
    80004198:	20813483          	ld	s1,520(sp)
    8000419c:	20013903          	ld	s2,512(sp)
    800041a0:	79fe                	ld	s3,504(sp)
    800041a2:	7a5e                	ld	s4,496(sp)
    800041a4:	7abe                	ld	s5,488(sp)
    800041a6:	7b1e                	ld	s6,480(sp)
    800041a8:	6bfe                	ld	s7,472(sp)
    800041aa:	6c5e                	ld	s8,464(sp)
    800041ac:	6cbe                	ld	s9,456(sp)
    800041ae:	6d1e                	ld	s10,448(sp)
    800041b0:	7dfa                	ld	s11,440(sp)
    800041b2:	22010113          	addi	sp,sp,544
    800041b6:	8082                	ret
    end_op();
    800041b8:	fffff097          	auipc	ra,0xfffff
    800041bc:	45c080e7          	jalr	1116(ra) # 80003614 <end_op>
    return -1;
    800041c0:	557d                	li	a0,-1
    800041c2:	b7f9                	j	80004190 <exec+0x9c>
  if((pagetable = proc_pagetable(p)) == 0)
    800041c4:	8526                	mv	a0,s1
    800041c6:	ffffd097          	auipc	ra,0xffffd
    800041ca:	d42080e7          	jalr	-702(ra) # 80000f08 <proc_pagetable>
    800041ce:	8b2a                	mv	s6,a0
    800041d0:	d555                	beqz	a0,8000417c <exec+0x88>
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800041d2:	e7042783          	lw	a5,-400(s0)
    800041d6:	e8845703          	lhu	a4,-376(s0)
    800041da:	c735                	beqz	a4,80004246 <exec+0x152>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    800041dc:	4481                	li	s1,0
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    800041de:	e0043423          	sd	zero,-504(s0)
    if((ph.vaddr % PGSIZE) != 0)
    800041e2:	6a05                	lui	s4,0x1
    800041e4:	fffa0713          	addi	a4,s4,-1 # fff <_entry-0x7ffff001>
    800041e8:	dee43023          	sd	a4,-544(s0)
loadseg(pagetable_t pagetable, uint64 va, struct inode *ip, uint offset, uint sz)
{
  uint i, n;
  uint64 pa;

  for(i = 0; i < sz; i += PGSIZE){
    800041ec:	6d85                	lui	s11,0x1
    800041ee:	7d7d                	lui	s10,0xfffff
    800041f0:	ac1d                	j	80004426 <exec+0x332>
    pa = walkaddr(pagetable, va + i);
    if(pa == 0)
      panic("loadseg: address should exist");
    800041f2:	00004517          	auipc	a0,0x4
    800041f6:	5c650513          	addi	a0,a0,1478 # 800087b8 <syscalls+0x3f0>
    800041fa:	00002097          	auipc	ra,0x2
    800041fe:	a76080e7          	jalr	-1418(ra) # 80005c70 <panic>
    if(sz - i < PGSIZE)
      n = sz - i;
    else
      n = PGSIZE;
    if(readi(ip, 0, (uint64)pa, offset+i, n) != n)
    80004202:	874a                	mv	a4,s2
    80004204:	009c86bb          	addw	a3,s9,s1
    80004208:	4581                	li	a1,0
    8000420a:	8556                	mv	a0,s5
    8000420c:	fffff097          	auipc	ra,0xfffff
    80004210:	c2a080e7          	jalr	-982(ra) # 80002e36 <readi>
    80004214:	2501                	sext.w	a0,a0
    80004216:	1aa91863          	bne	s2,a0,800043c6 <exec+0x2d2>
  for(i = 0; i < sz; i += PGSIZE){
    8000421a:	009d84bb          	addw	s1,s11,s1
    8000421e:	013d09bb          	addw	s3,s10,s3
    80004222:	1f74f263          	bgeu	s1,s7,80004406 <exec+0x312>
    pa = walkaddr(pagetable, va + i);
    80004226:	02049593          	slli	a1,s1,0x20
    8000422a:	9181                	srli	a1,a1,0x20
    8000422c:	95e2                	add	a1,a1,s8
    8000422e:	855a                	mv	a0,s6
    80004230:	ffffc097          	auipc	ra,0xffffc
    80004234:	2d0080e7          	jalr	720(ra) # 80000500 <walkaddr>
    80004238:	862a                	mv	a2,a0
    if(pa == 0)
    8000423a:	dd45                	beqz	a0,800041f2 <exec+0xfe>
      n = PGSIZE;
    8000423c:	8952                	mv	s2,s4
    if(sz - i < PGSIZE)
    8000423e:	fd49f2e3          	bgeu	s3,s4,80004202 <exec+0x10e>
      n = sz - i;
    80004242:	894e                	mv	s2,s3
    80004244:	bf7d                	j	80004202 <exec+0x10e>
  uint64 argc, sz = 0, sp, ustack[MAXARG], stackbase;
    80004246:	4481                	li	s1,0
  iunlockput(ip);
    80004248:	8556                	mv	a0,s5
    8000424a:	fffff097          	auipc	ra,0xfffff
    8000424e:	b9a080e7          	jalr	-1126(ra) # 80002de4 <iunlockput>
  end_op();
    80004252:	fffff097          	auipc	ra,0xfffff
    80004256:	3c2080e7          	jalr	962(ra) # 80003614 <end_op>
  p = myproc();
    8000425a:	ffffd097          	auipc	ra,0xffffd
    8000425e:	bea080e7          	jalr	-1046(ra) # 80000e44 <myproc>
    80004262:	8baa                	mv	s7,a0
  uint64 oldsz = p->sz;
    80004264:	04853d03          	ld	s10,72(a0)
  sz = PGROUNDUP(sz);
    80004268:	6785                	lui	a5,0x1
    8000426a:	17fd                	addi	a5,a5,-1 # fff <_entry-0x7ffff001>
    8000426c:	97a6                	add	a5,a5,s1
    8000426e:	777d                	lui	a4,0xfffff
    80004270:	8ff9                	and	a5,a5,a4
    80004272:	def43c23          	sd	a5,-520(s0)
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    80004276:	6609                	lui	a2,0x2
    80004278:	963e                	add	a2,a2,a5
    8000427a:	85be                	mv	a1,a5
    8000427c:	855a                	mv	a0,s6
    8000427e:	ffffc097          	auipc	ra,0xffffc
    80004282:	636080e7          	jalr	1590(ra) # 800008b4 <uvmalloc>
    80004286:	8c2a                	mv	s8,a0
  ip = 0;
    80004288:	4a81                	li	s5,0
  if((sz1 = uvmalloc(pagetable, sz, sz + 2*PGSIZE)) == 0)
    8000428a:	12050e63          	beqz	a0,800043c6 <exec+0x2d2>
  uvmclear(pagetable, sz-2*PGSIZE);
    8000428e:	75f9                	lui	a1,0xffffe
    80004290:	95aa                	add	a1,a1,a0
    80004292:	855a                	mv	a0,s6
    80004294:	ffffd097          	auipc	ra,0xffffd
    80004298:	842080e7          	jalr	-1982(ra) # 80000ad6 <uvmclear>
  stackbase = sp - PGSIZE;
    8000429c:	7afd                	lui	s5,0xfffff
    8000429e:	9ae2                	add	s5,s5,s8
  for(argc = 0; argv[argc]; argc++) {
    800042a0:	df043783          	ld	a5,-528(s0)
    800042a4:	6388                	ld	a0,0(a5)
    800042a6:	c925                	beqz	a0,80004316 <exec+0x222>
    800042a8:	e9040993          	addi	s3,s0,-368
    800042ac:	f9040c93          	addi	s9,s0,-112
  sp = sz;
    800042b0:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    800042b2:	4481                	li	s1,0
    sp -= strlen(argv[argc]) + 1;
    800042b4:	ffffc097          	auipc	ra,0xffffc
    800042b8:	042080e7          	jalr	66(ra) # 800002f6 <strlen>
    800042bc:	0015079b          	addiw	a5,a0,1
    800042c0:	40f907b3          	sub	a5,s2,a5
    sp -= sp % 16; // riscv sp must be 16-byte aligned
    800042c4:	ff07f913          	andi	s2,a5,-16
    if(sp < stackbase)
    800042c8:	13596363          	bltu	s2,s5,800043ee <exec+0x2fa>
    if(copyout(pagetable, sp, argv[argc], strlen(argv[argc]) + 1) < 0)
    800042cc:	df043d83          	ld	s11,-528(s0)
    800042d0:	000dba03          	ld	s4,0(s11) # 1000 <_entry-0x7ffff000>
    800042d4:	8552                	mv	a0,s4
    800042d6:	ffffc097          	auipc	ra,0xffffc
    800042da:	020080e7          	jalr	32(ra) # 800002f6 <strlen>
    800042de:	0015069b          	addiw	a3,a0,1
    800042e2:	8652                	mv	a2,s4
    800042e4:	85ca                	mv	a1,s2
    800042e6:	855a                	mv	a0,s6
    800042e8:	ffffd097          	auipc	ra,0xffffd
    800042ec:	820080e7          	jalr	-2016(ra) # 80000b08 <copyout>
    800042f0:	10054363          	bltz	a0,800043f6 <exec+0x302>
    ustack[argc] = sp;
    800042f4:	0129b023          	sd	s2,0(s3)
  for(argc = 0; argv[argc]; argc++) {
    800042f8:	0485                	addi	s1,s1,1
    800042fa:	008d8793          	addi	a5,s11,8
    800042fe:	def43823          	sd	a5,-528(s0)
    80004302:	008db503          	ld	a0,8(s11)
    80004306:	c911                	beqz	a0,8000431a <exec+0x226>
    if(argc >= MAXARG)
    80004308:	09a1                	addi	s3,s3,8
    8000430a:	fb3c95e3          	bne	s9,s3,800042b4 <exec+0x1c0>
  sz = sz1;
    8000430e:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004312:	4a81                	li	s5,0
    80004314:	a84d                	j	800043c6 <exec+0x2d2>
  sp = sz;
    80004316:	8962                	mv	s2,s8
  for(argc = 0; argv[argc]; argc++) {
    80004318:	4481                	li	s1,0
  ustack[argc] = 0;
    8000431a:	00349793          	slli	a5,s1,0x3
    8000431e:	f9078793          	addi	a5,a5,-112
    80004322:	97a2                	add	a5,a5,s0
    80004324:	f007b023          	sd	zero,-256(a5)
  sp -= (argc+1) * sizeof(uint64);
    80004328:	00148693          	addi	a3,s1,1
    8000432c:	068e                	slli	a3,a3,0x3
    8000432e:	40d90933          	sub	s2,s2,a3
  sp -= sp % 16;
    80004332:	ff097913          	andi	s2,s2,-16
  if(sp < stackbase)
    80004336:	01597663          	bgeu	s2,s5,80004342 <exec+0x24e>
  sz = sz1;
    8000433a:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    8000433e:	4a81                	li	s5,0
    80004340:	a059                	j	800043c6 <exec+0x2d2>
  if(copyout(pagetable, sp, (char *)ustack, (argc+1)*sizeof(uint64)) < 0)
    80004342:	e9040613          	addi	a2,s0,-368
    80004346:	85ca                	mv	a1,s2
    80004348:	855a                	mv	a0,s6
    8000434a:	ffffc097          	auipc	ra,0xffffc
    8000434e:	7be080e7          	jalr	1982(ra) # 80000b08 <copyout>
    80004352:	0a054663          	bltz	a0,800043fe <exec+0x30a>
  p->trapframe->a1 = sp;
    80004356:	058bb783          	ld	a5,88(s7)
    8000435a:	0727bc23          	sd	s2,120(a5)
  for(last=s=path; *s; s++)
    8000435e:	de843783          	ld	a5,-536(s0)
    80004362:	0007c703          	lbu	a4,0(a5)
    80004366:	cf11                	beqz	a4,80004382 <exec+0x28e>
    80004368:	0785                	addi	a5,a5,1
    if(*s == '/')
    8000436a:	02f00693          	li	a3,47
    8000436e:	a039                	j	8000437c <exec+0x288>
      last = s+1;
    80004370:	def43423          	sd	a5,-536(s0)
  for(last=s=path; *s; s++)
    80004374:	0785                	addi	a5,a5,1
    80004376:	fff7c703          	lbu	a4,-1(a5)
    8000437a:	c701                	beqz	a4,80004382 <exec+0x28e>
    if(*s == '/')
    8000437c:	fed71ce3          	bne	a4,a3,80004374 <exec+0x280>
    80004380:	bfc5                	j	80004370 <exec+0x27c>
  safestrcpy(p->name, last, sizeof(p->name));
    80004382:	4641                	li	a2,16
    80004384:	de843583          	ld	a1,-536(s0)
    80004388:	158b8513          	addi	a0,s7,344
    8000438c:	ffffc097          	auipc	ra,0xffffc
    80004390:	f38080e7          	jalr	-200(ra) # 800002c4 <safestrcpy>
  oldpagetable = p->pagetable;
    80004394:	050bb503          	ld	a0,80(s7)
  p->pagetable = pagetable;
    80004398:	056bb823          	sd	s6,80(s7)
  p->sz = sz;
    8000439c:	058bb423          	sd	s8,72(s7)
  p->trapframe->epc = elf.entry;  // initial program counter = main
    800043a0:	058bb783          	ld	a5,88(s7)
    800043a4:	e6843703          	ld	a4,-408(s0)
    800043a8:	ef98                	sd	a4,24(a5)
  p->trapframe->sp = sp; // initial stack pointer
    800043aa:	058bb783          	ld	a5,88(s7)
    800043ae:	0327b823          	sd	s2,48(a5)
  proc_freepagetable(oldpagetable, oldsz);
    800043b2:	85ea                	mv	a1,s10
    800043b4:	ffffd097          	auipc	ra,0xffffd
    800043b8:	bf0080e7          	jalr	-1040(ra) # 80000fa4 <proc_freepagetable>
  return argc; // this ends up in a0, the first argument to main(argc, argv)
    800043bc:	0004851b          	sext.w	a0,s1
    800043c0:	bbc1                	j	80004190 <exec+0x9c>
    800043c2:	de943c23          	sd	s1,-520(s0)
    proc_freepagetable(pagetable, sz);
    800043c6:	df843583          	ld	a1,-520(s0)
    800043ca:	855a                	mv	a0,s6
    800043cc:	ffffd097          	auipc	ra,0xffffd
    800043d0:	bd8080e7          	jalr	-1064(ra) # 80000fa4 <proc_freepagetable>
  if(ip){
    800043d4:	da0a94e3          	bnez	s5,8000417c <exec+0x88>
  return -1;
    800043d8:	557d                	li	a0,-1
    800043da:	bb5d                	j	80004190 <exec+0x9c>
    800043dc:	de943c23          	sd	s1,-520(s0)
    800043e0:	b7dd                	j	800043c6 <exec+0x2d2>
    800043e2:	de943c23          	sd	s1,-520(s0)
    800043e6:	b7c5                	j	800043c6 <exec+0x2d2>
    800043e8:	de943c23          	sd	s1,-520(s0)
    800043ec:	bfe9                	j	800043c6 <exec+0x2d2>
  sz = sz1;
    800043ee:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800043f2:	4a81                	li	s5,0
    800043f4:	bfc9                	j	800043c6 <exec+0x2d2>
  sz = sz1;
    800043f6:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    800043fa:	4a81                	li	s5,0
    800043fc:	b7e9                	j	800043c6 <exec+0x2d2>
  sz = sz1;
    800043fe:	df843c23          	sd	s8,-520(s0)
  ip = 0;
    80004402:	4a81                	li	s5,0
    80004404:	b7c9                	j	800043c6 <exec+0x2d2>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    80004406:	df843483          	ld	s1,-520(s0)
  for(i=0, off=elf.phoff; i<elf.phnum; i++, off+=sizeof(ph)){
    8000440a:	e0843783          	ld	a5,-504(s0)
    8000440e:	0017869b          	addiw	a3,a5,1
    80004412:	e0d43423          	sd	a3,-504(s0)
    80004416:	e0043783          	ld	a5,-512(s0)
    8000441a:	0387879b          	addiw	a5,a5,56
    8000441e:	e8845703          	lhu	a4,-376(s0)
    80004422:	e2e6d3e3          	bge	a3,a4,80004248 <exec+0x154>
    if(readi(ip, 0, (uint64)&ph, off, sizeof(ph)) != sizeof(ph))
    80004426:	2781                	sext.w	a5,a5
    80004428:	e0f43023          	sd	a5,-512(s0)
    8000442c:	03800713          	li	a4,56
    80004430:	86be                	mv	a3,a5
    80004432:	e1840613          	addi	a2,s0,-488
    80004436:	4581                	li	a1,0
    80004438:	8556                	mv	a0,s5
    8000443a:	fffff097          	auipc	ra,0xfffff
    8000443e:	9fc080e7          	jalr	-1540(ra) # 80002e36 <readi>
    80004442:	03800793          	li	a5,56
    80004446:	f6f51ee3          	bne	a0,a5,800043c2 <exec+0x2ce>
    if(ph.type != ELF_PROG_LOAD)
    8000444a:	e1842783          	lw	a5,-488(s0)
    8000444e:	4705                	li	a4,1
    80004450:	fae79de3          	bne	a5,a4,8000440a <exec+0x316>
    if(ph.memsz < ph.filesz)
    80004454:	e4043603          	ld	a2,-448(s0)
    80004458:	e3843783          	ld	a5,-456(s0)
    8000445c:	f8f660e3          	bltu	a2,a5,800043dc <exec+0x2e8>
    if(ph.vaddr + ph.memsz < ph.vaddr)
    80004460:	e2843783          	ld	a5,-472(s0)
    80004464:	963e                	add	a2,a2,a5
    80004466:	f6f66ee3          	bltu	a2,a5,800043e2 <exec+0x2ee>
    if((sz1 = uvmalloc(pagetable, sz, ph.vaddr + ph.memsz)) == 0)
    8000446a:	85a6                	mv	a1,s1
    8000446c:	855a                	mv	a0,s6
    8000446e:	ffffc097          	auipc	ra,0xffffc
    80004472:	446080e7          	jalr	1094(ra) # 800008b4 <uvmalloc>
    80004476:	dea43c23          	sd	a0,-520(s0)
    8000447a:	d53d                	beqz	a0,800043e8 <exec+0x2f4>
    if((ph.vaddr % PGSIZE) != 0)
    8000447c:	e2843c03          	ld	s8,-472(s0)
    80004480:	de043783          	ld	a5,-544(s0)
    80004484:	00fc77b3          	and	a5,s8,a5
    80004488:	ff9d                	bnez	a5,800043c6 <exec+0x2d2>
    if(loadseg(pagetable, ph.vaddr, ip, ph.off, ph.filesz) < 0)
    8000448a:	e2042c83          	lw	s9,-480(s0)
    8000448e:	e3842b83          	lw	s7,-456(s0)
  for(i = 0; i < sz; i += PGSIZE){
    80004492:	f60b8ae3          	beqz	s7,80004406 <exec+0x312>
    80004496:	89de                	mv	s3,s7
    80004498:	4481                	li	s1,0
    8000449a:	b371                	j	80004226 <exec+0x132>

000000008000449c <argfd>:

// Fetch the nth word-sized system call argument as a file descriptor
// and return both the descriptor and the corresponding struct file.
static int
argfd(int n, int *pfd, struct file **pf)
{
    8000449c:	7179                	addi	sp,sp,-48
    8000449e:	f406                	sd	ra,40(sp)
    800044a0:	f022                	sd	s0,32(sp)
    800044a2:	ec26                	sd	s1,24(sp)
    800044a4:	e84a                	sd	s2,16(sp)
    800044a6:	1800                	addi	s0,sp,48
    800044a8:	892e                	mv	s2,a1
    800044aa:	84b2                	mv	s1,a2
  int fd;
  struct file *f;

  if(argint(n, &fd) < 0)
    800044ac:	fdc40593          	addi	a1,s0,-36
    800044b0:	ffffe097          	auipc	ra,0xffffe
    800044b4:	a4a080e7          	jalr	-1462(ra) # 80001efa <argint>
    800044b8:	04054063          	bltz	a0,800044f8 <argfd+0x5c>
    return -1;
  if(fd < 0 || fd >= NOFILE || (f=myproc()->ofile[fd]) == 0)
    800044bc:	fdc42703          	lw	a4,-36(s0)
    800044c0:	47bd                	li	a5,15
    800044c2:	02e7ed63          	bltu	a5,a4,800044fc <argfd+0x60>
    800044c6:	ffffd097          	auipc	ra,0xffffd
    800044ca:	97e080e7          	jalr	-1666(ra) # 80000e44 <myproc>
    800044ce:	fdc42703          	lw	a4,-36(s0)
    800044d2:	01a70793          	addi	a5,a4,26 # fffffffffffff01a <end+0xffffffff7ffd1dda>
    800044d6:	078e                	slli	a5,a5,0x3
    800044d8:	953e                	add	a0,a0,a5
    800044da:	611c                	ld	a5,0(a0)
    800044dc:	c395                	beqz	a5,80004500 <argfd+0x64>
    return -1;
  if(pfd)
    800044de:	00090463          	beqz	s2,800044e6 <argfd+0x4a>
    *pfd = fd;
    800044e2:	00e92023          	sw	a4,0(s2)
  if(pf)
    *pf = f;
  return 0;
    800044e6:	4501                	li	a0,0
  if(pf)
    800044e8:	c091                	beqz	s1,800044ec <argfd+0x50>
    *pf = f;
    800044ea:	e09c                	sd	a5,0(s1)
}
    800044ec:	70a2                	ld	ra,40(sp)
    800044ee:	7402                	ld	s0,32(sp)
    800044f0:	64e2                	ld	s1,24(sp)
    800044f2:	6942                	ld	s2,16(sp)
    800044f4:	6145                	addi	sp,sp,48
    800044f6:	8082                	ret
    return -1;
    800044f8:	557d                	li	a0,-1
    800044fa:	bfcd                	j	800044ec <argfd+0x50>
    return -1;
    800044fc:	557d                	li	a0,-1
    800044fe:	b7fd                	j	800044ec <argfd+0x50>
    80004500:	557d                	li	a0,-1
    80004502:	b7ed                	j	800044ec <argfd+0x50>

0000000080004504 <fdalloc>:

// Allocate a file descriptor for the given file.
// Takes over file reference from caller on success.
static int
fdalloc(struct file *f)
{
    80004504:	1101                	addi	sp,sp,-32
    80004506:	ec06                	sd	ra,24(sp)
    80004508:	e822                	sd	s0,16(sp)
    8000450a:	e426                	sd	s1,8(sp)
    8000450c:	1000                	addi	s0,sp,32
    8000450e:	84aa                	mv	s1,a0
  int fd;
  struct proc *p = myproc();
    80004510:	ffffd097          	auipc	ra,0xffffd
    80004514:	934080e7          	jalr	-1740(ra) # 80000e44 <myproc>
    80004518:	862a                	mv	a2,a0

  for(fd = 0; fd < NOFILE; fd++){
    8000451a:	0d050793          	addi	a5,a0,208
    8000451e:	4501                	li	a0,0
    80004520:	46c1                	li	a3,16
    if(p->ofile[fd] == 0){
    80004522:	6398                	ld	a4,0(a5)
    80004524:	cb19                	beqz	a4,8000453a <fdalloc+0x36>
  for(fd = 0; fd < NOFILE; fd++){
    80004526:	2505                	addiw	a0,a0,1
    80004528:	07a1                	addi	a5,a5,8
    8000452a:	fed51ce3          	bne	a0,a3,80004522 <fdalloc+0x1e>
      p->ofile[fd] = f;
      return fd;
    }
  }
  return -1;
    8000452e:	557d                	li	a0,-1
}
    80004530:	60e2                	ld	ra,24(sp)
    80004532:	6442                	ld	s0,16(sp)
    80004534:	64a2                	ld	s1,8(sp)
    80004536:	6105                	addi	sp,sp,32
    80004538:	8082                	ret
      p->ofile[fd] = f;
    8000453a:	01a50793          	addi	a5,a0,26
    8000453e:	078e                	slli	a5,a5,0x3
    80004540:	963e                	add	a2,a2,a5
    80004542:	e204                	sd	s1,0(a2)
      return fd;
    80004544:	b7f5                	j	80004530 <fdalloc+0x2c>

0000000080004546 <create>:
  return -1;
}

static struct inode*
create(char *path, short type, short major, short minor)
{
    80004546:	715d                	addi	sp,sp,-80
    80004548:	e486                	sd	ra,72(sp)
    8000454a:	e0a2                	sd	s0,64(sp)
    8000454c:	fc26                	sd	s1,56(sp)
    8000454e:	f84a                	sd	s2,48(sp)
    80004550:	f44e                	sd	s3,40(sp)
    80004552:	f052                	sd	s4,32(sp)
    80004554:	ec56                	sd	s5,24(sp)
    80004556:	0880                	addi	s0,sp,80
    80004558:	89ae                	mv	s3,a1
    8000455a:	8ab2                	mv	s5,a2
    8000455c:	8a36                	mv	s4,a3
  struct inode *ip, *dp;
  char name[DIRSIZ];

  if((dp = nameiparent(path, name)) == 0)
    8000455e:	fb040593          	addi	a1,s0,-80
    80004562:	fffff097          	auipc	ra,0xfffff
    80004566:	e32080e7          	jalr	-462(ra) # 80003394 <nameiparent>
    8000456a:	892a                	mv	s2,a0
    8000456c:	12050e63          	beqz	a0,800046a8 <create+0x162>
    return 0;

  ilock(dp);
    80004570:	ffffe097          	auipc	ra,0xffffe
    80004574:	5c6080e7          	jalr	1478(ra) # 80002b36 <ilock>

  if((ip = dirlookup(dp, name, 0)) != 0){
    80004578:	4601                	li	a2,0
    8000457a:	fb040593          	addi	a1,s0,-80
    8000457e:	854a                	mv	a0,s2
    80004580:	fffff097          	auipc	ra,0xfffff
    80004584:	b1e080e7          	jalr	-1250(ra) # 8000309e <dirlookup>
    80004588:	84aa                	mv	s1,a0
    8000458a:	c921                	beqz	a0,800045da <create+0x94>
    iunlockput(dp);
    8000458c:	854a                	mv	a0,s2
    8000458e:	fffff097          	auipc	ra,0xfffff
    80004592:	856080e7          	jalr	-1962(ra) # 80002de4 <iunlockput>
    ilock(ip);
    80004596:	8526                	mv	a0,s1
    80004598:	ffffe097          	auipc	ra,0xffffe
    8000459c:	59e080e7          	jalr	1438(ra) # 80002b36 <ilock>
    if(type == T_FILE && (ip->type == T_FILE || ip->type == T_DEVICE))
    800045a0:	2981                	sext.w	s3,s3
    800045a2:	4789                	li	a5,2
    800045a4:	02f99463          	bne	s3,a5,800045cc <create+0x86>
    800045a8:	0444d783          	lhu	a5,68(s1)
    800045ac:	37f9                	addiw	a5,a5,-2
    800045ae:	17c2                	slli	a5,a5,0x30
    800045b0:	93c1                	srli	a5,a5,0x30
    800045b2:	4705                	li	a4,1
    800045b4:	00f76c63          	bltu	a4,a5,800045cc <create+0x86>
    panic("create: dirlink");

  iunlockput(dp);

  return ip;
}
    800045b8:	8526                	mv	a0,s1
    800045ba:	60a6                	ld	ra,72(sp)
    800045bc:	6406                	ld	s0,64(sp)
    800045be:	74e2                	ld	s1,56(sp)
    800045c0:	7942                	ld	s2,48(sp)
    800045c2:	79a2                	ld	s3,40(sp)
    800045c4:	7a02                	ld	s4,32(sp)
    800045c6:	6ae2                	ld	s5,24(sp)
    800045c8:	6161                	addi	sp,sp,80
    800045ca:	8082                	ret
    iunlockput(ip);
    800045cc:	8526                	mv	a0,s1
    800045ce:	fffff097          	auipc	ra,0xfffff
    800045d2:	816080e7          	jalr	-2026(ra) # 80002de4 <iunlockput>
    return 0;
    800045d6:	4481                	li	s1,0
    800045d8:	b7c5                	j	800045b8 <create+0x72>
  if((ip = ialloc(dp->dev, type)) == 0)
    800045da:	85ce                	mv	a1,s3
    800045dc:	00092503          	lw	a0,0(s2)
    800045e0:	ffffe097          	auipc	ra,0xffffe
    800045e4:	3bc080e7          	jalr	956(ra) # 8000299c <ialloc>
    800045e8:	84aa                	mv	s1,a0
    800045ea:	c521                	beqz	a0,80004632 <create+0xec>
  ilock(ip);
    800045ec:	ffffe097          	auipc	ra,0xffffe
    800045f0:	54a080e7          	jalr	1354(ra) # 80002b36 <ilock>
  ip->major = major;
    800045f4:	05549323          	sh	s5,70(s1)
  ip->minor = minor;
    800045f8:	05449423          	sh	s4,72(s1)
  ip->nlink = 1;
    800045fc:	4a05                	li	s4,1
    800045fe:	05449523          	sh	s4,74(s1)
  iupdate(ip);
    80004602:	8526                	mv	a0,s1
    80004604:	ffffe097          	auipc	ra,0xffffe
    80004608:	466080e7          	jalr	1126(ra) # 80002a6a <iupdate>
  if(type == T_DIR){  // Create . and .. entries.
    8000460c:	2981                	sext.w	s3,s3
    8000460e:	03498a63          	beq	s3,s4,80004642 <create+0xfc>
  if(dirlink(dp, name, ip->inum) < 0)
    80004612:	40d0                	lw	a2,4(s1)
    80004614:	fb040593          	addi	a1,s0,-80
    80004618:	854a                	mv	a0,s2
    8000461a:	fffff097          	auipc	ra,0xfffff
    8000461e:	c9a080e7          	jalr	-870(ra) # 800032b4 <dirlink>
    80004622:	06054b63          	bltz	a0,80004698 <create+0x152>
  iunlockput(dp);
    80004626:	854a                	mv	a0,s2
    80004628:	ffffe097          	auipc	ra,0xffffe
    8000462c:	7bc080e7          	jalr	1980(ra) # 80002de4 <iunlockput>
  return ip;
    80004630:	b761                	j	800045b8 <create+0x72>
    panic("create: ialloc");
    80004632:	00004517          	auipc	a0,0x4
    80004636:	1a650513          	addi	a0,a0,422 # 800087d8 <syscalls+0x410>
    8000463a:	00001097          	auipc	ra,0x1
    8000463e:	636080e7          	jalr	1590(ra) # 80005c70 <panic>
    dp->nlink++;  // for ".."
    80004642:	04a95783          	lhu	a5,74(s2)
    80004646:	2785                	addiw	a5,a5,1
    80004648:	04f91523          	sh	a5,74(s2)
    iupdate(dp);
    8000464c:	854a                	mv	a0,s2
    8000464e:	ffffe097          	auipc	ra,0xffffe
    80004652:	41c080e7          	jalr	1052(ra) # 80002a6a <iupdate>
    if(dirlink(ip, ".", ip->inum) < 0 || dirlink(ip, "..", dp->inum) < 0)
    80004656:	40d0                	lw	a2,4(s1)
    80004658:	00004597          	auipc	a1,0x4
    8000465c:	19058593          	addi	a1,a1,400 # 800087e8 <syscalls+0x420>
    80004660:	8526                	mv	a0,s1
    80004662:	fffff097          	auipc	ra,0xfffff
    80004666:	c52080e7          	jalr	-942(ra) # 800032b4 <dirlink>
    8000466a:	00054f63          	bltz	a0,80004688 <create+0x142>
    8000466e:	00492603          	lw	a2,4(s2)
    80004672:	00004597          	auipc	a1,0x4
    80004676:	17e58593          	addi	a1,a1,382 # 800087f0 <syscalls+0x428>
    8000467a:	8526                	mv	a0,s1
    8000467c:	fffff097          	auipc	ra,0xfffff
    80004680:	c38080e7          	jalr	-968(ra) # 800032b4 <dirlink>
    80004684:	f80557e3          	bgez	a0,80004612 <create+0xcc>
      panic("create dots");
    80004688:	00004517          	auipc	a0,0x4
    8000468c:	17050513          	addi	a0,a0,368 # 800087f8 <syscalls+0x430>
    80004690:	00001097          	auipc	ra,0x1
    80004694:	5e0080e7          	jalr	1504(ra) # 80005c70 <panic>
    panic("create: dirlink");
    80004698:	00004517          	auipc	a0,0x4
    8000469c:	17050513          	addi	a0,a0,368 # 80008808 <syscalls+0x440>
    800046a0:	00001097          	auipc	ra,0x1
    800046a4:	5d0080e7          	jalr	1488(ra) # 80005c70 <panic>
    return 0;
    800046a8:	84aa                	mv	s1,a0
    800046aa:	b739                	j	800045b8 <create+0x72>

00000000800046ac <sys_dup>:
{
    800046ac:	7179                	addi	sp,sp,-48
    800046ae:	f406                	sd	ra,40(sp)
    800046b0:	f022                	sd	s0,32(sp)
    800046b2:	ec26                	sd	s1,24(sp)
    800046b4:	e84a                	sd	s2,16(sp)
    800046b6:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0)
    800046b8:	fd840613          	addi	a2,s0,-40
    800046bc:	4581                	li	a1,0
    800046be:	4501                	li	a0,0
    800046c0:	00000097          	auipc	ra,0x0
    800046c4:	ddc080e7          	jalr	-548(ra) # 8000449c <argfd>
    return -1;
    800046c8:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0)
    800046ca:	02054363          	bltz	a0,800046f0 <sys_dup+0x44>
  if((fd=fdalloc(f)) < 0)
    800046ce:	fd843903          	ld	s2,-40(s0)
    800046d2:	854a                	mv	a0,s2
    800046d4:	00000097          	auipc	ra,0x0
    800046d8:	e30080e7          	jalr	-464(ra) # 80004504 <fdalloc>
    800046dc:	84aa                	mv	s1,a0
    return -1;
    800046de:	57fd                	li	a5,-1
  if((fd=fdalloc(f)) < 0)
    800046e0:	00054863          	bltz	a0,800046f0 <sys_dup+0x44>
  filedup(f);
    800046e4:	854a                	mv	a0,s2
    800046e6:	fffff097          	auipc	ra,0xfffff
    800046ea:	326080e7          	jalr	806(ra) # 80003a0c <filedup>
  return fd;
    800046ee:	87a6                	mv	a5,s1
}
    800046f0:	853e                	mv	a0,a5
    800046f2:	70a2                	ld	ra,40(sp)
    800046f4:	7402                	ld	s0,32(sp)
    800046f6:	64e2                	ld	s1,24(sp)
    800046f8:	6942                	ld	s2,16(sp)
    800046fa:	6145                	addi	sp,sp,48
    800046fc:	8082                	ret

00000000800046fe <sys_read>:
{
    800046fe:	7179                	addi	sp,sp,-48
    80004700:	f406                	sd	ra,40(sp)
    80004702:	f022                	sd	s0,32(sp)
    80004704:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004706:	fe840613          	addi	a2,s0,-24
    8000470a:	4581                	li	a1,0
    8000470c:	4501                	li	a0,0
    8000470e:	00000097          	auipc	ra,0x0
    80004712:	d8e080e7          	jalr	-626(ra) # 8000449c <argfd>
    return -1;
    80004716:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004718:	04054163          	bltz	a0,8000475a <sys_read+0x5c>
    8000471c:	fe440593          	addi	a1,s0,-28
    80004720:	4509                	li	a0,2
    80004722:	ffffd097          	auipc	ra,0xffffd
    80004726:	7d8080e7          	jalr	2008(ra) # 80001efa <argint>
    return -1;
    8000472a:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000472c:	02054763          	bltz	a0,8000475a <sys_read+0x5c>
    80004730:	fd840593          	addi	a1,s0,-40
    80004734:	4505                	li	a0,1
    80004736:	ffffd097          	auipc	ra,0xffffd
    8000473a:	7e6080e7          	jalr	2022(ra) # 80001f1c <argaddr>
    return -1;
    8000473e:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004740:	00054d63          	bltz	a0,8000475a <sys_read+0x5c>
  return fileread(f, p, n);
    80004744:	fe442603          	lw	a2,-28(s0)
    80004748:	fd843583          	ld	a1,-40(s0)
    8000474c:	fe843503          	ld	a0,-24(s0)
    80004750:	fffff097          	auipc	ra,0xfffff
    80004754:	448080e7          	jalr	1096(ra) # 80003b98 <fileread>
    80004758:	87aa                	mv	a5,a0
}
    8000475a:	853e                	mv	a0,a5
    8000475c:	70a2                	ld	ra,40(sp)
    8000475e:	7402                	ld	s0,32(sp)
    80004760:	6145                	addi	sp,sp,48
    80004762:	8082                	ret

0000000080004764 <sys_write>:
{
    80004764:	7179                	addi	sp,sp,-48
    80004766:	f406                	sd	ra,40(sp)
    80004768:	f022                	sd	s0,32(sp)
    8000476a:	1800                	addi	s0,sp,48
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000476c:	fe840613          	addi	a2,s0,-24
    80004770:	4581                	li	a1,0
    80004772:	4501                	li	a0,0
    80004774:	00000097          	auipc	ra,0x0
    80004778:	d28080e7          	jalr	-728(ra) # 8000449c <argfd>
    return -1;
    8000477c:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    8000477e:	04054163          	bltz	a0,800047c0 <sys_write+0x5c>
    80004782:	fe440593          	addi	a1,s0,-28
    80004786:	4509                	li	a0,2
    80004788:	ffffd097          	auipc	ra,0xffffd
    8000478c:	772080e7          	jalr	1906(ra) # 80001efa <argint>
    return -1;
    80004790:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    80004792:	02054763          	bltz	a0,800047c0 <sys_write+0x5c>
    80004796:	fd840593          	addi	a1,s0,-40
    8000479a:	4505                	li	a0,1
    8000479c:	ffffd097          	auipc	ra,0xffffd
    800047a0:	780080e7          	jalr	1920(ra) # 80001f1c <argaddr>
    return -1;
    800047a4:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argint(2, &n) < 0 || argaddr(1, &p) < 0)
    800047a6:	00054d63          	bltz	a0,800047c0 <sys_write+0x5c>
  return filewrite(f, p, n);
    800047aa:	fe442603          	lw	a2,-28(s0)
    800047ae:	fd843583          	ld	a1,-40(s0)
    800047b2:	fe843503          	ld	a0,-24(s0)
    800047b6:	fffff097          	auipc	ra,0xfffff
    800047ba:	4a4080e7          	jalr	1188(ra) # 80003c5a <filewrite>
    800047be:	87aa                	mv	a5,a0
}
    800047c0:	853e                	mv	a0,a5
    800047c2:	70a2                	ld	ra,40(sp)
    800047c4:	7402                	ld	s0,32(sp)
    800047c6:	6145                	addi	sp,sp,48
    800047c8:	8082                	ret

00000000800047ca <sys_close>:
{
    800047ca:	1101                	addi	sp,sp,-32
    800047cc:	ec06                	sd	ra,24(sp)
    800047ce:	e822                	sd	s0,16(sp)
    800047d0:	1000                	addi	s0,sp,32
  if(argfd(0, &fd, &f) < 0)
    800047d2:	fe040613          	addi	a2,s0,-32
    800047d6:	fec40593          	addi	a1,s0,-20
    800047da:	4501                	li	a0,0
    800047dc:	00000097          	auipc	ra,0x0
    800047e0:	cc0080e7          	jalr	-832(ra) # 8000449c <argfd>
    return -1;
    800047e4:	57fd                	li	a5,-1
  if(argfd(0, &fd, &f) < 0)
    800047e6:	02054463          	bltz	a0,8000480e <sys_close+0x44>
  myproc()->ofile[fd] = 0;
    800047ea:	ffffc097          	auipc	ra,0xffffc
    800047ee:	65a080e7          	jalr	1626(ra) # 80000e44 <myproc>
    800047f2:	fec42783          	lw	a5,-20(s0)
    800047f6:	07e9                	addi	a5,a5,26
    800047f8:	078e                	slli	a5,a5,0x3
    800047fa:	953e                	add	a0,a0,a5
    800047fc:	00053023          	sd	zero,0(a0)
  fileclose(f);
    80004800:	fe043503          	ld	a0,-32(s0)
    80004804:	fffff097          	auipc	ra,0xfffff
    80004808:	25a080e7          	jalr	602(ra) # 80003a5e <fileclose>
  return 0;
    8000480c:	4781                	li	a5,0
}
    8000480e:	853e                	mv	a0,a5
    80004810:	60e2                	ld	ra,24(sp)
    80004812:	6442                	ld	s0,16(sp)
    80004814:	6105                	addi	sp,sp,32
    80004816:	8082                	ret

0000000080004818 <sys_fstat>:
{
    80004818:	1101                	addi	sp,sp,-32
    8000481a:	ec06                	sd	ra,24(sp)
    8000481c:	e822                	sd	s0,16(sp)
    8000481e:	1000                	addi	s0,sp,32
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004820:	fe840613          	addi	a2,s0,-24
    80004824:	4581                	li	a1,0
    80004826:	4501                	li	a0,0
    80004828:	00000097          	auipc	ra,0x0
    8000482c:	c74080e7          	jalr	-908(ra) # 8000449c <argfd>
    return -1;
    80004830:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004832:	02054563          	bltz	a0,8000485c <sys_fstat+0x44>
    80004836:	fe040593          	addi	a1,s0,-32
    8000483a:	4505                	li	a0,1
    8000483c:	ffffd097          	auipc	ra,0xffffd
    80004840:	6e0080e7          	jalr	1760(ra) # 80001f1c <argaddr>
    return -1;
    80004844:	57fd                	li	a5,-1
  if(argfd(0, 0, &f) < 0 || argaddr(1, &st) < 0)
    80004846:	00054b63          	bltz	a0,8000485c <sys_fstat+0x44>
  return filestat(f, st);
    8000484a:	fe043583          	ld	a1,-32(s0)
    8000484e:	fe843503          	ld	a0,-24(s0)
    80004852:	fffff097          	auipc	ra,0xfffff
    80004856:	2d4080e7          	jalr	724(ra) # 80003b26 <filestat>
    8000485a:	87aa                	mv	a5,a0
}
    8000485c:	853e                	mv	a0,a5
    8000485e:	60e2                	ld	ra,24(sp)
    80004860:	6442                	ld	s0,16(sp)
    80004862:	6105                	addi	sp,sp,32
    80004864:	8082                	ret

0000000080004866 <sys_link>:
{
    80004866:	7169                	addi	sp,sp,-304
    80004868:	f606                	sd	ra,296(sp)
    8000486a:	f222                	sd	s0,288(sp)
    8000486c:	ee26                	sd	s1,280(sp)
    8000486e:	ea4a                	sd	s2,272(sp)
    80004870:	1a00                	addi	s0,sp,304
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004872:	08000613          	li	a2,128
    80004876:	ed040593          	addi	a1,s0,-304
    8000487a:	4501                	li	a0,0
    8000487c:	ffffd097          	auipc	ra,0xffffd
    80004880:	6c2080e7          	jalr	1730(ra) # 80001f3e <argstr>
    return -1;
    80004884:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    80004886:	10054e63          	bltz	a0,800049a2 <sys_link+0x13c>
    8000488a:	08000613          	li	a2,128
    8000488e:	f5040593          	addi	a1,s0,-176
    80004892:	4505                	li	a0,1
    80004894:	ffffd097          	auipc	ra,0xffffd
    80004898:	6aa080e7          	jalr	1706(ra) # 80001f3e <argstr>
    return -1;
    8000489c:	57fd                	li	a5,-1
  if(argstr(0, old, MAXPATH) < 0 || argstr(1, new, MAXPATH) < 0)
    8000489e:	10054263          	bltz	a0,800049a2 <sys_link+0x13c>
  begin_op();
    800048a2:	fffff097          	auipc	ra,0xfffff
    800048a6:	cf4080e7          	jalr	-780(ra) # 80003596 <begin_op>
  if((ip = namei(old)) == 0){
    800048aa:	ed040513          	addi	a0,s0,-304
    800048ae:	fffff097          	auipc	ra,0xfffff
    800048b2:	ac8080e7          	jalr	-1336(ra) # 80003376 <namei>
    800048b6:	84aa                	mv	s1,a0
    800048b8:	c551                	beqz	a0,80004944 <sys_link+0xde>
  ilock(ip);
    800048ba:	ffffe097          	auipc	ra,0xffffe
    800048be:	27c080e7          	jalr	636(ra) # 80002b36 <ilock>
  if(ip->type == T_DIR){
    800048c2:	04449703          	lh	a4,68(s1)
    800048c6:	4785                	li	a5,1
    800048c8:	08f70463          	beq	a4,a5,80004950 <sys_link+0xea>
  ip->nlink++;
    800048cc:	04a4d783          	lhu	a5,74(s1)
    800048d0:	2785                	addiw	a5,a5,1
    800048d2:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    800048d6:	8526                	mv	a0,s1
    800048d8:	ffffe097          	auipc	ra,0xffffe
    800048dc:	192080e7          	jalr	402(ra) # 80002a6a <iupdate>
  iunlock(ip);
    800048e0:	8526                	mv	a0,s1
    800048e2:	ffffe097          	auipc	ra,0xffffe
    800048e6:	316080e7          	jalr	790(ra) # 80002bf8 <iunlock>
  if((dp = nameiparent(new, name)) == 0)
    800048ea:	fd040593          	addi	a1,s0,-48
    800048ee:	f5040513          	addi	a0,s0,-176
    800048f2:	fffff097          	auipc	ra,0xfffff
    800048f6:	aa2080e7          	jalr	-1374(ra) # 80003394 <nameiparent>
    800048fa:	892a                	mv	s2,a0
    800048fc:	c935                	beqz	a0,80004970 <sys_link+0x10a>
  ilock(dp);
    800048fe:	ffffe097          	auipc	ra,0xffffe
    80004902:	238080e7          	jalr	568(ra) # 80002b36 <ilock>
  if(dp->dev != ip->dev || dirlink(dp, name, ip->inum) < 0){
    80004906:	00092703          	lw	a4,0(s2)
    8000490a:	409c                	lw	a5,0(s1)
    8000490c:	04f71d63          	bne	a4,a5,80004966 <sys_link+0x100>
    80004910:	40d0                	lw	a2,4(s1)
    80004912:	fd040593          	addi	a1,s0,-48
    80004916:	854a                	mv	a0,s2
    80004918:	fffff097          	auipc	ra,0xfffff
    8000491c:	99c080e7          	jalr	-1636(ra) # 800032b4 <dirlink>
    80004920:	04054363          	bltz	a0,80004966 <sys_link+0x100>
  iunlockput(dp);
    80004924:	854a                	mv	a0,s2
    80004926:	ffffe097          	auipc	ra,0xffffe
    8000492a:	4be080e7          	jalr	1214(ra) # 80002de4 <iunlockput>
  iput(ip);
    8000492e:	8526                	mv	a0,s1
    80004930:	ffffe097          	auipc	ra,0xffffe
    80004934:	40c080e7          	jalr	1036(ra) # 80002d3c <iput>
  end_op();
    80004938:	fffff097          	auipc	ra,0xfffff
    8000493c:	cdc080e7          	jalr	-804(ra) # 80003614 <end_op>
  return 0;
    80004940:	4781                	li	a5,0
    80004942:	a085                	j	800049a2 <sys_link+0x13c>
    end_op();
    80004944:	fffff097          	auipc	ra,0xfffff
    80004948:	cd0080e7          	jalr	-816(ra) # 80003614 <end_op>
    return -1;
    8000494c:	57fd                	li	a5,-1
    8000494e:	a891                	j	800049a2 <sys_link+0x13c>
    iunlockput(ip);
    80004950:	8526                	mv	a0,s1
    80004952:	ffffe097          	auipc	ra,0xffffe
    80004956:	492080e7          	jalr	1170(ra) # 80002de4 <iunlockput>
    end_op();
    8000495a:	fffff097          	auipc	ra,0xfffff
    8000495e:	cba080e7          	jalr	-838(ra) # 80003614 <end_op>
    return -1;
    80004962:	57fd                	li	a5,-1
    80004964:	a83d                	j	800049a2 <sys_link+0x13c>
    iunlockput(dp);
    80004966:	854a                	mv	a0,s2
    80004968:	ffffe097          	auipc	ra,0xffffe
    8000496c:	47c080e7          	jalr	1148(ra) # 80002de4 <iunlockput>
  ilock(ip);
    80004970:	8526                	mv	a0,s1
    80004972:	ffffe097          	auipc	ra,0xffffe
    80004976:	1c4080e7          	jalr	452(ra) # 80002b36 <ilock>
  ip->nlink--;
    8000497a:	04a4d783          	lhu	a5,74(s1)
    8000497e:	37fd                	addiw	a5,a5,-1
    80004980:	04f49523          	sh	a5,74(s1)
  iupdate(ip);
    80004984:	8526                	mv	a0,s1
    80004986:	ffffe097          	auipc	ra,0xffffe
    8000498a:	0e4080e7          	jalr	228(ra) # 80002a6a <iupdate>
  iunlockput(ip);
    8000498e:	8526                	mv	a0,s1
    80004990:	ffffe097          	auipc	ra,0xffffe
    80004994:	454080e7          	jalr	1108(ra) # 80002de4 <iunlockput>
  end_op();
    80004998:	fffff097          	auipc	ra,0xfffff
    8000499c:	c7c080e7          	jalr	-900(ra) # 80003614 <end_op>
  return -1;
    800049a0:	57fd                	li	a5,-1
}
    800049a2:	853e                	mv	a0,a5
    800049a4:	70b2                	ld	ra,296(sp)
    800049a6:	7412                	ld	s0,288(sp)
    800049a8:	64f2                	ld	s1,280(sp)
    800049aa:	6952                	ld	s2,272(sp)
    800049ac:	6155                	addi	sp,sp,304
    800049ae:	8082                	ret

00000000800049b0 <sys_unlink>:
{
    800049b0:	7151                	addi	sp,sp,-240
    800049b2:	f586                	sd	ra,232(sp)
    800049b4:	f1a2                	sd	s0,224(sp)
    800049b6:	eda6                	sd	s1,216(sp)
    800049b8:	e9ca                	sd	s2,208(sp)
    800049ba:	e5ce                	sd	s3,200(sp)
    800049bc:	1980                	addi	s0,sp,240
  if(argstr(0, path, MAXPATH) < 0)
    800049be:	08000613          	li	a2,128
    800049c2:	f3040593          	addi	a1,s0,-208
    800049c6:	4501                	li	a0,0
    800049c8:	ffffd097          	auipc	ra,0xffffd
    800049cc:	576080e7          	jalr	1398(ra) # 80001f3e <argstr>
    800049d0:	18054163          	bltz	a0,80004b52 <sys_unlink+0x1a2>
  begin_op();
    800049d4:	fffff097          	auipc	ra,0xfffff
    800049d8:	bc2080e7          	jalr	-1086(ra) # 80003596 <begin_op>
  if((dp = nameiparent(path, name)) == 0){
    800049dc:	fb040593          	addi	a1,s0,-80
    800049e0:	f3040513          	addi	a0,s0,-208
    800049e4:	fffff097          	auipc	ra,0xfffff
    800049e8:	9b0080e7          	jalr	-1616(ra) # 80003394 <nameiparent>
    800049ec:	84aa                	mv	s1,a0
    800049ee:	c979                	beqz	a0,80004ac4 <sys_unlink+0x114>
  ilock(dp);
    800049f0:	ffffe097          	auipc	ra,0xffffe
    800049f4:	146080e7          	jalr	326(ra) # 80002b36 <ilock>
  if(namecmp(name, ".") == 0 || namecmp(name, "..") == 0)
    800049f8:	00004597          	auipc	a1,0x4
    800049fc:	df058593          	addi	a1,a1,-528 # 800087e8 <syscalls+0x420>
    80004a00:	fb040513          	addi	a0,s0,-80
    80004a04:	ffffe097          	auipc	ra,0xffffe
    80004a08:	680080e7          	jalr	1664(ra) # 80003084 <namecmp>
    80004a0c:	14050a63          	beqz	a0,80004b60 <sys_unlink+0x1b0>
    80004a10:	00004597          	auipc	a1,0x4
    80004a14:	de058593          	addi	a1,a1,-544 # 800087f0 <syscalls+0x428>
    80004a18:	fb040513          	addi	a0,s0,-80
    80004a1c:	ffffe097          	auipc	ra,0xffffe
    80004a20:	668080e7          	jalr	1640(ra) # 80003084 <namecmp>
    80004a24:	12050e63          	beqz	a0,80004b60 <sys_unlink+0x1b0>
  if((ip = dirlookup(dp, name, &off)) == 0)
    80004a28:	f2c40613          	addi	a2,s0,-212
    80004a2c:	fb040593          	addi	a1,s0,-80
    80004a30:	8526                	mv	a0,s1
    80004a32:	ffffe097          	auipc	ra,0xffffe
    80004a36:	66c080e7          	jalr	1644(ra) # 8000309e <dirlookup>
    80004a3a:	892a                	mv	s2,a0
    80004a3c:	12050263          	beqz	a0,80004b60 <sys_unlink+0x1b0>
  ilock(ip);
    80004a40:	ffffe097          	auipc	ra,0xffffe
    80004a44:	0f6080e7          	jalr	246(ra) # 80002b36 <ilock>
  if(ip->nlink < 1)
    80004a48:	04a91783          	lh	a5,74(s2)
    80004a4c:	08f05263          	blez	a5,80004ad0 <sys_unlink+0x120>
  if(ip->type == T_DIR && !isdirempty(ip)){
    80004a50:	04491703          	lh	a4,68(s2)
    80004a54:	4785                	li	a5,1
    80004a56:	08f70563          	beq	a4,a5,80004ae0 <sys_unlink+0x130>
  memset(&de, 0, sizeof(de));
    80004a5a:	4641                	li	a2,16
    80004a5c:	4581                	li	a1,0
    80004a5e:	fc040513          	addi	a0,s0,-64
    80004a62:	ffffb097          	auipc	ra,0xffffb
    80004a66:	718080e7          	jalr	1816(ra) # 8000017a <memset>
  if(writei(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004a6a:	4741                	li	a4,16
    80004a6c:	f2c42683          	lw	a3,-212(s0)
    80004a70:	fc040613          	addi	a2,s0,-64
    80004a74:	4581                	li	a1,0
    80004a76:	8526                	mv	a0,s1
    80004a78:	ffffe097          	auipc	ra,0xffffe
    80004a7c:	4b6080e7          	jalr	1206(ra) # 80002f2e <writei>
    80004a80:	47c1                	li	a5,16
    80004a82:	0af51563          	bne	a0,a5,80004b2c <sys_unlink+0x17c>
  if(ip->type == T_DIR){
    80004a86:	04491703          	lh	a4,68(s2)
    80004a8a:	4785                	li	a5,1
    80004a8c:	0af70863          	beq	a4,a5,80004b3c <sys_unlink+0x18c>
  iunlockput(dp);
    80004a90:	8526                	mv	a0,s1
    80004a92:	ffffe097          	auipc	ra,0xffffe
    80004a96:	352080e7          	jalr	850(ra) # 80002de4 <iunlockput>
  ip->nlink--;
    80004a9a:	04a95783          	lhu	a5,74(s2)
    80004a9e:	37fd                	addiw	a5,a5,-1
    80004aa0:	04f91523          	sh	a5,74(s2)
  iupdate(ip);
    80004aa4:	854a                	mv	a0,s2
    80004aa6:	ffffe097          	auipc	ra,0xffffe
    80004aaa:	fc4080e7          	jalr	-60(ra) # 80002a6a <iupdate>
  iunlockput(ip);
    80004aae:	854a                	mv	a0,s2
    80004ab0:	ffffe097          	auipc	ra,0xffffe
    80004ab4:	334080e7          	jalr	820(ra) # 80002de4 <iunlockput>
  end_op();
    80004ab8:	fffff097          	auipc	ra,0xfffff
    80004abc:	b5c080e7          	jalr	-1188(ra) # 80003614 <end_op>
  return 0;
    80004ac0:	4501                	li	a0,0
    80004ac2:	a84d                	j	80004b74 <sys_unlink+0x1c4>
    end_op();
    80004ac4:	fffff097          	auipc	ra,0xfffff
    80004ac8:	b50080e7          	jalr	-1200(ra) # 80003614 <end_op>
    return -1;
    80004acc:	557d                	li	a0,-1
    80004ace:	a05d                	j	80004b74 <sys_unlink+0x1c4>
    panic("unlink: nlink < 1");
    80004ad0:	00004517          	auipc	a0,0x4
    80004ad4:	d4850513          	addi	a0,a0,-696 # 80008818 <syscalls+0x450>
    80004ad8:	00001097          	auipc	ra,0x1
    80004adc:	198080e7          	jalr	408(ra) # 80005c70 <panic>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004ae0:	04c92703          	lw	a4,76(s2)
    80004ae4:	02000793          	li	a5,32
    80004ae8:	f6e7f9e3          	bgeu	a5,a4,80004a5a <sys_unlink+0xaa>
    80004aec:	02000993          	li	s3,32
    if(readi(dp, 0, (uint64)&de, off, sizeof(de)) != sizeof(de))
    80004af0:	4741                	li	a4,16
    80004af2:	86ce                	mv	a3,s3
    80004af4:	f1840613          	addi	a2,s0,-232
    80004af8:	4581                	li	a1,0
    80004afa:	854a                	mv	a0,s2
    80004afc:	ffffe097          	auipc	ra,0xffffe
    80004b00:	33a080e7          	jalr	826(ra) # 80002e36 <readi>
    80004b04:	47c1                	li	a5,16
    80004b06:	00f51b63          	bne	a0,a5,80004b1c <sys_unlink+0x16c>
    if(de.inum != 0)
    80004b0a:	f1845783          	lhu	a5,-232(s0)
    80004b0e:	e7a1                	bnez	a5,80004b56 <sys_unlink+0x1a6>
  for(off=2*sizeof(de); off<dp->size; off+=sizeof(de)){
    80004b10:	29c1                	addiw	s3,s3,16
    80004b12:	04c92783          	lw	a5,76(s2)
    80004b16:	fcf9ede3          	bltu	s3,a5,80004af0 <sys_unlink+0x140>
    80004b1a:	b781                	j	80004a5a <sys_unlink+0xaa>
      panic("isdirempty: readi");
    80004b1c:	00004517          	auipc	a0,0x4
    80004b20:	d1450513          	addi	a0,a0,-748 # 80008830 <syscalls+0x468>
    80004b24:	00001097          	auipc	ra,0x1
    80004b28:	14c080e7          	jalr	332(ra) # 80005c70 <panic>
    panic("unlink: writei");
    80004b2c:	00004517          	auipc	a0,0x4
    80004b30:	d1c50513          	addi	a0,a0,-740 # 80008848 <syscalls+0x480>
    80004b34:	00001097          	auipc	ra,0x1
    80004b38:	13c080e7          	jalr	316(ra) # 80005c70 <panic>
    dp->nlink--;
    80004b3c:	04a4d783          	lhu	a5,74(s1)
    80004b40:	37fd                	addiw	a5,a5,-1
    80004b42:	04f49523          	sh	a5,74(s1)
    iupdate(dp);
    80004b46:	8526                	mv	a0,s1
    80004b48:	ffffe097          	auipc	ra,0xffffe
    80004b4c:	f22080e7          	jalr	-222(ra) # 80002a6a <iupdate>
    80004b50:	b781                	j	80004a90 <sys_unlink+0xe0>
    return -1;
    80004b52:	557d                	li	a0,-1
    80004b54:	a005                	j	80004b74 <sys_unlink+0x1c4>
    iunlockput(ip);
    80004b56:	854a                	mv	a0,s2
    80004b58:	ffffe097          	auipc	ra,0xffffe
    80004b5c:	28c080e7          	jalr	652(ra) # 80002de4 <iunlockput>
  iunlockput(dp);
    80004b60:	8526                	mv	a0,s1
    80004b62:	ffffe097          	auipc	ra,0xffffe
    80004b66:	282080e7          	jalr	642(ra) # 80002de4 <iunlockput>
  end_op();
    80004b6a:	fffff097          	auipc	ra,0xfffff
    80004b6e:	aaa080e7          	jalr	-1366(ra) # 80003614 <end_op>
  return -1;
    80004b72:	557d                	li	a0,-1
}
    80004b74:	70ae                	ld	ra,232(sp)
    80004b76:	740e                	ld	s0,224(sp)
    80004b78:	64ee                	ld	s1,216(sp)
    80004b7a:	694e                	ld	s2,208(sp)
    80004b7c:	69ae                	ld	s3,200(sp)
    80004b7e:	616d                	addi	sp,sp,240
    80004b80:	8082                	ret

0000000080004b82 <sys_open>:

uint64
sys_open(void)
{
    80004b82:	7131                	addi	sp,sp,-192
    80004b84:	fd06                	sd	ra,184(sp)
    80004b86:	f922                	sd	s0,176(sp)
    80004b88:	f526                	sd	s1,168(sp)
    80004b8a:	f14a                	sd	s2,160(sp)
    80004b8c:	ed4e                	sd	s3,152(sp)
    80004b8e:	0180                	addi	s0,sp,192
  int fd, omode;
  struct file *f;
  struct inode *ip;
  int n;

  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004b90:	08000613          	li	a2,128
    80004b94:	f5040593          	addi	a1,s0,-176
    80004b98:	4501                	li	a0,0
    80004b9a:	ffffd097          	auipc	ra,0xffffd
    80004b9e:	3a4080e7          	jalr	932(ra) # 80001f3e <argstr>
    return -1;
    80004ba2:	54fd                	li	s1,-1
  if((n = argstr(0, path, MAXPATH)) < 0 || argint(1, &omode) < 0)
    80004ba4:	0c054163          	bltz	a0,80004c66 <sys_open+0xe4>
    80004ba8:	f4c40593          	addi	a1,s0,-180
    80004bac:	4505                	li	a0,1
    80004bae:	ffffd097          	auipc	ra,0xffffd
    80004bb2:	34c080e7          	jalr	844(ra) # 80001efa <argint>
    80004bb6:	0a054863          	bltz	a0,80004c66 <sys_open+0xe4>

  begin_op();
    80004bba:	fffff097          	auipc	ra,0xfffff
    80004bbe:	9dc080e7          	jalr	-1572(ra) # 80003596 <begin_op>

  if(omode & O_CREATE){
    80004bc2:	f4c42783          	lw	a5,-180(s0)
    80004bc6:	2007f793          	andi	a5,a5,512
    80004bca:	cbdd                	beqz	a5,80004c80 <sys_open+0xfe>
    ip = create(path, T_FILE, 0, 0);
    80004bcc:	4681                	li	a3,0
    80004bce:	4601                	li	a2,0
    80004bd0:	4589                	li	a1,2
    80004bd2:	f5040513          	addi	a0,s0,-176
    80004bd6:	00000097          	auipc	ra,0x0
    80004bda:	970080e7          	jalr	-1680(ra) # 80004546 <create>
    80004bde:	892a                	mv	s2,a0
    if(ip == 0){
    80004be0:	c959                	beqz	a0,80004c76 <sys_open+0xf4>
      end_op();
      return -1;
    }
  }

  if(ip->type == T_DEVICE && (ip->major < 0 || ip->major >= NDEV)){
    80004be2:	04491703          	lh	a4,68(s2)
    80004be6:	478d                	li	a5,3
    80004be8:	00f71763          	bne	a4,a5,80004bf6 <sys_open+0x74>
    80004bec:	04695703          	lhu	a4,70(s2)
    80004bf0:	47a5                	li	a5,9
    80004bf2:	0ce7ec63          	bltu	a5,a4,80004cca <sys_open+0x148>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if((f = filealloc()) == 0 || (fd = fdalloc(f)) < 0){
    80004bf6:	fffff097          	auipc	ra,0xfffff
    80004bfa:	dac080e7          	jalr	-596(ra) # 800039a2 <filealloc>
    80004bfe:	89aa                	mv	s3,a0
    80004c00:	10050263          	beqz	a0,80004d04 <sys_open+0x182>
    80004c04:	00000097          	auipc	ra,0x0
    80004c08:	900080e7          	jalr	-1792(ra) # 80004504 <fdalloc>
    80004c0c:	84aa                	mv	s1,a0
    80004c0e:	0e054663          	bltz	a0,80004cfa <sys_open+0x178>
    iunlockput(ip);
    end_op();
    return -1;
  }

  if(ip->type == T_DEVICE){
    80004c12:	04491703          	lh	a4,68(s2)
    80004c16:	478d                	li	a5,3
    80004c18:	0cf70463          	beq	a4,a5,80004ce0 <sys_open+0x15e>
    f->type = FD_DEVICE;
    f->major = ip->major;
  } else {
    f->type = FD_INODE;
    80004c1c:	4789                	li	a5,2
    80004c1e:	00f9a023          	sw	a5,0(s3)
    f->off = 0;
    80004c22:	0209a023          	sw	zero,32(s3)
  }
  f->ip = ip;
    80004c26:	0129bc23          	sd	s2,24(s3)
  f->readable = !(omode & O_WRONLY);
    80004c2a:	f4c42783          	lw	a5,-180(s0)
    80004c2e:	0017c713          	xori	a4,a5,1
    80004c32:	8b05                	andi	a4,a4,1
    80004c34:	00e98423          	sb	a4,8(s3)
  f->writable = (omode & O_WRONLY) || (omode & O_RDWR);
    80004c38:	0037f713          	andi	a4,a5,3
    80004c3c:	00e03733          	snez	a4,a4
    80004c40:	00e984a3          	sb	a4,9(s3)

  if((omode & O_TRUNC) && ip->type == T_FILE){
    80004c44:	4007f793          	andi	a5,a5,1024
    80004c48:	c791                	beqz	a5,80004c54 <sys_open+0xd2>
    80004c4a:	04491703          	lh	a4,68(s2)
    80004c4e:	4789                	li	a5,2
    80004c50:	08f70f63          	beq	a4,a5,80004cee <sys_open+0x16c>
    itrunc(ip);
  }

  iunlock(ip);
    80004c54:	854a                	mv	a0,s2
    80004c56:	ffffe097          	auipc	ra,0xffffe
    80004c5a:	fa2080e7          	jalr	-94(ra) # 80002bf8 <iunlock>
  end_op();
    80004c5e:	fffff097          	auipc	ra,0xfffff
    80004c62:	9b6080e7          	jalr	-1610(ra) # 80003614 <end_op>

  return fd;
}
    80004c66:	8526                	mv	a0,s1
    80004c68:	70ea                	ld	ra,184(sp)
    80004c6a:	744a                	ld	s0,176(sp)
    80004c6c:	74aa                	ld	s1,168(sp)
    80004c6e:	790a                	ld	s2,160(sp)
    80004c70:	69ea                	ld	s3,152(sp)
    80004c72:	6129                	addi	sp,sp,192
    80004c74:	8082                	ret
      end_op();
    80004c76:	fffff097          	auipc	ra,0xfffff
    80004c7a:	99e080e7          	jalr	-1634(ra) # 80003614 <end_op>
      return -1;
    80004c7e:	b7e5                	j	80004c66 <sys_open+0xe4>
    if((ip = namei(path)) == 0){
    80004c80:	f5040513          	addi	a0,s0,-176
    80004c84:	ffffe097          	auipc	ra,0xffffe
    80004c88:	6f2080e7          	jalr	1778(ra) # 80003376 <namei>
    80004c8c:	892a                	mv	s2,a0
    80004c8e:	c905                	beqz	a0,80004cbe <sys_open+0x13c>
    ilock(ip);
    80004c90:	ffffe097          	auipc	ra,0xffffe
    80004c94:	ea6080e7          	jalr	-346(ra) # 80002b36 <ilock>
    if(ip->type == T_DIR && omode != O_RDONLY){
    80004c98:	04491703          	lh	a4,68(s2)
    80004c9c:	4785                	li	a5,1
    80004c9e:	f4f712e3          	bne	a4,a5,80004be2 <sys_open+0x60>
    80004ca2:	f4c42783          	lw	a5,-180(s0)
    80004ca6:	dba1                	beqz	a5,80004bf6 <sys_open+0x74>
      iunlockput(ip);
    80004ca8:	854a                	mv	a0,s2
    80004caa:	ffffe097          	auipc	ra,0xffffe
    80004cae:	13a080e7          	jalr	314(ra) # 80002de4 <iunlockput>
      end_op();
    80004cb2:	fffff097          	auipc	ra,0xfffff
    80004cb6:	962080e7          	jalr	-1694(ra) # 80003614 <end_op>
      return -1;
    80004cba:	54fd                	li	s1,-1
    80004cbc:	b76d                	j	80004c66 <sys_open+0xe4>
      end_op();
    80004cbe:	fffff097          	auipc	ra,0xfffff
    80004cc2:	956080e7          	jalr	-1706(ra) # 80003614 <end_op>
      return -1;
    80004cc6:	54fd                	li	s1,-1
    80004cc8:	bf79                	j	80004c66 <sys_open+0xe4>
    iunlockput(ip);
    80004cca:	854a                	mv	a0,s2
    80004ccc:	ffffe097          	auipc	ra,0xffffe
    80004cd0:	118080e7          	jalr	280(ra) # 80002de4 <iunlockput>
    end_op();
    80004cd4:	fffff097          	auipc	ra,0xfffff
    80004cd8:	940080e7          	jalr	-1728(ra) # 80003614 <end_op>
    return -1;
    80004cdc:	54fd                	li	s1,-1
    80004cde:	b761                	j	80004c66 <sys_open+0xe4>
    f->type = FD_DEVICE;
    80004ce0:	00f9a023          	sw	a5,0(s3)
    f->major = ip->major;
    80004ce4:	04691783          	lh	a5,70(s2)
    80004ce8:	02f99223          	sh	a5,36(s3)
    80004cec:	bf2d                	j	80004c26 <sys_open+0xa4>
    itrunc(ip);
    80004cee:	854a                	mv	a0,s2
    80004cf0:	ffffe097          	auipc	ra,0xffffe
    80004cf4:	f54080e7          	jalr	-172(ra) # 80002c44 <itrunc>
    80004cf8:	bfb1                	j	80004c54 <sys_open+0xd2>
      fileclose(f);
    80004cfa:	854e                	mv	a0,s3
    80004cfc:	fffff097          	auipc	ra,0xfffff
    80004d00:	d62080e7          	jalr	-670(ra) # 80003a5e <fileclose>
    iunlockput(ip);
    80004d04:	854a                	mv	a0,s2
    80004d06:	ffffe097          	auipc	ra,0xffffe
    80004d0a:	0de080e7          	jalr	222(ra) # 80002de4 <iunlockput>
    end_op();
    80004d0e:	fffff097          	auipc	ra,0xfffff
    80004d12:	906080e7          	jalr	-1786(ra) # 80003614 <end_op>
    return -1;
    80004d16:	54fd                	li	s1,-1
    80004d18:	b7b9                	j	80004c66 <sys_open+0xe4>

0000000080004d1a <sys_mkdir>:

uint64
sys_mkdir(void)
{
    80004d1a:	7175                	addi	sp,sp,-144
    80004d1c:	e506                	sd	ra,136(sp)
    80004d1e:	e122                	sd	s0,128(sp)
    80004d20:	0900                	addi	s0,sp,144
  char path[MAXPATH];
  struct inode *ip;

  begin_op();
    80004d22:	fffff097          	auipc	ra,0xfffff
    80004d26:	874080e7          	jalr	-1932(ra) # 80003596 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = create(path, T_DIR, 0, 0)) == 0){
    80004d2a:	08000613          	li	a2,128
    80004d2e:	f7040593          	addi	a1,s0,-144
    80004d32:	4501                	li	a0,0
    80004d34:	ffffd097          	auipc	ra,0xffffd
    80004d38:	20a080e7          	jalr	522(ra) # 80001f3e <argstr>
    80004d3c:	02054963          	bltz	a0,80004d6e <sys_mkdir+0x54>
    80004d40:	4681                	li	a3,0
    80004d42:	4601                	li	a2,0
    80004d44:	4585                	li	a1,1
    80004d46:	f7040513          	addi	a0,s0,-144
    80004d4a:	fffff097          	auipc	ra,0xfffff
    80004d4e:	7fc080e7          	jalr	2044(ra) # 80004546 <create>
    80004d52:	cd11                	beqz	a0,80004d6e <sys_mkdir+0x54>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004d54:	ffffe097          	auipc	ra,0xffffe
    80004d58:	090080e7          	jalr	144(ra) # 80002de4 <iunlockput>
  end_op();
    80004d5c:	fffff097          	auipc	ra,0xfffff
    80004d60:	8b8080e7          	jalr	-1864(ra) # 80003614 <end_op>
  return 0;
    80004d64:	4501                	li	a0,0
}
    80004d66:	60aa                	ld	ra,136(sp)
    80004d68:	640a                	ld	s0,128(sp)
    80004d6a:	6149                	addi	sp,sp,144
    80004d6c:	8082                	ret
    end_op();
    80004d6e:	fffff097          	auipc	ra,0xfffff
    80004d72:	8a6080e7          	jalr	-1882(ra) # 80003614 <end_op>
    return -1;
    80004d76:	557d                	li	a0,-1
    80004d78:	b7fd                	j	80004d66 <sys_mkdir+0x4c>

0000000080004d7a <sys_mknod>:

uint64
sys_mknod(void)
{
    80004d7a:	7135                	addi	sp,sp,-160
    80004d7c:	ed06                	sd	ra,152(sp)
    80004d7e:	e922                	sd	s0,144(sp)
    80004d80:	1100                	addi	s0,sp,160
  struct inode *ip;
  char path[MAXPATH];
  int major, minor;

  begin_op();
    80004d82:	fffff097          	auipc	ra,0xfffff
    80004d86:	814080e7          	jalr	-2028(ra) # 80003596 <begin_op>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004d8a:	08000613          	li	a2,128
    80004d8e:	f7040593          	addi	a1,s0,-144
    80004d92:	4501                	li	a0,0
    80004d94:	ffffd097          	auipc	ra,0xffffd
    80004d98:	1aa080e7          	jalr	426(ra) # 80001f3e <argstr>
    80004d9c:	04054a63          	bltz	a0,80004df0 <sys_mknod+0x76>
     argint(1, &major) < 0 ||
    80004da0:	f6c40593          	addi	a1,s0,-148
    80004da4:	4505                	li	a0,1
    80004da6:	ffffd097          	auipc	ra,0xffffd
    80004daa:	154080e7          	jalr	340(ra) # 80001efa <argint>
  if((argstr(0, path, MAXPATH)) < 0 ||
    80004dae:	04054163          	bltz	a0,80004df0 <sys_mknod+0x76>
     argint(2, &minor) < 0 ||
    80004db2:	f6840593          	addi	a1,s0,-152
    80004db6:	4509                	li	a0,2
    80004db8:	ffffd097          	auipc	ra,0xffffd
    80004dbc:	142080e7          	jalr	322(ra) # 80001efa <argint>
     argint(1, &major) < 0 ||
    80004dc0:	02054863          	bltz	a0,80004df0 <sys_mknod+0x76>
     (ip = create(path, T_DEVICE, major, minor)) == 0){
    80004dc4:	f6841683          	lh	a3,-152(s0)
    80004dc8:	f6c41603          	lh	a2,-148(s0)
    80004dcc:	458d                	li	a1,3
    80004dce:	f7040513          	addi	a0,s0,-144
    80004dd2:	fffff097          	auipc	ra,0xfffff
    80004dd6:	774080e7          	jalr	1908(ra) # 80004546 <create>
     argint(2, &minor) < 0 ||
    80004dda:	c919                	beqz	a0,80004df0 <sys_mknod+0x76>
    end_op();
    return -1;
  }
  iunlockput(ip);
    80004ddc:	ffffe097          	auipc	ra,0xffffe
    80004de0:	008080e7          	jalr	8(ra) # 80002de4 <iunlockput>
  end_op();
    80004de4:	fffff097          	auipc	ra,0xfffff
    80004de8:	830080e7          	jalr	-2000(ra) # 80003614 <end_op>
  return 0;
    80004dec:	4501                	li	a0,0
    80004dee:	a031                	j	80004dfa <sys_mknod+0x80>
    end_op();
    80004df0:	fffff097          	auipc	ra,0xfffff
    80004df4:	824080e7          	jalr	-2012(ra) # 80003614 <end_op>
    return -1;
    80004df8:	557d                	li	a0,-1
}
    80004dfa:	60ea                	ld	ra,152(sp)
    80004dfc:	644a                	ld	s0,144(sp)
    80004dfe:	610d                	addi	sp,sp,160
    80004e00:	8082                	ret

0000000080004e02 <sys_chdir>:

uint64
sys_chdir(void)
{
    80004e02:	7135                	addi	sp,sp,-160
    80004e04:	ed06                	sd	ra,152(sp)
    80004e06:	e922                	sd	s0,144(sp)
    80004e08:	e526                	sd	s1,136(sp)
    80004e0a:	e14a                	sd	s2,128(sp)
    80004e0c:	1100                	addi	s0,sp,160
  char path[MAXPATH];
  struct inode *ip;
  struct proc *p = myproc();
    80004e0e:	ffffc097          	auipc	ra,0xffffc
    80004e12:	036080e7          	jalr	54(ra) # 80000e44 <myproc>
    80004e16:	892a                	mv	s2,a0
  
  begin_op();
    80004e18:	ffffe097          	auipc	ra,0xffffe
    80004e1c:	77e080e7          	jalr	1918(ra) # 80003596 <begin_op>
  if(argstr(0, path, MAXPATH) < 0 || (ip = namei(path)) == 0){
    80004e20:	08000613          	li	a2,128
    80004e24:	f6040593          	addi	a1,s0,-160
    80004e28:	4501                	li	a0,0
    80004e2a:	ffffd097          	auipc	ra,0xffffd
    80004e2e:	114080e7          	jalr	276(ra) # 80001f3e <argstr>
    80004e32:	04054b63          	bltz	a0,80004e88 <sys_chdir+0x86>
    80004e36:	f6040513          	addi	a0,s0,-160
    80004e3a:	ffffe097          	auipc	ra,0xffffe
    80004e3e:	53c080e7          	jalr	1340(ra) # 80003376 <namei>
    80004e42:	84aa                	mv	s1,a0
    80004e44:	c131                	beqz	a0,80004e88 <sys_chdir+0x86>
    end_op();
    return -1;
  }
  ilock(ip);
    80004e46:	ffffe097          	auipc	ra,0xffffe
    80004e4a:	cf0080e7          	jalr	-784(ra) # 80002b36 <ilock>
  if(ip->type != T_DIR){
    80004e4e:	04449703          	lh	a4,68(s1)
    80004e52:	4785                	li	a5,1
    80004e54:	04f71063          	bne	a4,a5,80004e94 <sys_chdir+0x92>
    iunlockput(ip);
    end_op();
    return -1;
  }
  iunlock(ip);
    80004e58:	8526                	mv	a0,s1
    80004e5a:	ffffe097          	auipc	ra,0xffffe
    80004e5e:	d9e080e7          	jalr	-610(ra) # 80002bf8 <iunlock>
  iput(p->cwd);
    80004e62:	15093503          	ld	a0,336(s2)
    80004e66:	ffffe097          	auipc	ra,0xffffe
    80004e6a:	ed6080e7          	jalr	-298(ra) # 80002d3c <iput>
  end_op();
    80004e6e:	ffffe097          	auipc	ra,0xffffe
    80004e72:	7a6080e7          	jalr	1958(ra) # 80003614 <end_op>
  p->cwd = ip;
    80004e76:	14993823          	sd	s1,336(s2)
  return 0;
    80004e7a:	4501                	li	a0,0
}
    80004e7c:	60ea                	ld	ra,152(sp)
    80004e7e:	644a                	ld	s0,144(sp)
    80004e80:	64aa                	ld	s1,136(sp)
    80004e82:	690a                	ld	s2,128(sp)
    80004e84:	610d                	addi	sp,sp,160
    80004e86:	8082                	ret
    end_op();
    80004e88:	ffffe097          	auipc	ra,0xffffe
    80004e8c:	78c080e7          	jalr	1932(ra) # 80003614 <end_op>
    return -1;
    80004e90:	557d                	li	a0,-1
    80004e92:	b7ed                	j	80004e7c <sys_chdir+0x7a>
    iunlockput(ip);
    80004e94:	8526                	mv	a0,s1
    80004e96:	ffffe097          	auipc	ra,0xffffe
    80004e9a:	f4e080e7          	jalr	-178(ra) # 80002de4 <iunlockput>
    end_op();
    80004e9e:	ffffe097          	auipc	ra,0xffffe
    80004ea2:	776080e7          	jalr	1910(ra) # 80003614 <end_op>
    return -1;
    80004ea6:	557d                	li	a0,-1
    80004ea8:	bfd1                	j	80004e7c <sys_chdir+0x7a>

0000000080004eaa <sys_exec>:

uint64
sys_exec(void)
{
    80004eaa:	7145                	addi	sp,sp,-464
    80004eac:	e786                	sd	ra,456(sp)
    80004eae:	e3a2                	sd	s0,448(sp)
    80004eb0:	ff26                	sd	s1,440(sp)
    80004eb2:	fb4a                	sd	s2,432(sp)
    80004eb4:	f74e                	sd	s3,424(sp)
    80004eb6:	f352                	sd	s4,416(sp)
    80004eb8:	ef56                	sd	s5,408(sp)
    80004eba:	0b80                	addi	s0,sp,464
  char path[MAXPATH], *argv[MAXARG];
  int i;
  uint64 uargv, uarg;

  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004ebc:	08000613          	li	a2,128
    80004ec0:	f4040593          	addi	a1,s0,-192
    80004ec4:	4501                	li	a0,0
    80004ec6:	ffffd097          	auipc	ra,0xffffd
    80004eca:	078080e7          	jalr	120(ra) # 80001f3e <argstr>
    return -1;
    80004ece:	597d                	li	s2,-1
  if(argstr(0, path, MAXPATH) < 0 || argaddr(1, &uargv) < 0){
    80004ed0:	0c054b63          	bltz	a0,80004fa6 <sys_exec+0xfc>
    80004ed4:	e3840593          	addi	a1,s0,-456
    80004ed8:	4505                	li	a0,1
    80004eda:	ffffd097          	auipc	ra,0xffffd
    80004ede:	042080e7          	jalr	66(ra) # 80001f1c <argaddr>
    80004ee2:	0c054263          	bltz	a0,80004fa6 <sys_exec+0xfc>
  }
  memset(argv, 0, sizeof(argv));
    80004ee6:	10000613          	li	a2,256
    80004eea:	4581                	li	a1,0
    80004eec:	e4040513          	addi	a0,s0,-448
    80004ef0:	ffffb097          	auipc	ra,0xffffb
    80004ef4:	28a080e7          	jalr	650(ra) # 8000017a <memset>
  for(i=0;; i++){
    if(i >= NELEM(argv)){
    80004ef8:	e4040493          	addi	s1,s0,-448
  memset(argv, 0, sizeof(argv));
    80004efc:	89a6                	mv	s3,s1
    80004efe:	4901                	li	s2,0
    if(i >= NELEM(argv)){
    80004f00:	02000a13          	li	s4,32
    80004f04:	00090a9b          	sext.w	s5,s2
      goto bad;
    }
    if(fetchaddr(uargv+sizeof(uint64)*i, (uint64*)&uarg) < 0){
    80004f08:	00391513          	slli	a0,s2,0x3
    80004f0c:	e3040593          	addi	a1,s0,-464
    80004f10:	e3843783          	ld	a5,-456(s0)
    80004f14:	953e                	add	a0,a0,a5
    80004f16:	ffffd097          	auipc	ra,0xffffd
    80004f1a:	f4a080e7          	jalr	-182(ra) # 80001e60 <fetchaddr>
    80004f1e:	02054a63          	bltz	a0,80004f52 <sys_exec+0xa8>
      goto bad;
    }
    if(uarg == 0){
    80004f22:	e3043783          	ld	a5,-464(s0)
    80004f26:	c3b9                	beqz	a5,80004f6c <sys_exec+0xc2>
      argv[i] = 0;
      break;
    }
    argv[i] = kalloc();
    80004f28:	ffffb097          	auipc	ra,0xffffb
    80004f2c:	1f2080e7          	jalr	498(ra) # 8000011a <kalloc>
    80004f30:	85aa                	mv	a1,a0
    80004f32:	00a9b023          	sd	a0,0(s3)
    if(argv[i] == 0)
    80004f36:	cd11                	beqz	a0,80004f52 <sys_exec+0xa8>
      goto bad;
    if(fetchstr(uarg, argv[i], PGSIZE) < 0)
    80004f38:	6605                	lui	a2,0x1
    80004f3a:	e3043503          	ld	a0,-464(s0)
    80004f3e:	ffffd097          	auipc	ra,0xffffd
    80004f42:	f74080e7          	jalr	-140(ra) # 80001eb2 <fetchstr>
    80004f46:	00054663          	bltz	a0,80004f52 <sys_exec+0xa8>
    if(i >= NELEM(argv)){
    80004f4a:	0905                	addi	s2,s2,1
    80004f4c:	09a1                	addi	s3,s3,8
    80004f4e:	fb491be3          	bne	s2,s4,80004f04 <sys_exec+0x5a>
    kfree(argv[i]);

  return ret;

 bad:
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f52:	f4040913          	addi	s2,s0,-192
    80004f56:	6088                	ld	a0,0(s1)
    80004f58:	c531                	beqz	a0,80004fa4 <sys_exec+0xfa>
    kfree(argv[i]);
    80004f5a:	ffffb097          	auipc	ra,0xffffb
    80004f5e:	0c2080e7          	jalr	194(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f62:	04a1                	addi	s1,s1,8
    80004f64:	ff2499e3          	bne	s1,s2,80004f56 <sys_exec+0xac>
  return -1;
    80004f68:	597d                	li	s2,-1
    80004f6a:	a835                	j	80004fa6 <sys_exec+0xfc>
      argv[i] = 0;
    80004f6c:	0a8e                	slli	s5,s5,0x3
    80004f6e:	fc0a8793          	addi	a5,s5,-64 # ffffffffffffefc0 <end+0xffffffff7ffd1d80>
    80004f72:	00878ab3          	add	s5,a5,s0
    80004f76:	e80ab023          	sd	zero,-384(s5)
  int ret = exec(path, argv);
    80004f7a:	e4040593          	addi	a1,s0,-448
    80004f7e:	f4040513          	addi	a0,s0,-192
    80004f82:	fffff097          	auipc	ra,0xfffff
    80004f86:	172080e7          	jalr	370(ra) # 800040f4 <exec>
    80004f8a:	892a                	mv	s2,a0
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f8c:	f4040993          	addi	s3,s0,-192
    80004f90:	6088                	ld	a0,0(s1)
    80004f92:	c911                	beqz	a0,80004fa6 <sys_exec+0xfc>
    kfree(argv[i]);
    80004f94:	ffffb097          	auipc	ra,0xffffb
    80004f98:	088080e7          	jalr	136(ra) # 8000001c <kfree>
  for(i = 0; i < NELEM(argv) && argv[i] != 0; i++)
    80004f9c:	04a1                	addi	s1,s1,8
    80004f9e:	ff3499e3          	bne	s1,s3,80004f90 <sys_exec+0xe6>
    80004fa2:	a011                	j	80004fa6 <sys_exec+0xfc>
  return -1;
    80004fa4:	597d                	li	s2,-1
}
    80004fa6:	854a                	mv	a0,s2
    80004fa8:	60be                	ld	ra,456(sp)
    80004faa:	641e                	ld	s0,448(sp)
    80004fac:	74fa                	ld	s1,440(sp)
    80004fae:	795a                	ld	s2,432(sp)
    80004fb0:	79ba                	ld	s3,424(sp)
    80004fb2:	7a1a                	ld	s4,416(sp)
    80004fb4:	6afa                	ld	s5,408(sp)
    80004fb6:	6179                	addi	sp,sp,464
    80004fb8:	8082                	ret

0000000080004fba <sys_pipe>:

uint64
sys_pipe(void)
{
    80004fba:	7139                	addi	sp,sp,-64
    80004fbc:	fc06                	sd	ra,56(sp)
    80004fbe:	f822                	sd	s0,48(sp)
    80004fc0:	f426                	sd	s1,40(sp)
    80004fc2:	0080                	addi	s0,sp,64
  uint64 fdarray; // user pointer to array of two integers
  struct file *rf, *wf;
  int fd0, fd1;
  struct proc *p = myproc();
    80004fc4:	ffffc097          	auipc	ra,0xffffc
    80004fc8:	e80080e7          	jalr	-384(ra) # 80000e44 <myproc>
    80004fcc:	84aa                	mv	s1,a0

  if(argaddr(0, &fdarray) < 0)
    80004fce:	fd840593          	addi	a1,s0,-40
    80004fd2:	4501                	li	a0,0
    80004fd4:	ffffd097          	auipc	ra,0xffffd
    80004fd8:	f48080e7          	jalr	-184(ra) # 80001f1c <argaddr>
    return -1;
    80004fdc:	57fd                	li	a5,-1
  if(argaddr(0, &fdarray) < 0)
    80004fde:	0e054063          	bltz	a0,800050be <sys_pipe+0x104>
  if(pipealloc(&rf, &wf) < 0)
    80004fe2:	fc840593          	addi	a1,s0,-56
    80004fe6:	fd040513          	addi	a0,s0,-48
    80004fea:	fffff097          	auipc	ra,0xfffff
    80004fee:	de6080e7          	jalr	-538(ra) # 80003dd0 <pipealloc>
    return -1;
    80004ff2:	57fd                	li	a5,-1
  if(pipealloc(&rf, &wf) < 0)
    80004ff4:	0c054563          	bltz	a0,800050be <sys_pipe+0x104>
  fd0 = -1;
    80004ff8:	fcf42223          	sw	a5,-60(s0)
  if((fd0 = fdalloc(rf)) < 0 || (fd1 = fdalloc(wf)) < 0){
    80004ffc:	fd043503          	ld	a0,-48(s0)
    80005000:	fffff097          	auipc	ra,0xfffff
    80005004:	504080e7          	jalr	1284(ra) # 80004504 <fdalloc>
    80005008:	fca42223          	sw	a0,-60(s0)
    8000500c:	08054c63          	bltz	a0,800050a4 <sys_pipe+0xea>
    80005010:	fc843503          	ld	a0,-56(s0)
    80005014:	fffff097          	auipc	ra,0xfffff
    80005018:	4f0080e7          	jalr	1264(ra) # 80004504 <fdalloc>
    8000501c:	fca42023          	sw	a0,-64(s0)
    80005020:	06054963          	bltz	a0,80005092 <sys_pipe+0xd8>
      p->ofile[fd0] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005024:	4691                	li	a3,4
    80005026:	fc440613          	addi	a2,s0,-60
    8000502a:	fd843583          	ld	a1,-40(s0)
    8000502e:	68a8                	ld	a0,80(s1)
    80005030:	ffffc097          	auipc	ra,0xffffc
    80005034:	ad8080e7          	jalr	-1320(ra) # 80000b08 <copyout>
    80005038:	02054063          	bltz	a0,80005058 <sys_pipe+0x9e>
     copyout(p->pagetable, fdarray+sizeof(fd0), (char *)&fd1, sizeof(fd1)) < 0){
    8000503c:	4691                	li	a3,4
    8000503e:	fc040613          	addi	a2,s0,-64
    80005042:	fd843583          	ld	a1,-40(s0)
    80005046:	0591                	addi	a1,a1,4
    80005048:	68a8                	ld	a0,80(s1)
    8000504a:	ffffc097          	auipc	ra,0xffffc
    8000504e:	abe080e7          	jalr	-1346(ra) # 80000b08 <copyout>
    p->ofile[fd1] = 0;
    fileclose(rf);
    fileclose(wf);
    return -1;
  }
  return 0;
    80005052:	4781                	li	a5,0
  if(copyout(p->pagetable, fdarray, (char*)&fd0, sizeof(fd0)) < 0 ||
    80005054:	06055563          	bgez	a0,800050be <sys_pipe+0x104>
    p->ofile[fd0] = 0;
    80005058:	fc442783          	lw	a5,-60(s0)
    8000505c:	07e9                	addi	a5,a5,26
    8000505e:	078e                	slli	a5,a5,0x3
    80005060:	97a6                	add	a5,a5,s1
    80005062:	0007b023          	sd	zero,0(a5)
    p->ofile[fd1] = 0;
    80005066:	fc042783          	lw	a5,-64(s0)
    8000506a:	07e9                	addi	a5,a5,26
    8000506c:	078e                	slli	a5,a5,0x3
    8000506e:	00f48533          	add	a0,s1,a5
    80005072:	00053023          	sd	zero,0(a0)
    fileclose(rf);
    80005076:	fd043503          	ld	a0,-48(s0)
    8000507a:	fffff097          	auipc	ra,0xfffff
    8000507e:	9e4080e7          	jalr	-1564(ra) # 80003a5e <fileclose>
    fileclose(wf);
    80005082:	fc843503          	ld	a0,-56(s0)
    80005086:	fffff097          	auipc	ra,0xfffff
    8000508a:	9d8080e7          	jalr	-1576(ra) # 80003a5e <fileclose>
    return -1;
    8000508e:	57fd                	li	a5,-1
    80005090:	a03d                	j	800050be <sys_pipe+0x104>
    if(fd0 >= 0)
    80005092:	fc442783          	lw	a5,-60(s0)
    80005096:	0007c763          	bltz	a5,800050a4 <sys_pipe+0xea>
      p->ofile[fd0] = 0;
    8000509a:	07e9                	addi	a5,a5,26
    8000509c:	078e                	slli	a5,a5,0x3
    8000509e:	97a6                	add	a5,a5,s1
    800050a0:	0007b023          	sd	zero,0(a5)
    fileclose(rf);
    800050a4:	fd043503          	ld	a0,-48(s0)
    800050a8:	fffff097          	auipc	ra,0xfffff
    800050ac:	9b6080e7          	jalr	-1610(ra) # 80003a5e <fileclose>
    fileclose(wf);
    800050b0:	fc843503          	ld	a0,-56(s0)
    800050b4:	fffff097          	auipc	ra,0xfffff
    800050b8:	9aa080e7          	jalr	-1622(ra) # 80003a5e <fileclose>
    return -1;
    800050bc:	57fd                	li	a5,-1
}
    800050be:	853e                	mv	a0,a5
    800050c0:	70e2                	ld	ra,56(sp)
    800050c2:	7442                	ld	s0,48(sp)
    800050c4:	74a2                	ld	s1,40(sp)
    800050c6:	6121                	addi	sp,sp,64
    800050c8:	8082                	ret
    800050ca:	0000                	unimp
    800050cc:	0000                	unimp
	...

00000000800050d0 <kernelvec>:
    800050d0:	7111                	addi	sp,sp,-256
    800050d2:	e006                	sd	ra,0(sp)
    800050d4:	e40a                	sd	sp,8(sp)
    800050d6:	e80e                	sd	gp,16(sp)
    800050d8:	ec12                	sd	tp,24(sp)
    800050da:	f016                	sd	t0,32(sp)
    800050dc:	f41a                	sd	t1,40(sp)
    800050de:	f81e                	sd	t2,48(sp)
    800050e0:	fc22                	sd	s0,56(sp)
    800050e2:	e0a6                	sd	s1,64(sp)
    800050e4:	e4aa                	sd	a0,72(sp)
    800050e6:	e8ae                	sd	a1,80(sp)
    800050e8:	ecb2                	sd	a2,88(sp)
    800050ea:	f0b6                	sd	a3,96(sp)
    800050ec:	f4ba                	sd	a4,104(sp)
    800050ee:	f8be                	sd	a5,112(sp)
    800050f0:	fcc2                	sd	a6,120(sp)
    800050f2:	e146                	sd	a7,128(sp)
    800050f4:	e54a                	sd	s2,136(sp)
    800050f6:	e94e                	sd	s3,144(sp)
    800050f8:	ed52                	sd	s4,152(sp)
    800050fa:	f156                	sd	s5,160(sp)
    800050fc:	f55a                	sd	s6,168(sp)
    800050fe:	f95e                	sd	s7,176(sp)
    80005100:	fd62                	sd	s8,184(sp)
    80005102:	e1e6                	sd	s9,192(sp)
    80005104:	e5ea                	sd	s10,200(sp)
    80005106:	e9ee                	sd	s11,208(sp)
    80005108:	edf2                	sd	t3,216(sp)
    8000510a:	f1f6                	sd	t4,224(sp)
    8000510c:	f5fa                	sd	t5,232(sp)
    8000510e:	f9fe                	sd	t6,240(sp)
    80005110:	c1dfc0ef          	jal	ra,80001d2c <kerneltrap>
    80005114:	6082                	ld	ra,0(sp)
    80005116:	6122                	ld	sp,8(sp)
    80005118:	61c2                	ld	gp,16(sp)
    8000511a:	7282                	ld	t0,32(sp)
    8000511c:	7322                	ld	t1,40(sp)
    8000511e:	73c2                	ld	t2,48(sp)
    80005120:	7462                	ld	s0,56(sp)
    80005122:	6486                	ld	s1,64(sp)
    80005124:	6526                	ld	a0,72(sp)
    80005126:	65c6                	ld	a1,80(sp)
    80005128:	6666                	ld	a2,88(sp)
    8000512a:	7686                	ld	a3,96(sp)
    8000512c:	7726                	ld	a4,104(sp)
    8000512e:	77c6                	ld	a5,112(sp)
    80005130:	7866                	ld	a6,120(sp)
    80005132:	688a                	ld	a7,128(sp)
    80005134:	692a                	ld	s2,136(sp)
    80005136:	69ca                	ld	s3,144(sp)
    80005138:	6a6a                	ld	s4,152(sp)
    8000513a:	7a8a                	ld	s5,160(sp)
    8000513c:	7b2a                	ld	s6,168(sp)
    8000513e:	7bca                	ld	s7,176(sp)
    80005140:	7c6a                	ld	s8,184(sp)
    80005142:	6c8e                	ld	s9,192(sp)
    80005144:	6d2e                	ld	s10,200(sp)
    80005146:	6dce                	ld	s11,208(sp)
    80005148:	6e6e                	ld	t3,216(sp)
    8000514a:	7e8e                	ld	t4,224(sp)
    8000514c:	7f2e                	ld	t5,232(sp)
    8000514e:	7fce                	ld	t6,240(sp)
    80005150:	6111                	addi	sp,sp,256
    80005152:	10200073          	sret
    80005156:	00000013          	nop
    8000515a:	00000013          	nop
    8000515e:	0001                	nop

0000000080005160 <timervec>:
    80005160:	34051573          	csrrw	a0,mscratch,a0
    80005164:	e10c                	sd	a1,0(a0)
    80005166:	e510                	sd	a2,8(a0)
    80005168:	e914                	sd	a3,16(a0)
    8000516a:	6d0c                	ld	a1,24(a0)
    8000516c:	7110                	ld	a2,32(a0)
    8000516e:	6194                	ld	a3,0(a1)
    80005170:	96b2                	add	a3,a3,a2
    80005172:	e194                	sd	a3,0(a1)
    80005174:	4589                	li	a1,2
    80005176:	14459073          	csrw	sip,a1
    8000517a:	6914                	ld	a3,16(a0)
    8000517c:	6510                	ld	a2,8(a0)
    8000517e:	610c                	ld	a1,0(a0)
    80005180:	34051573          	csrrw	a0,mscratch,a0
    80005184:	30200073          	mret
	...

000000008000518a <plicinit>:
// the riscv Platform Level Interrupt Controller (PLIC).
//

void
plicinit(void)
{
    8000518a:	1141                	addi	sp,sp,-16
    8000518c:	e422                	sd	s0,8(sp)
    8000518e:	0800                	addi	s0,sp,16
  // set desired IRQ priorities non-zero (otherwise disabled).
  *(uint32*)(PLIC + UART0_IRQ*4) = 1;
    80005190:	0c0007b7          	lui	a5,0xc000
    80005194:	4705                	li	a4,1
    80005196:	d798                	sw	a4,40(a5)
  *(uint32*)(PLIC + VIRTIO0_IRQ*4) = 1;
    80005198:	c3d8                	sw	a4,4(a5)
}
    8000519a:	6422                	ld	s0,8(sp)
    8000519c:	0141                	addi	sp,sp,16
    8000519e:	8082                	ret

00000000800051a0 <plicinithart>:

void
plicinithart(void)
{
    800051a0:	1141                	addi	sp,sp,-16
    800051a2:	e406                	sd	ra,8(sp)
    800051a4:	e022                	sd	s0,0(sp)
    800051a6:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800051a8:	ffffc097          	auipc	ra,0xffffc
    800051ac:	c70080e7          	jalr	-912(ra) # 80000e18 <cpuid>
  
  // set uart's enable bit for this hart's S-mode. 
  *(uint32*)PLIC_SENABLE(hart)= (1 << UART0_IRQ) | (1 << VIRTIO0_IRQ);
    800051b0:	0085171b          	slliw	a4,a0,0x8
    800051b4:	0c0027b7          	lui	a5,0xc002
    800051b8:	97ba                	add	a5,a5,a4
    800051ba:	40200713          	li	a4,1026
    800051be:	08e7a023          	sw	a4,128(a5) # c002080 <_entry-0x73ffdf80>

  // set this hart's S-mode priority threshold to 0.
  *(uint32*)PLIC_SPRIORITY(hart) = 0;
    800051c2:	00d5151b          	slliw	a0,a0,0xd
    800051c6:	0c2017b7          	lui	a5,0xc201
    800051ca:	97aa                	add	a5,a5,a0
    800051cc:	0007a023          	sw	zero,0(a5) # c201000 <_entry-0x73dff000>
}
    800051d0:	60a2                	ld	ra,8(sp)
    800051d2:	6402                	ld	s0,0(sp)
    800051d4:	0141                	addi	sp,sp,16
    800051d6:	8082                	ret

00000000800051d8 <plic_claim>:

// ask the PLIC what interrupt we should serve.
int
plic_claim(void)
{
    800051d8:	1141                	addi	sp,sp,-16
    800051da:	e406                	sd	ra,8(sp)
    800051dc:	e022                	sd	s0,0(sp)
    800051de:	0800                	addi	s0,sp,16
  int hart = cpuid();
    800051e0:	ffffc097          	auipc	ra,0xffffc
    800051e4:	c38080e7          	jalr	-968(ra) # 80000e18 <cpuid>
  int irq = *(uint32*)PLIC_SCLAIM(hart);
    800051e8:	00d5151b          	slliw	a0,a0,0xd
    800051ec:	0c2017b7          	lui	a5,0xc201
    800051f0:	97aa                	add	a5,a5,a0
  return irq;
}
    800051f2:	43c8                	lw	a0,4(a5)
    800051f4:	60a2                	ld	ra,8(sp)
    800051f6:	6402                	ld	s0,0(sp)
    800051f8:	0141                	addi	sp,sp,16
    800051fa:	8082                	ret

00000000800051fc <plic_complete>:

// tell the PLIC we've served this IRQ.
void
plic_complete(int irq)
{
    800051fc:	1101                	addi	sp,sp,-32
    800051fe:	ec06                	sd	ra,24(sp)
    80005200:	e822                	sd	s0,16(sp)
    80005202:	e426                	sd	s1,8(sp)
    80005204:	1000                	addi	s0,sp,32
    80005206:	84aa                	mv	s1,a0
  int hart = cpuid();
    80005208:	ffffc097          	auipc	ra,0xffffc
    8000520c:	c10080e7          	jalr	-1008(ra) # 80000e18 <cpuid>
  *(uint32*)PLIC_SCLAIM(hart) = irq;
    80005210:	00d5151b          	slliw	a0,a0,0xd
    80005214:	0c2017b7          	lui	a5,0xc201
    80005218:	97aa                	add	a5,a5,a0
    8000521a:	c3c4                	sw	s1,4(a5)
}
    8000521c:	60e2                	ld	ra,24(sp)
    8000521e:	6442                	ld	s0,16(sp)
    80005220:	64a2                	ld	s1,8(sp)
    80005222:	6105                	addi	sp,sp,32
    80005224:	8082                	ret

0000000080005226 <free_desc>:
}

// mark a descriptor as free.
static void
free_desc(int i)
{
    80005226:	1141                	addi	sp,sp,-16
    80005228:	e406                	sd	ra,8(sp)
    8000522a:	e022                	sd	s0,0(sp)
    8000522c:	0800                	addi	s0,sp,16
  if(i >= NUM)
    8000522e:	479d                	li	a5,7
    80005230:	06a7c863          	blt	a5,a0,800052a0 <free_desc+0x7a>
    panic("free_desc 1");
  if(disk.free[i])
    80005234:	0001d717          	auipc	a4,0x1d
    80005238:	dcc70713          	addi	a4,a4,-564 # 80022000 <disk>
    8000523c:	972a                	add	a4,a4,a0
    8000523e:	6789                	lui	a5,0x2
    80005240:	97ba                	add	a5,a5,a4
    80005242:	0187c783          	lbu	a5,24(a5) # 2018 <_entry-0x7fffdfe8>
    80005246:	e7ad                	bnez	a5,800052b0 <free_desc+0x8a>
    panic("free_desc 2");
  disk.desc[i].addr = 0;
    80005248:	00451793          	slli	a5,a0,0x4
    8000524c:	0001f717          	auipc	a4,0x1f
    80005250:	db470713          	addi	a4,a4,-588 # 80024000 <disk+0x2000>
    80005254:	6314                	ld	a3,0(a4)
    80005256:	96be                	add	a3,a3,a5
    80005258:	0006b023          	sd	zero,0(a3)
  disk.desc[i].len = 0;
    8000525c:	6314                	ld	a3,0(a4)
    8000525e:	96be                	add	a3,a3,a5
    80005260:	0006a423          	sw	zero,8(a3)
  disk.desc[i].flags = 0;
    80005264:	6314                	ld	a3,0(a4)
    80005266:	96be                	add	a3,a3,a5
    80005268:	00069623          	sh	zero,12(a3)
  disk.desc[i].next = 0;
    8000526c:	6318                	ld	a4,0(a4)
    8000526e:	97ba                	add	a5,a5,a4
    80005270:	00079723          	sh	zero,14(a5)
  disk.free[i] = 1;
    80005274:	0001d717          	auipc	a4,0x1d
    80005278:	d8c70713          	addi	a4,a4,-628 # 80022000 <disk>
    8000527c:	972a                	add	a4,a4,a0
    8000527e:	6789                	lui	a5,0x2
    80005280:	97ba                	add	a5,a5,a4
    80005282:	4705                	li	a4,1
    80005284:	00e78c23          	sb	a4,24(a5) # 2018 <_entry-0x7fffdfe8>
  wakeup(&disk.free[0]);
    80005288:	0001f517          	auipc	a0,0x1f
    8000528c:	d9050513          	addi	a0,a0,-624 # 80024018 <disk+0x2018>
    80005290:	ffffc097          	auipc	ra,0xffffc
    80005294:	404080e7          	jalr	1028(ra) # 80001694 <wakeup>
}
    80005298:	60a2                	ld	ra,8(sp)
    8000529a:	6402                	ld	s0,0(sp)
    8000529c:	0141                	addi	sp,sp,16
    8000529e:	8082                	ret
    panic("free_desc 1");
    800052a0:	00003517          	auipc	a0,0x3
    800052a4:	5b850513          	addi	a0,a0,1464 # 80008858 <syscalls+0x490>
    800052a8:	00001097          	auipc	ra,0x1
    800052ac:	9c8080e7          	jalr	-1592(ra) # 80005c70 <panic>
    panic("free_desc 2");
    800052b0:	00003517          	auipc	a0,0x3
    800052b4:	5b850513          	addi	a0,a0,1464 # 80008868 <syscalls+0x4a0>
    800052b8:	00001097          	auipc	ra,0x1
    800052bc:	9b8080e7          	jalr	-1608(ra) # 80005c70 <panic>

00000000800052c0 <virtio_disk_init>:
{
    800052c0:	1101                	addi	sp,sp,-32
    800052c2:	ec06                	sd	ra,24(sp)
    800052c4:	e822                	sd	s0,16(sp)
    800052c6:	e426                	sd	s1,8(sp)
    800052c8:	1000                	addi	s0,sp,32
  initlock(&disk.vdisk_lock, "virtio_disk");
    800052ca:	00003597          	auipc	a1,0x3
    800052ce:	5ae58593          	addi	a1,a1,1454 # 80008878 <syscalls+0x4b0>
    800052d2:	0001f517          	auipc	a0,0x1f
    800052d6:	e5650513          	addi	a0,a0,-426 # 80024128 <disk+0x2128>
    800052da:	00001097          	auipc	ra,0x1
    800052de:	e3e080e7          	jalr	-450(ra) # 80006118 <initlock>
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800052e2:	100017b7          	lui	a5,0x10001
    800052e6:	4398                	lw	a4,0(a5)
    800052e8:	2701                	sext.w	a4,a4
    800052ea:	747277b7          	lui	a5,0x74727
    800052ee:	97678793          	addi	a5,a5,-1674 # 74726976 <_entry-0xb8d968a>
    800052f2:	0ef71063          	bne	a4,a5,800053d2 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    800052f6:	100017b7          	lui	a5,0x10001
    800052fa:	43dc                	lw	a5,4(a5)
    800052fc:	2781                	sext.w	a5,a5
  if(*R(VIRTIO_MMIO_MAGIC_VALUE) != 0x74726976 ||
    800052fe:	4705                	li	a4,1
    80005300:	0ce79963          	bne	a5,a4,800053d2 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    80005304:	100017b7          	lui	a5,0x10001
    80005308:	479c                	lw	a5,8(a5)
    8000530a:	2781                	sext.w	a5,a5
     *R(VIRTIO_MMIO_VERSION) != 1 ||
    8000530c:	4709                	li	a4,2
    8000530e:	0ce79263          	bne	a5,a4,800053d2 <virtio_disk_init+0x112>
     *R(VIRTIO_MMIO_VENDOR_ID) != 0x554d4551){
    80005312:	100017b7          	lui	a5,0x10001
    80005316:	47d8                	lw	a4,12(a5)
    80005318:	2701                	sext.w	a4,a4
     *R(VIRTIO_MMIO_DEVICE_ID) != 2 ||
    8000531a:	554d47b7          	lui	a5,0x554d4
    8000531e:	55178793          	addi	a5,a5,1361 # 554d4551 <_entry-0x2ab2baaf>
    80005322:	0af71863          	bne	a4,a5,800053d2 <virtio_disk_init+0x112>
  *R(VIRTIO_MMIO_STATUS) = status;
    80005326:	100017b7          	lui	a5,0x10001
    8000532a:	4705                	li	a4,1
    8000532c:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    8000532e:	470d                	li	a4,3
    80005330:	dbb8                	sw	a4,112(a5)
  uint64 features = *R(VIRTIO_MMIO_DEVICE_FEATURES);
    80005332:	4b98                	lw	a4,16(a5)
  *R(VIRTIO_MMIO_DRIVER_FEATURES) = features;
    80005334:	c7ffe6b7          	lui	a3,0xc7ffe
    80005338:	75f68693          	addi	a3,a3,1887 # ffffffffc7ffe75f <end+0xffffffff47fd151f>
    8000533c:	8f75                	and	a4,a4,a3
    8000533e:	d398                	sw	a4,32(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005340:	472d                	li	a4,11
    80005342:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_STATUS) = status;
    80005344:	473d                	li	a4,15
    80005346:	dbb8                	sw	a4,112(a5)
  *R(VIRTIO_MMIO_GUEST_PAGE_SIZE) = PGSIZE;
    80005348:	6705                	lui	a4,0x1
    8000534a:	d798                	sw	a4,40(a5)
  *R(VIRTIO_MMIO_QUEUE_SEL) = 0;
    8000534c:	0207a823          	sw	zero,48(a5) # 10001030 <_entry-0x6fffefd0>
  uint32 max = *R(VIRTIO_MMIO_QUEUE_NUM_MAX);
    80005350:	5bdc                	lw	a5,52(a5)
    80005352:	2781                	sext.w	a5,a5
  if(max == 0)
    80005354:	c7d9                	beqz	a5,800053e2 <virtio_disk_init+0x122>
  if(max < NUM)
    80005356:	471d                	li	a4,7
    80005358:	08f77d63          	bgeu	a4,a5,800053f2 <virtio_disk_init+0x132>
  *R(VIRTIO_MMIO_QUEUE_NUM) = NUM;
    8000535c:	100014b7          	lui	s1,0x10001
    80005360:	47a1                	li	a5,8
    80005362:	dc9c                	sw	a5,56(s1)
  memset(disk.pages, 0, sizeof(disk.pages));
    80005364:	6609                	lui	a2,0x2
    80005366:	4581                	li	a1,0
    80005368:	0001d517          	auipc	a0,0x1d
    8000536c:	c9850513          	addi	a0,a0,-872 # 80022000 <disk>
    80005370:	ffffb097          	auipc	ra,0xffffb
    80005374:	e0a080e7          	jalr	-502(ra) # 8000017a <memset>
  *R(VIRTIO_MMIO_QUEUE_PFN) = ((uint64)disk.pages) >> PGSHIFT;
    80005378:	0001d717          	auipc	a4,0x1d
    8000537c:	c8870713          	addi	a4,a4,-888 # 80022000 <disk>
    80005380:	00c75793          	srli	a5,a4,0xc
    80005384:	2781                	sext.w	a5,a5
    80005386:	c0bc                	sw	a5,64(s1)
  disk.desc = (struct virtq_desc *) disk.pages;
    80005388:	0001f797          	auipc	a5,0x1f
    8000538c:	c7878793          	addi	a5,a5,-904 # 80024000 <disk+0x2000>
    80005390:	e398                	sd	a4,0(a5)
  disk.avail = (struct virtq_avail *)(disk.pages + NUM*sizeof(struct virtq_desc));
    80005392:	0001d717          	auipc	a4,0x1d
    80005396:	cee70713          	addi	a4,a4,-786 # 80022080 <disk+0x80>
    8000539a:	e798                	sd	a4,8(a5)
  disk.used = (struct virtq_used *) (disk.pages + PGSIZE);
    8000539c:	0001e717          	auipc	a4,0x1e
    800053a0:	c6470713          	addi	a4,a4,-924 # 80023000 <disk+0x1000>
    800053a4:	eb98                	sd	a4,16(a5)
    disk.free[i] = 1;
    800053a6:	4705                	li	a4,1
    800053a8:	00e78c23          	sb	a4,24(a5)
    800053ac:	00e78ca3          	sb	a4,25(a5)
    800053b0:	00e78d23          	sb	a4,26(a5)
    800053b4:	00e78da3          	sb	a4,27(a5)
    800053b8:	00e78e23          	sb	a4,28(a5)
    800053bc:	00e78ea3          	sb	a4,29(a5)
    800053c0:	00e78f23          	sb	a4,30(a5)
    800053c4:	00e78fa3          	sb	a4,31(a5)
}
    800053c8:	60e2                	ld	ra,24(sp)
    800053ca:	6442                	ld	s0,16(sp)
    800053cc:	64a2                	ld	s1,8(sp)
    800053ce:	6105                	addi	sp,sp,32
    800053d0:	8082                	ret
    panic("could not find virtio disk");
    800053d2:	00003517          	auipc	a0,0x3
    800053d6:	4b650513          	addi	a0,a0,1206 # 80008888 <syscalls+0x4c0>
    800053da:	00001097          	auipc	ra,0x1
    800053de:	896080e7          	jalr	-1898(ra) # 80005c70 <panic>
    panic("virtio disk has no queue 0");
    800053e2:	00003517          	auipc	a0,0x3
    800053e6:	4c650513          	addi	a0,a0,1222 # 800088a8 <syscalls+0x4e0>
    800053ea:	00001097          	auipc	ra,0x1
    800053ee:	886080e7          	jalr	-1914(ra) # 80005c70 <panic>
    panic("virtio disk max queue too short");
    800053f2:	00003517          	auipc	a0,0x3
    800053f6:	4d650513          	addi	a0,a0,1238 # 800088c8 <syscalls+0x500>
    800053fa:	00001097          	auipc	ra,0x1
    800053fe:	876080e7          	jalr	-1930(ra) # 80005c70 <panic>

0000000080005402 <virtio_disk_rw>:
  return 0;
}

void
virtio_disk_rw(struct buf *b, int write)
{
    80005402:	7119                	addi	sp,sp,-128
    80005404:	fc86                	sd	ra,120(sp)
    80005406:	f8a2                	sd	s0,112(sp)
    80005408:	f4a6                	sd	s1,104(sp)
    8000540a:	f0ca                	sd	s2,96(sp)
    8000540c:	ecce                	sd	s3,88(sp)
    8000540e:	e8d2                	sd	s4,80(sp)
    80005410:	e4d6                	sd	s5,72(sp)
    80005412:	e0da                	sd	s6,64(sp)
    80005414:	fc5e                	sd	s7,56(sp)
    80005416:	f862                	sd	s8,48(sp)
    80005418:	f466                	sd	s9,40(sp)
    8000541a:	f06a                	sd	s10,32(sp)
    8000541c:	ec6e                	sd	s11,24(sp)
    8000541e:	0100                	addi	s0,sp,128
    80005420:	8aaa                	mv	s5,a0
    80005422:	8d2e                	mv	s10,a1
  uint64 sector = b->blockno * (BSIZE / 512);
    80005424:	00c52c83          	lw	s9,12(a0)
    80005428:	001c9c9b          	slliw	s9,s9,0x1
    8000542c:	1c82                	slli	s9,s9,0x20
    8000542e:	020cdc93          	srli	s9,s9,0x20

  acquire(&disk.vdisk_lock);
    80005432:	0001f517          	auipc	a0,0x1f
    80005436:	cf650513          	addi	a0,a0,-778 # 80024128 <disk+0x2128>
    8000543a:	00001097          	auipc	ra,0x1
    8000543e:	d6e080e7          	jalr	-658(ra) # 800061a8 <acquire>
  for(int i = 0; i < 3; i++){
    80005442:	4981                	li	s3,0
  for(int i = 0; i < NUM; i++){
    80005444:	44a1                	li	s1,8
      disk.free[i] = 0;
    80005446:	0001dc17          	auipc	s8,0x1d
    8000544a:	bbac0c13          	addi	s8,s8,-1094 # 80022000 <disk>
    8000544e:	6b89                	lui	s7,0x2
  for(int i = 0; i < 3; i++){
    80005450:	4b0d                	li	s6,3
    80005452:	a0ad                	j	800054bc <virtio_disk_rw+0xba>
      disk.free[i] = 0;
    80005454:	00fc0733          	add	a4,s8,a5
    80005458:	975e                	add	a4,a4,s7
    8000545a:	00070c23          	sb	zero,24(a4)
    idx[i] = alloc_desc();
    8000545e:	c19c                	sw	a5,0(a1)
    if(idx[i] < 0){
    80005460:	0207c563          	bltz	a5,8000548a <virtio_disk_rw+0x88>
  for(int i = 0; i < 3; i++){
    80005464:	2905                	addiw	s2,s2,1
    80005466:	0611                	addi	a2,a2,4 # 2004 <_entry-0x7fffdffc>
    80005468:	19690c63          	beq	s2,s6,80005600 <virtio_disk_rw+0x1fe>
    idx[i] = alloc_desc();
    8000546c:	85b2                	mv	a1,a2
  for(int i = 0; i < NUM; i++){
    8000546e:	0001f717          	auipc	a4,0x1f
    80005472:	baa70713          	addi	a4,a4,-1110 # 80024018 <disk+0x2018>
    80005476:	87ce                	mv	a5,s3
    if(disk.free[i]){
    80005478:	00074683          	lbu	a3,0(a4)
    8000547c:	fee1                	bnez	a3,80005454 <virtio_disk_rw+0x52>
  for(int i = 0; i < NUM; i++){
    8000547e:	2785                	addiw	a5,a5,1
    80005480:	0705                	addi	a4,a4,1
    80005482:	fe979be3          	bne	a5,s1,80005478 <virtio_disk_rw+0x76>
    idx[i] = alloc_desc();
    80005486:	57fd                	li	a5,-1
    80005488:	c19c                	sw	a5,0(a1)
      for(int j = 0; j < i; j++)
    8000548a:	01205d63          	blez	s2,800054a4 <virtio_disk_rw+0xa2>
    8000548e:	8dce                	mv	s11,s3
        free_desc(idx[j]);
    80005490:	000a2503          	lw	a0,0(s4)
    80005494:	00000097          	auipc	ra,0x0
    80005498:	d92080e7          	jalr	-622(ra) # 80005226 <free_desc>
      for(int j = 0; j < i; j++)
    8000549c:	2d85                	addiw	s11,s11,1
    8000549e:	0a11                	addi	s4,s4,4
    800054a0:	ff2d98e3          	bne	s11,s2,80005490 <virtio_disk_rw+0x8e>
  int idx[3];
  while(1){
    if(alloc3_desc(idx) == 0) {
      break;
    }
    sleep(&disk.free[0], &disk.vdisk_lock);
    800054a4:	0001f597          	auipc	a1,0x1f
    800054a8:	c8458593          	addi	a1,a1,-892 # 80024128 <disk+0x2128>
    800054ac:	0001f517          	auipc	a0,0x1f
    800054b0:	b6c50513          	addi	a0,a0,-1172 # 80024018 <disk+0x2018>
    800054b4:	ffffc097          	auipc	ra,0xffffc
    800054b8:	054080e7          	jalr	84(ra) # 80001508 <sleep>
  for(int i = 0; i < 3; i++){
    800054bc:	f8040a13          	addi	s4,s0,-128
{
    800054c0:	8652                	mv	a2,s4
  for(int i = 0; i < 3; i++){
    800054c2:	894e                	mv	s2,s3
    800054c4:	b765                	j	8000546c <virtio_disk_rw+0x6a>
  disk.desc[idx[0]].next = idx[1];

  disk.desc[idx[1]].addr = (uint64) b->data;
  disk.desc[idx[1]].len = BSIZE;
  if(write)
    disk.desc[idx[1]].flags = 0; // device reads b->data
    800054c6:	0001f697          	auipc	a3,0x1f
    800054ca:	b3a6b683          	ld	a3,-1222(a3) # 80024000 <disk+0x2000>
    800054ce:	96ba                	add	a3,a3,a4
    800054d0:	00069623          	sh	zero,12(a3)
  else
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
  disk.desc[idx[1]].flags |= VRING_DESC_F_NEXT;
    800054d4:	0001d817          	auipc	a6,0x1d
    800054d8:	b2c80813          	addi	a6,a6,-1236 # 80022000 <disk>
    800054dc:	0001f697          	auipc	a3,0x1f
    800054e0:	b2468693          	addi	a3,a3,-1244 # 80024000 <disk+0x2000>
    800054e4:	6290                	ld	a2,0(a3)
    800054e6:	963a                	add	a2,a2,a4
    800054e8:	00c65583          	lhu	a1,12(a2)
    800054ec:	0015e593          	ori	a1,a1,1
    800054f0:	00b61623          	sh	a1,12(a2)
  disk.desc[idx[1]].next = idx[2];
    800054f4:	f8842603          	lw	a2,-120(s0)
    800054f8:	628c                	ld	a1,0(a3)
    800054fa:	972e                	add	a4,a4,a1
    800054fc:	00c71723          	sh	a2,14(a4)

  disk.info[idx[0]].status = 0xff; // device writes 0 on success
    80005500:	20050593          	addi	a1,a0,512
    80005504:	0592                	slli	a1,a1,0x4
    80005506:	95c2                	add	a1,a1,a6
    80005508:	577d                	li	a4,-1
    8000550a:	02e58823          	sb	a4,48(a1)
  disk.desc[idx[2]].addr = (uint64) &disk.info[idx[0]].status;
    8000550e:	00461713          	slli	a4,a2,0x4
    80005512:	6290                	ld	a2,0(a3)
    80005514:	963a                	add	a2,a2,a4
    80005516:	03078793          	addi	a5,a5,48
    8000551a:	97c2                	add	a5,a5,a6
    8000551c:	e21c                	sd	a5,0(a2)
  disk.desc[idx[2]].len = 1;
    8000551e:	629c                	ld	a5,0(a3)
    80005520:	97ba                	add	a5,a5,a4
    80005522:	4605                	li	a2,1
    80005524:	c790                	sw	a2,8(a5)
  disk.desc[idx[2]].flags = VRING_DESC_F_WRITE; // device writes the status
    80005526:	629c                	ld	a5,0(a3)
    80005528:	97ba                	add	a5,a5,a4
    8000552a:	4809                	li	a6,2
    8000552c:	01079623          	sh	a6,12(a5)
  disk.desc[idx[2]].next = 0;
    80005530:	629c                	ld	a5,0(a3)
    80005532:	97ba                	add	a5,a5,a4
    80005534:	00079723          	sh	zero,14(a5)

  // record struct buf for virtio_disk_intr().
  b->disk = 1;
    80005538:	00caa223          	sw	a2,4(s5)
  disk.info[idx[0]].b = b;
    8000553c:	0355b423          	sd	s5,40(a1)

  // tell the device the first index in our chain of descriptors.
  disk.avail->ring[disk.avail->idx % NUM] = idx[0];
    80005540:	6698                	ld	a4,8(a3)
    80005542:	00275783          	lhu	a5,2(a4)
    80005546:	8b9d                	andi	a5,a5,7
    80005548:	0786                	slli	a5,a5,0x1
    8000554a:	973e                	add	a4,a4,a5
    8000554c:	00a71223          	sh	a0,4(a4)

  __sync_synchronize();
    80005550:	0ff0000f          	fence

  // tell the device another avail ring entry is available.
  disk.avail->idx += 1; // not % NUM ...
    80005554:	6698                	ld	a4,8(a3)
    80005556:	00275783          	lhu	a5,2(a4)
    8000555a:	2785                	addiw	a5,a5,1
    8000555c:	00f71123          	sh	a5,2(a4)

  __sync_synchronize();
    80005560:	0ff0000f          	fence

  *R(VIRTIO_MMIO_QUEUE_NOTIFY) = 0; // value is queue number
    80005564:	100017b7          	lui	a5,0x10001
    80005568:	0407a823          	sw	zero,80(a5) # 10001050 <_entry-0x6fffefb0>

  // Wait for virtio_disk_intr() to say request has finished.
  while(b->disk == 1) {
    8000556c:	004aa783          	lw	a5,4(s5)
    80005570:	02c79163          	bne	a5,a2,80005592 <virtio_disk_rw+0x190>
    sleep(b, &disk.vdisk_lock);
    80005574:	0001f917          	auipc	s2,0x1f
    80005578:	bb490913          	addi	s2,s2,-1100 # 80024128 <disk+0x2128>
  while(b->disk == 1) {
    8000557c:	4485                	li	s1,1
    sleep(b, &disk.vdisk_lock);
    8000557e:	85ca                	mv	a1,s2
    80005580:	8556                	mv	a0,s5
    80005582:	ffffc097          	auipc	ra,0xffffc
    80005586:	f86080e7          	jalr	-122(ra) # 80001508 <sleep>
  while(b->disk == 1) {
    8000558a:	004aa783          	lw	a5,4(s5)
    8000558e:	fe9788e3          	beq	a5,s1,8000557e <virtio_disk_rw+0x17c>
  }

  disk.info[idx[0]].b = 0;
    80005592:	f8042903          	lw	s2,-128(s0)
    80005596:	20090713          	addi	a4,s2,512
    8000559a:	0712                	slli	a4,a4,0x4
    8000559c:	0001d797          	auipc	a5,0x1d
    800055a0:	a6478793          	addi	a5,a5,-1436 # 80022000 <disk>
    800055a4:	97ba                	add	a5,a5,a4
    800055a6:	0207b423          	sd	zero,40(a5)
    int flag = disk.desc[i].flags;
    800055aa:	0001f997          	auipc	s3,0x1f
    800055ae:	a5698993          	addi	s3,s3,-1450 # 80024000 <disk+0x2000>
    800055b2:	00491713          	slli	a4,s2,0x4
    800055b6:	0009b783          	ld	a5,0(s3)
    800055ba:	97ba                	add	a5,a5,a4
    800055bc:	00c7d483          	lhu	s1,12(a5)
    int nxt = disk.desc[i].next;
    800055c0:	854a                	mv	a0,s2
    800055c2:	00e7d903          	lhu	s2,14(a5)
    free_desc(i);
    800055c6:	00000097          	auipc	ra,0x0
    800055ca:	c60080e7          	jalr	-928(ra) # 80005226 <free_desc>
    if(flag & VRING_DESC_F_NEXT)
    800055ce:	8885                	andi	s1,s1,1
    800055d0:	f0ed                	bnez	s1,800055b2 <virtio_disk_rw+0x1b0>
  free_chain(idx[0]);

  release(&disk.vdisk_lock);
    800055d2:	0001f517          	auipc	a0,0x1f
    800055d6:	b5650513          	addi	a0,a0,-1194 # 80024128 <disk+0x2128>
    800055da:	00001097          	auipc	ra,0x1
    800055de:	c82080e7          	jalr	-894(ra) # 8000625c <release>
}
    800055e2:	70e6                	ld	ra,120(sp)
    800055e4:	7446                	ld	s0,112(sp)
    800055e6:	74a6                	ld	s1,104(sp)
    800055e8:	7906                	ld	s2,96(sp)
    800055ea:	69e6                	ld	s3,88(sp)
    800055ec:	6a46                	ld	s4,80(sp)
    800055ee:	6aa6                	ld	s5,72(sp)
    800055f0:	6b06                	ld	s6,64(sp)
    800055f2:	7be2                	ld	s7,56(sp)
    800055f4:	7c42                	ld	s8,48(sp)
    800055f6:	7ca2                	ld	s9,40(sp)
    800055f8:	7d02                	ld	s10,32(sp)
    800055fa:	6de2                	ld	s11,24(sp)
    800055fc:	6109                	addi	sp,sp,128
    800055fe:	8082                	ret
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005600:	f8042503          	lw	a0,-128(s0)
    80005604:	20050793          	addi	a5,a0,512
    80005608:	0792                	slli	a5,a5,0x4
  if(write)
    8000560a:	0001d817          	auipc	a6,0x1d
    8000560e:	9f680813          	addi	a6,a6,-1546 # 80022000 <disk>
    80005612:	00f80733          	add	a4,a6,a5
    80005616:	01a036b3          	snez	a3,s10
    8000561a:	0ad72423          	sw	a3,168(a4)
  buf0->reserved = 0;
    8000561e:	0a072623          	sw	zero,172(a4)
  buf0->sector = sector;
    80005622:	0b973823          	sd	s9,176(a4)
  disk.desc[idx[0]].addr = (uint64) buf0;
    80005626:	7679                	lui	a2,0xffffe
    80005628:	963e                	add	a2,a2,a5
    8000562a:	0001f697          	auipc	a3,0x1f
    8000562e:	9d668693          	addi	a3,a3,-1578 # 80024000 <disk+0x2000>
    80005632:	6298                	ld	a4,0(a3)
    80005634:	9732                	add	a4,a4,a2
  struct virtio_blk_req *buf0 = &disk.ops[idx[0]];
    80005636:	0a878593          	addi	a1,a5,168
    8000563a:	95c2                	add	a1,a1,a6
  disk.desc[idx[0]].addr = (uint64) buf0;
    8000563c:	e30c                	sd	a1,0(a4)
  disk.desc[idx[0]].len = sizeof(struct virtio_blk_req);
    8000563e:	6298                	ld	a4,0(a3)
    80005640:	9732                	add	a4,a4,a2
    80005642:	45c1                	li	a1,16
    80005644:	c70c                	sw	a1,8(a4)
  disk.desc[idx[0]].flags = VRING_DESC_F_NEXT;
    80005646:	6298                	ld	a4,0(a3)
    80005648:	9732                	add	a4,a4,a2
    8000564a:	4585                	li	a1,1
    8000564c:	00b71623          	sh	a1,12(a4)
  disk.desc[idx[0]].next = idx[1];
    80005650:	f8442703          	lw	a4,-124(s0)
    80005654:	628c                	ld	a1,0(a3)
    80005656:	962e                	add	a2,a2,a1
    80005658:	00e61723          	sh	a4,14(a2) # ffffffffffffe00e <end+0xffffffff7ffd0dce>
  disk.desc[idx[1]].addr = (uint64) b->data;
    8000565c:	0712                	slli	a4,a4,0x4
    8000565e:	6290                	ld	a2,0(a3)
    80005660:	963a                	add	a2,a2,a4
    80005662:	058a8593          	addi	a1,s5,88
    80005666:	e20c                	sd	a1,0(a2)
  disk.desc[idx[1]].len = BSIZE;
    80005668:	6294                	ld	a3,0(a3)
    8000566a:	96ba                	add	a3,a3,a4
    8000566c:	40000613          	li	a2,1024
    80005670:	c690                	sw	a2,8(a3)
  if(write)
    80005672:	e40d1ae3          	bnez	s10,800054c6 <virtio_disk_rw+0xc4>
    disk.desc[idx[1]].flags = VRING_DESC_F_WRITE; // device writes b->data
    80005676:	0001f697          	auipc	a3,0x1f
    8000567a:	98a6b683          	ld	a3,-1654(a3) # 80024000 <disk+0x2000>
    8000567e:	96ba                	add	a3,a3,a4
    80005680:	4609                	li	a2,2
    80005682:	00c69623          	sh	a2,12(a3)
    80005686:	b5b9                	j	800054d4 <virtio_disk_rw+0xd2>

0000000080005688 <virtio_disk_intr>:

void
virtio_disk_intr()
{
    80005688:	1101                	addi	sp,sp,-32
    8000568a:	ec06                	sd	ra,24(sp)
    8000568c:	e822                	sd	s0,16(sp)
    8000568e:	e426                	sd	s1,8(sp)
    80005690:	e04a                	sd	s2,0(sp)
    80005692:	1000                	addi	s0,sp,32
  acquire(&disk.vdisk_lock);
    80005694:	0001f517          	auipc	a0,0x1f
    80005698:	a9450513          	addi	a0,a0,-1388 # 80024128 <disk+0x2128>
    8000569c:	00001097          	auipc	ra,0x1
    800056a0:	b0c080e7          	jalr	-1268(ra) # 800061a8 <acquire>
  // we've seen this interrupt, which the following line does.
  // this may race with the device writing new entries to
  // the "used" ring, in which case we may process the new
  // completion entries in this interrupt, and have nothing to do
  // in the next interrupt, which is harmless.
  *R(VIRTIO_MMIO_INTERRUPT_ACK) = *R(VIRTIO_MMIO_INTERRUPT_STATUS) & 0x3;
    800056a4:	10001737          	lui	a4,0x10001
    800056a8:	533c                	lw	a5,96(a4)
    800056aa:	8b8d                	andi	a5,a5,3
    800056ac:	d37c                	sw	a5,100(a4)

  __sync_synchronize();
    800056ae:	0ff0000f          	fence

  // the device increments disk.used->idx when it
  // adds an entry to the used ring.

  while(disk.used_idx != disk.used->idx){
    800056b2:	0001f797          	auipc	a5,0x1f
    800056b6:	94e78793          	addi	a5,a5,-1714 # 80024000 <disk+0x2000>
    800056ba:	6b94                	ld	a3,16(a5)
    800056bc:	0207d703          	lhu	a4,32(a5)
    800056c0:	0026d783          	lhu	a5,2(a3)
    800056c4:	06f70163          	beq	a4,a5,80005726 <virtio_disk_intr+0x9e>
    __sync_synchronize();
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800056c8:	0001d917          	auipc	s2,0x1d
    800056cc:	93890913          	addi	s2,s2,-1736 # 80022000 <disk>
    800056d0:	0001f497          	auipc	s1,0x1f
    800056d4:	93048493          	addi	s1,s1,-1744 # 80024000 <disk+0x2000>
    __sync_synchronize();
    800056d8:	0ff0000f          	fence
    int id = disk.used->ring[disk.used_idx % NUM].id;
    800056dc:	6898                	ld	a4,16(s1)
    800056de:	0204d783          	lhu	a5,32(s1)
    800056e2:	8b9d                	andi	a5,a5,7
    800056e4:	078e                	slli	a5,a5,0x3
    800056e6:	97ba                	add	a5,a5,a4
    800056e8:	43dc                	lw	a5,4(a5)

    if(disk.info[id].status != 0)
    800056ea:	20078713          	addi	a4,a5,512
    800056ee:	0712                	slli	a4,a4,0x4
    800056f0:	974a                	add	a4,a4,s2
    800056f2:	03074703          	lbu	a4,48(a4) # 10001030 <_entry-0x6fffefd0>
    800056f6:	e731                	bnez	a4,80005742 <virtio_disk_intr+0xba>
      panic("virtio_disk_intr status");

    struct buf *b = disk.info[id].b;
    800056f8:	20078793          	addi	a5,a5,512
    800056fc:	0792                	slli	a5,a5,0x4
    800056fe:	97ca                	add	a5,a5,s2
    80005700:	7788                	ld	a0,40(a5)
    b->disk = 0;   // disk is done with buf
    80005702:	00052223          	sw	zero,4(a0)
    wakeup(b);
    80005706:	ffffc097          	auipc	ra,0xffffc
    8000570a:	f8e080e7          	jalr	-114(ra) # 80001694 <wakeup>

    disk.used_idx += 1;
    8000570e:	0204d783          	lhu	a5,32(s1)
    80005712:	2785                	addiw	a5,a5,1
    80005714:	17c2                	slli	a5,a5,0x30
    80005716:	93c1                	srli	a5,a5,0x30
    80005718:	02f49023          	sh	a5,32(s1)
  while(disk.used_idx != disk.used->idx){
    8000571c:	6898                	ld	a4,16(s1)
    8000571e:	00275703          	lhu	a4,2(a4)
    80005722:	faf71be3          	bne	a4,a5,800056d8 <virtio_disk_intr+0x50>
  }

  release(&disk.vdisk_lock);
    80005726:	0001f517          	auipc	a0,0x1f
    8000572a:	a0250513          	addi	a0,a0,-1534 # 80024128 <disk+0x2128>
    8000572e:	00001097          	auipc	ra,0x1
    80005732:	b2e080e7          	jalr	-1234(ra) # 8000625c <release>
}
    80005736:	60e2                	ld	ra,24(sp)
    80005738:	6442                	ld	s0,16(sp)
    8000573a:	64a2                	ld	s1,8(sp)
    8000573c:	6902                	ld	s2,0(sp)
    8000573e:	6105                	addi	sp,sp,32
    80005740:	8082                	ret
      panic("virtio_disk_intr status");
    80005742:	00003517          	auipc	a0,0x3
    80005746:	1a650513          	addi	a0,a0,422 # 800088e8 <syscalls+0x520>
    8000574a:	00000097          	auipc	ra,0x0
    8000574e:	526080e7          	jalr	1318(ra) # 80005c70 <panic>

0000000080005752 <timerinit>:
// which arrive at timervec in kernelvec.S,
// which turns them into software interrupts for
// devintr() in trap.c.
void
timerinit()
{
    80005752:	1141                	addi	sp,sp,-16
    80005754:	e422                	sd	s0,8(sp)
    80005756:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005758:	f14027f3          	csrr	a5,mhartid
  // each CPU has a separate source of timer interrupts.
  int id = r_mhartid();
    8000575c:	0007859b          	sext.w	a1,a5

  // ask the CLINT for a timer interrupt.
  int interval = 1000000; // cycles; about 1/10th second in qemu.
  *(uint64*)CLINT_MTIMECMP(id) = *(uint64*)CLINT_MTIME + interval;
    80005760:	0037979b          	slliw	a5,a5,0x3
    80005764:	02004737          	lui	a4,0x2004
    80005768:	97ba                	add	a5,a5,a4
    8000576a:	0200c737          	lui	a4,0x200c
    8000576e:	ff873703          	ld	a4,-8(a4) # 200bff8 <_entry-0x7dff4008>
    80005772:	000f4637          	lui	a2,0xf4
    80005776:	24060613          	addi	a2,a2,576 # f4240 <_entry-0x7ff0bdc0>
    8000577a:	9732                	add	a4,a4,a2
    8000577c:	e398                	sd	a4,0(a5)

  // prepare information in scratch[] for timervec.
  // scratch[0..2] : space for timervec to save registers.
  // scratch[3] : address of CLINT MTIMECMP register.
  // scratch[4] : desired interval (in cycles) between timer interrupts.
  uint64 *scratch = &timer_scratch[id][0];
    8000577e:	00259693          	slli	a3,a1,0x2
    80005782:	96ae                	add	a3,a3,a1
    80005784:	068e                	slli	a3,a3,0x3
    80005786:	00020717          	auipc	a4,0x20
    8000578a:	87a70713          	addi	a4,a4,-1926 # 80025000 <timer_scratch>
    8000578e:	9736                	add	a4,a4,a3
  scratch[3] = CLINT_MTIMECMP(id);
    80005790:	ef1c                	sd	a5,24(a4)
  scratch[4] = interval;
    80005792:	f310                	sd	a2,32(a4)
  asm volatile("csrw mscratch, %0" : : "r" (x));
    80005794:	34071073          	csrw	mscratch,a4
  asm volatile("csrw mtvec, %0" : : "r" (x));
    80005798:	00000797          	auipc	a5,0x0
    8000579c:	9c878793          	addi	a5,a5,-1592 # 80005160 <timervec>
    800057a0:	30579073          	csrw	mtvec,a5
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800057a4:	300027f3          	csrr	a5,mstatus

  // set the machine-mode trap handler.
  w_mtvec((uint64)timervec);

  // enable machine-mode interrupts.
  w_mstatus(r_mstatus() | MSTATUS_MIE);
    800057a8:	0087e793          	ori	a5,a5,8
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800057ac:	30079073          	csrw	mstatus,a5
  asm volatile("csrr %0, mie" : "=r" (x) );
    800057b0:	304027f3          	csrr	a5,mie

  // enable machine-mode timer interrupts.
  w_mie(r_mie() | MIE_MTIE);
    800057b4:	0807e793          	ori	a5,a5,128
  asm volatile("csrw mie, %0" : : "r" (x));
    800057b8:	30479073          	csrw	mie,a5
}
    800057bc:	6422                	ld	s0,8(sp)
    800057be:	0141                	addi	sp,sp,16
    800057c0:	8082                	ret

00000000800057c2 <start>:
{
    800057c2:	1141                	addi	sp,sp,-16
    800057c4:	e406                	sd	ra,8(sp)
    800057c6:	e022                	sd	s0,0(sp)
    800057c8:	0800                	addi	s0,sp,16
  asm volatile("csrr %0, mstatus" : "=r" (x) );
    800057ca:	300027f3          	csrr	a5,mstatus
  x &= ~MSTATUS_MPP_MASK;
    800057ce:	7779                	lui	a4,0xffffe
    800057d0:	7ff70713          	addi	a4,a4,2047 # ffffffffffffe7ff <end+0xffffffff7ffd15bf>
    800057d4:	8ff9                	and	a5,a5,a4
  x |= MSTATUS_MPP_S;
    800057d6:	6705                	lui	a4,0x1
    800057d8:	80070713          	addi	a4,a4,-2048 # 800 <_entry-0x7ffff800>
    800057dc:	8fd9                	or	a5,a5,a4
  asm volatile("csrw mstatus, %0" : : "r" (x));
    800057de:	30079073          	csrw	mstatus,a5
  asm volatile("csrw mepc, %0" : : "r" (x));
    800057e2:	ffffb797          	auipc	a5,0xffffb
    800057e6:	b3e78793          	addi	a5,a5,-1218 # 80000320 <main>
    800057ea:	34179073          	csrw	mepc,a5
  asm volatile("csrw satp, %0" : : "r" (x));
    800057ee:	4781                	li	a5,0
    800057f0:	18079073          	csrw	satp,a5
  asm volatile("csrw medeleg, %0" : : "r" (x));
    800057f4:	67c1                	lui	a5,0x10
    800057f6:	17fd                	addi	a5,a5,-1 # ffff <_entry-0x7fff0001>
    800057f8:	30279073          	csrw	medeleg,a5
  asm volatile("csrw mideleg, %0" : : "r" (x));
    800057fc:	30379073          	csrw	mideleg,a5
  asm volatile("csrr %0, sie" : "=r" (x) );
    80005800:	104027f3          	csrr	a5,sie
  w_sie(r_sie() | SIE_SEIE | SIE_STIE | SIE_SSIE);
    80005804:	2227e793          	ori	a5,a5,546
  asm volatile("csrw sie, %0" : : "r" (x));
    80005808:	10479073          	csrw	sie,a5
  asm volatile("csrw pmpaddr0, %0" : : "r" (x));
    8000580c:	57fd                	li	a5,-1
    8000580e:	83a9                	srli	a5,a5,0xa
    80005810:	3b079073          	csrw	pmpaddr0,a5
  asm volatile("csrw pmpcfg0, %0" : : "r" (x));
    80005814:	47bd                	li	a5,15
    80005816:	3a079073          	csrw	pmpcfg0,a5
  timerinit();
    8000581a:	00000097          	auipc	ra,0x0
    8000581e:	f38080e7          	jalr	-200(ra) # 80005752 <timerinit>
  asm volatile("csrr %0, mhartid" : "=r" (x) );
    80005822:	f14027f3          	csrr	a5,mhartid
  w_tp(id);
    80005826:	2781                	sext.w	a5,a5
  asm volatile("mv tp, %0" : : "r" (x));
    80005828:	823e                	mv	tp,a5
  asm volatile("mret");
    8000582a:	30200073          	mret
}
    8000582e:	60a2                	ld	ra,8(sp)
    80005830:	6402                	ld	s0,0(sp)
    80005832:	0141                	addi	sp,sp,16
    80005834:	8082                	ret

0000000080005836 <consolewrite>:
//
// user write()s to the console go here.
//
int
consolewrite(int user_src, uint64 src, int n)
{
    80005836:	715d                	addi	sp,sp,-80
    80005838:	e486                	sd	ra,72(sp)
    8000583a:	e0a2                	sd	s0,64(sp)
    8000583c:	fc26                	sd	s1,56(sp)
    8000583e:	f84a                	sd	s2,48(sp)
    80005840:	f44e                	sd	s3,40(sp)
    80005842:	f052                	sd	s4,32(sp)
    80005844:	ec56                	sd	s5,24(sp)
    80005846:	0880                	addi	s0,sp,80
  int i;

  for(i = 0; i < n; i++){
    80005848:	04c05763          	blez	a2,80005896 <consolewrite+0x60>
    8000584c:	8a2a                	mv	s4,a0
    8000584e:	84ae                	mv	s1,a1
    80005850:	89b2                	mv	s3,a2
    80005852:	4901                	li	s2,0
    char c;
    if(either_copyin(&c, user_src, src+i, 1) == -1)
    80005854:	5afd                	li	s5,-1
    80005856:	4685                	li	a3,1
    80005858:	8626                	mv	a2,s1
    8000585a:	85d2                	mv	a1,s4
    8000585c:	fbf40513          	addi	a0,s0,-65
    80005860:	ffffc097          	auipc	ra,0xffffc
    80005864:	0a2080e7          	jalr	162(ra) # 80001902 <either_copyin>
    80005868:	01550d63          	beq	a0,s5,80005882 <consolewrite+0x4c>
      break;
    uartputc(c);
    8000586c:	fbf44503          	lbu	a0,-65(s0)
    80005870:	00000097          	auipc	ra,0x0
    80005874:	77e080e7          	jalr	1918(ra) # 80005fee <uartputc>
  for(i = 0; i < n; i++){
    80005878:	2905                	addiw	s2,s2,1
    8000587a:	0485                	addi	s1,s1,1
    8000587c:	fd299de3          	bne	s3,s2,80005856 <consolewrite+0x20>
    80005880:	894e                	mv	s2,s3
  }

  return i;
}
    80005882:	854a                	mv	a0,s2
    80005884:	60a6                	ld	ra,72(sp)
    80005886:	6406                	ld	s0,64(sp)
    80005888:	74e2                	ld	s1,56(sp)
    8000588a:	7942                	ld	s2,48(sp)
    8000588c:	79a2                	ld	s3,40(sp)
    8000588e:	7a02                	ld	s4,32(sp)
    80005890:	6ae2                	ld	s5,24(sp)
    80005892:	6161                	addi	sp,sp,80
    80005894:	8082                	ret
  for(i = 0; i < n; i++){
    80005896:	4901                	li	s2,0
    80005898:	b7ed                	j	80005882 <consolewrite+0x4c>

000000008000589a <consoleread>:
// user_dist indicates whether dst is a user
// or kernel address.
//
int
consoleread(int user_dst, uint64 dst, int n)
{
    8000589a:	7159                	addi	sp,sp,-112
    8000589c:	f486                	sd	ra,104(sp)
    8000589e:	f0a2                	sd	s0,96(sp)
    800058a0:	eca6                	sd	s1,88(sp)
    800058a2:	e8ca                	sd	s2,80(sp)
    800058a4:	e4ce                	sd	s3,72(sp)
    800058a6:	e0d2                	sd	s4,64(sp)
    800058a8:	fc56                	sd	s5,56(sp)
    800058aa:	f85a                	sd	s6,48(sp)
    800058ac:	f45e                	sd	s7,40(sp)
    800058ae:	f062                	sd	s8,32(sp)
    800058b0:	ec66                	sd	s9,24(sp)
    800058b2:	e86a                	sd	s10,16(sp)
    800058b4:	1880                	addi	s0,sp,112
    800058b6:	8aaa                	mv	s5,a0
    800058b8:	8a2e                	mv	s4,a1
    800058ba:	89b2                	mv	s3,a2
  uint target;
  int c;
  char cbuf;

  target = n;
    800058bc:	00060b1b          	sext.w	s6,a2
  acquire(&cons.lock);
    800058c0:	00028517          	auipc	a0,0x28
    800058c4:	88050513          	addi	a0,a0,-1920 # 8002d140 <cons>
    800058c8:	00001097          	auipc	ra,0x1
    800058cc:	8e0080e7          	jalr	-1824(ra) # 800061a8 <acquire>
  while(n > 0){
    // wait until interrupt handler has put some
    // input into cons.buffer.
    while(cons.r == cons.w){
    800058d0:	00028497          	auipc	s1,0x28
    800058d4:	87048493          	addi	s1,s1,-1936 # 8002d140 <cons>
      if(myproc()->killed){
        release(&cons.lock);
        return -1;
      }
      sleep(&cons.r, &cons.lock);
    800058d8:	00028917          	auipc	s2,0x28
    800058dc:	90090913          	addi	s2,s2,-1792 # 8002d1d8 <cons+0x98>
    }

    c = cons.buf[cons.r++ % INPUT_BUF];

    if(c == C('D')){  // end-of-file
    800058e0:	4b91                	li	s7,4
      break;
    }

    // copy the input byte to the user-space buffer.
    cbuf = c;
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    800058e2:	5c7d                	li	s8,-1
      break;

    dst++;
    --n;

    if(c == '\n'){
    800058e4:	4ca9                	li	s9,10
  while(n > 0){
    800058e6:	07305863          	blez	s3,80005956 <consoleread+0xbc>
    while(cons.r == cons.w){
    800058ea:	0984a783          	lw	a5,152(s1)
    800058ee:	09c4a703          	lw	a4,156(s1)
    800058f2:	02f71463          	bne	a4,a5,8000591a <consoleread+0x80>
      if(myproc()->killed){
    800058f6:	ffffb097          	auipc	ra,0xffffb
    800058fa:	54e080e7          	jalr	1358(ra) # 80000e44 <myproc>
    800058fe:	551c                	lw	a5,40(a0)
    80005900:	e7b5                	bnez	a5,8000596c <consoleread+0xd2>
      sleep(&cons.r, &cons.lock);
    80005902:	85a6                	mv	a1,s1
    80005904:	854a                	mv	a0,s2
    80005906:	ffffc097          	auipc	ra,0xffffc
    8000590a:	c02080e7          	jalr	-1022(ra) # 80001508 <sleep>
    while(cons.r == cons.w){
    8000590e:	0984a783          	lw	a5,152(s1)
    80005912:	09c4a703          	lw	a4,156(s1)
    80005916:	fef700e3          	beq	a4,a5,800058f6 <consoleread+0x5c>
    c = cons.buf[cons.r++ % INPUT_BUF];
    8000591a:	0017871b          	addiw	a4,a5,1
    8000591e:	08e4ac23          	sw	a4,152(s1)
    80005922:	07f7f713          	andi	a4,a5,127
    80005926:	9726                	add	a4,a4,s1
    80005928:	01874703          	lbu	a4,24(a4)
    8000592c:	00070d1b          	sext.w	s10,a4
    if(c == C('D')){  // end-of-file
    80005930:	077d0563          	beq	s10,s7,8000599a <consoleread+0x100>
    cbuf = c;
    80005934:	f8e40fa3          	sb	a4,-97(s0)
    if(either_copyout(user_dst, dst, &cbuf, 1) == -1)
    80005938:	4685                	li	a3,1
    8000593a:	f9f40613          	addi	a2,s0,-97
    8000593e:	85d2                	mv	a1,s4
    80005940:	8556                	mv	a0,s5
    80005942:	ffffc097          	auipc	ra,0xffffc
    80005946:	f6a080e7          	jalr	-150(ra) # 800018ac <either_copyout>
    8000594a:	01850663          	beq	a0,s8,80005956 <consoleread+0xbc>
    dst++;
    8000594e:	0a05                	addi	s4,s4,1
    --n;
    80005950:	39fd                	addiw	s3,s3,-1
    if(c == '\n'){
    80005952:	f99d1ae3          	bne	s10,s9,800058e6 <consoleread+0x4c>
      // a whole line has arrived, return to
      // the user-level read().
      break;
    }
  }
  release(&cons.lock);
    80005956:	00027517          	auipc	a0,0x27
    8000595a:	7ea50513          	addi	a0,a0,2026 # 8002d140 <cons>
    8000595e:	00001097          	auipc	ra,0x1
    80005962:	8fe080e7          	jalr	-1794(ra) # 8000625c <release>

  return target - n;
    80005966:	413b053b          	subw	a0,s6,s3
    8000596a:	a811                	j	8000597e <consoleread+0xe4>
        release(&cons.lock);
    8000596c:	00027517          	auipc	a0,0x27
    80005970:	7d450513          	addi	a0,a0,2004 # 8002d140 <cons>
    80005974:	00001097          	auipc	ra,0x1
    80005978:	8e8080e7          	jalr	-1816(ra) # 8000625c <release>
        return -1;
    8000597c:	557d                	li	a0,-1
}
    8000597e:	70a6                	ld	ra,104(sp)
    80005980:	7406                	ld	s0,96(sp)
    80005982:	64e6                	ld	s1,88(sp)
    80005984:	6946                	ld	s2,80(sp)
    80005986:	69a6                	ld	s3,72(sp)
    80005988:	6a06                	ld	s4,64(sp)
    8000598a:	7ae2                	ld	s5,56(sp)
    8000598c:	7b42                	ld	s6,48(sp)
    8000598e:	7ba2                	ld	s7,40(sp)
    80005990:	7c02                	ld	s8,32(sp)
    80005992:	6ce2                	ld	s9,24(sp)
    80005994:	6d42                	ld	s10,16(sp)
    80005996:	6165                	addi	sp,sp,112
    80005998:	8082                	ret
      if(n < target){
    8000599a:	0009871b          	sext.w	a4,s3
    8000599e:	fb677ce3          	bgeu	a4,s6,80005956 <consoleread+0xbc>
        cons.r--;
    800059a2:	00028717          	auipc	a4,0x28
    800059a6:	82f72b23          	sw	a5,-1994(a4) # 8002d1d8 <cons+0x98>
    800059aa:	b775                	j	80005956 <consoleread+0xbc>

00000000800059ac <consputc>:
{
    800059ac:	1141                	addi	sp,sp,-16
    800059ae:	e406                	sd	ra,8(sp)
    800059b0:	e022                	sd	s0,0(sp)
    800059b2:	0800                	addi	s0,sp,16
  if(c == BACKSPACE){
    800059b4:	10000793          	li	a5,256
    800059b8:	00f50a63          	beq	a0,a5,800059cc <consputc+0x20>
    uartputc_sync(c);
    800059bc:	00000097          	auipc	ra,0x0
    800059c0:	560080e7          	jalr	1376(ra) # 80005f1c <uartputc_sync>
}
    800059c4:	60a2                	ld	ra,8(sp)
    800059c6:	6402                	ld	s0,0(sp)
    800059c8:	0141                	addi	sp,sp,16
    800059ca:	8082                	ret
    uartputc_sync('\b'); uartputc_sync(' '); uartputc_sync('\b');
    800059cc:	4521                	li	a0,8
    800059ce:	00000097          	auipc	ra,0x0
    800059d2:	54e080e7          	jalr	1358(ra) # 80005f1c <uartputc_sync>
    800059d6:	02000513          	li	a0,32
    800059da:	00000097          	auipc	ra,0x0
    800059de:	542080e7          	jalr	1346(ra) # 80005f1c <uartputc_sync>
    800059e2:	4521                	li	a0,8
    800059e4:	00000097          	auipc	ra,0x0
    800059e8:	538080e7          	jalr	1336(ra) # 80005f1c <uartputc_sync>
    800059ec:	bfe1                	j	800059c4 <consputc+0x18>

00000000800059ee <consoleintr>:
// do erase/kill processing, append to cons.buf,
// wake up consoleread() if a whole line has arrived.
//
void
consoleintr(int c)
{
    800059ee:	1101                	addi	sp,sp,-32
    800059f0:	ec06                	sd	ra,24(sp)
    800059f2:	e822                	sd	s0,16(sp)
    800059f4:	e426                	sd	s1,8(sp)
    800059f6:	e04a                	sd	s2,0(sp)
    800059f8:	1000                	addi	s0,sp,32
    800059fa:	84aa                	mv	s1,a0
  acquire(&cons.lock);
    800059fc:	00027517          	auipc	a0,0x27
    80005a00:	74450513          	addi	a0,a0,1860 # 8002d140 <cons>
    80005a04:	00000097          	auipc	ra,0x0
    80005a08:	7a4080e7          	jalr	1956(ra) # 800061a8 <acquire>

  switch(c){
    80005a0c:	47d5                	li	a5,21
    80005a0e:	0af48663          	beq	s1,a5,80005aba <consoleintr+0xcc>
    80005a12:	0297ca63          	blt	a5,s1,80005a46 <consoleintr+0x58>
    80005a16:	47a1                	li	a5,8
    80005a18:	0ef48763          	beq	s1,a5,80005b06 <consoleintr+0x118>
    80005a1c:	47c1                	li	a5,16
    80005a1e:	10f49a63          	bne	s1,a5,80005b32 <consoleintr+0x144>
  case C('P'):  // Print process list.
    procdump();
    80005a22:	ffffc097          	auipc	ra,0xffffc
    80005a26:	f36080e7          	jalr	-202(ra) # 80001958 <procdump>
      }
    }
    break;
  }
  
  release(&cons.lock);
    80005a2a:	00027517          	auipc	a0,0x27
    80005a2e:	71650513          	addi	a0,a0,1814 # 8002d140 <cons>
    80005a32:	00001097          	auipc	ra,0x1
    80005a36:	82a080e7          	jalr	-2006(ra) # 8000625c <release>
}
    80005a3a:	60e2                	ld	ra,24(sp)
    80005a3c:	6442                	ld	s0,16(sp)
    80005a3e:	64a2                	ld	s1,8(sp)
    80005a40:	6902                	ld	s2,0(sp)
    80005a42:	6105                	addi	sp,sp,32
    80005a44:	8082                	ret
  switch(c){
    80005a46:	07f00793          	li	a5,127
    80005a4a:	0af48e63          	beq	s1,a5,80005b06 <consoleintr+0x118>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005a4e:	00027717          	auipc	a4,0x27
    80005a52:	6f270713          	addi	a4,a4,1778 # 8002d140 <cons>
    80005a56:	0a072783          	lw	a5,160(a4)
    80005a5a:	09872703          	lw	a4,152(a4)
    80005a5e:	9f99                	subw	a5,a5,a4
    80005a60:	07f00713          	li	a4,127
    80005a64:	fcf763e3          	bltu	a4,a5,80005a2a <consoleintr+0x3c>
      c = (c == '\r') ? '\n' : c;
    80005a68:	47b5                	li	a5,13
    80005a6a:	0cf48763          	beq	s1,a5,80005b38 <consoleintr+0x14a>
      consputc(c);
    80005a6e:	8526                	mv	a0,s1
    80005a70:	00000097          	auipc	ra,0x0
    80005a74:	f3c080e7          	jalr	-196(ra) # 800059ac <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005a78:	00027797          	auipc	a5,0x27
    80005a7c:	6c878793          	addi	a5,a5,1736 # 8002d140 <cons>
    80005a80:	0a07a703          	lw	a4,160(a5)
    80005a84:	0017069b          	addiw	a3,a4,1
    80005a88:	0006861b          	sext.w	a2,a3
    80005a8c:	0ad7a023          	sw	a3,160(a5)
    80005a90:	07f77713          	andi	a4,a4,127
    80005a94:	97ba                	add	a5,a5,a4
    80005a96:	00978c23          	sb	s1,24(a5)
      if(c == '\n' || c == C('D') || cons.e == cons.r+INPUT_BUF){
    80005a9a:	47a9                	li	a5,10
    80005a9c:	0cf48563          	beq	s1,a5,80005b66 <consoleintr+0x178>
    80005aa0:	4791                	li	a5,4
    80005aa2:	0cf48263          	beq	s1,a5,80005b66 <consoleintr+0x178>
    80005aa6:	00027797          	auipc	a5,0x27
    80005aaa:	7327a783          	lw	a5,1842(a5) # 8002d1d8 <cons+0x98>
    80005aae:	0807879b          	addiw	a5,a5,128
    80005ab2:	f6f61ce3          	bne	a2,a5,80005a2a <consoleintr+0x3c>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005ab6:	863e                	mv	a2,a5
    80005ab8:	a07d                	j	80005b66 <consoleintr+0x178>
    while(cons.e != cons.w &&
    80005aba:	00027717          	auipc	a4,0x27
    80005abe:	68670713          	addi	a4,a4,1670 # 8002d140 <cons>
    80005ac2:	0a072783          	lw	a5,160(a4)
    80005ac6:	09c72703          	lw	a4,156(a4)
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005aca:	00027497          	auipc	s1,0x27
    80005ace:	67648493          	addi	s1,s1,1654 # 8002d140 <cons>
    while(cons.e != cons.w &&
    80005ad2:	4929                	li	s2,10
    80005ad4:	f4f70be3          	beq	a4,a5,80005a2a <consoleintr+0x3c>
          cons.buf[(cons.e-1) % INPUT_BUF] != '\n'){
    80005ad8:	37fd                	addiw	a5,a5,-1
    80005ada:	07f7f713          	andi	a4,a5,127
    80005ade:	9726                	add	a4,a4,s1
    while(cons.e != cons.w &&
    80005ae0:	01874703          	lbu	a4,24(a4)
    80005ae4:	f52703e3          	beq	a4,s2,80005a2a <consoleintr+0x3c>
      cons.e--;
    80005ae8:	0af4a023          	sw	a5,160(s1)
      consputc(BACKSPACE);
    80005aec:	10000513          	li	a0,256
    80005af0:	00000097          	auipc	ra,0x0
    80005af4:	ebc080e7          	jalr	-324(ra) # 800059ac <consputc>
    while(cons.e != cons.w &&
    80005af8:	0a04a783          	lw	a5,160(s1)
    80005afc:	09c4a703          	lw	a4,156(s1)
    80005b00:	fcf71ce3          	bne	a4,a5,80005ad8 <consoleintr+0xea>
    80005b04:	b71d                	j	80005a2a <consoleintr+0x3c>
    if(cons.e != cons.w){
    80005b06:	00027717          	auipc	a4,0x27
    80005b0a:	63a70713          	addi	a4,a4,1594 # 8002d140 <cons>
    80005b0e:	0a072783          	lw	a5,160(a4)
    80005b12:	09c72703          	lw	a4,156(a4)
    80005b16:	f0f70ae3          	beq	a4,a5,80005a2a <consoleintr+0x3c>
      cons.e--;
    80005b1a:	37fd                	addiw	a5,a5,-1
    80005b1c:	00027717          	auipc	a4,0x27
    80005b20:	6cf72223          	sw	a5,1732(a4) # 8002d1e0 <cons+0xa0>
      consputc(BACKSPACE);
    80005b24:	10000513          	li	a0,256
    80005b28:	00000097          	auipc	ra,0x0
    80005b2c:	e84080e7          	jalr	-380(ra) # 800059ac <consputc>
    80005b30:	bded                	j	80005a2a <consoleintr+0x3c>
    if(c != 0 && cons.e-cons.r < INPUT_BUF){
    80005b32:	ee048ce3          	beqz	s1,80005a2a <consoleintr+0x3c>
    80005b36:	bf21                	j	80005a4e <consoleintr+0x60>
      consputc(c);
    80005b38:	4529                	li	a0,10
    80005b3a:	00000097          	auipc	ra,0x0
    80005b3e:	e72080e7          	jalr	-398(ra) # 800059ac <consputc>
      cons.buf[cons.e++ % INPUT_BUF] = c;
    80005b42:	00027797          	auipc	a5,0x27
    80005b46:	5fe78793          	addi	a5,a5,1534 # 8002d140 <cons>
    80005b4a:	0a07a703          	lw	a4,160(a5)
    80005b4e:	0017069b          	addiw	a3,a4,1
    80005b52:	0006861b          	sext.w	a2,a3
    80005b56:	0ad7a023          	sw	a3,160(a5)
    80005b5a:	07f77713          	andi	a4,a4,127
    80005b5e:	97ba                	add	a5,a5,a4
    80005b60:	4729                	li	a4,10
    80005b62:	00e78c23          	sb	a4,24(a5)
        cons.w = cons.e;
    80005b66:	00027797          	auipc	a5,0x27
    80005b6a:	66c7ab23          	sw	a2,1654(a5) # 8002d1dc <cons+0x9c>
        wakeup(&cons.r);
    80005b6e:	00027517          	auipc	a0,0x27
    80005b72:	66a50513          	addi	a0,a0,1642 # 8002d1d8 <cons+0x98>
    80005b76:	ffffc097          	auipc	ra,0xffffc
    80005b7a:	b1e080e7          	jalr	-1250(ra) # 80001694 <wakeup>
    80005b7e:	b575                	j	80005a2a <consoleintr+0x3c>

0000000080005b80 <consoleinit>:

void
consoleinit(void)
{
    80005b80:	1141                	addi	sp,sp,-16
    80005b82:	e406                	sd	ra,8(sp)
    80005b84:	e022                	sd	s0,0(sp)
    80005b86:	0800                	addi	s0,sp,16
  initlock(&cons.lock, "cons");
    80005b88:	00003597          	auipc	a1,0x3
    80005b8c:	d7858593          	addi	a1,a1,-648 # 80008900 <syscalls+0x538>
    80005b90:	00027517          	auipc	a0,0x27
    80005b94:	5b050513          	addi	a0,a0,1456 # 8002d140 <cons>
    80005b98:	00000097          	auipc	ra,0x0
    80005b9c:	580080e7          	jalr	1408(ra) # 80006118 <initlock>

  uartinit();
    80005ba0:	00000097          	auipc	ra,0x0
    80005ba4:	32c080e7          	jalr	812(ra) # 80005ecc <uartinit>

  // connect read and write system calls
  // to consoleread and consolewrite.
  devsw[CONSOLE].read = consoleread;
    80005ba8:	0001b797          	auipc	a5,0x1b
    80005bac:	fa078793          	addi	a5,a5,-96 # 80020b48 <devsw>
    80005bb0:	00000717          	auipc	a4,0x0
    80005bb4:	cea70713          	addi	a4,a4,-790 # 8000589a <consoleread>
    80005bb8:	eb98                	sd	a4,16(a5)
  devsw[CONSOLE].write = consolewrite;
    80005bba:	00000717          	auipc	a4,0x0
    80005bbe:	c7c70713          	addi	a4,a4,-900 # 80005836 <consolewrite>
    80005bc2:	ef98                	sd	a4,24(a5)
}
    80005bc4:	60a2                	ld	ra,8(sp)
    80005bc6:	6402                	ld	s0,0(sp)
    80005bc8:	0141                	addi	sp,sp,16
    80005bca:	8082                	ret

0000000080005bcc <printint>:

static char digits[] = "0123456789abcdef";

static void
printint(int xx, int base, int sign)
{
    80005bcc:	7179                	addi	sp,sp,-48
    80005bce:	f406                	sd	ra,40(sp)
    80005bd0:	f022                	sd	s0,32(sp)
    80005bd2:	ec26                	sd	s1,24(sp)
    80005bd4:	e84a                	sd	s2,16(sp)
    80005bd6:	1800                	addi	s0,sp,48
  char buf[16];
  int i;
  uint x;

  if(sign && (sign = xx < 0))
    80005bd8:	c219                	beqz	a2,80005bde <printint+0x12>
    80005bda:	08054763          	bltz	a0,80005c68 <printint+0x9c>
    x = -xx;
  else
    x = xx;
    80005bde:	2501                	sext.w	a0,a0
    80005be0:	4881                	li	a7,0
    80005be2:	fd040693          	addi	a3,s0,-48

  i = 0;
    80005be6:	4701                	li	a4,0
  do {
    buf[i++] = digits[x % base];
    80005be8:	2581                	sext.w	a1,a1
    80005bea:	00003617          	auipc	a2,0x3
    80005bee:	d4660613          	addi	a2,a2,-698 # 80008930 <digits>
    80005bf2:	883a                	mv	a6,a4
    80005bf4:	2705                	addiw	a4,a4,1
    80005bf6:	02b577bb          	remuw	a5,a0,a1
    80005bfa:	1782                	slli	a5,a5,0x20
    80005bfc:	9381                	srli	a5,a5,0x20
    80005bfe:	97b2                	add	a5,a5,a2
    80005c00:	0007c783          	lbu	a5,0(a5)
    80005c04:	00f68023          	sb	a5,0(a3)
  } while((x /= base) != 0);
    80005c08:	0005079b          	sext.w	a5,a0
    80005c0c:	02b5553b          	divuw	a0,a0,a1
    80005c10:	0685                	addi	a3,a3,1
    80005c12:	feb7f0e3          	bgeu	a5,a1,80005bf2 <printint+0x26>

  if(sign)
    80005c16:	00088c63          	beqz	a7,80005c2e <printint+0x62>
    buf[i++] = '-';
    80005c1a:	fe070793          	addi	a5,a4,-32
    80005c1e:	00878733          	add	a4,a5,s0
    80005c22:	02d00793          	li	a5,45
    80005c26:	fef70823          	sb	a5,-16(a4)
    80005c2a:	0028071b          	addiw	a4,a6,2

  while(--i >= 0)
    80005c2e:	02e05763          	blez	a4,80005c5c <printint+0x90>
    80005c32:	fd040793          	addi	a5,s0,-48
    80005c36:	00e784b3          	add	s1,a5,a4
    80005c3a:	fff78913          	addi	s2,a5,-1
    80005c3e:	993a                	add	s2,s2,a4
    80005c40:	377d                	addiw	a4,a4,-1
    80005c42:	1702                	slli	a4,a4,0x20
    80005c44:	9301                	srli	a4,a4,0x20
    80005c46:	40e90933          	sub	s2,s2,a4
    consputc(buf[i]);
    80005c4a:	fff4c503          	lbu	a0,-1(s1)
    80005c4e:	00000097          	auipc	ra,0x0
    80005c52:	d5e080e7          	jalr	-674(ra) # 800059ac <consputc>
  while(--i >= 0)
    80005c56:	14fd                	addi	s1,s1,-1
    80005c58:	ff2499e3          	bne	s1,s2,80005c4a <printint+0x7e>
}
    80005c5c:	70a2                	ld	ra,40(sp)
    80005c5e:	7402                	ld	s0,32(sp)
    80005c60:	64e2                	ld	s1,24(sp)
    80005c62:	6942                	ld	s2,16(sp)
    80005c64:	6145                	addi	sp,sp,48
    80005c66:	8082                	ret
    x = -xx;
    80005c68:	40a0053b          	negw	a0,a0
  if(sign && (sign = xx < 0))
    80005c6c:	4885                	li	a7,1
    x = -xx;
    80005c6e:	bf95                	j	80005be2 <printint+0x16>

0000000080005c70 <panic>:
    release(&pr.lock);
}

void
panic(char *s)
{
    80005c70:	1101                	addi	sp,sp,-32
    80005c72:	ec06                	sd	ra,24(sp)
    80005c74:	e822                	sd	s0,16(sp)
    80005c76:	e426                	sd	s1,8(sp)
    80005c78:	1000                	addi	s0,sp,32
    80005c7a:	84aa                	mv	s1,a0
  pr.locking = 0;
    80005c7c:	00027797          	auipc	a5,0x27
    80005c80:	5807a223          	sw	zero,1412(a5) # 8002d200 <pr+0x18>
  printf("panic: ");
    80005c84:	00003517          	auipc	a0,0x3
    80005c88:	c8450513          	addi	a0,a0,-892 # 80008908 <syscalls+0x540>
    80005c8c:	00000097          	auipc	ra,0x0
    80005c90:	02e080e7          	jalr	46(ra) # 80005cba <printf>
  printf(s);
    80005c94:	8526                	mv	a0,s1
    80005c96:	00000097          	auipc	ra,0x0
    80005c9a:	024080e7          	jalr	36(ra) # 80005cba <printf>
  printf("\n");
    80005c9e:	00003517          	auipc	a0,0x3
    80005ca2:	afa50513          	addi	a0,a0,-1286 # 80008798 <syscalls+0x3d0>
    80005ca6:	00000097          	auipc	ra,0x0
    80005caa:	014080e7          	jalr	20(ra) # 80005cba <printf>
  panicked = 1; // freeze uart output from other CPUs
    80005cae:	4785                	li	a5,1
    80005cb0:	00003717          	auipc	a4,0x3
    80005cb4:	36f72623          	sw	a5,876(a4) # 8000901c <panicked>
  for(;;)
    80005cb8:	a001                	j	80005cb8 <panic+0x48>

0000000080005cba <printf>:
{
    80005cba:	7131                	addi	sp,sp,-192
    80005cbc:	fc86                	sd	ra,120(sp)
    80005cbe:	f8a2                	sd	s0,112(sp)
    80005cc0:	f4a6                	sd	s1,104(sp)
    80005cc2:	f0ca                	sd	s2,96(sp)
    80005cc4:	ecce                	sd	s3,88(sp)
    80005cc6:	e8d2                	sd	s4,80(sp)
    80005cc8:	e4d6                	sd	s5,72(sp)
    80005cca:	e0da                	sd	s6,64(sp)
    80005ccc:	fc5e                	sd	s7,56(sp)
    80005cce:	f862                	sd	s8,48(sp)
    80005cd0:	f466                	sd	s9,40(sp)
    80005cd2:	f06a                	sd	s10,32(sp)
    80005cd4:	ec6e                	sd	s11,24(sp)
    80005cd6:	0100                	addi	s0,sp,128
    80005cd8:	8a2a                	mv	s4,a0
    80005cda:	e40c                	sd	a1,8(s0)
    80005cdc:	e810                	sd	a2,16(s0)
    80005cde:	ec14                	sd	a3,24(s0)
    80005ce0:	f018                	sd	a4,32(s0)
    80005ce2:	f41c                	sd	a5,40(s0)
    80005ce4:	03043823          	sd	a6,48(s0)
    80005ce8:	03143c23          	sd	a7,56(s0)
  locking = pr.locking;
    80005cec:	00027d97          	auipc	s11,0x27
    80005cf0:	514dad83          	lw	s11,1300(s11) # 8002d200 <pr+0x18>
  if(locking)
    80005cf4:	020d9b63          	bnez	s11,80005d2a <printf+0x70>
  if (fmt == 0)
    80005cf8:	040a0263          	beqz	s4,80005d3c <printf+0x82>
  va_start(ap, fmt);
    80005cfc:	00840793          	addi	a5,s0,8
    80005d00:	f8f43423          	sd	a5,-120(s0)
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005d04:	000a4503          	lbu	a0,0(s4)
    80005d08:	14050f63          	beqz	a0,80005e66 <printf+0x1ac>
    80005d0c:	4981                	li	s3,0
    if(c != '%'){
    80005d0e:	02500a93          	li	s5,37
    switch(c){
    80005d12:	07000b93          	li	s7,112
  consputc('x');
    80005d16:	4d41                	li	s10,16
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005d18:	00003b17          	auipc	s6,0x3
    80005d1c:	c18b0b13          	addi	s6,s6,-1000 # 80008930 <digits>
    switch(c){
    80005d20:	07300c93          	li	s9,115
    80005d24:	06400c13          	li	s8,100
    80005d28:	a82d                	j	80005d62 <printf+0xa8>
    acquire(&pr.lock);
    80005d2a:	00027517          	auipc	a0,0x27
    80005d2e:	4be50513          	addi	a0,a0,1214 # 8002d1e8 <pr>
    80005d32:	00000097          	auipc	ra,0x0
    80005d36:	476080e7          	jalr	1142(ra) # 800061a8 <acquire>
    80005d3a:	bf7d                	j	80005cf8 <printf+0x3e>
    panic("null fmt");
    80005d3c:	00003517          	auipc	a0,0x3
    80005d40:	bdc50513          	addi	a0,a0,-1060 # 80008918 <syscalls+0x550>
    80005d44:	00000097          	auipc	ra,0x0
    80005d48:	f2c080e7          	jalr	-212(ra) # 80005c70 <panic>
      consputc(c);
    80005d4c:	00000097          	auipc	ra,0x0
    80005d50:	c60080e7          	jalr	-928(ra) # 800059ac <consputc>
  for(i = 0; (c = fmt[i] & 0xff) != 0; i++){
    80005d54:	2985                	addiw	s3,s3,1
    80005d56:	013a07b3          	add	a5,s4,s3
    80005d5a:	0007c503          	lbu	a0,0(a5)
    80005d5e:	10050463          	beqz	a0,80005e66 <printf+0x1ac>
    if(c != '%'){
    80005d62:	ff5515e3          	bne	a0,s5,80005d4c <printf+0x92>
    c = fmt[++i] & 0xff;
    80005d66:	2985                	addiw	s3,s3,1
    80005d68:	013a07b3          	add	a5,s4,s3
    80005d6c:	0007c783          	lbu	a5,0(a5)
    80005d70:	0007849b          	sext.w	s1,a5
    if(c == 0)
    80005d74:	cbed                	beqz	a5,80005e66 <printf+0x1ac>
    switch(c){
    80005d76:	05778a63          	beq	a5,s7,80005dca <printf+0x110>
    80005d7a:	02fbf663          	bgeu	s7,a5,80005da6 <printf+0xec>
    80005d7e:	09978863          	beq	a5,s9,80005e0e <printf+0x154>
    80005d82:	07800713          	li	a4,120
    80005d86:	0ce79563          	bne	a5,a4,80005e50 <printf+0x196>
      printint(va_arg(ap, int), 16, 1);
    80005d8a:	f8843783          	ld	a5,-120(s0)
    80005d8e:	00878713          	addi	a4,a5,8
    80005d92:	f8e43423          	sd	a4,-120(s0)
    80005d96:	4605                	li	a2,1
    80005d98:	85ea                	mv	a1,s10
    80005d9a:	4388                	lw	a0,0(a5)
    80005d9c:	00000097          	auipc	ra,0x0
    80005da0:	e30080e7          	jalr	-464(ra) # 80005bcc <printint>
      break;
    80005da4:	bf45                	j	80005d54 <printf+0x9a>
    switch(c){
    80005da6:	09578f63          	beq	a5,s5,80005e44 <printf+0x18a>
    80005daa:	0b879363          	bne	a5,s8,80005e50 <printf+0x196>
      printint(va_arg(ap, int), 10, 1);
    80005dae:	f8843783          	ld	a5,-120(s0)
    80005db2:	00878713          	addi	a4,a5,8
    80005db6:	f8e43423          	sd	a4,-120(s0)
    80005dba:	4605                	li	a2,1
    80005dbc:	45a9                	li	a1,10
    80005dbe:	4388                	lw	a0,0(a5)
    80005dc0:	00000097          	auipc	ra,0x0
    80005dc4:	e0c080e7          	jalr	-500(ra) # 80005bcc <printint>
      break;
    80005dc8:	b771                	j	80005d54 <printf+0x9a>
      printptr(va_arg(ap, uint64));
    80005dca:	f8843783          	ld	a5,-120(s0)
    80005dce:	00878713          	addi	a4,a5,8
    80005dd2:	f8e43423          	sd	a4,-120(s0)
    80005dd6:	0007b903          	ld	s2,0(a5)
  consputc('0');
    80005dda:	03000513          	li	a0,48
    80005dde:	00000097          	auipc	ra,0x0
    80005de2:	bce080e7          	jalr	-1074(ra) # 800059ac <consputc>
  consputc('x');
    80005de6:	07800513          	li	a0,120
    80005dea:	00000097          	auipc	ra,0x0
    80005dee:	bc2080e7          	jalr	-1086(ra) # 800059ac <consputc>
    80005df2:	84ea                	mv	s1,s10
    consputc(digits[x >> (sizeof(uint64) * 8 - 4)]);
    80005df4:	03c95793          	srli	a5,s2,0x3c
    80005df8:	97da                	add	a5,a5,s6
    80005dfa:	0007c503          	lbu	a0,0(a5)
    80005dfe:	00000097          	auipc	ra,0x0
    80005e02:	bae080e7          	jalr	-1106(ra) # 800059ac <consputc>
  for (i = 0; i < (sizeof(uint64) * 2); i++, x <<= 4)
    80005e06:	0912                	slli	s2,s2,0x4
    80005e08:	34fd                	addiw	s1,s1,-1
    80005e0a:	f4ed                	bnez	s1,80005df4 <printf+0x13a>
    80005e0c:	b7a1                	j	80005d54 <printf+0x9a>
      if((s = va_arg(ap, char*)) == 0)
    80005e0e:	f8843783          	ld	a5,-120(s0)
    80005e12:	00878713          	addi	a4,a5,8
    80005e16:	f8e43423          	sd	a4,-120(s0)
    80005e1a:	6384                	ld	s1,0(a5)
    80005e1c:	cc89                	beqz	s1,80005e36 <printf+0x17c>
      for(; *s; s++)
    80005e1e:	0004c503          	lbu	a0,0(s1)
    80005e22:	d90d                	beqz	a0,80005d54 <printf+0x9a>
        consputc(*s);
    80005e24:	00000097          	auipc	ra,0x0
    80005e28:	b88080e7          	jalr	-1144(ra) # 800059ac <consputc>
      for(; *s; s++)
    80005e2c:	0485                	addi	s1,s1,1
    80005e2e:	0004c503          	lbu	a0,0(s1)
    80005e32:	f96d                	bnez	a0,80005e24 <printf+0x16a>
    80005e34:	b705                	j	80005d54 <printf+0x9a>
        s = "(null)";
    80005e36:	00003497          	auipc	s1,0x3
    80005e3a:	ada48493          	addi	s1,s1,-1318 # 80008910 <syscalls+0x548>
      for(; *s; s++)
    80005e3e:	02800513          	li	a0,40
    80005e42:	b7cd                	j	80005e24 <printf+0x16a>
      consputc('%');
    80005e44:	8556                	mv	a0,s5
    80005e46:	00000097          	auipc	ra,0x0
    80005e4a:	b66080e7          	jalr	-1178(ra) # 800059ac <consputc>
      break;
    80005e4e:	b719                	j	80005d54 <printf+0x9a>
      consputc('%');
    80005e50:	8556                	mv	a0,s5
    80005e52:	00000097          	auipc	ra,0x0
    80005e56:	b5a080e7          	jalr	-1190(ra) # 800059ac <consputc>
      consputc(c);
    80005e5a:	8526                	mv	a0,s1
    80005e5c:	00000097          	auipc	ra,0x0
    80005e60:	b50080e7          	jalr	-1200(ra) # 800059ac <consputc>
      break;
    80005e64:	bdc5                	j	80005d54 <printf+0x9a>
  if(locking)
    80005e66:	020d9163          	bnez	s11,80005e88 <printf+0x1ce>
}
    80005e6a:	70e6                	ld	ra,120(sp)
    80005e6c:	7446                	ld	s0,112(sp)
    80005e6e:	74a6                	ld	s1,104(sp)
    80005e70:	7906                	ld	s2,96(sp)
    80005e72:	69e6                	ld	s3,88(sp)
    80005e74:	6a46                	ld	s4,80(sp)
    80005e76:	6aa6                	ld	s5,72(sp)
    80005e78:	6b06                	ld	s6,64(sp)
    80005e7a:	7be2                	ld	s7,56(sp)
    80005e7c:	7c42                	ld	s8,48(sp)
    80005e7e:	7ca2                	ld	s9,40(sp)
    80005e80:	7d02                	ld	s10,32(sp)
    80005e82:	6de2                	ld	s11,24(sp)
    80005e84:	6129                	addi	sp,sp,192
    80005e86:	8082                	ret
    release(&pr.lock);
    80005e88:	00027517          	auipc	a0,0x27
    80005e8c:	36050513          	addi	a0,a0,864 # 8002d1e8 <pr>
    80005e90:	00000097          	auipc	ra,0x0
    80005e94:	3cc080e7          	jalr	972(ra) # 8000625c <release>
}
    80005e98:	bfc9                	j	80005e6a <printf+0x1b0>

0000000080005e9a <printfinit>:
    ;
}

void
printfinit(void)
{
    80005e9a:	1101                	addi	sp,sp,-32
    80005e9c:	ec06                	sd	ra,24(sp)
    80005e9e:	e822                	sd	s0,16(sp)
    80005ea0:	e426                	sd	s1,8(sp)
    80005ea2:	1000                	addi	s0,sp,32
  initlock(&pr.lock, "pr");
    80005ea4:	00027497          	auipc	s1,0x27
    80005ea8:	34448493          	addi	s1,s1,836 # 8002d1e8 <pr>
    80005eac:	00003597          	auipc	a1,0x3
    80005eb0:	a7c58593          	addi	a1,a1,-1412 # 80008928 <syscalls+0x560>
    80005eb4:	8526                	mv	a0,s1
    80005eb6:	00000097          	auipc	ra,0x0
    80005eba:	262080e7          	jalr	610(ra) # 80006118 <initlock>
  pr.locking = 1;
    80005ebe:	4785                	li	a5,1
    80005ec0:	cc9c                	sw	a5,24(s1)
}
    80005ec2:	60e2                	ld	ra,24(sp)
    80005ec4:	6442                	ld	s0,16(sp)
    80005ec6:	64a2                	ld	s1,8(sp)
    80005ec8:	6105                	addi	sp,sp,32
    80005eca:	8082                	ret

0000000080005ecc <uartinit>:

void uartstart();

void
uartinit(void)
{
    80005ecc:	1141                	addi	sp,sp,-16
    80005ece:	e406                	sd	ra,8(sp)
    80005ed0:	e022                	sd	s0,0(sp)
    80005ed2:	0800                	addi	s0,sp,16
  // disable interrupts.
  WriteReg(IER, 0x00);
    80005ed4:	100007b7          	lui	a5,0x10000
    80005ed8:	000780a3          	sb	zero,1(a5) # 10000001 <_entry-0x6fffffff>

  // special mode to set baud rate.
  WriteReg(LCR, LCR_BAUD_LATCH);
    80005edc:	f8000713          	li	a4,-128
    80005ee0:	00e781a3          	sb	a4,3(a5)

  // LSB for baud rate of 38.4K.
  WriteReg(0, 0x03);
    80005ee4:	470d                	li	a4,3
    80005ee6:	00e78023          	sb	a4,0(a5)

  // MSB for baud rate of 38.4K.
  WriteReg(1, 0x00);
    80005eea:	000780a3          	sb	zero,1(a5)

  // leave set-baud mode,
  // and set word length to 8 bits, no parity.
  WriteReg(LCR, LCR_EIGHT_BITS);
    80005eee:	00e781a3          	sb	a4,3(a5)

  // reset and enable FIFOs.
  WriteReg(FCR, FCR_FIFO_ENABLE | FCR_FIFO_CLEAR);
    80005ef2:	469d                	li	a3,7
    80005ef4:	00d78123          	sb	a3,2(a5)

  // enable transmit and receive interrupts.
  WriteReg(IER, IER_TX_ENABLE | IER_RX_ENABLE);
    80005ef8:	00e780a3          	sb	a4,1(a5)

  initlock(&uart_tx_lock, "uart");
    80005efc:	00003597          	auipc	a1,0x3
    80005f00:	a4c58593          	addi	a1,a1,-1460 # 80008948 <digits+0x18>
    80005f04:	00027517          	auipc	a0,0x27
    80005f08:	30450513          	addi	a0,a0,772 # 8002d208 <uart_tx_lock>
    80005f0c:	00000097          	auipc	ra,0x0
    80005f10:	20c080e7          	jalr	524(ra) # 80006118 <initlock>
}
    80005f14:	60a2                	ld	ra,8(sp)
    80005f16:	6402                	ld	s0,0(sp)
    80005f18:	0141                	addi	sp,sp,16
    80005f1a:	8082                	ret

0000000080005f1c <uartputc_sync>:
// use interrupts, for use by kernel printf() and
// to echo characters. it spins waiting for the uart's
// output register to be empty.
void
uartputc_sync(int c)
{
    80005f1c:	1101                	addi	sp,sp,-32
    80005f1e:	ec06                	sd	ra,24(sp)
    80005f20:	e822                	sd	s0,16(sp)
    80005f22:	e426                	sd	s1,8(sp)
    80005f24:	1000                	addi	s0,sp,32
    80005f26:	84aa                	mv	s1,a0
  push_off();
    80005f28:	00000097          	auipc	ra,0x0
    80005f2c:	234080e7          	jalr	564(ra) # 8000615c <push_off>

  if(panicked){
    80005f30:	00003797          	auipc	a5,0x3
    80005f34:	0ec7a783          	lw	a5,236(a5) # 8000901c <panicked>
    for(;;)
      ;
  }

  // wait for Transmit Holding Empty to be set in LSR.
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005f38:	10000737          	lui	a4,0x10000
  if(panicked){
    80005f3c:	c391                	beqz	a5,80005f40 <uartputc_sync+0x24>
    for(;;)
    80005f3e:	a001                	j	80005f3e <uartputc_sync+0x22>
  while((ReadReg(LSR) & LSR_TX_IDLE) == 0)
    80005f40:	00574783          	lbu	a5,5(a4) # 10000005 <_entry-0x6ffffffb>
    80005f44:	0207f793          	andi	a5,a5,32
    80005f48:	dfe5                	beqz	a5,80005f40 <uartputc_sync+0x24>
    ;
  WriteReg(THR, c);
    80005f4a:	0ff4f513          	zext.b	a0,s1
    80005f4e:	100007b7          	lui	a5,0x10000
    80005f52:	00a78023          	sb	a0,0(a5) # 10000000 <_entry-0x70000000>

  pop_off();
    80005f56:	00000097          	auipc	ra,0x0
    80005f5a:	2a6080e7          	jalr	678(ra) # 800061fc <pop_off>
}
    80005f5e:	60e2                	ld	ra,24(sp)
    80005f60:	6442                	ld	s0,16(sp)
    80005f62:	64a2                	ld	s1,8(sp)
    80005f64:	6105                	addi	sp,sp,32
    80005f66:	8082                	ret

0000000080005f68 <uartstart>:
// called from both the top- and bottom-half.
void
uartstart()
{
  while(1){
    if(uart_tx_w == uart_tx_r){
    80005f68:	00003797          	auipc	a5,0x3
    80005f6c:	0b87b783          	ld	a5,184(a5) # 80009020 <uart_tx_r>
    80005f70:	00003717          	auipc	a4,0x3
    80005f74:	0b873703          	ld	a4,184(a4) # 80009028 <uart_tx_w>
    80005f78:	06f70a63          	beq	a4,a5,80005fec <uartstart+0x84>
{
    80005f7c:	7139                	addi	sp,sp,-64
    80005f7e:	fc06                	sd	ra,56(sp)
    80005f80:	f822                	sd	s0,48(sp)
    80005f82:	f426                	sd	s1,40(sp)
    80005f84:	f04a                	sd	s2,32(sp)
    80005f86:	ec4e                	sd	s3,24(sp)
    80005f88:	e852                	sd	s4,16(sp)
    80005f8a:	e456                	sd	s5,8(sp)
    80005f8c:	0080                	addi	s0,sp,64
      // transmit buffer is empty.
      return;
    }
    
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005f8e:	10000937          	lui	s2,0x10000
      // so we cannot give it another byte.
      // it will interrupt when it's ready for a new byte.
      return;
    }
    
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005f92:	00027a17          	auipc	s4,0x27
    80005f96:	276a0a13          	addi	s4,s4,630 # 8002d208 <uart_tx_lock>
    uart_tx_r += 1;
    80005f9a:	00003497          	auipc	s1,0x3
    80005f9e:	08648493          	addi	s1,s1,134 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r){
    80005fa2:	00003997          	auipc	s3,0x3
    80005fa6:	08698993          	addi	s3,s3,134 # 80009028 <uart_tx_w>
    if((ReadReg(LSR) & LSR_TX_IDLE) == 0){
    80005faa:	00594703          	lbu	a4,5(s2) # 10000005 <_entry-0x6ffffffb>
    80005fae:	02077713          	andi	a4,a4,32
    80005fb2:	c705                	beqz	a4,80005fda <uartstart+0x72>
    int c = uart_tx_buf[uart_tx_r % UART_TX_BUF_SIZE];
    80005fb4:	01f7f713          	andi	a4,a5,31
    80005fb8:	9752                	add	a4,a4,s4
    80005fba:	01874a83          	lbu	s5,24(a4)
    uart_tx_r += 1;
    80005fbe:	0785                	addi	a5,a5,1
    80005fc0:	e09c                	sd	a5,0(s1)
    
    // maybe uartputc() is waiting for space in the buffer.
    wakeup(&uart_tx_r);
    80005fc2:	8526                	mv	a0,s1
    80005fc4:	ffffb097          	auipc	ra,0xffffb
    80005fc8:	6d0080e7          	jalr	1744(ra) # 80001694 <wakeup>
    
    WriteReg(THR, c);
    80005fcc:	01590023          	sb	s5,0(s2)
    if(uart_tx_w == uart_tx_r){
    80005fd0:	609c                	ld	a5,0(s1)
    80005fd2:	0009b703          	ld	a4,0(s3)
    80005fd6:	fcf71ae3          	bne	a4,a5,80005faa <uartstart+0x42>
  }
}
    80005fda:	70e2                	ld	ra,56(sp)
    80005fdc:	7442                	ld	s0,48(sp)
    80005fde:	74a2                	ld	s1,40(sp)
    80005fe0:	7902                	ld	s2,32(sp)
    80005fe2:	69e2                	ld	s3,24(sp)
    80005fe4:	6a42                	ld	s4,16(sp)
    80005fe6:	6aa2                	ld	s5,8(sp)
    80005fe8:	6121                	addi	sp,sp,64
    80005fea:	8082                	ret
    80005fec:	8082                	ret

0000000080005fee <uartputc>:
{
    80005fee:	7179                	addi	sp,sp,-48
    80005ff0:	f406                	sd	ra,40(sp)
    80005ff2:	f022                	sd	s0,32(sp)
    80005ff4:	ec26                	sd	s1,24(sp)
    80005ff6:	e84a                	sd	s2,16(sp)
    80005ff8:	e44e                	sd	s3,8(sp)
    80005ffa:	e052                	sd	s4,0(sp)
    80005ffc:	1800                	addi	s0,sp,48
    80005ffe:	8a2a                	mv	s4,a0
  acquire(&uart_tx_lock);
    80006000:	00027517          	auipc	a0,0x27
    80006004:	20850513          	addi	a0,a0,520 # 8002d208 <uart_tx_lock>
    80006008:	00000097          	auipc	ra,0x0
    8000600c:	1a0080e7          	jalr	416(ra) # 800061a8 <acquire>
  if(panicked){
    80006010:	00003797          	auipc	a5,0x3
    80006014:	00c7a783          	lw	a5,12(a5) # 8000901c <panicked>
    80006018:	c391                	beqz	a5,8000601c <uartputc+0x2e>
    for(;;)
    8000601a:	a001                	j	8000601a <uartputc+0x2c>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    8000601c:	00003717          	auipc	a4,0x3
    80006020:	00c73703          	ld	a4,12(a4) # 80009028 <uart_tx_w>
    80006024:	00003797          	auipc	a5,0x3
    80006028:	ffc7b783          	ld	a5,-4(a5) # 80009020 <uart_tx_r>
    8000602c:	02078793          	addi	a5,a5,32
    80006030:	02e79b63          	bne	a5,a4,80006066 <uartputc+0x78>
      sleep(&uart_tx_r, &uart_tx_lock);
    80006034:	00027997          	auipc	s3,0x27
    80006038:	1d498993          	addi	s3,s3,468 # 8002d208 <uart_tx_lock>
    8000603c:	00003497          	auipc	s1,0x3
    80006040:	fe448493          	addi	s1,s1,-28 # 80009020 <uart_tx_r>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006044:	00003917          	auipc	s2,0x3
    80006048:	fe490913          	addi	s2,s2,-28 # 80009028 <uart_tx_w>
      sleep(&uart_tx_r, &uart_tx_lock);
    8000604c:	85ce                	mv	a1,s3
    8000604e:	8526                	mv	a0,s1
    80006050:	ffffb097          	auipc	ra,0xffffb
    80006054:	4b8080e7          	jalr	1208(ra) # 80001508 <sleep>
    if(uart_tx_w == uart_tx_r + UART_TX_BUF_SIZE){
    80006058:	00093703          	ld	a4,0(s2)
    8000605c:	609c                	ld	a5,0(s1)
    8000605e:	02078793          	addi	a5,a5,32
    80006062:	fee785e3          	beq	a5,a4,8000604c <uartputc+0x5e>
      uart_tx_buf[uart_tx_w % UART_TX_BUF_SIZE] = c;
    80006066:	00027497          	auipc	s1,0x27
    8000606a:	1a248493          	addi	s1,s1,418 # 8002d208 <uart_tx_lock>
    8000606e:	01f77793          	andi	a5,a4,31
    80006072:	97a6                	add	a5,a5,s1
    80006074:	01478c23          	sb	s4,24(a5)
      uart_tx_w += 1;
    80006078:	0705                	addi	a4,a4,1
    8000607a:	00003797          	auipc	a5,0x3
    8000607e:	fae7b723          	sd	a4,-82(a5) # 80009028 <uart_tx_w>
      uartstart();
    80006082:	00000097          	auipc	ra,0x0
    80006086:	ee6080e7          	jalr	-282(ra) # 80005f68 <uartstart>
      release(&uart_tx_lock);
    8000608a:	8526                	mv	a0,s1
    8000608c:	00000097          	auipc	ra,0x0
    80006090:	1d0080e7          	jalr	464(ra) # 8000625c <release>
}
    80006094:	70a2                	ld	ra,40(sp)
    80006096:	7402                	ld	s0,32(sp)
    80006098:	64e2                	ld	s1,24(sp)
    8000609a:	6942                	ld	s2,16(sp)
    8000609c:	69a2                	ld	s3,8(sp)
    8000609e:	6a02                	ld	s4,0(sp)
    800060a0:	6145                	addi	sp,sp,48
    800060a2:	8082                	ret

00000000800060a4 <uartgetc>:

// read one input character from the UART.
// return -1 if none is waiting.
int
uartgetc(void)
{
    800060a4:	1141                	addi	sp,sp,-16
    800060a6:	e422                	sd	s0,8(sp)
    800060a8:	0800                	addi	s0,sp,16
  if(ReadReg(LSR) & 0x01){
    800060aa:	100007b7          	lui	a5,0x10000
    800060ae:	0057c783          	lbu	a5,5(a5) # 10000005 <_entry-0x6ffffffb>
    800060b2:	8b85                	andi	a5,a5,1
    800060b4:	cb81                	beqz	a5,800060c4 <uartgetc+0x20>
    // input data is ready.
    return ReadReg(RHR);
    800060b6:	100007b7          	lui	a5,0x10000
    800060ba:	0007c503          	lbu	a0,0(a5) # 10000000 <_entry-0x70000000>
  } else {
    return -1;
  }
}
    800060be:	6422                	ld	s0,8(sp)
    800060c0:	0141                	addi	sp,sp,16
    800060c2:	8082                	ret
    return -1;
    800060c4:	557d                	li	a0,-1
    800060c6:	bfe5                	j	800060be <uartgetc+0x1a>

00000000800060c8 <uartintr>:
// handle a uart interrupt, raised because input has
// arrived, or the uart is ready for more output, or
// both. called from trap.c.
void
uartintr(void)
{
    800060c8:	1101                	addi	sp,sp,-32
    800060ca:	ec06                	sd	ra,24(sp)
    800060cc:	e822                	sd	s0,16(sp)
    800060ce:	e426                	sd	s1,8(sp)
    800060d0:	1000                	addi	s0,sp,32
  // read and process incoming characters.
  while(1){
    int c = uartgetc();
    if(c == -1)
    800060d2:	54fd                	li	s1,-1
    800060d4:	a029                	j	800060de <uartintr+0x16>
      break;
    consoleintr(c);
    800060d6:	00000097          	auipc	ra,0x0
    800060da:	918080e7          	jalr	-1768(ra) # 800059ee <consoleintr>
    int c = uartgetc();
    800060de:	00000097          	auipc	ra,0x0
    800060e2:	fc6080e7          	jalr	-58(ra) # 800060a4 <uartgetc>
    if(c == -1)
    800060e6:	fe9518e3          	bne	a0,s1,800060d6 <uartintr+0xe>
  }

  // send buffered characters.
  acquire(&uart_tx_lock);
    800060ea:	00027497          	auipc	s1,0x27
    800060ee:	11e48493          	addi	s1,s1,286 # 8002d208 <uart_tx_lock>
    800060f2:	8526                	mv	a0,s1
    800060f4:	00000097          	auipc	ra,0x0
    800060f8:	0b4080e7          	jalr	180(ra) # 800061a8 <acquire>
  uartstart();
    800060fc:	00000097          	auipc	ra,0x0
    80006100:	e6c080e7          	jalr	-404(ra) # 80005f68 <uartstart>
  release(&uart_tx_lock);
    80006104:	8526                	mv	a0,s1
    80006106:	00000097          	auipc	ra,0x0
    8000610a:	156080e7          	jalr	342(ra) # 8000625c <release>
}
    8000610e:	60e2                	ld	ra,24(sp)
    80006110:	6442                	ld	s0,16(sp)
    80006112:	64a2                	ld	s1,8(sp)
    80006114:	6105                	addi	sp,sp,32
    80006116:	8082                	ret

0000000080006118 <initlock>:
#include "proc.h"
#include "defs.h"

void
initlock(struct spinlock *lk, char *name)
{
    80006118:	1141                	addi	sp,sp,-16
    8000611a:	e422                	sd	s0,8(sp)
    8000611c:	0800                	addi	s0,sp,16
  lk->name = name;
    8000611e:	e50c                	sd	a1,8(a0)
  lk->locked = 0;
    80006120:	00052023          	sw	zero,0(a0)
  lk->cpu = 0;
    80006124:	00053823          	sd	zero,16(a0)
}
    80006128:	6422                	ld	s0,8(sp)
    8000612a:	0141                	addi	sp,sp,16
    8000612c:	8082                	ret

000000008000612e <holding>:
// Interrupts must be off.
int
holding(struct spinlock *lk)
{
  int r;
  r = (lk->locked && lk->cpu == mycpu());
    8000612e:	411c                	lw	a5,0(a0)
    80006130:	e399                	bnez	a5,80006136 <holding+0x8>
    80006132:	4501                	li	a0,0
  return r;
}
    80006134:	8082                	ret
{
    80006136:	1101                	addi	sp,sp,-32
    80006138:	ec06                	sd	ra,24(sp)
    8000613a:	e822                	sd	s0,16(sp)
    8000613c:	e426                	sd	s1,8(sp)
    8000613e:	1000                	addi	s0,sp,32
  r = (lk->locked && lk->cpu == mycpu());
    80006140:	6904                	ld	s1,16(a0)
    80006142:	ffffb097          	auipc	ra,0xffffb
    80006146:	ce6080e7          	jalr	-794(ra) # 80000e28 <mycpu>
    8000614a:	40a48533          	sub	a0,s1,a0
    8000614e:	00153513          	seqz	a0,a0
}
    80006152:	60e2                	ld	ra,24(sp)
    80006154:	6442                	ld	s0,16(sp)
    80006156:	64a2                	ld	s1,8(sp)
    80006158:	6105                	addi	sp,sp,32
    8000615a:	8082                	ret

000000008000615c <push_off>:
// it takes two pop_off()s to undo two push_off()s.  Also, if interrupts
// are initially off, then push_off, pop_off leaves them off.

void
push_off(void)
{
    8000615c:	1101                	addi	sp,sp,-32
    8000615e:	ec06                	sd	ra,24(sp)
    80006160:	e822                	sd	s0,16(sp)
    80006162:	e426                	sd	s1,8(sp)
    80006164:	1000                	addi	s0,sp,32
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006166:	100024f3          	csrr	s1,sstatus
    8000616a:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() & ~SSTATUS_SIE);
    8000616e:	9bf5                	andi	a5,a5,-3
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006170:	10079073          	csrw	sstatus,a5
  int old = intr_get();

  intr_off();
  if(mycpu()->noff == 0)
    80006174:	ffffb097          	auipc	ra,0xffffb
    80006178:	cb4080e7          	jalr	-844(ra) # 80000e28 <mycpu>
    8000617c:	5d3c                	lw	a5,120(a0)
    8000617e:	cf89                	beqz	a5,80006198 <push_off+0x3c>
    mycpu()->intena = old;
  mycpu()->noff += 1;
    80006180:	ffffb097          	auipc	ra,0xffffb
    80006184:	ca8080e7          	jalr	-856(ra) # 80000e28 <mycpu>
    80006188:	5d3c                	lw	a5,120(a0)
    8000618a:	2785                	addiw	a5,a5,1
    8000618c:	dd3c                	sw	a5,120(a0)
}
    8000618e:	60e2                	ld	ra,24(sp)
    80006190:	6442                	ld	s0,16(sp)
    80006192:	64a2                	ld	s1,8(sp)
    80006194:	6105                	addi	sp,sp,32
    80006196:	8082                	ret
    mycpu()->intena = old;
    80006198:	ffffb097          	auipc	ra,0xffffb
    8000619c:	c90080e7          	jalr	-880(ra) # 80000e28 <mycpu>
  return (x & SSTATUS_SIE) != 0;
    800061a0:	8085                	srli	s1,s1,0x1
    800061a2:	8885                	andi	s1,s1,1
    800061a4:	dd64                	sw	s1,124(a0)
    800061a6:	bfe9                	j	80006180 <push_off+0x24>

00000000800061a8 <acquire>:
{
    800061a8:	1101                	addi	sp,sp,-32
    800061aa:	ec06                	sd	ra,24(sp)
    800061ac:	e822                	sd	s0,16(sp)
    800061ae:	e426                	sd	s1,8(sp)
    800061b0:	1000                	addi	s0,sp,32
    800061b2:	84aa                	mv	s1,a0
  push_off(); // disable interrupts to avoid deadlock.
    800061b4:	00000097          	auipc	ra,0x0
    800061b8:	fa8080e7          	jalr	-88(ra) # 8000615c <push_off>
  if(holding(lk))
    800061bc:	8526                	mv	a0,s1
    800061be:	00000097          	auipc	ra,0x0
    800061c2:	f70080e7          	jalr	-144(ra) # 8000612e <holding>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800061c6:	4705                	li	a4,1
  if(holding(lk))
    800061c8:	e115                	bnez	a0,800061ec <acquire+0x44>
  while(__sync_lock_test_and_set(&lk->locked, 1) != 0)
    800061ca:	87ba                	mv	a5,a4
    800061cc:	0cf4a7af          	amoswap.w.aq	a5,a5,(s1)
    800061d0:	2781                	sext.w	a5,a5
    800061d2:	ffe5                	bnez	a5,800061ca <acquire+0x22>
  __sync_synchronize();
    800061d4:	0ff0000f          	fence
  lk->cpu = mycpu();
    800061d8:	ffffb097          	auipc	ra,0xffffb
    800061dc:	c50080e7          	jalr	-944(ra) # 80000e28 <mycpu>
    800061e0:	e888                	sd	a0,16(s1)
}
    800061e2:	60e2                	ld	ra,24(sp)
    800061e4:	6442                	ld	s0,16(sp)
    800061e6:	64a2                	ld	s1,8(sp)
    800061e8:	6105                	addi	sp,sp,32
    800061ea:	8082                	ret
    panic("acquire");
    800061ec:	00002517          	auipc	a0,0x2
    800061f0:	76450513          	addi	a0,a0,1892 # 80008950 <digits+0x20>
    800061f4:	00000097          	auipc	ra,0x0
    800061f8:	a7c080e7          	jalr	-1412(ra) # 80005c70 <panic>

00000000800061fc <pop_off>:

void
pop_off(void)
{
    800061fc:	1141                	addi	sp,sp,-16
    800061fe:	e406                	sd	ra,8(sp)
    80006200:	e022                	sd	s0,0(sp)
    80006202:	0800                	addi	s0,sp,16
  struct cpu *c = mycpu();
    80006204:	ffffb097          	auipc	ra,0xffffb
    80006208:	c24080e7          	jalr	-988(ra) # 80000e28 <mycpu>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    8000620c:	100027f3          	csrr	a5,sstatus
  return (x & SSTATUS_SIE) != 0;
    80006210:	8b89                	andi	a5,a5,2
  if(intr_get())
    80006212:	e78d                	bnez	a5,8000623c <pop_off+0x40>
    panic("pop_off - interruptible");
  if(c->noff < 1)
    80006214:	5d3c                	lw	a5,120(a0)
    80006216:	02f05b63          	blez	a5,8000624c <pop_off+0x50>
    panic("pop_off");
  c->noff -= 1;
    8000621a:	37fd                	addiw	a5,a5,-1
    8000621c:	0007871b          	sext.w	a4,a5
    80006220:	dd3c                	sw	a5,120(a0)
  if(c->noff == 0 && c->intena)
    80006222:	eb09                	bnez	a4,80006234 <pop_off+0x38>
    80006224:	5d7c                	lw	a5,124(a0)
    80006226:	c799                	beqz	a5,80006234 <pop_off+0x38>
  asm volatile("csrr %0, sstatus" : "=r" (x) );
    80006228:	100027f3          	csrr	a5,sstatus
  w_sstatus(r_sstatus() | SSTATUS_SIE);
    8000622c:	0027e793          	ori	a5,a5,2
  asm volatile("csrw sstatus, %0" : : "r" (x));
    80006230:	10079073          	csrw	sstatus,a5
    intr_on();
}
    80006234:	60a2                	ld	ra,8(sp)
    80006236:	6402                	ld	s0,0(sp)
    80006238:	0141                	addi	sp,sp,16
    8000623a:	8082                	ret
    panic("pop_off - interruptible");
    8000623c:	00002517          	auipc	a0,0x2
    80006240:	71c50513          	addi	a0,a0,1820 # 80008958 <digits+0x28>
    80006244:	00000097          	auipc	ra,0x0
    80006248:	a2c080e7          	jalr	-1492(ra) # 80005c70 <panic>
    panic("pop_off");
    8000624c:	00002517          	auipc	a0,0x2
    80006250:	72450513          	addi	a0,a0,1828 # 80008970 <digits+0x40>
    80006254:	00000097          	auipc	ra,0x0
    80006258:	a1c080e7          	jalr	-1508(ra) # 80005c70 <panic>

000000008000625c <release>:
{
    8000625c:	1101                	addi	sp,sp,-32
    8000625e:	ec06                	sd	ra,24(sp)
    80006260:	e822                	sd	s0,16(sp)
    80006262:	e426                	sd	s1,8(sp)
    80006264:	1000                	addi	s0,sp,32
    80006266:	84aa                	mv	s1,a0
  if(!holding(lk))
    80006268:	00000097          	auipc	ra,0x0
    8000626c:	ec6080e7          	jalr	-314(ra) # 8000612e <holding>
    80006270:	c115                	beqz	a0,80006294 <release+0x38>
  lk->cpu = 0;
    80006272:	0004b823          	sd	zero,16(s1)
  __sync_synchronize();
    80006276:	0ff0000f          	fence
  __sync_lock_release(&lk->locked);
    8000627a:	0f50000f          	fence	iorw,ow
    8000627e:	0804a02f          	amoswap.w	zero,zero,(s1)
  pop_off();
    80006282:	00000097          	auipc	ra,0x0
    80006286:	f7a080e7          	jalr	-134(ra) # 800061fc <pop_off>
}
    8000628a:	60e2                	ld	ra,24(sp)
    8000628c:	6442                	ld	s0,16(sp)
    8000628e:	64a2                	ld	s1,8(sp)
    80006290:	6105                	addi	sp,sp,32
    80006292:	8082                	ret
    panic("release");
    80006294:	00002517          	auipc	a0,0x2
    80006298:	6e450513          	addi	a0,a0,1764 # 80008978 <digits+0x48>
    8000629c:	00000097          	auipc	ra,0x0
    800062a0:	9d4080e7          	jalr	-1580(ra) # 80005c70 <panic>
	...

0000000080007000 <_trampoline>:
    80007000:	14051573          	csrrw	a0,sscratch,a0
    80007004:	02153423          	sd	ra,40(a0)
    80007008:	02253823          	sd	sp,48(a0)
    8000700c:	02353c23          	sd	gp,56(a0)
    80007010:	04453023          	sd	tp,64(a0)
    80007014:	04553423          	sd	t0,72(a0)
    80007018:	04653823          	sd	t1,80(a0)
    8000701c:	04753c23          	sd	t2,88(a0)
    80007020:	f120                	sd	s0,96(a0)
    80007022:	f524                	sd	s1,104(a0)
    80007024:	fd2c                	sd	a1,120(a0)
    80007026:	e150                	sd	a2,128(a0)
    80007028:	e554                	sd	a3,136(a0)
    8000702a:	e958                	sd	a4,144(a0)
    8000702c:	ed5c                	sd	a5,152(a0)
    8000702e:	0b053023          	sd	a6,160(a0)
    80007032:	0b153423          	sd	a7,168(a0)
    80007036:	0b253823          	sd	s2,176(a0)
    8000703a:	0b353c23          	sd	s3,184(a0)
    8000703e:	0d453023          	sd	s4,192(a0)
    80007042:	0d553423          	sd	s5,200(a0)
    80007046:	0d653823          	sd	s6,208(a0)
    8000704a:	0d753c23          	sd	s7,216(a0)
    8000704e:	0f853023          	sd	s8,224(a0)
    80007052:	0f953423          	sd	s9,232(a0)
    80007056:	0fa53823          	sd	s10,240(a0)
    8000705a:	0fb53c23          	sd	s11,248(a0)
    8000705e:	11c53023          	sd	t3,256(a0)
    80007062:	11d53423          	sd	t4,264(a0)
    80007066:	11e53823          	sd	t5,272(a0)
    8000706a:	11f53c23          	sd	t6,280(a0)
    8000706e:	140022f3          	csrr	t0,sscratch
    80007072:	06553823          	sd	t0,112(a0)
    80007076:	00853103          	ld	sp,8(a0)
    8000707a:	02053203          	ld	tp,32(a0)
    8000707e:	01053283          	ld	t0,16(a0)
    80007082:	00053303          	ld	t1,0(a0)
    80007086:	18031073          	csrw	satp,t1
    8000708a:	12000073          	sfence.vma
    8000708e:	8282                	jr	t0

0000000080007090 <userret>:
    80007090:	18059073          	csrw	satp,a1
    80007094:	12000073          	sfence.vma
    80007098:	07053283          	ld	t0,112(a0)
    8000709c:	14029073          	csrw	sscratch,t0
    800070a0:	02853083          	ld	ra,40(a0)
    800070a4:	03053103          	ld	sp,48(a0)
    800070a8:	03853183          	ld	gp,56(a0)
    800070ac:	04053203          	ld	tp,64(a0)
    800070b0:	04853283          	ld	t0,72(a0)
    800070b4:	05053303          	ld	t1,80(a0)
    800070b8:	05853383          	ld	t2,88(a0)
    800070bc:	7120                	ld	s0,96(a0)
    800070be:	7524                	ld	s1,104(a0)
    800070c0:	7d2c                	ld	a1,120(a0)
    800070c2:	6150                	ld	a2,128(a0)
    800070c4:	6554                	ld	a3,136(a0)
    800070c6:	6958                	ld	a4,144(a0)
    800070c8:	6d5c                	ld	a5,152(a0)
    800070ca:	0a053803          	ld	a6,160(a0)
    800070ce:	0a853883          	ld	a7,168(a0)
    800070d2:	0b053903          	ld	s2,176(a0)
    800070d6:	0b853983          	ld	s3,184(a0)
    800070da:	0c053a03          	ld	s4,192(a0)
    800070de:	0c853a83          	ld	s5,200(a0)
    800070e2:	0d053b03          	ld	s6,208(a0)
    800070e6:	0d853b83          	ld	s7,216(a0)
    800070ea:	0e053c03          	ld	s8,224(a0)
    800070ee:	0e853c83          	ld	s9,232(a0)
    800070f2:	0f053d03          	ld	s10,240(a0)
    800070f6:	0f853d83          	ld	s11,248(a0)
    800070fa:	10053e03          	ld	t3,256(a0)
    800070fe:	10853e83          	ld	t4,264(a0)
    80007102:	11053f03          	ld	t5,272(a0)
    80007106:	11853f83          	ld	t6,280(a0)
    8000710a:	14051573          	csrrw	a0,sscratch,a0
    8000710e:	10200073          	sret
	...
