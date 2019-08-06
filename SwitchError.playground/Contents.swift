import UIKit

enum CommonError {
  case a
  case b
  case c
}

let error = CommonError.a
switch error {
case is CommonError:
  print("CommonError")
default:
  print("Not commonError")
}

