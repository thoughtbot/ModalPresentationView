import SwiftUI

typealias _ScaledImage = Image.Modified<_EnvironmentKeyWritingModifier<Image.Scale>>

/// Use `ModalDismissButton` from within a modal presentation to provide a user
/// interface for dismissing modal content. If using the default presentation
/// style with interactive dismissal, `ModalDismissButton` isn't required in
/// order to dismiss the modal content, but is still recommended.
///
/// The default appearance of `ModalDismissButton` uses the `xmark` system image
/// and is configured with an accessility label of "Dismiss".
///
/// - Note: Interacting with a `ModalDismissButton` from outside a modal
///   presentation triggers an assertion failure.
public struct ModalDismissButton<Label: View>: View {
  @Environment(\.modalDismissAction) private var dismiss

  private let label: Label

  /// Create a `ModalDismissButton` with a custom label.
  public init(@ViewBuilder _ label: () -> Label) {
    self.label = label()
  }

  public var body: some View {
    Button(action: dismiss) {
      label
    }
  }
}

extension ModalDismissButton where Label == _ScaledImage.Modified<AccessibilityModifier> {
  /// Create a `ModalDismissButton` with the default appearance and
  /// accessibility label.
  public init() {
    self.init {
      Image(systemName: "xmark")
        .imageScale(.large)
        .accessibility(label: Text("Dismiss"))
    }
  }
}
