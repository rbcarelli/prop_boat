function f_plot_data(data,time,t_end,subplot_parameters)
    figure(1)
    subplot(subplot_parameters(1),subplot_parameters(2),subplot_parameters(3))
    plot(time, data)
    if t_end
        xlim([0 t_end])
    end
end
