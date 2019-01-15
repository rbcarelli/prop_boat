function f_reset_plot()

subplot_location = [".15" ".65" ".75" ".3" "[1 2]";
                    ".15" ".25" ".35" ".3" "3";
                    ".6" ".25" ".3" ".3" "4"];
                    % L  B  W  H  
                    
    for i = 1:3
       figure(1)
       fig = subplot(2,2,str2num(subplot_location(i,5)));
       set(fig, 'position',[str2num(subplot_location(i,1)) ...
        str2num(subplot_location(i,2)) ...
        str2num(subplot_location(i,3)) ...
        str2num(subplot_location(i,4))]);
       plot(0)
           
    end
                            
    f = figure(1);
    bgcolor = f.Color;                              %L B W H
    time1 = uicontrol('Parent',f,'Style','text','Position',[714,380,40,23],...
        'String','Time','BackgroundColor',bgcolor);
    time2 = uicontrol('Parent',f,'Style','text','Position',[438,120,40,23],...
        'String','Time','BackgroundColor',bgcolor);
    time3 = uicontrol('Parent',f,'Style','text','Position',[1030,120,40,23],...
        'String','Time','BackgroundColor',bgcolor);
    rpm = uicontrol('Parent',f,'Style','text','Position',[780,245,40,23],...
        'String','RPM','BackgroundColor',bgcolor);
    thrust_lengend = uicontrol('Parent',f,'Style','text','Position',[125,590,60,23],...
        'String','Thrust Volts','ForegroundColor','blue','BackgroundColor',bgcolor);
    torque_lengend = uicontrol('Parent',f,'Style','text','Position',[125,570,60,23],...
        'String','Torque Volts','ForegroundColor',[0.9100    0.4100    0.1700],'BackgroundColor',bgcolor);    
    thrust_lengend2 = uicontrol('Parent',f,'Style','text','Position',[125,330,60,23],...
        'String','Thrust Volts','ForegroundColor','blue','BackgroundColor',bgcolor);
    torque_lengend2 = uicontrol('Parent',f,'Style','text','Position',[125,310,60,23],...
        'String','Torque Volts','ForegroundColor',[0.9100    0.4100    0.1700],'BackgroundColor',bgcolor); 
    rpm_initial = uicontrol('Parent',f,'Style','text','Position',[1150,440,40,15],...
        'String','RPM =','ForegroundColor','red','BackgroundColor','white');
    
end