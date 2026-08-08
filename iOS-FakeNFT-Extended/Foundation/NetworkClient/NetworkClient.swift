import Foundation

enum NetworkClientError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
    case parsingError
    case incorrectRequest(String)
}

protocol NetworkClient {
    func send(request: NetworkRequest) async throws -> Data
    func send<T: Decodable>(request: NetworkRequest) async throws -> T
}

actor DefaultNetworkClient: NetworkClient {
    private let session: URLSession
    private let decoder: JSONDecoder
    private let encoder: JSONEncoder

    init(
        session: URLSession = URLSession.shared,
        decoder: JSONDecoder = JSONDecoder(),
        encoder: JSONEncoder = JSONEncoder()
    ) {
        self.session = session
        self.decoder = decoder
        self.encoder = encoder
    }

    func send(request: NetworkRequest) async throws -> Data {
        let urlRequest = try create(request: request)
        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkClientError.urlSessionError
        }
        guard 200 ..< 300 ~= response.statusCode else {
            throw NetworkClientError.httpStatusCode(response.statusCode)
        }
        return data
    }

    func send<T: Decodable>(request: NetworkRequest) async throws -> T {
        let data = try await send(request: request)
        return try await parse(data: data)
    }

    // MARK: - Private

    private func create(request: NetworkRequest) throws -> URLRequest {
        guard let endpoint = request.endpoint else {
            throw NetworkClientError.incorrectRequest("Empty endpoint")
        }

        var urlRequest = URLRequest(url: endpoint)
        urlRequest.httpMethod = request.httpMethod.rawValue
        
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        urlRequest.setValue(RequestConstants.token, forHTTPHeaderField: "X-Practicum-Mobile-Token")

        if let dto = request.dto {
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            
            if let stringDto = dto as? String {
                urlRequest.httpBody = stringDto.data(using: .utf8)
            } else {
                urlRequest.httpBody = try encodeToURLParams(dto: dto)
            }
        }
        
        return urlRequest
    }

    /// Преобразует любой Encodable в Data формата x-www-form-urlencoded
    private func encodeToURLParams(dto: Encodable) throws -> Data {
        do {
            let data = try encoder.encode(dto)
            guard let dictionary = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                throw NetworkClientError.incorrectRequest("Failed to serialize DTO")
            }
            
            var components = URLComponents()
            components.queryItems = dictionary.map { key, value -> URLQueryItem in
                let stringValue: String
                
                // 🔥 Вот здесь обработка массива (для ваших likes: [String])
                if let array = value as? [Any] {
                    // Превращаем ["id1", "id2"] в "id1, id2"
                    stringValue = array.map { "\($0)" }.joined(separator: ", ")
                } else if let stringVal = value as? String {
                    stringValue = stringVal
                } else {
                    stringValue = "\(value)"
                }
                
                return URLQueryItem(name: key, value: stringValue)
            }
            
            return components.percentEncodedQuery?.data(using: .utf8) ?? Data()
        } catch {
            throw NetworkClientError.incorrectRequest("Failed to encode DTO to URL params")
        }
    }

    private func parse<T: Decodable>(data: Data) async throws -> T {
        do {
            return try decoder.decode(T.self, from: data)
        } catch {
            // Выводим реальную ошибку декодирования в консоль
            print("🔴 DECODING ERROR: \(error)")
            throw NetworkClientError.parsingError
        }
    }
}

