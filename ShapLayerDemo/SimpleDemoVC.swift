//
//  ViewController.swift
//  ShapLayerDemo
//
//  Created by Chiao-Te Ni on 2018/6/11.
//  Copyright © 2018年 aaron. All rights reserved.
//

import UIKit

class SimpleDemoVC: UIViewController {
    
    @IBOutlet weak var locateView: UIView! //偷懶用
    @IBOutlet weak var lineWidthSlider: UISlider!
    @IBOutlet weak var radiusSlider: UISlider!
    
    private var circleLayer = CAShapeLayer()
    
    private var radius: Float = 70
    private var startAngle: Float = 0.0
    private var endAngle: Float = Float.pi * 1.5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        radiusSlider.maximumValue    = radius * 2
        radiusSlider.value           = radius
        
        lineWidthSlider.maximumValue = radius * 2
        lineWidthSlider.value        = 0
        
        drawCircle()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func lineCapValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            circleLayer.lineCap = kCALineCapButt
        case 1:
            circleLayer.lineCap = kCALineCapRound
        case 2:
            circleLayer.lineCap = kCALineCapSquare
        default:
            break
        }
    }
    
    @IBAction func lineJoinValueChanged(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            circleLayer.lineJoin = kCALineJoinMiter
        case 1:
            circleLayer.lineJoin = kCALineJoinRound
        case 2:
            circleLayer.lineJoin = kCALineJoinBevel
        default:
            break
        }
    }
    
    @IBAction func layerPropertyValueChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value)
        
        switch sender.tag {
        case 0:
            circleLayer.lineWidth = value
//            circleLayer.lineDashPhase = value // 虛線測試用
        case 1:
            circleLayer.strokeStart = value
        case 2:
            circleLayer.strokeEnd = value
        default:
            break
        }
    }
    
    @IBAction func layerPathValueChanged(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            radius = sender.value
        case 1:
            startAngle = Float.pi * sender.value
        case 2:
            endAngle = Float.pi * sender.value
        default:
            return
        }
        
        let path = UIBezierPath(arcCenter: locateView.center,
                                radius: CGFloat(radius),
                                startAngle: CGFloat(startAngle),
                                endAngle: CGFloat(endAngle),
                                clockwise: true)
        
        if endAngle != Float.pi * 2 {
            path.addLine(to: locateView.center)
        }
        
        circleLayer.path = nil
        circleLayer.path = path.cgPath
    }
    
    func drawCircle(){
        let path = UIBezierPath(arcCenter: locateView.center,
                                radius: CGFloat(radius),
                                startAngle: CGFloat(startAngle),
                                endAngle: CGFloat(endAngle),
                                clockwise: true)
        path.addLine(to: locateView.center)
        path.close()
        
        // 愛心版path
        // let path = UIBezierPath(heartIn: locateView.bounds)
        
        circleLayer.path        = path.cgPath
        circleLayer.fillColor   = UIColor.black.cgColor
        circleLayer.strokeColor = UIColor.red.cgColor
        circleLayer.strokeStart = 0
        circleLayer.strokeEnd   = 1
        circleLayer.lineWidth   = 10

        // 邊線樣式
        let pattern: [NSNumber]? = [5,1,2]
        circleLayer.lineDashPattern = pattern
//        circleLayer.lineDashPattern = nil
        
        self.view.layer.addSublayer(circleLayer)
    }
}

