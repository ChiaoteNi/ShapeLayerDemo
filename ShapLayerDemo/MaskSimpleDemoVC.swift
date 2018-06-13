//
//  MaskSimpleDemoVC.swift
//  ShapLayerDemo
//
//  Created by Chiao-Te Ni on 2018/6/12.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class MaskSimpleDemoVC: UIViewController {

    @IBOutlet weak var titleImg: UIImageView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var bgPlantView: UIView!
    
    private let maskLayer   = CAShapeLayer()
    private let borderLayer = CAShapeLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgPlantView.layer.cornerRadius = 10
        bgPlantView.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        maskLayer.path = UIBezierPath.init(heartIn: titleImg.bounds).cgPath
        maskLayer.frame = titleImg.bounds
        titleImg.layer.mask = maskLayer
        
        addHeartBorder()
    }
    
    func addHeartBorder() {
        borderLayer.path        = UIBezierPath.init(heartIn: borderView.bounds).cgPath
        borderLayer.fillColor   = UIColor.purple.withAlphaComponent(0.3).cgColor
        
        borderView.layer.addSublayer(borderLayer)
    }
}
