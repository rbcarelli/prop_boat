function isr_get_new_data(src,event)

    fprintf('ISR Called \n')
    
    global raw_thrust raw_torque raw_rpm time ...
        program_running enable_acquire packet_size mydaq

    if program_running && enable_acquire
        
        array_size = length(time);
        data_received = mydaq.ScansAcquired;
        
        if  data_received >= array_size % only when out of space
            raw_thrust = vertcat(raw_thrust, zeros(10*packet_size, 1));
            raw_torque = vertcat(raw_torque, zeros(10*packet_size, 1));
            raw_rpm = vertcat(raw_rpm, zeros(10*packet_size, 1));
            time = vertcat(time, zeros(10*packet_size, 1));
        end
        
        raw_thrust(data_received-packet_size+1:data_received) = event.Data(:,1);
        raw_torque(data_received-packet_size+1:data_received) = event.Data(:,2);
        time(data_received-packet_size+1:data_received) = event.TimeStamps;
        raw_rpm(data_received-packet_size+1:data_received) = event.Data(:,3);
                
    else
        fprintf('ISR Stopped')
        src.stop()
    end    
end
    