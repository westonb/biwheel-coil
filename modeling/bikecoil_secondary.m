%load all the FEMM functions. the folder with all the M files for FEMM should have already been added to path 
openfemm;


function make_round_turn(x, y, radius, material, circuit)
	x1 = x - radius
	x2 = x + radius 
	y1 = y 
	y2 = y 

	mi_drawarc(x1, y1, x2, y2, 180, 10);
	mi_addarc(x2, y2, x1, y1, 180, 10);

	mi_addblocklabel(x,y);
	mi_selectlabel(x,y);
	%comment out first for automeshing
	mi_setblockprop(material, 1, 0, circuit, 0, 0, 1); 
	%mi_setblockprop(material, 0, 10E-3, circuit, 0, 0, 1);
	mi_clearselected

endfunction

function make_n_round_turns(radius, x_start, y_start, delta_y, n, material, circuit)

	for i = 0 : (n-1)
		y_val = y_start + i * delta_y;
		make_round_turn(x_start, y_val, radius, material, circuit);
	endfor 

endfunction 

% materials 
copper_conductivity = 58.0;

%currents 
i_primary = 1
i_secondary = 0;

%create new document 
% "0 for a magnetics problem, 1 for an electrostatics problem, 2 for a heat flow problem, or 3 for a current flow problem"
newdocument(0);

% Define the problem type.  Magnetostatic; Units of mm; Axisymmetric; 
% Precision of 10^(-8) for the linear solver; a placeholder of 0 for 
% the depth dimension, and an angle constraint of 30 degrees

%(freq,units,type,precision,depth,minangle,(acsolver))
mi_probdef(0, 'millimeters', 'axi', 1.e-8, 0, 30, 0);

%define materials and circuits 

mi_addmaterial('Air', 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0);
mi_addmaterial('Copper', 1, 1, 0, 0, copper_conductivity, 0, 0, 1, 0, 0, 0);
mi_addmaterial('Al', 1, 1, 0, 0, copper_conductivity*0.6, 0, 0, 1, 0, 0, 0);
ferrite_mu = 220.0;
mi_addmaterial('Ferrite', ferrite_mu, ferrite_mu, 0, 0, 0, 0, 0, 1, 0, 0, 0);


mi_addcircprop('ipri', i_primary, 1);
mi_addcircprop('isec', i_secondary, 1);

%air 
mi_addblocklabel(0, -20);
mi_selectlabel(0,-20);
% (’blockname’, automesh, meshsize, ’incircuit’, magdir, group, turns) 
mi_setblockprop('Air', 1, 0, '<None>', 0, 0, 0);
mi_clearselected

%ferrite block
mi_drawpolygon([0,0; 60,0; 60,0.2;, 0,0.2]);
mi_addblocklabel(10, 0.1);
mi_selectlabel(10,0.1);
mi_setblockprop('Ferrite', 1, 0, '<None>', 0, 0, 0);
mi_clearselected


% primary 
make_n_round_turns(1.3/2,145/2, 50, 6.5, 16, 'Copper', 'ipri');


% new secondary is 10in tall, 9in wound 
%make_n_round_turns(0.32/2,39.4,50, 0.37, 618, 'Copper', 'isec');  %28 AWG
%make_n_round_turns(0.404/2,39.4,50, 0.453, 504, 'Copper', 'isec'); %26 AWG
make_n_round_turns(0.361/2,39.4,50, 0.401, 570, 'Copper', 'isec');  %28 AWG




% topload 
topload_height = 40 + 50 + 570*0.401;
topload_thickness = 1;
topload_major = 165/2;
topload_minor = 65/2;




mi_drawline(0, topload_height- topload_thickness , topload_major - topload_minor, topload_height- topload_thickness);
mi_drawline(0, topload_height + topload_thickness , topload_major - topload_minor, topload_height + topload_thickness);
mi_addsegment(0, topload_height- topload_thickness, 0, topload_height + topload_thickness);
mi_addnode(topload_major + topload_minor, topload_height);
mi_addarc(topload_major - topload_minor, topload_height- topload_thickness, topload_major + topload_minor, topload_height, 180, 10);
mi_addarc(topload_major + topload_minor, topload_height,  topload_major - topload_minor, topload_height + topload_thickness, 180, 10);

mi_drawarc(topload_minor + topload_major - topload_thickness, topload_height, topload_major - topload_minor + topload_thickness, topload_height, 180, 10);

mi_addarc(topload_major - topload_minor + topload_thickness, topload_height,  topload_major + topload_minor- topload_thickness, topload_height, 180, 10);

mi_addblocklabel(5, topload_height);
mi_selectlabel(5, topload_height);
mi_setblockprop("Al", 1, 0, '<None>', 0, 0, 0);
mi_clearselected;

mi_addblocklabel(topload_major, topload_height);
mi_selectlabel(topload_major, topload_height);
mi_setblockprop('Air', 1, 0, '<None>', 0, 0, 0);
mi_clearselected;



mi_saveas('teslacoilv2.fem');
