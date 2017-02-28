//
//  PriceItemCell.swift
//  NiubilityCalculator
//
//  Created by 季阳 on 2017/2/15.
//  Copyright © 2017年 季阳. All rights reserved.
//

import UIKit

class PriceItemCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var detail: UILabel!
    @IBOutlet weak var price: UILabel!
    
    func loadData(data: PriceItemModel!) {
        
    }
    
    class func getCellID() -> String {
        return "PriceItemCell";
    }
    
    class func getCellHeight() -> CGFloat {
        return 40;
    }
}
