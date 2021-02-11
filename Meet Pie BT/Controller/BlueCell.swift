//
//  TableViewCell.swift
//  Meet Pie BT
//
//  Created by Stephen Devlin on 09/02/2021.
//

import UIKit

class BlueCell: UITableViewCell {

    @IBOutlet weak var cellMemNum: UILabel!
    @IBOutlet weak var cellAngle: UILabel!
    @IBOutlet weak var cellTalking: UILabel!
    
    @IBOutlet weak var cellTotalTalk: UILabel!
    @IBOutlet weak var cellFreq: UILabel!
    
    @IBOutlet weak var cellNumTurns: UILabel!
    


    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
