//
//  ViewController.swift
//  SwipeCollectionViewController
//
//  Created by Sean Espressoft on 14/03/2019.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class SwipeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var menuCollectionView: UICollectionView?
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    let cellIdentifier = "mycell"
    var textLabel: UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let menuView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        self.view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        menuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        menuView.backgroundColor = .white
        
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: menuView.frame.width, height: menuView.frame.height), collectionViewLayout: UICollectionViewFlowLayout.init())
        menuCollectionView?.center.x = menuView.center.x
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: 60, height: 50)
        menuCollectionView?.setCollectionViewLayout(layout, animated: true)
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuView.addSubview(menuCollectionView!)
        menuCollectionView?.leadingAnchor.constraint(equalTo: menuView.leadingAnchor).isActive = true
        menuCollectionView?.topAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.topAnchor).isActive = true
        menuCollectionView?.trailingAnchor.constraint(equalTo: menuView.trailingAnchor).isActive = true
        menuCollectionView?.backgroundColor = .gray
        menuCollectionView?.contentInset = UIEdgeInsets(top: 0, left: menuView.center.x - 40, bottom: 0, right: 0)
        menuCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        
        
        let contentView = UIView(frame: CGRect(x: 0, y: menuView.frame.height, width: self.view.frame.width, height:  self.view.frame.height - menuView.frame.height))

        self.view.addSubview(contentView)
        
        contentView.backgroundColor = .green
        
        textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath)
        cell.backgroundColor = .blue
        return cell
    }
}

