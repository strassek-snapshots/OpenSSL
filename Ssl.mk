#######################################
# target static library
include $(CLEAR_VARS)

# The static library should be used in only unbundled apps
# and we don't have clang in unbundled build yet.
LOCAL_SDK_VERSION := 9

LOCAL_SHARED_LIBRARIES = $(log_shared_libraries)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libssl_static2
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-target.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_STATIC_LIBRARY)

#######################################
# target shared library
include $(CLEAR_VARS)

# If we're building an unbundled build, don't try to use clang since it's not
# in the NDK yet. This can be removed when a clang version that is fast enough
# in the NDK.
ifeq (,$(TARGET_BUILD_APPS))
LOCAL_CLANG := true
else
LOCAL_SDK_VERSION := 9
endif

LOCAL_SHARED_LIBRARIES += libcrypto2 $(log_shared_libraries)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libssl2
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-target.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_SHARED_LIBRARY)

#######################################
# host shared library
include $(CLEAR_VARS)
LOCAL_IS_HOST_MODULE := true
LOCAL_SHARED_LIBRARIES += libcrypto-host2 $(log_shared_libraries)
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libssl-host2
#LOCAL_MODULE_HOST_OS := linux windows
LOCAL_MULTILIB := both
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-host.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_HOST_SHARED_LIBRARY)

#######################################
# host static library
include $(CLEAR_VARS)
LOCAL_IS_HOST_MODULE := true
LOCAL_SHARED_LIBRARIES +=  $(log_shared_libraries)
LOCAL_STATIC_LIBRARIES += libcrypto_static2
LOCAL_MODULE_TAGS := optional
LOCAL_MODULE := libssl-static2
#LOCAL_MODULE_HOST_OS := linux windows
LOCAL_MULTILIB := both
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-host.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_HOST_STATIC_LIBRARY)

#######################################
# ssltest
include $(CLEAR_VARS)
LOCAL_SRC_FILES := ssl/ssltest.c
LOCAL_SHARED_LIBRARIES := libssl2 libcrypto2 $(log_shared_libraries)
LOCAL_MODULE := ssltest2
LOCAL_MULTILIB := both
LOCAL_MODULE_STEM_32 := ssltest
LOCAL_MODULE_STEM_64 := ssltest64
LOCAL_MODULE_TAGS := optional
LOCAL_ADDITIONAL_DEPENDENCIES := $(LOCAL_PATH)/android-config.mk $(LOCAL_PATH)/Ssl.mk
include $(LOCAL_PATH)/Ssl-config-host.mk
include $(LOCAL_PATH)/android-config.mk
include $(BUILD_EXECUTABLE)
