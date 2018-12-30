function f_plot_data(data,time,subplot_parameters,subplot_location)
    
    figure(1)

    fig = subplot(subplot_parameters(1),subplot_parameters(2),...
        subplot_parameters(3));
    set(fig, 'position',[subplot_location(1) subplot_location(2) ...
        subplot_location(3) subplot_location(4)]);
    plot(time, data)
    
end
