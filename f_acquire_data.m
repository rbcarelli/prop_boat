
function f_acquire_data()
    f_reset_plots()
      
    global enable_acquire raw_thrust raw_torque raw_rpm program_running...
    time mydaq packet_size sample_rate
    
    raw_thrust = zeros(50*packet_size, 1);
    raw_torque = zeros(50*packet_size, 1);
    raw_rpm = zeros(50*packet_size, 1);
    time = zeros(50*packet_size, 1);
    
    lh = addlistener(mydaq,'DataAvailable',@isr_get_new_data);
    mydaq.startBackground();  %start recording on DAQ
    load tacho 
    
    while enable_acquire && program_running
        fprintf('While loop: Scans acquired = %d\n', mydaq.ScansAcquired)
        smooth_torque = smoothdata(raw_torque,'movmean',100);
        smooth_thrust = smoothdata(raw_thrust,'movmean',900);
        f_plot_data([smooth_thrust smooth_torque],time,[2 2 1],[.15 .65 .35 .3])
        
        rpm = 4.7-raw_rpm;
        
        x = max(2,find(time,1,'last'));
        
        if x < 4000
            delta = x-1;
            y = mean(rpm(x-delta:x))
        else
            delta = 4000-1;
            y = mean(rpm(x-delta:x))
        end
        
        if y > min(rpm) + 0.1
            rpm_calc = rpm((x-delta):x);
            rpm_instantaneous = tachorpm(rpm_calc,sample_rate);
        else
            rpm_instantaneous = 0;
        end
        
        f_plot_data(rpm,time,[2 2 2],[.6 .65 .3 .3])        
       
        rpm_position = [.85 .7 .05 .02];
        rpm_label_position = [.82 .7 .02 .02];
        rpm_textbox = uicontrol('Style', 'text', 'Units', 'norm', 'Position', rpm_position);
        rpm_label = uicontrol('Style', 'text', 'Units', 'norm', 'Position', rpm_label_position);
        set(rpm_textbox, 'String', rpm_instantaneous,'BackgroundColor','w');
        set(rpm_label, 'String', 'RPM=','BackgroundColor','w');
        
        pause(.1)
        
    end   
    
    text = strcat('Input advance ratio');
    prompt = {text};
    title = 'Advance Ratio';
    dims = [1 30];
    definput = {''};
    advance_ratio = string(inputdlg(prompt,title,dims,definput));
    
    filename = strcat('C:\Users\rbcar\Documents\MIT\~Thesis\Data\',advance_ratio);
    data = [time raw_thrust raw_torque rpm];
    csvwrite(filename, data)
    
    delete(lh)
    
end

