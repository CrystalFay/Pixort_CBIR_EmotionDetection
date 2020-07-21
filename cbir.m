function varargout = cbir(varargin)
% CBIR MATLAB code for cbir.fig
%      CBIR, by itself, creates a new CBIR or raises the existing
%      singleton*.
%
%      H = CBIR returns the handle to a new CBIR or the handle to
%      the existing singleton*.
%
%      CBIR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CBIR.M with the given input arguments.
%
%      CBIR('Property','Value',...) creates a new CBIR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cbir_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cbir_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cbir

% Last Modified by GUIDE v2.5 23-May-2020 19:02:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cbir_OpeningFcn, ...
                   'gui_OutputFcn',  @cbir_OutputFcn, ...
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


% --- Executes just before cbir is made visible.
function cbir_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cbir (see VARARGIN)

% Choose default command line output for cbir
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
handles=guidata(hObject);
handles.Imgdata=0;
guidata(hObject,handles);

% UIWAIT makes cbir wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = cbir_OutputFcn(hObject, eventdata, handles) 
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
delete 'C:\matlab\cheryl project\identified\*.jpg';
%global I
[f,p] = uigetfile('*.jpg;*.png');
I = imread([p f]);
% handles.ImgData = I;
I = imresize(I,[256 256]);
handles.ImgData = I;
guidata(hObject,handles);






% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%global I
handles = guidata(hObject);
I=handles.ImgData;
guidata(hObject,handles);


name=get(handles.edit2,'String');
aaa='C:\matlab\cheryl project\';
bbb=strcat(aaa,name);
ccc='\';
ddd=strcat(bbb,ccc);

if isempty(name)
	msgbox 'Enter a folder name!';
	return
end

exist(sprintf(name),'dir')
if ans==7
	msgbox 'Folder with same name already exists!';
	return
end

if ~isempty(regexp(name, '[*:/\?"<>|]', 'once'))
	msgbox 'Enter valid folder name!';
	return
end

if I==0
    msgbox 'Upload Query Image';
    return
end

mkdir(name);
im = I;
R = im(:,:,1);   
G = im(:,:,2);
B = im(:,:,3);

% figure('name','Input Image result');  
% subplot(221);imshow(I,[]);title('Input Image');
% subplot(222);imshow(R,[]);title('Red band Image');
% subplot(223);imshow(G,[]);title('Green band Image');
% subplot(224);imshow(B,[]);title('Blue Image');

cform = makecform('srgb2lab');
lab = applycform(I,cform); 

% figure('name','Input Image & L*a*b Color space Result');
% subplot(121);imshow(I,[]);title('Input RGB image');
% subplot(122);imshow(lab);title('L*a*b color space result');

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);

a = ll;
[m,n] = size(a); 
m
n
for i = 2:m-1
    for j = 2:n-1
        b = a(i-1:i+1,j-1:j+1);
        B(i-1:i+1,j-1:j+1) = LBP(b);
    end
end
disp 'Going on';
figure,imshow(B); impixelinfo;
title('Local Binary Patterns');
lbp = mean(mean(B))
data = lbp;

 
   load net_cbir2
     x = round(sim(net_cbir2,data ));
x
if x==1
    
    myString=sprintf('Burger');
    set(handles.text2,'String',myString);
elseif x==2
    myString=sprintf('Cat');
    set(handles.text2,'String',myString);
elseif x==3
myString=sprintf('Dog');
    set(handles.text2,'String',myString);
elseif x==4
myString=sprintf('Pizza');
    set(handles.text2,'String',myString);
else
    myString=sprintf('Unidentified');
    set(handles.text2,'String',myString);
end
    
% %  count=0;
 k=1;
images=uigetdir;
jpgfiles = dir(fullfile(images,'\*.jpg*'));
for i=1:length(jpgfiles); % we have 16 images we have in or folder
    images ='C:\matlab\cheryl project\dataset';
    jpgfiles=dir(fullfile(images,'\*.jpg*'));

    im1=jpgfiles(i).name;
    im2=imread(fullfile(images,im1));

    I = imresize(im2,[256 256]);
       
    im = I;
%     R = im(:,:,1);
%     G = im(:,:,2);
%     B = im(:,:,3);

   
    cform = makecform('srgb2lab');
    lab = applycform(I,cform); 

    ll = lab(:,:,1);
    aa = lab(:,:,2);
    bb = lab(:,:,3);

    a1 = ll;
    [m1,n1] = size(a1);  
    for i1 = 2:m1-1
        for j1 = 2:n1-1
            b1 = a1(i1-1:i1+1,j1-1:j1+1);
            B1(i1-1:i1+1,j1-1:j1+1) = LBP(b1);
        end
    end
   

    lbp = mean(mean(B1));
    data1 = lbp
    y = round(sim(net_cbir2,data1 ));
    y
    ddd
        if y==x
        imwrite(im2,['C:\matlab\cheryl project\identified\IMG' int2str(k), '.jpg']);
        imwrite(im2,[ddd int2str(k), '.jpg']);
	k=k+1;
    end

i
end

if exist ('identified\IMG1.jpg','file')
    image1=imread('identified\IMG1.jpg');
    axes(handles.axes1);
imshow(image1);
end
if exist('identified\IMG2.jpg','file')
    image2=imread('identified\IMG2.jpg');
    axes(handles.axes2);
imshow(image2);
end
if exist('identified\IMG3.jpg','file')
    image3=imread('identified\IMG3.jpg');
    axes(handles.axes3);
imshow(image3);
end
if exist('identified\IMG3.jpg','file')
    image4=imread('identified\IMG4.jpg');
    axes(handles.axes4);
imshow(image4);
end

% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
winopen('C:\matlab\cheryl project\identified\');


function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double

% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
