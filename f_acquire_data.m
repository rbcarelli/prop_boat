
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
        f_plot_data([raw_thrust raw_torque],time,[2 2 1])
        %f_plot_data(raw_rpm,sample_rate,time,[2 2 2])        
         pause(.1)
        
    end   
    
    delete(lh)
    
end

