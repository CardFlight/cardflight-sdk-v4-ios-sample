/*!
 * @header ReaderSelectionCell.swift
 *
 * @brief Responsible for setting up card reader table view cell
 *
 * @copyright 2017 CardFlight Inc. All rights reserved.
 */

import Foundation

class ReaderSelectionCell: UITableViewCell {
    
    @IBOutlet weak var readerLabel: UILabel!
    @IBOutlet weak var selectedIndicator: UIImageView!
    
    func setup(with name: String, selected: Bool) {
        readerLabel.text = name
        selectedIndicator.alpha = selected ? 1 : 0
    }
}
