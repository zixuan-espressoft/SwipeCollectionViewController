//
//  ViewController.swift
//  SwipeCollectionViewController
//
//  Created by Sean Espressoft on 14/03/2019.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class SwipeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    var menuCollectionView: UICollectionView?
    var contentCollectionView: UICollectionView?
    let menuCVLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    let contentCVLayout:UICollectionViewFlowLayout = UICollectionViewFlowLayout()
    
    let cellIdentifier = "mycell"
    var textLabel: UILabel = UILabel()
    var menuView = UIView()
    
    let cellWidth = 60
    
    let color: [UIColor] = [.red, .green, .blue]
    
    var viewControllers: [UIViewController] = []
    
    let firstVC = UIViewController()
    let secondVC = UIViewController()
    let thirdVC = UIViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        menuView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        self.view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        menuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: menuView.frame.width, height: menuView.frame.height), collectionViewLayout: UICollectionViewFlowLayout.init())
        menuCVLayout.scrollDirection = .horizontal
        menuCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        menuCVLayout.itemSize = CGSize(width: 50, height: 50)
        menuCollectionView?.setCollectionViewLayout(menuCVLayout, animated: true)
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuView.addSubview(menuCollectionView!)
        menuCollectionView?.contentInset = UIEdgeInsets(top: 0, left: menuView.center.x - 30, bottom: 0, right: menuView.center.x - 30)
        menuCollectionView?.register(NumberCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        menuCollectionView?.decelerationRate = .fast
        menuCollectionView?.backgroundColor = .white
        menuCollectionView?.showsHorizontalScrollIndicator = false
        
        
        let contentView = UIView(frame: CGRect(x: 0, y: menuView.frame.height, width: self.view.frame.width, height:  self.view.frame.height - menuView.frame.height))
        self.view.addSubview(contentView)
        
        contentCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height), collectionViewLayout: UICollectionViewFlowLayout())
        contentCVLayout.scrollDirection = .horizontal
        contentCVLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        contentCVLayout.itemSize = CGSize(width: contentView.frame.width, height: contentView.frame.height)
        contentCVLayout.minimumLineSpacing = 0
        contentCollectionView?.setCollectionViewLayout(contentCVLayout, animated: true)
        contentCollectionView?.delegate = self
        contentCollectionView?.dataSource = self
        contentCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        contentCollectionView?.showsHorizontalScrollIndicator = false
        contentCollectionView?.isPagingEnabled = true
        contentCollectionView?.backgroundColor = .white
        contentView.addSubview(contentCollectionView!)
        contentView.backgroundColor = .green
        
        firstVC.view = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        secondVC.view = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        thirdVC.view = UIView(frame: CGRect(x: 0, y: 0, width: contentView.frame.width, height: contentView.frame.height))
        firstVC.view.backgroundColor = .purple
        secondVC.view.backgroundColor = .yellow
        thirdVC.view.backgroundColor = .orange
        viewControllers = [firstVC,secondVC,thirdVC]
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == contentCollectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
            cell.contentView.addSubview(viewControllers[indexPath.item].view)
            return cell
        }else{
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as? NumberCollectionViewCell{
                cell.textLabel.text = "\(indexPath.item)"
                cell.backgroundColor = color[indexPath.item]
                return cell
            }
        }
        return UICollectionViewCell()
    }
    
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

