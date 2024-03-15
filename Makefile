UNAME_S = $(shell uname -s)


TARGET_EXEC = testbed
GENGINE_LIBRARY = libgengine.so


BUILD_DIR = ./build

SANDBOX_SRC_DIRS := ./Sandbox/src
GENGINE_SRC_DIRS := Gengine/src

SANDBOX_SRCS := $(shell find $(SANDBOX_SRC_DIRS) -name *.c)
GENGINE_SRCS := $(shell find $(GENGINE_SRC_DIRS) -name *.c)

SANDBOX_OBJS := $(SANDBOX_SRCS:%=$(BUILD_DIR)/%.o)
GENGINE_OBJS := $(GENGINE_SRCS:%=$(BUILD_DIR)/%.o)

GENGINE_INC_DIRS := $(VULKAN_SDK)/include
GENGINE_INC_DIRS := $(VULKAN_SDK)/lib

GENGINE_INC_FLAGS := $(addprefix -I,$(INC_DIRS))

GENGINE_LD_FLAGS += -lvulkan -Wl, -rpath,$(VULKAN_SDK)/lib



CC = clang


GENGINE_CCFLAGS := $(GENGINE_INC_FLAGS) -MMD -MP -g -shared -fPIC
SANDBOX_CCFLAGS := -MMD -MP -g
MKDIR_P := mkdir -p


#$(BUILD_DIR)/$(GENGINE_LIBRARY): $(GENGINE_OBJS)
#	$(CC) $(GENGINE_CCFLAGS) $(GENGINE_OBJS) -o $@

#$(BUILD_DIR)/%.c.o: %.c
#	$(MKDIR_P) $(dir $@)
#	$(CC) $(GENGINE_CCFLAGS) -c $< -o $@

all: build/testbed build/libgengine.so

# Sandbox
$(BUILD_DIR)/$(TARGET_EXEC): $(SANDBOX_OBJS)
	$(CC) $(SANDBOX_OBJS) -o $@ 

# assembly
$(BUILD_DIR)/%.s.o: %.s
	$(MKDIR_P) $(dir $@)
	$(AS) $(ASFLAGS) -c $< -o $@

# c source
$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(SANDBOX_CCFLAGS) -c $< -o $@

$(BUILD_DIR)/$(GENGINE_LIBRARY): $(GENGINE_OBJS)
	$(CC) $(GENGINE_CCFLAGS) $(GENGINE_OBJS) -o $@

$(BUILD_DIR)/%.c.o: %.c
	$(MKDIR_P) $(dir $@)
	$(CC) $(GENGINE_CCFLAGS) -c $< -o $@



#Library


clean:
	rm -rf build
