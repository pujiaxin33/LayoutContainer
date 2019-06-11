//
//  ListGuideViewController.swift
//  LayoutContainer
//
//  Created by jiaxin on 2019/6/10.
//  Copyright © 2019 jiaxin. All rights reserved.
//

import UIKit

class ListGuideViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
}
