//
//  ListEmployeeCell.swift
//  Commonwealth Project
//
//  Created by Nur Irfan Pangestu on 10/12/20.
//

import UIKit

class ListEmployeeCell: UITableViewCell {
    
    var onEditTapped: ((Datum) -> Void)?
    var onDeleteTapped: ((Datum) -> Void)?
    
    @IBOutlet weak var vwContainer: UIView!
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSalary: UILabel!
    @IBOutlet weak var lblAge: UILabel!
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupAction()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func setupModel(model: Datum) {
        self.lblId.text = model.id
        self.lblName.text = model.employeeName
        self.lblSalary.text = model.employeeSalary
        self.lblAge.text = model.employeeAge
    }
    
    func setupBackground(row: Int) {
        if row % 2 == 0 {
            self.vwContainer.backgroundColor = #colorLiteral(red: 0.9071783423, green: 0.9220461249, blue: 0.9603423476, alpha: 1)
        }
    }
    
    private func setupAction() {
        self.btnEdit.addTapGestureRecognizer {
            self.onEditTapped?(
                Datum(
                    id: self.lblId.text ?? "",
                    employeeName: self.lblName.text ?? "",
                    employeeSalary: self.lblSalary.text ?? "",
                    employeeAge: self.lblAge.text ?? "")
            )
        }
        
        self.btnDelete.addTapGestureRecognizer {
            self.onDeleteTapped?(
                Datum(
                    id: self.lblId.text ?? "",
                    employeeName: self.lblName.text ?? "",
                    employeeSalary: self.lblSalary.text ?? "",
                    employeeAge: self.lblAge.text ?? "")
            )
        }
    }
    
    
    
}
