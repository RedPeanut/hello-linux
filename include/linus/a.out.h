#ifndef _A_OUT_H
#define _A_OUT_H

struct exec {
    unsigned long a_info;		/* Use macros N_MAGIC, etc for access */
    unsigned a_text;		/* length of text, in bytes */
    unsigned a_data;		/* length of data, in bytes */
    unsigned a_bss;		/* length of uninitialized data area for file, in bytes */
    unsigned a_syms;		/* length of symbol table data in file, in bytes */
    unsigned a_entry;		/* start address */
    unsigned a_trsize;		/* length of relocation info for text, in bytes */
    unsigned a_drsize;		/* length of relocation info for data, in bytes */
};

#if !defined (N_MAGIC)
#define N_MAGIC(exec) ((exec).a_info & 0xffff)
#endif

/* Code indicating object file or impure executable.  */
#define OMAGIC 0407
/* Code indicating pure executable.  */
#define NMAGIC 0410
/* Code indicating demand-paged executable.  */
#define ZMAGIC 0413
/* This indicates a demand-paged executable with the header in the text. 
   The first page is unmapped to help trap NULL pointer references */
#define QMAGIC 0314

/* Code indicating core file.  */
#define CMAGIC 0421

#define _N_HDROFF(x) (1024 - sizeof (struct exec))

#if !defined (N_TXTOFF)
#define N_TXTOFF(x) \
 (N_MAGIC(x) == ZMAGIC ? _N_HDROFF((x)) + sizeof (struct exec) : \
  (N_MAGIC(x) == QMAGIC ? 0 : sizeof (struct exec)))
#endif

#if !defined (N_DATOFF)
#define N_DATOFF(x) (N_TXTOFF(x) + (x).a_text)
#endif

#if !defined (N_TRELOFF)
#define N_TRELOFF(x) (N_DATOFF(x) + (x).a_data)
#endif

#if !defined (N_DRELOFF)
#define N_DRELOFF(x) (N_TRELOFF(x) + (x).a_trsize)
#endif

#if !defined (N_SYMOFF)
#define N_SYMOFF(x) (N_DRELOFF(x) + (x).a_drsize)
#endif

#endif
