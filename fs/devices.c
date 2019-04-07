#include <linus/fs.h>
#include <linus/major.h>
#include <linus/string.h>
#include <linus/errno.h>

struct DeviceStruct {
    const char* name;
    struct FileOperations* fops;
};

static struct DeviceStruct m_ChrDevs[MAX_CHRDEV];

int DevRegisterChrDev(unsigned int major, const char* name, struct FileOperations *fops) {
    if(major == 0) {
        for(major = MAX_CHRDEV-1; major > 0; major--) {
            if(m_ChrDevs[major].fops == NULL) {
                m_ChrDevs[major].name = name;
                m_ChrDevs[major].fops = fops;
            }
        }
    }
    if(major >= MAX_CHRDEV)
        return -EINVAL;
    if(m_ChrDevs[major].fops && m_ChrDevs[major].fops != fops)
        return -EBUSY;
    m_ChrDevs[major].name = name;
    m_ChrDevs[major].fops = fops;
    return 0;
}
