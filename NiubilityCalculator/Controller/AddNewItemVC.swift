//
//  AddNewItemVC.swift
//  NiubilityCalculator
//
//  Created by 季阳 on 2017/2/17.
//  Copyright © 2017年 季阳. All rights reserved.
//

import UIKit
import SVProgressHUD

protocol AddNewItemVCDelegate: class {
    func onAddNewGroup(withName name: String)
}

class AddNewItemVC: UIViewController {
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var confirm: UIButton!
    
    var pickerModel = [String]()
    var newGroupInputView = NewGroupInputViewWithBg()
    var pickerView: JYPickerView!
    
    weak var delegate: AddNewItemVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "记一笔"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "取消", style: .plain, target: self, action: #selector(AddNewItemVC.onTapCancel))
        
        self.confirm.layer.cornerRadius = 10
        self.confirm.layer.masksToBounds = true
        
        self.newGroupInputView.delegate = self
        self.newGroupInputView.alpha = 0
        self.newGroupInputView.isHidden = true
        self.view.addSubview(self.newGroupInputView)
        
        self.newGroupInputView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(self.contentView.snp.top)
            make.bottom.equalTo(self.contentView.snp.bottom)
            make.left.equalTo(self.contentView.snp.left)
            make.right.equalTo(self.contentView.snp.right)
        }
        
        self.pickerView = Bundle.main.loadNibNamed("JYPickerView", owner: self, options: nil)!.first as! JYPickerView
        self.pickerView.setPickerView(withDelegate: self, andDataSource: self)
        self.view.addSubview(self.pickerView)
        
        self.pickerView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(self.view.snp.bottom)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.height.equalTo(266)
        }
    }
    
    func onTapCancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onClickAddNewGroup(_ sender: Any) {
        self.newGroupInputView.isHidden = false
        UIView.animate(withDuration: 0.2, animations: {
            self.newGroupInputView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
}

// MARK: - NewGroupInputViewDelegate
extension AddNewItemVC: NewGroupInputViewDelegate {
    func onClickSave(name: String) {
        self.delegate?.onAddNewGroup(withName: name)
        
        DispatchQueue.global().async {
            self.pickerModel.append(name)
        }
        
        UIView.animate(withDuration: 0.2, animations: {
            self.newGroupInputView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (finish) in
            if finish {
                self.newGroupInputView.isHidden = true
            }
        }
    }
    
    func onClickCancel() {
        UIView.animate(withDuration: 0.2, animations: {
            self.newGroupInputView.alpha = 0
            self.view.layoutIfNeeded()
        }) { (finish) in
            if finish {
                self.newGroupInputView.isHidden = true
            }
        }
    }
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension AddNewItemVC: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return self.pickerModel.count
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 0
    }
}

// MARK: - UITextFieldDelegate
extension AddNewItemVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == self.typeTextField {
            self.priceTextField.resignFirstResponder()
            self.quantityTextField.resignFirstResponder()
            
            if self.pickerModel.count == 0 {
                SVProgressHUD.showError(withStatus: "请先添加类别")
                SVProgressHUD.dismiss(withDelay: 2.0)
            } else {
                UIView.animate(withDuration: 0.2, animations: {
                    self.pickerView.snp.remakeConstraints({
                        (make) in
                        make.top.equalTo(self.view.snp.bottom).offset(-266)
                    })
                    self.view.layoutIfNeeded()
                })
            }
            return false
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.pickerView.snp.remakeConstraints({
                    (make) in
                    make.top.equalTo(self.view.snp.bottom)
                })
                self.view.layoutIfNeeded()
            })
            return true
        }
    }
}
