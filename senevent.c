#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <unistd.h>
#include <errno.h>

typedef uint32_t        __u32;
typedef uint16_t        __u16;
typedef __signed__ int  __s32;

__attribute__ ((aligned (1),packed)) struct input_event
{
    __u32 time_dummy_1;
    __u32 time_dummy_2;
    __u16 type;
    __u16 code;
    __s32 value;
};

int convert (char * str)
{
    return (int) strtol (str, NULL, 16);
}

#define S_ALL (S_IRUSR | S_IWUSR | S_IXUSR | S_IRGRP | S_IWGRP | S_IXGRP | S_IROTH | S_IWOTH | S_IXOTH)

int main (int argc, char *argv[])
{
    int i;
    int fd;
    int ret;

    if (argc < 3)
    {
        fprintf (stderr, "use: %s in-file out-file\n", argv[0]);
        return 1;
    }

    fd = open (argv[2], O_CREAT | O_WRONLY, S_ALL);
    if (fd < 0)
    {
        fprintf (stderr, "could not open %s, %s\n", argv[2], strerror (errno));
        return 1;
    }

    FILE * fd_in = fopen (argv[1], "r");
    if (fd_in == NULL)
    {
        fprintf (stderr, "Can't open input file: %s\n", argv[1]);
        return 1;
    }

    struct input_event event;
    char type[32];
    char code[32];
    char value[32];
    int count = 0;
    while (fscanf (fd_in, "%s %s %s", type, code, value) != EOF)
    {
        memset (&event, 0, sizeof (event));
        // printf("%d) %s %s %s\n", ++count, type, code, value);
        event.type = convert (type);
        event.code = convert (code);
        event.value = convert (value);
        memset (type, 0, sizeof (type));
        memset (code, 0, sizeof (code));
        memset (value, 0, sizeof (value));
        ret = write (fd, &event, sizeof (event));
        if (ret < sizeof (event))
        {
            fprintf (stderr, "write event failed, %s\n", strerror (errno));
            return -1;
        }
    }

    return 0;
}
