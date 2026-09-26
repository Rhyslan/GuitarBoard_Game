# Guitar Board
![Static Badge](https://img.shields.io/badge/Godot-4.6-blue)
![GitHub License](https://img.shields.io/github/license/Rhyslan/GuitarBoard_Game)
![GitHub Release](https://img.shields.io/github/v/release/Rhyslan/GuitarBoard_Game)

A game created for the Swinburne University of Technology unit GAM30006 - Experimental Game Design. The prompt for this game was to make a game with "*Unique Input*". This game uses both a Wii guitar controller and a Wii balance board to control a top-down Vampire Survivors inspired game.

This game was developed by a team of 5 students in a period of 2 weeks.

## Getting Started
### Requirements
#### Hardware
- Windows 10/11 computer
- Wii guitar & Wii remote
- Wii balance board
#### Software
- [Godot 4.6.1](https://godotengine.org/download/archive/4.6.1-stable/)
- [WiiBalanceWalker v0.5](https://github.com/lshachar/WiiBalanceWalker)
- [WiitarThing](https://github.com/Meowmaritus/WiitarThing)

### Installation
#### Prebuilt Executable
1. Download the [latest release](https://github.com/Rhyslan/GuitarBoard_Game/releases/latest)
2. Download and setup both WiiBalanceWalker and WiitarThing
3. Run the Guitar Board executable

#### Godot Project
1. Clone the repository
2. Download Godot 4.6
2. Download and setup both WiiBalanceWalker and WiitarThing
3. Open the project in Godot and run the game

## Usage
The goal of the game is to kill as many enemies as possible. The Wii balance board is used for movement and the guitar is used to select and perform attacks and other actions. Actions need to be selected with one of the fret buttons on the guitar and then the selected action(s) are performed when the strum bar is pressed.

### Controls
| Action                 | Keyboard                        | Controller                   |
| ---------------------- | :-----------------------------: | :--------------------------: |
| Move Up                | ``W``                           | Balance Board Lean Forward   |
| Move Down              | ``S``                           | Balance Board Lean Backward  |
| Move Left              | ``A``                           | Balance Board Lean Left      |
| Move Right             | ``D``                           | Balance Board Lean Right     |
| Jump                   | ``Space``                       | Balance Board Jump/Lift Feet |
| Select Gun             | ``1``                           | ``Green``                    |
| Select Beam            | ``2``                           | ``Red``                      |
| Select Slash           | ``3``                           | ``Yellow``                   |
| Select Dash            | ``4``                           | ``Blue``                     |
| Select Shield          | ``5``                           | ``Orange``                   |
| Do selected action     | ``Left Arrow``, ``Right Arrow`` | ``Strum Up``, ``Strum Down`` |
| Reload                 | ``Left Shift``                  | ``Star Power``               |
| Spin Counter-Clockwise | ``Q``                           | ``Whammy Bar Fully Down``    |
| Spin Clockwise         | ``E``                           | ``Whammy Bar Fully Up``      |
