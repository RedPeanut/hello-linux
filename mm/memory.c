#include <linus/types.h>

#define NR_PAGE 2

typedef struct _PAGE_MANAGE_STRUCT {
    ULONG list[NR_PAGE];
    INT nr_entry[NR_PAGE];
} PAGE_MANAGE_STRUCT, *PPAGE_MANAGE_STRUCT;

PAGE_MANAGE_STRUCT page_manage_struct;

