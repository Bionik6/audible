//
//  ViewController.swift
//  BrianAudible
//
//  Created by Ibrahima Ciss on 06/09/2016.
//  Copyright © 2016 Ibrahima Ciss. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let cellId = "cell"
    let loginCellId = "loginCellId"
    
    var buttonStackTopConstraint: NSLayoutConstraint?
    var pageControlBottomConstraint: NSLayoutConstraint?
    
    lazy var pages: [Page] = {
        return [
            Page(title: "Share a great listen", message: "It's free to send your books to the people in your life. Every recipeint's first book is on us.", imageName: "page1"),
            Page(title: "Send from your library", message: "Ta the More menu next to any book. Choose \"Send this Book\"", imageName: "page2"),
            Page(title: "Send from the player", message: "Tap More menu in the upper corner. Choose \"Send this Book\"", imageName: "page3"),
            ]
    }()
    
    let buttonStack: UIStackView = {
        let skipButton = UIButton()
        skipButton.setTitle("Skip", for: .normal)
        skipButton.setTitleColor(UIColor(red:1, green:0.591, blue:0, alpha:1), for: .normal)
        
        let nextButton = UIButton()
        nextButton.setTitle("Next", for: .normal)
        nextButton.setTitleColor(UIColor(red:1, green:0.591, blue:0, alpha:1), for: .normal)
        
        let stack = UIStackView(arrangedSubviews: [skipButton, nextButton])
        stack.distribution = .equalCentering
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = self.view.frame.size
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.dataSource = self
        cv.delegate = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageControl: UIPageControl = {
        let control = UIPageControl()
        control.numberOfPages = self.pages.count + 1
        control.currentPageIndicatorTintColor = UIColor(red:1, green:0.591, blue:0, alpha:1)
        control.pageIndicatorTintColor = .gray
        return control
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        view.addSubview(pageControl)
        view.addSubview(buttonStack)
        registerCells()
        collectionView.addAnchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        pageControl.addAnchor(top: nil, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
        buttonStack.addAnchor(top: nil, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 20, leftConstant: 20, bottomConstant: 0, rightConstant: 20)
        buttonStackTopConstraint = NSLayoutConstraint(item: buttonStack, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20)
        pageControlBottomConstraint = NSLayoutConstraint(item: pageControl, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -20)
        NSLayoutConstraint.activate([buttonStackTopConstraint!, pageControlBottomConstraint!])
        pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func registerCells() {
        collectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: loginCellId)
    }
}



extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath)
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.page = pages[(indexPath as NSIndexPath).item]
        return cell
    }
}

extension ViewController: UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let currentPage = Int(targetContentOffset.pointee.x / view.frame.width)
        pageControl.currentPage = currentPage
        buttonStackTopConstraint?.constant = currentPage == pages.count ? -50 : 20
        pageControlBottomConstraint?.constant = currentPage == pages.count ? 30 : -20
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}


extension UIView {
    
    func addAnchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil) {
        self.addAnchor(top: top, left: left, bottom: bottom, right: right, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0)
    }
    
    func addAnchor(top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat) {
        self.translatesAutoresizingMaskIntoConstraints = false
        if let top = top { self.topAnchor.constraint(equalTo: top, constant: topConstant).isActive = true }
        if let left = left { self.leftAnchor.constraint(equalTo: left, constant: leftConstant).isActive = true }
        if let bottom = bottom { self.bottomAnchor.constraint(equalTo: bottom, constant: bottomConstant).isActive = true }
        if let right = right { self.rightAnchor.constraint(equalTo: right, constant: -rightConstant).isActive = true }
    }
}
