import UIKit


class FilePrivateVsPrivate {
  private var privateContext: String {
    return "privateContext"
  }
  fileprivate var filePrivateContext: String {
    return "filePrivateContext"
  }
  
}

class SubFilePrivateVsPrivate : FilePrivateVsPrivate {
  func accessLevel() {
    // private 는 컴파일 오류
    //    print("private: \(privateContext)")
    print("filePrivateContext: \(filePrivateContext)")
  }
}


