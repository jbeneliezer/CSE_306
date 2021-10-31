// Per-CPU state
struct cpu
{
  uchar apicid;              // Local APIC ID
  struct context *scheduler; // Context used by scheduler and idle loop
  struct taskstate ts;       // Used by x86 to find stack for interrupt
  struct segdesc gdt[NSEGS]; // x86 global descriptor table
  volatile uint started;     // Has the CPU started?
  int ncli;                  // Depth of pushcli nesting.
  int intena;                // Were interrupts enabled before pushcli?
  struct proc *proc;         // The process running on this cpu or null
  double load_avg;           // average 
};

extern struct cpu cpus[NCPU];
extern int ncpu;

// Process table

struct
{
  struct spinlock lock;
  struct proc proc[NPROC];
} ptable;

// Signals

#define NSIGS 16

struct signal
{
  uint n;
  void (*handler)(int);
};

// Timing

struct ptimes {
	int pt_real;   // Ticks since process creation
	int pt_cpu;    // Ticks of CPU time consumed
	int pt_wait;   // Ticks spent waiting for CPU
	int pt_sleep;  // Ticks spent sleeping
};

//PAGEBREAK: 17
// Saved registers for kernel context switches.
// Don't need to save all the segment registers (%cs, etc),
// because they are constant across kernel contexts.
// Don't need to save %eax, %ecx, %edx, because the
// x86 convention is that the caller has saved them.
// Contexts are stored at the bottom of the stack they
// describe; the stack pointer is the address of the context.
// The layout of the context matches the layout of the stack in swtch.S
// at the "Switch stacks" comment. Switch doesn't save eip explicitly,
// but it is on the stack and allocproc() manipulates it.
struct context
{
  uint edi;
  uint esi;
  uint ebx;
  uint ebp;
  uint eip;
};

enum procstate
{
  UNUSED,
  EMBRYO,
  SLEEPING,
  RUNNABLE,
  RUNNING,
  ZOMBIE
};

// Per-process state
struct proc
{
  uint sz;                    // Size of process memory (bytes)
  pde_t *pgdir;               // Page table
  char *kstack;               // Bottom of kernel stack for this process
  enum procstate state;       // Process state
  int pid;                    // Process ID
  struct proc *parent;        // Parent process
  struct trapframe *tf;       // Trap frame for current syscall
  struct context *context;    // swtch() here to run process
  void *chan;                 // If non-zero, sleeping on chan
  int killed;                 // If non-zero, have been killed
  struct file *ofile[NOFILE]; // Open files
  struct inode *cwd;          // Current directory
  char name[16];              // Process name (debugging)
  struct signal sigs[NSIGS];  // signals
  struct signal *sigptr;      // signal pointer
  struct signal mask;         // masked signal
  int pt_real;                // Ticks since process creation
  int pt_cpu;                 // Ticks of CPU time consumed
	int pt_wait;                // Ticks spent waiting for CPU
	int pt_sleep;               // Ticks spent sleeping
  struct rtcdate *bedtime;    // Records when process sleeps
  int ticks;                  // expected time
};

// Process memory is laid out contiguously, low addresses first:
//   text
//   original data and bss
//   fixed-size stack
//   expandable heap

