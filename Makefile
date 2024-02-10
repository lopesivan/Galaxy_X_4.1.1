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

unlock:
	adb push tmp2.out /mnt/sdcard/
	adb shell "cd /mnt/sdcard/ && cat tmp2.out > /dev/input/event1"

open: onoff-screen swipe

senha:
	adb shell input text a2244
	adb shell input keyevent 66

foto:
	adb shell "am start com.google.android.gallery3d/com.android.camera.Camera"
	adb shell "input keyevent KEYCODE_FOCUS"
	adb shell "input keyevent KEYCODE_CAMERA"
	adb shell am force-stop com.google.android.gallery3d
	adb pull /storage/sdcard0/DCIM/Camera/$$(adb shell ls  /storage/sdcard0/DCIM/Camera/| grep 2024| tr -d '\15') .
	adb shell rm /storage/sdcard0/DCIM/Camera/$$(adb shell ls  /storage/sdcard0/DCIM/Camera/| grep 2024| tr -d '\15')

#pego as informações sobre o aplicativo da camera:
# adb -d shell "am start -a android.media.action.IMAGE_CAPTURE" -W
# Abro a camera
# adb shell "am start com.google.android.gallery3d/com.android.camera.Camera"

# abro a camera sem poder tirar foto
# adb shell "am start -a android.media.action.IMAGE_CAPTURE"

# aplica foco
# adb shell "input keyevent KEYCODE_FOCUS"

# bato a foto
# adb shell "input keyevent KEYCODE_CAMERA"

#fecha app
# adb shell am force-stop com.google.android.gallery3d
# END OF FILE
