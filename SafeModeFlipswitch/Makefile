ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:5.0

THEOS_BUILD_DIR = Packages

FINALPACKAGE = 1

include theos/makefiles/common.mk

BUNDLE_NAME = SafeModeFlipswitch
SafeModeFlipswitch_CFLAGS = -fno-objc-arc
SafeModeFlipswitch_FILES = SafeModeFlipswitchSwitch.x
SafeModeFlipswitch_FRAMEWORKS = Foundation UIKit
SafeModeFlipswitch_LDFLAGS = -weak_library libflipswitch.dylib
SafeModeFlipswitch_INSTALL_PATH = /Library/Switches

include $(THEOS_MAKE_PATH)/bundle.mk

after-install::
	install.exec "rm -rf /tmp/FlipswitchCache"
	install.exec "killall -9 backboardd"
