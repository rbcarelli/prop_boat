
function f_acquire_data()
    f_reset_plots()
      
    global enable_acquire raw_thrust raw_torque raw_rpm program_running...
    time mydaq packet_size sample_rate tq_axis rpm_axis read_rpm
    
    raw_thrust = zeros(50*packet_size, 1);
    raw_torque = zeros(50*packet_size, 1);
    raw_rpm = zeros(50*packet_size, 1);
    time = zeros(50*packet_size, 1);
    
    lh = addlistener(mydaq,'DataAvailable',@isr_get_new_data);
    mydaq.startBackground();  %start recording on DAQ
    load tacho 
    
    tq_axis = [-10 10];
    rpm_axis = [0 600];
    
    while enable_acquire && program_running
        fprintf('While loop: Scans acquired = %d\n', mydaq.ScansAcquired)
        smooth_torque = smoothdata(raw_torque,'movmean',100);
        smooth_thrust = smoothdata(raw_thrust,'movmean',900);
        f_plot_data([smooth_thrust smooth_torque],time,...
            ["2" "2" "[1 2]"],[.15 .65 .75 .3],tq_axis)
        
        rpm = 4.7-raw_rpm;
        
        if read_rpm
            rpm_instantaneous = 1;
%             x = max(2,find(time,1,'last'));
%             delta = 4000-1;
%             rpm_calc = rpm((x-delta):x);
%             rpm_instantaneous = tachorpm(rpm_calc,sample_rate);
        else
            rpm_instantaneous = 0;
        end

        
        rpm_position = [.85 .68 .05 .02];
        rpm_textbox = uicontrol('Style', 'text', 'Units', 'norm', 'Position', rpm_position);
        set(rpm_textbox, 'String', rpm_instantaneous,'BackgroundColor','w');
        
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

