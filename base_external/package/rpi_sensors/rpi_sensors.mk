################################################################################
# rpi_sensors.mk - Buildroot package for Raspberry Pi sensors
################################################################################

RPI_SENSORS_VERSION = ce10fdcd71ca6c5eb72b1f2eacaaf540ba67a52b
RPI_SENSORS_SITE = https://github.com/msmouni/ecen-5713-final-project-sensors.git
RPI_SENSORS_SITE_METHOD = git

define RPI_SENSORS_BUILD_CMDS
	$(MAKE) -C $(@D) \
	    CC="$(TARGET_CC)"
endef

define RPI_SENSORS_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/build/bin/rpi_sensors $(TARGET_DIR)/usr/bin/rpi_sensors
endef

$(eval $(generic-package))
