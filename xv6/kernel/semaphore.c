#include "types.h"
#include "defs.h"
#include "spinlock.h"
#include "semaphore.h"

void sem_init(struct semaphore *sp, int val)
{
    acquire(&sp->lock);
    sp->value = val;
    release(&sp->lock);
}

void sem_P(struct semaphore *sp)
{
    acquire(&sp->lock);
    while (sp->value <= 0) sleep(sp, &sp->lock);
    --sp->value;
    release(&sp->lock);
}

void sem_V(struct semaphore *sp)
{
    acquire(&sp->lock);
    ++sp->value;
    wakeup(sp);
    release(&sp->lock);
}