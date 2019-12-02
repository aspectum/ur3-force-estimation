% load("../experiment/id1.mat");
load("../experiment/id2.mat");

g = figure();
plot(mt-4.06, mtorque, ftime-4.06, torques);
title('Torques medidos e calculados para trajetória de identificação')
ylabel('Torque (N.m)')
xlabel('Tempo (s)')
xlim([0 10]);
legend('M1', 'M2', 'M3', 'M4', 'M5', 'M6', 'C1', 'C2', 'C3', 'C4', 'C5', 'C6')

% colors = linspecer(6, 'qualitative');
colors = distinguishable_colors(6);
colors = normr(colors);

dark = 0.7 * colors;

poss = g.Children(2).Children;
poss(1).LineWidth = 1.5;
poss(1).Color = dark(1,:);
poss(1).LineStyle = '-';
poss(2).LineWidth = 1.5;
poss(2).Color = dark(2,:);
poss(2).LineStyle = '-';
poss(3).LineWidth = 1.5;
poss(3).Color = dark(3,:);
poss(3).LineStyle = '-';
poss(4).LineWidth = 1.5;
poss(4).Color = dark(4,:);
poss(4).LineStyle = '-';
poss(5).LineWidth = 1.5;
poss(5).Color = dark(5,:);
poss(5).LineStyle = '-';
poss(6).LineWidth = 1.5;
poss(6).Color = dark(6,:);
poss(6).LineStyle = '-';
poss(7).LineWidth = 1.5;
poss(7).Color = colors(1,:);
poss(7).LineStyle = ':';
poss(8).LineWidth = 1.5;
poss(8).Color = colors(2,:);
poss(8).LineStyle = ':';
poss(9).LineWidth = 1.5;
poss(9).Color = colors(3,:);
poss(9).LineStyle = ':';
poss(10).LineWidth = 1.5;
poss(10).Color = colors(4,:);
poss(10).LineStyle = ':';
poss(11).LineWidth = 1.5;
poss(11).Color = colors(5,:);
poss(11).LineStyle = ':';
poss(12).LineWidth = 1.5;
poss(12).Color = colors(6,:);
poss(12).LineStyle = ':';
g = tight(g);

saveas(g, '/home/pedro/tcc-tmp-master/my_ur3_model/Figures/torques_ident_2.png');