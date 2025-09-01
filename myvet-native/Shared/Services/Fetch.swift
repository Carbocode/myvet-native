import Foundation

class Fetch {
    
    private static let debugMode = true // Imposta su `false` per disattivare i log
    
    /// Metodo generico per effettuare richieste HTTP
    private static func request<T: Decodable & Sendable>(
        baseUrl: URL,
        endpoint: String,
        method: String,
        body: Encodable? = nil,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        var url = baseUrl.appendingPathComponent(endpoint)
        
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
            do {
                let jsonData = try JSONEncoder().encode(body)
                urlRequest.httpBody = jsonData
                if let jsonString = String(data: jsonData, encoding: .utf8) {
                    log("📦 Body: \(jsonString)")
                }
            } catch {
                log("❌ [Fetch] Errore nella codifica del body JSON: \(error.localizedDescription)")
                throw error
            }
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let httpResponse = response as? HTTPURLResponse else {
                log("❌ [Fetch] Risposta non valida")
                throw NSError(domain: "InvalidResponse", code: -1)
            }
            
            log("📥 [Fetch] Risposta ricevuta - Status Code: \(httpResponse.statusCode)")
            
            if let jsonString = String(data: data, encoding: .utf8) {
                log("📩 Body ricevuto: \(jsonString)")
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                throw NSError(domain: "HTTPError", code: httpResponse.statusCode)
            }
            
            do {
                let decoder = JSONDecoder()
                let decodedResponse: HTTPResponse<T> = try decodeWithDetailedErrors(HTTPResponse<T>.self, from: data, using: decoder)
                return decodedResponse.body
            } catch let err as DecodingError {
                log("❌ [Fetch] DecodingError: \(err)")
                throw err
            } catch {
                log("❌ [Fetch] Decode error: \(error.localizedDescription)")
                throw error
            }
        } catch {
            log("❌ [Fetch] Errore nella richiesta: \(error.localizedDescription)")
            throw error
        }
    }
    
    /// Metodo GET
    static func get<T: Decodable & Sendable>(
        baseUrl: URL = Config.apiURL,
        endpoint: String,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(baseUrl: baseUrl, endpoint: endpoint, method: "GET", queryParams: queryParams, headers: headers)
    }
    
    /// Metodo POST
    static func post<T: Decodable & Sendable>(
        baseUrl: URL = Config.apiURL,
        endpoint: String,
        body: Encodable,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(baseUrl: baseUrl, endpoint: endpoint, method: "POST", body: body, queryParams: queryParams, headers: headers)
    }
    
    /// Metodo PUT
    static func put<T: Decodable & Sendable>(
        baseUrl: URL = Config.apiURL,
        endpoint: String,
        body: Encodable,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(baseUrl: baseUrl, endpoint: endpoint, method: "PUT", body: body, queryParams: queryParams, headers: headers)
    }
    
    /// Metodo DELETE
    static func delete<T: Decodable & Sendable>(
        baseUrl: URL = Config.apiURL,
        endpoint: String,
        queryParams: [URLQueryItem]? = nil,
        headers: [String: String] = [:]
    ) async throws -> T {
        try await request(baseUrl: baseUrl, endpoint: endpoint, method: "DELETE", queryParams: queryParams, headers: headers)
    }
    
    /// Funzione per il logging (attivabile/disattivabile con `debugMode`)
    private static func log(_ message: String) {
        if debugMode {
            print(message)
        }
    }
    
    private static func decodeWithDetailedErrors<T: Decodable>(
            _ type: T.Type,
            from data: Data,
            using decoder: JSONDecoder = JSONDecoder()
        ) throws -> T {
            do {
                return try decoder.decode(T.self, from: data)
            } catch let err as DecodingError {
                // Prova a pretty-printare il payload per debugging
                if let obj = try? JSONSerialization.jsonObject(with: data, options: []),
                   let pretty = try? JSONSerialization.data(withJSONObject: obj, options: [.prettyPrinted]),
                   let prettyStr = String(data: pretty, encoding: .utf8) {
                    log("📄 JSON (pretty):\n\(prettyStr)")
                } else if let raw = String(data: data, encoding: .utf8) {
                    log("📄 JSON (raw):\n\(raw)")
                }
                log("❌ DecodingError:\n\(err)")
                throw err
            } catch {
                if let raw = String(data: data, encoding: .utf8) {
                    log("📄 JSON (raw):\n\(raw)")
                }
                log("❌ Decode error generico: \(error)")
                throw error
            }
        }
}

