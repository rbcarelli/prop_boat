
function f_acquire_data()
    f_reset_plots()
      
    global enable_acquire raw_thrust raw_torque raw_rpm program_running...
    time mydaq packet_size sample_rate tq_axis rpm_axis
    
    raw_thrust = zeros(50*packet_size, 1);
    raw_torque = zeros(50*packet_size, 1);
    raw_rpm = zeros(50*packet_size, 1);
    time = zeros(50*packet_size, 1);
    
    lh = addlistener(mydaq,'DataAvailable',@isr_get_new_data);
    mydaq.startBackground();  %start recording on DAQ
    
    tq_axis = [-.8 .2];
    rpm_axis = [0 600];
    
    while enable_acquire && program_running
        fprintf('While loop: Scans acquired = %d\n', mydaq.ScansAcquired)
        smooth_torque = smoothdata(raw_torque,'movmean',400);
        smooth_thrust = smoothdata(raw_thrust,'movmean',10);
        f_plot_data([smooth_thrust smooth_torque],time,...
            ["2" "2" "[1 2]"],[.15 .65 .75 .3],tq_axis)
        
        
        x = find(time,1,'last');
        rpm_calc = rpm((x-sample_rate):x);
        rpm_voltage_diff = -diff(rpm_calc);
        upcross_count = rpm_voltage_diff>3;
        rpm_instantaneous=(sum(upcross_count)*60);

        
        rpm_position = [.85 .68 .05 .02];
        rpm_textbox = uicontrol('Style', 'text', 'Units', 'norm', 'Position', rpm_position);
        set(rpm_textbox, 'String', rpm_instantaneous,'BackgroundColor','w');
        
        pause(.1)
        
    end   
    
    text = strcat('Input advance ratio');
    prompt = {text};
    title = 'Advance Ratio';
    dims = [1 30];
    definput = {'1-24-f20-'};
    advance_ratio = string(inputdlg(prompt,title,dims,definput));
    
    filename = strcat('C:\Users\rbcar\Dropbox (MIT)\Prop Data\',advance_ratio,'.csv');
    data = [time raw_thrust raw_torque rpm];
    csvwrite(filename, data)
    
    delete(lh)
    
end

