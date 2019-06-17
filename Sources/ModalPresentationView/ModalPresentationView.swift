import SwiftUI

/// A view for presenting full screen content. After wrapping your content in
/// a `ModalPresentationView`, add a `ModalPresentationButton` to present your
/// modal content. Use `ModalDismissButton` from inside the modal presentation
/// in order to dismiss the full screen content.
public struct ModalPresentationView<Content: View>: View {
  @State private var presentedView: AnyView? = nil

  private let content: Content

  /// Create a `ModalPresentationView` that defines the context for presenting
  /// content full-screen.
  public init(@ViewBuilder _ content: () -> Content) {
    self.content = content()
  }

  public var body: some View {
    content
      .environment(\.modalPresentationAction, present)
      .presentation(modal)
  }

  private var modal: Modal? {
    guard let presentedView = presentedView else { return nil }
    return Modal(
      presentedView.environment(\.modalDismissAction, dismiss),
      onDismiss: dismiss
    )
  }

  private func present(_ view: AnyView) {
    presentedView = view
  }

  private func dismiss() {
    presentedView = nil
  }
}
