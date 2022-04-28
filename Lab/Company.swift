
import Foundation

struct Company: Codable {
    let companyName: String
    let companySymbol: String
    let latestPrice: Double
    let change: Double
}

struct CompanySymbol: Codable {
    let symbol: String
    let name: String
}
