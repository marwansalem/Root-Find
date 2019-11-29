
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

% Last Modified by GUIDE v2.5 27-Nov-2019 23:33:35

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @numfig_OpeningFcn, ...
                   'gui_OutputFcn',  @numfig_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
               
clc   
syms x;
f = inline('x');
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
set(handles.root_output,'string',''); % clear the text area

func_str = get(handles.function_input,'string')

eps = str2double(get(handles.epsilon_text,'string'));
max_iter = str2double(get(handles.max_iter_text,'string'));

func_str = strrep(func_str,'e','2.7182818'); 
% replace e with its numeric value  because matlab cannot compute 
% because matlab cannot compute e^3 it computes exp(3)
f = inline(func_str);
xr= [];
%yy = sym2poly(yy);% convert from symbol to coeffcient form,,, only one ,however just one coefficient

table_results = [];

fmethd = get(handles.bisect_button,'value')+2*get(handles.false_button,'value') +3*get(handles.fixed_button,'value') +4*get(handles.newton_button,'value')+5*get(handles.secant_button,'value');

if fmethd ==1;  % bisection
    bounds = inputdlg({'Enter lower bound','enter upper bound'});
    xl = bounds(1);  %type will be cell
    xu = bounds(2);
    xl = str2num(char(xl));
    xu = str2num(char(xu));

    [xm , table_results] = bisection(f,xl,xu,eps,max_iter);
    xr =[xr xm];
    set(handles.table, 'columnname',{'xl', 'xu', 'xr', 'ea', 'f(xr)'});
    
elseif fmethd ==2;   % false position
    bounds = inputdlg({'Enter lower bound','enter upper bound'});
    xl = bounds(1);  %type will be cell
    xu = bounds(2);
    xl = str2num(char(xl));   % convert to number
    xu = str2num(char(xu));
    [xm , table_results] = false_position(f,xu,xl,eps,max_iter);
    xr =[xr xm];
    set(handles.table, 'columnname',{'xl', 'xu', 'xr', 'ea', 'f(xr)'});
    
elseif fmethd ==3;    % fixed point
    gx_str = char(inputdlg('Enter g(x)'));
    g = inline(gx_str);
    
elseif fmethd ==4;  % newton raphson
    x_0 = -10;
    x_0 = inputdlg({'Enter Initial guess'});
    x_0 = str2num(char( x_0)) ;

    [xm, table_results] = newton_raphson(func_str,x_0, eps, max_iter);
    xr = [xr xm];
    set(handles.table, 'columnname',{'xi', 'ea'});
    
elseif fmethd ==5;   % secant
    bounds = inputdlg({'Enter first guess','Enter second guess'});
    x_0 = bounds(1);  %type will be cell
    x_1 = bounds(2);
    x_0 = str2num(char(x_0));
    x_1 = str2num(char(x_1));

    [xm, table_results] = Secant(f,x_0,x_1,eps,max_iter);
    xr = [xr xm];
    set(handles.table, 'columnname',{'xi-1', 'xi', 'f(xi-1)', 'f(xi)', 'xi+1', 'ea'});
end 
axes(handles.axes2);
t_lin = linspace(-10,10,100);

plot(t_lin,f(t_lin), xr*ones(1,30),linspace(-3,3,30));
grid on ;
set(handles.table,'data',table_results);
set(handles.root_output,'string',mat2str(xr));

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
[file,path] = uigetfile('*.*');  % returns [0,0] if open is cancelled
if file ~= 0 and path~= 2   
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
end

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


% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes during object creation, after setting all properties.
function table_CreateFcn(hObject, eventdata, handles)
% hObject    handle to table (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
