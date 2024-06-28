function varargout = PrecisePositioning(varargin)
% PRECISEPOSITIONING MATLAB code for PrecisePositioning.fig
%      PRECISEPOSITIONING, by itself, creates a new PRECISEPOSITIONING or raises the existing
%      singleton*.
%
%      H = PRECISEPOSITIONING returns the handle to a new PRECISEPOSITIONING or the handle to
%      the existing singleton*.
%
%      PRECISEPOSITIONING('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PRECISEPOSITIONING.M with the given input arguments.
%
%      PRECISEPOSITIONING('Property','Value',...) creates a new PRECISEPOSITIONING or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PrecisePositioning_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PrecisePositioning_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PrecisePositioning

% Last Modified by GUIDE v2.5 25-May-2024 14:42:06

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PrecisePositioning_OpeningFcn, ...
                   'gui_OutputFcn',  @PrecisePositioning_OutputFcn, ...
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


% --- Executes just before PrecisePositioning is made visible.
function PrecisePositioning_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PrecisePositioning (see VARARGIN)

% Choose default command line output for PrecisePositioning
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

% UIWAIT makes PrecisePositioning wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PrecisePositioning_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton_com.
function pushbutton_com_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_com (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
runPth=handles.runPth;
logFile=handles.logFile;
if(isempty(runPth)||isempty(logFile))
    warndlg('Workspace not created.', 'Warning');
    return;
end
%%%check file
if ~exist(strcat(runPth,'\import.data'),'file')
    warndlg('Data not imported.', 'Warning');
    return;
end
%%% site_list
site_list=get(findobj(gcf,'tag','edit_site'),'String');
if(length(strfind(site_list,'...'))>0)
    site_list='';
end
if(isempty(site_list))
    warndlg('Site list file not input.', 'Warning');
    return;
end
%%% res
iter_c=get(findobj(gcf,'tag','edit_res'),'String');
if(isempty(iter_c))
    warndlg('Residual analysis iterations not input.', 'Warning');
    return;
end
[iter,stat]=str2num(iter_c);
if(~stat)
    warndlg('Residual analysis iterations input error.', 'Warning');
    return;
end
%%% date
cdate=get(findobj(gcf,'tag','edit_date'),'String');
if(length(strfind(cdate,'e.g.'))>0)
    cdate='';
end
if(isempty(cdate))
    warndlg('Process date not input.', 'Warning');
    return;
end
if(length(cdate)~=7)
    warndlg('Process date input error.', 'Warning');
    return;
end
cyear=cdate(1:4);
cdoy=cdate(end-2:end);
[iyear,stat1]=str2num(cyear);
[idoy,stat2]=str2num(cdoy);
if(~stat1 || ~stat2)
    warndlg('Process date input error.', 'Warning');
    return;
end
[nweek,ndow]=yeardoy2wkd(iyear,idoy);
cweek=num2str(nweek);
cdow=num2str(ndow);
iyy=iyear-floor(iyear/100)*100;
cyy=num2str(iyy);
%%% intv
cintv=get(findobj(gcf,'tag','edit_intv'),'String');
if(isempty(cintv))
    warndlg('Process intervals not input.', 'Warning');
    return;
end
%%% AR
AR=0;
if(get(findobj(gcf,'tag','radiobutton_yes'),'Value')==1.0)
    AR=1;
end
%%% sys
csys='';
if(get(findobj(gcf,'tag','checkbox_gps'),'Value')==1.0)
    csys=strcat(csys,'G');
end
if(get(findobj(gcf,'tag','checkbox_glo'),'Value')==1.0)
    csys=strcat(csys,'R');
end
if(get(findobj(gcf,'tag','checkbox_gal'),'Value')==1.0)
    csys=strcat(csys,'E');
end
if(get(findobj(gcf,'tag','checkbox_bds'),'Value')==1.0)
    csys=strcat(csys,'C');
end
if(get(findobj(gcf,'tag','checkbox_qzss'),'Value')==1.0)
    csys=strcat(csys,'J');
end
if(isempty(csys))
    warndlg('Satellite system not choose.', 'Warning');
    return;
end
%%% set black
set(findobj(gcf,'tag','edit_res'),'foregroundcolor','black');
set(findobj(gcf,'tag','edit_intv'),'foregroundcolor','black');
%%% read import data file
fname=strcat(runPth,'\import.data');
fid=fopen(fname,'r');
line=fgetl(fid);fbrd=line(3:end);%%% brd file
line=fgetl(fid);ftemp=line(3:end);fsp3=strsplit(ftemp,';');fsp3(end)=[];%%% sp3 file
line=fgetl(fid);fclk=line(3:end);%%% clk file
line=fgetl(fid);fquat=line(3:end);%%% quat file
line=fgetl(fid);pconf=line(3:end);%%% conf path
line=fgetl(fid);pobs=line(3:end);%%% obs path
fclose(fid);
%%% prepare data
pth=pwd;
fileID = fopen(logFile, 'a');
cd(runPth);
%%%---brdsat
command=strcat(pth,'/dos_bin/brdsat.exe',32,fbrd,32,'-noorb -noclk -sys',32,csys);
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%%---brdsat
fbrd_brd=strcat('brdc',cdoy,'0.',cyy,'p');
fbrd_sp3=strcat('brd',cweek,cdow,'.sp3');
fbrd_clk=strcat('brd',cweek,cdow,'.clk');
command=strcat(pth,'/dos_bin/brdsat.exe',32,fbrd_brd,32,'-sp3',32,fbrd_sp3,32,'-clk',32,fbrd_clk,32,'-fk -sys',32,csys,32,'-nochk');
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%%---rotmat
frot=strcat('rot_',cyear,cdoy);
fconf=strcat(pconf,'/configure');
command=strcat(pth,'/dos_bin/rotmat.exe',32,'-time',32,cyear,32,cdoy,32,'0 86400',32,'-intv 30',32,'-out',32,frot,32,'+conf',32,fconf);
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%%---yawatt
fyaw=strcat('yaw_',cyear,cdoy);
fatt=strcat('att_',cyear,cdoy);
command=strcat(pth,'/dos_bin/yawatt.exe',32,fbrd_sp3,32,'-time',32,cyear,32,cdoy,32,'0 86400',32,'-intv 30',32,'-yaw',32,fyaw,32,'-att',32,fatt,32,'-sys',32,csys,32,'+conf',32,fconf);
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%%---quat2att
fsati=strcat(pconf,'/sat_info');
command=strcat(pth,'/dos_bin/quat2att.exe',32,fquat,32,'-intv 30',32,'-out',32,fatt,32,'-rot',32,frot,32,'-sys',32,csys,32,'-sati',32,fsati);
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%%---olist
olist=strcat('.\olist');
fio=fopen(olist,'w');
fid=fopen(site_list,'r');
while ~feof(fid)
    line=fgetl(fid);
    ss=line(1:4);
    ff=ls(strcat(pobs,'\*',ss,'*'));
    if(length(ff)>0)
        %fprintf(fio,'%s\n',ff(1,:));
        fprintf(fio,'%s\n',strcat(pobs,'\',ff(1,:)));
    end
end
fclose(fid);
fclose(fio);
%%%---predat
fsign=strcat(pconf,'\sys_freq');
fsitc=strcat(pconf,'\site_appr');
fid=fopen(olist,'r');
while ~feof(fid)
    ff=fgetl(fid);
    command=strcat(pth,'/dos_bin/predat.exe',32,ff,32,'-intv 30 -freq 12 -gap 0',32,'-sp3',32,fbrd_sp3,32,'-fk glonass.fk',32,'-sign',32,fsign,32,'-sitc',32,fsitc,32,'-sys',32,csys,32,'-tb -yaw',32,fyaw,32,'-leap -orb',32,fbrd_sp3);
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
end
fclose(fid);
%%%---combine sp3 and remove bias
fcmb_sp3=strcat('cmb',cweek,cdow,'.sp3');
if(length(fsp3)==1)
    command=strcat(pth,'/dos_bin/cmbsp3.exe',32,char(fsp3(1)),32,'-out',32,fcmb_sp3,32,'-sys',32,csys);
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
elseif(length(fsp3)==2)
    command=strcat(pth,'/dos_bin/cmbsp3.exe',32,char(fsp3(1)),32,char(fsp3(2)),32,'-out',32,fcmb_sp3,32,'-sys',32,csys);
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
elseif(length(fsp3)==3)
    command=strcat(pth,'/dos_bin/cmbsp3.exe',32,char(fsp3(1)),32,char(fsp3(2)),32,'-out',32,strcat(fcmb_sp3,'_temp'),32,'-sys',32,csys,32,'-rmb 1');
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
    command=strcat(pth,'/dos_bin/cmbsp3.exe',32,strcat(fcmb_sp3,'_temp'),32,char(fsp3(3)),32,'-out',32,fcmb_sp3,32,'-sys',32,csys,32,'-rmb 2');
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
    delete(strcat(fcmb_sp3,'_temp'));
end
%%%---precise clock
fcmb_clk=strcat('cmb',cweek,cdow,'.clk');
command=strcat(pth,'/dos_bin/cmbclk.exe',32,fclk,32,'-out',32,fcmb_clk,32,'-sys',32,csys);
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%%---main step gclk
command=strcat(pth,'/dos_bin/gclk.exe',32,'olist -clk',32,fcmb_clk,32,'-sp3',32,fcmb_sp3,32,'+conf',32,fconf,32,'-intv',32,cintv,32,'-fk glonass.fk -sys',32,csys,32,'-nopco');
[status,cmdout] = system(command,'-echo');
fprintf(fileID, '%s', cmdout);
%%% anares
for(i=1:iter)
    fid=fopen(olist,'r');
    while ~feof(fid)
        ff=fgetl(fid);
        command=strcat(pth,'/dos_bin/anares.exe',32,ff,'.res',32,ff,'.arc',32,'-gap 0');
        [status,cmdout] = system(command,'-echo');
        fprintf(fileID, '%s', cmdout);
    end
    fclose(fid);
    command=strcat(pth,'/dos_bin/gclk.exe',32,'olist -clk',32,fcmb_clk,32,'-sp3',32,fcmb_sp3,32,'+conf',32,fconf,32,'-intv',32,cintv,32,'-fk glonass.fk -sys',32,csys,32,'-nopco');
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
end
%%%AMBR
if(AR)
    %%%satpo
    command=strcat(pth,'/dos_bin/satpo.exe',32,fcmb_sp3,32,'-time',32,cyear,32,cdoy,32,'0 86400',32,'-intv 30',32,'-sys',32,csys);
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
    %%%ambr
    fpil=strcat('pil_',cyear,cdoy);
    fspo=strcat('spo_',cyear,cdoy);
    command=strcat(pth,'/dos_bin/ambr.exe',32,'olist -pil',32,fpil,32,'-arc default',32,'+conf',32,fconf,32,'-fk glonass.fk -spo',32,fspo);
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
    %%%gclk
    famb=strcat('amb_',cyear,cdoy);
    command=strcat(pth,'/dos_bin/gclk.exe',32,'olist -clk',32,fcmb_clk,32,'-sp3',32,fcmb_sp3,32,'+conf',32,fconf,32,'-intv',32,cintv,32,'-amb',32,famb,32,'-fk glonass.fk -sys',32,csys,32,'-nopco');
    [status,cmdout] = system(command,'-echo');
    fprintf(fileID, '%s', cmdout);
end

cd(pth);


% --- Executes on button press in pushbutton_can.
function pushbutton_can_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_can (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close(gcf);



% --- Executes on button press in pushbutton_site.
function pushbutton_site_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton_site (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[ff,pp]=uigetfile('*.*','Please Choose Site List File');
if(ff~=0)
    set(findobj(gcf,'tag','edit_site'),'string',strcat(pp,ff));
    set(findobj(gcf,'tag','edit_site'),'foregroundcolor','black');
end


function edit_site_Callback(hObject, eventdata, handles)
% hObject    handle to edit_site (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_site as text
%        str2double(get(hObject,'String')) returns contents of edit_site as a double


% --- Executes during object creation, after setting all properties.
function edit_site_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_site (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hint_str = 'Using a file...';
set(findobj(gcf,'tag','edit_site'),'string',hint_str);
set(findobj(gcf,'tag','edit_site'),'foregroundcolor',[0.5 0.5 0.5]);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_date_Callback(hObject, eventdata, handles)
% hObject    handle to edit_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_date as text
%        str2double(get(hObject,'String')) returns contents of edit_date as a double


% --- Executes during object creation, after setting all properties.
function edit_date_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_date (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hint_str = 'e.g. 2023001';
set(findobj(gcf,'tag','edit_date'),'string',hint_str);
set(findobj(gcf,'tag','edit_date'),'foregroundcolor',[0.5 0.5 0.5]);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit_res_Callback(hObject, eventdata, handles)
% hObject    handle to edit_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_res as text
%        str2double(get(hObject,'String')) returns contents of edit_res as a double


% --- Executes during object creation, after setting all properties.
function edit_res_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_res (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hint_str = '2';
set(findobj(gcf,'tag','edit_res'),'string',hint_str);
set(findobj(gcf,'tag','edit_res'),'foregroundcolor',[0.5 0.5 0.5]);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radiobutton_yes.
function radiobutton_yes_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_yes (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_no');
    set(h,'Value',0.0)
else
    h=findobj(gcf,'tag','radiobutton_no');
    set(h,'Value',1)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_yes


% --- Executes on button press in radiobutton_no.
function radiobutton_no_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_no (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if get(hObject,'Value')==1
    h=findobj(gcf,'tag','radiobutton_yes');
    set(h,'Value',0.0)
else
    h=findobj(gcf,'tag','radiobutton_yes');
    set(h,'Value',1)
end
% Hint: get(hObject,'Value') returns toggle state of radiobutton_no


% --- Executes on button press in checkbox_gps.
function checkbox_gps_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_gps (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_gps


% --- Executes on button press in checkbox_glo.
function checkbox_glo_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_glo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_glo


% --- Executes on button press in checkbox_gal.
function checkbox_gal_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_gal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_gal


% --- Executes on button press in checkbox_bds.
function checkbox_bds_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_bds (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_bds


% --- Executes on button press in checkbox_qzss.
function checkbox_qzss_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_qzss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox_qzss


% --- Executes on key press with focus on edit_site and none of its controls.
function edit_site_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_site (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'tag','edit_site'),'foregroundcolor','black');


% --- Executes on key press with focus on edit_res and none of its controls.
function edit_res_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_res (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'tag','edit_res'),'foregroundcolor','black');


% --- Executes on key press with focus on edit_date and none of its controls.
function edit_date_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_date (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'tag','edit_date'),'foregroundcolor','black');



function edit_intv_Callback(hObject, eventdata, handles)
% hObject    handle to edit_intv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit_intv as text
%        str2double(get(hObject,'String')) returns contents of edit_intv as a double


% --- Executes during object creation, after setting all properties.
function edit_intv_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit_intv (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
hint_str = '300';
set(findobj(gcf,'tag','edit_intv'),'string',hint_str);
set(findobj(gcf,'tag','edit_intv'),'foregroundcolor',[0.5 0.5 0.5]);

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on key press with focus on edit_intv and none of its controls.
function edit_intv_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to edit_intv (see GCBO)
% eventdata  structure with the following fields (see UICONTROL)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)
set(findobj(gcf,'tag','edit_intv'),'foregroundcolor','black');
