//
//  JYPickerView.swift
//  NiubilityCalculator
//
//  Created by 季阳 on 2017/2/20.
//  Copyright © 2017年 季阳. All rights reserved.
//

import UIKit

protocol JYPickerViewDelegate: class {
    func onClickJYPickerViewCancel()
    func onClickJYPickerViewConfirm()
}

class JYPickerView: UIView {
    
    @IBOutlet weak var pickerView: UIPickerView!
    
    weak var delegate: JYPickerViewDelegate?
    
    func setPickerView(withDelegate delegate: Any!) {
        self.delegate = delegate as? JYPickerViewDelegate
        self.pickerView.delegate = delegate as? UIPickerViewDelegate
        self.pickerView.dataSource = delegate as? UIPickerViewDataSource
    }
    
    func reloadData() {
        self.pickerView.reloadComponent(0)
    }
    
    func getSelectedRow() -> Int {
        return self.pickerView.selectedRow(inComponent: 0)
    }
    
    @IBAction func onClickCancel(_ sender: Any) {
        self.delegate?.onClickJYPickerViewCancel()
    }
    
    @IBAction func onClickConfirm(_ sender: Any) {
        self.delegate?.onClickJYPickerViewConfirm()
    }
}
