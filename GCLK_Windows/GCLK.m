function varargout = GCLK(varargin)
% GCLK MATLAB code for GCLK.fig
%      GCLK, by itself, creates a new GCLK or raises the existing
%      singleton*.
%
%      H = GCLK returns the handle to a new GCLK or the handle to
%      the existing singleton*.
%
%      GCLK('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GCLK.M with the given input arguments.
%
%      GCLK('Property','Value',...) creates a new GCLK or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GCLK_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GCLK_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GCLK

% Last Modified by GUIDE v2.5 06-May-2024 17:05:34

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GCLK_OpeningFcn, ...
                   'gui_OutputFcn',  @GCLK_OutputFcn, ...
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


% --- Executes just before GCLK is made visible.
function GCLK_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GCLK (see VARARGIN)

% Choose default command line output for GCLK
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%%% gclk global data
handles.runPth = '';guidata(hObject,handles);
handles.logFile = '';guidata(hObject,handles);

% UIWAIT makes GCLK wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GCLK_OutputFcn(hObject, eventdata, handles) 
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



function edit_out_Callback(hObject, eventdata, handles)
% hObject    handle to edit_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_out as text
%        str2double(get(hObject,'String')) returns contents of edit_out as a double


% --- Executes during object creation, after setting all properties.
function edit_out_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_out (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_cmp.
function pushbutton_cmp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%% open('ClockComparison.fig');
runPth=handles.runPth;
logFile=handles.logFile;
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    Str3='->Clock Comparison: Failed.';
else
    ClockComparison(2,runPth,logFile);
    Str3='->Clock Comparison: Running';
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);


% --- Executes on button press in pushbutton_new.
function pushbutton_new_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_new (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth = uigetdir;
logFile = ' ';
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
if isequal(runPth,0)
    Str3 = '->New Workspace: Cancel.';
else
    Str3 = strcat('->New Workspace: ',runPth);
    logFile = strcat(runPth,'/gclk.log');
    if ~exist(logFile, 'file')
        fileID = fopen(logFile, 'a');
        fclose(fileID);
    end
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);
%%% global parameters
handles.runPth = runPth;guidata(hObject,handles);
handles.logFile = logFile;guidata(hObject,handles);


% --- Executes on button press in pushbutton_import.
function pushbutton_import_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth=handles.runPth;
logFile=handles.logFile;
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    Str3='->Import Data: Failed.';
else
    ImportData(2,runPth,logFile);
    Str3='->Import Data: Running';
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);


% --- Executes on button press in pushbutton_clk.
function pushbutton_clk_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth=handles.runPth;
logFile=handles.logFile;
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    Str3='->Clock Estimation: Failed.';
else
    ClockEstimation(2,runPth,logFile);
    Str3='->Clock Estimation: Running';
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);

% --- Executes on button press in pushbutton_pos.
function pushbutton_pos_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_pos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth=handles.runPth;
logFile=handles.logFile;
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    Str3='->Precise Positioning: Failed.';
else
    PrecisePositioning(2,runPth,logFile);
    Str3='->Precise Positioning: Running';
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);

% --- Executes on button press in pushbutton_log.
function pushbutton_log_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_log (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
logFile=handles.logFile;
if exist(logFile, 'file')
    Str3 = '->View Log File: Success.';
    open(logFile);
else
    warndlg('Log file does not exist.', 'Warning');
    Str3 = '->View Log File: Failed.';
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);


% --- Executes on button press in pushbutton_exit.
function pushbutton_exit_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes on button press in pushbutton_coord.
function pushbutton_coord_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth=handles.runPth;
logFile=handles.logFile;
h1=findobj(gcf,'tag','text_1');
h2=findobj(gcf,'tag','text_2');
h3=findobj(gcf,'tag','text_3');
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    Str3='->Coord Comparison: Failed.';
else
    CoordComparison(2,runPth,logFile);
    Str3='->Coord Comparison: Running';
end
Str2 = get(h3,'String');
Str1 = get(h2,'String');
set(h1,'String',Str1);
set(h2,'String',Str2);
set(h3,'String',Str3);