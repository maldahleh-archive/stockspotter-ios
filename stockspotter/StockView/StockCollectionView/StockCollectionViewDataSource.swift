//
//  StockCollectionViewDataSource.swift
//  stockspotter
//
//  Created by Mohammed Al-Dahleh on 2020-03-15.
//  Copyright © 2020 Codeovo Software Ltd. All rights reserved.
//

import UIKit

class StockCollectionViewDataSource: NSObject, UICollectionViewDataSource {
    private static let HEADER_IDENTIFIER = "StockHeader"
    private static let CELL_REUSE_IDENTIFIER = "StockDataCell"
    
    var collectionView: UICollectionView
    var refreshTimer: Timer
    
    let client = StockClient()
    var data: StockClient.Industries  = [:]
    
    init(collectionView: UICollectionView) {
        self.collectionView = collectionView
        self.refreshTimer = Timer()
        super.init()
        
        refreshStockData()
        self.refreshTimer = Timer.scheduledTimer(timeInterval: 60, target: self, selector: #selector(refreshStockData), userInfo: nil, repeats: true)
    }
    
    deinit {
        refreshTimer.invalidate()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let industryMapping = StockCollectionViewDataSource.INDUSTRY_MAPPING[section]
        if industryMapping == nil {
            return 0
        }
        
        return data[industryMapping!.jsonKey]?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StockCollectionViewDataSource.CELL_REUSE_IDENTIFIER, for: indexPath) as? StockCell,
            let industryJson = StockCollectionViewDataSource.INDUSTRY_MAPPING[indexPath.section],
            let stockList = data[industryJson.jsonKey] else {
                return UICollectionViewCell()
        }
        
        let stockData = stockList[indexPath.row]
        cell.symbolLabel.text = stockData.symbol
        cell.dataLabel.text = stockData.changePercent.description
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return StockCollectionViewDataSource.INDUSTRY_MAPPING.count
    }

    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let cell = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: StockCollectionViewDataSource.HEADER_IDENTIFIER, for: indexPath) as? StockHeader else {
            return UICollectionReusableView()
        }
        
        cell.sectorLabel.text = StockCollectionViewDataSource.INDEX_TITLES[indexPath.section]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    func indexTitles(for collectionView: UICollectionView) -> [String]? {
        return StockCollectionViewDataSource.INDEX_TITLES
    }
}

extension StockCollectionViewDataSource {
    private struct IndustryMapping {
        let jsonKey: String
        let displayName: String
    }
    
    private static let INDEX_TITLES = [
        "Advertising",
        "Aerospace & Defence"
    ]
    
    private static let INDUSTRY_MAPPING = [
        0: IndustryMapping(jsonKey: "advertising", displayName: "Advertising"),
        1: IndustryMapping(jsonKey: "aerospaceDefence", displayName: "Aerospace & Defence")
    ]
}

extension StockCollectionViewDataSource {
    @objc private func refreshStockData() {
        client.stocks { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let industries):
                self.data = industries
            case .failure:
                return
            }
            
            self.collectionView.reloadData()
        }
    }
}
