//
//  OrderDetailPrescriptionCell.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 02/12/20.
//

import UIKit
import Kingfisher

class OrderDetailPrescriptionCell: UITableViewCell {

    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var imgPrescription: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContainer.addAnotherDefaultShadow()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupModel(model: MedicationDetailResponse?) {
        let image = URL(string: model?.prescriptionImage ?? "")
        
        self.imgPrescription.kf.setImage(with: image)
    }
    
}
