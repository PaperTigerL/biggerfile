struct file {
  enum { FD_NONE, FD_PIPE, FD_INODE, FD_DEVICE } type;
  int ref; // reference count
  char readable;
  char writable;
  struct pipe *pipe; // FD_PIPE
  struct inode *ip;  // FD_INODE and FD_DEVICE
  uint off;          // FD_INODE
  short major;       // FD_DEVICE
};

#define major(dev)  ((dev) >> 16 & 0xFFFF)
#define minor(dev)  ((dev) & 0xFFFF)
#define	mkdev(m,n)  ((uint)((m)<<16| (n)))

// in-memory copy of an inode
// 修改后的inode结构体，以支持更大文件大小
struct inode {
  uint dev;           // 设备号
  uint inum;          // inode号
  int ref;            // 引用计数
  struct sleeplock lock; // 保护以下字段的锁
  int valid;          // inode已从磁盘读取？

  short type;         // 磁盘inode的副本
  short major;
  short minor;
  short nlink;
  uint size;
  // 修改索引数组，减少一个直接索引，增加一个二级间接索引
  uint addrs[NDIRECT-1];    // 直接索引项，现在是11个而不是原来的12个
  uint indirect1[1];       // 一级间接索引，保持不变
  uint indirect2[NINDIRECT]; // 新增的二级间接索引，NINDIRECT定义为256
};

// map major device number to device functions.
struct devsw {
  int (*read)(int, uint64, int);
  int (*write)(int, uint64, int);
};

extern struct devsw devsw[];

#define CONSOLE 1
