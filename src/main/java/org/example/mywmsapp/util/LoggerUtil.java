package org.example.mywmsapp.util;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

public class LoggerUtil {
    public static final Logger LOGGER = LogManager.getLogger(LoggerUtil.class);

    public static void logInfo(String message) {
        LOGGER.info(message);
    }

    public static void logError(String message, Exception e) {
        LOGGER.error(message, e);
    }
}
