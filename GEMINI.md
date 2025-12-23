# Project Overview

This project is a 2D shooter game developed using the Godot Engine. The game features a player character with advanced movement mechanics, a mouse-controlled gun, and various enemies.

## Main Technologies

*   **Engine:** Godot Engine (version 4.5)
*   **Language:** GDScript

## Architecture

The project is structured as follows:

*   **`project.godot`**: The main project file, containing configuration settings and input mappings.
*   **`Scenes/`**: Contains the game's scenes, including the main `root.tscn` scene.
*   **`Scripts/`**: Contains the GDScript files that define the game's logic.
*   **`Assets/`**: Contains the game's assets, such as sprites and sounds.

### Key Scenes

*   **`root.tscn`**: The main scene, which brings together the player, the map, and the enemies.

### Key Scripts

*   **`PlayerController.gd`**: Manages player movement, including jumping, coyote time, and bunny hopping.
*   **`GunBehavior.gd`**: Controls the gun's rotation, offset, and shooting mechanics.
*   **`CameraController.gd`**: Implements camera effects, such as tilt and mouse-based offset.
*   **`Enemy.gd`**: Manages enemy health, damage, and animations.
*   **`Inventory.gd`**: Handles player inventory management, including cycling through items and updating the UI.
*   **`MessageBus.gd`**: Provides a centralized communication hub for game events, currently for UI updates like ammo.
*   **`root.gd`**: The main script for the `root.tscn`, currently a placeholder for global game logic.

# Current Task: Inventory System

We are currently implementing a 3-slot inventory system with hotkey access and a UI. The plan for this is tracked in `plan.md`.

The key features of the inventory system are:
*   Three inventory slots.
*   Hotkey access using '1', '2', and '3' keys.
*   A user interface to display the inventory.

# Building and Running

To run the project, open it in the Godot Engine and press the "Play" button.

# Development Conventions

## Coding Style

The code follows the standard GDScript style guidelines.

## Testing

There are no explicit tests in the project.

## Contribution Guidelines

There are no explicit contribution guidelines in the project.