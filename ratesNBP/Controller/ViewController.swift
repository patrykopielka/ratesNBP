//
//  ViewController.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 24/06/2021.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var ratesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ratesTableView.delegate = self
        ratesTableView.dataSource = self
        ratesTableView.register(UINib(nibName: "RateCell", bundle: nil), forCellReuseIdentifier: "rateCell")
    }


}



extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell", for: indexPath)
            as! RateCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}



