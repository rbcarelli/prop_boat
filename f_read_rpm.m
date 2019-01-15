function f_read_rpm(hObject,eventdata,handles)

global read_rpm c_button_rpm
button_state = get(hObject,'Value');
f = figure(1);
if button_state == get(hObject,'Max')
    read_rpm = true;
    c_button_rpm = 'green';
    rpm = uicontrol('Parent',f,'Style','text','Position',[1150,440,40,15],...
        'String','RPM =','ForegroundColor',c_button_rpm,'BackgroundColor','white');
    
elseif button_state == get(hObject,'Min')
    read_rpm = false;
    c_button_rpm = 'red';
    rpm = uicontrol('Parent',f,'Style','text','Position',[1150,440,40,15],...
        'String','RPM =','ForegroundColor',c_button_rpm,'BackgroundColor','white');
    
end