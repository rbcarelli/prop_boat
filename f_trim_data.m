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
    
    %Defining Sliders
    sliders()
    function sliders()

        f = figure(1);
        bgcolor = f.Color;                              %L B W H
        thrust_smoothing = uicontrol('Parent',f,'Style','slider','Position',[250,90,400,20],...
                  'value',1, 'min',1, 'max',100);
         bl1 = uicontrol('Parent',f,'Style','text','Position',[230,85,23,23],...
                    'String','1','BackgroundColor',bgcolor);
         bl2 = uicontrol('Parent',f,'Style','text','Position',[655,85,23,23],...
                    'String','100','BackgroundColor',bgcolor);
         bl3 = uicontrol('Parent',f,'Style','text','Position',[405,65,100,23],...
                    'String','Thrust Smoothing','BackgroundColor',bgcolor);

        torque_smoothing = uicontrol('Parent',f,'Style','slider','Position',[250,50,400,20],...
                  'value',1, 'min',1, 'max',100);
         bl1 = uicontrol('Parent',f,'Style','text','Position',[230,45,23,23],...
                    'String','1','BackgroundColor',bgcolor);
         bl2 = uicontrol('Parent',f,'Style','text','Position',[655,45,23,23],...
                    'String','100','BackgroundColor',bgcolor);
         bl3 = uicontrol('Parent',f,'Style','text','Position',[405,25,100,23],...
                    'String','Torque Smoothing','BackgroundColor',bgcolor);
    end

    addlistener(thrust_smoothing, 'Value', 'PostSet', @callbackfn_thrust);
    addlistener(torque_smoothing, 'Value', 'PostSet', @callbackfn_torque);
    
    smoothed_thrust = valuable_thrust;
    smoothed_torque = valuable_torque;
    
    average_thrust = num2str(mean(smoothed_thrust));
    average_torque = num2str(mean(smoothed_torque));
    average_rpm = num2str(mean(valuable_rpm));
   
    %Defining mean value text boxes
    thrust_position = [.45 .3 .05 .02];
    thrust_label_position = [.42 .3 .02 .02];
    thrust_textbox = uicontrol('Style', 'text', 'Units', 'norm', 'Position', thrust_position);
    thrust_label = uicontrol('Style', 'text', 'Units', 'norm', 'Position', thrust_label_position);
    set(thrust_textbox, 'String', average_thrust,'BackgroundColor','w');
    set(thrust_label, 'String', 'T=','BackgroundColor','w');

    torque_position = [.45 .27 .05 .02];
    torque_label_position = [.42 .27 .02 .02];
    torque_textbox = uicontrol('Style', 'text', 'Units', 'norm', 'Position', torque_position);
    torque_label = uicontrol('Style', 'text', 'Units', 'norm', 'Position', torque_label_position);
    set(torque_textbox, 'String', average_torque,'BackgroundColor','w');
    set(torque_label, 'String', 'Q=','BackgroundColor','w');
    
    rpm_position = [.84 .27 .05 .02];
    rpm_label_position = [.81 .27 .02 .02];
    rpm_textbox = uicontrol('Style', 'text', 'Units', 'norm', 'Position', rpm_position);
    torque_label = uicontrol('Style', 'text', 'Units', 'norm', 'Position', rpm_label_position);
    set(rpm_textbox, 'String', average_rpm,'BackgroundColor','w');
    set(torque_label, 'String', 'RPM=','BackgroundColor','w');
    
    function callbackfn_thrust(~, eventdata)
       num_thrust = get(eventdata.AffectedObject, 'Value');
       smoothed_thrust = smoothdata(valuable_thrust,'movmean',num_thrust);
       plot_trimmed_data()
       average_thrust = num2str(mean(smoothed_thrust));
       set(thrust_textbox, 'String', average_thrust,'BackgroundColor','w');
    end     

    function callbackfn_torque(~, eventdata)
       num_torque = get(eventdata.AffectedObject, 'Value');
       smoothed_torque = smoothdata(valuable_torque,'movmean',num_torque);
       plot_trimmed_data()
       average_torque = num2str(mean(smoothed_torque));
       set(torque_textbox, 'String', average_torque,'BackgroundColor','w');    
    end  

    function plot_trimmed_data()
       f_plot_data([smoothed_thrust smoothed_torque],valuable_time,[2 2 3],[.15 .25 .35 .3])        
    end

end





