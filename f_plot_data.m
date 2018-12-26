function f_plot_data(data,time,subplot_parameters)
    figure(1)
    subplot(subplot_parameters(1),subplot_parameters(2),subplot_parameters(3))
    plot(time, data)
end
