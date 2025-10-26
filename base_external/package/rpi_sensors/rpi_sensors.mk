################################################################################
# rpi_sensors.mk - Buildroot package for Raspberry Pi sensors
################################################################################

RPI_SENSORS_VERSION = fc1ddae7a0ddf7ba1f74afea78ad7bc05fc59b8b
RPI_SENSORS_SITE = https://github.com/msmouni/ecen-5713-final-project-sensors.git
RPI_SENSORS_SITE_METHOD = git

RPI_SENSORS_DEPENDENCIES = sqlite

define RPI_SENSORS_BUILD_CMDS
	$(MAKE) -C $(@D) \
	    CC="$(TARGET_CC)"
endef

define RPI_SENSORS_INSTALL_TARGET_CMDS
	# Create writable directory for the DB
	mkdir -p $(TARGET_DIR)/var/lib/rpi_sensors_data

	$(INSTALL) -D -m 0755 $(@D)/build/bin/rpi_sensors $(TARGET_DIR)/usr/bin/rpi_sensors
endef

$(eval $(generic-package))
