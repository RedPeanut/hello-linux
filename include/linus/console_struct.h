#ifndef CONSOLE_STRUCT_H_
#define CONSOLE_STRUCT_H_

typedef struct VIRTUAL_CONSOLE_DATA {
    unsigned short     num;                /* Console number */
    unsigned int       cols;               /* [#] Console size */
    unsigned int       rows;
    unsigned int       size_row;           /* Bytes per row */
    const struct CONSOLE_SWITCH *sw;
    unsigned short     *screenbuf;         /* In-memory character/attribute buffer */
    unsigned int       screenbuf_size;
    unsigned char      attr;               /* Current attributes */
    unsigned char      def_color;          /* Default colors */
    unsigned char      color;              /* Foreground & background */
    unsigned char      s_color;            /* Saved foreground & background */
    unsigned char      ulcolor;            /* Color for underline mode */
    unsigned char      halfcolor;          /* Color for half intensity mode */
    unsigned short     complement_mask;    /* [#] Xor mask for mouse pointer */
    unsigned short     hi_font_mask;       /* [#] Attribute set for upper 256 chars of font or 0 if not supported */
    unsigned short     video_erase_char;   /* Background erase character */
    unsigned short     s_complement_mask;  /* Saved mouse pointer mask */
    unsigned int       x, y;            /* Cursor position */
    unsigned int       top, bottom;     /* Scrolling region */
    unsigned int       state;              /* Escape sequence parser state */
    //unsigned int       npar,par[NPAR];  /* Parameters of current escape sequence */
    unsigned long      origin;             /* [!] Start of real screen */
    unsigned long      scr_end;            /* [!] End of real screen */
    unsigned long      visible_origin;     /* [!] Top of visible window */
    unsigned long      pos;                /* Cursor address */
    unsigned int       saved_x;
    unsigned int       saved_y;
    /* mode flags */
    unsigned int       charset      : 1;   /* Character set G0 / G1 */
    unsigned int       s_charset    : 1;   /* Saved character set */
    unsigned int       disp_ctrl    : 1;   /* Display chars < 32? */
    unsigned int       toggle_meta  : 1;   /* Toggle high bit? */
    unsigned int       decscnm      : 1;   /* Screen Mode */
    unsigned int       decom        : 1;   /* Origin Mode */
    unsigned int       decawm       : 1;   /* Autowrap Mode */
    unsigned int       deccm        : 1;   /* Cursor Visible */
    unsigned int       decim        : 1;   /* Insert Mode */
    unsigned int       deccolm      : 1;   /* 80/132 Column Mode */
    /* attribute flags */
    unsigned int       intensity    : 2;   /* 0=half-bright, 1=normal, 2=bold */
    unsigned int       underline    : 1;
    unsigned int       blink        : 1;
    unsigned int       reverse      : 1;
    unsigned int       s_intensity  : 2;   /* saved rendition */
    unsigned int       s_underline  : 1;
    unsigned int       s_blink      : 1;
    unsigned int       s_reverse    : 1;
    /* misc */
    unsigned int       ques         : 1;
    unsigned int       need_wrap    : 1;
    unsigned int       can_do_color : 1;
    unsigned int       report_mouse : 2;
    unsigned int       kmalloced    : 1;
    unsigned char      utf          : 1;    /* Unicode UTF-8 encoding */
    unsigned char      utf_count;
    int                utf_char;
    unsigned int       tab_stop[5];     /* Tab stops. 160 columns. */
    unsigned char      palette[16*3];       /* Colour palette for VGA+ */
    unsigned short     *translate;
    unsigned char      G0_charset;
    unsigned char      G1_charset;
    unsigned char      saved_G0;
    unsigned char      saved_G1;
    unsigned int       bell_pitch;      /* Console bell pitch */
    unsigned int       bell_duration;   /* Console bell duration */
    unsigned int       cursor_type;
    struct VIRTUAL_CONSOLE_DATA **display_fg;     /* [!] Ptr to var holding fg console for this display */
    unsigned long      uni_pagedir;
    unsigned long      *uni_pagedir_loc;  /* [!] Location of uni_pagedir variable for this console */
} VIRTUAL_CONSOLE_DATA, *PVIRTUAL_CONSOLE_DATA;

typedef struct _VIRTUAL_CONSOLE {
    VIRTUAL_CONSOLE_DATA d;
    /*
     * might add screen memory,
     * to have everything in one place -
     */
} VIRTUAL_CONSOLE;

#endif /* CONSOLE_STRUCT_H_ */
