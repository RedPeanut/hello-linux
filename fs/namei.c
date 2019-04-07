/*
 * In order to reduce some races, while at the same time doing additional
 * checking and hopefully speeding things up, we copy filenames to the
 * kernel data space before using them..
 *
 * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
 */
/*
 * user영역에 있을때 몇가지 체크루틴들을 타기 때문에 약간의 속도 개선을
 * 위해서, filename을 kernel 데이터 영역으로 옮긴다.
 * 
 * POSIX 1.2.4: pathname이 없는 경우는 무효처리(ENOENT)
 */

int getname(const char * filename, char **result) {
    
}
