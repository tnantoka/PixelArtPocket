//
//  EditViewController.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/04/07.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {

    @IBOutlet weak var editorView: EditorView!
    
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

    @IBAction func onTapGrid(_ sender: Any) {
        editorView.isGrid = !editorView.isGrid
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let colorViewController = segue.destination as? ColorViewController {
            colorViewController.delegate = self
        }
    }
}

extension EditViewController: ColorPickerDelegate {
    func colorDidChange(color: UIColor) {
        editorView.color = color
        dismiss(animated: true, completion: nil)
    }
}
