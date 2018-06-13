//
//  MaskDemoVC.swift
//  ShapLayerDemo
//
//  Created by Chiao-Te Ni on 2018/6/11.
//  Copyright © 2018年 aaron. All rights reserved.
//

// 僅示意圖, 請搭配Transition & Snap shot 使用
import UIKit

class MaskDemoVC: UIViewController {
    
    @IBOutlet weak var topCoverImg: UIImageView!
    @IBOutlet weak var bottomCoverImg: UIImageView!
    
    private var maskLayer = CAShapeLayer()
    
    private var tapLocation: CGPoint    = CGPoint.zero
    private let initSize: CGSize        = CGSize(width: 1, height: 1)
    private var currentRatio: CGFloat   = 0
    
    private var shouldStop: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        maskLayer.fillColor = UIColor.black.cgColor
        resetMaskLayer(frame: CGRect.zero, ratio: 0)
        self.bottomCoverImg.layer.mask = self.maskLayer

        let tap = UITapGestureRecognizer(target: self, action: #selector(topCoverDidTap(sender:)))
        view.addGestureRecognizer(tap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        shouldStop = false
        startSlackLoop()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        shouldStop = true
    }
    
    @objc private func topCoverDidTap(sender: UITapGestureRecognizer) {
        tapLocation = sender.location(in: view)
        currentRatio = 1
    }
    
    private func resetMaskLayer(frame: CGRect, ratio: CGFloat) {
        let size = frame.size
        let path = UIBezierPath.init(arcCenter: CGPoint(x: frame.midX, y: frame.midY),
                                     radius: size.width * ratio,
                                     startAngle: 0,
                                     endAngle: CGFloat(Float.pi * 2),
                                     clockwise: true)
        self.maskLayer.path = path.cgPath
    }
    
    // Demo用偷懶loop, 開一個讓他一直跑
    private func startSlackLoop() {
        DispatchQueue(label: "slackLoop").async {
            repeat {
                guard self.shouldStop == false else { return }
                usleep(10000)
                guard self.currentRatio != 0 else { continue }
                
                self.currentRatio += 5
                DispatchQueue.main.async {
                    self.resetMaskLayer(frame: CGRect(origin: self.tapLocation, size: self.initSize), ratio: self.currentRatio)
                }
                
                guard self.currentRatio > 650 else { continue }
                DispatchQueue.main.async {
                    self.currentRatio = 0
                    self.resetMaskLayer(frame: CGRect(origin: self.tapLocation, size: self.initSize), ratio: 0)
                }
            } while self.shouldStop == false
        }
    }
}
