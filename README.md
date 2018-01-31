# MultiMC Import Updater

MultiMC Import Updater is a small Linux script to simply using modpacks with MultiMC.

---
### Overview
If you use MultiMC for modpacks like Feed the Beast, Age of Engineering, or any others, you may find it tedious to manually transfer each customized file from each version to version. This script simplifies your life by allowing you to automatically transfer all of your personalized files from one modpack version to another!

---
#### What does this script transfer?
  - Config Files: all custom config that doesn't need to be overriden is kept*
  - User-Added Mods: any custom added, non-pack mods like Optifine are automatically transfered
  - Optifine Settings
  - Controls
  - Saves
  - Resource Packs
  - Screenshots
  - Journeymap Data

\* ʸᵒᵘʳ ᵐⁱˡᵉᵃᵍᵉ ᵐᵃʸ ᵛᵃʳʸ

---
### Usage
Placing the script in the MultiMC instances directory is recommended for ease of use.
    
    ./updateInstance.sh <old instance folder> <new instance folder>
    
That's it! All of your personalized data is now transfered to your new instance. If your data didn't get transfered for a particular mod, make an issue report and I'll implement that mod.