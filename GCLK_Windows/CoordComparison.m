function varargout = CoordComparison(varargin)
% COORDCOMPARISON MATLAB code for CoordComparison.fig
%      COORDCOMPARISON, by itself, creates a new COORDCOMPARISON or raises the existing
%      singleton*.
%
%      H = COORDCOMPARISON returns the handle to a new COORDCOMPARISON or the handle to
%      the existing singleton*.
%
%      COORDCOMPARISON('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COORDCOMPARISON.M with the given input arguments.
%
%      COORDCOMPARISON('Property','Value',...) creates a new COORDCOMPARISON or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CoordComparison_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CoordComparison_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CoordComparison

% Last Modified by GUIDE v2.5 06-May-2024 16:29:27

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CoordComparison_OpeningFcn, ...
                   'gui_OutputFcn',  @CoordComparison_OutputFcn, ...
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


% --- Executes just before CoordComparison is made visible.
function CoordComparison_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to CoordComparison (see VARARGIN)

% Choose default command line output for CoordComparison
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

% UIWAIT makes CoordComparison wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = CoordComparison_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_openCoord.
function pushbutton_openCoord_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_openCoord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose GCLK Coord File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_coord'),'string',strcat(pp,ff));
end


% --- Executes on button press in pushbutton_openPar.
function pushbutton_openPar_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_openPar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose GCLK Parameter File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_par'),'string',strcat(pp,ff));
end



function edit_par_Callback(hObject, eventdata, handles)
% hObject    handle to edit_par (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_par as text
%        str2double(get(hObject,'String')) returns contents of edit_par as a double


% --- Executes during object creation, after setting all properties.
function edit_par_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_par (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_coord_Callback(hObject, eventdata, handles)
% hObject    handle to edit_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_coord as text
%        str2double(get(hObject,'String')) returns contents of edit_coord as a double


% --- Executes during object creation, after setting all properties.
function edit_coord_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_coord (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



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
h1=findobj(gcf,'tag','edit_par');
h2=findobj(gcf,'tag','edit_coord');
file1 = get(h1,'String');
file2 = get(h2,'String');
if(isempty(file1)||isempty(file2))
    warndlg('Input file is empty.', 'Warning');
    return;
end
%%%check deleted sites
h=findobj(gcf,'tag','edit_exc');
cdel=get(h,'String');
if(isempty(cdel))
    cdel='xx-no-ne-xx';
end
%%%coord diff
[parSit,parCoord]=readParCoord(file1);
file_par=strcat(runPth,'\temp.parcoord');
fid=fopen(file_par,'w');
for(i=1:length(parSit))
    if(strfind(cdel,char(parSit(i))))
        continue;
    end
    fprintf(fid, '%s %f %f %f\n',char(parSit(i)),parCoord(i,:));
end
fclose(fid);
[corSit,corCoord]=readCorCoord(file2);
file_cor=strcat(runPth,'\temp.corcoord');
fid=fopen(file_cor,'w');
for(i=1:length(corSit))
    if(strfind(cdel,char(corSit(i))))
        continue;
    end
    fprintf(fid, '%s %f %f %f\n',char(corSit(i)),corCoord(i,:));
end
fclose(fid);
%%% diff
pth=pwd;
fileID = fopen(logFile, 'a');
cd(runPth);
command=strcat(pth,'/dos_bin/xdif.exe',32,file_cor,32,file_par);
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
cd(pth);
if(status==0)
    %%% plot result
    STR=strsplit(cmdout,'\n');
    csit=[];dneu=[];
    for(j=2:1:length(STR))
        line=STR(j);
        str=strsplit(char(line));
        if(length(str)<3)
            continue;
        end
        csit=[csit;str(3)];
        dneu=[dneu;[str2double(str(8)),str2double(str(9)),str2double(str(10))]];
    end
    %%%bar
    [m,n]=size(dneu);
    if(m>0)
        figure(1);
        bar(dneu*1000);
        title(strcat('Coordinate Comparison Result'));
        ylabel('Difference (mm)');
        xlim([0,m+1]);
        set(gca,'XTick',1:m,'XTickLabel',csit);
        grid on
        set(gcf, 'Color', 'white');
        %set(gca, 'XTickLabelRotation', 90);
        legend('N','E','U',0);
    end
end

% --- Executes on button press in pushbutton_can.
function pushbutton_can_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_can (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);
