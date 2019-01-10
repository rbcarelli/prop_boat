function f_reset_plot()

subplot_location = [.15 .65 .35 .3;
                    .6 .65 .3 .3;
                    .15 .25 .35 .3;
                    .6 .25 .3 .3];
                    % L  B  W  H  
                    
    for i = 1:4
       figure(1)
       fig = subplot(2,2,i);
       set(fig, 'position',[subplot_location(i,1) subplot_location(i,2) ...
        subplot_location(i,3) subplot_location(i,4)]);
       plot(0)
       
       if i == 1
           text(0.05,.89,'Thrust Voltage','color','b')
           text(0.05,.71,'Torque Voltage','color',[0.9100    0.4100    0.1700])
       elseif i == 3
           text(0.05,.89,'Thrust Voltage','color','b')
           text(0.05,.71,'Torque Voltage','color',[0.9100    0.4100    0.1700])
       end
           
    end

    f = figure(1);
    bgcolor = f.Color;                              %L B W H
    time1 = uicontrol('Parent',f,'Style','text','Position',[430,380,40,23],...
        'String','Time','BackgroundColor',bgcolor);
    time2 = uicontrol('Parent',f,'Style','text','Position',[430,120,40,23],...
        'String','Time','BackgroundColor',bgcolor);
    time2 = uicontrol('Parent',f,'Style','text','Position',[1030,120,40,23],...
        'String','Time','BackgroundColor',bgcolor);
    thrust_lengend = uicontrol('Parent',f,'Style','text','Position',[1030,120,40,23],...
        'String','Time','BackgroundColor','white');
        

    
end