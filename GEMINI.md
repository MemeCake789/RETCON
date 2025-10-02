# Project Overview

This project is a 2D shooter game developed using the Godot Engine. The game features a player character with advanced movement mechanics, a mouse-controlled gun, and a simple enemy.

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
*   **`gun.gd`**: Controls the gun's rotation, offset, and shooting mechanics.
*   **`CameraController.gd`**: Implements camera effects, such as tilt and mouse-based offset.

# Building and Running

To run the project, open it in the Godot Engine and press the "Play" button.

# Development Conventions

## Coding Style

The code follows the standard GDScript style guidelines.

## Testing

There are no explicit tests in the project.

## Contribution Guidelines

There are no explicit contribution guidelines in the project.
