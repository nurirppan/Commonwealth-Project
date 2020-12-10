//
//  OrderListCell.swift
//  ITMI Project
//
//  Created by Nur Irfan Pangestu on 02/12/20.
//

import UIKit

class OrderListCell: UITableViewCell {
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblStatusOrder: UILabel!
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        self.vwContainer.addAnotherDefaultShadow()
        
        let string = "20:32 Wed, 30 Oct 2019"
        let formatter4 = DateFormatter()
        formatter4.dateFormat = "HH:mm E, d MMM y"
        print(formatter4.date(from: string) ?? "Unknown date")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func setupModel(model: ListOfMedication) {
        self.lblStatusOrder.text = model.status
        switch model.status {
        case "Active":
            self.lblStatusOrder.textColor = UIColor.green
        case "Prescription Rejected":
            self.lblStatusOrder.textColor = UIColor.red
        case "In Review":
            self.lblStatusOrder.textColor = UIColor.orange
        default:
            self.lblStatusOrder.textColor = UIColor.black
        }
        self.lblFullname.text = model.fullName
        self.lblOrderId.text = "# \(model.id ?? 0)"
        self.lblDate.text = DateFormatters.convert(valueDate: model.updatedAt ?? "", from: .defaultFormat, to: .resultFormat)
        self.lblPrice.text = CurrencyFormatter.convert(value: model.totalPrice ?? 0)
    }
    

    
}
