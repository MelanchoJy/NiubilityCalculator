//
//  NewGroupInputView.swift
//  NiubilityCalculator
//
//  Created by 季阳 on 2017/2/15.
//  Copyright © 2017年 季阳. All rights reserved.
//

import UIKit

protocol NewGroupInputViewDelegate: class {
    func onClickSave(name: String)
    func onClickCancel()
}

class NewGroupInputView: UIView {
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: NewGroupInputViewDelegate?
    
    @IBAction func onClickCancel(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.onClickCancel()
        }
    }
    
    @IBAction func onClickSave(_ sender: Any) {
        if let delegate = self.delegate {
            delegate.onClickSave(name: self.textField.text!)
        }
    }
}


class NewGroupInputViewWithBg: UIView {
    var newGroupInputView: NewGroupInputView!
    
    weak var delegate: NewGroupInputViewDelegate? {
        didSet {
            self.newGroupInputView.delegate = self.delegate
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let grayView = UIView()
        grayView.backgroundColor = UIColor.gray
        grayView.alpha = 0.8
        addSubview(grayView)
        
        self.newGroupInputView = Bundle.main.loadNibNamed("NewGroupInputView", owner: self, options: nil)!.first as! NewGroupInputView
        self.newGroupInputView.layer.cornerRadius = 6
        self.newGroupInputView.layer.masksToBounds = true
        self.addSubview(self.newGroupInputView)
        
        grayView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
        }
        
        self.newGroupInputView.snp.makeConstraints {
            (make) -> Void in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(self.snp.centerY).offset(-60)
            make.left.equalTo(self.snp.left).offset(20)
            make.height.equalTo(165)
        }
    }
    
    func dismissKeyboard() {
        self.newGroupInputView.textField.resignFirstResponder()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
