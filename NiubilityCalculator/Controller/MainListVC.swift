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
    
    lazy var addGroup: NewGroupInputView!  = NewGroupInputView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        add.layer.cornerRadius = 10
        add.layer.masksToBounds = true
    }
    
    @IBAction func onClickAdd(_ sender: Any) {
        
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
        return model.categoryGroup.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.categoryGroup[section].items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PriceItemCell.getCellID(), for: indexPath) as! PriceItemCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return PriceItemCell.getCellHeight()
    }
}
