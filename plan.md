### Inventory System Implementation Plan

This plan outlines the steps to create a 3-slot inventory system with hotkey access and a corresponding UI. The inventory will be initialized with three items at the start of the game.

- [x] **1. Project Setup & Input Mapping**
	- [x] Open the Godot project.
	- [x] Go to `Project` > `Project Settings` > `Input Map`.
	- [x] Add three new actions: `inventory_slot_1`, `inventory_slot_2`, and `inventory_slot_3`.
	- [x] Assign the '1', '2', and '3' keys to these actions, respectively.

- [x] **2. Inventory Data and Logic**
	- [x] Create a new script named `Inventory.gd`.
	- [x] In `Inventory.gd`, define an array to hold the inventory items.
	- [x] In the `_ready()` function, initialize the inventory with three predefined items.
	- [x] Create a function to handle the `_input` event and detect when the `inventory_slot_` actions are pressed.
	- [x] When a hotkey is pressed, update the currently selected slot and emit a signal (e.g., `selected_slot_changed`).

- [x] **3. Inventory UI Scene**
	- [x] Create a new scene for the inventory UI (e.g., `InventoryUI.tscn`).
	- [x] Add a `HBoxContainer` to the scene to hold the inventory slots.
	- [x] Inside the `HBoxContainer`, add three `Panel` or `TextureRect` nodes to represent the slots.
	- [x] Create a script for the UI (e.g., `InventoryUI.gd`).
	- [x] In the UI script, add logic to highlight the currently selected slot.

- [ ] **4. Integration**
	- [ ] Add the `Inventory.gd` script to the `Player` node (or a suitable parent node).
	- [ ] Instance the `InventoryUI.tscn` into the main game scene.
	- [ ] Connect the `selected_slot_changed` signal from `Inventory.gd` to a function in `InventoryUI.gd` that updates the UI.

- [ ] **5. Item Representation**
	- [ ] Define a custom resource for items (e.g., `ItemResource.gd`) with properties like `name` and `texture`.
	- [ ] Create three item resources with unique names and textures.
	- [ ] Update the `Inventory.gd` script to use these item resources.
	- [ ] Update the `InventoryUI.gd` script to display the item textures in the slots.

- [ ] **6. Testing**
	- [ ] Run the game and test the following:
		- [ ] Does the inventory initialize with the three items?
		- [ ] Can you select inventory slots with the '1', '2', and '3' keys?
		- [ ] Does the UI correctly highlight the selected slot?
		- [ ] Does the UI display the correct item textures?
