# AudioPlayer.gd

## Overview

The `AudioPlayer` script extends the `AudioStreamPlayer2D` class in the Godot game engine. This handles 2D audio playback. 

## Class Definition 
```gdscript
extends AudioStreamPlayer2D
```
This script extends `AudioStreamPlayer2D` class, indicating that it inherits functionality from the parent class.

## Methods
`_ready()`  
This is called when the node enters the scene tree for the first time.  
It is typically used for initializtion and setup tasks.

`_process(delta)`
This method is automatically called every frame.  

The parameter `delta` represents the time elapsed since the previous frame.  
This is used for continuous updates and game logics that requires running every frame.

## Usage
In order to use the `AudioPlayer` script, attach it to a node in your Godot scene that requires 2D audio playback functionalilty. Ensure that the necessary audio files are assigned to the `AudioStream` property of the `AudioStreamPlayer2D` node.


