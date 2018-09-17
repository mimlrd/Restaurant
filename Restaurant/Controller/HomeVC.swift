//
//  HomeVC.swift
//  Restaurant
//
//  Created by Mike Milord on 04/08/2018.
//  Copyright © 2018 First Republic. All rights reserved.
//

import UIKit

class HomeVC: UIViewController {
    
    @IBOutlet weak var restoCellection: UICollectionView!
    
    @IBOutlet var filterView: UIView!
    
    @IBOutlet weak var filterCollection: UICollectionView!
    
    
    fileprivate var heightFilterViewConstraint = NSLayoutConstraint()
    
    let conf = UXConfigure()
    let cardCell = "restoCell"
    // transition
    let transition = CircularTransition()
    // foaling button
    var verticalFloatingButtonConstraint: NSLayoutConstraint?
    let floatingBtn = UIButton()
    
    lazy var restos: [Post] = {
        let setPost = SetPosts()
        return setPost.createPostsForTesting()
    }()
    
    lazy var layoutItemCell : UICollectionViewFlowLayout? = {
        return self.restoCellection?.collectionViewLayout as! UICollectionViewFlowLayout?
    }()
    

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        restoCellection.dataSource = self
        restoCellection.delegate = self
        
        setupCells()
        addFloatingButton()
        
        setTitleLabl()
        setupNavbarButtons()
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        //make the button round
        createRoundButton()
        
    }
    
    private func createRoundButton(){
    
        floatingBtn.layer.cornerRadius = floatingBtn.frame.width / 2
        floatingBtn.layer.borderWidth = 0.25
        floatingBtn.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    
    func setTitleLabl() {
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.width - 32, height: view.frame.height ))
        titleLabel.text = "La Fourchette"
        titleLabel.font = UIFont(name: "Didot-Bold", size: 25)
        titleLabel.textColor = UIColor.rgb(153, green: 175, blue: 142)
        navigationItem.titleView = titleLabel
    }
    
    
    func setupNavbarButtons() {

        
        let filterImage = #imageLiteral(resourceName: "filter")
        
        let filterBarBtn = UIBarButtonItem(image: filterImage, style: .plain, target: self, action: #selector(pushFilterButton))
        filterBarBtn.tintColor = UIColor.rgb(153, green: 175, blue: 142) // Put the colour to white
        
        let reservation = #imageLiteral(resourceName: "resto-inverse")
        
        let reservationBarBtn = UIBarButtonItem(image: reservation, style: .plain, target: self, action: #selector(pushReservationButton))
        reservationBarBtn.tintColor = UIColor.rgb(153, green: 175, blue: 142) // Put the colour to white
        
        
        navigationItem.rightBarButtonItems = [filterBarBtn, reservationBarBtn]
    }
    
    
    
    
    
    
    
    
    fileprivate func setupCells(){
        
        let nib = UINib(nibName: "RestaurantCell", bundle: nil)
        restoCellection.register(nib, forCellWithReuseIdentifier: cardCell)
        
        
        if let flowLayout = self.layoutItemCell  {
            
            let width = view.frame.width  - 60
            let height: CGFloat = width * 1.34 + 40
            
            flowLayout.itemSize = CGSize(width: width , height: height)
            //flowLayout.estimatedItemSize = CGSize(width: (view.frame.width / 2) - 10, height: 1.0)
        }
        //        self.layoutItemCell?.estimatedItemSize = CGSize(width: (view.frame.width / 2) - 15, height: 1.0)
        self.layoutItemCell?.minimumInteritemSpacing = 0
        
        addViews()
        
    }
    
    
    @objc fileprivate func pushFilterButton(){
        print("frame: \(filterView.frame)")
        let height = view.frame.height / 2.2
        animateGrowView(height: height)
    }
    
    
    @objc fileprivate func pushReservationButton(){
        //print("frame: \(filterView.frame)")
        let height = view.frame.height / 2
        animateGrowView(height: height)
    }
    

    
    
    @IBAction func disPushDismissFilterViewBtn(_ sender: Any) {
        
        animateGrowView(height: 0.0)
    }
    




}


//- Mark: Foating button
extension HomeVC {
    
    fileprivate func addFloatingButton()  {
        
       // let yValue = restoCellection.frame.height * 0.47
        
        var height : CGFloat =  0.0
        
        if let h = self.tabBarController?.tabBar.frame.height {
            height = h
        } else {
            height = 50
        }
       
        print("tab bar height: \(String(describing: height))")
        
        floatingBtn.backgroundColor = .white
        floatingBtn.setImage(UIImage(named:"map"), for: .normal)
        floatingBtn.imageView?.contentMode = .scaleAspectFit
        floatingBtn.clipsToBounds = true
        floatingBtn.addTarget(self, action: #selector(floatingBtnPressed), for: .touchDown)
        floatingBtn.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(floatingBtn)
        
        //addShadow(forButton: floatingBtn)
        
        if #available(iOS 9.0, *) {
            verticalFloatingButtonConstraint = floatingBtn.bottomAnchor.constraint(equalTo: restoCellection.bottomAnchor, constant: -height)
            verticalFloatingButtonConstraint?.isActive = true
            floatingBtn.trailingAnchor.constraint(equalTo: restoCellection.trailingAnchor, constant: -15).isActive = true
            floatingBtn.heightAnchor.constraint(equalToConstant: 50).isActive = true
            floatingBtn.widthAnchor.constraint(equalToConstant: 50).isActive = true
            
        } else {
            // Fallback on earlier versions
        }
        
        
        
        
        
    }
    
    fileprivate func addShadow(forButton button: UIButton) {
        button.layer.shadowColor = UIColor.gray.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2.0)
        button.layer.shadowRadius = 2.0
        button.layer.shadowOpacity = 1.0
        button.layer.masksToBounds = false
        button.layer.shadowPath = UIBezierPath(roundedRect:button.bounds, cornerRadius:button.layer.cornerRadius).cgPath
    }
    
    
     @objc fileprivate func floatingBtnPressed()  {
        
        //print("Hello, I have been pressed")
        performSegue(withIdentifier: "showMapSegue", sender: self)
        
    }
    
}


