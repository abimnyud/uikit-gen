#!/bin/bash

# Test function
test_uikit_gen() {
  # Run the script
  ./uikit-gen.sh -n TestModule -p test_output

  # Check if the files were created
  if [ ! -f "test_output/TestModule/TestModuleView.swift" ]; then
    echo "❌ Test failed: TestModuleView.swift was not created."
    exit 1
  fi
  if [ ! -f "test_output/TestModule/TestModuleViewController.swift" ]; then
    echo "❌ Test failed: TestModuleViewController.swift was not created."
    exit 1
  fi
  if [ ! -f "test_output/TestModule/TestModuleViewModel.swift" ]; then
    echo "❌ Test failed: TestModuleViewModel.swift was not created."
    exit 1
  fi
  if [ ! -f "test_output/TestModule/TestModuleViewModelProtocol.swift" ]; then
    echo "❌ Test failed: TestModuleViewModelProtocol.swift was not created."
    exit 1
  fi

  # Clean up
  rm -rf test_output

  echo "✅ Test passed!"
}

# Run the test
test_uikit_gen
