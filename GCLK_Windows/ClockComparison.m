function varargout = ClockComparison(varargin)
% CLOCKCOMPARISON MATLAB code for ClockComparison.fig
%      CLOCKCOMPARISON, by itself, creates a new CLOCKCOMPARISON or raises the existing
%      singleton*.
%
%      H = CLOCKCOMPARISON returns the handle to a new CLOCKCOMPARISON or the handle to
%      the existing singleton*.
%
%      CLOCKCOMPARISON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CLOCKCOMPARISON.M with the given input arguments.
%
%      CLOCKCOMPARISON('Property','Value',...) creates a new CLOCKCOMPARISON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ClockComparison_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ClockComparison_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ClockComparison

% Last Modified by GUIDE v2.5 05-May-2024 20:36:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ClockComparison_OpeningFcn, ...
                   'gui_OutputFcn',  @ClockComparison_OutputFcn, ...
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


% --- Executes just before ClockComparison is made visible.
function ClockComparison_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ClockComparison (see VARARGIN)

% Choose default command line output for ClockComparison
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

% UIWAIT makes ClockComparison wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ClockComparison_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_openRef.
function pushbutton_openRef_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_openRef (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.clk;*.clk_30s','Please Choose A Clock File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_ref'),'string',strcat(pp,ff));
end


% --- Executes on button press in pushbutton_openCmp.
function pushbutton_openCmp_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_openCmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.clk;*.clk_30s','Please Choose A Clock File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_cmp'),'string',strcat(pp,ff));
end



function edit_cmp_Callback(hObject, eventdata, handles)
% hObject    handle to edit_cmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_cmp as text
%        str2double(get(hObject,'String')) returns contents of edit_cmp as a double


% --- Executes during object creation, after setting all properties.
function edit_cmp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_cmp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_ref_Callback(hObject, eventdata, handles)
% hObject    handle to edit_ref (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_ref as text
%        str2double(get(hObject,'String')) returns contents of edit_ref as a double


% --- Executes during object creation, after setting all properties.
function edit_ref_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_ref (see GCBO)
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
runPth=handles.runPth;
logFile=handles.logFile;
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    return;
end
%%%check file
h1=findobj(gcf,'tag','edit_cmp');
h2=findobj(gcf,'tag','edit_ref');
file1 = get(h1,'String');
file2 = get(h2,'String');
if(isempty(file1)||isempty(file2))
    warndlg('Input file is empty.', 'Warning');
    return;
end
%%%check system
csys='';
h=findobj(gcf,'tag','radiobutton_gps');
if(get(h,'Value')==1.0)
    csys='G';
end
h=findobj(gcf,'tag','radiobutton_glo');
if(get(h,'Value')==1.0)
    csys='R';
end
h=findobj(gcf,'tag','radiobutton_gal');
if(get(h,'Value')==1.0)
    csys='E';
end
h=findobj(gcf,'tag','radiobutton_bds');
if(get(h,'Value')==1.0)
    csys='C';
end
h=findobj(gcf,'tag','radiobutton_qzss');
if(get(h,'Value')==1.0)
    csys='J';
end
if(isempty(csys))
    warndlg('Satellite system not selected.', 'Warning');
    return;
end
%%%check deleted sats
h=findobj(gcf,'tag','edit_exc');
cdel=get(h,'String');
if(isempty(cdel))
    cdel='none';
end
%%%clock diff
pth=pwd;
fileID = fopen(logFile, 'a');
cd(runPth);
command=strcat(pth,'/dos_bin/cmbclk.exe',32,file1,32,'-sys',32,csys,32,'-out',32,file1,'_Align');
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
command=strcat(pth,'/dos_bin/cmbclk.exe',32,file2,32,'-sys',32,csys,32,'-out',32,file2,'_Align');
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
command=strcat(pth,'/dos_bin/clkdif.exe',32,file2,'_Align',32,file1,'_Align',32,'-sys',32,csys,32,'-del',32,cdel,32,'-out',32,runPth,'/ClockComparison.Result',32, '-ref all');
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
fclose(fileID);
cd(pth);
if(status==0)
    %%% plot result
    STR=strsplit(cmdout,'\n');
    for(i=1:1:length(STR))
        line=STR(i);
        if(findstr(char(line),'* PRN EPOCHS  MEAN:Clk(ns)   STD:Clk(ns)   RMS:Clk(ns)   MAX:Clk(ns)'))
            break
        end
    end
    csat=[];dstd=[];mstd=0.0;
    for(j=i+1:1:length(STR))
        line=STR(j);
        str=strsplit(char(line));
        if(findstr(char(line),'* MEAN'))
            mstd=str2double(str(6));
            break;
        end
        csat=[csat;str(3)];
        dstd=[dstd;str2double(str(6))];
    end
    %%%bar
    if(length(dstd)>0)
        figure(1);
        bar(dstd,'r');
        title(strcat('Clock Comparison Result (Mean STD:',32,num2str(mstd),' ns)'));
        ylabel('STD (ns)');
        xlim([0,length(dstd)+1]);
        set(gca,'XTick',1:length(dstd),'XTickLabel',csat);
        grid on
        set(gcf, 'Color', 'white');
        %set(gca, 'XTickLabelRotation', 90);
    end
end
%cmdout

% --- Executes on button press in pushbutton_can.
function pushbutton_can_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_can (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);

function edit_exc_Callback(hObject, eventdata, handles)
% hObject    handle to edit_exc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_exc as text
%        str2double(get(hObject,'String')) returns contents of edit_exc as a double


% --- Executes during object creation, after setting all properties.
function edit_exc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_exc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_gps.
function radiobutton_gps_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_gps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_glo');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_gal');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_bds');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_qzss');
    set(h,'Value',0.0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_gps


% --- Executes on button press in radiobutton_glo.
function radiobutton_glo_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_glo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_gps');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_gal');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_bds');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_qzss');
    set(h,'Value',0.0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_glo


% --- Executes on button press in radiobutton_gal.
function radiobutton_gal_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_gal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_gps');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_glo');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_bds');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_qzss');
    set(h,'Value',0.0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_gal


% --- Executes on button press in radiobutton_bds.
function radiobutton_bds_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_bds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_gps');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_glo');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_gal');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_qzss');
    set(h,'Value',0.0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_bds


% --- Executes on button press in radiobutton_qzss.
function radiobutton_qzss_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_qzss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_gps');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_glo');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_gal');
    set(h,'Value',0.0)
    h=findobj(gcf,'tag','radiobutton_bds');
    set(h,'Value',0.0)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_qzss
