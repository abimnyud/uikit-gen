# UIKit Component Module Generator

This is a simple shell script to automate the creation of a new UIKit component module. It generates the following files:
- `View`
- `ViewController`
- `ViewModel`
- `ViewModelProtocol`

## Installation

To install the script, you can use `curl` to download it and make it executable.

```bash
sudo curl -o /usr/local/bin/uikit-gen https://raw.githubusercontent.com/abimnyud/uikit-gen/main/uikit-gen.sh
sudo chmod +x /usr/local/bin/uikit-gen
```

After installation, you can use the `uikit-gen` command from anywhere in your terminal.

## Usage

To generate a new component module, use the `uikit-gen` command with the following options:

```bash
uikit-gen -n <ModuleName> [-p <DirectoryPath>]
```

### Options

- `-n` or `--name`: The name of the module to generate. The first letter will be capitalized automatically.
- `-p` or `--path`: The directory path where the module will be generated. If not specified, the module will be generated in the current directory.

### Example

To generate a new module named `Profile`, you can run the following command:

```bash
uikit-gen -n Profile
```

This will create a new directory named `Profile` in the current directory with the following files:

- `ProfileView.swift`
- `ProfileViewController.swift`
- `ProfileViewModel.swift`
- `ProfileViewModelProtocol.swift`

To generate the module in a specific directory, you can use the `-p` option:

```bash
uikit-gen -n Profile -p Views/
```

This will create the `Profile` module in the `Views/` directory.

## Generated Files

The generated files are based on the following templates:

### `ViewModelProtocol.swift`

```swift
//
//  <ModuleName>ViewModelProtocol.swift
//  <ProjectName>
//
//  Created by <Username> on <Date>.
//

import Foundation

protocol <ModuleName>ViewModelDelegate: AnyObject {
    // TODO: Define your view model delegate methods here
}

protocol <ModuleName>ViewModelAction: AnyObject {
    // TODO: Define your view model action delegate methods here
}

protocol <ModuleName>ViewModelProtocol: AnyObject {
    // TODO: Define your protocol properties and methods here
    var actionDelegate: <ModuleName>ViewModelAction? { get set }

    func onViewDidLoad()
}
```

### `ViewModel.swift`

```swift
//
//  <ModuleName>ViewModel.swift
//  <ProjectName>
//
//  Created by <Username> on <Date>.
//

import Foundation

final class <ModuleName>ViewModel {
    weak var actionDelegate: <ModuleName>ViewModelAction?

    init() {
        // TODO: Setup your ViewModel initialization
    }
}

extension <ModuleName>ViewModel: <ModuleName>ViewModelProtocol {
    func onViewDidLoad() {
        // TODO: Setup your viewDidLoad() configuration
    }
}
```

### `ViewController.swift`

```swift
//
//  <ModuleName>ViewController.swift
//  <ProjectName>
//
//  Created by <Username> on <Date>.
//

import Foundation
import UIKit

final class <ModuleName>ViewController: UIViewController {
    init(viewModel: <ModuleName>ViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.actionDelegate = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has nt been implemented")
    }

    override func loadView() {
        view = thisView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.onViewDidLoad()
    }

    private let viewModel: <ModuleName>ViewModelProtocol
    private let thisView: <ModuleName>View = .init()
}

extension <ModuleName>ViewController: <ModuleName>ViewModelAction {
    // TODO: Implement <ModuleName>ViewModelAction protocol here
}
```

### `View.swift`

```swift
//
//  <ModuleName>View.swift
//  <ProjectName>
//
//  Created by <Username> on <Date>.
//

import UIKit

final class <ModuleName>View: UIView {
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension <ModuleName>View {
    private func setupView() {
      // TODO: Setup your view here
    }
}
```
