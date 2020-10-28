import Foundation

/*
 課題3
 APIレスポンスのエラーハンドリング
 */

final class API {
  static let shared = API()
  private init() {}
}


//サーバーから返ってくるjsonのdata ランダムでエラーが発生する
let json = Bool.random() ?
  //成功した場合のレスポンス
  """
[
{
"name": "sasaki",
"address": "東京",
"age": 20
},
{
"name": "tanaka",
"address": "大阪",
},
{
"name": "saito",
"age": 40
}
]
""".data(using: .utf8)!
:
  //失敗した場合のレスポンス
  """
{"error": {
"title": "不正な入力です",
"code": 1999
}
}
""".data(using: .utf8)!

/*ここに書き足す*/
struct UserModel: Codable {
  private var _name: String?
  var name: String {
    set { _name = newValue }
    get { _name ?? "no name" }
  }
  private var _address: String?
  var address: String {
    set { _address = newValue }
    get { _address ?? "no address" }
  }
  private var _age: Int?
  var age: Int {
    set { _age = newValue }
    get { _age ?? 0 }
  }

  enum CodingKeys: String, CodingKey {
    case _name = "name", _address = "address", _age = "age"
  }
}

enum ApiError: Error {
  struct UserApiError: Codable {
    struct ErrorInfo: Codable {
      let title: String
      let code: Int
    }
    let error: ErrorInfo
  }

  case responseFailed(UserApiError)
  case decodeFailed(Error)
  case unknown

  var title: String {
    switch self {
    case .responseFailed(let apiError):
      return "ApiError : Unavailable status code: \(apiError.error.code)"
    case .decodeFailed(let raw):
      return "ApiError : Failed to decode \(raw)"
    case .unknown:
      return "ApiError : Unknown error"
    }
  }
}

extension API {

  func requestUser(completion:(([UserModel]?, ApiError?) -> ())?=nil) {
    let _json = json
    if let apiError = try? JSONDecoder().decode(ApiError.UserApiError.self, from: _json) {
      completion?(nil, ApiError.responseFailed(apiError))
      return
    }
    do {
      let userModels = try JSONDecoder().decode([UserModel].self, from: _json)
      completion?(userModels, nil)
    } catch(let error) {
      completion?(nil, ApiError.decodeFailed(error))
    }
  }
}

//呼び出し
API.shared.requestUser { (userModels, apiError) in
  if let _apiError = apiError {
    print(_apiError.title)
    return
  }
  guard let _userModels = userModels else {
    print(ApiError.unknown.title)
    return
  }

  for _userModel in _userModels {
    print(_userModel.name)
    print(_userModel.address)
    print(_userModel.age)
    print("--------")
  }
}
