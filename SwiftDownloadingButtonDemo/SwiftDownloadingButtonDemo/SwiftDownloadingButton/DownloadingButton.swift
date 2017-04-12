//
//  DownloadingButton.swift
//  SwiftDownloadingButtonDemo
//
//  Created by Dong, Yiming (Agoda) on 4/12/17.
//  Copyright © 2017 Dong, Yiming (Agoda). All rights reserved.
//

import UIKit

class DownloadingButton: UIView {
    
    enum State {
        case waitDownload
        case downloading
        case downloaded
    }
    var state: State = .waitDownload {
        didSet {
            updateUiState()
        }
    }

    var waitDownloadButton : UIButton!
    var downloadingButton : UIButton!
    var downloadedButton : UIButton!
    
    var downloadingView : DownloadingView!
    var downloadingContainer : UIView!
    
    var shouldHideDownloadedButton = true
    
    var color = UIColor.white
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        doInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        doInit()
    }
    
    func doInit() {
        backgroundColor = UIColor.white.withAlphaComponent(0.1)
        
        downloadingView = DownloadingView(frame: bounds)
        downloadingContainer = UIView(frame: bounds)
        
        waitDownloadButton = UIButton(frame: bounds)
        downloadingButton = UIButton(frame: bounds)
        downloadedButton = UIButton(frame: bounds)
        
        waitDownloadButton.setTitleColor(color, for: .normal)
        downloadedButton.setTitleColor(color, for: .normal)
        downloadingView.color = color
        
        waitDownloadButton.setTitle("Download", for: .normal)
        downloadedButton.setTitle("Open", for: .normal)
        
        installSubView(subView: downloadedButton, superView: self)
        installSubView(subView: waitDownloadButton, superView: self)
        
        installSubView(subView: downloadingView, superView: downloadingContainer)
        installSubView(subView: downloadingButton, superView: downloadingContainer)
        installSubView(subView: downloadingContainer, superView: self)
        
        waitDownloadButton.addTarget(self, action: #selector(DownloadingButton.startDownload), for: .touchUpInside)
        downloadingButton.addTarget(self, action: #selector(DownloadingButton.stopDownload), for: .touchUpInside)
        
        state = .waitDownload
    }
    
    func updateUiState() {
        
        waitDownloadButton.isHidden = true
        downloadingContainer.isHidden = true
        downloadedButton.isHidden = true
        
        switch state {
        case .waitDownload:
            waitDownloadButton.isHidden = false
        case .downloading:
            downloadingContainer.isHidden = false
        case .downloaded:
            if !shouldHideDownloadedButton {
                downloadedButton.isHidden = false
            }
        }
    }

    func installSubView(subView: UIView, superView: UIView) {
        
        subView.removeFromSuperview()
        superView.addSubview(subView)
        
        let leading = NSLayoutConstraint(item: subView, attribute: .leading, relatedBy: .equal, toItem: superView, attribute: .leading, multiplier: 1, constant: 0)
        let trailing = NSLayoutConstraint(item: subView, attribute: .trailing, relatedBy: .equal, toItem: superView, attribute: .trailing, multiplier: 1, constant: 0)
        let top = NSLayoutConstraint(item: subView, attribute: .top, relatedBy: .equal, toItem: superView, attribute: .top, multiplier: 1, constant: 0)
        let bottom = NSLayoutConstraint(item: subView, attribute: .bottom, relatedBy: .equal, toItem: superView, attribute: .bottom, multiplier: 1, constant: 0)
        
        superView.addConstraints([leading, trailing, top, bottom]);
    }
    
    // MARK: Button actions
    func startDownload() {
        state = .downloading
    }
    
    func stopDownload() {
        state = .waitDownload
    }

}
