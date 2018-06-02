//
//  ColorViewController.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/05/31.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {
    
    var delegate: ColorPickerDelegate? {
        get {
            return (view as? ColorPickerView)?.delegate
        }
        set {
            (view as? ColorPickerView)?.delegate = newValue
        }
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        modalPresentationStyle = .popover
        popoverPresentationController?.delegate = self
        preferredContentSize = CGSize(width: 320.0, height: 240.0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ColorViewController: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        return .none
    }
}
