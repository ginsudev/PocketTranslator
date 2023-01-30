ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard
TARGET = iphone:clang:15.2:14.5

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = PocketTranslator
PocketTranslator_BUNDLE_EXTENSION = bundle
PocketTranslator_FILES = PocketTranslator.m
PocketTranslator_CFLAGS = -fobjc-arc
PocketTranslator_FRAMEWORKS = UIKit
PocketTranslator_PRIVATE_FRAMEWORKS = ControlCenterUIKit
PocketTranslator_INSTALL_PATH = /Library/ControlCenter/Bundles/

include $(THEOS_MAKE_PATH)/bundle.mk
