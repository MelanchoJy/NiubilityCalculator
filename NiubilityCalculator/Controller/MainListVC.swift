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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.add.layer.cornerRadius = 10
        self.add.layer.masksToBounds = true
    }
    
    @IBAction func onClickAddNewItem(_ sender: Any) {
        let vc = AddNewItemVC(nibName: "AddNewItemVC", bundle: nil) 
        vc.delegate = self
        for group in self.model.categoryGroup {
            vc.pickerModel.append(group.name)
        }
        
        let nav = UINavigationController(rootViewController: vc)
        self.present(nav, animated: true, completion: nil)
    }
}

// MARK: - PrivateFunc
extension MainListVC {
    fileprivate func addNewGroup(name: String) {
        DispatchQueue.global().async {
            let newGroup = ItemGroupModel()
            newGroup.name = name
            self.model.categoryGroup.append(newGroup)
            
            DispatchQueue.main.async {
                self.priceListView.reloadData()
            }
        }
    }
}

// MARK: - AddNewItemVCDelegate
extension MainListVC: AddNewItemVCDelegate {
    func onAddNewGroup(withName name: String) {
        self.addNewGroup(name: name)
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
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
                self.addBottomToViewBottom.constant = 2;
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.2, animations: {
            self.addBottomToViewBottom.constant = 2;
            self.view.layoutIfNeeded()
        })
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.model.categoryGroup.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = Bundle.main.loadNibNamed("MainListHeaderView", owner: self, options: nil)!.first as! MainListHeaderView
        let group = self.model.categoryGroup[section]
        header.name.text = group.name
        header.price.text = "\(group.totalPrice)元"
        return header
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
