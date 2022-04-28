
import Foundation

class Api {
    
    class URLMaker {
        let token = "pk_46d9060701434954a9775a06d0067b0a"
        let baseURL = "https://cloud.iexapis.com"
        
        enum Path {
            static let companySymbol = "stable/stock"
            static let symbols = "stable/ref-data/symbols"
        }
        
        func urlStringFor(companySymbol: String) -> String {
            let symbolDataRequestURL = [baseURL, Path.companySymbol, companySymbol, "quote"].joined(separator: "/")
            return appendAPIToken(toRequestURL: symbolDataRequestURL)
        }
        
        func allCompaniesListURL() -> String {
            let companiesList = [baseURL, Path.symbols].joined(separator: "/")
            return appendAPIToken(toRequestURL: companiesList)
        }
        
        func appendAPIToken(toRequestURL url: String) -> String {
            "\(url)?token=\(token)"
        }
    }

    func fetchDataFor(compnaySymbol: String, completion: @escaping (Data) -> Void) {
        let urlString = URLMaker().urlStringFor(companySymbol: compnaySymbol)
        fetchRequestWith(url: urlString, completion: completion)
    }
    
    func fetchCompanyList(completion: @escaping (Data) -> Void) {
        let urlString = URLMaker().allCompaniesListURL()
        fetchRequestWith(url: urlString, completion: completion)
    }
    
    private func fetchRequestWith(url: String, completion: @escaping (Data) -> Void) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard (response as? HTTPURLResponse)?.statusCode == 200,
                  let data = data else {
                      print("Network error: \(error?.localizedDescription ?? "")")
                      return
                  }
            completion(data)
        }.resume()
    }
}
