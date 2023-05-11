ROOTLESS ?= 0

ARCHS = arm64 arm64e
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = SpringBoard
TARGET = iphone:clang:16.4:14.5
PACKAGE_VERSION = 2.1.0

# Rootless / Rootful settings
ifeq ($(ROOTLESS),1)
	export THEOS_PACKAGE_SCHEME=rootless
	# Control
	PKG_NAME_SUFFIX = (Rootless)
endif

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PocketTranslator

PocketTranslator_PRIVATE_FRAMEWORKS = SpringBoard SpringBoardFoundation
PocketTranslator_FILES = $(shell find Sources/PocketTranslator -name '*.swift') $(shell find Sources/PocketTranslatorC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
PocketTranslator_SWIFTFLAGS = -ISources/PocketTranslatorC/include
PocketTranslator_CFLAGS = -fobjc-arc -ISources/PocketTranslatorC/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += pockettranslator
include $(THEOS_MAKE_PATH)/aggregate.mk

before-package::
	# Append values to control file
	$(ECHO_NOTHING)sed -i '' \
		-e 's/\$${PKG_NAME_SUFFIX}/$(PKG_NAME_SUFFIX)/g' \
		$(THEOS_STAGING_DIR)/DEBIAN/control$(ECHO_END)
