%% Micro-Manager Initiation
import mmcorej.*;
mmc=CMMCore;
mmc.loadSystemConfiguration('C:\Program Files\Micro-Manager-2.0beta\Ti2_V2.cfg');

Devices = mmc.getLoadedDevices();

for i=1:size(Devices)
   Devices_list{i,1} = char(Devices.get(i-1)); 
end

%% XY Stage

% Get and move
x=mmc.getXPosition();
y=mmc.getYPosition();
z=mmc.getPosition();

move=0;
mmc.setXYPosition(x,y+move);

%% Shutter
% Init
handles.shutter = java.lang.String('Turret1Shutter');

% Set
mmc.setProperty(handles.shutter,'State',0);

%% Filter turret
% Init
handles.filter = java.lang.String('FilterTurret1');
handles.filter_1 = java.lang.String('1-');
handles.filter_2 = java.lang.String('2-');
handles.filter_3 = java.lang.String('3-');
handles.filter_4 = java.lang.String('4-');
handles.filter_5 = java.lang.String('5-');
handles.filter_6 = java.lang.String('6-');

% Set
mmc.setProperty(handles.filter,'Label',handles.filter_1);

%% DIA Lamp
% Init
handles.lamp = java.lang.String('DiaLamp');

% Set
mmc.setProperty(handles.lamp,'State',0);

%% Lightpath
% Init
handles.lightpath = java.lang.String('LightPath');
handles.lightpath_0 = java.lang.String('1-EYE');
handles.lightpath_1 = java.lang.String('2-R100');
handles.lightpath_2 = java.lang.String('3-AUX');
handles.lightpath_3 = java.lang.String('4-L100');

% Set
mmc.setProperty(handles.lightpath,'Label',handles.lightpath_0);

%% Shutdown
mmc.unloadAllDevices()
