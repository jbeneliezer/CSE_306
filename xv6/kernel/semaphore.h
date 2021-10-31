
struct semaphore{
    int value;
    struct spinlock lock;
};