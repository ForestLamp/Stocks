//
//  ViewController.swift
//  Lab
//
//  Created by Alex Ch. on 10.02.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var companyNameLabel: UILabel!
    @IBOutlet weak var companySimbolLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var priceChangeLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var companyPickerView: UIPickerView!
    
    private var dataFetcher: CompanyFetcher!
    
    private var companies: [CompanySymbol] = [
        CompanySymbol(symbol: "AAPL", name: "Apple")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        updateSelectedQuate()
    }
    
    private func setup() {
        companyPickerView.dataSource = self
        companyPickerView.delegate = self
        activityIndicator.hidesWhenStopped = true
        dataFetcher = CompanyFetcher()
    }
    
    private func displayStockInfo(company: Company) {
        activityIndicator.stopAnimating()
        companyNameLabel.text = company.companyName
        companySimbolLabel.text = company.companySymbol
        priceLabel.text = "\(company.latestPrice)"
        priceChangeLabel.text = "\(company.latestPrice)"
        priceChangeLabel.textColor = company.change >= 0 ? .green : .red
    }
    
    private func loadData() {
        dataFetcher.loadCompanySymbols { symbols in
            self.companies = symbols
            self.companyPickerView.reloadAllComponents()
        }
    }
    
    private func updateSelectedQuate() {
        
        guard !companies.isEmpty else {
            return
        }
        
        activityIndicator.startAnimating()
        companyNameLabel.text = "(ಠ_ಠ)"
        companySimbolLabel.text = "(ಠ_ಠ)"
        priceLabel.text = "(ಠ_ಠ)"
        priceChangeLabel.text = "(ಠ_ಠ)"
        priceChangeLabel.textColor = .black
        
        let selectedRow = companyPickerView.selectedRow(inComponent: 0)
        let selectedSymbol = companies[selectedRow].symbol
        
        dataFetcher.compnayWith(symbol: selectedSymbol) { company in
            guard let company = company else {
                return
            }
            self.displayStockInfo(company: company)
        }
    }
}
// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return companies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return companies[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateSelectedQuate()
    }
    
}




