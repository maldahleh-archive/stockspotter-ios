//
//  ViewController.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var stockCollectionView: UICollectionView!
    var dataSource: UICollectionViewDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dataSource = StockCollectionViewDataSource(collectionView: stockCollectionView)
        stockCollectionView.dataSource = dataSource
    }
}

