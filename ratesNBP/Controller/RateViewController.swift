//
//  RateViewController.swift
//  ratesNBP
//
//  Created by Patryk Opiełka on 25/06/2021.
//

import UIKit

class RateViewController: UIViewController {
    
    @IBOutlet weak var ratesDatesTableView: UITableView!
    
    @IBOutlet weak var firstDatePicker: UIDatePicker!
    @IBOutlet weak var secondDatePicker: UIDatePicker!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    
    let datePicker = UIDatePicker()
    let formatter = DateFormatter()
    var ratesManagerDates = RatesManagerDates()
    var rates = [RateInfoDates]()
    var rateCode = ""
    var rateTable = ""
    var firstDate = ""
    var secondDate = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        formatter.dateFormat = "yyyy-MM-dd"
        refreshButton.layer.cornerRadius = 5
        refreshButton.layer.borderWidth = 1
        ratesManagerDates.delegate = self
        
        ratesDatesTableView.bottomAnchor.constraint(greaterThanOrEqualTo: view.bottomAnchor, constant: 225.0)
        ratesDatesTableView.delegate = self
        ratesDatesTableView.dataSource = self
        ratesDatesTableView.register(UINib(nibName: "RateCell", bundle: nil), forCellReuseIdentifier: "rateCell")
        
        firstDatePicker.datePickerMode = .date
        secondDatePicker.datePickerMode = .date
    }
    
    @IBAction func refreshPressed(_ sender: UIButton) {
        ratesManagerDates.fetchData(table: rateTable, code: rateCode, firstDate: firstDate, secondDate: secondDate)
        ratesDatesTableView.reloadData()
        createSpinnerView()
    }
    
    @IBAction func firstDatePickerChanged(_ sender: UIDatePicker) {
        errorLabel.text = ""
        ratesDatesTableView.setContentOffset(ratesDatesTableView.contentOffset, animated: false)
        
        firstDate = formatter.string(from: sender.date)
        
        ratesManagerDates.fetchData(table: rateTable, code: rateCode, firstDate: firstDate, secondDate: secondDate)
        ratesDatesTableView.reloadData()
        createSpinnerView()
    }
    
    @IBAction func secondDatePickerChanged(_ sender: UIDatePicker) {
        errorLabel.text = ""
        ratesDatesTableView.setContentOffset(ratesDatesTableView.contentOffset, animated: false)
        
        secondDate = formatter.string(from: sender.date)
        
        ratesManagerDates.fetchData(table: rateTable, code: rateCode, firstDate: firstDate, secondDate: secondDate)
        ratesDatesTableView.reloadData()
        createSpinnerView()
    }
}

extension RateViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rateElement = rates[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "rateCell", for: indexPath)
            as! RateCell
        cell.rateName.text = ""
        cell.rateCode.text = rateCode
        cell.rateDate.text = rateElement.effectiveDate
        if rateTable == "C" {
            cell.rateMid.text = "bid: "+String(rateElement.bid!)
            cell.rateAsk.text = "ask: "+String(rateElement.ask!)
        } else {
            cell.rateMid.text = "mid: "+String(rateElement.mid!)
            cell.rateAsk.text = ""
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension RateViewController: RatesManagerDatesDelegate {
    
    func didUpdateRate(rateModel: RatesModelDates) {
        DispatchQueue.main.async {
            self.rates = rateModel.rates
            self.ratesDatesTableView.reloadData()
        }
    }
    
    func didFailWithError() {
        DispatchQueue.main.async {
            self.errorLabel.text = "Invalid date! Try again."
        }
        
    }
}

extension RateViewController {
    func createSpinnerView() {
        let child = SpinnerViewController()

        addChild(child)
        child.view.frame = view.frame
        view.addSubview(child.view)
        child.didMove(toParent: self)

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            child.willMove(toParent: nil)
            child.view.removeFromSuperview()
            child.removeFromParent()
        }
    }
}

