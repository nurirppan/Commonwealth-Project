//
//  OrderDetailStatusCell.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 02/12/20.
//

import UIKit

class OrderDetailStatusCell: UITableViewCell {

    @IBOutlet weak var vwInside: UIView!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwInside.addAnotherDefaultShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupModel(model: MedicationDetailResponse?) {
        self.lblStatus.text = model?.status
        self.lblDescription.text = "We are currently reviewing your prescription"
        
        switch model?.status {
        case "Active":
            self.lblStatus.textColor = UIColor.green
        case "Prescription Rejected":
            self.lblStatus.textColor = UIColor.red
        case "In Review":
            self.lblStatus.textColor = UIColor.orange
        default:
            self.lblStatus.textColor = UIColor.black
        }
    }
    
}
