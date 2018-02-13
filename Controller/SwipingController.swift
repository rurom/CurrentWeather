//
//  CollectionViewController.swift
//  CurrentWeather
//
//  Created by Roman on 2/8/18.
//  Copyright © 2018 Roman Rudavskiy. All rights reserved.
//

import UIKit

class SwipingController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var pageCtrlView: UIView!
    @IBOutlet weak var pageCtrl: UIPageControl!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        //Handling default nav back button
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
            topItem.backBarButtonItem?.tintColor = UIColor.white
            
            self.title = "Weather details"
            
            //Making the pageCtrlView transparent
            pageCtrlView.backgroundColor = .clear
            
            //Setup the number of page control pages
            let pc = pageCtrl
            pc?.numberOfPages = weatherList.count
            
            //setup Auto Layout for views
            setupLayout()
            
        }
    }//viewDidLoad


    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        return weatherList.count
    }
    

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as? PageCell else { return UICollectionViewCell()}
    
        //Setup the Auto layout constraints for views inside the cell using constructed functions from Helper
        //imageView constraints
        setupViewConstraints(item: cell.imageView, leadingTo: cell.leadingAnchor, leadingCon: 20, trailingTo: cell.trailingAnchor, trailingCon: -20, topTo: cell.topAnchor, topCon: 0, bottomTo: cell.bottomAnchor, bottomCon: heightTo(toView: cell, mp: -0.6))
        
        //tempView constraints
        setupViewConstraints(item: cell.tempView, leadingTo: cell.leadingAnchor, leadingCon: 20, trailingTo: cell.trailingAnchor, trailingCon: -20, topTo: cell.topAnchor, topCon: heightTo(toView: cell, mp: 0.4), bottomTo: cell.bottomAnchor, bottomCon:heightTo(toView: cell, mp: -0.4))
       setupCenterPosition(item: cell.tempLbl, toView: cell.tempView)
        
        //cityView constraints
        setupViewConstraints(item: cell.cityView, leadingTo: cell.leadingAnchor, leadingCon: 20, trailingTo: cell.trailingAnchor, trailingCon: -20, topTo: cell.topAnchor, topCon: heightTo(toView: cell, mp: 0.6), bottomTo: cell.bottomAnchor, bottomCon: 0)
        setupCenterPosition(item: cell.cityLbl, toView: cell.cityView)
        
        //Setup cityLbl constraints
        cell.cityLbl.leadingAnchor.constraint(equalTo: cell.cityView.leadingAnchor, constant: 10).isActive = true
        cell.cityLbl.trailingAnchor.constraint(equalTo: cell.cityView.trailingAnchor, constant: -10).isActive = true
     
        
        let weather = weatherList[indexPath.row]
        
        print(weather.name!)
        
        let name = weather.name!.uppercased()
        cell.cityLbl.text = name
        let temp = weather.main.temp
        
        let celsius = NSString(format:"%@", "\u{00B0}") as String
        
        //Changing background Color of the tempView depending on temperature value
        if temp > 0 {
            cell.tempView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
            cell.tempLbl.text = "+\(temp)\(celsius)"
        } else if temp < 0 {
            cell.tempView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            cell.tempLbl.text = "\(temp)\(celsius)"
        } else {
            cell.tempView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
            cell.tempLbl.text = "\(temp)\(celsius)"
        }
    
        print(temp)
        
        //Checking id of the weather conditions and setup the image
        if let weatherArr = weather.weather.first {
            
            let id:Int = (weatherArr?.id)!
            
            let idStr = String(id)
            let idPref = idStr.prefix(1)
            
            if idStr == "800" {
                cell.imageView.image = UIImage(named: "sunny")
            }else {
                
                if idPref == "2" {
                    cell.imageView.image = UIImage(named: "thunderstorm")
                }
                if idPref == "3" || idPref == "5" {
                    cell.imageView.image = UIImage(named: "rain")
                }
                if idPref == "6" {
                    cell.imageView.image = UIImage(named: "snow")
                }
                if idPref == "8" {
                    cell.imageView.image = UIImage(named: "clouds")
                }
                if idPref == "9" {
                    cell.imageView.image = UIImage(named: "xtreem")
                }
           }
      }
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //the collectionview to start at a specific index (currentRow) when it shows
    var onceOnly = false
    internal func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if !onceOnly {
            //set the row and section you need.
            let indexToScrollTo = IndexPath(row: currentRow, section: indexPath.section)
            
            pageCtrl.currentPage = currentRow
            self.collectionView.scrollToItem(at: indexToScrollTo, at: .left, animated: false)
            onceOnly = true
        }
    }
    
    
    
    //Setup Auto layot using constructed functions from Helper
    func setupLayout() {
        
        setupViewWidthHeightCenter(item: containerView, toView:self.view, widthMp: 1, heightMp: 0.6)
        containerView.backgroundColor = .clear
        
        setupViewConstraints(item: collectionView, leadingTo: containerView.leadingAnchor, leadingCon: 0, trailingTo: containerView.trailingAnchor, trailingCon: 0, topTo: containerView.topAnchor, topCon: 0, bottomTo: containerView.bottomAnchor, bottomCon: heightTo(toView: containerView, mp: -0.2))
        
        setupViewConstraints(item:pageCtrlView , leadingTo: containerView.leadingAnchor, leadingCon: 20, trailingTo: containerView.trailingAnchor, trailingCon: -20, topTo: collectionView.bottomAnchor, topCon: 0, bottomTo: containerView.bottomAnchor, bottomCon: 0)
        
        setupCenterPosition(item: pageCtrl, toView: pageCtrlView)
        
    }
    
    
    //Checking the current page of page control
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        
        let frameWidth = view.frame.width

        pageCtrl.currentPage = Int(x / frameWidth)
        
        print(pageCtrl.currentPage)
    
    }
    
    

}//class
