//
//  ViewController.swift
//  SwipeCollectionViewController
//
//  Created by Sean Espressoft on 14/03/2019.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class SwipeCollectionViewController: UIViewController{
    
    var menuCollectionView: UICollectionView?
    var contentCollectionView: UICollectionView?
    let menuCVLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let contentCVLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let cellIdentifier = "mycell"
    var viewControllers: [UIViewController] = []
    
    let firstVC = UIViewController()
    let secondVC = UIViewController()
    let thirdVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //MenuView
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50), collectionViewLayout: UICollectionViewFlowLayout())
        menuCVLayout.scrollDirection = .horizontal
        menuCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        menuCVLayout.itemSize = CGSize(width: 50, height: 50)
        menuCollectionView?.setCollectionViewLayout(menuCVLayout, animated: true)
        self.view.addSubview(menuCollectionView!)
        menuCollectionView?.contentInset = UIEdgeInsets(top: 0, left: self.view.center.x - 30, bottom: 0, right: self.view.center.x - 30)
        menuCollectionView?.register(NumberCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        menuCollectionView?.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        menuCollectionView?.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuCollectionView?.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.setCollectionViewProperty(collectionView: menuCollectionView!)
        
        //ContentView
        contentCollectionView = UICollectionView(frame: CGRect(x: 0, y: (menuCollectionView?.frame.height)!, width: self.view.frame.width, height: self.view.frame.height - (menuCollectionView?.frame.height)!), collectionViewLayout: UICollectionViewFlowLayout())
        contentCVLayout.scrollDirection = .horizontal
        contentCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentCVLayout.itemSize = CGSize(width: self.view.frame.width, height: self.view.frame.height - (menuCollectionView?.frame.height)!)
        contentCVLayout.minimumLineSpacing = 0
        contentCollectionView?.setCollectionViewLayout(contentCVLayout, animated: true)
        contentCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        contentCollectionView?.isPagingEnabled = true
        self.view.addSubview(contentCollectionView!)
        contentCollectionView?.bounces = false
        self.setCollectionViewProperty(collectionView: contentCollectionView!)

        firstVC.view = UIView(frame: CGRect(x: 0, y: 0, width: (contentCollectionView?.frame.width)!, height: (contentCollectionView?.frame.height)!))
        secondVC.view = UIView(frame: CGRect(x: 0, y: 0, width: (contentCollectionView?.frame.width)!, height: (contentCollectionView?.frame.height)!))
        thirdVC.view = UIView(frame: CGRect(x: 0, y: 0, width: (contentCollectionView?.frame.width)!, height: (contentCollectionView?.frame.height)!))
        firstVC.view.backgroundColor = .purple
        secondVC.view.backgroundColor = .yellow
        thirdVC.view.backgroundColor = .orange
        viewControllers = [firstVC,secondVC,thirdVC]
    }
    
    func setCollectionViewProperty(collectionView: UICollectionView){
        collectionView.decelerationRate = .fast
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension SwipeCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewControllers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == contentCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            cell.contentView.addSubview(viewControllers[indexPath.item].view)
            return cell
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NumberCollectionViewCell{
                cell.textLabel.text = "\(indexPath.item)"
                return cell
            }
        }
        return UICollectionViewCell()
    }
}

extension SwipeCollectionViewController: UIScrollViewDelegate{
    func scrollToNearestVisibleCollectionViewCell() {
        let visibleCenterPositionOfScrollView = Float((menuCollectionView?.contentOffset.x)! + ((self.menuCollectionView?.bounds.size.width)! / 2))
        var closestCellIndex = -1
        var closestDistance: Float = .greatestFiniteMagnitude
        
        if let menuCVCell = menuCollectionView?.visibleCells{
            for i in 0..<menuCVCell.count {
                let cell = menuCollectionView?.visibleCells[i]
                let cellWidth = cell?.bounds.size.width
                let cellCenter = Float((cell?.frame.origin.x)! + cellWidth! / 2)
                
                // Now calculate closest cell
                let distance: Float = fabsf(visibleCenterPositionOfScrollView - cellCenter)
                if distance < closestDistance {
                    closestDistance = distance
                    closestCellIndex = (menuCollectionView?.indexPath(for: cell!)!.row)!
                }
            }
        }
        
        if closestCellIndex != -1 {
            self.menuCollectionView?.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
            self.contentCollectionView?.scrollToItem(at: IndexPath(row: closestCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollToNearestVisibleCollectionViewCell()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollToNearestVisibleCollectionViewCell()
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        if scrollView == self.menuCollectionView{
        }else{
            let row = Int(targetContentOffset.pointee.x / view.frame.width)
            self.menuCollectionView?.scrollToItem(at: IndexPath(row: row, section: 0), at: .centeredHorizontally, animated: true)
        }
        
    }
}
