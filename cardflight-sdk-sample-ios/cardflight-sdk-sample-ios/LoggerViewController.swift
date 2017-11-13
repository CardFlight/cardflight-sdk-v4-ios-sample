/*!
 * @header LoggerViewController.swift
 *
 * @brief Extension of the MainViewController. Responsible for handling the CFTLoggerDelegate methods to log messages on the console.
 *
 * @copyright 2017 CardFlight Inc. All rights reserved.
 */

import Foundation

extension MainViewController: CFTLoggerDelegate {
    
    func setupLogger() {
        /*!
         * CFTLogger is a singleton
         */
        let logger = CFTLogger.shared()
        logger.delegate = self
        /*!
         * Set logging mode of the SDK
         * Pass true to enable developer logging mode to the console.
         */
        logger.setLogging(true)
    }

    func loggerOutput(_ output: String) {
        /*!
         * Capture logging messages
         */
        print(output)
    }
}
