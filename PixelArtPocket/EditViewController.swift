//
//  EditViewController.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/04/07.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

import SwiftIconFont

class EditViewController: UIViewController {

    @IBOutlet weak var editorView: EditorView!
    
    @IBOutlet weak var colorItem: UIBarButtonItem!
    @IBOutlet weak var undoItem: UIBarButtonItem!
    @IBOutlet weak var redoItem: UIBarButtonItem!
    @IBOutlet weak var gridItem: UIBarButtonItem!

    var picture: Picture?

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let picture = picture else { return }
        editorView.dots = picture.colors

        // Do any additional setup after loading the view.
        editorView.dotsDidChange = {
            self.undoItem.isEnabled = self.editorView.canUndo
            self.redoItem.isEnabled = self.editorView.canRedo
            self.picture?.colors = self.editorView.dots
            self.picture?.image = self.editorView.screenshot
            self.picture?.save()
        }

        colorItem.icon(from: .fontAwesome, code: "square", ofSize: 20)
        colorItem.tintColor = .black
        undoItem.icon(from: .fontAwesome, code: "undo", ofSize: 20)
        redoItem.icon(from: .fontAwesome, code: "repeat", ofSize: 20)
        gridItem.icon(from: .fontAwesome, code: "squareo", ofSize: 20)
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

    @IBAction func onTapUndo(_ sender: Any) {
        editorView.undo()
    }

    @IBAction func onTapRedo(_ sender: Any) {
        editorView.redo()
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
        colorItem.tintColor = color
        dismiss(animated: true, completion: nil)
    }
}
