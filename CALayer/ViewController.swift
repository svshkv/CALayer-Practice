//
//  ViewController.swift
//  CALayer
//
//  Created by Саша Руцман on 22/09/2019.
//  Copyright © 2019 Саша Руцман. All rights reserved.
//

import UIKit
import Jelly

class ViewController: UIViewController {

    var animator: Jelly.Animator?

    var shapeLayer: CAShapeLayer! {
        didSet {
            shapeLayer.lineWidth = 10
            shapeLayer.lineCap = .round
            shapeLayer.fillColor = nil
            shapeLayer.strokeEnd = 1
            let color = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
            shapeLayer.strokeColor = color
        }
    }
    
    var overShapeLayer: CAShapeLayer! {
        didSet {
            overShapeLayer.lineWidth = 10
            overShapeLayer.lineCap = .round
            overShapeLayer.fillColor = nil
            overShapeLayer.strokeEnd = 0
            let color = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1).cgColor
            overShapeLayer.strokeColor = color
        }
    }
    
    var gradientLayer: CAGradientLayer! {
        didSet {
            gradientLayer.startPoint = CGPoint(x: 0, y: 0)
            gradientLayer.endPoint = CGPoint(x: 0, y: 1)
            let startColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1).cgColor
            let endColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
            gradientLayer.colors = [startColor, endColor]
            //            gradientLayer.locations = [0, 0.2, 1]
        }
    }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.size.height / 2
            imageView.layer.masksToBounds = true
            //let borderColor = UIColor.white
            //imageView.layer.borderColor = borderColor.cgColor
            //imageView.layer.borderWidth = 10
        }
    }
    
    
    @IBOutlet weak var tapButton: UIButton! {
        didSet {
            tapButton.layer.shadowOffset = CGSize(width: 0, height: 5)
            tapButton.layer.shadowOpacity = 0.5
            tapButton.layer.shadowRadius = 5
        }
    }
    
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height)
        
        configShapeLayer(shapeLayer)
        configShapeLayer(overShapeLayer)
    }
    
    func configShapeLayer(_ shapeLayer: CAShapeLayer) {
        shapeLayer.frame = imageView.bounds
        let path = UIBezierPath(roundedRect: imageView.frame, cornerRadius: imageView.frame.size.height / 2)
        
        //path.addLine(to: CGPoint(x: self.view.frame.width / 2 + 100, y: self.view.frame.height / 2))
        shapeLayer.path = path.cgPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer = CAGradientLayer()
        view.layer.insertSublayer(gradientLayer, at: 0)
        
        shapeLayer = CAShapeLayer()
        view.layer.addSublayer(shapeLayer)
        
        overShapeLayer = CAShapeLayer()
        view.layer.addSublayer(overShapeLayer)
        // Do any additional setup after loading the view.
        let myVC = UIViewController()
        myVC.view.backgroundColor = .green
        let viewController = myVC
        let interaction = InteractionConfiguration(presentingViewController: self, completionThreshold: 0.5, dragMode: .edge, mode: .dismiss)
        let presentation = SlidePresentation(direction: .right, interactionConfiguration: interaction)
        let animator = Animator(presentation: presentation)
        animator.prepare(presentedViewController: viewController)
        present(viewController, animated: true, completion: nil)
    }

    @IBAction func buttonTapped(_ sender: Any) {
        overShapeLayer.strokeEnd += 0.2
        if overShapeLayer.strokeEnd == 1.2 {
            overShapeLayer.strokeEnd = 0
        }
    }
    
}

