import SwiftUI

/// Use a `ModalPresentationButton` to display a control for presenting content
/// full-screen. Like `NavigationButton`, the modal presentation button also
/// defines the destination content to be presented.
public struct ModalPresentationButton<Destination: View, Label: View>: View {
  @Environment(\.modalPresentationAction) private var _present

  private let destination: Destination
  private let label: Label

  /// Create a `ModalPresentationButton` by providing its `destination` and
  /// `label`.
  ///
  /// - parameters:
  ///     - destination: The destination content to be presented full screen.
  ///     - label: The content for the button's label.
  public init(destination: Destination, @ViewBuilder _ label: () -> Label) {
    self.destination = destination
    self.label = label()
  }

  public var body: some View {
    Button(action: present) {
      label
    }
  }

  private func present() {
    _present(AnyView(destination))
  }
}
