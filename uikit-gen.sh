#!/bin/bash

MODULE_NAME=""
OUTPUT_PATH="."
USAGE_MESSAGE="Usage: uikit-gen [-n | --name] <ModuleName> [-p | --path <DirectoryPath>]"

while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
  -n | --name)
    MODULE_NAME="$2"
    shift
    shift
    ;;
  -p | --path)
    OUTPUT_PATH=$2
    shift
    shift
    ;;
  *)

    echo "Error: Unknown option '$1'"
    echo "$USAGE_MESSAGE"
    exit 1
    ;;
  esac
done

if [ -z "$MODULE_NAME" ]; then
  echo "Error: No module name specified."
  echo "$USAGE_MESSAGE"
  exit 1
fi

# --- Sanitize MODULE_NAME make sure it's capitalized on first letter ---
MODULE_NAME=$(echo "${MODULE_NAME}" | awk '{print toupper(substr($0,1,1)) substr($0,2)}')

PROJECT_NAME=$(basename "$(pwd)")
FULL_MODULE_PATH="$OUTPUT_PATH/$MODULE_NAME"

echo "🚀 Generating module: $MODULE_NAME at $FULL_MODULE_PATH"

mkdir -p "$FULL_MODULE_PATH"

# --- File paths ---
PROTOCOL_FILE="$FULL_MODULE_PATH/${MODULE_NAME}ViewModelProtocol.swift"
VIEWMODEL_FILE="$FULL_MODULE_PATH/${MODULE_NAME}ViewModel.swift"
CONTROLLER_FILE="$FULL_MODULE_PATH/${MODULE_NAME}ViewController.swift"
VIEW_FILE="$FULL_MODULE_PATH/${MODULE_NAME}View.swift"

# --- Create and populate the ViewModelProtocol file ---
cat <<EOF >"$PROTOCOL_FILE"
//
//  ${MODULE_NAME}ViewModelProtocol.swift
//  ${PROJECT_NAME}
//
//  Created by $(whoami) on $(date +"%d/%m/%Y").
//

import Foundation

protocol ${MODULE_NAME}ViewModelDelegate: AnyObject {
    // TODO: Define your view model delegate methods here
}

protocol ${MODULE_NAME}ViewModelAction: AnyObject {
    // TODO: Define your view model action delegate methods here
}

protocol ${MODULE_NAME}ViewModelProtocol: AnyObject {
    // TODO: Define your protocol properties and methods here
    var actionDelegate: ${MODULE_NAME}ViewModelAction? { get set }

    func onViewDidLoad()
}
EOF

# --- Create and populate the ViewModel file ---
cat <<EOF >"$VIEWMODEL_FILE"
//  
//  ${MODULE_NAME}ViewModel.swift
//  ${PROJECT_NAME}
//  
//  Created by $(whoami) on $(date +"%d/%m/%Y").
//

import Foundation

final class ${MODULE_NAME}ViewModel {
    weak var actionDelegate: ${MODULE_NAME}ViewModelAction?

    init() { 
        // TODO: Setup your ViewModel initialization
    }
}

extension ${MODULE_NAME}ViewModel: ${MODULE_NAME}ViewModelProtocol {
    func onViewDidLoad() {
        // TODO: Setup your viewDidLoad() configuration
    }
}
EOF

# --- Create and populate Controller file ---
cat <<EOF >"$CONTROLLER_FILE"
//
//  ${MODULE_NAME}ViewController.swift
//  ${PROJECT_NAME}
//  
//  Created by $(whoami) on $(date +"%d/%m/%Y").
//  

import Foundation
import UIKit

final class ${MODULE_NAME}ViewController: UIViewController {
    init(viewModel: ${MODULE_NAME}ViewModelProtocol) {
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

    private let viewModel: ${MODULE_NAME}ViewModelProtocol
    private let thisView: ${MODULE_NAME}View = .init()
}

extension ${MODULE_NAME}ViewController: ${MODULE_NAME}ViewModelAction {
    // TODO: Implement ${MODULE_NAME}ViewModelAction protocol here
}
EOF

cat <<EOF >"$VIEW_FILE"
//
//  ${MODULE_NAME}View.swift
//  ${PROJECT_NAME}
//
//  Created by $(whoami) on $(date +"%d/%m/%Y").
//

import UIKit

final class ${MODULE_NAME}View: UIView {
    override init(frame: CGRect) {
      super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ${MODULE_NAME}View {
    private func setupView() {
      // TODO: Setup your view here
    }
}
EOF

echo "✅ Successfully created module $MODULE_NAME at $FULL_MODULE_PATH!"
