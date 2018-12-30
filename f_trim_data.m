function f_trim_data(~,~)
global raw_thrust raw_torque raw_rpm time program_running
    y=0;
    [x,y] = ginput;
    [~, idx1] = min(abs(time-x(1)));
    [~, idx2] = min(abs(time-x(2)));
    valuable_thrust = raw_thrust(idx1:idx2);
    valuable_torque = raw_torque(idx1:idx2);
    valuable_rpm = raw_rpm(idx1:idx2);
    valuable_time = time(idx1:idx2);
    figure(1)
    f_plot_data([valuable_thrust valuable_torque],valuable_time,[2 2 3], [.15 .25 .35 .3])
    f_plot_data([valuable_rpm],valuable_time,[2 2 4],[.6 .25 .3 .3])
    mean_val = sum(valuable_thrust)/length(valuable_thrust);
    
    sliders()
    function sliders()

        f = figure(1);
        bgcolor = f.Color;                              %L B W H
        thrust_smoothing = uicontrol('Parent',f,'Style','slider','Position',[250,90,400,20],...
                  'value',1, 'min',1, 'max',100);
         bl1 = uicontrol('Parent',f,'Style','text','Position',[230,85,23,23],...
                    'String','0','BackgroundColor',bgcolor);
         bl2 = uicontrol('Parent',f,'Style','text','Position',[655,85,23,23],...
                    'String','100','BackgroundColor',bgcolor);
         bl3 = uicontrol('Parent',f,'Style','text','Position',[405,65,100,23],...
                    'String','Thrust Smoothing','BackgroundColor',bgcolor);

        torque_smoothing = uicontrol('Parent',f,'Style','slider','Position',[250,50,400,20],...
                  'value',1, 'min',1, 'max',100);
         bl1 = uicontrol('Parent',f,'Style','text','Position',[230,45,23,23],...
                    'String','0','BackgroundColor',bgcolor);
         bl2 = uicontrol('Parent',f,'Style','text','Position',[655,45,23,23],...
                    'String','100','BackgroundColor',bgcolor);
         bl3 = uicontrol('Parent',f,'Style','text','Position',[405,25,100,23],...
                    'String','Torque Smoothing','BackgroundColor',bgcolor);
    end

    addlistener(thrust_smoothing, 'Value', 'PostSet', @callbackfn_thrust);
    addlistener(torque_smoothing, 'Value', 'PostSet', @callbackfn_torque);
    
    smoothed_thrust = valuable_thrust;
    smoothed_torque = valuable_torque;
        
    function callbackfn_thrust(~, eventdata)
       num_thrust = get(eventdata.AffectedObject, 'Value');
       smoothed_thrust = smoothdata(valuable_thrust,'movmean',num_thrust);
       plot_trimmed_data()  
    end     

    function callbackfn_torque(~, eventdata)
       num_torque = get(eventdata.AffectedObject, 'Value');
       smoothed_torque = smoothdata(valuable_torque,'movmean',num_torque);
       plot_trimmed_data()
    end  

    function plot_trimmed_data()
       f_plot_data([smoothed_thrust smoothed_torque],valuable_time,[2 2 3],[.15 .25 .35 .3])        
    end

end





