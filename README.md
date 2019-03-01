# lbnc-cellfree2
This repository contains LabVIEW code to control the `cellfree2` microchemostat setup at [LBNC-EPFL](http://lbnc.epfl.ch). The setup consists of three modules:

* Nikon Ti2 Eclipse microscope with motorised XYZ-stage
* Hamamatsu Orca-Flash4.0 digital CMOS camera 
* Electric solenoid valves for actuating microfluidic control lines, connected to a relay board

The code is likewise divided into modules for independently controlling the microscope stage, image acquisition, and solenoid valves. Interfacing with the Ti2 microscope is done using a Matlab-Micro-Manager layer. The VI allows for automated time-lapse imaging, pumping, mixing, and programmable dilution of the microchemostat chip described in [Niederholtmeyer et al. 2013](http://lbnc.epfl.ch) and [Niederholtmeyer et al. 2015](https://elifesciences.org/articles/09771). 

The setup has been tested with the following software:

* LabVIEW 2018 Version 18.0f2 (64-bit)
* Matlab R2018b 64-bit
* [Micro-Manager V2.0beta3](https://valelab4.ucsf.edu/~MM/nightlyBuilds/2.0.0-beta/Windows/) build 20190201 - V2.0 or higher is required.
* [Nikon Ti2 Control](https://www.nikon.com/products/microscope-solutions/support/download/software/biological/ti2_win_v210_64bit.htm) version 2.10.70, 64-bit - Windows drivers for Nikon Ti2 
* [Hamamatsu DCAM-API](https://dcam-api.com/) 19.1.5703 - Windows drivers for Hamamatsu camera
* [Hamamatsu HVC_4418 Video Capture library](https://dcam-api.com/hamamatsu-software/) - LabVIEW interface to Hamamatsu camera
* Windows 10

---
## Installation

First install the required software. LabVIEW and Matlab are used to control the setup. The microscope requires Micro-Manager as well as Nikon Ti2 Control. The camera requires the DCAM-API drivers and the HVC_4418 LabVIEW interface. 

### 1. Connect to microscope

1. Test the microscope connection using Ti2 Control: there should be no errors. 
2. Copy the library `Ti2_Mic_Driver.dll`, installed by Ti2 Control, to the main Micro-Manager folder. 
3. Run Micro-Manager, add the microscope and generate a cfg file. Further instructions are found on the [Micro-Manager](https://micro-manager.org/wiki/NikonTi2) website.

### 2. Setting up the Matlab interface

1. In Matlab run command `edit([prefdir '/javaclasspath.txt']);` to first create, then edit javapaths for Matlab. Add the following paths to the `javaclasspath.txt` file (actual paths will depend on your setup):
    * C:\Program Files\Micro-Manager-2.0beta\ij.jar                                                             
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\MMAcqEngine.jar                              
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\MMCoreJ.jar                                  
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\MMJ_.jar                                     
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\clojure.jar                                  
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\bsh-2.0b4.jar                                
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\swingx-0.9.5.jar                             
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\swing-layout-1.0.4.jar                       
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\commons-math-2.0.jar                         
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\ome-xml.jar                                  
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\scifio.jar                                   
    * C:\Program Files\Micro-Manager-2.0beta\plugins\Micro-Manager\guava-17.0.jar
2. Run command `edit librarypath.txt` and add the following path:
    * C:\Program Files\Micro-Manager-2.0beta
3. Add the location of Micro-Manager's dlls to a new Windows path variable: `(Start->Settings->Control Panel->System->Advanced->Environment Variables`, make a new 'User variable for Administrator' named `PATH` and set it to the location of Micro-Manager (for instance: C:\Program Files\Micro-Manager-2.0beta).
4. Matlab should now be able to access the Micro-Manager MMCore library. Run the following to import MMCore, load a configuration, and shut down the microscope:

```matlab
	import mmcorej.*;
	mmc=CMMCore;
	mmc.loadSystemConfiguration('C:\Program Files\Micro-Manager-2.0beta\TI2_V1.cfg');
	mmc.unloadAllDevices()
```
The system configuration path should point to the cfg file you generated when first setting up the microscope. An example cfg file and matlab test script can be found in the `/matlab/` subfolder of this repository.

More information for this step can be found on the [Micro-Manager website](https://micro-manager.org/wiki/Matlab_Configuration). 

### 3. Linking LabVIEW and Matlab

1. Open up the main VI `NikonTI2_Hama_valves_V1.vi`. Check that the Hamamatsu LabVIEW interface has installed correctly. There are then two links which must be made.
2. Set the name of the USB-serial interface to the valves' relay board (default value is `COM4` but this will change depending on the individual machine).
3. Set the path to the Micro-Manager cfg file in the `matlab_TI2_init.vi` subVI.

