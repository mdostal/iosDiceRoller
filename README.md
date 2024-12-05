# Dice Roller 

Dice Roller is a SwiftUI-based app with a basic screen to select dice and allow you to roll them.  The goal is to grow this to be a 3d dice roller and enable re-rolling and a number of other features

---

## Features

### 🎲 **Multiple Dice Types**
- Select from a variety of dice types:
  - D4, D6, D8, D10, D12, D20.
- Customize the number of each dice type to roll simultaneously.

### 🌀 **Realistic 3D Dice**
- Each die type is represented by a corresponding 3D model using SceneKit.
- Unique geometries for each dice type:
  - **D4**: Pyramid  
  - **D6**: Cube  
  - **D8**: Octahedron  
  - **D10**: Pentagon-based approximation  
  - **D12**: Dodecagon  
  - **D20**: Icosahedron  


### 🛠️ **Customizable Setup**
- Easily select dice type and quantity from the intuitive interface.
- Add multiple dice types to a single roll for complex gaming scenarios.

### 📱 **SwiftUI Integration**
- Modern, clean design with interactive elements like roll buttons and customizable settings.

---

## Getting Started

### Prerequisites
- **Xcode 13** or later.
- **iOS 14.0** or later for deployment.

### Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/yourusername/DiceRoller3D.git
   ```
 2. Open the project in Xcode:
   ```bash
  open DiceRoller3D.xcodeproj
   ```
 3. Build and run the app on a simulator or a physical device.

----


****NOTE:**** 3D stuff hasn't been added yet, the below is the goal:

# Dice Roller 3D

Dice Roller 3D is a SwiftUI-based app with integrated SceneKit for a fully immersive dice-rolling experience. It allows users to roll multiple types of dice (D4, D6, D8, D10, D12, D20) with realistic 3D models and animations, perfect for tabletop gaming, RPGs, or just for fun!

---

## Features

### 🎲 **Multiple Dice Types**
- Select from a variety of dice types:
  - D4, D6, D8, D10, D12, D20.
- Customize the number of each dice type to roll simultaneously.

### 🌀 **Realistic 3D Dice**
- Each die type is represented by a corresponding 3D model using SceneKit.
- Unique geometries for each dice type:
  - **D4**: Pyramid  
  - **D6**: Cube  
  - **D8**: Octahedron  
  - **D10**: Pentagon-based approximation  
  - **D12**: Dodecagon  
  - **D20**: Icosahedron  

### 🎥 **Rolling Animation**
- Realistic rolling animations with random rotations using SceneKit’s `SCNAction`.
- Physics-based interactions (optional future enhancement).

### 🛠️ **Customizable Setup**
- Easily select dice type and quantity from the intuitive interface.
- Add multiple dice types to a single roll for complex gaming scenarios.

### 📱 **SwiftUI Integration**
- Seamlessly integrates SceneKit’s 3D rendering within a SwiftUI interface.
- Modern, clean design with interactive elements like roll buttons and customizable settings.

---


TODO:
[] Swap models to 3d
[] Add physics scene that rolls dice
[] Allow dice to have their colors changed / set
[] Add a tally so you know totals of each dice set, totals of all
[] Add a screen that shows the dice rolls entirely and allows you to re-roll ones you pick

