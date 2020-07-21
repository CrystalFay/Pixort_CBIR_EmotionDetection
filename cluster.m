
function varargout = cluster(varargin)
% CLUSTER MATLAB code for cluster.fig
%      CLUSTER, by itself, creates a new CLUSTER or raises the existing
%      singleton*.
%
%      H = CLUSTER returns the handle to a new CLUSTER or the handle to
%      the existing singleton*.
%
%      CLUSTER('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLUSTER.M with the given input arguments.
%
%      CLUSTER('Property','Value',...) creates a new CLUSTER or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before cluster_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to cluster_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help cluster

% Last Modified by GUIDE v2.5 24-May-2020 20:03:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @cluster_OpeningFcn, ...
                   'gui_OutputFcn',  @cluster_OutputFcn, ...
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


% --- Executes just before cluster is made visible.
function cluster_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to cluster (see VARARGIN)

% Choose default command line output for cluster
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

handles = guidata(hObject);
handles.x = 0;
handles.xx=0;
guidata(hObject,handles);

% UIWAIT makes cluster wait for user response (see UIRESUME)
% uiwait(handles.figure1);



% --- Outputs from this function are returned to the command line.
function varargout = cluster_OutputFcn(hObject, eventdata, handles) 
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

handles = guidata(hObject);
valueF = handles.x;
guidata(hObject,handles);

if(valueF==0)
    msgbox 'Select the dataset folder!';
else

handles = guidata(hObject);
handles.xx=1;
guidata(hObject,handles);
    
clc;
delete 'C:\matlab\pixort\correlation\happy\*.jpg';
delete 'C:\matlab\pixort\correlation\sad\*.jpg';
name=get(handles.edit1,'String');
aaa='C:\matlab\pixort\';
bbb=strcat(aaa,name);
ccc='\';
ddd=strcat(bbb,ccc);
ddd



if isempty(name)
	msgbox 'Enter a folder name!';
	return
end
exist(sprintf(name),'dir')
if ans==7
	msgbox 'Folder with same name already exists!';
	return
end

if ~isempty(regexp(name,'[*:/~!@#$%^&+-\?"<>|]','once'))
	msgbox 'Enter a valid folder name!';
	return
end

mkdir(name);
[f,p] = uigetfile('C:\matlab\pixort\face\*.jpg;*.png');
I = imread([p f]);
x = imresize(I,[60 60]);
global templates
global templates2

%%
dim=ndims(x);

if(dim==3)
    x=rgb2gray(x);
end
 y = rgb2lab( repmat(x, [1 1 3]));
 cform = makecform('srgb2lab');
lab = applycform(y,cform); 


% figure('name','Input Image & L*a*b Color space Result');
% subplot(121);imshow(I,[]);title('Input RGB image');
% subplot(122);imshow(lab);title('L*a*b color space result');

ll = lab(:,:,1);
aa = lab(:,:,2);
bb = lab(:,:,3);

a = ll;
[m,n] = size(a);  
for i = 2:m-1
    for j = 2:n-1
        b = a(i-1:i+1,j-1:j+1);
        B(i-1:i+1,j-1:j+1) = LBP(b);
    end
end
% figure,imshow(B); impixelinfo;
% title('Local Binary Patterns');
tf=1;

B=uint8(B);

load templates
% disp('inside function')

num_imgs=size(templates,2);
comp=[ ];
for n=1:num_imgs %for databse images
    sem=corr2(templates{1,n},B);
    comp=[comp sem];
end


vd=find(comp==max(comp))
%*-*-*-*-*-*-*-*-*-*-*-*-*-
if vd<=21
    disp('Archana');
      x1=1;
elseif vd<=37
    disp('Chandrakanth');
        x1=2;
elseif vd<=100
    disp('Cheryl');
        x1=3;
elseif vd<=134
    disp('Crystal');
        x1=4;
elseif vd<=159
    disp('Job');
        x1=5;
elseif vd<=211
    disp('Krithi');
        x1=6;
elseif vd<=234
    disp('Manish');
        x1=7;
elseif vd<=287
    disp('Mariah');
        x1=8;
elseif vd<=305
    disp('Sahil');
        x1=9;
elseif vd<=851
    disp('Unidentified');
    msgbox 'Cannot recognize face. Select another!';
        x1=10;
else
    disp('Unidentified');
    msgbox 'Cannot recognize face. Select another!';
        x1=10;
end


if x1~=10

%Detect objects using Viola-Jones Algorithm

%To detect Face
    FDetect = vision.CascadeObjectDetector;
    count=1;
    count1=1;
% ShapeI=vision.ShapeInserter('BorderColor','Custom','CustomBorderColor',[0 255 0]);
%Read the input image
% I = imread('img4.jpg');

    handles = guidata(hObject);
    images = handles.y;

    if isempty(images)
        msgbox 'Please select a folder!';
        return
    end


guidata(hObject,handles);
halls = images;

jpgfiles=dir(fullfile(images,'\*.jpg*'));
for i3=1:length(jpgfiles) % we have 16 images we have in or folder

    
    images =halls;
    jpgfiles=dir(fullfile(images,'\*.jpg*'));
    
    
    im2=jpgfiles(i3).name;
    image=imread(fullfile(images,im2));



%Returns Bounding Box values based on number of objects
    BB = step(FDetect,image);
% face=step(ShapeI,I,int32(BB));%  face=imcrop(I,BB);
    figure(1),imshow(image);
    tf = isempty(BB) %check if face is detected
    if(tf==0)
% figure(1),imshow(face);
% impixelinfo; hold on

        for i2 = 1:size(BB,1)
%     rectangle('Position',BB(i,:),'LineWidth',3,'LineStyle','-','EdgeColor','b');
            face=imresize(imcrop(image,BB(i2,:)),[60 60]);
            dim=ndims(face);

            if(dim==3)
                face=rgb2gray(face);
            end
             y1 = rgb2lab( repmat(face, [1 1 3]));
            cform = makecform('srgb2lab');
            lab = applycform(y1,cform); 
 

% figure('name','Input Image & L*a*b Color space Result');
% subplot(121);imshow(I,[]);title('Input RGB image');
% subplot(122);imshow(lab);title('L*a*b color space result');

            ll2 = lab(:,:,1);
            aa2 = lab(:,:,2);
            bb2 = lab(:,:,3);

            a1 = ll2;
            [m,n] = size(a1);  
            for i1 = 2:m-1
                for j1 = 2:n-1
                     b1 = a1(i1-1:i1+1,j1-1:j1+1);
                     B1(i1-1:i1+1,j1-1:j1+1) = LBP(b1);
                end
            end
% figure,imshow(B); impixelinfo;
% title('Local Binary Patterns');
            tf=1;

            B1=uint8(B1);

            load templates
% disp('inside function')

            num_img=size(templates,2);
            comp1=[ ];
            for n=1:num_img %for databse images
                sem1=corr2(templates{1,n},B1);
                comp1=[comp1 sem1];
            end

            vd1=find(comp1==max(comp1))
%*-*-*-*-*-*-*-*-*-*-*-*-*-
            if vd1<=21
                disp('Archana');
                myString=sprintf('Archana');
                set(handles.text2,'String',myString);
                y1=1;
            elseif vd1<=37
                disp('Chandrakanth');
                myString=sprintf('Chandrakanth');
                set(handles.text2,'String',myString);
                y1=2;
            elseif vd1<=100
                disp('Cheryl');
                myString=sprintf('Cheryl');
                set(handles.text2,'String',myString);
                y1=3;
            elseif vd1<=134
                disp('Crystal');
                myString=sprintf('Crystal');
                set(handles.text2,'String',myString);
                y1=4;
            elseif vd1<=159
                disp('Job');
                myString=sprintf('Job');
                set(handles.text2,'String',myString);
                y1=5;
            elseif vd1<=211
                disp('Krithi');
                myString=sprintf('Krithi');
                set(handles.text2,'String',myString);
                y1=6;
            elseif vd1<=224
                disp('Manish');
                myString=sprintf('Manish');
                set(handles.text2,'String',myString);
                y1=7;
            elseif vd1<=287
                disp('Mariah');
                myString=sprintf('Mariah');
                set(handles.text2,'String',myString);
                y1=8;
            elseif vd1<=305
                disp('Sahil');
                myString=sprintf('Sahil');
                set(handles.text2,'String',myString);
                y1=9;
            elseif vd1<=851
                disp('Unidentified');
                myString=sprintf('Unidentified');
                set(handles.text2,'String',myString);
                y1=10;
            else
                disp('Unidentified');
                y1=10;
            end

            if x1==y1

                 load templates2
% disp('inside function')

                num_img1=size(templates2,2);
                comp2=[ ];
                for n1=1:num_img1 %for databse images
                        sem2=corr2(templates2{1,n1},B1);
                        comp2=[comp2 sem2];
                end
                vd2=find(comp2==max(comp2))
                if vd2<=246
                        imwrite(image,['C:\matlab\pixort\correlation\happy\img' int2str(count),'.jpg']);
                        imwrite(image,[ddd int2str(count),'.jpg']);
                        count=count+1;
                elseif vd2<=305
                        imwrite(image,['C:\matlab\pixort\correlation\sad\img' int2str(count1),'.jpg']);
                        count1=count1+1;
                end
            end
        end
    end
end
if exist('correlation\happy\img1.jpg')
image1=imread('correlation\happy\img1.jpg');
axes(handles.axes1);
imshow(image1);
end

if exist('correlation\happy\img2.jpg')
image2=imread('correlation\happy\img2.jpg');
axes(handles.axes2);
imshow(image2);
end

if exist('correlation\sad\img1.jpg')
image3=imread('correlation\sad\img1.jpg');
axes(handles.axes3);
imshow(image3);
end

if exist('correlation\sad\img2.jpg')
image4=imread('correlation\sad\img2.jpg');
axes(handles.axes4);
imshow(image4);

end
end
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles = guidata(hObject);
valueH = handles.xx;
guidata(hObject,handles);
if (valueH==1)

winopen('C:\matlab\pixort\correlation\happy\');
else
    msgbox 'Please select a face!';
end

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = guidata(hObject);
valueS = handles.xx;
guidata(hObject,handles);
if (valueS==1)

winopen('C:\matlab\pixort\correlation\sad\');
else
    msgbox 'Please select a face!';
end


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


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
yas=uigetdir;

handles = guidata(hObject);
handles.y = yas;
guidata(hObject,handles);

handles = guidata(hObject);
handles.x =1;
guidata(hObject,handles);
