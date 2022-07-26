# Makefile: A standard Makefile for senevent.c

all  : senevent
clean:
	/bin/rm -rf senevent senevent.o

tmp.out:
	./senevent tmp.in tmp.out

onoff-screen:
	adb shell input keyevent 26
swipe:
	adb push tmp.out /mnt/sdcard/
	adb shell "cd /mnt/sdcard/ && cat tmp.out > /dev/input/event1"

open: onoff-screen swipe

# END OF FILE
