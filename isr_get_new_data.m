funtion isr_get_new_data(src,event)

    global raw_thrust raw_torque raw_rpm time data_received ...
        program_running enable_acquire packet_size

    if program_running && enable_acquire

        array_size = length(time);  %change this to be 10*packetsize

        data_received = data_received + packet_size;
        
        if data_received >= array_size % only when out of space
            raw_thrust = vertcat(raw_thrust, zeros(10*packet_size, 1));
            raw_torque = vertcat(raw_torque, zeros(10*packet_size, 1));
            raw_rpm = vertcat(raw_rpm, zeros(10*packet_size, 1));
            time = vertcat(time, zeros(10*packet_size, 1));
        end

        raw_thrust(data_received+1:data_received+packet_size) = event.Data(:,1);
        raw_torque(data_received+1:data_received+packet_size) = event.Data(:,2);
        time(data_received+1:data_received+packet_size) = event.TimeStamps;
        raw_rpm(data_received+1:data_received+packet_size) = f_acquire_rpm();

    else
        src.stop()
    end

end