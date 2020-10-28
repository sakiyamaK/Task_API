import Foundation

/*
 課題4
 実践 githubのsearch APIを叩いて必要な情報を取得する
 何が必要かは各々自由に選んでください
 */

struct GithubRepository: Codable {
  /*ここに書き足す*/

}

enum GithubError: Int {
  case searchWordRequest = 999, searchWordResponse

  var code: Int { self.rawValue }
  var domain: String {
    /*ここに書き足す*/
    //正しくエラーのドメインを用意する
    ""
  }

  var error: NSError {
    NSError.init(domain: self.domain, code: self.code, userInfo: nil)
  }
}

final class GithubAPI {
  static let shared = GithubAPI()
  private init() {}

  private let host = "https://api.github.com"

  func requestRepository(searchWork: String, completion: ((GithubRepository?, Error?) -> Void)? = nil) {
    let endpoint = "search/repositories"
    let parameter = "q=\(searchWork)"
    guard let url = URL(string: host + "/" + endpoint + "?" +  parameter) else {
      completion?(nil, GithubError.searchWordRequest.error)
      return
    }
    //urlにアクセス
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let _error = error {
        completion?(nil, _error)
        return
      }
      guard let _data = data, let responseJsonStr = String(data: _data, encoding: .utf8) else {
        completion?(nil, GithubError.searchWordResponse.error)
        return
      }
      print(responseJsonStr)
      /*ここに書き足す*/
      //受け取ったレスポンスからGithubRepositoryモデルを生成してください
      completion?(nil, nil)
    }.resume()
  }
}

GithubAPI.shared.requestRepository(searchWork: "iOS")
