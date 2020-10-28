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
let json = Bool.random() ? """
[
{
"name": "sasaki",
"address": "東京",
"age": 20
},
{
"name": "tanaka",
"address": "大阪",
}
{
"name": "saito",
"age": 40
}
]
""".data(using: .utf8)!
  :
  """
{"error": {
"title": "不正な入力です",
"code": 1999
}
}
""".data(using: .utf8)!


/*ここに書き足す*/
struct UserModel {
}

extension API {

  func requestUser(completion:((/*ここに書き足す UserModelとErrorを入れてください*/) -> ())?=nil) {
    /*ここに書き足す*/
    //jsonからCodableを使ってモデル化する
    //UserModelにならないときはErrorを返す
    completion?()
  }
}

//呼び出し
API.shared.requestUser {
  /*ここに書き足す*/
  //APIから受け取ったユーザ全員分の情報を表示してください
  //エラーの場合はエラーの内容を表示してくだしあ
}
