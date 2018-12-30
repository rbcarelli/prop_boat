function f_reset_plot()

subplot_location = [.15 .65 .35 .3;
                    .6 .65 .3 .3;
                    .15 .25 .35 .3;
                    .6 .25 .3 .3];
                    % L  B  W  H  
                    
    for i = 1:4
       figure(1)
       fig = subplot(2,2,i);
       set(fig, 'position',[subplot_location(i,1) subplot_location(i,2) ...
        subplot_location(i,3) subplot_location(i,4)]);
       plot(0)
    end

    
end