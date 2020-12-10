//
//  OrderDetailCustomerCell.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 02/12/20.
//

import UIKit

class OrderDetailCustomerCell: UITableViewCell {
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblNumberId: UILabel!
    @IBOutlet weak var lblPatientName: UILabel!
    @IBOutlet weak var lblPhoneNumber: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContainer.addAnotherDefaultShadow()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupModel(model: MedicationDetailResponse?) {
        let addressFirst = model?.address.firstLine ?? "" // alamat
        let addressSecond = model?.address.secondLine ?? "" // alamat
        let district = model?.address.district ?? "" // kecamatan
        let subDistrict = model?.address.subDistrict ?? "" // kelurahan
        let province = model?.address.province ?? "" // provinsi
        let postalCode = model?.address.postalCode ?? "" // kode pos
            
        self.lblNumberId.text = "# \(model?.id ?? "-")"
        self.lblPatientName.text = model?.patient.fullName
        self.lblPhoneNumber.text = model?.patient.phoneNumber
        self.lblAddress.text = "\(addressFirst), \(addressSecond), \(subDistrict), \(district), \(province), \(postalCode)"
    }
    
}
