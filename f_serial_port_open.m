function f_serial_port_open(~,~)

    port_list = strjoin(seriallist, ',');

    global port

    text = strcat('Enter COM port. Available ports: ', port_list);
    prompt = {text};
    title = 'Serial Port';
    dims = [1 30];
    definput = {'COM6'};
    serial_port = string(inputdlg(prompt,title,dims,definput));

    f = waitbar(0,'Opening Serial Port');
    port = serial(serial_port(1));
    set(port,'BaudRate',9600);
    fopen(port);
    close(f);
        
end
