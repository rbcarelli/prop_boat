function f_control_acquire(hObject,eventdata,handles)

global enable_acquire 
button_state = get(hObject,'Value');
if button_state == get(hObject,'Max')
    enable_acquire = true;
    f_acquire_data()
    
elseif button_state == get(hObject,'Min')
    enable_acquire = false;
    
    
end



% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)