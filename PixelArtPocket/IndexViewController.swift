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

    let items = [
        "#1",
        "#2",
        "#3",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)

        cell.textLabel?.text = items[indexPath.row]

        return cell
    }
}
