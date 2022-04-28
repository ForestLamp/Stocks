
import Foundation

class CompanyFetcher {
    
    private let api = Api()
    private let parser = Parser()
    
    func compnayWith(symbol: String, completion: @escaping (Company?) -> Void) {
        api.fetchDataFor(compnaySymbol: symbol) { [weak self] companyData in
            self?.parser.parseQuote(data: companyData) { company in
                DispatchQueue.main.async {
                    completion(company)
                }
            }
        }
    }
    
    func loadCompanySymbols(completion: @escaping ([CompanySymbol]) -> Void) {
        api.fetchCompanyList { [weak self] companiesListData in
            self?.parser.parseCompanySymbols(data: companiesListData) { companySymbolList in
                DispatchQueue.main.async {
                    completion(companySymbolList)
                }
            }
        }
    }
    
}
