# ModalPresentationView

Takes the boilerplate out of managing modal presentations in SwiftUI.

## Background

SwiftUI currently provides two different ways to manage modal presentations:

* The simplest, [`PresentationButton`][presentation-button], accepts a
  `Destination` parameter and presents it over the current context. It doesn't
  provide a control for manual dismissal, instead appearing to rely on the
  interactive dismissal gesture that's part of the new default `.pageSheet`
  modal presentation style.

* Alternatively, the more powerful [`presentation(_:)` modifier][presentation-modifier]
  allows you to take control of the presentation state yourself, by accepting an
  optional parameter of type `Modal`.

`ModalPresentationView` sits in the middle, providing a
`ModalPresentationButton` control with the same API as `PresentationButton`,
but additionally:

* Unlike the `presentation(_:)` modifier, automatically manages the state of
  the modal via a new `ModalNavigationView`. If you're familiar with
  [`NavigationView`][navigation-view], then you already know how to use it.

* Provides for manual dismissal via `ModalDismissButton`, in addition to the
  existing interactive dismiss gesture.

[navigation-view]: https://developer.apple.com/documentation/swiftui/navigationview "Navigation view - Apple Developer Documentation"
[presentation-button]: https://developer.apple.com/documentation/swiftui/presentationbutton "Presentation button - Apple Developer Documentation"
[presentation-modifier]: https://developer.apple.com/documentation/swiftui/view/3278634-presentation "Presentation modifier - Apple Developer Documentation"

## Demo

![GIF showing a demo of modal presentation and dismissal](demo.gif)

## Example code

```swift
import ModalPresentationView
import SwiftUI

struct App: View {
  var body: some View {
    ModalPresentationView {
      ModalPresentationButton(destination: DetailScreen()) {
        Text("Present")
      }
    }
  }
}

struct DetailScreen: View {
  var body: some View {
    ModalDismissButton {
      Text("Dismiss")
    }
  }
}
```

## Installation

1. In Xcode, open your project and navigate to File > Swift Packages > Add Package Dependency...
2. Paste the repository URL and follow the prompts to add the library to your project.

## How does it work?

Internally, `ModalPresentationView` defines two custom environment keys, which
it then uses to communicate between the container and the buttons, regardless
of where they're placed in your view hierarchy.

* Firstly, `ModalPresentationView` injects a `present(_:)` closure into the
  environment using the `.modalPresentAction` key.

* When tapped, `ModalPresentationButton` reads the closure from the environment
  and calls it to notify `ModalPresentationView` to trigger a presentation. The
  presentation button passes the destination view into the closure by first
  wrapping it in an `AnyView`.

* `ModalPresentationView` updates its internal state to pass the destination
  view into the `presentation(_:)` view modifier. It also sets a `dismiss()`
  closure on the environment of the presented view using the
  `.modalDismissAction` environment key.

* Finally, `ModalDismissButton` reads the `dismiss()` closure from the
  environment and calls it when tapped, causing `ModalPresentationView` to
  update its internal state again and remove the presented modal.

## Contributing

See the [CONTRIBUTING][] document for details about how you can contribute.

[CONTRIBUTING]: CONTRIBUTING.md

## License

ModalPresentationView is Copyright (c) 2019 thoughtbot, inc.
It contains free software that may be redistributed
under the terms specified in the [LICENSE][] file.

[LICENSE]: LICENSE

## About

![thoughtbot](http://presskit.thoughtbot.com/images/thoughtbot-logo-for-readmes.svg)

ModalPresentationView is maintained by Adam Sharp and funded by thoughtbot, inc.
The names and logos for thoughtbot are trademarks of thoughtbot, inc.

We love open source software!
See [our other projects][community]
or [hire us][hire] to help build your product.

[community]: https://thoughtbot.com/community?utm_source=github
[hire]: https://thoughtbot.com/hire-us?utm_source=github
