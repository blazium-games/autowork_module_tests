# Autowork Module Tests

This repository contains the test suite and examples for the **Autowork** testing framework, a native C++ testing framework integrated directly into the Blazium engine.

Unlike traditional GDScript testing frameworks, Autowork binds its assertions and mocking systems directly in C++ via Godot's `ClassDB`, ensuring high performance, deep engine integration, and native reflection capabilities.

## Features

- **Native C++ Assertions:** Over 30+ assertions natively bound for maximum performance (`assert_eq`, `assert_between`, `assert_has_signal`, etc.).
- **Signal Tracking:** Built-in `watch_signals` to natively intercept and count signal emissions.
- **Mocking & Doubling:** Powerful API for stubbing methods, replacing nodes, and spying on object calls natively.
- **Orphan Node Detection:** Automatically detects leaked nodes during test execution.
- **Parameterized Testing:** Support for running a single test case multiple times with different grouped parameters.
- **Familiar API:** Designed with compatibility in mind, offering an API reminiscent of popular GDScript test frameworks but running at C++ speeds.

## Configuration

Autowork is configured using an `.autoworkconfig.json` file in the root of your project:

```json
{
    "dirs": ["res://tests"],
    "prefix": "test_",
    "suffix": ".gd",
    "include_subdirs": true,
    "hide_orphans": false
}
```

## Running Tests

To run the test suite, execution is triggered via a standard Godot script attached to your SceneTree (e.g., `run_tests.gd`).

```gdscript
extends SceneTree

func _initialize() -> void:
    # Instantiate the Autowork engine singleton
    var autowork = ClassDB.instantiate("Autowork")
    root.add_child(autowork)
    
    # Run tests based on .autoworkconfig.json
    autowork.run_tests()
    
    # Exit with the amount of failing tests
    quit(autowork.get_fail_count())
```

Execute your project from the command line in headless mode:
```bash
blazium --headless -s run_tests.gd
```

## Writing Tests

Test scripts must extend `AutoworkTest` and test function names must start with `test_` (or whatever prefix you configured).

### 1. Basic Assertions & Signals
```gdscript
extends AutoworkTest

signal my_custom_signal

func test_basic_math():
    assert_eq(5 + 5, 10, "Math works")
    assert_between(5, 1, 10, "5 is between 1 and 10")

func test_signals():
    watch_signals(self)
    my_custom_signal.emit()
    assert_signal_emitted(self, "my_custom_signal", "Signal was emitted successfully")
```

### 2. Parameterized Tests
```gdscript
extends AutoworkTest

func test_parameters(p = use_parameters([
    {"a": 1, "b": 2, "c": 3},
    {"a": 5, "b": -1, "c": 4}
])):
    assert_eq(p.a + p.b, p.c, "Testing parameterized math")
```

### 3. Mocking & Spying
```gdscript
extends AutoworkTest

class MyObject extends RefCounted:
    func get_name() -> String:
        return "Original"

func test_stubbing():
    var obj = MyObject.new()
    
    # Stubbing returns natively
    stub(obj, "get_name").to_return("StubbedName")
    
    # Spying on method calls
    spy(obj)
    obj.get_name()
    assert_called(obj, "get_name")
```

## Examples

You can find numerous comprehensive examples in the `tests/` directory of this repository:
- **`tests/core/test_basic.gd`**: Covers assertions, parameterization, aliases, properties, and edge cases.
- **`tests/mocking/test_mocking.gd`**: Covers stubbing, spying, and test doubles.
- **`tests/simulation/test_input_and_awaits.gd`**: Covers yielding (await) and simulating engine frames/time.
