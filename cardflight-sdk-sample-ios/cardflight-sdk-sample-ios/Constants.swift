/*!
 * @header Constants.swift
 *
 * @brief Constants used by the app
 *
 * @copyright 2017 CardFlight Inc. All rights reserved.
 */

import Foundation

struct Constants {
    
    static var kCardFlightSDKVersion: String {
        let bundle = Bundle(identifier: "com.cardflight.CardFlight")
        return bundle!.infoDictionary!["CFBundleShortVersionString"] as! String
    }
    static var kApplicationTitle = "CardFlight SDK v\(kCardFlightSDKVersion)"
    static let kResetStateMessage = "Transaction State:"
    static let kResetDisplayMessage = "Display Message:"
    static let kResetReaderMessage = "Reader Event:"
    static var kUpdateStateMessage = {(state: String) in "Transaction State: \(state)"}
    static var kUpdateDisplayMessage = {(message: String) in "Display Primary Message: \(message)"}
    static var kUpdateDisplaySecondMessage = {(message: String) in " | Secondary Message: \(message)"}
    static var kUpdateReaderMessage = {(event: String) in "Reader Event: \(event)"}
    static let kVoidTransactionSuccess = "Successfully voided transaction."
    static let kVoidTransactionFailure = "Failed to void the transaction."
    static let kErrorMessage = {(error: String) in "Error:: \(error)"}
    static let kCardReaderSectionTitle = "Select A Reader"
    static let kValidationError = "Validation Error"
    static let kCheckCredentials = "Please check your credentials."
    static let kOkay = "Okay"
}
