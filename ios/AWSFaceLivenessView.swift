//
//  AWSLivenessView.swift
//
//  Created by Chong Jhuang Hung on 27/10/2023.
//

import SwiftUI
import FaceLiveness

struct AWSFaceLivenessView: View {
    @State private var isPresentingLiveness = true
    @State private var sessionID: SessionID?
    @State private var isSessionIDObtained = false
    @State private var isLivenessResultObtained = false

    var body: some View {
        VStack {
            if isSessionIDObtained {
                FaceLivenessDetectorView(
                    sessionID: sessionID?.sessionId ?? "",
                    region: "us-west-2",
                    isPresented: $isPresentingLiveness,
                    onCompletion: { result in
                        switch result {
                        case .success:
                            print("Success")
                            // TODO: Navigigate to result page, and put the sessionID into the param
                            isLivenessResultObtained = true
                            // ...
                        case .failure(let error):
                            // ...
                            print("Failure")
                        default:
                            // ...
                            print("Default")
                        }
                    }
                )
//                NavigationLink("", destination: FaceLivenessResultView(sessionId: sessionID?.sessionId ?? "Failed to get sessionId"), isActive: $isLivenessResultObtained)
//                    .isDetailLink(false)
//                NavigationLink("", destination: FaceCompareResult(sessionId: sessionID?.sessionId ?? "Failed to get sessionId"), isActive: $isLivenessResultObtained)
//                    .isDetailLink(false)
            } else {
                Text("Getting session ID for AWS Faceliveness")
            }
            
        }
        .task {
            do {
                sessionID = try await getSessionId()
                isSessionIDObtained = true
                print("sessionID: \(sessionID?.sessionId ?? "SessionID not found")")
            } catch sessionIDError.invalidURL {
                print ("invalid URL")
            } catch sessionIDError.invalidData {
                print ("invalid Data")
            } catch sessionIDError.invalidResponse {
                print ("invalid response")
            } catch {
                print("unexpected error")
            }
        }
//        .onAppear {
//            let passportImageString: String? = UserDefaults.standard.string(forKey: "passportFaceImage")
//            print("Reterieved from user defaults", passportImageString)
//        }
        
    }
    
    func getSessionId() async throws -> SessionID {
//        let endpoint = "https://sendnotif.ez2sign.cloud/liveness"
//        let endpoint = "https://4zrw5lke3deay4areh3gokdysm0wowgb.lambda-url.ap-northeast-1.on.aws/"
        let endpoint = "https://cqmnwkzolcenin6xqrh4s43zvu0ugevi.lambda-url.us-west-2.on.aws/"
        
        guard let url = URL(string: endpoint) else { throw sessionIDError.invalidURL }

        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw sessionIDError.invalidResponse
        }

        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(SessionID.self, from: data)
        } catch {
            throw sessionIDError.invalidData
        }
    }
}

//func getSessionId() async {
//    let response = AF.request("https://sendnotif.ez2sign.cloud/liveness", method: .post, parameters: nil)
//    print("API Response: \(response)")
//}
    

//struct AWSLivenessView_Previews: PreviewProvider {
//    static var previews: some View {
//        AWSLivenessView()
//    }
//}

struct SessionID: Codable {
    let sessionId: String
}

enum sessionIDError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
}





// Attempt to make POST request

//var request = URLRequest(url: url)
//request.httpMethod = "POST"
//request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//request.addValue("application/json", forHTTPHeaderField: "Accept")
//
//URLSession.shared.dataTask(with: request) { data, response, error in
//    guard error == nil else {
//        print("Error: error calling POST")
//        print(error!)
//        return
//    }
//    guard let data = data else {
//        print("Error: Did not receive data")
//        return
//    }
//    guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
//        print("Error: HTTP request failed")
//        return
//    }
//    do {
//        guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
//            print("Error: Cannot convert data to JSON object")
//            return
//        }
//        guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
//            print("Error: Cannot convert JSON object to Pretty JSON data")
//            return
//        }
//        guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
//            print("Error: Couldn't print JSON in String")
//            return
//        }
//
//        print(prettyPrintedJson)
//
//
//    } catch {
//        print("Error: Trying to convert JSON data to string")
//        return
//    }
//}.resume()
