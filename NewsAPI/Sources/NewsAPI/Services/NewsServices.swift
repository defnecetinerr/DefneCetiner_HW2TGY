//
//  File.swift
//  
//
//  Created by Defne Çetiner on 11.05.2023.
//

import Foundation
import Alamofire

public protocol NewsServiceProtocol: AnyObject {
    func fetchNews(completion: @escaping (Result<[News], Error>) -> Void)
}

public class NewsService: NewsServiceProtocol {
    
    public init() {} // to do: test yazmada yardımcı testi vakit kalırsa araştır ekle
    
    public func fetchNews(completion: @escaping (Result<[News], Error>) -> Void) {
        let urlString = "https://api.nytimes.com/svc/topstories/v2/home.json?api-key=kM36SrggFUFOtOXiBWtlBthxiHYiNF0R#"
        AF.request(urlString).responseData { response in
            switch response.result {
                
            case .success(let data):
                let decoder = Decoders.dateDecoder
                do {
                    let response = try decoder.decode(NewsTimeResponse.self, from: data)
                    completion(.success(response.results))
                } catch {
                    print("JSON DECODE ERROR")
                }
            case .failure(let error):
                print("**** GEÇİCİ BİR HATA OLUŞTU: \(error.localizedDescription) ******")
            }
        }
        
    }
    
    
}
