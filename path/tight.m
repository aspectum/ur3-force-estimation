function ax = tight(ax)

    ax.PaperUnits = 'inches';
    ax.PaperPosition = [0 0 8 6];
    ax.PaperSize = [8 6];

    axx = ax.Children(2);
    outerpos = axx.OuterPosition;
    ti = axx.TightInset; 
    left = outerpos(1) + ti(1);
    bottom = outerpos(2) + ti(2);
    ax_width = outerpos(3) - ti(1) - ti(3);
    ax_height = outerpos(4) - ti(2) - ti(4);
    axx.Position = [left bottom ax_width ax_height];

end