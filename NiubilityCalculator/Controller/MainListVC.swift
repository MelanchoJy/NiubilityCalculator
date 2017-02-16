//
//  MainListVC.swift
//  NiubilityCalculator
//
//  Created by 季阳 on 17/2/14.
//  Copyright © 2017年 季阳. All rights reserved.
//

import UIKit
import SnapKit

class MainListVC: UIViewController {
    
    @IBOutlet weak var add: UIButton!
    @IBOutlet weak var priceListView: UITableView!
    
    @IBOutlet weak var addBottomToViewBottom: NSLayoutConstraint!
    
    var model = MainListModel()
    
    var newGroupInputView: NewGroupInputViewWithBg!  = NewGroupInputViewWithBg()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.add.layer.cornerRadius = 10
        self.add.layer.masksToBounds = true
        
        self.newGroupInputView.delegate = self
        self.newGroupInputView.alpha = 0
        self.view.addSubview(self.newGroupInputView)
        
        self.newGroupInputView.snp.makeConstraints {
            (make) -> Void in
            make.top.equalTo(self.priceListView.snp.top)
            make.bottom.equalTo(self.priceListView.snp.bottom)
            make.left.equalTo(self.priceListView.snp.left)
            make.right.equalTo(self.priceListView.snp.right)
        }
    }
    
    @IBAction func onClickAdd(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {
            self.newGroupInputView.alpha = 1
            self.view.layoutIfNeeded()
        })
    }
}

//MARK: - UITableViewDelegate, UITableViewDataSource
extension MainListVC: UITableViewDelegate, UITableViewDataSource {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2, animations: {
            self.addBottomToViewBottom.constant = -45;
            self.view.layoutIfNeeded()
        })
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            UIView.animate(withDuration: 0.2, animations: {
                self.addBottomToViewBottom.constant = 0;
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2, animations: {
            self.addBottomToViewBottom.constant = 0;
            self.view.layoutIfNeeded()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.categoryGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.model.categoryGroup[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceItemCell.getCellID(), for: indexPath) as! PriceItemCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PriceItemCell.getCellHeight()
    }
}

// MARK: - NewGroupInputViewDelegate
extension MainListVC: NewGroupInputViewDelegate {
    func onClickSave() {
        UIView.animate(withDuration: 0.2, animations: {
            self.newGroupInputView.alpha = 0
            self.view.layoutIfNeeded()
        })
    }
    
    func onClickCancel() {
        UIView.animate(withDuration: 0.2, animations: {
            self.newGroupInputView.alpha = 0
            self.view.layoutIfNeeded()
        })
    }
}
