function varargout = emotion(varargin)
% EMOTION MATLAB code for emotion.fig
%      EMOTION, by itself, creates a new EMOTION or raises the existing
%      singleton*.
%
%      H = EMOTION returns the handle to a new EMOTION or the handle to
%      the existing singleton*.
%
%      EMOTION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EMOTION.M with the given input arguments.
%
%      EMOTION('Property','Value',...) creates a new EMOTION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before emotion_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to emotion_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help emotion

% Last Modified by GUIDE v2.5 24-May-2020 20:12:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @emotion_OpeningFcn, ...
                   'gui_OutputFcn',  @emotion_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before emotion is made visible.
function emotion_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to emotion (see VARARGIN)

% Choose default command line output for emotion
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles = guidata(hObject);
handles.y = 0;
handles.yy=0;
guidata(hObject,handles);

% UIWAIT makes emotion wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = emotion_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc;
delete 'C:\matlab\pixort\face\*.jpg';
global I
[f,p] = uigetfile('*.jpg;*.png');
I = imread([p f]);



handles = guidata(hObject);
handles.y =1;
guidata(hObject, handles);



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global I

handles = guidata(hObject);
valueP = handles.y;
guidata(hObject,handles);

if (valueP==0)
    msgbox 'Please enter query image!';
else


handles = guidata(hObject);
handles.yy = 1;
guidata(hObject,handles);



FDetect = vision.CascadeObjectDetector;
% I=imresize(I,[256 256]);
j=0;
BB = step(FDetect,I);
% face=step(ShapeI,I,int32(BB));%  face=imcrop(I,BB);
axes(handles.axes1);
imshow(I);
tf = isempty(BB) %check if face is detected
if(tf==0)
% figure(1),imshow(face);
% impixelinfo; hold on
for i = 1:size(BB,1)
    rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','b');
    
end


for i = 1:size(BB,1)
%     rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','b');
    face=imresize(imcrop(I,BB(i,:)),[60 60]);
%     figure;imshow(face,[]);
    imwrite(face,['C:\matlab\pixort\face\face' int2str(j), '.jpg']);
    j=j+1;
end
else
msgbox 'Cannot detect face. Select another image!';
end
end



% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





handles = guidata(hObject);
val = handles.y;
val1 = handles.yy;

if(val==1)
    if (val1==1)

        cluster;
    else
        msgbox 'Press Detect!';
    end

else
msgbox 'Upload query image!';
end

guidata(hObject,handles);
