function f_plot_data(data,time,subplot_parameters,subplot_location,axis)
    
    figure(1)

    fig = subplot(str2num(subplot_parameters(1)),...
        str2num(subplot_parameters(2)),...
        str2num(subplot_parameters(3)));
    set(fig, 'position',[subplot_location(1) subplot_location(2) ...
        subplot_location(3) subplot_location(4)]);
    plot(time, data)
    ylim(axis)
end
