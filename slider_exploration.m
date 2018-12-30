zeta = .5;                           % Damping Ratio
wn = 2;                              % Natural Frequency
sys = tf(wn^2,[1,2*zeta*wn,wn^2]); 

f = figure;
ax = axes('Parent',f,'position',[0.13 0.39  0.77 0.54]);
h = stepplot(ax,sys);
setoptions(h,'XLim',[0,10],'YLim',[0,2]);

b = uicontrol('Parent',f,'Style','slider','Position',[81,54,419,23],...
              'value',zeta, 'min',0, 'max',1);
bgcolor = f.Color;
bl1 = uicontrol('Parent',f,'Style','text','Position',[50,54,23,23],...
                'String','0','BackgroundColor',bgcolor);
bl2 = uicontrol('Parent',f,'Style','text','Position',[500,54,23,23],...
                'String','1','BackgroundColor',bgcolor);
bl3 = uicontrol('Parent',f,'Style','text','Position',[240,25,100,23],...
                'String','Damping Ratio','BackgroundColor',bgcolor);

b.Callback = @(es,ed) updateSystem(h,tf(wn^2,[1,2*(es.Value)*wn,wn^2])); 


%%
FigH = figure('position',[360 500 400 400]);
axes('XLim', [0 4*pi], 'units','pixels', 'position',[100 50 200 200], 'NextPlot', 'add');
x     = linspace(0, 4*pi, 400);
y     = sin(x);
LineH = plot(x,y);
TextH = uicontrol('style','text','position',[170 340 40 15]);
SliderH = uicontrol('style','slider','position',[100 280 200 20],'min', 0, 'max', 4*pi);
addlistener(SliderH, 'Value', 'PostSet', @callbackfn);

movegui(FigH, 'center')
    function callbackfn(source, eventdata)
    num          = get(eventdata.AffectedObject, 'Value');
    LineH.YData  = sin(num * x);
    TextH.String = num2str(num);
    end
