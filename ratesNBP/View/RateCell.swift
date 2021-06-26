//
//  RateCell.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import UIKit

class RateCell: UITableViewCell {
    
    @IBOutlet weak var rateCode: UILabel!
    @IBOutlet weak var rateName: UILabel!
    @IBOutlet weak var rateMid: UILabel!
    @IBOutlet weak var rateAsk: UILabel!
    @IBOutlet weak var rateDate: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
