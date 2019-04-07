#ifndef _FLOWER_MATH_EMU_H
#define _FLOWER_MATH_EMU_H

struct fpu_reg {
    char sign;
    char tag;
    long exp;
    unsigned sigl;
    unsigned sigh;
};

#endif // 
