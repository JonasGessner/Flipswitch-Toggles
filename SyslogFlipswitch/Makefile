ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:5.0

THEOS_BUILD_DIR = Packages

FINALPACKAGE = 1

include theos/makefiles/common.mk

BUNDLE_NAME = SyslogFlipswitch
SyslogFlipswitch_CFLAGS = -fobjc-arc
SyslogFlipswitch_FILES = SyslogFlipswitchSwitch.x
SyslogFlipswitch_FRAMEWORKS = Foundation UIKit
SyslogFlipswitch_LDFLAGS = -weak_library libflipswitch.dylib
SyslogFlipswitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk

SUBPROJECTS += syslogflipswitchserver
include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	install.exec "rm -rf /tmp/FlipswitchCache; killall -9 backboardd"

