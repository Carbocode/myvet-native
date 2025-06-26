import Foundation

class Fetch {
    
    private static let debugMode = true // Imposta su `false` per disattivare i log
    
    /// Metodo generico per effettuare richieste HTTP
    private static func request<T: Decodable & Sendable>(
        endpoint: String,
        method: String,
        body: Encodable? = nil,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        var url = Config.apiURL.appendingPathComponent(endpoint)
        
        if let queryParams = queryParams, !queryParams.isEmpty {
            url.append(queryItems: queryParams)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method
        
        log("📤 [Fetch] \(method) \(url.absoluteString)")
        
        // Aggiunta degli headers personalizzati
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")

        //log("🔹 Headers: \(headers)")
        
        // Gestione del body per i metodi diversi da GET
        if let body = body, method != "GET" {
            if let jsonData = encodeBody(body) {
                urlRequest.httpBody = jsonData
            } else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "JSONEncodingError", code: -3, userInfo: nil)))
                }
                return
            }
        }
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                log("❌ [Fetch] Errore nella richiesta: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "InvalidResponse", code: -1, userInfo: nil)))
                }
                return
            }
            
            log("📥 [Fetch] Risposta ricevuta - Status Code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                log("❌ [Fetch] Nessun dato ricevuto")
                DispatchQueue.main.async {
                    completion(.failure(NSError(domain: "NoData", code: -2, userInfo: nil)))
                }
                return
            }
            
            DispatchQueue.main.async {
                handleResponse(data: data, completion: completion)
            }
        }
        
        task.resume()
    }
    
    /// Metodo GET
    static func get<T: Decodable & Sendable>(
        endpoint: String,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(endpoint: endpoint, method: "GET", queryParams: queryParams, headers: headers, completion: completion)
    }
    
    /// Metodo POST
    static func post<T: Decodable & Sendable>(
        endpoint: String,
        body: Encodable,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(endpoint: endpoint, method: "POST", body: body, queryParams: queryParams, headers: headers, completion: completion)
    }
    
    /// Metodo PUT
    static func put<T: Decodable & Sendable>(
        endpoint: String,
        body: Encodable,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(endpoint: endpoint, method: "PUT", body: body, queryParams: queryParams, headers: headers, completion: completion)
    }
    
    /// Metodo DELETE
    static func delete<T: Decodable & Sendable>(
        endpoint: String,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:],
        completion: @escaping (Result<T, Error>) -> Void
    ) {
        request(endpoint: endpoint, method: "DELETE", queryParams: queryParams, headers: headers, completion: completion)
    }
    
    /// Funzione per codificare il body in JSON
    private static func encodeBody(_ body: Encodable) -> Data? {
        do {
            let jsonData = try JSONEncoder().encode(body)
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                log("📦 Body: \(jsonString)")
            }
            return jsonData
        } catch {
            log("❌ [Fetch] Errore nella codifica del body JSON: \(error.localizedDescription)")
            return nil
        }
    }
    
    /// Funzione per gestire la decodifica della risposta
    private static func handleResponse<T: Decodable & Sendable>(data: Data, completion: @escaping (Result<T, Error>) -> Void) {
        if let jsonString = String(data: data, encoding: .utf8) {
            log("📩 Body ricevuto: \(jsonString)")
        }
        
        do {
            let decodedResponse = try JSONDecoder().decode(HTTPResponse<T>.self, from: data)
            completion(.success(decodedResponse.body))
        } catch {
            log("❌ [Fetch] Errore nella decodifica della risposta: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    /// Funzione per il logging (attivabile/disattivabile con `debugMode`)
    private static func log(_ message: String) {
        if debugMode {
            print(message)
        }
    }
}

