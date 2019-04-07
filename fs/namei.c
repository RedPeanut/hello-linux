/*
 * In order to reduce some races, while at the same time doing additional
 * checking and hopefully speeding things up, we copy filenames to the
 * kernel data space before using them..
 *
 * POSIX.1 2.4: an empty pathname is invalid (ENOENT).
 */
/*
 * user������ ������ ��� üũ��ƾ���� Ÿ�� ������ �ణ�� �ӵ� ������
 * ���ؼ�, filename�� kernel ������ �������� �ű��.
 * 
 * POSIX 1.2.4: pathname�� ���� ���� ��ȿó��(ENOENT)
 */

int getname(const char * filename, char **result) {
    
}
