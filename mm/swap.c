#include <linus/mm.h>

/*
 * This is one ugly macro, but it simplifies checking, and makes
 * this speed-critical place reasonably fast, especially as we have
 * to do things with the interrupt flag etc.
 *
 * Note that this #define is heavily optimized to give fast code
 * for the normal case - the if-statements are ordered so that gcc-2.2.2
 * will make *no* jumps for the normal code. Don't touch unless you
 * know what you are doing.
 */
/*
 *  
 *
 * �ָ� �� macro�� �ӵ��� ���� ������ ����ȭ �Ǿ���
 * 
 * 
 */
#define REMOVE_FROM_MEM_QUEUE(queue,nr) \
         cli(); \
         if ((result = queue) != 0) { \
             if (!(result & ~PAGE_MASK) && result < high_memory) { \
                 queue = *(unsigned long *) result; \
                 if (!mem_map[MAP_NR(result)]) { \
                     mem_map[MAP_NR(result)] = 1; \
                     nr--; \
     last_free_pages[index = (index + 1) & (NR_LAST_FREE_PAGES - 1)] = result; \
                     restore_flags(flag); \
                     return result; \
                 } \
                 printk("Free page %08lx has mem_map = %d\n", \
                     result,mem_map[MAP_NR(result)]); \
             } else \
                 printk("Result = 0x%08lx - memory map destroyed\n", result); \
             queue = 0; \
             nr = 0; \
         } else if (nr) { \
             printk(#nr " is %d, but " #queue " is empty\n",nr); \
             nr = 0; \
         } \
         restore_flags(flag)

/*
 * Get physical address of first (actually last :-) free page, and mark it
 * used. If no free pages left, return 0.
 *
 * Note that this is one of the most heavily called functions in the kernel,
 * so it's a bit timing-critical (especially as we have to disable interrupts
 * in it). See the above macro which does most of the work, and which is
 * optimized for a fast normal path of execution.
 */
/*
 * ù��° free page ���� �ּ� ��������, �������� �������� ǥ��.
 * ������ free page�� ������, return 0.
 *
 * kernel���� ���� ���� ȣ�� �Ǵ� �Լ��� �ϳ��⶧����, timing-critical.
 * 
 *
 *
 */
unsigned long __get_free_page(int priority) {
    extern unsigned long intr_count;
    unsigned long result;

    
    return 0;
}
