
function f_acquire_data()
    f_reset_plots()
  
    global enable_acquire raw_thrust raw_torque raw_rpm program_running...
    time daq sample_rate
    
    raw_thrust = zeros(10*packet_size, 1);
    raw_torque = zeros(10*packet_size, 1);
    raw_rpm = zeros(10*packet_size, 1);
    time = zeros(10*packet_size, 1);
     
    daq.startBackground();  %start recording on DAQ
    load tacho 
    
    while enable_acquire && program_running
        f_plot_data([raw_thrust raw_torque],time,[2 2 1])
        f_plot_data(tachorpm(raw_rpm,sample_rate),time,2 2 2])        
        pause(.5)
    end   
    
end

