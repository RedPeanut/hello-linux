#ifndef KERNEL_H_
#define KERNEL_H_

#define KERN_EMERG "<0>" /* system is unusable */
#define KERN_ALERT "<1>" /* action must be taken immediately */

#define NORET_TYPE /**/

NORET_TYPE void panic(const char* fmt, ...);

#endif /* KERNEL_H_ */
