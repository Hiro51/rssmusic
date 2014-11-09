//
//  DetailsViewController.swift
//  rssmusic
//
//  Created by Hiroyuki Tsujino on 11/9/14.
//  Copyright (c) 2014 Hiroyuki Tsujino. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    var album: Album?
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = self.album?.title
        albumCover.image = UIImage(data: NSData(contentsOfURL: NSURL(string: self.album!.largeImageURL)!)!)
    }
}
