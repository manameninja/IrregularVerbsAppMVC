//
//  SelectVerbsViewController.swift
//  Verregular
//
//  Created by Даниил Павленко on 23.04.2023.
//

import UIKit

final class SelectVerbsViewController: UITableViewController {
    // MARK: - Properties
    private var dataSource = IrregularVerbs.shared
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Select verbs".localized
        view.backgroundColor = .white
        tableView.register(SelectVerbsTableViewCell.self, forCellReuseIdentifier: "SelectVerbsTableViewCell")
    }
    
    // MARK: - Private methods
    private func isSelected(verb: Verb) -> Bool {
        dataSource.selectVerbs.contains(where: {$0.infinitive == verb.infinitive })
    }
}

// MARK: - UITableViewDataSource
extension SelectVerbsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dataSource.verbs.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SelectVerbsTableViewCell", for: indexPath) as? SelectVerbsTableViewCell else { return UITableViewCell()}
        
        let verb = dataSource.verbs[indexPath.row]
        cell.configure(with: verb, isSelected: isSelected(verb: verb))
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SelectVerbsViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let verb = dataSource.verbs[indexPath.row]
        if isSelected(verb: verb) {
            dataSource.selectVerbs.removeAll(where: { $0.infinitive == verb.infinitive })
        } else {
            dataSource.selectVerbs.append(verb)
        }
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
}
