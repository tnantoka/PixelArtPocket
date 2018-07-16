//
//  IndexViewController.swift
//  PixelArtPocket
//
//  Created by Tatsuya Tobioka on 2018/03/28.
//  Copyright © 2018 tnantoka. All rights reserved.
//

import UIKit

class IndexViewController: UITableViewController {

    let reuseIdentifier = "reuseIdentifier"

    var pictures = Picture.all

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reload()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short

        let picture = pictures[indexPath.row]

        cell.textLabel?.text = formatter.string(from: picture.createdAt)
        cell.imageView?.image = picture.image

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let picture = pictures[indexPath.row]
        performSegue(withIdentifier: "edit", sender: picture)
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let picture = pictures[indexPath.row]
            picture.destroy()
            reload()
        }
    }


    @IBAction func onTapAdd(_ sender: Any) {
        let picture = Picture(colors: EditorView.defaultDots)
        picture.save()
        reload()
    }

    func reload() {
        pictures = Picture.all
        tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let picture = sender as? Picture {
            (segue.destination as? EditViewController)?.picture = picture
        }
    }
}
