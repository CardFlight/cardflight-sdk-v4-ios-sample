/*!
 * @header CardReaderTableViewController.swift
 *
 * @brief Extension of the MainViewController. Responsible for handling the UITableView data source and delegate methods used to display card readers.
 *
 * @copyright 2017 CardFlight Inc. All rights reserved.
 */

import Foundation
import UIKit

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.isHidden = true
    }
    
    func updateCardReaderArray(cardReaderArray: [CFTCardReaderInfo]) {
        self.cardReaders = cardReaderArray
        self.tableView.reloadData()
        self.tableView.isHidden = self.cardReaders.count <= 0
    }
    
    /*!
     * MARK: TableView Data Source and Delegate Methods
     */
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return Constants.kCardReaderSectionTitle
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cardReaders.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let reader = self.cardReaders[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReaderCell", for: indexPath) as! ReaderSelectionCell
        cell.setup(with: reader.name, selected: self.currentReader == reader)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedReader = self.cardReaders[indexPath.row]
        self.currentReader = selectedReader
        /*!
         * Call Select Card Reader on the Transaction with a [Card Reader Info object].
         */
        self.transaction.select(cardReaderInfo: selectedReader, cardReaderModel: selectedReader.cardReaderModel)
        tableView.reloadData()
        self.readerMessage.isHidden = false
    }
}
