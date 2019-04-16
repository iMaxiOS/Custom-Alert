//
//  ViewController.swift
//  Custom Alert
//
//  Created by Maxim Granchenko on 4/16/19.
//  Copyright © 2019 Maxim Granchenko. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var alertView: AlertView = {
        let alertView: AlertView = AlertView.loadFromNib()
        alertView.delegate = self
        return alertView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupVisualEffectView()
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    func setAlert() {
        view.addSubview(alertView)
        alertView.center = view.center
        alertView.set(title: "Hold on!", body: "Would you like to try our short tutorial to show you how this app work? It will take no more than 30 seconds!", leftButtonTitle: "Okey", rightButtonTitle: "No")
    }
    
    func animateIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    func animateOut() {
        UIView.animate(withDuration: 0.4,
                       animations: {
                        self.visualEffectView.alpha = 0
                        self.alertView.alpha = 0
                        self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.alertView.removeFromSuperview()
        }
    }
    
    @IBAction func showAlertButton(_ sender: Any) {
        setAlert()
        animateIn()
    }
}

extension ViewController: AlertDelegate {
    
    func leftButtonTapped() {
        animateOut()
    }
    
    func rightButtonTapped() {
        animateOut()
    }
}

