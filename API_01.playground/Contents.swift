import Foundation

/*
 課題1
 requestUserはAPIのレスポンスをそのまま文字列型などで使用されてます
 Codableを利用して正しくモデル化したrequestUser2を用意してください
 */


//サーバーから返ってくるjsonのdata
let json = """
{
"name": "sasaki",
"address": "東京",
"age": 20
}
""".data(using: .utf8)!



final class API {
  static let shared = API()
  private init() {}
}


extension API {
  //このrequestUserは文字列や数値を直接completionに渡している
  func requestUser(completion:((String, String, Int) -> ())?=nil) {
    guard let dic = try? JSONSerialization.jsonObject(with: json, options: []) as? [String: Any] else {
      completion?("", "", 0)
      return
    }
    let name = dic["name"] as? String ?? ""
    let address = dic["address"] as? String ?? ""
    let age = dic["age"] as? Int ?? 0

    completion?(name, address, age)
  }
}

//requestTest
API.shared.requestUser { (name, address, age) in
  print(name)
  print(address)
  print(age)
}



/*--------------- ここから修正 -------------*/
//このUserModelをCodableを使って完成さえる
struct UserModel: Codable {
  let name: String
  let address: String
  let age: Int
}

extension API {
  func requestUser2(completion:((UserModel?) -> ())?=nil) {
    guard let userModel = try? JSONDecoder().decode(UserModel.self, from: json) else {
      completion?(nil)
      return
    }
    completion?(userModel)
  }
}

//UserModelを受け取るrequestTest2
//出力はrequestTestと同じにしてください
API.shared.requestUser2 { (userModel) in
  guard let _userModel = userModel else {
    return
  }
  print(_userModel.name)
  print(_userModel.address)
  print(_userModel.age)
}

