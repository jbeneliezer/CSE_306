#include "types.h"
#include "defs.h"
#include "param.h"
#include "memlayout.h"
#include "mmu.h"
#include "proc.h"
#include "x86.h"
#include "traps.h"
#include "spinlock.h"

#define tickrate 10 // tick rate in ms

// Interrupt descriptor table (shared by all CPUs).
struct gatedesc idt[256];
extern uint vectors[];  // in vectors.S: array of 256 entry pointers
struct spinlock tickslock;
uint ticks;

void
tvinit(void)
{
  int i;

  for(i = 0; i < 256; i++)
    SETGATE(idt[i], 0, SEG_KCODE<<3, vectors[i], 0);
  SETGATE(idt[T_SYSCALL], 1, SEG_KCODE<<3, vectors[T_SYSCALL], DPL_USER);

  initlock(&tickslock, "time");
}

void
idtinit(void)
{
  lidt(idt, sizeof(idt));
}

//PAGEBREAK: 41
void
trap(struct trapframe *tf)
{
  if(tf->trapno == T_SYSCALL){
    if(myproc()->killed)
      exit();
    myproc()->tf = tf;
    syscall();
    if(myproc()->killed)
      exit();
    return;
  }

  switch(tf->trapno){
  case T_IRQ0 + IRQ_TIMER:
    if(cpuid() == 0){
      acquire(&tickslock);
      ticks++;
      wakeup(&ticks);
      release(&tickslock);
      struct proc *p;
      struct cpu *c;
      p->pt_cpu++;
      acquire(&ptable.lock);
      int i = 0;
      for (p = ptable.proc; p < &ptable.proc[NPROC]; p++)
      {
        p->pt_real++;
        if (p->ticks <= 0 && p->state == SLEEPING) wakeup1(&p->chan);
        p->ticks--;
        if (p->state == RUNNABLE) p->pt_wait++;
        i++;
      }
      double p_value = -(log(1/10))/((30 * 1000)/tickrate);
      c->load_avg = p_value * i + (1 - p_value) * c->load_avg;
      release(&ptable.lock);
    }
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE:
    ideintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_IDE+1:
    // Bochs generates spurious IDE1 interrupts.
    break;
  case T_IRQ0 + IRQ_KBD:
    kbdintr();
    lapiceoi();
    break;
  case T_IRQ0 + IRQ_COM1:
    uartintr();
    lapiceoi();
    break;
  case T_IRQ0 + 7:
  case T_IRQ0 + IRQ_MOUSE:
    mouseintr();
    break;
  case T_IRQ0 + IRQ_SPURIOUS:
  case T_IRQ0 + IRQ_SPURIOUS1:
    cprintf("cpu%d: spurious interrupt (%d) at %x:%x\n",
            cpuid(), tf->trapno, tf->cs, tf->eip);
    lapiceoi();
    break;

  //PAGEBREAK: 13
  default:
    if(myproc() == 0 || (tf->cs&3) == 0){
      // In kernel, it must be our mistake.
      cprintf("unexpected trap %d from cpu %d eip %x (cr2=0x%x)\n",
              tf->trapno, cpuid(), tf->eip, rcr2());
      //panic("trap");
      return;
    }
    // In user space, assume process misbehaved.
    cprintf("pid %d %s: trap %d err %d on cpu %d "
            "eip 0x%x addr 0x%x--kill proc\n",
            myproc()->pid, myproc()->name, tf->trapno,
            tf->err, cpuid(), tf->eip, rcr2());
    myproc()->killed = 1;
  }

  // Force process exit if it has been killed and is in user space.
  // (If it is still executing in the kernel, let it keep running
  // until it gets to the regular system call return.)
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // Invoke the scheduler on clock tick.
  if(tf->trapno == T_IRQ0+IRQ_TIMER)
    reschedule();

  // Check if the process has been killed since we yielded
  if(myproc() && myproc()->killed && (tf->cs&3) == DPL_USER)
    exit();

  // struct proc *p = myproc();
  // struct signal *s;

  // for (s = p->sigs; s <= p->sigptr; ++s)
  // {
  //   if (s->n == 0)
  //   {
  //     p->killed = 1;
  //   }
  //   else if (s->n == p->mask.n)
  //   {
  //     continue;
  //   }
  //   else
  //   {
  //     // tf->esp -= sizeof(p->tf);
  //     // memmove((void*) tf->esp, &(p->tf), sizeof(p->tf));
  //     // tf->esp -= sizeof(s->n);
  //     // memmove((void*)tf->esp, &(s->n), sizeof(s->n));
  //     s->handler(s->n);
  //   }
  // }
}