ARCHS = arm64 arm64e
THEOS_DEVICE_IP = localhost -p 2222
INSTALL_TARGET_PROCESSES = SpringBoard
TARGET = iphone:clang:15.2:14.5
PACKAGE_VERSION = 2.0.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PocketTranslator

PocketTranslator_PRIVATE_FRAMEWORKS = SpringBoard SpringBoardFoundation
PocketTranslator_FILES = $(shell find Sources/PocketTranslator -name '*.swift') $(shell find Sources/PocketTranslatorC -name '*.m' -o -name '*.c' -o -name '*.mm' -o -name '*.cpp')
PocketTranslator_SWIFTFLAGS = -ISources/PocketTranslatorC/include
PocketTranslator_CFLAGS = -fobjc-arc -ISources/PocketTranslatorC/include

include $(THEOS_MAKE_PATH)/tweak.mk
SUBPROJECTS += pockettranslator
include $(THEOS_MAKE_PATH)/aggregate.mk
