function f_reset(~,~)
    global port
    fprintf(port,'port.WriteLine("reset")')
end