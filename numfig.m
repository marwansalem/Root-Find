function varargout = numfig(varargin)
% NUMFIG MATLAB code for numfig.fig
%      NUMFIG, by itself, creates a new NUMFIG or raises the existing
%      singleton*.
%
%      H = NUMFIG returns the handle to a new NUMFIG or the handle to
%      the existing singleton*.
%
%      NUMFIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NUMFIG.M with the given input arguments.
%
%      NUMFIG('Property','Value',...) creates a new NUMFIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before numfig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to numfig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help numfig

% Last Modified by GUIDE v2.5 15-Nov-2019 16:17:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @numfig_OpeningFcn, ...
                   'gui_OutputFcn',  @numfig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
               
               
syms x;
f(x) = x;
load_mode = 0;
func_str = '';
eps = 0.00001;
max_iter = 50;
roots =[];
root_str='';

          
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before numfig is made visible.
function numfig_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to numfig (see VARARGIN)

% Choose default command line output for numfig
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes numfig wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = numfig_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in calculate_button.
function calculate_button_Callback(hObject, eventdata, handles)
% hObject    handle to calculate_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
func_str = get(handles.function_input,'string');
eps = str2double(get(handles.epsilon_text,'string'));
max_iter = str2double(get(handles.max_iter_text,'string'));
f(x) = sym(func_str);
display('here')
fmethd = get(handles.bisect_button,'value')+2*get(handles.false_button,'value') +3*get(handles.fixed_button,'value') +4*get(handles.newton_button,'value')+5*get(handles.secant_button,'value');
set(handles.root_output,'string',f(3));
if fmethd ==1
    y=0;
elseif fmethd ==2
    y=1;
elseif fmethd ==3
    y=2;
elseif fmethd ==4
    y=3;
elseif fmethd ==5
    y=4;
end 

function function_input_Callback(hObject, eventdata, handles)
% hObject    handle to function_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of function_input as text
%        str2double(get(hObject,'String')) returns contents of function_input as a double


% --- Executes during object creation, after setting all properties.
function function_input_CreateFcn(hObject, eventdata, handles)
% hObject    handle to function_input (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in load_button.
function load_button_Callback(hObject, eventdata, handles)
% hObject    handle to load_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
load_mode = 1;
[file,path] = uigetfile('*.*');
full_path = strcat(path,file);
file_id =fopen(full_path,'r');
func_str = fgetl(file_id);
max_iter = fgetl(file_id);
eps = fgetl(file_id) 
set(handles.function_input,'string',func_str);
set(handles.max_iter_text,'string',max_iter);
set(handles.epsilon_text,'string',eps);
eps = str2double(eps);
max_iter = str2double(max_iter);



function epsilon_text_Callback(hObject, eventdata, handles)
% hObject    handle to epsilon_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsilon_text as text
%        str2double(get(hObject,'String')) returns contents of epsilon_text as a double


% --- Executes during object creation, after setting all properties.
function epsilon_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsilon_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function max_iter_text_Callback(hObject, eventdata, handles)
% hObject    handle to max_iter_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of max_iter_text as text
%        str2double(get(hObject,'String')) returns contents of max_iter_text as a double


% --- Executes during object creation, after setting all properties.
function max_iter_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to max_iter_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function root_output_Callback(hObject, eventdata, handles)
% hObject    handle to root_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of root_output as text
%        str2double(get(hObject,'String')) returns contents of root_output as a double


% --- Executes during object creation, after setting all properties.
function root_output_CreateFcn(hObject, eventdata, handles)
% hObject    handle to root_output (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
