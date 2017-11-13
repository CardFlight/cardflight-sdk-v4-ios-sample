/*!
 * @header HelperFunctions.swift
 *
 * @brief List of functions that generate user-readable strings from SDK messages and states.
 *
 * @copyright 2017 CardFlight Inc. All rights reserved.
 */

import Foundation

class HelperFunctions {
    
    func stringForState(state: CFTTransactionState) -> String {
        var returnString = ""
        
        switch state {
        case .unknown:
            returnString = "Unknown"
            break
        case .pendingTransactionParameters:
            returnString = "Pending Transaction Parameters"
            break
        case .deferred:
            returnString = "Deferred"
            break
        case .completed:
            returnString = "Completed"
            break
        case .processing:
            returnString = "Processing"
            break
        case .pendingCardInput:
            returnString = "Pending Card Input"
            break
        case .pendingProcessOption:
            returnString = "Pending Process Option"
            break
        }
        return returnString
    }
    
    func stringForBattery(batteryStatus: CFTBatteryStatus) -> String {
        var returnString = ""
        
        switch batteryStatus {
        case .unknown:
            returnString = "Unknown"
            break
        case .low:
            returnString = "Low"
            break
        case .nominal:
            returnString = "Nominal"
            break
        case .pluggedIn:
            returnString = "Plugged In"
            break
        }
        return returnString
    }
    
    func stringForCardReaderType(cardReaderType: CFTCardReaderType) -> String {
        var returnString = ""
        
        switch cardReaderType {
        case .unknown:
            returnString = "Unknown"
            break
        case .audioJack:
            returnString = "Audio Jack"
            break
        case .bluetooth:
            returnString = "Bluetooth"
            break
        }
        return returnString
    }
    
    func stringForCardReaderModel(cardReaderModel: CFTCardReaderModel) -> String {
        var returnString = ""
        
        switch cardReaderModel {
        case .unknown:
            returnString = "Unknown"
            break
        case .A100:
            returnString = "A100"
            break
        case .A200:
            returnString = "A200"
            break
        case .A250:
            returnString = "A250"
            break
        case .B200:
            returnString = "B200"
            break
        case .B250:
            returnString = "B250"
            break
        case .B500:
            returnString = "B500"
            break
        case .B550:
            returnString = "B550"
            break
        case .btMag:
            returnString = "BTMag"
            break
        case .shuttle:
            returnString = "Shuttle"
            break
        }
        return returnString
    }
    
    func stringForCardInputMethod(cardInputMethod: CFTCardInputMethod) -> String {
        var returnString = ""
        
        switch cardInputMethod {
        case .unknown:
            returnString = "Unknown"
            break
        case .dip:
            returnString = "Dip"
            break
        case .key:
            returnString = "Key"
            break
        case .tap:
            returnString = "Tap"
            break
        case .swipe:
            returnString = "Swipe"
            break
        case .swipeFallback:
            returnString = "Swipe Fallback"
            break
        case .quickChip:
            returnString = "Quick Chip"
            break
        }
        return returnString
    }
    
    func stringForKeyedEntryEvent(keyedEntryEvent: CFTKeyedEntryEvent) -> String {
        var returnString = ""
        
        switch keyedEntryEvent {
        case .unknown:
            returnString = "Unknown"
            break
        case .cardIncomplete:
            returnString = "Card Incomplete"
            break
        case .cardComplete:
            returnString = "Card Complete"
            break
        }
        return returnString
    }
    
    func stringForCardReaderEvent(cardReaderEvent: CFTCardReaderEvent) -> String {
        var returnString = ""
        
        switch cardReaderEvent {
        case .unknown:
            returnString = "Unknown"
            break
        case .cardSwiped:
            returnString = "Swiped"
            break
        case .cardTapped:
            returnString = "Tapped"
            break
        case .cardInserted:
            returnString = "Inserted"
            break
        case .connected:
            returnString = "Connected"
            break
        case .cardTapErrored:
            returnString = "Tap Errored"
            break
        case .cardRemoved:
            returnString = "Card Removed"
            break
        case .disconnected:
            returnString = "Disconnected"
            break
        case .cardSwipeErrored:
            returnString = "Swipe Errored"
            break
        case .cardInsertErrored:
            returnString = "Insert Errored"
            break
        case .updateStarted:
            returnString = "Update Started"
            break
        case .updateCompleted:
            returnString = "Update Completed"
            break
        case .connectionErrored:
            returnString = "Connection Errored"
            break
        case .audioRecordingPermissionNotGranted:
            returnString = "Audio Permission Not Granted"
            break
        case .fatalError:
            returnString = "Fatal Error"
            break
        case .connecting:
            returnString = "Connecting"
            break
        case .batteryStatusUpdated:
            returnString = "Battery Status Updated"
            break
        }
        return returnString
    }
    
    func stringForTransactionResult(result: CFTTransactionResult) -> String {
        var returnString = ""
        
        switch result {
        case .unknown:
            returnString = "Unknown"
            break
        case .approved:
            returnString = "Approved"
            break
        case .declined:
            returnString = "Declined"
            break
        case .errored:
            returnString = "Errored"
            break
        case .aborted:
            returnString = "Aborted"
            break
        case .voided:
            returnString = "Voided"
            break
        }
        return returnString
    }
    
    func stringForCardBrand(cardBrand: CFTCardBrand) -> String {
        var returnString = ""
        switch cardBrand {
        case .unknown:
            returnString = "Unknown"
            break
        case .americanExpress:
            returnString = "AmericanExpress"
            break
        case .chinaUnionPay:
            returnString = "ChinaUnionPay"
            break
        case .dinersClubCarteBlanche:
            returnString = "DinersClubCarteBlanche"
            break
        case .dinersClubInternational:
            returnString = "DinersClubInternational"
            break
        case .discoverCard:
            returnString = "DiscoverCard"
            break
        case .interpayment:
            returnString = "Interpayment"
            break
        case .instapayment:
            returnString = "Instapayment"
            break
        case .JCB:
            returnString = "JCB"
            break
        case .maestro:
            returnString = "Maestro"
            break
        case .dankort:
            returnString = "Dankort"
            break
        case .mastercard:
            returnString = "Mastercard"
            break
        case .visa:
            returnString = "Visa"
            break
        case .UATP:
            returnString = "UATP"
            break
        case .verve:
            returnString = "Verve"
            break
        case .cardguard:
            returnString = "Cardguard"
            break
        }
        return returnString
    }
    
    func stringForTransactionType(transactionType: CFTTransactionType) -> String {
        var returnString = ""
        
        switch transactionType {
        case .unknown:
            returnString = "Unknown"
            break
        case .sale:
            returnString = "Sale"
            break
        case .refund:
            returnString = "Refund"
            break
        case .authorization:
            returnString = "Authorization"
            break
        case .tokenization:
            returnString = "Tokenization"
            break
        }
        return returnString
    }
}
