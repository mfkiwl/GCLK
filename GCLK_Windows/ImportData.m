function varargout = ImportData(varargin)
% IMPORTDATA MATLAB code for ImportData.fig
%      IMPORTDATA, by itself, creates a new IMPORTDATA or raises the existing
%      singleton*.
%
%      H = IMPORTDATA returns the handle to a new IMPORTDATA or the handle to
%      the existing singleton*.
%
%      IMPORTDATA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IMPORTDATA.M with the given input arguments.
%
%      IMPORTDATA('Property','Value',...) creates a new IMPORTDATA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ImportData_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ImportData_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ImportData

% Last Modified by GUIDE v2.5 25-May-2024 10:48:46

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ImportData_OpeningFcn, ...
                   'gui_OutputFcn',  @ImportData_OutputFcn, ...
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


% --- Executes just before ImportData is made visible.
function ImportData_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ImportData (see VARARGIN)

% Choose default command line output for ImportData
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

%%% global data
if(nargin>5)
    handles.runPth = varargin{2};guidata(hObject,handles);
    handles.logFile = varargin{3};guidata(hObject,handles);
else
    handles.runPth = '';guidata(hObject,handles);
    handles.logFile = '';guidata(hObject,handles);
end

% UIWAIT makes ImportData wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ImportData_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_eph.
function pushbutton_eph_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_eph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose Precise Ephemeris File(s)','multiselect','on');
if(iscell(ff))
    str='';
    for(i=1:length(ff))
        str=strcat(str,pp,ff(i),';');
    end
    set(findobj(gcf,'tag','edit_eph'),'string',str);
    set(findobj(gcf,'tag','edit_eph'),'foregroundcolor','black');
else
    if(ff~=0)
        set(findobj(gcf,'tag','edit_eph'),'string',strcat(pp,ff,';'));
        set(findobj(gcf,'tag','edit_eph'),'foregroundcolor','black');
    end
end


% --- Executes on button press in pushbutton_brd.
function pushbutton_brd_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose Broadcast Ephemeris File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_brd'),'string',strcat(pp,ff));
end



function edit_brd_Callback(hObject, eventdata, handles)
% hObject    handle to edit_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_brd as text
%        str2double(get(hObject,'String')) returns contents of edit_brd as a double


% --- Executes during object creation, after setting all properties.
function edit_brd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_brd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_eph_Callback(hObject, eventdata, handles)
% hObject    handle to edit_eph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hints: get(hObject,'String') returns contents of edit_eph as text
%        str2double(get(hObject,'String')) returns contents of edit_eph as a double


% --- Executes during object creation, after setting all properties.
function edit_eph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_eph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hint_str = 'Consecutive three days...';
set(findobj(gcf,'tag','edit_eph'),'string',hint_str);
set(findobj(gcf,'tag','edit_eph'),'foregroundcolor',[0.5 0.5 0.5]);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_clk.
function pushbutton_clk_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_clk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose Precise Clock File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_clk'),'string',strcat(pp,ff));
    set(findobj(gcf,'tag','edit_clk'),'foregroundcolor','black');
end



function edit_clk_Callback(hObject, eventdata, handles)
% hObject    handle to edit_clk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_clk as text
%        str2double(get(hObject,'String')) returns contents of edit_clk as a double


% --- Executes during object creation, after setting all properties.
function edit_clk_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_clk (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hint_str = 'Precise positioning is required...';
set(findobj(gcf,'tag','edit_clk'),'string',hint_str);
set(findobj(gcf,'tag','edit_clk'),'foregroundcolor',[0.5 0.5 0.5]);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_att.
function pushbutton_att_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_att (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose Attitude Quaternion File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_att'),'string',strcat(pp,ff));
end



function edit_att_Callback(hObject, eventdata, handles)
% hObject    handle to edit_att (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_att as text
%        str2double(get(hObject,'String')) returns contents of edit_att as a double


% --- Executes during object creation, after setting all properties.
function edit_att_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_att (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_import.
function pushbutton_import_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_import (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth=handles.runPth;
logFile=handles.logFile;
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    return;
end
%%%check file
h1=findobj(gcf,'tag','edit_brd');
h2=findobj(gcf,'tag','edit_eph');
h3=findobj(gcf,'tag','edit_clk');
h4=findobj(gcf,'tag','edit_att');
h5=findobj(gcf,'tag','edit_conf');
h6=findobj(gcf,'tag','edit_obs');
file1 = get(h1,'String');
file2 = get(h2,'String');
file3 = get(h3,'String');
file4 = get(h4,'String');
file5 = get(h5,'String');
file6 = get(h6,'String');
if(iscell(file2))
    file2=char(file2);
end
if(length(strfind(file2,'...'))>0)
    file2='';
end
if(length(strfind(file3,'...'))>0)
    file3='';
end
if(isempty(file1)||isempty(file2)||isempty(file4)||isempty(file5)||isempty(file6))
    warndlg('Input file is empty.', 'Warning');
    return;
end
%%%write in file
fname=strcat(runPth,'\import.data');
fid=fopen(fname,'w');
fprintf(fid,'%s\n',strcat('->',file1));
fprintf(fid,'%s\n',strcat('->',file2));
fprintf(fid,'%s\n',strcat('->',file3));
fprintf(fid,'%s\n',strcat('->',file4));
fprintf(fid,'%s\n',strcat('->',file5));
fprintf(fid,'%s\n',strcat('->',file6));
fclose(fid);
msgbox('Import was successful.');
%close(gcf);



% --- Executes on button press in pushbutton_cancel.
function pushbutton_cancel_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_cancel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);


% --- Executes on button press in pushbutton_conf.
function pushbutton_conf_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pp=uigetdir('./','Please Choose Configure File Path');
if(pp~=0)
    set(findobj(gcf,'tag','edit_conf'),'string',pp);
end



function edit_conf_Callback(hObject, eventdata, handles)
% hObject    handle to edit_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_conf as text
%        str2double(get(hObject,'String')) returns contents of edit_conf as a double


% --- Executes during object creation, after setting all properties.
function edit_conf_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_conf (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton_obs.
function pushbutton_obs_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_obs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
pp=uigetdir('./','Please Choose Observation Data Path');
if(pp~=0)
    set(findobj(gcf,'tag','edit_obs'),'string',pp);
end


function edit_obs_Callback(hObject, eventdata, handles)
% hObject    handle to edit_obs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_obs as text
%        str2double(get(hObject,'String')) returns contents of edit_obs as a double


% --- Executes during object creation, after setting all properties.
function edit_obs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_obs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function pushbutton_eph_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton_eph (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on key press with focus on edit_eph and none of its controls.
function edit_eph_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_eph (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'tag','edit_eph'),'foregroundcolor','black');


% --- Executes on key press with focus on edit_clk and none of its controls.
function edit_clk_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_clk (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'tag','edit_clk'),'foregroundcolor','black');
