//
//  ViewController.swift
//  BubblePicker
//
//  Created by ronnel_davis@yahoo.com on 03/14/2017.
//  Copyright (c) 2017 ronnel_davis@yahoo.com. All rights reserved.
//

import UIKit
import BubblePicker

class ViewController: UIViewController {

    @IBOutlet var bubblePicker: BubblePicker!
    var array:NSArray? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()

        array = ["TV Shows", "Sports", "Movies", "Events", "Social", "Environment", "Causes", "News", "Technology", "Science", "People", "Places", "Music", "Photography"]
        
        bubblePicker.setup(items: array as! Array<String>);

        bubblePicker.setSelectedBubble(3, true);
        bubblePicker.setSelectedBubble(1, true);
        bubblePicker.setSelectedBubble(4, true);

        bubblePicker.setSelectedBubbles([3, 1, 4], true);

        bubblePicker.onBubbleSelected({
            index in
            print(index)
                 print(self.array?[index] ?? String(),index)
        })

        bubblePicker.onBubbleDeselected({
            index in
            print(self.array?[index] ?? String(),index)
        })

        print(bubblePicker.getSelectedBubbles());

        bubblePicker.theme = .light

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

