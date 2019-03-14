//
//  ViewController.swift
//  SwipeCollectionViewController
//
//  Created by Sean Espressoft on 14/03/2019.
//  Copyright © 2019 Sean. All rights reserved.
//

import UIKit

class SwipeCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    
    var menuCollectionView: UICollectionView?
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let menuView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: 50))
        self.view.addSubview(menuView)
        menuView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        menuView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor).isActive = true
        menuView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        menuView.backgroundColor = .white
        
        menuCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 50, height: menuView.frame.height), collectionViewLayout: UICollectionViewFlowLayout.init())
        menuCollectionView?.center.x = menuView.center.x
        layout.scrollDirection = .horizontal
        menuCollectionView?.setCollectionViewLayout(layout, animated: true)
        menuCollectionView?.delegate = self
        menuCollectionView?.dataSource = self
        menuView.addSubview(menuCollectionView!)
        menuCollectionView?.leadingAnchor.constraint(equalTo: menuView.leadingAnchor).isActive = true
        menuCollectionView?.topAnchor.constraint(equalTo: menuView.safeAreaLayoutGuide.topAnchor).isActive = true
        menuCollectionView?.trailingAnchor.constraint(equalTo: menuView.trailingAnchor).isActive = true
        menuCollectionView?.backgroundColor = .gray
        
        
        let contentView = UIView()
        contentView.frame.origin.x = 0
        contentView.frame.origin.y = menuView.frame.height
        contentView.frame.size.width = self.view.frame.width
        self.view.addSubview(contentView)
        
        contentView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: menuView.bottomAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        contentView.backgroundColor = .green
        
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
    }


}

