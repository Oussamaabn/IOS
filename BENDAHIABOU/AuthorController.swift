//
//  AuthorController.swift
//  BENDAHIABOU
//
//  Created by Ingénieur on 17/01/2019.
//  Copyright © 2019 ENSISA. All rights reserved.
//

import UIKit

class AuthorController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var parser: CDParser = CDParser()
    var cds: [CD] = []
    var authors: [String] = []
    var authorsCds: [[String]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authors = parser.authors
        tableView.delegate = self
        tableView.dataSource = self
        
        authors.sort { (aut1, aut2) -> Bool in
            return aut1 < aut2
        }
        
        for aut in authors {
            let cdsAut = parser.cdsAuthors(author: aut)
            authorsCds.append(cdsAut)
        }
        
        print(authorsCds)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text = authorsCds[indexPath.section][indexPath.row]
        cell.textLabel?.textColor = UIColor.blue
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return authors.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return authors[section]
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return authorsCds[section].count
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
