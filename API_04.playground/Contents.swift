import Foundation

/*
 課題4
 実践 githubのsearch APIを叩いて必要な情報を取得する
 何が必要かは各々自由に選んでください
 */

struct GithubRepository: Codable {
  struct Item: Codable {
    let fullName: String?
    let htmlUrl: String?
    enum CodingKeys: String, CodingKey {
      case fullName = "full_name", htmlUrl = "html_url"
    }

  }
  let items: [Item]?
}

enum GithubError: Error {
  case requestFailed
  case responseFailed(Error?)
  case decodeFailed(Error)
  case unknown

  var title: String {
    switch self {
    case .requestFailed:
      return "ApiError : Unavailable status code"
    case .responseFailed(let raw):
      return "ApiError : Failed to response \(raw?.localizedDescription ?? " error")"
    case .decodeFailed(let raw):
      return "ApiError : Failed to decode \(raw.localizedDescription)"
    case .unknown:
      return "ApiError : Unknown error"
    }
  }
}

final class GithubAPI {
  static let shared = GithubAPI()
  private init() {}

  private let host = "https://api.github.com"

  func requestRepositories(searchWork: String, completion: ((GithubRepository?, GithubError?) -> Void)? = nil) {
    let endpoint = "search/repositories"
    let parameter = "q=\(searchWork)"
    guard let url = URL(string: host + "/" + endpoint + "?" +  parameter) else {
      completion?(nil, GithubError.requestFailed)
      return
    }
    //urlにアクセス
    URLSession.shared.dataTask(with: url) { data, response, error in
      if let _error = error {
        completion?(nil, GithubError.responseFailed(_error))
        return
      }
      guard let _data = data else {
        completion?(nil, GithubError.responseFailed(nil))
        return
      }
      /*ここに書き足す*/
      //受け取ったレスポンスからGithubRepositoryモデルを生成してください
      do {
        let githubRepository = try JSONDecoder().decode(GithubRepository.self, from: _data)
        completion?(githubRepository, nil)
      } catch(let e) {
        completion?(nil, GithubError.decodeFailed(e))
      }
    }.resume()
  }
}

GithubAPI.shared.requestRepositories(searchWork: "iOS") { (repository, error) in
  if let _error = error {
    print(_error.title)
    return
  }
  guard let _repositoryItems = repository?.items else {
    print(GithubError.unknown.title)
    return
  }

  for item in _repositoryItems {
    print(item.fullName ?? "")
    print(item.htmlUrl ?? "")
    print("-----------")
  }
}