extension HomeVC: UIViewControllerTransitioningDelegate {
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showMapSegue" {
            let secondVC = segue.destination as! MapViewVC
            secondVC.transitioningDelegate = self
            secondVC.modalPresentationStyle = .custom
            secondVC.restos = restos
        } else if segue.identifier == "showRestoDetail" {
            
        }
        
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = floatingBtn.center
        transition.circleColor = floatingBtn.backgroundColor!
        
        return transition
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = floatingBtn.center
        transition.circleColor = floatingBtn.backgroundColor!
        
        return transition
    }
    
}



extension HomeVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return restos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cardCell, for: indexPath) as? RestaurantCell else {return UICollectionViewCell()}
        
        // add corners and shadow to the cell
        conf.addCornerShadow(forCell: cell)
        
        cell.post = restos[indexPath.row]
        
        return cell
    }
    
    

    
  
    
}




extension HomeVC: UICollectionViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 540
    }
    
}


extension HomeVC {
    
    /** *********** ADD FILTER VIEW ****************** */
    
    fileprivate func addViews(){
        view.insertSubview(self.filterView, aboveSubview: restoCellection)
        self.filterView.translatesAutoresizingMaskIntoConstraints = false

        
        //Let put the constraint for the view
        
        heightFilterViewConstraint.constant = 0.0
        
        // add constraint for address and payment
        addConstraintToViews(viewItem: self.filterView, forContainerView: view)

        
    }
    
    
    fileprivate func addConstraintToViews(viewItem: UIView, forContainerView view: UIView){
        
        
        let bottomConstraint = NSLayoutConstraint(item: viewItem, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0)
        let leadingConstraint = NSLayoutConstraint(item: viewItem, attribute: .leading, relatedBy: .equal, toItem: view, attribute: .leading, multiplier: 1, constant: 0)
        let trailingConstraint = NSLayoutConstraint(item: viewItem, attribute: .trailing, relatedBy: .equal, toItem: view, attribute: .trailing, multiplier: 1, constant: 0)
        heightFilterViewConstraint = NSLayoutConstraint(item: viewItem, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 0)
        
        NSLayoutConstraint.activate([bottomConstraint, leadingConstraint, trailingConstraint, heightFilterViewConstraint])
        
    }
    
    
    fileprivate func animateGrowView(height: CGFloat){
        //print("is called")
        
        heightFilterViewConstraint.constant = height
        
        print("***** frame: \(filterView.frame)")
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
}

