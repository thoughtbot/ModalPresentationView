import SwiftUI

enum ModalDismissActionKey: EnvironmentKey {
  static var defaultValue: () -> Void {
    {
      assertionFailure("ModalDismissButton action triggered outside a modal presentation")
    }
  }
}

enum ModalPresentationActionKey: EnvironmentKey {
  static var defaultValue: (AnyView) -> Void {
    { _ in
      assertionFailure("ModalPresentationButton action triggered outside a ModalPresentationView")
    }
  }
}

public extension EnvironmentValues {
  var modalDismissAction: () -> Void {
    get { self[ModalDismissActionKey.self] }
    set { self[ModalDismissActionKey.self] = newValue }
  }

  var modalPresentationAction: (AnyView) -> Void {
    get { self[ModalPresentationActionKey.self] }
    set { self[ModalPresentationActionKey.self] = newValue }
  }
}
