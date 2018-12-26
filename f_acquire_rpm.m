function rpm = f_acquire_rpm(sample_rate)
    t=0:0.1:999*0.1;
    raw_rpm =  (sawtooth(t))';
    load tacho
    rpm = tachorpm(raw_rpm,sample_rate)
end
