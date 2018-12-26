funtion isr_get_new_data()
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
end