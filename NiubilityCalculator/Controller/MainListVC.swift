//
//  MainListVC.swift
//  NiubilityCalculator
//
//  Created by 季阳 on 17/2/14.
//  Copyright © 2017年 季阳. All rights reserved.
//

import UIKit

class MainListVC: UIViewController {
    
    @IBOutlet weak var priceListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

//# MARK: - UITableViewDelegate, UITableViewDataSource
extension MainListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
