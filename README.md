# Hello Pong

A simple 2D Pong game built with Godot 4.4.

## How to Play

- **Left Paddle**: Use `W` (up) and `S` (down) keys
- **Right Paddle**: Use `↑` (up) and `↓` (down) arrow keys
- **Objective**: Keep the ball from passing your paddle
- **Scoring**: Score a point when the ball passes your opponent's paddle
- **Game Reset**: When a point is scored, the game automatically resets to the starting position

## Features

- Classic Pong gameplay
- Scoreboard system to track points
- Automatic game reset when someone scores
- Smooth paddle movement with screen boundary limits
- Ball physics with paddle angle-based deflection
- Visual center line divider
- Score display in the top corners

## Running the Game

1. Open the project in Godot 4.4
2. Press F5 or click the "Play" button to run the game
3. The game will start automatically after a 1-second delay

## Project Structure

```
hello-pong-godot/
├── scenes/
│   ├── Main.tscn      # Main game scene with UI
│   ├── Paddle.tscn    # Paddle scene
│   └── Ball.tscn      # Ball scene
├── scripts/
│   ├── Main.gd        # Main game logic and scoring
│   ├── Paddle.gd      # Paddle movement and controls
│   └── Ball.gd        # Ball physics and collision
├── project.godot      # Project configuration
└── README.md          # This file
```

## Controls Summary

- **W/S**: Left paddle movement
- **Arrow Keys**: Right paddle movement
- **F5**: Run the game (in Godot editor)

Enjoy playing Pong!
