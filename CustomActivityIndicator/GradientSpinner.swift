//
//  Spinner.swift
//  CustomActivityIndicator
//
//  Created by jucollado on 6/23/20.
//  Copyright © 2020 jucollado. All rights reserved.
//

import UIKit

public class GradientSpinner: UIView {
    
    private let gradientLayer: CAGradientLayer = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.type = .init(rawValue: "conic")
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        return gradientLayer
    }()
    
    private var isSpinning = false
    private var lineWidth: CGFloat = 1
    private var duration: CFTimeInterval = 0.7
    private var firstColor: CGColor = UIColor.systemGreen.cgColor
    private var secondColor: CGColor = UIColor.white.cgColor
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func layoutSubviews() {
        super.layoutSubviews()
        setupGradientLayer()
        startAnimation()
    }
    
    public func setup(firstColor: CGColor, secondColor: CGColor, lineWidth: CGFloat, duration: CFTimeInterval) {
        self.firstColor = firstColor
        self.secondColor = secondColor
        self.lineWidth = lineWidth
        self.duration = duration
    }
    
    private func setupGradientLayer() {
        
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [secondColor, firstColor]
        
        //remove these 4 bellow line
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius: CGFloat = (self.frame.height / 2) - lineWidth
        let startAngle = CGFloat(Double.pi / 2)
        let endAngle = startAngle + CGFloat(Double.pi * 1.5)
        
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        //let path = UIBezierPath(ovalIn: bounds.insetBy(dx: lineWidth / 2, dy: lineWidth / 2)).cgPath
      
        let mask = CAShapeLayer()
        mask.fillColor = UIColor.clear.cgColor
        mask.strokeColor = UIColor.white.cgColor
        mask.lineCap = .round
        mask.lineWidth = lineWidth
        mask.path = path
        
        //remove this bellow line
        mask.position = center
        
        gradientLayer.mask = mask
        layer.addSublayer(gradientLayer)
        
    }
    
    private func startAnimation() {
        let spinnerAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
        spinnerAnimation.fromValue = 0
        spinnerAnimation.toValue = Float.pi * 2
        spinnerAnimation.duration = duration
        spinnerAnimation.timingFunction = CAMediaTimingFunction(name: .linear)
        spinnerAnimation.repeatCount = Float.infinity
        gradientLayer.add(spinnerAnimation, forKey: "spinnerAnimation")
        isSpinning = true
    }
    
    private func stopAnimation() {
        gradientLayer.removeAnimation(forKey: "spinnerAnimation")
        isSpinning = false
    }
    
    public func toggleSpinner() {
        if isSpinning {
            stopAnimation()
            return
        }
        startAnimation()
    }
    
}
