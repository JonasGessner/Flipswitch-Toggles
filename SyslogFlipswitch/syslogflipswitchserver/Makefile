ARCHS = armv7 armv7s arm64

TARGET = iphone:clang:latest:5.0

THEOS_BUILD_DIR = Packages

include theos/makefiles/common.mk

TOOL_NAME = SyslogFlipswitchServer
SyslogFlipswitchServer_CFLAGS = -fobjc-arc
SyslogFlipswitchServer_FILES = main.m

include $(THEOS_MAKE_PATH)/tool.mk

after-SyslogFlipswitchServer-stage::
	$(ECHO_NOTHING)$(FAKEROOT) chown root:wheel $(THEOS_STAGING_DIR)/Library/LaunchDaemons/de.j-gessner.syslogflipswitchxpc.plist$(ECHO_END)
