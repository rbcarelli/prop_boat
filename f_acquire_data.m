
function f_acquire_data()
    f_reset_plots()
    sample_rate = 100;                              %samples per second
    transfer_rate = 10                              %data transfer per second
    packet_size = sample_rate * transfer_rate;      %data points per transfer
    
    array_size = 5000;
    data_received = 0;
    raw_thrust = zeros(array_size, 1);
    raw_torque = zeros(array_size, 1);
    raw_rpm = zeros(array_size, 1);
    t_end = (array_size-1)/sample_rate;
    time = 0 : 1/sample_rate : t_end;
     
    global enable_acquire raw_thrust raw_torque raw_rpm program_running...
        time daq

    daq.startBackground();  %start recording on DAQ
    
    while enable_acquire && program_running
        daq.wait()  %wait until there are 2000 values
        new_thrust = 2-.2*randn(packet_size, 1);
        new_torque = 1+.2*randn(packet_size, 1);
        new_rpm = f_acquire_rpm(sample_rate);
        if data_received >= array_size % only when out of space
            raw_thrust = vertcat(raw_thrust, zeros(array_size, 1));
            raw_torque = vertcat(raw_torque, zeros(array_size, 1));
            raw_rpm = vertcat(raw_rpm, zeros(array_size, 1));
            array_size = array_size * 2;
            t_end = (array_size-1)/sample_rate;
            time = 0 : 1/sample_rate : t_end;
        end
        raw_thrust(data_received+1:data_received+packet_size) = new_thrust;
        raw_torque(data_received+1:data_received+packet_size) = new_torque;
        size(new_rpm)
        raw_rpm(data_received+1:data_received+packet_size) = new_rpm;
        data_received = data_received + packet_size;
            
        f_plot_data([raw_thrust raw_torque],time,t_end,[2 2 1])
        f_plot_data(raw_rpm,time,t_end,[2 2 2])        
        pause(.1)
    end   
       
end



