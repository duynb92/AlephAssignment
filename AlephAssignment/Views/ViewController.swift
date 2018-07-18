//
//  ViewController.swift
//  AlephAssignment
//
//  Created by DuyN on 7/18/18.
//  Copyright © 2018 DuyN. All rights reserved.
//

import UIKit
import ViewAnimator
import EasyNotificationBadge

class ViewController: UIViewController {

    //MARK: - Outlets
    @IBOutlet weak var vIndicator: UIView!
    @IBOutlet weak var lbApple: UILabel!
    @IBOutlet weak var lbAndroid: UILabel!
    @IBOutlet var dataProvider: ProductDataProvider!
    @IBOutlet weak var colProducts: UICollectionView!
    @IBOutlet weak var btnNotification: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //set badge
        btnNotification.badge(text: "5")
        
        colProducts.register(UINib(nibName: "ProductCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ProductCollectionViewCell")
        let productManager = ProductManager()
        dataProvider.setProductManager(productManager: productManager)
        colProducts.dataSource = dataProvider
        colProducts.delegate = dataProvider
        
        getAppleProducts()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getProductsAndAnimate(url: String) {
        let animations = [AnimationType.from(direction: .right, offset: UIScreen.main.bounds.size.width + 20) ]
        UIView.animate(views: self.colProducts.orderedVisibleCells.reversed(), animations: animations, reversed: true, initialAlpha: 1.0, finalAlpha: 0.5,  duration: 0.2, options: .curveEaseOut, completion: {
            self.dataProvider.productManager.clearItems()
            self.colProducts.reloadData()
            
            NetworkManager.shared().getProducts(url: url) { (products, error) in
                if let products = products {
                    self.dataProvider.productManager.addItems(products: products)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                        self.colProducts.reloadData()
                        self.colProducts.performBatchUpdates({
                            UIView.animateBounce(views: self.colProducts.orderedVisibleCells, animations: animations, initialAlpha: 1.0, animationInterval: 0.2, duration: 0.7, options: .curveEaseOut, usingSpringWithDamping: 0.65, initialSpringVelocity: 0, completion: {
                            })
                        }, completion: nil)
                    }
                } else {
                    print(error)
                }
            }
        })
    }
    
    func getAppleProducts() {
        getProductsAndAnimate(url: "ios_assignment/apple.json")
    }
    
    func getAndroidProducts() {
        getProductsAndAnimate(url: "ios_assignment/android.json")
    }
    
    //MARK: - Actions
    @IBAction func selectApple(_ sender: UIButton) {
        let lbFrameInSuperview = self.view.convert(CGRect.zero, from: lbApple)
        let indicatorFrameInSuperview = self.view.convert(CGRect.zero, from: vIndicator)
        if lbFrameInSuperview.origin.x < indicatorFrameInSuperview.origin.x {
            UIView.animate(withDuration: 0.2) { [unowned self] in
                let frame = CGRect(x: (lbFrameInSuperview.origin.x), y: self.vIndicator.frame.origin.y, width: (self.lbApple.frame.size.width), height: self.vIndicator.frame.size.height)
                self.vIndicator.frame = frame
            }
            lbApple.alpha = 1
            lbAndroid.alpha = 0.7
            getAppleProducts()
        }
    }
    
    @IBAction func selectAndroid(_ sender: UIButton) {
        let lbFrameInSuperview = self.view.convert(CGRect.zero, from: lbAndroid)
        let indicatorFrameInSuperview = self.view.convert(CGRect.zero, from: vIndicator)
        if lbFrameInSuperview.origin.x > indicatorFrameInSuperview.origin.x {
            UIView.animate(withDuration: 0.2) { [unowned self] in
                let frame = CGRect(x: (lbFrameInSuperview.origin.x), y: self.vIndicator.frame.origin.y, width: (self.lbAndroid.frame.size.width), height: self.vIndicator.frame.size.height)
                self.vIndicator.frame = frame
            }
            lbApple.alpha = 0.7
            lbAndroid.alpha = 1
            getAndroidProducts()
        }
    }
}

