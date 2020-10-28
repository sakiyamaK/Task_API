import Foundation

/*
 課題2
 複雑なjsonを正しくCodableで対応させる
 */

final class API {
  static let shared = API()
  private init() {}
}

/*
 課題2-1
 配列
 */

//サーバーから返ってくるjsonのdata
let json1 = """
[
{
"name": "sasaki",
"address": "東京",
"age": 20
},
{
"name": "tanaka",
"address": "大阪",
"age": 30
}
]
""".data(using: .utf8)!


/*ここに書き足す*/
struct UserModel: Codable {
  let name: String
  let address: String
  let age: Int
}

extension API {
  func requestUser1(completion:(([UserModel]?) -> ())?=nil) {
    guard let userModels = try? JSONDecoder().decode([UserModel].self, from: json1) else {
      completion?(nil)
      return
    }
    completion?(userModels)
  }
}

//呼び出し
API.shared.requestUser1 { userModels in
  print("-----[requestUser1]------")
  guard let _userModels = userModels else {
    return
  }
  for _userModel in _userModels {
    print(_userModel.name)
    print(_userModel.address)
    print(_userModel.age)
    print("-----------")
  }
}


/*
 課題2-2
 入れ子
 */

//サーバーから返ってくるjsonのdata
let json2 = """
{
"name": "sasaki",
"address": "東京",
"age": 20,
"friend": {
  "name": "tanaka",
  "address": "大阪",
  "age": 10
}
}
""".data(using: .utf8)!


/*ここに書き足す*/
struct UserModel2: Codable {
  struct Friend: Codable {
    let name: String
    let address: String
    let age: Int
  }
  let name: String
  let address: String
  let age: Int
  let friend: Friend
}

extension API {
  func requestUser2(completion:((UserModel2?) -> ())?=nil) {
    guard let userModel2 = try? JSONDecoder().decode(UserModel2.self, from: json2) else {
      completion?(nil)
      return
    }
    completion?(userModel2)
  }
}

//呼び出し
API.shared.requestUser2 { userModel2 in
  print("-----[requestUser2]------")
  guard let _userModel2 = userModel2 else {
    return
  }

  print(_userModel2.name)
  print(_userModel2.address)
  print(_userModel2.age)
  print("friend")
  print(_userModel2.friend.name)
  print(_userModel2.friend.address)
  print(_userModel2.friend.age)
}


/*
 課題2-3
 入れ子で配列
 */

//サーバーから返ってくるjsonのdata
let json3 = """
{
"name": "sasaki",
"address": "東京",
"age": 20,
"friends": [
  {
    "name": "tanaka",
    "address": "大阪",
    "age": 10
  },
  {
    "name": "saito",
    "address": "札幌",
    "age": 30
  }
]
}
""".data(using: .utf8)!


/*ここに書き足す*/
struct UserModel3: Codable {
  struct Friend: Codable {
    let name: String
    let address: String
    let age: Int
  }
  let name: String
  let address: String
  let age: Int
  let friends: [Friend]

}

extension API {
  func requestUser3(completion:((UserModel3?) -> ())?=nil) {
    guard let userModel3 = try? JSONDecoder().decode(UserModel3.self, from: json3) else {
      completion?(nil)
      return
    }
    completion?(userModel3)
  }
}

//呼び出し
API.shared.requestUser3 { userModel3 in
  print("-----[requestUser3]------")
  guard let _userModel3 = userModel3 else {
    return
  }
  print(_userModel3.name)
  print(_userModel3.address)
  print(_userModel3.age)
  print("friends")
  for friend in _userModel3.friends {
    print(friend.name)
    print(friend.address)
    print(friend.age)
    print("------------")
  }
}


/*
 課題2-4
 情報が不揃い
 */

//サーバーから返ってくるjsonのdata
let json4 = """
[
{
"name": "sasaki",
"address": "東京",
"age": 20
},
{
"name": "tanaka",
"address": "大阪"
},
{
"name": "saito",
"age": 40
}
]
""".data(using: .utf8)!


/*ここに書き足す*/
struct UserModel4: Codable {
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

extension API {
  func requestUser4(completion:(([UserModel4]?) -> ())?=nil) {
    guard let userModel4s = try? JSONDecoder().decode([UserModel4].self, from: json4) else {
      completion?(nil)
      return
    }
    completion?(userModel4s)
  }
}

//呼び出し
API.shared.requestUser4 { userModel4s in
  print("-----[requestUser4]------")
  guard let _userModel4s = userModel4s else {
    return
  }
  for _userModel4 in _userModel4s {
    print(_userModel4.name)
    print(_userModel4.address)
    print(_userModel4.age)
    print("---------")
  }
}

