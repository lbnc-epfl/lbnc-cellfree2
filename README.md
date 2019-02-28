# lbnc-cellfree2
This repository contains LabVIEW code to control the `cellfree2` microchemostat setup at [LBNC-EPFL](http://lbnc.epfl.ch). The setup consists of three modules:

* Nikon Ti2 Eclipse microscope with motorised XYZ-stage
* Hamamatsu Orca-Flash4.0 digital CMOS camera 
* Electric solenoid valves for actuating microfluidic control lines, connected to a relay board

The code is likewise divided into modules for independently controlling the microscope stage, image acquisition, and solenoid valves. Interfacing with the new Ti2 microscope is done using a Matlab-Micromanager layer. The VI allows for automated time-lapse imaging, pumping, mixing, and programmable dilution of the microchemostat chip described in [Niederholtmeyer et al. 2013](http://lbnc.epfl.ch) and [Niederholtmeyer et al. 2015](https://elifesciences.org/articles/09771). 
