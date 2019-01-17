//
//  TitleViewController.swift
//  BENDAHIABOU
//
//  Created by Ingénieur on 17/01/2019.
//  Copyright © 2019 ENSISA. All rights reserved.
//

import UIKit

class TitleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    
    var parser: CDParser = CDParser()
    var cds: [CD] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewCon.delegate = self
        tableViewCon.dataSource = self
        cds = parser.cds
        cds.sort { (cd1, cd2) -> Bool in
            cd1.title < cd2.title
        }
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return cds.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            cds.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
            
            parser.cds = cds
        }
    }
    
    func tableView(_ tableViewCon: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableViewCon.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? TableViewCell else {
            fatalError("dequeued cell")
        }
        
        let cd = cds[indexPath.row]
        cell.titleLabel?.text = cd.title
        cell.authorLabel?.text = cd.author
        cell.dateLabel?.text = cd.date
        
        return cell
    }
    

    
    @IBOutlet weak var tableViewCon: UITableView!
    
    
}
