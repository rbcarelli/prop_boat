function f_trim_data(~,~)
global raw_thrust raw_torque raw_rpm time

    [x,y] = ginput
    [~, idx1] = min(abs(time-x(1)))
    [~, idx2] = min(abs(time-x(2)))
    valuable_thrust = raw_thrust(idx1:idx2);
    valuable_torque = raw_torque(idx1:idx2);
    valuable_rpm = raw_rpm(idx1:idx2);
    valuable_time = time(idx1:idx2);
    f_plot_data([valuable_thrust valuable_torque],valuable_time,[2 2 3])
    f_plot_data([valuable_rpm],valuable_time,[2 2 4])
    mean_val = sum(valuable_thrust)/length(valuable_thrust)

end




