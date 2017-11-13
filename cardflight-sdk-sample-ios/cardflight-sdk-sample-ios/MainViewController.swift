/*!
 * @header MainViewController.swift
 *
 * @brief Responsible for handling the interaction between the app and the CardFlight SDK
 *
 * @copyright 2017 CardFlight Inc. All rights reserved.
 */

import UIKit

class MainViewController: UIViewController, CFTTransactionDelegate {
    
    private let apiKey = "YOUR_API_KEY_HERE"
    private let accountToken = "YOUR_ACCOUNT_TOKEN_HERE"
    
    @IBOutlet weak var stateMessage: UILabel!
    @IBOutlet weak var displayMessage: UILabel!
    @IBOutlet weak var readerMessage: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var transaction: CFTTransaction!
    var cardReaders = [CFTCardReaderInfo]()
    var currentReader: CFTCardReaderInfo?
    weak var delegate: CFTTransactionDelegate?
    var credentials: CFTCredentials = CFTCredentials()
    let amount = CFTAmount(decimalNumber: 1.00)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.setupLogger()
        self.resetLabels()
        
        /*!
         * Sets navigation title to current version of CardFlight SDK
         */
        self.navigationItem.title = Constants.kApplicationTitle
        
        /*!
         * Initialize credentials
         */
        self.credentials = self.createCredentials()
    }
    
    @IBAction func beginTransaction(_ sender: Any) {
        self.resetTransaction()
        self.beginSale()
    }
    
    func beginSale() {
        /*!
         * When a Transaction is in state PENDING TRANSACTION PARAMETERS, call Begin Sale or Begin Authorization with a valid Transaction Parameters object to begin a new sale or authorization.
         */
        let parameters = self.generateTransactionParameters(amount: amount, credentials: self.credentials)
        self.transaction?.beginSale(transactionParameters: parameters)
        /*!
         * Call Scan Bluetooth Card Readers to discover available Bluetooth Readers
         */
        self.transaction.scanBluetoothCardReaders()

    }
    
    func createCredentials() -> CFTCredentials {
        
        /*!
         * Assign an API Key and Account Token to the Credentials object.
         * When called, a network request is made to validate the parameters provided with the CardFlight Gateway.
         */
        self.credentials.setup(apiKey: apiKey, accountToken: accountToken, completion: { (credentials, success, error) in
            if success {
                /*!
                 * If a callback url is specified, the CardFlight Gateway will provide that url with all transaction details.
                 */
            } else {
                let alert = UIAlertController(title: Constants.kValidationError, message: Constants.kCheckCredentials, preferredStyle: .alert)
                let okay = UIAlertAction(title: Constants.kOkay, style: .default, handler: nil)
                alert.addAction(okay)
                self.present(alert, animated: true, completion: nil)
            }
        })
        
        return self.credentials
    }
    
    func generateTransactionParameters(amount: CFTAmount, credentials: CFTCredentials) -> CFTTransactionParameters {
        let parameters = CFTTransactionParameters(amount: amount, credentials: credentials)
        /*!
         * The boolean for requesting a signature is only honored for keyed and swiped transactions.
         * The CardFlight Gateway indicates whether to request a signature for all other card input methods used.
         */
        parameters.requireSignature = true
        /*!
         * The metadata hash is used to store any additional information with a Transaction on the CardFlight Gateway.
         * This data will also be sent to the callback url if one was provided.
         */
        parameters.metadata = nil
        
        return parameters
    }
    
    func resetLabels() {
        self.stateMessage.text = Constants.kResetStateMessage
        self.displayMessage.text = Constants.kResetDisplayMessage
        self.readerMessage.text = Constants.kResetReaderMessage
        self.readerMessage.isHidden = true
        self.toggleStartButton(isEnabled: true)
    }
    
    func resetTransaction() {
        /*!
         * Create a new Transaction object
         */
        self.transaction = nil
        self.transaction = CFTTransaction(delegate: self)
        self.currentReader = nil
        self.resetLabels()
    }
    
    func toggleStartButton(isEnabled: Bool) {
        if isEnabled {
            self.startButton.isEnabled = true
            self.startButton.backgroundColor = UIColor.blue
        } else {
            self.startButton.isEnabled = false
            self.startButton.backgroundColor = UIColor.gray
        }
    }
    
    func transaction(_ transaction: CFTTransaction, didUpdate cardReaderArray: [CFTCardReaderInfo]) {
        /*!
         * When reader availability changes, the Transaction Handler will return the [Card Reader Array Updated] callback with an array of available Card Reader Info objects.
         */
        self.updateCardReaderArray(cardReaderArray: cardReaderArray)
    }
    
    func transaction(_ transaction: CFTTransaction, didReceive cardReaderEvent: CFTCardReaderEvent, cardReaderInfo: CFTCardReaderInfo?) {
        /*!
         * Events triggered by the card reader: .unknown, .disconnected, .connected, .connectionErrored, .cardSwiped, .cardSwipedErrored, .cardInserted, .cardInsertedErrored, .cardRemoved, .cardTapped, .cardTappedErrored, .updateStarted, .updateCompleted, .audioRecordingPermissionNotGranted
         */
        self.readerMessage.text = Constants.kUpdateReaderMessage(HelperFunctions().stringForCardReaderEvent(cardReaderEvent: cardReaderEvent))
    }
    
    func transaction(_ transaction: CFTTransaction, didUpdate cardInputMethodArray: [NSNumber]) {
        /*!
         * After selecting a card reader, the cardInputMethodArray is updated with that selected reader's available card input methods.
         * Method by which card info was captured: .unknown, .key, .swipe, .dip, .tap, .swipeFallback
         */
        var message = ""
        for card in cardInputMethodArray {
            if let crd = CFTCardInputMethod(rawValue: card.intValue) {
                let cardAsString = HelperFunctions().stringForCardInputMethod(cardInputMethod: crd)
                message += "\(cardAsString) "
            }
        }
        self.displayMessage.text = Constants.kUpdateDisplayMessage(message)
    }
    
    func transaction(_ transaction: CFTTransaction, didRequestCardAidSelection cardAidArray: [CFTCardAID]) {
        /*!
         * When a Transaction is in the state PROCESSING and the Transaction Handler returns the Request CVM callback, call the Select Card AID method with the cardholder selected card AID object to proceed with processing.
         */
        if let cardAid = cardAidArray.first {
            transaction.select(cardAid: cardAid)
        }
    }
    
    /*!
     * MARK: CFTTransaction Delegate Methods
     */
    func transaction(_ transaction: CFTTransaction, didUpdate state: CFTTransactionState, error: Error?) {
        /*!
         * Current state of the transaction
         * Most transactions will proceed through 5 states in linear order: .pendingTransactionParameters, .pendingCardInput, .pendingProcessOptions, .processing, .completed
         */
        
        self.stateMessage.text = Constants.kUpdateStateMessage(HelperFunctions().stringForState(state: state))
        self.toggleStartButton(isEnabled: state != .pendingProcessOption)
    }
    
    func transaction(_ transaction: CFTTransaction, didRequestDisplay message: CFTMessage) {
        /*!
         * Primary message: High priority message, should be displayed to the user
         * Secondary message: Lower priority message, should be displayed to the user
         */
        var msg = ""
        msg += Constants.kUpdateDisplayMessage(String(message.primary ?? ""))
       
        if let secMessage = message.secondary, secMessage.count > 0 {
            msg += Constants.kUpdateDisplaySecondMessage(secMessage)
        }
        
        self.displayMessage.text = msg
    }
    
    func transaction(_ transaction: CFTTransaction, didRequestProcessOption cardInfo: CFTCardInfo) {
        /*!
         * Transaction requests a Process Option selection of Process, Abort, or Defer
         */
        self.transaction.select(processOption: .process)
    }
    
    func transaction(_ transaction: CFTTransaction, didDefer transactionData: Data) {
        /*!
         * The Defer Transaction callback is fired if the user opts to defer the transaction, which generally would be done if the user did not have internet connectivity to process the transaction.
         * A deferred transaction is in an incomplete state and must be resumed manually.
         */
    }
    
    func transaction(_ transaction: CFTTransaction, didRequest cvm: CFTCVM) {
        /*!
         * CVM stands for Cardholder Verification Method, i.e. the cardholder's signature.
         * Can request no CVM or a Signature CVM
         * When Request CVM callback is requested by the Transaction Handler, the cardholder should be prompted to provide signature verification.
         * Call attach(signature:) and attach signature CVM to Transaction.
         */
        transaction.attach(signature: UIImage(named: "cardflight")!)
    }
    
    func transaction(_ transaction: CFTTransaction, didComplete historicalTransaction: CFTHistoricalTransaction) {
        self.tableView.isHidden = true
        /*!
         * The Historical Transaction object is created to represent the record of a completed Transaction.
         * Void and Refund can be performed against the Historical Transaction returned on an APPROVED SALE Transaction.
         */
        if historicalTransaction.result == .approved {
            /*!
             * If transaction result is approved, void transaction
             * The transactions in this starter app is currently being conducted on a production environment.
             * Without voiding, you would be charged $1.00 after each successful transaction
             */
            historicalTransaction.voidTransaction { (success, error) in
                if success {
                    print(Constants.kVoidTransactionSuccess)
                } else {
                    print(Constants.kVoidTransactionFailure)
                    print(Constants.kErrorMessage(error?.localizedDescription ?? ""))
                }
            }
        }
    }
}
