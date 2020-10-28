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
struct UserModel {
}

extension API {
  func requestUser1(completion:((/*ここに書き足す*/) -> ())?=nil) {
    /*ここに書き足す*/
    //jsonからCodableを使ってモデル化する
    completion?()
  }
}

//呼び出し
API.shared.requestUser1 {
  /*ここに書き足す*/
  //APIから受け取ったユーザ全員分の情報を表示してください
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
struct UserModel2 {
}

extension API {
  func requestUser2(completion:((/*ここに書き足す*/) -> ())?=nil) {
    /*ここに書き足す*/
    //jsonからCodableを使ってモデル化する
    completion?()
  }
}

//呼び出し
API.shared.requestUser2 {
  /*ここに書き足す*/
  //APIから受け取ったユーザ全員分の情報を表示してください
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
struct UserModel3 {
}

extension API {
  func requestUser3(completion:((/*ここに書き足す*/) -> ())?=nil) {
    /*ここに書き足す*/
    //jsonからCodableを使ってモデル化する
    completion?()
  }
}

//呼び出し
API.shared.requestUser3 {
  /*ここに書き足す*/
  //APIから受け取ったユーザ全員分の情報を表示してください
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
struct UserModel4 {
}

extension API {
  func requestUser4(completion:((/*ここに書き足す*/) -> ())?=nil) {
    /*ここに書き足す*/
    //jsonからCodableを使ってモデル化する
    completion?()
  }
}

//呼び出し
API.shared.requestUser4 {
  /*ここに書き足す*/
  //APIから受け取ったユーザ全員分の情報を表示してください
}


