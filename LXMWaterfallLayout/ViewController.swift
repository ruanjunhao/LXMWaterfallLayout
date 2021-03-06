//
//  ViewController.swift
//  LXMWaterfallLayout
//
//  Created by luxiaoming on 2017/8/23.
//  Copyright © 2017年 duowan. All rights reserved.
//

import UIKit

//UICollectionViewDelegateFlowLayout
//UICollectionViewFlowLayout
//UICollectionView

class ViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = LXMWaterfallLayout()
        layout.columnCount = 3
        layout.minimumColumnSpacing = 30
        layout.minimumInteritemSpacing = 20
        layout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 30, right: 40)
        layout.sectionHeaderHeight = 100
        layout.sectionFooterHeight = 50
        layout.collectionViewHeaderHeight = 200
        layout.collectionViewFooterHeight = 300
        
        let collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: layout)
//        collectionView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: "TestCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: TestCollectionViewCellIdentifier)
        
        let sectionNib = UINib(nibName: "TestSectionView", bundle: nil)
        collectionView.register(sectionNib, forSupplementaryViewOfKind: LXMCollectionElementKindSectionHeader , withReuseIdentifier: TestSectionViewIdentifier)
        collectionView.register(sectionNib, forSupplementaryViewOfKind: LXMCollectionElementKindSectionFooter, withReuseIdentifier: TestSectionViewIdentifier)
        collectionView.register(sectionNib, forSupplementaryViewOfKind: LXMCollectionElementKindCollectionViewHeader , withReuseIdentifier: TestSectionViewIdentifier)
        collectionView.register(sectionNib, forSupplementaryViewOfKind: LXMCollectionElementKindCollectionViewFooter, withReuseIdentifier: TestSectionViewIdentifier)
        
        return collectionView
    }()

    
    fileprivate var dataArray: [String] = {
        var dataArray = [String]()
        for i in 0 ..< 20 {
            dataArray.append("\(i)")
        }
        return dataArray
    }()
    
    fileprivate var sizeArray: [CGSize] = {
        var sizeArray = [CGSize]()
        for i in 0 ..< 20 {
            sizeArray.append(CGSize(width: 100, height: 100 + i % 5 * 10))
        }
        return sizeArray
    }()
}

// MARK: - Lifecycle
extension ViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(collectionView)
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


// MARK: - UICollectionViewDataSource
extension ViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 2 {
            return 5
        } else if section == 1 {
            return 10
        } else {
            return dataArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TestCollectionViewCellIdentifier, for: indexPath) as! TestCollectionViewCell
        cell.nameLabel.text = "(\(indexPath.section),\(dataArray[indexPath.item]))"
        cell.backgroundColor = UIColor.orange
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == LXMCollectionElementKindSectionHeader {
            let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TestSectionViewIdentifier, for: indexPath) as! TestSectionView
            sectionView.backgroundColor = UIColor.red
            sectionView.nameLabel.text = "sectionHeader \(indexPath.section)"
            return sectionView
            
        } else if kind == LXMCollectionElementKindSectionFooter {
            let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TestSectionViewIdentifier, for: indexPath) as! TestSectionView
            sectionView.backgroundColor = UIColor.blue
            sectionView.nameLabel.text = "sectionFooter \(indexPath.section)"
            return sectionView
        } else if kind == LXMCollectionElementKindCollectionViewHeader {
            let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TestSectionViewIdentifier, for: indexPath) as! TestSectionView
            sectionView.backgroundColor = UIColor.yellow
            sectionView.nameLabel.text = "collectionViewHeader"
            return sectionView
        } else if kind == LXMCollectionElementKindCollectionViewFooter {
            let sectionView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: TestSectionViewIdentifier, for: indexPath) as! TestSectionView
            sectionView.backgroundColor = UIColor.green
            sectionView.nameLabel.text = "collectionViewFooter"
            return sectionView
        } else {
            return UICollectionReusableView()
        }
    }
}


// MARK: - UICollectionViewDelegate
extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 && indexPath.item == 0 {
            self.collectionView.reloadData()
        }
        
        print("didSelectItemAt \(indexPath)")
    }
}

extension ViewController: LXMWaterfallLayoutDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return sizeArray[indexPath.item]
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, numberOfColumnsAt section: Int) -> Int {
        if section == 0 {
            return 3
        } else if section == 1 {
            return 2
        } else {
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, minimumColumnSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else if section == 1 {
            return 10
        } else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 0 {
            return 20
        } else if section == 1 {
            return 10
        } else {
            return 30
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, heightForSectionHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 100
        } else if section == 1 {
            return 50
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, heightForSectionFooterInSection section: Int) -> CGFloat {
        if section == 0 {
            return 50
        } else if section == 1 {
            return 20
        } else {
            return 0
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: LXMWaterfallLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if section == 0 {
            return UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        } else if section == 1 {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        } else {
            return UIEdgeInsets(top: 30, left: 30, bottom: 30, right: 30)
        }
    }
    
    
}

