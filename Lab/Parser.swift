

import Foundation

class Parser {
        
    func parseQuote(data: Data, completion: @escaping (Company?) -> Void) {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
            completion(nil)
            return
        }
        completion(createCompanyFromJSON(jsonObject))
    }
    
    func parseCompanySymbols(data: Data, completion: @escaping ([CompanySymbol]) -> Void) {
        guard let jsonObject = try? JSONSerialization.jsonObject(with: data) else {
            completion([])
            return
        }
        completion(createCompanySymbolsFromJSON(jsonObject))
    }
        
    private func createCompanyFromJSON(_ jsonObject: Any) -> Company? {
        guard let json = jsonObject as? [String: Any],
              let companyName = json["companyName"] as? String,
              let companySymbol = json["symbol"] as? String,
              let latestPrice = json["latestPrice"] as? Double,
              let change = json["change"] as? Double
        else {
            print("Invalid json format")
            return nil
        }
        return Company(
            companyName: companyName,
            companySymbol: companySymbol,
            latestPrice: latestPrice,
            change: change
        )
    }
    
    private func createCompanySymbolsFromJSON(_ jsonObject: Any) -> [CompanySymbol] {
        guard let symbolsJSON = jsonObject as? [Any] else {
            print("Invalid json format")
            return []
        }
        let symbols: [CompanySymbol] = symbolsJSON.compactMap { jsonObject in
            guard let json = jsonObject as? [String: Any],
                  let companyName = json["name"] as? String,
                  let companySymbol = json["symbol"] as? String
            else {
                return nil
            }
            return CompanySymbol(symbol: companySymbol, name: companyName)
        }
        return symbols
    }
}
